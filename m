Return-Path: <linux-kernel+bounces-98099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C6B877525
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 03:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74881F213A5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 02:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C971381;
	Sun, 10 Mar 2024 02:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="j8wV+0Xi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LpSfTKK5"
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800A7EC5;
	Sun, 10 Mar 2024 02:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710037240; cv=none; b=VqOAPm3TZ436IWPgjoOmrL/Tuw5O8vg+yUxbpfsEtAlKnbMAQRnO030y0G+5YEhzfITUGNihL9qJ1raKIrVJGjm5XuEdHnm1sTdqZiaT+wmB471YBnLT0IwGjaET28ZfTb217sfSnBjSJSI/sSvYmO+8CLNp0s3oMMPed3HEiug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710037240; c=relaxed/simple;
	bh=lU2FEXjQf5ULWlJGjC6beHT2szn5igv6p/kvrR7y6o4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nvxq3hQ+qk7ywRJejjxWah4CJ+2LTnzhxsPx6wNA2yvNHP7Rr+oR2g/fm3uGckaKy7FiU39b/hmn3IyqLvGNI0hU1ssspb0rpa7Qo6+6kP2EK614j769fXoCDWEEibPj9RTp09qot2+7LhwNVHBEOu8sDVblCySDkZ6iQ9nBUNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=j8wV+0Xi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LpSfTKK5; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2392D1800086;
	Sat,  9 Mar 2024 21:20:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 09 Mar 2024 21:20:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1710037235; x=1710123635; bh=t1ZldjZTYg9N6JKMzIXtm
	D68rf620xDzEz43/gNhjtM=; b=j8wV+0Xibu+aH5VIqFA29L94vIkvxB84BshcS
	pEq6LOYuOp5ftyEtpPhUroG1zhkCy5SRqfLGjwTtB1xzsqem7Dh/w2nMuqQWIzlu
	FGQSJwpBIVDv+Li1H+5ppEyfXZ9m+SQw0jGiUEoeBifHQiEmZffXcogBvkRnvkvE
	RqLL2BBBSv0lkT7Ck85Gjyx1bL2XipDvkbGCmVywSkZBEexXXlfbFbsBdf83c9gf
	On/DDe42YJ/VKT6FB0Ss7NqbcraBvTCgQGG/yZKa/muNBe0IRh0pI4BGhpD42Exu
	5x0iAyIgpRI4AAkBhbKvFTn/9VIGjc4tJkqFRJCO6JFLXucaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710037235; x=1710123635; bh=t1ZldjZTYg9N6JKMzIXtmD68rf62
	0xDzEz43/gNhjtM=; b=LpSfTKK5xXlFJnukAgZhUAYI0uywdQOnFxOeOfYarZee
	8DaOjcyosOONFVYU/EEe+oPS0XtCb+H3lgTQ/hG6Phz0Hw2Ov2W/Xogo0iiB9RBZ
	icqmXIz9M9OvSUo8KZw4dmr0HkehdClD33h7OydC86I4DBVdF2UGEZdDfEjfdrvk
	O31PmXgR4Aeut1z2qvSiF/99sJsLWjzHCt1LPAOMfJH1PWZ8Fb/8429rt1sMi0E/
	dy3yiyQbuFwNmDiggaEPdjnMvFE2BGytKJaugvSTZVG7Q9XvZFb8uDXDy3XcdtQh
	27l77JKHh49bq/yDLm7eyN2xwcKQYxkEMMxSWq7yrg==
X-ME-Sender: <xms:8xjtZerybfPyvJFLiPuM_yDiY9-uEqPOI_qYPvJtGZAJZtEkvLEhpw>
    <xme:8xjtZcrFvJFCa_YYTbdTKBSMMaBYgnrTe5ec7bCqqnxaRiALKP2PKLHZ1mWJNSV3U
    a31rmPNIk-h8vHjKNk>
X-ME-Received: <xmr:8xjtZTMLrCCKSW8SkvgcXCjMowwTaOZ8J0YM-JEiMjivF0Q4h0Yg1Gt8k8Iq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieekgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftddtvd
    fhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:8xjtZd4COE0jJgUkZ_JE_SCJvRakf-feQfRYVVnIFTGS7Pd4FNU7IQ>
    <xmx:8xjtZd5wWJg4vYR1lpNcD1PrHSj-ie1qshMq13D49blzz4pR1GRGtw>
    <xmx:8xjtZdgenmSxDj_cbR5XlMX0XL1xdvCaVkJxsE_iCztqnuhP9OfL0A>
    <xmx:8xjtZQ0EMn31ZK17Cg-Xb5JGl31zRFT9rh6qPFgv5JA7Cv9Ib0WwByUP8oA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Mar 2024 21:20:32 -0500 (EST)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] platform/x86: asus-wmi: add support for 2024 ROG Mini-LED
Date: Sun, 10 Mar 2024 15:20:26 +1300
Message-ID: <20240310022026.69841-1-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
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
 .../ABI/testing/sysfs-platform-asus-wmi       |  8 ++++
 drivers/platform/x86/asus-wmi.c               | 37 +++++++++++++++++--
 include/linux/platform_data/x86/asus-wmi.h    |  1 +
 3 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 8a7e25bde085..e32b4f0ae15f 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -126,6 +126,14 @@ Description:
 		Change the mini-LED mode:
 			* 0 - Single-zone,
 			* 1 - Multi-zone
+			* 2 - Multi-zone strong (available on newer generation mini-led)
+
+What:		/sys/devices/platform/<platform>/avilable_mini_led_mode
+Date:		Jun 2023
+KernelVersion:	6.9
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		List the available mini-led modes.
 
 What:		/sys/devices/platform/<platform>/ppt_pl1_spl
 Date:		Jun 2023
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 18be35fdb381..94cc589607b3 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -297,6 +297,7 @@ struct asus_wmi {
 
 	bool panel_overdrive_available;
 	bool mini_led_mode_available;
+	u32 mini_led_dev_id;
 
 	struct hotplug_slot hotplug_slot;
 	struct mutex hotplug_lock;
@@ -2109,7 +2110,7 @@ static ssize_t mini_led_mode_show(struct device *dev,
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result;
 
-	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MINI_LED_MODE);
+	result = asus_wmi_get_devstate_simple(asus, asus->mini_led_dev_id);
 	if (result < 0)
 		return result;
 
@@ -2129,10 +2130,15 @@ static ssize_t mini_led_mode_store(struct device *dev,
 	if (result)
 		return result;
 
-	if (mode > 1)
+	if (mode > 1 && asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE)
 		return -EINVAL;
+	if (mode > 2 && asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2)
+		return -EINVAL;
+	// Remap the mode values to match previous generation mini-led
+	if (asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2)
+		mode = mode == 2 ? 1 : mode == 0 ? 2 : 0;
 
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_MINI_LED_MODE, mode, &result);
+	err = asus_wmi_set_devstate(asus->mini_led_dev_id, mode, &result);
 
 	if (err) {
 		pr_warn("Failed to set mini-LED: %d\n", err);
@@ -2150,6 +2156,21 @@ static ssize_t mini_led_mode_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(mini_led_mode);
 
+static ssize_t available_mini_led_mode_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	if (asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE)
+		return sysfs_emit(buf, "0 1\n");
+	if (asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2)
+		return sysfs_emit(buf, "0 1 2\n");
+
+	return sysfs_emit(buf, "0\n");
+}
+
+static DEVICE_ATTR_RO(available_mini_led_mode);
+
 /* Quirks *********************************************************************/
 
 static void asus_wmi_set_xusb2pr(struct asus_wmi *asus)
@@ -4174,6 +4195,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_nv_temp_target.attr,
 	&dev_attr_panel_od.attr,
 	&dev_attr_mini_led_mode.attr,
+	&dev_attr_available_mini_led_mode.attr,
 	NULL
 };
 
@@ -4496,10 +4518,17 @@ static int asus_wmi_add(struct platform_device *pdev)
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


