Return-Path: <linux-kernel+bounces-158975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B0B8B279B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C0E286878
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA38A14EC43;
	Thu, 25 Apr 2024 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="M61/zjIj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XeSgxN2P"
Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AE014B077;
	Thu, 25 Apr 2024 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714066186; cv=none; b=h19BFegfh2cDUWdWASBQCZrIJwgxjEJYe/4PRbmgXWSM7b6/JNBlOadnxRrX0MVx3xwEKHqShkP6Vqvij/5Im4Y122NB53OWpDc8wa5wXTtzDSFxyAmTTpvRRAfkRpHTjU6u4IViQMJf+JVh35CNUjPnCNHPhANTIsAaYGfh1Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714066186; c=relaxed/simple;
	bh=IdX1DsByIet9n5PBe8ieFNKHO8b7P4X3usY6bDnoiXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oCYLveO2/nJHuu9kbMPQQV2kqxSpUTveh1+vpMO4zNRHBLL8w9ArZKC7ItZPag8dq1PjgV++HXjdMZUVSFDjHs3ZW8wVLUIBipRe3E8DOz06oc/enk1+Q94MteTM33vdWR/w9aOi4MbEfnZk0TS5wDqPRgz291iL6d5zDZsc1lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=M61/zjIj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XeSgxN2P; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 9D4FA1C0016A;
	Thu, 25 Apr 2024 13:29:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 25 Apr 2024 13:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1714066182; x=1714152582; bh=Y5T8dXy+0IuzWwo5IEYIV
	EtK9ssccq41CPbLF2/ePpA=; b=M61/zjIjAIP7ExRllpoB5mItmQ0m+RhGMEHZI
	fN23T3TU9p2QRtz4vMsQ1cx8sDsVUsxepz+pnRq2dY7lW+RO3Ug+JMoIc+r4v0Uq
	C72xwlqC3842+YlUHUxwLK9qkZIJUelL+4NAwBhCLCSqVWv2tPWT95ZRfRWjaVZw
	V+ZbTTzmz50waLVkAi0eDZ5xMAwytC9w2Tt1fdv2Vj/CsBgbdguvvmb4Z0fhH2cp
	CM32kZiZ6YfbvrDD6ewBKkE1p8Zkt4M8ackuf+EtTJoviHN3bgyDYq4cR84/yjJ5
	ZCVGD1GvFDMtkeUzAZPuXGl28y3mLBwTFyUEWHh13OPDXdX3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714066182; x=1714152582; bh=Y5T8dXy+0IuzWwo5IEYIVEtK9ssc
	cq41CPbLF2/ePpA=; b=XeSgxN2PgWn2ZxpvNL5XFITz1N143IivaspEkZNlhREB
	vvavQLVosFYWvrWe7R+KTvzfCNjMF4mwVJdutyc4CGrGWuoVtADqFLO9uwRbQgOp
	r3POSKgVvRGGt5Y7ayoM7onAW+i2KiWtDaX7iQOSvlr75t0mmKRYtxXQGyFgLmJi
	6xyd9RBJAMQU6GajTLdUFcCD2Bg/d3hlVaYsVso57z2Vu307rQhwoKzBkWfiWnd8
	GOf/O0lhj/2P7W+D6WPUU88van9PspQFt9MQtcmKxVmMOmoyesJZGgpHwJ/Yt99x
	QpH6mztUb+frp2iCybjSDEmo6bkwyunvLuVStE86hA==
X-ME-Sender: <xms:BZMqZjshkVjgQqzt-xabEfBeBsx0Eij41z9RpNoBNhjUMPgbyyukWw>
    <xme:BZMqZkdEAC7eDhgA8EuuTgfm6rdLwL26s9jO-Xn4mjf5-8K2Xdo4jb3wXAIAsZVey
    -IhFAYXuuvJYTPas7Y>
X-ME-Received: <xmr:BZMqZmw0SU6lW8Zc3iQDRybEaNrs8b7ud0agSCx-iZ4WUtYUFwP3rG8eCKx4IA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeljedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogetfedtuddqtdduucdludehmdenucfjughrpefhvfevufffkffoggfgsedtkeertder
    tddtnecuhfhrohhmpefnhihnughonhcuufgrnhgthhgvuceolhhsrghntghhvgeslhihnh
    guvghnohdrtggrqeenucggtffrrghtthgvrhhnpeeitdfhjeejgfejtdeihfdviedvuddt
    vdfgfedvheeitedttdehvdefkeetkeffjeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehlshgrnhgthhgvsehlhihnuggvnhhordgtrg
X-ME-Proxy: <xmx:BZMqZiPGt1qAo82i-18wSsorE9Ckb42pFS6z5RIZ1la0onfqq4qU2w>
    <xmx:BZMqZj-Tyvob3B0grhVKkHPumR3pZ6qNDjIKfY6w96baf5qi9Ywm2g>
    <xmx:BZMqZiXohanuSkxxiggpi4h2s44K8DcR2PcxawuOcTXsbjzOinUmrg>
    <xmx:BZMqZkenTgeN4yaYEtIdL2lLRD-kV9QCqNvovqRIeUygzFpsYxELJA>
    <xmx:BpMqZvQPnuvEfwfLyb_xaqutp-mETrfMqK7l5FtjHrrSA1Ub81p14URv>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Apr 2024 13:29:40 -0400 (EDT)
From: Lyndon Sanche <lsanche@lyndeno.ca>
To: lsanche@lyndeno.ca
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: [PATCH] platform/x86: dell-laptop: Implement platform_profile
Date: Thu, 25 Apr 2024 11:27:57 -0600
Message-ID: <20240425172758.67831-1-lsanche@lyndeno.ca>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Dell laptops support configuration of preset
fan modes through smbios tables.

If the platform supports these fan modes, set up
platform_profile to change these modes. If not
supported, skip enabling platform_profile.

Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
---
 drivers/platform/x86/dell/dell-laptop.c | 220 ++++++++++++++++++++++++
 drivers/platform/x86/dell/dell-smbios.h |   1 +
 2 files changed, 221 insertions(+)

diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
index 42f7de2b4522..7f9c4e0e5ef5 100644
--- a/drivers/platform/x86/dell/dell-laptop.c
+++ b/drivers/platform/x86/dell/dell-laptop.c
@@ -27,6 +27,7 @@
 #include <linux/i8042.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/platform_profile.h>
 #include <acpi/video.h>
 #include "dell-rbtn.h"
 #include "dell-smbios.h"
@@ -95,10 +96,18 @@ static struct backlight_device *dell_backlight_device;
 static struct rfkill *wifi_rfkill;
 static struct rfkill *bluetooth_rfkill;
 static struct rfkill *wwan_rfkill;
+static struct platform_profile_handler *thermal_handler;
 static bool force_rfkill;
 static bool micmute_led_registered;
 static bool mute_led_registered;
 
+enum thermal_mode_bits {
+	DELL_BALANCED = 0,
+	DELL_COOL_BOTTOM = 1,
+	DELL_QUIET = 2,
+	DELL_PERFORMANCE = 3,
+};
+
 module_param(force_rfkill, bool, 0444);
 MODULE_PARM_DESC(force_rfkill, "enable rfkill on non whitelisted models");
 
@@ -2199,6 +2208,211 @@ static int mute_led_set(struct led_classdev *led_cdev,
 	return 0;
 }
 
+// Derived from smbios-thermal-ctl
+//
+// cbClass 17
+// cbSelect 19
+// User Selectable Thermal Tables(USTT)
+// cbArg1 determines the function to be performed
+// cbArg1 0x0 = Get Thermal Information
+//  cbRES1         Standard return codes (0, -1, -2)
+//  cbRES2, byte 0  Bitmap of supported thermal modes. A mode is supported if its bit is set to 1
+//     Bit 0 Balanced
+//     Bit 1 Cool Bottom
+//     Bit 2 Quiet
+//     Bit 3 Performance
+//  cbRES2, byte 1 Bitmap of supported Active Acoustic Controller (AAC) modes. Each mode
+//                 corresponds to the supported thermal modes in byte 0. A mode is supported if
+//                 its bit is set to 1.
+//     Bit 0 AAC (Balanced)
+//     Bit 1 AAC (Cool Bottom
+//     Bit 2 AAC (Quiet)
+//     Bit 3 AAC (Performance)
+//  cbRes3, byte 0 Current Thermal Mode
+//     Bit 0 Balanced
+//     Bit 1 Cool Bottom
+//     Bit 2 Quiet
+//     Bit 3 Performanc
+//  cbRes3, byte 1  AAC Configuration type
+//          0       Global (AAC enable/disable applies to all supported USTT modes)
+//          1       USTT mode specific
+//  cbRes3, byte 2  Current Active Acoustic Controller (AAC) Mode
+//     If AAC Configuration Type is Global,
+//          0       AAC mode disabled
+//          1       AAC mode enabled
+//     If AAC Configuration Type is USTT mode specific (multiple bits may be set),
+//          Bit 0 AAC (Balanced)
+//          Bit 1 AAC (Cool Bottom
+//          Bit 2 AAC (Quiet)
+//          Bit 3 AAC (Performance)
+//  cbRes3, byte 3  Current Fan Failure Mode
+//     Bit 0 Minimal Fan Failure (at least one fan has failed, one fan working)
+//     Bit 1 Catastrophic Fan Failure (all fans have failed)
+//  cbArg1 0x1   (Set Thermal Information), both desired thermal mode and
+//               desired AAC mode shall be applied
+//  cbArg2, byte 0  Desired Thermal Mode to set (only one bit may be set for this parameter)
+//     Bit 0 Balanced
+//     Bit 1 Cool Bottom
+//     Bit 2 Quiet
+//     Bit 3 Performance
+//  cbArg2, byte 1  Desired Active Acoustic Controller (AAC) Mode to set
+//     If AAC Configuration Type is Global,
+//         0  AAC mode disabled
+//         1  AAC mode enabled
+//
+//     If AAC Configuration Type is USTT mode specific (multiple bits may be set for this parameter),
+//         Bit 0 AAC (Balanced)
+//         Bit 1 AAC (Cool Bottom
+//         Bit 2 AAC (Quiet)
+//         Bit 3 AAC (Performance)
+static int thermal_get_mode(void)
+{
+	struct calling_interface_buffer buffer;
+	int state;
+	int ret;
+
+	dell_fill_request(&buffer, 0x0, 0, 0, 0);
+	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
+	if (ret)
+		return ret;
+	state = buffer.output[2];
+	if ((state >> DELL_BALANCED) & 1)
+		return DELL_BALANCED;
+	else if ((state >> DELL_COOL_BOTTOM) & 1)
+		return DELL_COOL_BOTTOM;
+	else if ((state >> DELL_QUIET) & 1)
+		return DELL_QUIET;
+	else if ((state >> DELL_PERFORMANCE) & 1)
+		return DELL_PERFORMANCE;
+	else
+		return 0;
+}
+
+static int thermal_get_supported_modes(int *supported_bits)
+{
+	struct calling_interface_buffer buffer;
+	int ret;
+
+	dell_fill_request(&buffer, 0x0, 0, 0, 0);
+	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
+	if (ret)
+		return ret;
+	*supported_bits = buffer.output[1] & 0xF;
+	return 0;
+}
+
+static int thermal_get_acc_mode(int *acc_mode)
+{
+	struct calling_interface_buffer buffer;
+	int ret;
+
+	dell_fill_request(&buffer, 0x0, 0, 0, 0);
+	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
+	if (ret)
+		return ret;
+	*acc_mode = ((buffer.output[3] >> 8) & 0xFF);
+	return 0;
+}
+
+static int thermal_set_mode(enum thermal_mode_bits state)
+{
+	struct calling_interface_buffer buffer;
+	int ret;
+	int acc_mode;
+
+	ret = thermal_get_acc_mode(&acc_mode);
+	if (ret)
+		return ret;
+
+	dell_fill_request(&buffer, 0x1, (acc_mode << 8) | BIT(state), 0, 0);
+	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
+	return ret;
+}
+
+static int thermal_platform_profile_set(struct platform_profile_handler *pprof,
+					enum platform_profile_option profile)
+{
+	int ret;
+
+	switch (profile) {
+	case PLATFORM_PROFILE_BALANCED:
+		ret = thermal_set_mode(DELL_BALANCED);
+		break;
+	case PLATFORM_PROFILE_PERFORMANCE:
+		ret = thermal_set_mode(DELL_PERFORMANCE);
+		break;
+	case PLATFORM_PROFILE_QUIET:
+		ret = thermal_set_mode(DELL_QUIET);
+		break;
+	case PLATFORM_PROFILE_COOL:
+		ret = thermal_set_mode(DELL_COOL_BOTTOM);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
+static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
+					enum platform_profile_option *profile)
+{
+	switch (thermal_get_mode()) {
+	case DELL_BALANCED:
+		*profile = PLATFORM_PROFILE_BALANCED;
+		break;
+	case DELL_PERFORMANCE:
+		*profile = PLATFORM_PROFILE_PERFORMANCE;
+		break;
+	case DELL_COOL_BOTTOM:
+		*profile = PLATFORM_PROFILE_COOL;
+		break;
+	case DELL_QUIET:
+		*profile = PLATFORM_PROFILE_QUIET;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int thermal_init(void)
+{
+	int ret;
+	int supported_modes;
+
+	ret = thermal_get_supported_modes(&supported_modes);
+
+	if (ret != 0 || supported_modes == 0)
+		return -ENXIO;
+
+	thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
+	if (!thermal_handler)
+		return -ENOMEM;
+	thermal_handler->profile_get = thermal_platform_profile_get;
+	thermal_handler->profile_set = thermal_platform_profile_set;
+
+	if ((supported_modes >> DELL_QUIET) & 1)
+		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
+	if ((supported_modes >> DELL_COOL_BOTTOM) & 1)
+		set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
+	if ((supported_modes >> DELL_BALANCED) & 1)
+		set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
+	if ((supported_modes >> DELL_PERFORMANCE) & 1)
+		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
+
+	platform_profile_register(thermal_handler);
+
+	return 0;
+}
+
+void thermal_cleanup(void)
+{
+	platform_profile_remove();
+	kfree(thermal_handler);
+}
+
 static struct led_classdev mute_led_cdev = {
 	.name = "platform::mute",
 	.max_brightness = 1,
@@ -2266,6 +2480,11 @@ static int __init dell_init(void)
 		mute_led_registered = true;
 	}
 
+	// Do not fail module if thermal modes not supported,
+	// just skip
+	if (thermal_init() != 0)
+		pr_warn("Unable to setup platform_profile, skipping");
+
 	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
 		return 0;
 
@@ -2344,6 +2563,7 @@ static void __exit dell_exit(void)
 		platform_device_unregister(platform_device);
 		platform_driver_unregister(&platform_driver);
 	}
+	thermal_cleanup();
 }
 
 /* dell-rbtn.c driver export functions which will not work correctly (and could
diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/x86/dell/dell-smbios.h
index eb341bf000c6..585d042f1779 100644
--- a/drivers/platform/x86/dell/dell-smbios.h
+++ b/drivers/platform/x86/dell/dell-smbios.h
@@ -19,6 +19,7 @@
 /* Classes and selects used only in kernel drivers */
 #define CLASS_KBD_BACKLIGHT 4
 #define SELECT_KBD_BACKLIGHT 11
+#define SELECT_THERMAL_MANAGEMENT 19
 
 /* Tokens used in kernel drivers, any of these
  * should be filtered from userspace access
-- 
2.42.0


