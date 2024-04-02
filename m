Return-Path: <linux-kernel+bounces-127295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81834894958
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E668CB22AD9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191FB13ADC;
	Tue,  2 Apr 2024 02:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="iysiQSDl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TJhtFYqM"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15EA1119B;
	Tue,  2 Apr 2024 02:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024785; cv=none; b=YJeRJQgxIY3xg2HtfhE9ynZ2cw/XOzzkRJC/ohomAhoi7LLcnW9ZUKz+iHdWPQ+ta9SClVMGY0NLVtEys3bIrozoGeaqL0MkDTHH/NqGt/DDfwmWUew6wI1AldMUm55OD6fg8aCKkt6FItJg6zGZfQ//CCcRILPJxufuTzwLLxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024785; c=relaxed/simple;
	bh=qSmsh9/IR3rOAqrNHFgQnDe/gM7dkXYBsU0kaq+U+2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtQL0wrfZXrLqYTO5HY8g+0nojqpwtYHMn2yqIYH+p5oERGaD03sOj9mbKcgbwplKw8okrLqgYbU7zo2bNw4jjget47KV3j40paGqCXSbm/IkbDMVIwYHIEWK8hDJ4Hqrtzi+4JNllbBCZgKGKkmGppQ2GaRd/RRRJ2xfsr85E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=iysiQSDl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TJhtFYqM; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id B3A7D1C000A6;
	Mon,  1 Apr 2024 22:26:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 01 Apr 2024 22:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1712024781; x=
	1712111181; bh=PWlttQ05zh32ghVePLcr881KF2PLwTz0eDgDhUTn+EM=; b=i
	ysiQSDloWLEXALkhjpmHK5zE3u5zd3Yvr/1pYxoC13y8QAcr9gzyUxUIeqnCjxTY
	0Kl7WfiE3I7UU5zuPVw6uXGgbu355AUJ1eJkBo8l6/UobYlR+AnHRwOQKmH9sAH5
	FXNtTahLUUHBZPDpS0gjrHAZXrwO6nnX/fW0XhA9MGTJUCJ0qjAtZYgg75vlc+Ii
	fGT68f1ksIHc3AW3fYVMi+jTTU73cqrY0qDj6t2vLnkZQs8nXiAhIn9v9MZDNGZG
	xIW60jDS2c1OyKQdOFZOK92z3KxtwEcy5A5FBQ9DLXvevSVQwnO/4tAGOAkrLuZU
	tBtf3+jH30v4bcFuwNTGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712024781; x=
	1712111181; bh=PWlttQ05zh32ghVePLcr881KF2PLwTz0eDgDhUTn+EM=; b=T
	JhtFYqMUxWSXzByx1MKryF/0WR27Rey9oxe1ATzoPwgzcbmBgiGFS4wUFw3H7YEF
	Lp+/pawgqtSPT3sh/QWwfmHKQ+9Q8ZX+AlKcNfZo5Vn/GDZ64nWGmw5gIanOo+79
	WMq95Dy4ILlgIQdgdEO8NG7S3bz8P9gCLuf0qFplZzHTaHmnspcp2+k0sf3HADJy
	FI/6oIq3ff5mdh33CyZrJ70BmZWHlzl8qztxq9VpEJ+sGqUPEjKrxx4iY5NStv1x
	lKDYufX2y5v8jS8Brd1uFmJ55tJNy/vzIleYDYGRnGOWFIB1nPetB+EWiNQxLzhi
	SqioRvMfLFTcSRCKhM+Tg==
X-ME-Sender: <xms:zWwLZsJQaUvprqxrvv4b-o7Hq7-QP3H-B-rsc6-0FPjhOtCkqxoycA>
    <xme:zWwLZsLKM7GPbg30piI4ZTrkSX2g917oJ83tzVaAkTf50T-gY7Z2BHiRIPIbtzEU3
    zzLqsZn_Uk7soF92Ng>
X-ME-Received: <xmr:zWwLZsv4bxn5T2MrhJ-OEyZJ8G7UHzuqRm02lC09xdZG-jp92CFzSuOQQg1s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:zWwLZpa8OhiE8kLd-G9fEFGLAireTN0ddZ6luYHiMlWHsrWS4yecKg>
    <xmx:zWwLZjbU_EDnwxxmIEqEsMwRaGAKZSiU0ZJp_xQzwTYbohoorewWog>
    <xmx:zWwLZlB7_ciJxbNBfR31sVHub1yDTQUe5u9gutrCR9m75qqhxzDgGg>
    <xmx:zWwLZpbyFNFlV24lA7cpjE4SemeYH4tWuU_itoEjJ0aTKhgHZCUt1g>
    <xmx:zWwLZoNqtPswrXy92Mx_KH0LuK_reFsKdIuEB-tucIQcme_sFeoYb-xTdPg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 22:26:18 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 1/9] platform/x86: asus-wmi: add support for 2024 ROG Mini-LED
Date: Tue,  2 Apr 2024 15:25:59 +1300
Message-ID: <20240402022607.34625-2-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402022607.34625-1-luke@ljones.dev>
References: <20240402022607.34625-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support the 2024 mini-led backlight and adjust the related functions
to select the relevant dev-id. Also add `available_mini_led_mode` to the
platform sysfs since the available mini-led levels can be different.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       |  8 ++
 drivers/platform/x86/asus-wmi.c               | 80 ++++++++++++++++---
 include/linux/platform_data/x86/asus-wmi.h    |  1 +
 3 files changed, 78 insertions(+), 11 deletions(-)

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
index 3f07bbf809ef..2330f02ff76f 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -288,7 +288,7 @@ struct asus_wmi {
 	bool battery_rsoc_available;
 
 	bool panel_overdrive_available;
-	bool mini_led_mode_available;
+	u32 mini_led_dev_id;
 
 	struct hotplug_slot hotplug_slot;
 	struct mutex hotplug_lock;
@@ -2108,13 +2108,30 @@ static ssize_t mini_led_mode_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
-	int result;
+	u32 value;
 
-	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MINI_LED_MODE);
-	if (result < 0)
-		return result;
+	asus_wmi_get_devstate(asus, asus->mini_led_dev_id, &value);
+	value = value & 0x03; // only 3 modes on 2024 version
 
-	return sysfs_emit(buf, "%d\n", result);
+	/* Remap the mode values to match previous generation mini-led.
+	 * Some BIOSes return -19 instead of 2, which is "mini-LED off", this
+	 * appears to be a  BIOS bug.
+	 */
+	if (asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2) {
+		switch (value) {
+		case 0:
+			value = 1;
+			break;
+		case 1:
+			value = 2;
+			break;
+		case 2:
+			value = 0;
+		}
+	} else if (value < 0) {
+		return value;
+	}
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t mini_led_mode_store(struct device *dev,
@@ -2130,11 +2147,28 @@ static ssize_t mini_led_mode_store(struct device *dev,
 	if (result)
 		return result;
 
-	if (mode > 1)
+	if (mode > 1 && asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE)
 		return -EINVAL;
+	if (mode > 2 && asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2)
+		return -EINVAL;
+	/*
+	 * Remap the mode values so expected behaviour is the same as the last
+	 * generation of mini-LED
+	 */
+	if (asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2) {
+		switch (mode) {
+		case 0:
+			mode = 2;
+			break;
+		case 1:
+			mode = 0;
+			break;
+		case 2:
+			mode = 1;
+		}
+	}
 
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_MINI_LED_MODE, mode, &result);
-
+	err = asus_wmi_set_devstate(asus->mini_led_dev_id, mode, &result);
 	if (err) {
 		pr_warn("Failed to set mini-LED: %d\n", err);
 		return err;
@@ -2151,6 +2185,23 @@ static ssize_t mini_led_mode_store(struct device *dev,
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
@@ -4139,6 +4190,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_nv_temp_target.attr,
 	&dev_attr_panel_od.attr,
 	&dev_attr_mini_led_mode.attr,
+	&dev_attr_available_mini_led_mode.attr,
 	NULL
 };
 
@@ -4191,7 +4243,9 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_panel_od.attr)
 		ok = asus->panel_overdrive_available;
 	else if (attr == &dev_attr_mini_led_mode.attr)
-		ok = asus->mini_led_mode_available;
+		ok = asus->mini_led_dev_id != 0;
+	else if (attr == &dev_attr_available_mini_led_mode.attr)
+		ok = asus->mini_led_dev_id != 0;
 
 	if (devid != -1)
 		ok = !(asus_wmi_get_devstate_simple(asus, devid) < 0);
@@ -4444,10 +4498,14 @@ static int asus_wmi_add(struct platform_device *pdev)
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


