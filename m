Return-Path: <linux-kernel+bounces-162716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347F78B5F73
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A571C213DE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADE08613E;
	Mon, 29 Apr 2024 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="GFO3OI21";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JpjOF11k"
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB218595F;
	Mon, 29 Apr 2024 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714409947; cv=none; b=rkLoS7Dbi/EeT0plk/RXJaX9yZ1LMKG1/oIjO7YuUxtfeaqXWEwNpx9t3jOFTlcsz6mbTydS36nM+L45Lbj5u7eh9PKpgfZngfh/3pDJ0t6vcjRUATCBGStDiNW6jXbCH1ToEauHRPz/NIRJQkx1Tw4eRWnFuTNlykIKGp/y5ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714409947; c=relaxed/simple;
	bh=o5ddzOwpsLMZDc6Yz9gyrYwwQLk13a/bHgJ9M8fGxj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArujtAAhvYd+lUn0vuSkywSkpWiZLh3hqnXVnB/1KeRvEMwZLLhYPBvM1d5rUVizE9V/Kg8aapIo4qCvYsXq7b/wH0dkAImJAdiany/VLOUwkzzdFjcchG+KZPtli21GwBUiPHIvQYeqIpelLc3uT7edrWdb13xL7aKW+F9E3n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=GFO3OI21; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JpjOF11k; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 2C4691C000FC;
	Mon, 29 Apr 2024 12:59:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 29 Apr 2024 12:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1714409942; x=
	1714496342; bh=JgK/Kt4hl32qAVMHSJkvz/7NFmIpCjXK8EzE4Y8Nejo=; b=G
	FO3OI219ipM4uwgFifA59+FiSFHNIXSIq8f5vkih7S/dCI0mz8t2/3AMP+urFiSI
	E4wVyLfb+lwbeJeVLQ79IC5UH357ZjwdmQ2G/3WGEZhidBE8Ulo+/WeTAtrJriFk
	8dgOpk1ryjH6qgEho2fSCMScu/b8Sks3JPGEMWqMqWj3i2nqDJFd9VF7+BQ9N62W
	0abv1J9eVvrj7LYPZqyX8myj1Q9Fq/DjQLD4YOtvWkDK1k8pHB8Vtj2Sc2BZ+/yK
	c0GDLDC0+SG72Ksr+LKVY0dMei3iViNvBS5+Ni49cPrHE9dWZ71VEhJEPjPbX7HQ
	ezH6fMtn6CaFXfvW8ssXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714409942; x=
	1714496342; bh=JgK/Kt4hl32qAVMHSJkvz/7NFmIpCjXK8EzE4Y8Nejo=; b=J
	pjOF11kN25K4cFOBAnettDQkgLAw9th0yOgfqVVBS8Kzs4lWj5UBG+6+PpljKfQo
	RAQlaLlWJwjP6tcIucbbm3xpATC5HL2iWw3s7rHvRK2QeqTdD/28YNmB7vk+Pk0C
	SYZ9MxzTGdhVuxIQifqogu6yZALRz2HZ8kudDn0PJtHr4STFk6onVoRqavdp+P7/
	R/RumHV9vaRxEs2vj8nSAGTYLTCpQphqCYDV7sp1xjfuDU+D8hzrxEprWgAhSD+H
	pMgP4JXdLmy/MUT/ety6xR3/zvEmrHFtv8bRPj7kOEwrkPS7/ezyn53jhwIm+hhO
	4jJzIsx0FghJ+6TZtQU/Q==
X-ME-Sender: <xms:1dEvZn9eF_sVRm3nOZOIwukLmtcSQ45uuRCtorrDFxVOO2KPpoOiVg>
    <xme:1dEvZjty425uDhH3cO0HPTAsIL2nd3ZYvu3cp_RgTbndKlElpM3HdiqtcHrpfZkSS
    mJ09K83DloVqErrpXA>
X-ME-Received: <xmr:1dEvZlD9PP_ZlCV9x2Sf2Lk4zcmbtUdk34G4aEiJpuB1MgcDwGnM3L4AOFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduuddguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogetfedtuddqtdduucdludehmdenucfjughrpefhvfevufffkffojghfggfgsedtkeer
    tdertddtnecuhfhrohhmpefnhihnughonhcuufgrnhgthhgvuceolhhsrghntghhvgeslh
    ihnhguvghnohdrtggrqeenucggtffrrghtthgvrhhnpeelhfeiffektdeludfgtefggeef
    hefhtefhhfffueevhfdtkedvieekheeljeeiteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehlshgrnhgthhgvsehlhihnuggvnhhordgtrg
X-ME-Proxy: <xmx:1dEvZjcnMaOEJj3eRAeKPjQxw1BDbGU7vYdaWKXQ3abdyr97dA_j-g>
    <xmx:1tEvZsPgILq07eqXXjhlceNtvQlYBtFTLN-D89Ads8V098i7nivgJg>
    <xmx:1tEvZlmBmZihy69807Efpl7w490bWIXKbDiUUvZiF9R2GPsMUTGbgQ>
    <xmx:1tEvZmuaO8LAg9yYONg3YfopDO1P0SjKNs0b1V_6_p6JclnhZrM2Kg>
    <xmx:1tEvZlmc5izdTvMmGj5xjkciQL7Og1znkeeGWRYrLjXovq-Xo43lX5Lu>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 12:59:00 -0400 (EDT)
From: Lyndon Sanche <lsanche@lyndeno.ca>
To: lsanche@lyndeno.ca
Cc: mario.limonciello@amd.com,
	pali@kernel.org,
	W_Armin@gmx.de,
	srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: [PATCH v3] platform/x86: dell-laptop: Implement platform_profile
Date: Mon, 29 Apr 2024 10:48:26 -0600
Message-ID: <20240429164844.7544-2-lsanche@lyndeno.ca>
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
 drivers/platform/x86/dell/dell-laptop.c | 232 ++++++++++++++++++++++++
 drivers/platform/x86/dell/dell-smbios.h |   1 +
 2 files changed, 233 insertions(+)

diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
index 42f7de2b4522..fa58e7751d06 100644
--- a/drivers/platform/x86/dell/dell-laptop.c
+++ b/drivers/platform/x86/dell/dell-laptop.c
@@ -27,6 +27,8 @@
 #include <linux/i8042.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/platform_profile.h>
+#include <linux/bitfield.h>
 #include <acpi/video.h>
 #include "dell-rbtn.h"
 #include "dell-smbios.h"
@@ -95,6 +97,7 @@ static struct backlight_device *dell_backlight_device;
 static struct rfkill *wifi_rfkill;
 static struct rfkill *bluetooth_rfkill;
 static struct rfkill *wwan_rfkill;
+static struct platform_profile_handler *thermal_handler;
 static bool force_rfkill;
 static bool micmute_led_registered;
 static bool mute_led_registered;
@@ -2199,6 +2202,227 @@ static int mute_led_set(struct led_classdev *led_cdev,
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
+#define DELL_ACC_GET_FIELD GENMASK(19, 16)
+#define DELL_ACC_SET_FIELD GENMASK(11, 8)
+#define DELL_THERMAL_SUPPORTED GENMASK(3, 0)
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
+	if (ret || !supported_modes)
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
+	// Clean up but do not fail
+	if (platform_profile_register(thermal_handler))
+		kfree(thermal_handler);
+
+	return 0;
+}
+
+void thermal_cleanup(void)
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
@@ -2238,6 +2462,11 @@ static int __init dell_init(void)
 		goto fail_rfkill;
 	}
 
+	// Do not fail module if thermal modes not supported, just skip
+	ret = thermal_init();
+	if (ret)
+		goto fail_thermal;
+
 	if (quirks && quirks->touchpad_led)
 		touchpad_led_init(&platform_device->dev);
 
@@ -2317,6 +2546,8 @@ static int __init dell_init(void)
 		led_classdev_unregister(&mute_led_cdev);
 fail_led:
 	dell_cleanup_rfkill();
+fail_thermal:
+	thermal_cleanup();
 fail_rfkill:
 	platform_device_del(platform_device);
 fail_platform_device2:
@@ -2344,6 +2575,7 @@ static void __exit dell_exit(void)
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


