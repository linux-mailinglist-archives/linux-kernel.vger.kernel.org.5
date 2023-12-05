Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBBB806025
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345870AbjLEVHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEVHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:07:02 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C58188;
        Tue,  5 Dec 2023 13:07:08 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54bfa9b3ffaso7890084a12.1;
        Tue, 05 Dec 2023 13:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701810427; x=1702415227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x74SPMcY0OIkNHNYKVP8zxIa11SKy/rAVbNbtzbNtj4=;
        b=COPgiI9/aWIyacDSbgSGPgRq4wsvpYGF+lZQtluFjSitxG05E5J4uKRQUkAVFIgHCC
         LS6rDJLgW81G31iT6qH/RDddjxboFGCmZDdrVTddRT6gvc5B7b8PcBSVIa7AhMmFaT43
         Wm0NUiIV8+gsM3MRBLxC0cLEvhRNk9uX84yBo81jOwoZwECoFOrw4wsjeRVeLEwp6BQv
         KVdQ7czXrdoFHcdi1rVCKhpVC5RHgKBYrf2pDHJJZGutkPBp8ieuQK98GWZ3vwzhCu1t
         USKbPJR/rtA1L/eiKUxfjBnwlKzlM5xP6NhWX+WVb2QcHCCKxX/psuMNHdj+SaEQMO+c
         pIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701810427; x=1702415227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x74SPMcY0OIkNHNYKVP8zxIa11SKy/rAVbNbtzbNtj4=;
        b=IR4RTxxansXVbJKFyWOOZdYDRbvYBjNOgm34Fbl1r0n2sCnZcP+3YXREo+ym+H99DF
         iBhUg/4vdvvHaZqfaUFQxRm7QhA8mL7l1xdXY1QNYcEJ5ThACb/+eKw2Df9MXZky0ohm
         aunPMEZZuBeYpaRrlqcGr72qKddktTMxNH+uCj4wqn9gRGaWSneQP40ccUDPahGthqgg
         5H45n2uStNf0g9AAfcg5ZoMmhB9sa+K/gjAie5fkVtoAKqyN/0C9v5sfxFURTmq0BXF7
         5CHNj9tdY8lGaajRuKIQCORs+H5hJXN0P1ugUQ0Ov3+QpIngYIGPwWHTbFc9EchhEIAP
         UYZQ==
X-Gm-Message-State: AOJu0YzYYmNj7OApiAYpZeHg4aOGKCsfPz5LlleqeqzHJOPS3hWRaH9w
        VoQt5190cv2FR7pdV2EOmA==
X-Google-Smtp-Source: AGHT+IHkH5GZG8pFrRCk2/oY21EPtFifTXv8buO1kDY7Mx9lU/9yMV3qiqndEcQvV5LdEnXc9J3Y0w==
X-Received: by 2002:a50:d75a:0:b0:54c:4837:9a85 with SMTP id i26-20020a50d75a000000b0054c48379a85mr4078032edj.44.1701810426428;
        Tue, 05 Dec 2023 13:07:06 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:d9b0:71c0:990:192e])
        by smtp.gmail.com with ESMTPSA id o24-20020aa7c518000000b005485282a520sm1549596edq.75.2023.12.05.13.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 13:07:06 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [RESEND PATCH] wifi: mwifiex: Restore USB8897 chipset support
Date:   Tue,  5 Dec 2023 22:07:02 +0100
Message-ID: <20231205210702.209444-1-knaerzche@gmail.com>
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

