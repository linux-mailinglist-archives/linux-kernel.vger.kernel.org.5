Return-Path: <linux-kernel+bounces-26142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C555F82DBE0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30FD3B21A63
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67EF19441;
	Mon, 15 Jan 2024 14:49:05 +0000 (UTC)
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6D318EC8;
	Mon, 15 Jan 2024 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 4A1C7101655;
	Mon, 15 Jan 2024 14:49:00 +0000 (UTC)
From: Max Staudt <max@enpas.org>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	max@enpas.org
Subject: [PATCH v1 7/7] HID: playstation: DS4: Add VID/PID for SZ-MYPOWER controllers
Date: Mon, 15 Jan 2024 23:45:38 +0900
Message-Id: <20240115144538.12018-8-max@enpas.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240115144538.12018-1-max@enpas.org>
References: <20240115144538.12018-1-max@enpas.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems like this USB VID is not officially assigned, so let's create a
hid-ids.h entry without a vendor or product name.

Signed-off-by: Max Staudt <max@enpas.org>
---
 drivers/hid/hid-ids.h         | 3 +++
 drivers/hid/hid-playstation.c | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 72046039d1be..df831ab464a4 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -22,6 +22,9 @@
 #define USB_DEVICE_ID_3M2256		0x0502
 #define USB_DEVICE_ID_3M3266		0x0506
 
+#define USB_VENDOR_ID_7545		0x7545
+#define USB_DEVICE_ID_7545_0104		0x0104
+
 #define USB_VENDOR_ID_A4TECH		0x09da
 #define USB_DEVICE_ID_A4TECH_WCP32PU	0x0006
 #define USB_DEVICE_ID_A4TECH_X5_005D	0x000a
diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index a0eb36d695d9..0aa474f1e96f 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -2747,6 +2747,10 @@ static const struct hid_device_id ps_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONGLE),
 		.driver_data = PS_TYPE_PS4_DUALSHOCK4 },
 
+	/* Third-party controllers identifying as "SZ-MYPOWER" */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_7545, USB_DEVICE_ID_7545_0104),
+		.driver_data = PS_TYPE_PS4_DUALSHOCK4 },
+
 	/* Sony DualSense controllers for PS5 */
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5_CONTROLLER),
 		.driver_data = PS_TYPE_PS5_DUALSENSE },
-- 
2.39.2


