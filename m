Return-Path: <linux-kernel+bounces-164848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 674DA8B83F2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236BA2813F7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889124C7D;
	Wed,  1 May 2024 01:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="y6lcSHbw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X0x/UVbe"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884169461;
	Wed,  1 May 2024 01:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714526389; cv=none; b=FNAoghtBgf2l1/Q17tg5hjnm5d1F113dPlCO0wwkobM31ZvpPsSBkmxDFetdJ7tPQFa3hal8rSwGPgNVY6IFqyQcNb7l7G/NI78wzKFWX1S2byda11/+xWmv8OTLiDekV8TOsdhrXpMcEltRaae3X+R5CwbZw0xh8LRY6gCFAP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714526389; c=relaxed/simple;
	bh=LPi7KLbu40Qh6639itaoKijP7XG1NO4Wdmf1SQQI3uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ig4UyHG+YiPqreJib6pWmTP6QtibnUqasMo17+g5IcLQg+/fc7jLeR0aMzdxQRZi+ZHPCsEky+rZ8tMWTymNDhs/v7JgtFrL1sX1x2cXM30g+uUaV9Ibk5NEW2zuqrU2jl41b2mjbsTqvfwd4Ux7gASwX8vLWnZfHHHavyMyfsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=y6lcSHbw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X0x/UVbe; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A73AB11400E9;
	Tue, 30 Apr 2024 21:19:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 30 Apr 2024 21:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1714526384; x=
	1714612784; bh=7pxhx9MYFuRtaeBCtF7COYkBbHYztWeLGA2jrlK5tDY=; b=y
	6lcSHbwZDHzoMR332lAmAuFWBmNSPd+OgPafmcND7ZY/E/xKqGHjyG6AplZm+/dL
	CEz+LlpEyUCfaL2qu3WExa/7bCBuMKCdXu4QoWvRvKrfzbZpltbSwk5HOfMvQbec
	eLGMEmRj6E4lJrq8afFNv8sVjBi2OOASrni+pijJFAENb5Iw7ikdUgVrU9l/goMc
	w+8HscXWKB1tizf2HA3me2foxZcCrmh8chGDCgCUo1NWWAqgDh2e+SKOdDxw/BnI
	i/B73dDVJl6Que2/xC99jMIQBAyZ9fbT7EXyeV3LQVueejlAjok4fbbFaMZgvU5v
	0VGjDH6m9RrRKkkAjEkbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714526384; x=
	1714612784; bh=7pxhx9MYFuRtaeBCtF7COYkBbHYztWeLGA2jrlK5tDY=; b=X
	0x/UVbeqmvSBpwCLwfVXmwJbji0yTUrhkwX+4xGqL0rVw+v9m4+8KFyDCMnqZcIa
	OkEHixVcJEMmgabkdCUrAUtqwbNvroLfldwPjang1lCc1i3KWuKlRt/oR6fjmG4K
	OTy0Ncp/BqSyFeYAESyu2+ObmQyfk+Y32v+aSp6bOJM80S4Th4R0/B5Tm76A2XlL
	p2u3s2XqJyJRlHBY31BrEAJ0wPqX4xbts3TXVnk8PQiOruTUr0aF3vCuzERql17W
	9xp/VG2IfCAAJq3CEx47wj9LTCfA0y5qEK2b0iNQEdZsWuhorzjCsy2QPAwx4fy4
	DyF2AFjbnmPbnEUAo7Yrg==
X-ME-Sender: <xms:sJgxZsV37KFPmkSMvlIxZdnV6QUqG856boCD8j9W_rJQOErIJYqVTg>
    <xme:sJgxZgkZ3Oz-R1og3Ns2ERPmZbsyGDtZphhJGDgshEJvELO2fim-AldQl2pFrLAiq
    79F9vOO6Qu7LD0th6o>
X-ME-Received: <xmr:sJgxZgYX4XG9J0A0LHFh9GbDQJIFtsVa0Ob-IBckWAk5zHVew50Atmh4mmOsKAJlZ7bKpYX-nhg2RfnGGPS04phjAvOhQ8Ot>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddugedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goteeftdduqddtudculdduhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepnfihnhguohhnucfurghntghhvgcuoehlshgrnhgthhgvsehlhi
    hnuggvnhhordgtrgeqnecuggftrfgrthhtvghrnheplefhieffkedtledugfetgfegfeeh
    hfethffhffeuvefhtdekvdeikeehleejieetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheplhhsrghntghhvgeslhihnhguvghnohdrtggr
X-ME-Proxy: <xmx:sJgxZrWd8WmhGx-oBh0Zx_byRGKVWsDY_KTxHwnhSLR_Qlt_2oU9aQ>
    <xmx:sJgxZmmIsMSjQPp-f_Fmqs0Ij0_eymJy7mH_6oxq2mT6AJ93Poht3A>
    <xmx:sJgxZgcHa6lAlIv0U6Wa_oO56ZBeZFpUSywUNjc5R7bt6jTqkF5TFA>
    <xmx:sJgxZoHZ80lbFNqT06sWYg6ZH6cxfnNV6SzsZsProzxrWzwn8Y9aHw>
    <xmx:sJgxZh88vUMh-u1lggIWY1chKlq8TfVYdg_cuoGIDKY9z91hBliFngHi>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 21:19:43 -0400 (EDT)
From: Lyndon Sanche <lsanche@lyndeno.ca>
To: lsanche@lyndeno.ca
Cc: mario.limonciello@amd.com,
	pali@kernel.org,
	W_Armin@gmx.de,
	srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	lkp@intel.com,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: [PATCH v4] platform/x86: dell-laptop: Implement platform_profile
Date: Tue, 30 Apr 2024 19:14:52 -0600
Message-ID: <20240501011507.6942-2-lsanche@lyndeno.ca>
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

Some Dell laptops support configuration of preset fan modes through
smbios tables.

If the platform supports these fan modes, set up platform_profile to
change these modes. If not supported, skip enabling platform_profile.

Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
---
v4:
 - Make thermal_init and thermal_cleanup static
 - Rearrange order of added includes, did not edit current includes
 - Include bits.h
 - Switch comment style
 - Return error if platform_profile registering failed
 - Add thermal calls to call_blacklist
 - Align defines with tabs
 - Correct separation of function and error handling
 - Propagate error codes up
v3:
 - Convert smbios-thermal-ctl docs to multiline comment and wrap
 - Change thermal_mode_bits enum to directly be BIT() values
	- Convert related code to use this
 - Use FIELD_GET/PREP and GENNMASK for getting/setting thermal modes
	- Correct offset for getting current ACC mode, setting offset
		unchanged
 - Check if thermal_handler is allocated before freeing and
	 unregistering platform_profile
v2:
 - Wrap smbios-thermal-ctl comment
 - Return proper error code when invalid state returned
 - Simplify platform_profile_get returns
 - Propogate ENOMEM error
---
 drivers/platform/x86/dell/dell-laptop.c      | 238 +++++++++++++++++++
 drivers/platform/x86/dell/dell-smbios-base.c |   2 +
 drivers/platform/x86/dell/dell-smbios.h      |   1 +
 3 files changed, 241 insertions(+)

diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
index 42f7de2b4522..530ee6079447 100644
--- a/drivers/platform/x86/dell/dell-laptop.c
+++ b/drivers/platform/x86/dell/dell-laptop.c
@@ -27,6 +27,9 @@
 #include <linux/i8042.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/platform_profile.h>
 #include <acpi/video.h>
 #include "dell-rbtn.h"
 #include "dell-smbios.h"
@@ -95,6 +98,7 @@ static struct backlight_device *dell_backlight_device;
 static struct rfkill *wifi_rfkill;
 static struct rfkill *bluetooth_rfkill;
 static struct rfkill *wwan_rfkill;
+static struct platform_profile_handler *thermal_handler;
 static bool force_rfkill;
 static bool micmute_led_registered;
 static bool mute_led_registered;
@@ -2199,6 +2203,232 @@ static int mute_led_set(struct led_classdev *led_cdev,
 	return 0;
 }
 
+/* Derived from smbios-thermal-ctl
+ *
+ * cbClass 17
+ * cbSelect 19
+ * User Selectable Thermal Tables(USTT)
+ * cbArg1 determines the function to be performed
+ * cbArg1 0x0 = Get Thermal Information
+ *  cbRES1         Standard return codes (0, -1, -2)
+ *  cbRES2, byte 0  Bitmap of supported thermal modes. A mode is supported if
+ *                  its bit is set to 1
+ *     Bit 0 Balanced
+ *     Bit 1 Cool Bottom
+ *     Bit 2 Quiet
+ *     Bit 3 Performance
+ *  cbRES2, byte 1 Bitmap of supported Active Acoustic Controller (AAC) modes.
+ *                 Each mode corresponds to the supported thermal modes in
+ *                  byte 0. A mode is supported if its bit is set to 1.
+ *     Bit 0 AAC (Balanced)
+ *     Bit 1 AAC (Cool Bottom
+ *     Bit 2 AAC (Quiet)
+ *     Bit 3 AAC (Performance)
+ *  cbRes3, byte 0 Current Thermal Mode
+ *     Bit 0 Balanced
+ *     Bit 1 Cool Bottom
+ *     Bit 2 Quiet
+ *     Bit 3 Performanc
+ *  cbRes3, byte 1  AAC Configuration type
+ *          0       Global (AAC enable/disable applies to all supported USTT modes)
+ *          1       USTT mode specific
+ *  cbRes3, byte 2  Current Active Acoustic Controller (AAC) Mode
+ *     If AAC Configuration Type is Global,
+ *          0       AAC mode disabled
+ *          1       AAC mode enabled
+ *     If AAC Configuration Type is USTT mode specific (multiple bits may be set),
+ *          Bit 0 AAC (Balanced)
+ *          Bit 1 AAC (Cool Bottom
+ *          Bit 2 AAC (Quiet)
+ *          Bit 3 AAC (Performance)
+ *  cbRes3, byte 3  Current Fan Failure Mode
+ *     Bit 0 Minimal Fan Failure (at least one fan has failed, one fan working)
+ *     Bit 1 Catastrophic Fan Failure (all fans have failed)
+ *  cbArg1 0x1   (Set Thermal Information), both desired thermal mode and
+ *               desired AAC mode shall be applied
+ *  cbArg2, byte 0  Desired Thermal Mode to set
+ *                  (only one bit may be set for this parameter)
+ *     Bit 0 Balanced
+ *     Bit 1 Cool Bottom
+ *     Bit 2 Quiet
+ *     Bit 3 Performance
+ *  cbArg2, byte 1  Desired Active Acoustic Controller (AAC) Mode to set
+ *     If AAC Configuration Type is Global,
+ *         0  AAC mode disabled
+ *         1  AAC mode enabled
+ *
+ *     If AAC Configuration Type is USTT mode specific
+ *     (multiple bits may be set for this parameter),
+ *         Bit 0 AAC (Balanced)
+ *         Bit 1 AAC (Cool Bottom
+ *         Bit 2 AAC (Quiet)
+ *         Bit 3 AAC (Performance)
+ */
+
+#define DELL_ACC_GET_FIELD		GENMASK(19, 16)
+#define DELL_ACC_SET_FIELD		GENMASK(11, 8)
+#define DELL_THERMAL_SUPPORTED	GENMASK(3, 0)
+
+enum thermal_mode_bits {
+	DELL_BALANCED = BIT(0),
+	DELL_COOL_BOTTOM = BIT(1),
+	DELL_QUIET = BIT(2),
+	DELL_PERFORMANCE = BIT(3),
+};
+
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
+	if (state & DELL_BALANCED)
+		return DELL_BALANCED;
+	else if (state & DELL_COOL_BOTTOM)
+		return DELL_COOL_BOTTOM;
+	else if (state & DELL_QUIET)
+		return DELL_QUIET;
+	else if (state & DELL_PERFORMANCE)
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
+	*supported_bits = FIELD_GET(DELL_THERMAL_SUPPORTED, buffer.output[1]);
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
+	*acc_mode = FIELD_GET(DELL_ACC_GET_FIELD, buffer.output[3]);
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
+	dell_fill_request(&buffer, 0x1, FIELD_PREP(DELL_ACC_SET_FIELD, acc_mode) | state, 0, 0);
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
+	int ret;
+
+	ret = thermal_get_mode();
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
+static int thermal_init(void)
+{
+	int ret;
+	int supported_modes;
+
+	/* If thermal modes not supported, exit without error */
+	ret = thermal_get_supported_modes(&supported_modes);
+	if (ret < 0)
+		return ret;
+	if (!supported_modes)
+		return 0;
+
+	thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
+	if (!thermal_handler)
+		return -ENOMEM;
+	thermal_handler->profile_get = thermal_platform_profile_get;
+	thermal_handler->profile_set = thermal_platform_profile_set;
+
+	if (supported_modes & DELL_QUIET)
+		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
+	if (supported_modes & DELL_COOL_BOTTOM)
+		set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
+	if (supported_modes & DELL_BALANCED)
+		set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
+	if (supported_modes & DELL_PERFORMANCE)
+		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
+
+	/* Clean up if failed */
+	ret = platform_profile_register(thermal_handler);
+	if (ret)
+		kfree(thermal_handler);
+
+	return ret;
+}
+
+static void thermal_cleanup(void)
+{
+	if (thermal_handler) {
+		platform_profile_remove();
+		kfree(thermal_handler);
+	}
+}
+
 static struct led_classdev mute_led_cdev = {
 	.name = "platform::mute",
 	.max_brightness = 1,
@@ -2238,6 +2468,11 @@ static int __init dell_init(void)
 		goto fail_rfkill;
 	}
 
+	/* Do not fail module if thermal modes not supported, just skip */
+	ret = thermal_init();
+	if (ret)
+		goto fail_thermal;
+
 	if (quirks && quirks->touchpad_led)
 		touchpad_led_init(&platform_device->dev);
 
@@ -2317,6 +2552,8 @@ static int __init dell_init(void)
 		led_classdev_unregister(&mute_led_cdev);
 fail_led:
 	dell_cleanup_rfkill();
+fail_thermal:
+	thermal_cleanup();
 fail_rfkill:
 	platform_device_del(platform_device);
 fail_platform_device2:
@@ -2344,6 +2581,7 @@ static void __exit dell_exit(void)
 		platform_device_unregister(platform_device);
 		platform_driver_unregister(&platform_driver);
 	}
+	thermal_cleanup();
 }
 
 /* dell-rbtn.c driver export functions which will not work correctly (and could
diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
index e61bfaf8b5c4..40aa4469b38b 100644
--- a/drivers/platform/x86/dell/dell-smbios-base.c
+++ b/drivers/platform/x86/dell/dell-smbios-base.c
@@ -9,6 +9,7 @@
  *  Based on documentation in the libsmbios package:
  *  Copyright (C) 2005-2014 Dell Inc.
  */
+#include "linux/wmi.h"
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kernel.h>
@@ -71,6 +72,7 @@ static struct smbios_call call_blacklist[] = {
 	/* handled by kernel: dell-laptop */
 	{0x0000, CLASS_INFO, SELECT_RFKILL},
 	{0x0000, CLASS_KBD_BACKLIGHT, SELECT_KBD_BACKLIGHT},
+	{0x0000, CLASS_INFO, SELECT_THERMAL_MANAGEMENT},
 };
 
 struct token_range {
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


