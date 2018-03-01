//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 押火太世 on 2018/02/28.
//  Copyright © 2018年 taisei.oshibi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var playstop: UIButton!
    
    @IBOutlet weak var go: UIButton!
    
    @IBOutlet weak var back: UIButton!
    
    let image = ["画像①.jpg", "画像②.jpg", "画像③.jpg"]

    var timer: Timer!
    
    var index = 1
    
    @IBAction func onTapImage(_ sender: Any) {
         performSegue(withIdentifier: "result", sender: nil)
    
        if self.timer != nil {
        self.timer.invalidate()
        self.timer = nil
            
             //表示を復活
            go.isEnabled = true
            back.isEnabled = true
            
            // ボタンの名前を変更
            playstop.setTitle("再生", for: .normal)
            
        }
        
    }

        var dispImageNo = 0
    
    func displayImage() {
        
        // 画像の名前の配列
        let imageNameArray = [
            "画像①.jpg",
            "画像②.jpg",
            "画像③.jpg",
            ]
        
        if dispImageNo < 0 {
            dispImageNo = 2
        }
        
        // 範囲より上を指している場合、最初の画像を表示
        if dispImageNo > 2 {
            dispImageNo = 0
        }
        
        let name = imageNameArray[dispImageNo]
        
        // 画像を読み込み
        let image = UIImage(named: name)
        
        // Image Viewに読み込んだ画像をセット
        ImageView.image = image
    
}
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 画像を読み込み
        let image = UIImage(named: "画像①.jpg")
        
        // Image Viewに読み込んだ画像をセット
        ImageView.image = image
        
    }
    
    /// NSTimerによって、一定の間隔で呼び出される関数
    @objc func onTimer(timer: Timer) {
        
        // 表示している画像の番号を1増やす
        dispImageNo += 1
        
        // 表示している画像の番号を元に画像を表示する
        displayImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func playstop(_ sender: Any) {
         if self.timer == nil {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)
            
            //表示を隠す
            go.isEnabled = false
            back.isEnabled = false
            
            // ボタンの名前を変更
            playstop.setTitle("停止", for: .normal)
            
        }
        
        else{
            self.timer.invalidate()
            self.timer = nil
            
            //表示を復活
            go.isEnabled = true
            back.isEnabled = true
            
            // ボタンの名前を変更
            playstop.setTitle("再生", for: .normal)
            
    }
        
    }
    @IBAction func go(_ sender: Any) {
        
        // 表示している画像の番号を1増やす
        dispImageNo += 1
        
        // 表示している画像の番号を元に画像を表示する
        displayImage()
        
    }
    
    @IBAction func back(_ sender: Any) {
        
        // 表示している画像の番号を1減らす
        dispImageNo -= 1
        
        // 表示している画像の番号を元に画像を表示する
        displayImage()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let resultViewController = segue.destination as! resultViewController
        resultViewController.image = UIImage(named: self.image[dispImageNo])!
            }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
    
}
