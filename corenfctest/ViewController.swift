//
//  ViewController.swift
//  corenfctest
//
//  Created by 崔 佑宗 on 2017/06/18.
//  Copyright © 2017年 崔 佑宗. All rights reserved.
//

import UIKit
import CoreNFC

class ViewController: UIViewController, NFCNDEFReaderSessionDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func startScan(_ sender: Any) {
        let session:NFCNDEFReaderSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        session.begin()
        print("Session Start") //comment
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages{
            for payload in message.records {
                
                if let payloadstr = String(data: payload.payload, encoding: .ascii) { // get payload data for String
                    print(payloadstr)
                }
                if let identifier: String = String(data: payload.identifier, encoding: .ascii) {
                    print(identifier)
                }
                if let type: String = String(data: payload.type, encoding: .ascii) {
                    print(type)
                }
            }
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        if let readerError = error as? NFCReaderError {
            if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                let alertController = UIAlertController(title: "Session Invalidated", message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }}

