Return-Path: <linux-kernel+bounces-91197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE19870B14
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BC05B23C1A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866AB7A71E;
	Mon,  4 Mar 2024 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orange.fr header.i=@orange.fr header.b="uF/oNEhK"
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9807995F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709582301; cv=none; b=QtUjmJwQUeLeuYHABqMlc/c4MPF4m/7wQxiC7XqCsNjidtLnEoM5uHV97eBhiuSSu62BvdLPEB94rJMJqu7VM2tVGxueG1zwML1mLpJb30l6cKQIGzLSHu9Qb61/wfZYMRkMLZBGbt4r5fa/FYoUeB5LZZbd7KeYe93T0TvZdDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709582301; c=relaxed/simple;
	bh=UZlUKzJDIE3Ejg/2uPUT90rGzS7fsqyUAE1JCjenB8I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Enzqr+v1Xmq+tMRFiYuKi2ke1PVg9Beju3Hujwbg83bUghTURHQWGR8uq13By1OmQ0ZGeW1LPy6qwwgcp6nxSzhsttuvnkrV7/nZSkVkF7tEvP8z6VWqaCCG9JUF0KEa0nUzPdsFO2j/hZiUPUgX6fkwM+urOLkKWuhnfT1a2po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orange.fr; spf=pass smtp.mailfrom=orange.fr; dkim=pass (2048-bit key) header.d=orange.fr header.i=@orange.fr header.b=uF/oNEhK; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orange.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orange.fr
Received: from jules-desktop.dynamic.ziggo.nl ([84.105.71.69])
	by smtp.orange.fr with ESMTPA
	id hERkrRZOAhB2WhERtr5oAP; Mon, 04 Mar 2024 20:58:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
	s=t20230301; t=1709582290;
	bh=3dYE06cGrljHtTRYwZzkQUBSeOHR9BhQZqpePGYgV5k=;
	h=From:To:Cc:Subject:Date;
	b=uF/oNEhK4XQZg3UzLRoWmmzve7fwvieWMOMT6tkwHlIWCQbe52mdmsW4bau/1SKqc
	 JtZ3OauX4BiUvGB6F8geDZOHgjYGAR10WbTF3r5MTskvDbB2xKVGdw6yRfWuW/IY5j
	 kGNd+5mI7kZaxsrYnLr1I/r6VwejPbnXQvrKpzIyzHPzXk3WwjY7B6cIlazb4A0hK4
	 ULmiddNkFyj5PeG/ptRvYG1mbRca/w4ejm27ve8yJZQvPhz6cd5dtciwK0TwJwVfXm
	 c8YeT6xD8Gov3LURxCLGZlwbiGJrEG/O1ZD/QONxvnkPxjmzTcReONonaz4aR3byby
	 HWpqjczT2rwuQ==
X-ME-Helo: jules-desktop.dynamic.ziggo.nl
X-ME-Auth: anVsZXMubm9pcmFudEBvcmFuZ2UuZnI=
X-ME-Date: Mon, 04 Mar 2024 20:58:10 +0100
X-ME-IP: 84.105.71.69
From: Jules Noirant <jules.noirant@orange.fr>
To: 
Cc: jkosina@suse.com,
	bentiss@kernel.org,
	jkosina@suse.cz,
	Jules Noirant <jules.noirant@orange.fr>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-usb@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: usbhid: hid-pidff: fix initialisation for devices that pre-play effects
Date: Mon,  4 Mar 2024 20:57:45 +0100
Message-Id: <20240304195745.10195-1-jules.noirant@orange.fr>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some PID compliant devices play effects outside of the usb drivers when you
power them, for example an autocenter spring. These effects are thus
re-triggered when you reset the device through the driver init sequence,
preventing other effects to be played in some cases.

This fix makes sure all the effects currently played are stopped after
resetting the device. More specifically, it brings compatibility to the
Brunner CLS-P joystick and potentially more of their products.

Signed-off-by: Jules Noirant <jules.noirant@orange.fr>
---
 drivers/hid/usbhid/hid-pidff.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 3b4ee21cd..aade18f9e 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -109,8 +109,9 @@ static const u8 pidff_pool[] = { 0x80, 0x83, 0xa9 };
 /* Special field key tables used to put special field keys into arrays */
 
 #define PID_ENABLE_ACTUATORS	0
-#define PID_RESET		1
-static const u8 pidff_device_control[] = { 0x97, 0x9a };
+#define PID_STOP_ALL_EFFECTS	1
+#define PID_RESET		2
+static const u8 pidff_device_control[] = { 0x97, 0x99, 0x9a };
 
 #define PID_CONSTANT	0
 #define PID_RAMP	1
@@ -1157,6 +1158,10 @@ static void pidff_reset(struct pidff_device *pidff)
 	hid_hw_request(hid, pidff->reports[PID_DEVICE_CONTROL], HID_REQ_SET_REPORT);
 	hid_hw_wait(hid);
 
+	pidff->device_control->value[0] = pidff->control_id[PID_STOP_ALL_EFFECTS];
+	hid_hw_request(hid, pidff->reports[PID_DEVICE_CONTROL], HID_REQ_SET_REPORT);
+	hid_hw_wait(hid);
+
 	pidff->device_control->value[0] =
 		pidff->control_id[PID_ENABLE_ACTUATORS];
 	hid_hw_request(hid, pidff->reports[PID_DEVICE_CONTROL], HID_REQ_SET_REPORT);
-- 
2.40.1


