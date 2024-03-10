Return-Path: <linux-kernel+bounces-98142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BC9877592
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 07:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DD45B2252C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 06:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6552179BF;
	Sun, 10 Mar 2024 06:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="cAs+/rTE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XTtbcgFC"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04372F22;
	Sun, 10 Mar 2024 06:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710053662; cv=none; b=FEnfV0SMk0jE56scoMvv6fuIixSuVd7Ihk0grXrX3L+EC3MrDL2e8I4VE1suRhkzkKeFRtLtxZ/97a5RRF+vGpGOi/j6U0/0ewZSHqg4OpbsIek9PQ6ejXhsdYC+cf+nbvI2kZe6ehSMxdXRULCeXUCKLfgsGXSDzSp5+t2qPO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710053662; c=relaxed/simple;
	bh=TX1/HSDWVBD3VLcdB/aCBGqMrfNa0AJYTvTDkYqNxVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTM2VOP0DJ+6Lvek/7rkLFOjkOPiwqv9tWG9cBmwS+EJDFKRnRFIEdFGPRkJfensIajSVx7fPiYaf5YOPPSkXzfbj5RbC+9cwYjUSKbp7OJfImZL35dW72af+6CEF+poNXSmhT9gYfPP9PXufwZRlpX0dt/TWnoddGLKe3kCCSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=cAs+/rTE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XTtbcgFC; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CCD7C114009D;
	Sun, 10 Mar 2024 01:54:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 10 Mar 2024 01:54:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1710053659; x=
	1710140059; bh=jYgNFKoegeuVhWSAq6NHSNBWJ2GvxYXdAko3rNDG9NU=; b=c
	As+/rTEVJ14Ua0yWoQJUNaCXfBpkLKOXPD9IACmHIEYsqN8PMXWkKZ3dY2SVxySG
	xK93O1Vc3TvH1/gLwgs/PLHFjc1LIGZ4krpwTpR79U5dqoA1iScDBECxslHkvWnH
	blhTSfKiqLMrxphkIDNkMDRDWNKulYOmTqdvpUjWeD2aCyNSpu5xjVqWn2wByRaU
	SJYOhxbslLLb+ts7h+xapQJgEoq1kUnIx9NR0hqRv6+mSHEaA93KP0FimLIqqYko
	dnMYJr61SY2T5ot1QhzKLo1wmtWxKTovxRDZWDssyL42dw8CmtPLhtT39jPaSAV0
	n66c77S0Sgzu3/C5VlhDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710053659; x=
	1710140059; bh=jYgNFKoegeuVhWSAq6NHSNBWJ2GvxYXdAko3rNDG9NU=; b=X
	TtbcgFCeJ9vXXFNKsdx5t5GOtkH8GQCX5wEXkG1qWxQNu2IOW23/bjuXYVCTRFlJ
	Rd5S3ltxqIKSDYf3QiPBe18C3qyowlxmZq1g86BRAHL9HSJib2IsGdDkWrpRcORc
	5eG7aiViFOFnn0+l91fQfQM/kq/zMZ61ekskC7K380Wx1Hw+Zr07r3iHmFML8ZKG
	7hjrXRyDlEyIIfzkVJsuFFGzwgTO2YOP3rlHuG+RA1ldKKvD/Xpe4b343eVu03VY
	SmLnqh2jWmUAOYj/TG/jI6WrJrTSyYJ22mq7EHXMzdicYkWB+5pSaj9Q78Z8DXZm
	+FFRSMMUCcv09DIfSR62w==
X-ME-Sender: <xms:G1ntZbgPR5H5y2LSipr2pVXZ1igwBI5fAKNVO_-ImrpM2UTyz6SjhQ>
    <xme:G1ntZYAd9wjj5OZyLtPgEhJYChy1RH6BBzpsFaBJPJ2t-VQa_V2YwSgLU9HxfeT3m
    E6q-mAGsGRQrfW16dY>
X-ME-Received: <xmr:G1ntZbHnGP9KZcdPGaN-7RIVHBgLXMdznPeER0tFfZwa4gOUMQgw07Lcafxn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieekgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:G1ntZYQY01f0FXhis7CyFTVzTwwMwuk4XP1hAJzs3UOsx_G3t8A25g>
    <xmx:G1ntZYzM21qdElVLgQpN0NGJ8SY2w4CJQiE6Iivz_G2Fkdu9NbaxPw>
    <xmx:G1ntZe57UqN3GRGHVOka5u1854ctfIamFjD_BY1_lfde8-julNS4yg>
    <xmx:G1ntZSuYvk5pli8GwiXPE0V335-SyRop9ny61MPyx1ggLlrMVF9T-g>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Mar 2024 01:54:17 -0500 (EST)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v1 1/1] platform/x86: asus-wmi: add support for 2024 ROG Mini-LED
Date: Sun, 10 Mar 2024 19:54:08 +1300
Message-ID: <20240310065408.63703-2-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240310065408.63703-1-luke@ljones.dev>
References: <20240310065408.63703-1-luke@ljones.dev>
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
 drivers/platform/x86/asus-wmi.c               | 48 ++++++++++++++++---
 include/linux/platform_data/x86/asus-wmi.h    |  1 +
 3 files changed, 51 insertions(+), 6 deletions(-)

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
index 18be35fdb381..a56152ccfbe7 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -297,6 +297,7 @@ struct asus_wmi {
 
 	bool panel_overdrive_available;
 	bool mini_led_mode_available;
+	u32 mini_led_dev_id;
 
 	struct hotplug_slot hotplug_slot;
 	struct mutex hotplug_lock;
@@ -2109,10 +2110,17 @@ static ssize_t mini_led_mode_show(struct device *dev,
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result;
 
-	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MINI_LED_MODE);
-	if (result < 0)
-		return result;
+	result = asus_wmi_get_devstate_simple(asus, asus->mini_led_dev_id);
 
+	// Remap the mode values to match previous generation mini-led including
+	// if errored -19 since some of these bios return a bad result if set to "2"
+	// which is mini-led off
+	if (asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2) {
+		if (result >= 0 || result == -19)
+			result = result == 1 ? 2 : result == 0 ? 1 : 0;
+	} else if (result < 0) {
+		return result;
+	}
 	return sysfs_emit(buf, "%d\n", result);
 }
 
@@ -2129,10 +2137,15 @@ static ssize_t mini_led_mode_store(struct device *dev,
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
@@ -2150,6 +2163,21 @@ static ssize_t mini_led_mode_store(struct device *dev,
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
@@ -4174,6 +4202,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_nv_temp_target.attr,
 	&dev_attr_panel_od.attr,
 	&dev_attr_mini_led_mode.attr,
+	&dev_attr_available_mini_led_mode.attr,
 	NULL
 };
 
@@ -4496,10 +4525,17 @@ static int asus_wmi_add(struct platform_device *pdev)
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


