Return-Path: <linux-kernel+bounces-143861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C40338A3E6A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 22:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44F31C20B48
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 20:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D5E54915;
	Sat, 13 Apr 2024 20:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="RaMxr38k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rZvXXyi3"
Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3416123BE;
	Sat, 13 Apr 2024 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713039692; cv=none; b=BevMIMG/PTGXiYI25YgSuiMMwvWSADnu82odJTzeVgtNgQKPxmmDOXvw9zU8uYMQD6dTLJI+Y4QvQ6mTP0sPnYcBavChcGkJXF6lmXKGd1BGelk2RoayGL//l2a7rhWs49fng9WmgMKRHV/d4f5f0+9HIllGClUH3DX0VnuXp2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713039692; c=relaxed/simple;
	bh=zAdtXVatRJXtfODpENwmf60lQdVBH44vsMoxw4Llvok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P1GVgJKCCkeSBGAVkrgbUiPZGG1uLYLesyTkYPozYVQNZnwHpBhrru7wW3UEdT+Yuf7jPcxP9R0+2h/djHeWbtga8CoDrPokMnSBdnbkYUbzrCtjDcMjN+Nr2xS/Qi7AaMTIdY0zgYSRUg4TLETcTDd5+uzB6YkPWTfdTgDXAj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=RaMxr38k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rZvXXyi3; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 889CA180009D;
	Sat, 13 Apr 2024 16:21:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 13 Apr 2024 16:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1713039683; x=1713126083; bh=fq+/IgHD56xmC4qkpsxEe
	ynTUfNdHkceCUnjS4UT8n8=; b=RaMxr38kvHAQXuvZH5AmgGBID/RIk0NBKXncv
	Hwe774igEmTGuCkdWtZ5h8Aji3FTVI+jCanJLMO+qg+leX9ExEXi5ubWo8telzsf
	FmO8XS1oW1Yp/s0QyzD9UOLRkiFybvY+Mrm5r0BgO2rnSrpWThsjCKCIhGObZ0BI
	y/2PqphKmwe9iMvJWpC73LXv3rZhOR+rcuTW0PDg75kOb27jCCykH2Y886tQsxhv
	h2aGA+CCNe0OsGhke1ovgBqgoRgA2RSL04YcDKDRa8z4Sa4LI6X0kySJ2dYKYkmM
	s09MPKf5OekwcJ/hS4dFqRaSrVDKwey6IWm6VcgLPe4m7r6MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713039683; x=1713126083; bh=fq+/IgHD56xmC4qkpsxEeynTUfNd
	HkceCUnjS4UT8n8=; b=rZvXXyi3KdHjf9o/uY7MtWTykh5BZIl5AqT9W8zXfLhd
	eeiqnKasuuyo5b5mOIC6xyF+aH82rQYHbyE9nd5wovEdSCs/BmQoWlVhRNaZwdad
	9bbSukUqKrzjlLsl4SevNOngrtaEvmxHEDYKILw6EVdGC6PyS7Ib53LT3pkvRWz5
	+pqp2LDsbm7pEoXiYt3Z3Hw4eZBS5FNt50O3ho2R1IaEuD4OVmWT6S7tzVu1FvRr
	lPWu1IN6MvVPtt6GQx45u3e5+cmx+z4jeQNd+gtLafR264IZxV9/ITM0H2Cpbwi/
	nfNrRsIuutEi8K4XFaqw09PiaRUGu7MU72wKDI4Uwg==
X-ME-Sender: <xms:Q-kaZm3U39qQhflagP5ZI6W0srmSQcdm2ZimjmlkEw4mS3LKK0iyfw>
    <xme:Q-kaZpF8mewhPc3FhSfcOsPqnHesP5-MARSJ4BubZnYh4BBuntG6uoQxUVcgm8bkQ
    Zg9n4kdc7rT-fakEbg>
X-ME-Received: <xmr:Q-kaZu6nUC4qd9UhrPisaCYluRzDY5RpFUGZuMoFp-iGvaqp5S8AH7ZKTKs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeiiedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpedfnfhukhgv
    ucffrdculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrth
    htvghrnhepgfdujedthfduudekffefkeeiffdttddvhfegudduueffuefhfefggeefteev
    vdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplh
    hukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:Q-kaZn3AgqfjMT8QMTxk8XcYdJAWdshtjgZ0zV0bXnuSLFppo4wxow>
    <xmx:Q-kaZpEHHOFbEZDYOL0egJ2-d0O8PS-l-6jit7H85u9UU21wq1Cvkg>
    <xmx:Q-kaZg8bTkC7Oz3Z6SzB1PLf8bUbrotH4Wo-V6MiWOClaRoDZt6mrw>
    <xmx:Q-kaZumQAvS9791HFa87dpYXLGbg8Ijv6f1_oIxxH8xsW1HiEaipqw>
    <xmx:Q-kaZu4uTx8lNUgS5GNXIR1CNcn_hsFL1gj16Xs7YYKQuDBdnQkmCGHm>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Apr 2024 16:21:19 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	mohamed.ghanmi@supcom.tn,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D . Jones" <luke@ljones.dev>
Subject: [PATCH] platform/x86: asus-wmi: add support for vivobook fan profiles
Date: Sun, 14 Apr 2024 08:21:12 +1200
Message-ID: <20240413202112.37729-1-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>

Add support for vivobook fan profiles wmi call on the ASUS VIVOBOOK
to adjust power limits.

These fan profiles have a different device id than the ROG series.
and different order. This reorders the existing modes and adds a new
full speed mode available on these laptops.

As part of keeping the patch clean the throttle_thermal_policy_available
boolean stored in the driver struct is removed and
throttle_thermal_policy_dev is used in place (as on init it is zeroed).

Signed-off-by: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
Co-developed-by: Luke D. Jones <luke@ljones.dev>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 100 +++++++++++----------
 include/linux/platform_data/x86/asus-wmi.h |   1 +
 2 files changed, 55 insertions(+), 46 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 2d2b4eca7fd8..439d330fb80b 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -97,6 +97,11 @@ module_param(fnlock_default, bool, 0444);
 #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST	1
 #define ASUS_THROTTLE_THERMAL_POLICY_SILENT	2
 
+#define ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO	0
+#define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO	2
+#define ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO		1
+#define ASUS_THROTTLE_THERMAL_POLICY_FULLSPEED		3
+
 #define USB_INTEL_XUSB2PR		0xD0
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
 
@@ -285,8 +290,8 @@ struct asus_wmi {
 	u32 kbd_rgb_dev;
 	bool kbd_rgb_state_available;
 
-	bool throttle_thermal_policy_available;
 	u8 throttle_thermal_policy_mode;
+	u32 throttle_thermal_policy_dev;
 
 	bool cpu_fan_curve_available;
 	bool gpu_fan_curve_available;
@@ -3153,7 +3158,7 @@ static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
 	int err, fan_idx;
 	u8 mode = 0;
 
-	if (asus->throttle_thermal_policy_available)
+	if (asus->throttle_thermal_policy_dev)
 		mode = asus->throttle_thermal_policy_mode;
 	/* DEVID_<C/G>PU_FAN_CURVE is switched for OVERBOOST vs SILENT */
 	if (mode == 2)
@@ -3360,7 +3365,7 @@ static ssize_t fan_curve_enable_store(struct device *dev,
 		 * For machines with throttle this is the only way to reset fans
 		 * to default mode of operation (does not erase curve data).
 		 */
-		if (asus->throttle_thermal_policy_available) {
+		if (asus->throttle_thermal_policy_dev) {
 			err = throttle_thermal_policy_write(asus);
 			if (err)
 				return err;
@@ -3577,8 +3582,8 @@ static const struct attribute_group asus_fan_curve_attr_group = {
 __ATTRIBUTE_GROUPS(asus_fan_curve_attr);
 
 /*
- * Must be initialised after throttle_thermal_policy_check_present() as
- * we check the status of throttle_thermal_policy_available during init.
+ * Must be initialised after throttle_thermal_policy_dev is set as
+ * we check the status of throttle_thermal_policy_dev during init.
  */
 static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
 {
@@ -3619,38 +3624,31 @@ static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
 }
 
 /* Throttle thermal policy ****************************************************/
-
-static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
-{
-	u32 result;
-	int err;
-
-	asus->throttle_thermal_policy_available = false;
-
-	err = asus_wmi_get_devstate(asus,
-				    ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
-				    &result);
-	if (err) {
-		if (err == -ENODEV)
-			return 0;
-		return err;
-	}
-
-	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
-		asus->throttle_thermal_policy_available = true;
-
-	return 0;
-}
-
 static int throttle_thermal_policy_write(struct asus_wmi *asus)
 {
-	int err;
-	u8 value;
+	u8 value = asus->throttle_thermal_policy_mode;
 	u32 retval;
+	bool vivo;
+	int err;
 
-	value = asus->throttle_thermal_policy_mode;
+	vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
+	if (vivo) {
+		switch (value) {
+		case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
+			value = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO;
+			break;
+		case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
+			value = ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO;
+			break;
+		case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
+			value = ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO;
+			break;
+		default:
+			break;
+		}
+	}
 
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
+	err = asus_wmi_set_devstate(asus->throttle_thermal_policy_dev,
 				    value, &retval);
 
 	sysfs_notify(&asus->platform_device->dev.kobj, NULL,
@@ -3680,7 +3678,7 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
 
 static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
 {
-	if (!asus->throttle_thermal_policy_available)
+	if (!asus->throttle_thermal_policy_dev)
 		return 0;
 
 	asus->throttle_thermal_policy_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
@@ -3690,9 +3688,14 @@ static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
 static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
 {
 	u8 new_mode = asus->throttle_thermal_policy_mode + 1;
+	bool vivo;
 	int err;
 
-	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
+	vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
+	if (!vivo && new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
+		new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
+
+	if (vivo && new_mode > ASUS_THROTTLE_THERMAL_POLICY_FULLSPEED)
 		new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
 
 	asus->throttle_thermal_policy_mode = new_mode;
@@ -3725,13 +3728,17 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 	u8 new_mode;
 	int result;
+	bool vivo;
 	int err;
 
 	result = kstrtou8(buf, 10, &new_mode);
 	if (result < 0)
 		return result;
 
-	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
+	vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
+	if (vivo && new_mode > ASUS_THROTTLE_THERMAL_POLICY_FULLSPEED)
+		return -EINVAL;
+	else if (!vivo && new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
 		return -EINVAL;
 
 	asus->throttle_thermal_policy_mode = new_mode;
@@ -3748,7 +3755,10 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 	return count;
 }
 
-// Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
+/*
+ * Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
+ * VIVOBOOK: 3 - fans full speed
+ */
 static DEVICE_ATTR_RW(throttle_thermal_policy);
 
 /* Platform profile ***********************************************************/
@@ -3814,7 +3824,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
 	 * Not an error if a component platform_profile relies on is unavailable
 	 * so early return, skipping the setup of platform_profile.
 	 */
-	if (!asus->throttle_thermal_policy_available)
+	if (!asus->throttle_thermal_policy_dev)
 		return 0;
 
 	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
@@ -4229,7 +4239,7 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 	if (code == NOTIFY_KBD_FBM || code == NOTIFY_KBD_TTP) {
 		if (asus->fan_boost_mode_available)
 			fan_boost_mode_switch_next(asus);
-		if (asus->throttle_thermal_policy_available)
+		if (asus->throttle_thermal_policy_dev)
 			throttle_thermal_policy_switch_next(asus);
 		return;
 
@@ -4401,7 +4411,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_fan_boost_mode.attr)
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
-		ok = asus->throttle_thermal_policy_available;
+		ok = asus->throttle_thermal_policy_dev != 0;
 	else if (attr == &dev_attr_ppt_pl2_sppt.attr)
 		devid = ASUS_WMI_DEVID_PPT_PL2_SPPT;
 	else if (attr == &dev_attr_ppt_pl1_spl.attr)
@@ -4693,16 +4703,15 @@ static int asus_wmi_add(struct platform_device *pdev)
 	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE2))
 		asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE2;
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY))
+		asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY;
+	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO))
+		asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
 
-	err = throttle_thermal_policy_check_present(asus);
-	if (err)
-		goto fail_throttle_thermal_policy;
-	else
-		throttle_thermal_policy_set_default(asus);
-
 	err = platform_profile_setup(asus);
 	if (err)
 		goto fail_platform_profile_setup;
@@ -4797,7 +4806,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_input:
 	asus_wmi_sysfs_exit(asus->platform_device);
 fail_sysfs:
-fail_throttle_thermal_policy:
 fail_custom_fan_curve:
 fail_platform_profile_setup:
 	if (asus->platform_profile_support)
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 3eb5cd6773ad..982a637744ec 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -64,6 +64,7 @@
 #define ASUS_WMI_DEVID_SCREENPAD_LIGHT	0x00050032
 #define ASUS_WMI_DEVID_FAN_BOOST_MODE	0x00110018
 #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
+#define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO 0x00110019
 
 /* Misc */
 #define ASUS_WMI_DEVID_PANEL_OD		0x00050019
-- 
2.44.0


