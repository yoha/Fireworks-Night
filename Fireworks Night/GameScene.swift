//
//  GameScene.swift
//  Fireworks Night
//
//  Created by Yohannes Wijaya on 9/29/15.
//  Copyright (c) 2015 Yohannes Wijaya. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // MARK: - Stored Properties
    
    var gameTimer: NSTimer!
    var fireworkNodeArray = [SKNode]()
    
    var leftEdge = -22
    var rightEdge = 1024 + 22
    var bottomEdge = -22
    
    // MARK: Property Observers
    
    var score: Int = 0 {
        didSet {
            
        }
    }
    
    // MARK: - Methods Override
    
    override func didMoveToView(view: SKView) {
        let backgroundSpriteNode = SKSpriteNode(imageNamed: "background")
        backgroundSpriteNode.position = CGPoint(x: 512, y: 384)
        backgroundSpriteNode.blendMode = .Replace
        backgroundSpriteNode.zPosition = -1
        self.addChild(backgroundSpriteNode)
        
        self.gameTimer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: "launchFireworks", userInfo: nil, repeats: true)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    // MARK: - Local Methods
    
    func createFirework(xMovement xMovement: CGFloat, x: Int, y: Int) {
        let containerNode = SKNode()
        containerNode.position = CGPoint(x: x, y: y)
        
        let fireworkSpriteNode = SKSpriteNode(imageNamed: "rocket")
        fireworkSpriteNode.name = "firework"
        containerNode.addChild(fireworkSpriteNode)
        
        switch GKRandomSource.sharedRandom().nextIntWithUpperBound(3) {
        case 0:
            fireworkSpriteNode.color = UIColor.cyanColor()
            fireworkSpriteNode.colorBlendFactor = 1
        case 1:
            fireworkSpriteNode.color = UIColor.greenColor()
            fireworkSpriteNode.colorBlendFactor = 1
        case 2:
            fireworkSpriteNode.color = UIColor.redColor()
            fireworkSpriteNode.colorBlendFactor = 1
        default:
            break
        }
        
        let fireworkMovementPath = UIBezierPath()
        fireworkMovementPath.moveToPoint(CGPoint(x: 0, y: 0))
        fireworkMovementPath.addLineToPoint(CGPoint(x: xMovement, y: 1000))
        
        // Tell the container node to follow that bezier path, turning itself as needed.
        let followBezierPath = SKAction.followPath(fireworkMovementPath.CGPath, asOffset: true, orientToPath: true, speed: 200.0)
        containerNode.runAction(followBezierPath)
        
        // Create particles behind the firework that make it looks like it's lit.
        let emitter = SKEmitterNode(fileNamed: "fuse.sks")
        emitter!.position = CGPoint(x: 0, y: -22)
        containerNode.addChild(emitter!)
        
        self.fireworkNodeArray.append(containerNode)
        self.addChild(containerNode)
    }
    
    func launchFireworks() {
        let movementAmount: CGFloat = 1800.0
        
        switch GKRandomSource.sharedRandom().nextIntWithUpperBound(4) {
        case 0:
            // fire 5 straight up
            self.createFirework(xMovement: 0, x: 512, y: self.bottomEdge)
            self.createFirework(xMovement: 0, x: 512 - 200, y: self.bottomEdge)
            self.createFirework(xMovement: 0, x: 512 - 100, y: self.bottomEdge)
            self.createFirework(xMovement: 0, x: 512 + 100, y: self.bottomEdge)
            self.createFirework(xMovement: 0, x: 512 + 200, y: self.bottomEdge)
        case 1:
            // fire 5 in a fan fashion
            self.createFirework(xMovement: 0, x: 512, y: self.bottomEdge)
            self.createFirework(xMovement: -200, x: 512 - 200, y: self.bottomEdge)
            self.createFirework(xMovement: -100, x: 512 - 100, y: self.bottomEdge)
            self.createFirework(xMovement: 100, x: 512 + 100, y: self.bottomEdge)
            self.createFirework(xMovement: 200, x: 512 + 200, y: self.bottomEdge)
        case 2:
            // fire 5 from left to the right
            self.createFirework(xMovement: movementAmount, x: self.leftEdge, y: self.bottomEdge + 400)
            self.createFirework(xMovement: movementAmount, x: self.leftEdge, y: self.bottomEdge + 300)
            self.createFirework(xMovement: movementAmount, x: self.leftEdge, y: self.bottomEdge + 200)
            self.createFirework(xMovement: movementAmount, x: self.leftEdge, y: self.bottomEdge + 100)
            self.createFirework(xMovement: movementAmount, x: self.leftEdge, y: self.bottomEdge)
        case 3:
            // fire 5 from right to the left
            self.createFirework(xMovement: -movementAmount, x: self.rightEdge, y: self.bottomEdge + 400)
            self.createFirework(xMovement: -movementAmount, x: self.rightEdge, y: self.bottomEdge + 300)
            self.createFirework(xMovement: -movementAmount, x: self.rightEdge, y: self.bottomEdge + 200)
            self.createFirework(xMovement: -movementAmount, x: self.rightEdge, y: self.bottomEdge + 100)
            self.createFirework(xMovement: -movementAmount, x: self.rightEdge, y: self.bottomEdge)
        default:
            break
        }
    }
}
