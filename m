Return-Path: <linux-kernel+bounces-132017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB81898EC0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2681F28D73
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE098134416;
	Thu,  4 Apr 2024 19:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wantyapps.xyz header.i=@wantyapps.xyz header.b="cf1DVxsM"
Received: from mail.wantyapps.xyz (mail.wantyapps.xyz [66.135.5.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2493E13119B;
	Thu,  4 Apr 2024 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.135.5.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258086; cv=none; b=CMWxrYIbLr1I+3tD8kuFykerWs1OHZ8uTWHd58dsyDM6VlfYo3jf1OLPFIHs9gFdjF1B1psFNyXWQ+o4EKl1FI5g8aUyyGYVlu9VeAhoTVoTSuFBpOSSCMGSnsRBZ/OjDakg8Oh9skA3nK+vEfCny6orP0f27TMsFzpj6js4mSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258086; c=relaxed/simple;
	bh=QueE5iv6KUjeMTE44OC109wI3g5umCLfJ4vOn6h6GzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JsVfUbkr05e0hSoNedsMs9yrX7aH47iAmfJcEfEKX5s7KZts2HZna52HXq7f2jW0hmoU8cqvfrC58TaBXbgvpWwmehfoMHll4B12nutCHJQVaRHAkWc6fRuT0XxNIo6ijgDYYSjh0RwpcPCxDuCl/jEGIkKCDsZqiyQwF3kxejQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wantyapps.xyz; spf=pass smtp.mailfrom=wantyapps.xyz; dkim=pass (2048-bit key) header.d=wantyapps.xyz header.i=@wantyapps.xyz header.b=cf1DVxsM; arc=none smtp.client-ip=66.135.5.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wantyapps.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wantyapps.xyz
Received: from multivac.localdomain (unknown [147.235.205.62])
	by mail.wantyapps.xyz (Postfix) with ESMTPSA id D4CEE94A47;
	Thu,  4 Apr 2024 19:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wantyapps.xyz;
	s=mail; t=1712258082;
	bh=QueE5iv6KUjeMTE44OC109wI3g5umCLfJ4vOn6h6GzQ=;
	h=From:To:Cc:Subject:Date:From;
	b=cf1DVxsM7uXEYoHbAL7ZiDAKfBmvdxgEIPhOkObOdbkGPjSndgy88fKHfPd7eLX1d
	 qT9WzEsSzK8ohMmf7HFS7KljeeW2vqEyGAqGmMsoeIeirjn4LichnTlIWxzGyl9MOY
	 5Y9ec4CPwaJaxaPzbjo9FRzXvxNSAAvcOaABpq/7SovpAg5sVAdKGqJ1k/7hTa4g4b
	 druFCyqsv2MWOr9ZwACG+LHwzDhHx9lYUNtyNypvR8wprudikMXM2pwPHOMQhBsGlE
	 mKc1c3CCpRHutJoUAlc0fmkAAwjbSSixPoXunMcphjM8mw6VzWwRScE4IumCKSHnwD
	 NUMHVIQsCbBvQ==
From: me@wantyapps.xyz
To: 
Cc: me@wantyapps.xyz,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: ath3k: Fix multiple issues reported by checkpatch.pl
Date: Thu,  4 Apr 2024 22:13:45 +0300
Message-ID: <20240404191423.1545366-1-me@wantyapps.xyz>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Uri Arev <me@wantyapps.xyz>

This fixes some CHECKs reported by the checpatch script.

Issues reported in ath3k.c:
-------
ath3k.c
-------
CHECK: Please don't use multiple blank lines
+
+

CHECK: Blank lines aren't necessary after an open brace '{'
+static const struct usb_device_id ath3k_blist_tbl[] = {
+

CHECK: Alignment should match open parenthesis
+static int ath3k_load_firmware(struct usb_device *udev,
+				const struct firmware *firmware)

CHECK: Alignment should match open parenthesis
+		err = usb_bulk_msg(udev, pipe, send_buf, size,
+					&len, 3000);

CHECK: Unnecessary parentheses around 'len != size'
+		if (err || (len != size)) {

CHECK: Alignment should match open parenthesis
+static int ath3k_get_version(struct usb_device *udev,
+			struct ath3k_version *version)

CHECK: Alignment should match open parenthesis
+static int ath3k_load_fwfile(struct usb_device *udev,
+		const struct firmware *firmware)

CHECK: Alignment should match open parenthesis
+		err = usb_bulk_msg(udev, pipe, send_buf, size,
+					&len, 3000);

CHECK: Unnecessary parentheses around 'len != size'
+		if (err || (len != size)) {

CHECK: Blank lines aren't necessary after an open brace '{'
+	switch (fw_version.ref_clock) {
+

CHECK: Alignment should match open parenthesis
+	snprintf(filename, ATH3K_NAME_LEN, "ar3k/ramps_0x%08x_%d%s",
+		le32_to_cpu(fw_version.rom_version), clk_value, ".dfu");

CHECK: Alignment should match open parenthesis
+static int ath3k_probe(struct usb_interface *intf,
+			const struct usb_device_id *id)

CHECK: Alignment should match open parenthesis
+			BT_ERR("Firmware file \"%s\" not found",
+							ATH3K_FIRMWARE);

CHECK: Alignment should match open parenthesis
+			BT_ERR("Firmware file \"%s\" request failed (err=%d)",
+							ATH3K_FIRMWARE, ret);

total: 0 errors, 0 warnings, 14 checks, 540 lines checked

Signed-off-by: Uri Arev <me@wantyapps.xyz>
---
 drivers/bluetooth/ath3k.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 88262d3a9392..ce97b336fbfb 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2008-2009 Atheros Communications Inc.
  */
 
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -128,7 +127,6 @@ MODULE_DEVICE_TABLE(usb, ath3k_table);
  * for AR3012
  */
 static const struct usb_device_id ath3k_blist_tbl[] = {
-
 	/* Atheros AR3012 with sflash firmware*/
 	{ USB_DEVICE(0x0489, 0xe04e), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0489, 0xe04d), .driver_info = BTUSB_ATH3012 },
@@ -202,7 +200,7 @@ static inline void ath3k_log_failed_loading(int err, int len, int size,
 #define TIMEGAP_USEC_MAX	100
 
 static int ath3k_load_firmware(struct usb_device *udev,
-				const struct firmware *firmware)
+			       const struct firmware *firmware)
 {
 	u8 *send_buf;
 	int len = 0;
@@ -237,9 +235,9 @@ static int ath3k_load_firmware(struct usb_device *udev,
 		memcpy(send_buf, firmware->data + sent, size);
 
 		err = usb_bulk_msg(udev, pipe, send_buf, size,
-					&len, 3000);
+				   &len, 3000);
 
-		if (err || (len != size)) {
+		if (err || len != size) {
 			ath3k_log_failed_loading(err, len, size, count);
 			goto error;
 		}
@@ -262,7 +260,7 @@ static int ath3k_get_state(struct usb_device *udev, unsigned char *state)
 }
 
 static int ath3k_get_version(struct usb_device *udev,
-			struct ath3k_version *version)
+			     struct ath3k_version *version)
 {
 	return usb_control_msg_recv(udev, 0, ATH3K_GETVERSION,
 				    USB_TYPE_VENDOR | USB_DIR_IN, 0, 0,
@@ -271,7 +269,7 @@ static int ath3k_get_version(struct usb_device *udev,
 }
 
 static int ath3k_load_fwfile(struct usb_device *udev,
-		const struct firmware *firmware)
+			     const struct firmware *firmware)
 {
 	u8 *send_buf;
 	int len = 0;
@@ -310,8 +308,8 @@ static int ath3k_load_fwfile(struct usb_device *udev,
 		memcpy(send_buf, firmware->data + sent, size);
 
 		err = usb_bulk_msg(udev, pipe, send_buf, size,
-					&len, 3000);
-		if (err || (len != size)) {
+				   &len, 3000);
+		if (err || len != size) {
 			ath3k_log_failed_loading(err, len, size, count);
 			kfree(send_buf);
 			return err;
@@ -425,7 +423,6 @@ static int ath3k_load_syscfg(struct usb_device *udev)
 	}
 
 	switch (fw_version.ref_clock) {
-
 	case ATH3K_XTAL_FREQ_26M:
 		clk_value = 26;
 		break;
@@ -441,7 +438,7 @@ static int ath3k_load_syscfg(struct usb_device *udev)
 	}
 
 	snprintf(filename, ATH3K_NAME_LEN, "ar3k/ramps_0x%08x_%d%s",
-		le32_to_cpu(fw_version.rom_version), clk_value, ".dfu");
+		 le32_to_cpu(fw_version.rom_version), clk_value, ".dfu");
 
 	ret = request_firmware(&firmware, filename, &udev->dev);
 	if (ret < 0) {
@@ -456,7 +453,7 @@ static int ath3k_load_syscfg(struct usb_device *udev)
 }
 
 static int ath3k_probe(struct usb_interface *intf,
-			const struct usb_device_id *id)
+		       const struct usb_device_id *id)
 {
 	const struct firmware *firmware;
 	struct usb_device *udev = interface_to_usbdev(intf);
@@ -505,10 +502,10 @@ static int ath3k_probe(struct usb_interface *intf,
 	if (ret < 0) {
 		if (ret == -ENOENT)
 			BT_ERR("Firmware file \"%s\" not found",
-							ATH3K_FIRMWARE);
+			       ATH3K_FIRMWARE);
 		else
 			BT_ERR("Firmware file \"%s\" request failed (err=%d)",
-							ATH3K_FIRMWARE, ret);
+			       ATH3K_FIRMWARE, ret);
 		return ret;
 	}
 
-- 
2.44.0


