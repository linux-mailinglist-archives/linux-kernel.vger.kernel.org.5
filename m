Return-Path: <linux-kernel+bounces-143662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569658A3C0F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 420A3B21460
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 09:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36ED376E2;
	Sat, 13 Apr 2024 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=carewolf.com header.i=@carewolf.com header.b="Ibfk6tCT";
	dkim=permerror (0-bit key) header.d=carewolf.com header.i=@carewolf.com header.b="72NY91nH"
Received: from mailrelay5-3.pub.mailoutpod3-cph3.one.com (mailrelay5-3.pub.mailoutpod3-cph3.one.com [46.30.212.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E06208D7
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713002171; cv=none; b=Tuo4wEEvh5CgtzLQWhax/Em2y4idTirM+syBuA4CjOmA/nivO/6p443CluZyeMXcgTjkWGQttVdmRIlCfJTOw07/6hGVsD/VtQRB94Oed4NvTOk/8z/ikhWCk+yg4NuxZjLNpZrB/MRHZSYyl0e5Pt5j+1xYYuFL9IDooOF9hoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713002171; c=relaxed/simple;
	bh=a/Cj0cYX194DFIeEdbRHmqY8C46QktZNzM5KRjs/LzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Unc+Mb3aeKB0cxtkpkEf9WxgbyKzLDVz35NegS26K1jgXrFXyMRTn5n6hetgwdYmHa8dyFEdoHzRjhjMM70vn6AaFpj9M3ZC814rfYBbA89KxfvuIhj4cWuCY0jFv91WaP/c0H2R0QFJdDNB9mPQecBFU8Pphrnz1PI4boFjur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carewolf.com; spf=none smtp.mailfrom=carewolf.com; dkim=pass (2048-bit key) header.d=carewolf.com header.i=@carewolf.com header.b=Ibfk6tCT; dkim=permerror (0-bit key) header.d=carewolf.com header.i=@carewolf.com header.b=72NY91nH; arc=none smtp.client-ip=46.30.212.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carewolf.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=carewolf.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=carewolf.com; s=rsa2;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=9MxNM7wKesTwim03/yc0/VDRR+BxHZw1lREx6nqzB70=;
	b=Ibfk6tCT7EkmxWXTRIuSKB5jceDnnW5uxxrleoUl1gap6fs60ZMG9XoV4r3jazln0t8pH/LPVkmqb
	 ig/knQNOpU3aSSFVp7n3hs+BGu3bkqZIJU1F0OmnPmjyoE/KdAnmbF5hzfEsR5S624Cj4gC7MnlzBM
	 Asbik9fH35wafepwpJd+QtF6ixdg7KU3hE29Wzt8FOnyo2tMj/P3PJ1jkOc3oTcxkc8s61kUg3UPeN
	 ZuMK/VSBTE6V6mYMPdwkpbrH9Zs4EdY3J5fh5sWjvCrl90cHOBiPTj8b+RcZXYQm6ErOOdS0Z5nTJW
	 l45K4JD0ZabxbFdZYFZhenzBz5WC0FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=carewolf.com; s=ed2;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=9MxNM7wKesTwim03/yc0/VDRR+BxHZw1lREx6nqzB70=;
	b=72NY91nHLGOWtxSbrn8eCtOSjuVxtDDWb2oF5yCdl4bms9VNLXxb8hDczC5sQGKFLb0FEsc82TH90
	 zhdv8ruCw==
X-HalOne-ID: e0253a46-f97b-11ee-8c3d-9fce02cdf4bb
Received: from carewolf.com (dynamic-2a02-3103-004c-5300-4122-02a7-cbcb-6b9e.310.pool.telefonica.de [2a02:3103:4c:5300:4122:2a7:cbcb:6b9e])
	by mailrelay5.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id e0253a46-f97b-11ee-8c3d-9fce02cdf4bb;
	Sat, 13 Apr 2024 09:54:55 +0000 (UTC)
From: kde@carewolf.com
To: lains@riseup.net,
	hadess@hadess.net,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Allan Sandfeld Jensen <allan.jensen@qt.io>
Subject: [PATCH] Logitech Anywhere 3SB support
Date: Sat, 13 Apr 2024 11:54:53 +0200
Message-Id: <20240413095453.14816-1-kde@carewolf.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Allan Sandfeld Jensen <allan.jensen@qt.io>

---
 drivers/hid/hid-ids.h            |  1 +
 drivers/hid/hid-logitech-dj.c    | 10 +++++++++-
 drivers/hid/hid-logitech-hidpp.c |  2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 2235d78784b1..4b79c4578d32 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -849,6 +849,7 @@
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1	0xc539
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_1	0xc53f
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_POWERPLAY	0xc53a
+#define USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER		0xc548
 #define USB_DEVICE_ID_SPACETRAVELLER	0xc623
 #define USB_DEVICE_ID_SPACENAVIGATOR	0xc626
 #define USB_DEVICE_ID_DINOVO_DESKTOP	0xc704
diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index c358778e070b..92b41ae5a47c 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -120,6 +120,7 @@ enum recvr_type {
 	recvr_type_27mhz,
 	recvr_type_bluetooth,
 	recvr_type_dinovo,
+	recvr_type_bolt,
 };
 
 struct dj_report {
@@ -1068,6 +1069,7 @@ static void logi_hidpp_recv_queue_notif(struct hid_device *hdev,
 		workitem.reports_supported |= STD_KEYBOARD;
 		break;
 	case 0x0f:
+	case 0x10:
 	case 0x11:
 		device_type = "eQUAD Lightspeed 1.2";
 		logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
@@ -1430,7 +1432,8 @@ static int logi_dj_ll_parse(struct hid_device *hid)
 		dbg_hid("%s: sending a mouse descriptor, reports_supported: %llx\n",
 			__func__, djdev->reports_supported);
 		if (djdev->dj_receiver_dev->type == recvr_type_gaming_hidpp ||
-		    djdev->dj_receiver_dev->type == recvr_type_mouse_only)
+		    djdev->dj_receiver_dev->type == recvr_type_mouse_only ||
+		    djdev->dj_receiver_dev->type == recvr_type_bolt)
 			rdcat(rdesc, &rsize, mse_high_res_descriptor,
 			      sizeof(mse_high_res_descriptor));
 		else if (djdev->dj_receiver_dev->type == recvr_type_27mhz)
@@ -1773,6 +1776,7 @@ static int logi_dj_probe(struct hid_device *hdev,
 	case recvr_type_dj:		no_dj_interfaces = 3; break;
 	case recvr_type_hidpp:		no_dj_interfaces = 2; break;
 	case recvr_type_gaming_hidpp:	no_dj_interfaces = 3; break;
+	case recvr_type_bolt:		no_dj_interfaces = 4; break;
 	case recvr_type_mouse_only:	no_dj_interfaces = 2; break;
 	case recvr_type_27mhz:		no_dj_interfaces = 2; break;
 	case recvr_type_bluetooth:	no_dj_interfaces = 2; break;
@@ -1950,6 +1954,10 @@ static const struct hid_device_id logi_dj_receivers[] = {
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER_2),
 	 .driver_data = recvr_type_dj},
+	{ /* Logitech bolt receiver (0xc548) */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
+		USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER),
+	 .driver_data = recvr_type_bolt},
 
 	{ /* Logitech Nano mouse only receiver (0xc52f) */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 3c00e6ac8e76..509142982daa 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4380,6 +4380,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb023) },
 	{ /* MX Master 3S mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb034) },
+	{ /* MX Anywhere 3SB mouse over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb038) },
 	{}
 };
 
-- 
2.39.2


