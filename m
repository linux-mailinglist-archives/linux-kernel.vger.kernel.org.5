Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097AB77DD73
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243414AbjHPJjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240373AbjHPJiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:38:54 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A478213E;
        Wed, 16 Aug 2023 02:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Byefe
        1fj5C0m8WcjSH24Gccaa0QbjE0NaEHY/Q/2LzY=; b=N8MmdakF921D0mdgVy/ix
        ypGI5SaKP6qP+8YKNosx/n/yWRF7cG6lZaqvT2pzazUePuVuh40g03mDUzqpSOaT
        JalGh2YRwLIBvJEe1Y7wV7T71sxkOvERqKMFe67lzho6N1n6XpEqs+C0lDasQyhs
        8BZfi3bJRByYRYtbYUYrCI=
Received: from localhost.localdomain (unknown [223.104.66.110])
        by zwqz-smtp-mta-g5-0 (Coremail) with SMTP id _____wDHVEH+mNxk8uPfDA--.57409S2;
        Wed, 16 Aug 2023 17:38:07 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] USB: serial: option: add FOXCONN vendor and T99W368/T99W373  product
Date:   Wed, 16 Aug 2023 17:37:55 +0800
Message-Id: <20230816093755.7059-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHVEH+mNxk8uPfDA--.57409S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4rJr4rXry5Cr47WrW5GFg_yoWrWFWkpF
        y5CF4avrWDWw4rGF93trs5Ca95uan5Kry3CasrAw43uFyfAw4Dt348trWxXF9FgrsYqrsF
        vrWDG3y7Ka4DJrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUjfOrUUUUU=
X-Originating-IP: [223.104.66.110]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBDRPNZFaEQCWxiAAAs5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the increase of the number of Foxconn devices, we add
a vendor name for Foxconn. The difference of T99W368 and
T99W373 is the chip solution. T99W368 is designed based
on Qualcomm SDX65 and T99W373 is SDX62.

Test evidence as below:
T:  Bus=01 Lev=02 Prnt=05 Port=00 Cnt=01 Dev#=  7 Spd=480 MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e0f0 Rev=05.04
S:  Manufacturer=FII
S:  Product=OLYMPIC USB WWAN Adapter
S:  SerialNumber=78ada8c4
C:  #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=500mA
I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
I:  If#=0x1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
I:  If#=0x3 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I:  If#=0x4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
I:  If#=0x5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option

T:  Bus=01 Lev=02 Prnt=05 Port=00 Cnt=01 Dev#=  8 Spd=480 MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e0ee Rev=05.04
S:  Manufacturer=FII
S:  Product=OLYMPIC USB WWAN Adapter
S:  SerialNumber=78ada8d5
C:  #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=500mA
I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
I:  If#=0x1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
I:  If#=0x3 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I:  If#=0x4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
I:  If#=0x5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option

Both of them share the same port configuration:
0&1: MBIM, 2: Modem, 3:GNSS, 4:NMEA, 5:Diag
GNSS port don't use serial driver.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/usb/serial/option.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 8ac98e60fff5..405eba83640d 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -606,6 +606,14 @@ static void option_instat_callback(struct urb *urb);
 /* TOZED LT70-C based on UNISOC SL8563 uses UNISOC's vendor ID */
 #define TOZED_PRODUCT_LT70C			0x4055
 
+/* Foxconn products */
+#define FOXCONN_VENDOR_ID			0x0489
+#define FOXCONN_PRODUCT_T77W968		0xe0b4
+#define FOXCONN_PRODUCT_T77W968_ESIM		0xe0b5
+#define FOXCONN_PRODUCT_T99W265		0xe0db
+#define FOXCONN_PRODUCT_T99W368		0xe0ee
+#define FOXCONN_PRODUCT_T99W373		0xe0f0
+
 /* Device flags */
 
 /* Highest interface number which can be used with NCTRL() and RSVD() */
@@ -2226,11 +2234,15 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0xa31d, 0xff, 0x06, 0x13) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0xa31d, 0xff, 0x06, 0x14) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0xa31d, 0xff, 0x06, 0x1b) },
-	{ USB_DEVICE(0x0489, 0xe0b4),						/* Foxconn T77W968 */
+	{ USB_DEVICE(FOXCONN_VENDOR_ID, FOXCONN_PRODUCT_T77W968),					/* Foxconn T77W968 */
 	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
-	{ USB_DEVICE(0x0489, 0xe0b5),						/* Foxconn T77W968 ESIM */
+	{ USB_DEVICE(FOXCONN_VENDOR_ID, FOXCONN_PRODUCT_T77W968_ESIM),				/* Foxconn T77W968 ESIM */
 	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
-	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0db, 0xff),			/* Foxconn T99W265 MBIM */
+	{ USB_DEVICE_INTERFACE_CLASS(FOXCONN_VENDOR_ID, FOXCONN_PRODUCT_T99W265, 0xff),		/* Foxconn T99W265 MBIM */
+	  .driver_info = RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(FOXCONN_VENDOR_ID, FOXCONN_PRODUCT_T99W368, 0xff),		/* Foxconn T99W368 MBIM */
+	  .driver_info = RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(FOXCONN_VENDOR_ID, FOXCONN_PRODUCT_T99W373, 0xff),		/* Foxconn T99W373 MBIM */
 	  .driver_info = RSVD(3) },
 	{ USB_DEVICE(0x1508, 0x1001),						/* Fibocom NL668 (IOT version) */
 	  .driver_info = RSVD(4) | RSVD(5) | RSVD(6) },
-- 
2.25.1

