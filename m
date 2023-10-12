Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C347C6C32
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377894AbjJLLYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343649AbjJLLYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:24:05 -0400
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4336D90;
        Thu, 12 Oct 2023 04:24:00 -0700 (PDT)
X-QQ-mid: bizesmtp85t1697109739t1lnnidg
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 12 Oct 2023 19:22:18 +0800 (CST)
X-QQ-SSF: 01400000000000F0F000000A0000000
X-QQ-FEAT: CR3LFp2JE4ltdTud+4AYKJcdUD+uXs6VvqjLXfu+SzUIUtAKlVb/Hy1fQTboe
        yEa6+SWXN8euKCoBBuoM0FGQ6NBCTFzkq8ZMMR73I9t+gfwhvrNth6EVU/jSIjdcv4I5p3S
        Dli5iTHPbmirkl+6cMaofPb/mNxeQc5K6b2tD/uBgux3umFb1Z8LJaMH6PfZYW56/6dBob9
        I04ni6lNKaSeDlE/6Dojo9ZIzoqMM56NjMCJmRbsRXNNWxeVLO+Z64UrSZtbUQbk/QOnw3R
        U/i5e4wIx/u269qu8G7iOQpiF6biZdIyVo3e+Meo7Vs1CdFhWpcn+18DTOU/27roKQtgyZn
        AN2MwLgrixegFsbeCnBYrQxUZdlXtTCXSj5bqAxw4SsMJWP/Fl+lt2jqlo5/57S2sbNP3km
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14250982440802780419
From:   Guan Wentao <guanwentao@uniontech.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        guanwentao@uniontech.com, stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add 0bda:b85b for Fn-Link RTL8852BE
Date:   Thu, 12 Oct 2023 19:21:17 +0800
Message-Id: <20231012112118.11431-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PID/VID 0bda:b85b for Realtek RTL8852BE USB bluetooth part.
The PID/VID was reported by the patch last year. [1]
Some SBCs like rockpi 5B A8 module contains the device.
And it`s founded in website. [2] [3]

Here is the device tables in /sys/kernel/debug/usb/devices .

T:  Bus=07 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=b85b Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00e04c000001
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Link: https://lore.kernel.org/all/20220420052402.19049-1-tangmeng@uniontech.com/ [1]
Link: https://forum.radxa.com/t/bluetooth-on-ubuntu/13051/4 [2]
Link: https://ubuntuforums.org/showthread.php?t=2489527 [3]

Cc: stable@vger.kernel.org
Signed-off-by: Meng Tang <tangmeng@uniontech.com>
Signed-off-by: Guan Wentao <guanwentao@uniontech.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3fdad35e5..894938d2b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -544,6 +544,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0bda, 0x887b), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0bda, 0xb85b), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3570), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3571), .driver_info = BTUSB_REALTEK |
-- 
2.20.1

