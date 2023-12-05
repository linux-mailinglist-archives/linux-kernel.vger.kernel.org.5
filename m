Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E548D806006
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346394AbjLEVCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLEVCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:02:41 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E68B188;
        Tue,  5 Dec 2023 13:02:47 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54c79968ffbso4491534a12.3;
        Tue, 05 Dec 2023 13:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701810166; x=1702414966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x74SPMcY0OIkNHNYKVP8zxIa11SKy/rAVbNbtzbNtj4=;
        b=YSYmIgJQFm8WVfJNnAu/BP/5dxy3jM1T5ZNttRmYT71/aIP4z/4zHWILfCe2PMfIGU
         Z+xO3JeEBnHUSxa4kTFLPjcvcOnGlwseETZ6W+B1Jn6vfgwZUfbtV6ipOycJGccSZcHY
         R2Q0/60YA8xx8d2uZ2dKaF0l0X3wKM6uq48GDjpLWslVCXRnoRmFTxCvPnCmY55j2CIZ
         mWEMtaSROUpEEI3Bvhvt80TPDBrMJ764TSErtPfk2x/DxyQS6KoUCeXaDSpCkcrlSvJa
         9jLPPCh4/0HweJS4mn8esaniMY/OzfDABmekF8E/4jTBt2AcR5gTVkIBCfgeQw2ErCuY
         38gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701810166; x=1702414966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x74SPMcY0OIkNHNYKVP8zxIa11SKy/rAVbNbtzbNtj4=;
        b=eS0TDeQIA/UT5QoTkT2Y/ZSX4OPqhnKlfxGuY40MvGXQU/y4srEZv5lRiThAAkWoo8
         ynbFo5njPvnYe6yVf6HAci+PM/LbSWDyWdgdxtGutnev/x/p+ia2fGn1Vv/6mwk/f03L
         0TslqqLjEATD1jQjTTqmgpr4ByF+2yot8ouXJfaS9XGjEiqoJYtMGEINa3n3ImzrNXr5
         oMokcbk3K1YnNj+jdLpoCMvvPfIwYhqQ0rhwPuabzqVoa8DuYijv/J973gmC4DPvzNtb
         aaX/XgH/35PDIc6dVdsMgpH9gO8lkRaFfrIobuC9WwPwiGjSijUU7Kwj18IXXZxYKEMx
         wnUw==
X-Gm-Message-State: AOJu0Ywv715e/2bLn8WLHoUmkpazFxwWSNXyaVL+mkOEmQZKJ7Oa05l5
        UjoA5WMQW8zTHj+YjxiqiQ==
X-Google-Smtp-Source: AGHT+IG5JtxIrogBnXD/l1CGXaxKHhGDtxgkWosjh9HL/9HZZJhkIHXQQIJ/lKfBp8Yigv9Jot5ZjA==
X-Received: by 2002:aa7:dad5:0:b0:54c:c1e4:3d3 with SMTP id x21-20020aa7dad5000000b0054cc1e403d3mr2465047eds.33.1701810165848;
        Tue, 05 Dec 2023 13:02:45 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:d9b0:71c0:990:192e])
        by smtp.gmail.com with ESMTPSA id i21-20020a50fc15000000b0054ca3df2257sm1552836edr.36.2023.12.05.13.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 13:02:45 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Amitkumar Karwar <akarwar@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH] wifi: mwifiex: Restore USB8897 chipset support
Date:   Tue,  5 Dec 2023 22:02:37 +0100
Message-ID: <20231205210237.209332-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch restores USB8897 support which was removed with
Commit 60a188a2715f ("mwifiex: remove USB8897 chipset support")

There are quite some devices which use this chipset with USB interface.
The firmware still exits in linux upstream firmware repo and this simple
patch is all what is required to support it in upstream linux (again).

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
Recently I upstreamed support for Geniatec XPI-3128 SBC which actually
has one any of those boards soldered to the onboard USB Host controller.
Geniatech has some boards [0], [1], [2] (maybe more) which have this
variant soldered the same way. (optional)
I've also read that "Xbox Wireless adapter for Windows" uses this chipset
(unverified).
I've also CC'ed Ganapathi Bhat who last updated the firmware for SDIO and
PCIe variant of this chipset: It would be great if the firmware
for USB variant could get an update too, as the one which we currently
have is quite old - version 15.68.4.p103, while other have some 16.*
firmware. 

[0] https://www.geniatech.com/product/xpi-3288/
[1] https://www.geniatech.com/product/xpi-imx8mm/
[2] https://www.geniatech.com/product/xpi-s905x/
 
 drivers/net/wireless/marvell/mwifiex/Kconfig |  4 ++--
 drivers/net/wireless/marvell/mwifiex/usb.c   | 14 ++++++++++++++
 drivers/net/wireless/marvell/mwifiex/usb.h   |  3 +++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/Kconfig b/drivers/net/wireless/marvell/mwifiex/Kconfig
index b182f7155d66..277b75eaf91e 100644
--- a/drivers/net/wireless/marvell/mwifiex/Kconfig
+++ b/drivers/net/wireless/marvell/mwifiex/Kconfig
@@ -35,12 +35,12 @@ config MWIFIEX_PCIE
 	  mwifiex_pcie.
 
 config MWIFIEX_USB
-	tristate "Marvell WiFi-Ex Driver for USB8766/8797/8997"
+	tristate "Marvell WiFi-Ex Driver for USB8766/8797/8897/8997"
 	depends on MWIFIEX && USB
 	select FW_LOADER
 	help
 	  This adds support for wireless adapters based on Marvell
-	  8797/8997 chipset with USB interface.
+	  8797/8897/8997 chipset with USB interface.
 
 	  If you choose to build it as a module, it will be called
 	  mwifiex_usb.
diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
index d3ab9572e711..061be9c2ed2f 100644
--- a/drivers/net/wireless/marvell/mwifiex/usb.c
+++ b/drivers/net/wireless/marvell/mwifiex/usb.c
@@ -28,6 +28,11 @@ static const struct usb_device_id mwifiex_usb_table[] = {
 	{USB_DEVICE_AND_INTERFACE_INFO(USB8XXX_VID, USB8801_PID_2,
 				       USB_CLASS_VENDOR_SPEC,
 				       USB_SUBCLASS_VENDOR_SPEC, 0xff)},
+	/* 8897 */
+	{USB_DEVICE(USB8XXX_VID, USB8897_PID_1)},
+	{USB_DEVICE_AND_INTERFACE_INFO(USB8XXX_VID, USB8897_PID_2,
+				       USB_CLASS_VENDOR_SPEC,
+				       USB_SUBCLASS_VENDOR_SPEC, 0xff)},
 	/* 8997 */
 	{USB_DEVICE(USB8XXX_VID, USB8997_PID_1)},
 	{USB_DEVICE_AND_INTERFACE_INFO(USB8XXX_VID, USB8997_PID_2,
@@ -409,12 +414,14 @@ static int mwifiex_usb_probe(struct usb_interface *intf,
 	case USB8766_PID_1:
 	case USB8797_PID_1:
 	case USB8801_PID_1:
+	case USB8897_PID_1:
 	case USB8997_PID_1:
 		card->usb_boot_state = USB8XXX_FW_DNLD;
 		break;
 	case USB8766_PID_2:
 	case USB8797_PID_2:
 	case USB8801_PID_2:
+	case USB8897_PID_2:
 	case USB8997_PID_2:
 		card->usb_boot_state = USB8XXX_FW_READY;
 		break;
@@ -1318,6 +1325,12 @@ static int mwifiex_register_dev(struct mwifiex_adapter *adapter)
 		strcpy(adapter->fw_name, USB8997_DEFAULT_FW_NAME);
 		adapter->ext_scan = true;
 		break;
+	case USB8897_PID_1:
+	case USB8897_PID_2:
+		adapter->tx_buf_size = MWIFIEX_TX_DATA_BUF_SIZE_4K;
+		strcpy(adapter->fw_name, USB8897_DEFAULT_FW_NAME);
+		adapter->ext_scan = true;
+		break;
 	case USB8766_PID_1:
 	case USB8766_PID_2:
 		adapter->tx_buf_size = MWIFIEX_TX_DATA_BUF_SIZE_2K;
@@ -1615,4 +1628,5 @@ MODULE_LICENSE("GPL v2");
 MODULE_FIRMWARE(USB8766_DEFAULT_FW_NAME);
 MODULE_FIRMWARE(USB8797_DEFAULT_FW_NAME);
 MODULE_FIRMWARE(USB8801_DEFAULT_FW_NAME);
+MODULE_FIRMWARE(USB8897_DEFAULT_FW_NAME);
 MODULE_FIRMWARE(USB8997_DEFAULT_FW_NAME);
diff --git a/drivers/net/wireless/marvell/mwifiex/usb.h b/drivers/net/wireless/marvell/mwifiex/usb.h
index 7e920b51994c..b7dba256e9f8 100644
--- a/drivers/net/wireless/marvell/mwifiex/usb.h
+++ b/drivers/net/wireless/marvell/mwifiex/usb.h
@@ -19,6 +19,8 @@
 #define USB8797_PID_2		0x2044
 #define USB8801_PID_1		0x2049
 #define USB8801_PID_2		0x204a
+#define USB8897_PID_1		0x2045
+#define USB8897_PID_2		0x2046
 #define USB8997_PID_1		0x2052
 #define USB8997_PID_2		0x204e
 
@@ -35,6 +37,7 @@
 #define USB8766_DEFAULT_FW_NAME	"mrvl/usb8766_uapsta.bin"
 #define USB8797_DEFAULT_FW_NAME	"mrvl/usb8797_uapsta.bin"
 #define USB8801_DEFAULT_FW_NAME	"mrvl/usb8801_uapsta.bin"
+#define USB8897_DEFAULT_FW_NAME	"mrvl/usb8897_uapsta.bin"
 #define USB8997_DEFAULT_FW_NAME	"mrvl/usbusb8997_combo_v4.bin"
 
 #define FW_DNLD_TX_BUF_SIZE	620
-- 
2.43.0

