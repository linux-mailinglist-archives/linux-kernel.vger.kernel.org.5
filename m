Return-Path: <linux-kernel+bounces-116557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BC488A0AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D26E2947B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003B715FD11;
	Mon, 25 Mar 2024 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="BKJyUdA9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cx3bKixn"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2441487F4;
	Mon, 25 Mar 2024 05:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711345813; cv=none; b=q8DpVZd5mgIISx9CtE7ZlzO3rd+R41ecXFldbVYJzwui8A61IkDuv6I4FiYIXSixrqfuY82PiX/Z0obvtLorRjWYEVFm6gAEy6936Kz3JmMcBrQc4EFmy6g3xG3L6C+AgcfKtjHm7pj9Pq/KX5EhW1KhGdPuRA2W3dc0mrJrG+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711345813; c=relaxed/simple;
	bh=4jL1KWXjYiXny0h+Nb8iTu6zptXy96mU9So4SIu2+78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJBmcbc4KAe37fQU26ZGj4xDwqMn8Pm0mSVe7QZjR0TGbVk7z8JnTurk4w4CYWsCm4fRLiedncIp3gkU0LPLQNoh4xkRaplwrllRJQsSwNj1cxffftZmf8t+v/dwNGXMXFJS5CJb+YwJW+SX7IODo+jxsHaeZH4AFWm39SjWpgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=BKJyUdA9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cx3bKixn; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9C7C313800F3;
	Mon, 25 Mar 2024 01:50:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 25 Mar 2024 01:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1711345810; x=
	1711432210; bh=0Bh+6YXJNCLRuMqGyD0SersId0d+g+aFk1/fEt3iF3I=; b=B
	KJyUdA9Fky93RqSejG38eS4pz5NRQhjJcZYszN4RHsU5/Elns7iedbvCuNH49hxu
	mL9+nEedahi3EBZbLXaplV2JVok6zF5fehCZPjGfSjnmyygIPfsem2hCMlc1Ots0
	ZwmY5ZmdE5qOUGYD3phDsLF3WuGeCkoj46hEls7aH3Ve/pDmo86vfOJeXgrPFifZ
	owB+noqh6R57SksWACHGnEPnDJU5cYzIPOgPPOMS/kbxzTDZqTNk9t57E0L/Z4q8
	qZ1W++rzpzvr4KZCMaYNjag6v/Loo0SRxeZT8Yhuz2FtTqUK7tRfCkBNssnPtj83
	chBvMA6pq2q2C1uNczEQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711345810; x=
	1711432210; bh=0Bh+6YXJNCLRuMqGyD0SersId0d+g+aFk1/fEt3iF3I=; b=C
	x3bKixnkaveIUB0fbqzayQ+IS5r93S+ef1c2L1TG70xFXj5hWYgep6qtHwWmj0d9
	KlV3p8GG3Ww2IARz0lRL4kVSweCm9Cy144DVSi6z90Qo1TYrbcpaiIwPBikJMyVt
	pheXay9ouw+Io8afRSotLzuZ445ruB4Le0lqDEGjQcEMI2SAVnHMDBfxvcH4b2Mu
	Fw+DOmZFx7wAn4oweT0aHu5ONSfkcE8KtNIDKnBGp5MMvZghhMVhvhkiNRZAEDOg
	lf39KyGGPYw6IJMtxgwPYKdr3lrSDruq72Yoq8oj3WNzyZqyVmXEqsQbiKo7cNS5
	bmOXOKnJDLtE96d43J3CA==
X-ME-Sender: <xms:khABZrFKdmIfRH_g7zpFsKq92QS6xNU1av-6J6l4HY3mJ0BMA0qefA>
    <xme:khABZoXvmtS71jh6EASDTgJn3rE8blrXe9PJWZEyGNU54JqnAq1aPzsaQ_fv-vCRB
    qa2zi1QMeFOs4u08WY>
X-ME-Received: <xmr:khABZtLRJdUFH1KrNvwCtvbXPFDTIzPO_OOfqrvWLms-d5QRWPmKRKkUS2pB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtkedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:khABZpFuGIq4Esq02oIi2apuvDnz4IGDBKa3UnD75cqoybBQCk8vWg>
    <xmx:khABZhUerafxdBKMHYrV8O5tL4nhhPh-4ep4RCWMWcx-6mY_0xtXrA>
    <xmx:khABZkNJ_1-6Eu7vlh_qAnXuq4h-vJy52oL5X-OmAL1hKqSQ_QwElg>
    <xmx:khABZg315VGtzopLvYGOm7w5MQKqKrzEiFzEkYR6DuzVkjefBXaQsQ>
    <xmx:khABZjK-P9BagwWHK0FEx1uHAQ2vcBIKLQgKw281Si7R6mYCnFIvmg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 01:50:07 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 1/9] platform/x86: asus-wmi: add support for 2024 ROG Mini-LED
Date: Mon, 25 Mar 2024 18:49:30 +1300
Message-ID: <20240325054938.489732-2-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325054938.489732-1-luke@ljones.dev>
References: <20240325054938.489732-1-luke@ljones.dev>
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
 drivers/platform/x86/asus-wmi.c               | 74 +++++++++++++++++--
 include/linux/platform_data/x86/asus-wmi.h    |  1 +
 3 files changed, 76 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 8a7e25bde085..61a745d2476f 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -126,6 +126,14 @@ Description:
 		Change the mini-LED mode:
 			* 0 - Single-zone,
 			* 1 - Multi-zone
+			* 2 - Multi-zone strong (available on newer generation mini-led)
+
+What:		/sys/devices/platform/<platform>/available_mini_led_mode
+Date:		Jun 2023
+KernelVersion:	6.10
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		List the available mini-led modes.
 
 What:		/sys/devices/platform/<platform>/ppt_pl1_spl
 Date:		Jun 2023
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 18be35fdb381..54ce0fb26f42 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -297,6 +297,7 @@ struct asus_wmi {
 
 	bool panel_overdrive_available;
 	bool mini_led_mode_available;
+	u32 mini_led_dev_id;
 
 	struct hotplug_slot hotplug_slot;
 	struct mutex hotplug_lock;
@@ -2109,10 +2110,27 @@ static ssize_t mini_led_mode_show(struct device *dev,
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result;
 
-	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MINI_LED_MODE);
-	if (result < 0)
-		return result;
+	result = asus_wmi_get_devstate_simple(asus, asus->mini_led_dev_id);
 
+	/* Remap the mode values to match previous generation mini-led.
+	 * Some BIOSes return -19 instead of 2, which is "mini-LED off", this
+	 * appears to be a  BIOS bug.
+	 */
+	if (asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2) {
+		switch (result) {
+		case 0:
+			result = 1;
+			break;
+		case 1:
+			result = 2;
+			break;
+		case 2:
+		case -19:
+			result = 0;
+		}
+	} else if (result < 0) {
+		return result;
+	}
 	return sysfs_emit(buf, "%d\n", result);
 }
 
@@ -2129,11 +2147,28 @@ static ssize_t mini_led_mode_store(struct device *dev,
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
@@ -2150,6 +2185,23 @@ static ssize_t mini_led_mode_store(struct device *dev,
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
@@ -4174,6 +4226,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_nv_temp_target.attr,
 	&dev_attr_panel_od.attr,
 	&dev_attr_mini_led_mode.attr,
+	&dev_attr_available_mini_led_mode.attr,
 	NULL
 };
 
@@ -4496,10 +4549,17 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->nv_dyn_boost_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_NV_DYN_BOOST);
 	asus->nv_temp_tgt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_NV_THERM_TARGET);
 	asus->panel_overdrive_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PANEL_OD);
-	asus->mini_led_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE);
 	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
 						&& dmi_match(DMI_BOARD_NAME, "RC71L");
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE)) {
+		asus->mini_led_mode_available = true;
+		asus->mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE;
+	} else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE2)) {
+		asus->mini_led_mode_available = true;
+		asus->mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE2;
+	}
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


