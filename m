Return-Path: <linux-kernel+bounces-128874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD662896161
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74246289469
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F50CA4E;
	Wed,  3 Apr 2024 00:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="wIJXRJoC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IqvsUE6Z"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9830F46BA;
	Wed,  3 Apr 2024 00:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712104173; cv=none; b=XDT2NAdJQ1a7KLvFFgwfQHjpmzZVCB95htFdpvGIKNzPEjMzstKT8dYleBwpcop/1hDxVL9x8NLImbA1HRugDe7uR1RZSwXPa6IUDAe39wDcZppI4vKCiua1B+w6D8vLAHZKr8ENvW2RG3IHq8loGpRTknmkHQLZiG0ZpBuZ6z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712104173; c=relaxed/simple;
	bh=e0k9J/MM1+U2kUahxPM9dv3uvIxGsbiWzykNjAHeu1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DP1Qap6RTnC3S6PPqKwRM9Zj1ddw/waNEN8bjpOqEXeUe6eWY2d6e+wnvLaun2EX8hULx7syyyvVF/2Ery9cnZIV1KJi5gp1T+6k5lurowtiZT2xWgQOE/sQ/d4/fgvFJ22rVPsK+wywzAPloomoZwF/LwpTc8g3K/3zrpAJdWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=wIJXRJoC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IqvsUE6Z; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id A83B613800CF;
	Tue,  2 Apr 2024 20:29:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 02 Apr 2024 20:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1712104170; x=
	1712190570; bh=E8dn53vhhorz7U2nBrV/MbaHN4fcVu1avvy6C1XYjvU=; b=w
	IJXRJoCF3AK1zt03pA04YsrQr69OQOH3cBQTPfLZhNWskwo3/tnkhqgcHm7qE0e7
	cRU9M1EMW562ML4wI/hc31c6RXAQCWuzmXWMx9P6yRy1p9XuScH7Qi1jMyM00anm
	kKLCnmlqMaZ3IhprQ7OaABspsHVjLeu1KznEXU+EzLhL1ZpQEpYB+uCxagoiEMbO
	3R/jmAGvG0oLPJSHjy5LwTXxmawn+0mSnPghiPAljSahfXek/3BvAYQwt1kOxyaL
	U8qdo6n2E4bjktKGC8VftQ7y4u2LGl/i1j9TGqzqBjsM934TFVMGZbbysoIKlyXe
	WIb1TPp5teiNPFFHfrHYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712104170; x=
	1712190570; bh=E8dn53vhhorz7U2nBrV/MbaHN4fcVu1avvy6C1XYjvU=; b=I
	qvsUE6ZfWfhmEl/2/xr+Bx6eSxiT8/gdju5IA9xqRNrydLGbhjur1dH8j/Nc94zZ
	M+ZDn0DWiqLwjectppS3DYETyj26/r5xsgirQaEci6+EwzMZwSoZWT1fMmSKIABl
	4IgrpiYSHcuJYu4ZiYyouhpdrxwQ2H+oRZNviCAQN09Mubau/W6+VYPf32h7AOl8
	1BAZ4A87JDwoK5p6oK4BEX40c5fwcdIYKhEid7TKOtTP5jwEYxHj8s/YdJ5kj9Na
	HSafbNDzAGCej9SKHl0BLO3QQJA7RDC4l3Da4A8C2dl1kZ08aVKMo779fAZreNhK
	VieUOACCBdtvd31mqWklw==
X-ME-Sender: <xms:6qIMZlCsVFpZ8DclO7wxIHAh1ApbOm6VJL82xxFbLSVxR8cPKchKMQ>
    <xme:6qIMZjhakwqNGadfzu_aHaKpwkNUCeh9oUMNsKeV_Y7o8PyNwV4mpyDQQfIDAHrgS
    yZbYRqpzurIpS6GHks>
X-ME-Received: <xmr:6qIMZgkSzJa8tKJGPrD_SsaLaX992usSHyWdbzugIkJDiITfsQOzh7zvVxPh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:6qIMZvwvR0AfRQuMQw_HcgXS7_ILlQOPbFowbWelQVwF5d97s9k6eA>
    <xmx:6qIMZqSa_1MKH_uGXa4sBFYCpDHFDsazSx_yRWCwN7QJ7I2LJPVzIQ>
    <xmx:6qIMZibM2rDd_p7CXGAm-5-ewiz8GO2asigpf0WDvjhxUW6Xmsl45Q>
    <xmx:6qIMZrShOHrZ8F2YZ_3IBU7kr0oBnyNtmf3QR2jdEgky8BRDSn9C-Q>
    <xmx:6qIMZpHFhVhI8yrcKpwgoyOZNRAr5_FRMANce-P-QaawHWaEj7WH5wXZ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 20:29:27 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 1/9] platform/x86: asus-wmi: add support for 2024 ROG Mini-LED
Date: Wed,  3 Apr 2024 13:29:09 +1300
Message-ID: <20240403002917.2870959-2-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403002917.2870959-1-luke@ljones.dev>
References: <20240403002917.2870959-1-luke@ljones.dev>
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

signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       |  8 ++
 drivers/platform/x86/asus-wmi.c               | 94 +++++++++++++++++--
 include/linux/platform_data/x86/asus-wmi.h    |  1 +
 3 files changed, 93 insertions(+), 10 deletions(-)

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
index 3f07bbf809ef..588c099103de 100644
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
+	int err;
+	u32 value;
 
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
@@ -2130,11 +2161,30 @@ static ssize_t mini_led_mode_store(struct device *dev,
 	if (result)
 		return result;
 
-	if (mode > 1)
+	if (mode > 1 && asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE)
+		return -EINVAL;
+	if (mode > 2 && asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2)
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
@@ -2151,6 +2201,23 @@ static ssize_t mini_led_mode_store(struct device *dev,
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
@@ -4139,6 +4206,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_nv_temp_target.attr,
 	&dev_attr_panel_od.attr,
 	&dev_attr_mini_led_mode.attr,
+	&dev_attr_available_mini_led_mode.attr,
 	NULL
 };
 
@@ -4191,7 +4259,9 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_panel_od.attr)
 		ok = asus->panel_overdrive_available;
 	else if (attr == &dev_attr_mini_led_mode.attr)
-		ok = asus->mini_led_mode_available;
+		ok = asus->mini_led_dev_id != 0;
+	else if (attr == &dev_attr_available_mini_led_mode.attr)
+		ok = asus->mini_led_dev_id != 0;
 
 	if (devid != -1)
 		ok = !(asus_wmi_get_devstate_simple(asus, devid) < 0);
@@ -4444,10 +4514,14 @@ static int asus_wmi_add(struct platform_device *pdev)
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


