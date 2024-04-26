Return-Path: <linux-kernel+bounces-159430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F3B8B2E8B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C10E2B22802
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62891860;
	Fri, 26 Apr 2024 02:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="NopgmDAr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RKV3jtK2"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2BA15CE;
	Fri, 26 Apr 2024 02:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714097132; cv=none; b=ekTnfIVXpQt1iVVRrRz3MembpYNba2tTTgkK2SYmicTGavkuXjhc3fHn7S/G8WcfdY75db7MF/bLV7vFgyCC862e0C7YzUgdvnxj5S+SfwYFu/WW+0uNTx8YFEAVwCIiiQe2ErWGt4Y2SIsJ2PB7XwnCCbmZznajJMx77rfEX5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714097132; c=relaxed/simple;
	bh=ZfGAvkZbMx+tx84phpGu3476P+EfApvkK/FmtNhatws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDlWUv7iCvbHupUyRmxxAj80alJCEMktm7bXYow8vgmn8OSKBjP9/4UIuvMHf97jzvmFnxM9GgCMehI4XDAKISXVwxfYa/XUiAFM1OIjrgz7qP/N3c0VNsncrsM9H2sMlhXi8frKdduw4ZpM+Ey4ney0aES+Bn+7JybnQUj2CYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=NopgmDAr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RKV3jtK2; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B37921140148;
	Thu, 25 Apr 2024 22:05:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 25 Apr 2024 22:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1714097128; x=
	1714183528; bh=R0QQ/UT8XpuSH689+3hRSGkzucHfAjikPxtw3mo7Hv4=; b=N
	opgmDArUaDJD7Yyrhv+FBj9f6Fx2tN9Gpjk48000qyBEyKPp1aQO7YN/RIGctjVw
	AIk3GJQDtW8UZy2HOQFPextZfQFuGDOWM+ULdA7xVJ2sLP4ujwjTDKin+AX+qgVd
	m3Z/zF2zZOXLv3vhJgsupl1//JHsnxxylEfrDXhudLOl/XzRacTwP78MCZtuHZrY
	YadYss1ywc80Q3IClirp6234CLhYUmHcaVWApjyBygCqa9CEHERpKx4GjRVeHWUj
	A9ByuWQHRyTPyBPDUny5drQgjL5tzKNxveR3sKrfvHyCvID0t/PWlCHO2MW6s4Jz
	dBadnkJe/EwgJVUzRFnKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714097128; x=
	1714183528; bh=R0QQ/UT8XpuSH689+3hRSGkzucHfAjikPxtw3mo7Hv4=; b=R
	KV3jtK20WnaNw5jF+GDhROqZ/TNsgg0SQcru/vnbfrOe4t7C4cR921UBvG4WNqEr
	ugKRruPwavRUxbf2gYHt3TAlNyLwRZ/XcFlu5StExnKQRqUW9es9FYbVt++rmt6q
	EpGsce+EA+vPUe1oUyg4Vi9vJgD7mv9oJjZhTMzljCaFm/wjaii0nYRicmafGfZA
	4WNpi1iVcBNFB2Uzg6hENjhr2KOgeI7Kka5aV24aYwmLI/xaOSspI2Lov7cmsw87
	uAiRSAAlvPmxuo/DtMmPsRxbXtxXT1e3VWdRgmwuJCajNlta8SPEnalhYVtp4fZ5
	3zQVqI8K4ZIYZh/CGXQXg==
X-ME-Sender: <xms:6AsrZtkqWIJn_Fb82elSPHoo2GXW51Dp2E2e2200iGoFz6HXFh9J3w>
    <xme:6AsrZo1QC6xnNAjMWO16ctZw9l6r9UcDr7RuDwnQNuOCKhc2EKUOMRyHlc5NbVGGK
    SJhQUiQkEUSBK1-zjE>
X-ME-Received: <xmr:6AsrZjpSjOrILn8VxF1d9vQJtFwEmmrO7OA3OOQk0kSnSVEUyepc2PWLjU_Kbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelkedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goteeftdduqddtudculdduhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepnfihnhguohhnucfurghntghhvgcuoehlshgrnhgthhgvsehlhi
    hnuggvnhhordgtrgeqnecuggftrfgrthhtvghrnheplefhieffkedtledugfetgfegfeeh
    hfethffhffeuvefhtdekvdeikeehleejieetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheplhhsrghntghhvgeslhihnhguvghnohdrtggr
X-ME-Proxy: <xmx:6AsrZtmK-k34S-6hRuoaYK0xBJpitbNLlKYLLGSsW-eQoWZnIEiJdg>
    <xmx:6AsrZr3Yu7ad-NQ_wFOT65h-6cX6piAbSDgkMo5KF5ENQpI26O6PVQ>
    <xmx:6AsrZsuy18dmxVnbfWNCNbkBD3jxxjGx8A8q4zHQ5NjoZSbdIG1y9A>
    <xmx:6AsrZvUTOzG_R3zyCqlPUwRVCouUQoclr3AuWeZu6OyEXpn3mAkt-A>
    <xmx:6AsrZksOvM-S6fwnbt5Cz-Vk5NtvxPu-1dAOtK2L_3agOg4kDN8HqAmS>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Apr 2024 22:05:27 -0400 (EDT)
From: Lyndon Sanche <lsanche@lyndeno.ca>
To: lsanche@lyndeno.ca
Cc: mario.limonciello@amd.com,
	pali@kernel.org,
	W_Armin@gmx.de,
	srinivas.pandruvada@linux.intel.com,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: [PATCH v2] platform/x86: dell-laptop: Implement platform_profile
Date: Thu, 25 Apr 2024 20:04:39 -0600
Message-ID: <20240426020448.10862-1-lsanche@lyndeno.ca>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240425172758.67831-1-lsanche@lyndeno.ca>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
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
 drivers/platform/x86/dell/dell-laptop.c | 223 ++++++++++++++++++++++++
 drivers/platform/x86/dell/dell-smbios.h |   1 +
 2 files changed, 224 insertions(+)

diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
index 42f7de2b4522..ff67bc7697b1 100644
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
+//     If AAC Configuration Type is USTT mode specific
+//     (multiple bits may be set for this parameter),
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
+		return -ENXIO;
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
+	switch (profile) {
+	case PLATFORM_PROFILE_BALANCED:
+		return thermal_set_mode(DELL_BALANCED);
+	case PLATFORM_PROFILE_PERFORMANCE:
+		return thermal_set_mode(DELL_PERFORMANCE);
+	case PLATFORM_PROFILE_QUIET:
+		return thermal_set_mode(DELL_QUIET);
+	case PLATFORM_PROFILE_COOL:
+		return thermal_set_mode(DELL_COOL_BOTTOM);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
+					enum platform_profile_option *profile)
+{
+	int ret = thermal_get_mode();
+
+	if (ret < 0)
+		return ret;
+
+	switch (ret) {
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
+	if (ret || !supported_modes)
+		return 0;
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
+	// Clean up but do not fail
+	if (platform_profile_register(thermal_handler))
+		kfree(thermal_handler);
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
@@ -2238,6 +2452,12 @@ static int __init dell_init(void)
 		goto fail_rfkill;
 	}
 
+	// Do not fail module if thermal modes not supported,
+	// just skip
+	ret = thermal_init();
+	if (ret)
+		goto fail_thermal;
+
 	if (quirks && quirks->touchpad_led)
 		touchpad_led_init(&platform_device->dev);
 
@@ -2317,6 +2537,8 @@ static int __init dell_init(void)
 		led_classdev_unregister(&mute_led_cdev);
 fail_led:
 	dell_cleanup_rfkill();
+fail_thermal:
+	thermal_cleanup();
 fail_rfkill:
 	platform_device_del(platform_device);
 fail_platform_device2:
@@ -2344,6 +2566,7 @@ static void __exit dell_exit(void)
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


