Return-Path: <linux-kernel+bounces-98135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE310877583
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 07:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D98E1F22D02
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 06:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FD912B72;
	Sun, 10 Mar 2024 06:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="r+bvhjxZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CtAK4kuJ"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C5813AF2;
	Sun, 10 Mar 2024 06:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710051448; cv=none; b=hYMcqvnSd8oOl6PrBpkKgb1GC4r3TEOSPz06bUfboR9yU0nFwwufIkIwpqbaDNPpwnqUkB0zbp/jXQNGSQ5hG5vvid9e2copYSmaxHEXo+eHlw6vKDNcmzK9fJYcawUinPXEpomXA91jQ+ajsBn3QzE4U4ZrFWR8aW4p912Mfh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710051448; c=relaxed/simple;
	bh=KUT+1ybGRuShKqLJkasCpuG2j4yRV7TW6oXtIFsLtiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H1dLq6gwHEzAunYu3f0Q9c3jjasVjhpr84GhBqQ3GiDBxNefrqXzmyDWp6b3lSCikGn+nMh4S/T6YTO/n8HILKRGnD9eJpG+IaJ0U/L3ePe8fYm97uWG62PftITXq/9V6D8DlRhvNxznGstjqzT/yDyjquvTSVDWgV92ij8KAbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=r+bvhjxZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CtAK4kuJ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A813911400CD;
	Sun, 10 Mar 2024 01:17:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 10 Mar 2024 01:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1710051445; x=1710137845; bh=PWe8JOzSuiGd8iJSQG6Xc
	s+jMrE2JjLID6rd+Y1zGBk=; b=r+bvhjxZXR9Far6InpP8BwH41uF/rejC08RhX
	xJfuIEfT8b8PM047c4rMV1u4s0ikb+WwwQrSWxh09d2Xr1J10RFEaWLm/z7o5wEi
	VQAE9MMzcx7bTx4FGq39QN6sh1nLDQt0PJ6FYs7j6vgmgk9AQdSSq3ETNSG7kH+d
	AhhihwHQt1neulV3YczVk7ISnBR9rWoT6m8+19lvZmnLtpfnMI7ufBEkmZaBU9tl
	EaRKVqdDb5FdtZW+fBHXYaAF/QUkNIHOQlgKHakT2FUtPZmvJkE5BycPMYcD+KPz
	4jdAkmQq8xf1MaOerdL+GcpnRw9tZ+aaiJEntro9QE0szIFWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710051445; x=1710137845; bh=PWe8JOzSuiGd8iJSQG6Xcs+jMrE2
	JjLID6rd+Y1zGBk=; b=CtAK4kuJvx0jOhfW5nOwmDPQa8gDJg8bHdZutlROFMNv
	hmSLqpORr8JQegmg9gU89NY2GMRHnI7EnWo9pcOAWXmAOtk1bZMuB/fRJA/FyXMu
	mVkGOkObEa+pmVsUFtdc62cNeQD75Wy+szi97JtuJSvDg4kr5zO5xmXT13qbrOOw
	CR246pcENY+VcbwkIHoBkn4Hk+hdgUH58Yl5yfNIw4twIm7QJAfpx76HFNX4HUZS
	NQy3AVogbBzQbXz1LEq5UR2SX9YMtuvKRx9UG4liJVbVE7OVVcXC5YwWGEuXBnxP
	QvoBIrsv7pcm2J3XhYZjvipDd9qnUgZX60Rfi68Jiw==
X-ME-Sender: <xms:dVDtZYL_PeA02T6mB8jGL-9exmp4AuW2Tftjn3Sgvm3kgsnDB8iRlQ>
    <xme:dVDtZYKywr1vGl9lbqi81vUZTiYgam2WX39_7yidiINUd9wKSSjtneL5AjJ7wHmOr
    kCkkURVP3mSHhvdDp0>
X-ME-Received: <xmr:dVDtZYslf_tedM_4ABqNSGedziRIXvhe0Xfhj8jxTL-uJ_ds3inkJj6ZJ8qi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieekgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftddtvd
    fhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:dVDtZVZK5buqdOnCcwLFztccy06qp6swpLyw5QCBJ1HcIbAWMZHvPw>
    <xmx:dVDtZfau9Vg9_mjlWaab8BQbIEifDLfY9RK8QxO1plfhzBysu6R5lA>
    <xmx:dVDtZRAfe7s1la3QHQxtS1PxQFA95Rkat55pTd3pvNV8pjt0QE_hYw>
    <xmx:dVDtZeWOQei3stNj98hDmzL0OC5K_HyRk4yTB47Yp4aztfwWI7mEQw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Mar 2024 01:17:22 -0500 (EST)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] platform/x86: asus-wmi: support toggling POST sound
Date: Sun, 10 Mar 2024 19:17:15 +1300
Message-ID: <20240310061715.16531-1-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for toggling the BIOS POST sound on some ASUS laptops.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       |  7 +++
 drivers/platform/x86/asus-wmi.c               | 54 +++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h    |  3 ++
 3 files changed, 64 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index e32b4f0ae15f..f3c53b7453f0 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -194,3 +194,10 @@ Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
 		Set the target temperature limit of the Nvidia dGPU:
 			* min=75, max=87
+
+What:		/sys/devices/platform/<platform>/boot_sound
+Date:		Jun 2023
+KernelVersion:	6.9
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set if the BIOS POST sound is played on boot.
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index ca8c73c15fcc..26084e9846a1 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -297,6 +297,7 @@ struct asus_wmi {
 	// The RSOC controls the maximum charging percentage.
 	bool battery_rsoc_available;
 
+	bool boot_sound_available;
 	bool panel_overdrive_available;
 	bool mini_led_mode_available;
 	u32 mini_led_dev_id;
@@ -2106,6 +2107,55 @@ static ssize_t panel_od_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(panel_od);
 
+/* Bootup sound ***************************************************************/
+
+static ssize_t boot_sound_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	int result;
+
+	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_BOOT_SOUND);
+	if (result < 0)
+		return result;
+
+	return sysfs_emit(buf, "%d\n", result);
+}
+
+static ssize_t boot_sound_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	int result, err;
+	u32 snd;
+
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	result = kstrtou32(buf, 10, &snd);
+	if (result)
+		return result;
+
+	if (snd > 1)
+		return -EINVAL;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BOOT_SOUND, snd, &result);
+
+	if (err) {
+		pr_warn("Failed to set boot sound: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set panel boot sound (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "boot_sound");
+
+	return count;
+}
+static DEVICE_ATTR_RW(boot_sound);
+
 /* Mini-LED mode **************************************************************/
 static ssize_t mini_led_mode_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
@@ -4196,6 +4246,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_ppt_platform_sppt.attr,
 	&dev_attr_nv_dynamic_boost.attr,
 	&dev_attr_nv_temp_target.attr,
+	&dev_attr_boot_sound.attr,
 	&dev_attr_panel_od.attr,
 	&dev_attr_mini_led_mode.attr,
 	&dev_attr_available_mini_led_mode.attr,
@@ -4248,6 +4299,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->nv_dyn_boost_available;
 	else if (attr == &dev_attr_nv_temp_target.attr)
 		ok = asus->nv_temp_tgt_available;
+	else if (attr == &dev_attr_boot_sound.attr)
+		ok = asus->boot_sound_available;
 	else if (attr == &dev_attr_panel_od.attr)
 		ok = asus->panel_overdrive_available;
 	else if (attr == &dev_attr_mini_led_mode.attr)
@@ -4519,6 +4572,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->ppt_plat_sppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PLAT_SPPT);
 	asus->nv_dyn_boost_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_NV_DYN_BOOST);
 	asus->nv_temp_tgt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_NV_THERM_TARGET);
+	asus->boot_sound_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_BOOT_SOUND);
 	asus->panel_overdrive_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PANEL_OD);
 	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
 						&& dmi_match(DMI_BOARD_NAME, "RC71L");
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 3e9a01467c67..3eb5cd6773ad 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -137,6 +137,9 @@
 /* TUF laptop RGB power/state */
 #define ASUS_WMI_DEVID_TUF_RGB_STATE	0x00100057
 
+/* Bootup sound control */
+#define ASUS_WMI_DEVID_BOOT_SOUND	0x00130022
+
 /* DSTS masks */
 #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
 #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002
-- 
2.44.0


