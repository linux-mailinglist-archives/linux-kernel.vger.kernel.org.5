Return-Path: <linux-kernel+bounces-130765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EF0897CDE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD9CCB26EF4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D833FF4;
	Thu,  4 Apr 2024 00:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="dTXx46zN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="REkoCeqA"
Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEF31391;
	Thu,  4 Apr 2024 00:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712189832; cv=none; b=iya4q4sG6wwya+jQNA3vUkoS690hbY4PpdGZ5MiFoyKxSnSQLt62Rq/6QFCG28eQZIBscxBdKdRHiiaIzUTUshWoIn4dEEgt+BU7EXrORQYKK1zrrXgLm/Vl08S93nAvEKFg7YaK5YuGQ8ho/nLvkOSLRIchPlbkApjdDOzMYOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712189832; c=relaxed/simple;
	bh=4CdxyI36NoYF3ibohNO2SZBa2ORShXjHwJVRoQLrb9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uK8sqQGukALVwTVRJiK7w5rGdDkN7I/mjaH64QtPk9jTPCd1T5Se5BgaweYgdcKiTDuIIprj33adYe6A1+RpBS8PfGadf84Z04ZH8uPkm5miTkkomE9bPWdxN7d+Ipp80pE9WA5/xQ54aF7fNRA6WQicQiRNxY5s4dzGae3Nk0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=dTXx46zN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=REkoCeqA; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 178761C00101;
	Wed,  3 Apr 2024 20:17:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 03 Apr 2024 20:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1712189827;
	 x=1712276227; bh=YKGAXGmzJ7M8+Kbnl7Jzla5MWweHM6jjVjw3PA3ZJQ4=; b=
	dTXx46zN/1RoiSpQH5q6RaNnnBnlYcCkIdtPVi+t8AS+Hnnb2c5Uflh7X6bkRJUG
	OfllAxGZuo4DyIkMfrXpBeHyGq6ijS/UwwzqG396q79EHkiapehmY7TYVqiYFJOt
	jrRnZQbSkN1A5kWrf5758/EKiiPnVU0zfz5A2NrZDU5TuiJtt2E/RwWyX0nHS5Og
	2OfTYn54ktozFQqo/4N4Bht3tV7TaaBVa9LnZ7BFfJVNq7Q6FWOnDsJgj7VkFDyS
	0PZwUFw3dcf5/GIH6zvYSI2qpniGa87JlvqUFC6uEplC41PdOOb+rBWh/Shzt4KS
	ImGkTF77PBBlUczjjbVfcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712189827; x=
	1712276227; bh=YKGAXGmzJ7M8+Kbnl7Jzla5MWweHM6jjVjw3PA3ZJQ4=; b=R
	EkoCeqAUrAbprYfhqEWRsqwEt/zNKJNoOWdaJCtjC19ntoVFrbP7ZzbZz79rKItQ
	goxnDgMuIsR9/t3UU2Vx7IVODNbxQwgyCKiO9m+M+IeOpVIx3ITx77bFEx63oE60
	a7AMxgFsYfEB335TMQ00c612R9DSaTnJygvGDlJeqHc/VqVtHgkb8TBb7yn7LE2V
	bzFsqVDkbXkLjEFhTKyYjx3NhoyVVfqyAznsXJYsLX/9ajW0CVnOaKHkJR+bs7vc
	9RNf++RVc+Xwt1CMntpmaDsnJD9kym6dtVpmoW5J9M3d0fBQZWO/7sgOOGwjq1Js
	dAWNEEMo6+AqsudSn4KLw==
X-ME-Sender: <xms:g_ENZh3vrKgVvV2ixtNiXmmvnLSqFpQc9Way8A5da1TKb8RU_vZGIQ>
    <xme:g_ENZoH5Jw0ZYkT8E2m5X3JVxVqT3bBRKSM2CMMpiAU9Cp9PIzZiVHuOB9GL4tFM-
    4HI3uQH1MPC02lBK1w>
X-ME-Received: <xmr:g_ENZh56e1zN3_FeURadGq85yMWQCn4yBfMfGtdIOcMQUC9eAdMPg5QTDlv1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvges
    lhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpeduudetudehiedvvdevveelhf
    egkeefffdvfeetuefgveefgffgffeiffeitdelieenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:g_ENZu1e1SxKmoPzZoNSwwU-L5J5-J-fw7z0gAwMKXRo9rSP8ppWfQ>
    <xmx:g_ENZkEd4g4RmvNMdMWuYL5nh8GjZ8ob12ReCRFmf2FzhZbooZoB1Q>
    <xmx:g_ENZv92YVPzKnY5IdOxioJzxSY62AfgLHXtLKEJ4fzMWaFs5Fs_hg>
    <xmx:g_ENZhlWGlnVXVrVmAq_10GDvOpjzeKAsTyYnjf8OMCkevOhBE-LnA>
    <xmx:g_ENZp5VWBLdaXeshBhxW3ZJu8MOiaWfnjiMpPeuwqo3a91Hjqgk9BUI>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 20:17:04 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v4 1/9] platform/x86: asus-wmi: add support for 2024 ROG Mini-LED
Date: Thu,  4 Apr 2024 13:16:44 +1300
Message-ID: <20240404001652.86207-2-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404001652.86207-1-luke@ljones.dev>
References: <20240404001652.86207-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Support the 2024 mini-led backlight and adjust the related functions
to select the relevant dev-id. Also add `available_mini_led_mode` to the
platform sysfs since the available mini-led levels can be different.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       |  8 ++
 drivers/platform/x86/asus-wmi.c               | 96 +++++++++++++++++--
 include/linux/platform_data/x86/asus-wmi.h    |  1 +
 3 files changed, 95 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 8a7e25bde085..ef1ac1a20a71 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -126,6 +126,14 @@ Description:
 		Change the mini-LED mode:
 			* 0 - Single-zone,
 			* 1 - Multi-zone
+			* 2 - Multi-zone strong (available on newer generation mini-led)
+
+What:		/sys/devices/platform/<platform>/available_mini_led_mode
+Date:		Apr 2024
+KernelVersion:	6.10
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		List the available mini-led modes.
 
 What:		/sys/devices/platform/<platform>/ppt_pl1_spl
 Date:		Jun 2023
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 3f07bbf809ef..aa2a3b402e33 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -126,6 +126,17 @@ module_param(fnlock_default, bool, 0444);
 #define ASUS_SCREENPAD_BRIGHT_MAX 255
 #define ASUS_SCREENPAD_BRIGHT_DEFAULT 60
 
+#define ASUS_MINI_LED_MODE_MASK		0x03
+/* Standard modes for devices with only on/off */
+#define ASUS_MINI_LED_OFF		0x00
+#define ASUS_MINI_LED_ON		0x01
+/* New mode on some devices, define here to clarify remapping later */
+#define ASUS_MINI_LED_STRONG_MODE	0x02
+/* New modes for devices with 3 mini-led mode types */
+#define ASUS_MINI_LED_2024_WEAK		0x00
+#define ASUS_MINI_LED_2024_STRONG	0x01
+#define ASUS_MINI_LED_2024_OFF		0x02
+
 /* Controls the power state of the USB0 hub on ROG Ally which input is on */
 #define ASUS_USB0_PWR_EC0_CSEE "\\_SB.PCI0.SBRG.EC0.CSEE"
 /* 300ms so far seems to produce a reliable result on AC and battery */
@@ -288,7 +299,7 @@ struct asus_wmi {
 	bool battery_rsoc_available;
 
 	bool panel_overdrive_available;
-	bool mini_led_mode_available;
+	u32 mini_led_dev_id;
 
 	struct hotplug_slot hotplug_slot;
 	struct mutex hotplug_lock;
@@ -2108,13 +2119,33 @@ static ssize_t mini_led_mode_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
-	int result;
+	u32 value;
+	int err;
 
-	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MINI_LED_MODE);
-	if (result < 0)
-		return result;
+	err = asus_wmi_get_devstate(asus, asus->mini_led_dev_id, &value);
+	if (err < 0)
+		return err;
+	value = value & ASUS_MINI_LED_MODE_MASK;
 
-	return sysfs_emit(buf, "%d\n", result);
+	/*
+	 * Remap the mode values to match previous generation mini-led. The last gen
+	 * WMI 0 == off, while on this version WMI 2 ==off (flipped).
+	 */
+	if (asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2) {
+		switch (value) {
+		case ASUS_MINI_LED_2024_WEAK:
+			value = ASUS_MINI_LED_ON;
+			break;
+		case ASUS_MINI_LED_2024_STRONG:
+			value = ASUS_MINI_LED_STRONG_MODE;
+			break;
+		case ASUS_MINI_LED_2024_OFF:
+			value = ASUS_MINI_LED_OFF;
+			break;
+		}
+	}
+
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t mini_led_mode_store(struct device *dev,
@@ -2130,11 +2161,32 @@ static ssize_t mini_led_mode_store(struct device *dev,
 	if (result)
 		return result;
 
-	if (mode > 1)
+	if (asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE &&
+		mode > ASUS_MINI_LED_ON)
+		return -EINVAL;
+	if (asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2 &&
+		mode > ASUS_MINI_LED_STRONG_MODE)
 		return -EINVAL;
 
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_MINI_LED_MODE, mode, &result);
+	/*
+	 * Remap the mode values so expected behaviour is the same as the last
+	 * generation of mini-LED with 0 == off, 1 == on.
+	 */
+	if (asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2) {
+		switch (mode) {
+		case ASUS_MINI_LED_OFF:
+			mode = ASUS_MINI_LED_2024_OFF;
+			break;
+		case ASUS_MINI_LED_ON:
+			mode = ASUS_MINI_LED_2024_WEAK;
+			break;
+		case ASUS_MINI_LED_STRONG_MODE:
+			mode = ASUS_MINI_LED_2024_STRONG;
+			break;
+		}
+	}
 
+	err = asus_wmi_set_devstate(asus->mini_led_dev_id, mode, &result);
 	if (err) {
 		pr_warn("Failed to set mini-LED: %d\n", err);
 		return err;
@@ -2151,6 +2203,23 @@ static ssize_t mini_led_mode_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(mini_led_mode);
 
+static ssize_t available_mini_led_mode_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	switch (asus->mini_led_dev_id) {
+	case ASUS_WMI_DEVID_MINI_LED_MODE:
+		return sysfs_emit(buf, "0 1\n");
+	case ASUS_WMI_DEVID_MINI_LED_MODE2:
+		return sysfs_emit(buf, "0 1 2\n");
+	}
+
+	return sysfs_emit(buf, "0\n");
+}
+
+static DEVICE_ATTR_RO(available_mini_led_mode);
+
 /* Quirks *********************************************************************/
 
 static void asus_wmi_set_xusb2pr(struct asus_wmi *asus)
@@ -4139,6 +4208,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_nv_temp_target.attr,
 	&dev_attr_panel_od.attr,
 	&dev_attr_mini_led_mode.attr,
+	&dev_attr_available_mini_led_mode.attr,
 	NULL
 };
 
@@ -4191,7 +4261,9 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_panel_od.attr)
 		ok = asus->panel_overdrive_available;
 	else if (attr == &dev_attr_mini_led_mode.attr)
-		ok = asus->mini_led_mode_available;
+		ok = asus->mini_led_dev_id != 0;
+	else if (attr == &dev_attr_available_mini_led_mode.attr)
+		ok = asus->mini_led_dev_id != 0;
 
 	if (devid != -1)
 		ok = !(asus_wmi_get_devstate_simple(asus, devid) < 0);
@@ -4444,10 +4516,14 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->nv_dyn_boost_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_NV_DYN_BOOST);
 	asus->nv_temp_tgt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_NV_THERM_TARGET);
 	asus->panel_overdrive_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PANEL_OD);
-	asus->mini_led_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE);
 	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
 						&& dmi_match(DMI_BOARD_NAME, "RC71L");
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE))
+		asus->mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE;
+	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE2))
+		asus->mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE2;
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index ab1c7deff118..9cadce10ad9a 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -71,6 +71,7 @@
 #define ASUS_WMI_DEVID_LID_FLIP		0x00060062
 #define ASUS_WMI_DEVID_LID_FLIP_ROG	0x00060077
 #define ASUS_WMI_DEVID_MINI_LED_MODE	0x0005001E
+#define ASUS_WMI_DEVID_MINI_LED_MODE2	0x0005002E
 
 /* Storage */
 #define ASUS_WMI_DEVID_CARDREADER	0x00080013
-- 
2.44.0


