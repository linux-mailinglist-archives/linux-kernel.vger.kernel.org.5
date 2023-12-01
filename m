Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540F380016E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 03:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376610AbjLACKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 21:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjLACKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 21:10:08 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E723E13E;
        Thu, 30 Nov 2023 18:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=oV3Mw
        Nn4l5UCMKMMhFzmpSsC7lPc9xb/Zeakfk8Rxt0=; b=e1pbDTVgLfrEgOXK4q1/Q
        dYST1gBg8DFIXD2JXD+5wdAfcd/rIvg8JBDIkLW52d6unS64w39Mt2nuJEN6aQBl
        AX9pmgAaVrfCETHxRinDdA6LPqT64rjzdk6QXp8ftptLy/E3v0zI+Do775EC/Y92
        2j1lTuRkU7mDMO7nPmDEC8=
Received: from test.web.setting (unknown [223.160.225.51])
        by zwqz-smtp-mta-g4-3 (Coremail) with SMTP id _____wD3P3BxQGllZQIzCg--.56146S2;
        Fri, 01 Dec 2023 10:09:55 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        johan@kernel.org
Cc:     slark_xiao@163.com
Subject: [PATCH] USB: serial: option: add Foxconn T99W265 with new baseline
Date:   Fri,  1 Dec 2023 10:09:50 +0800
Message-Id: <20231201020950.34770-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3P3BxQGllZQIzCg--.56146S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFy5Jr13Ww15ur4DJw1UJrb_yoW8Aw18pF
        n0yry3ZrZ5XayrWFy0yr4rAF95Wan5K343KasrAw1aqFyfArsrt34xtryFqF1S9rs3KrnF
        vr4DGw4UK3WrArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUjfOrUUUUU=
X-Originating-IP: [223.160.225.51]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiMBk5ZFWB2UXL8QAAsG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ID was added based on latest SDX12 code base line, and we
made some changes with previous 0489:e0db.

Test evidence as below:
T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=5000 MxCh= 0
D:  Ver= 3.20 Cls=ef(misc ) Sub=02 Prot=01 MxPS= 9 #Cfgs=  2
P:  Vendor=0489 ProdID=e0da Rev=05.04
S:  Manufacturer=Qualcomm
S:  Product=Qualcomm Snapdragon X12
S:  SerialNumber=2bda65fb
C:  #Ifs= 6 Cfg#= 2 Atr=a0 MxPwr=896mA
I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
I:  If#=0x1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
I:  If#=0x3 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I:  If#=0x4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
I:  If#=0x5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)

0&1: MBIM, 2: Modem, 3:GNSS, 4:Diag, 5:ADB

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 4dffcfefd62d..b46ffe9c8d0d 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2242,6 +2242,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
 	{ USB_DEVICE(0x0489, 0xe0b5),						/* Foxconn T77W968 ESIM */
 	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0da, 0xff),                     /* Foxconn T99W265 MBIM variant */
+	  .driver_info = RSVD(3) | RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0db, 0xff),			/* Foxconn T99W265 MBIM */
 	  .driver_info = RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0ee, 0xff),			/* Foxconn T99W368 MBIM */
-- 
2.34.1

