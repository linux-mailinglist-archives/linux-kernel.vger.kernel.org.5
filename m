Return-Path: <linux-kernel+bounces-127254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3509F8948CF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B611D1F22EED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB43E55F;
	Tue,  2 Apr 2024 01:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="i49jY0pf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="opJbV/27"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC4913FFC;
	Tue,  2 Apr 2024 01:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712021730; cv=none; b=FdzGWjWa0+WAahMtuFCEjeeB6g+J99TERre7roKaX13V1qG5M0ljsS3XMVOLYFW3y/XeGgoZMorr4syt90bSD1dDHlnNJFH/XRNGaHOOK4VK5BgLhgH1GLbj+UYk8I+tCTtJUctMyK7lC2qhTNa7XOL3aex7Ty+YbYcZHto/NxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712021730; c=relaxed/simple;
	bh=xsREb+57Vt9lCHgSGnNOYko9mfC1XEVGwBFhnsuKUgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsCcCHW/e5SBf5ObsSpaWquLAIbMEszsT+alCaxuy9tmpe68vJDp2NqEPtgDO7IqChSEDAfPFN2sLoPRCGe/k8kVPm63v5QGS7K36NcD4Ltdyeo/0WiN5EXmsYFX3ob7GObZt2A5vIExGEcNjMNh1eHh/LlxhzqvxTWN4IHHptc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=i49jY0pf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=opJbV/27; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 1181A1C000A6;
	Mon,  1 Apr 2024 21:35:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 01 Apr 2024 21:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1712021726; x=
	1712108126; bh=trk5TzQgKhZg9saEMdevl4e54pGOqEYoUzRD6rKvezo=; b=i
	49jY0pfB1wkeT7cFY7fzCQaKQOs4OCi0Zy7Gip38b3zLTst40gY1cBLLEyBxm5+b
	wPRnlgmR4AiUgPN906QvoXxfY9hVLdAC3R+TPH03vne+p0welXS19l2w5U7tRdpJ
	m/70r+RBBtI/D41aZCa/v/u8XdeKvBiQBXHuL5imG83wR+9ws6evUSXBURhY9dkF
	+0WUBpvdL5QRJDdOPQikK4j48MfMehfWbWl2nLFfxwdSWwg03im+ESUJ4weGEfvL
	u6RaOM9Ox573pGDKiMj+Rxlhh4RnBCPe0/8kmmYHUnmZXHby5e9AXDXgB5OSrbC9
	I9tRJwL5PZPY6EhNhVe4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712021726; x=
	1712108126; bh=trk5TzQgKhZg9saEMdevl4e54pGOqEYoUzRD6rKvezo=; b=o
	pJbV/27ixvo+725nZBBr/7P6TDGF2k6L3a5BH5bQ2c6GH0ECF6QTegtW6WIayNUU
	1RPI8x5kGnFF3XZ99QOyeei8ngIT6do8HiamePLvuT/e/W5XOorwotYimf/9NhEo
	GcDtJkMb7jq66zGPufPB6oWUMm52KJpc8IkeWtC7U8ku0PaPpZpAyc1INujVGjcS
	WF3s0Og4zfjC+101/GuUOjYYTZVSrs8NTy3TUPIZuV0bcUlLjzKQtk5W5gPm1WaX
	rN/TItdiR2g+e2naXD1cHKK+hR9mB7PYBJBpWFVh2+a60bDc2+FIVS00iFk5qdeX
	fwtLr4UdupiIwGaI6YYwg==
X-ME-Sender: <xms:3mALZrTIKjXMlbtwMxAJJQ01ZC8AkZvP5cKWGzdlW3PCB-5EqaWUoQ>
    <xme:3mALZsxIb3kbFbR0qNh4gqCTVy8O55FFa4jeBzbhyi_Pzzl404VqAqmZ8yZYevMrY
    thQcS8ciDS6bYQZg_U>
X-ME-Received: <xmr:3mALZg2fOaun93wzIrN5Fizn3bc3W1hvFubATsDN56ps6PkNdCyG5ZpSLrjf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:3mALZrDSTdecowTXEcK5ISzdF3mHnwt8YeeGM4qgCs3JWXMzGvJD-Q>
    <xmx:3mALZkiZ8K185pdcf_fpJ2RFon1a2wSoyRY-PMn0SCqF4Zy_OotL6w>
    <xmx:3mALZvqPbnhzu6QOmbiQbgkn00BMn7MQ6PVD8Ge7sbw_dxD1xQQpTQ>
    <xmx:3mALZvh6g5XuXFWDrAFo76fJWisjv5sSG4v8qD0gWlGLfV112x5ndA>
    <xmx:3mALZvXCa_KTIdSRcDlegBf3ABkX6LSOldBgTXhi0uV4zf4YanM-IRuV7P0>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 21:35:23 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v1 5/9] platform/x86: asus-wmi: store a min default for ppt options
Date: Tue,  2 Apr 2024 14:34:49 +1300
Message-ID: <20240402013453.18205-6-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402013453.18205-1-luke@ljones.dev>
References: <20240402013453.18205-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Laptops with any of the ppt or nv tunables default to the minimum setting
on boot so we can safely assume a stored value is correct.

This patch adds storing of those values in the local struct, and enables
reading of those values back. To prevent creating a series of byte holes
in the struct the "<name>_available" bool is removed and
`asus_sysfs_is_visible()` uses the `ASUS_WMI_DEVID_<name>` directly.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 127 +++++++++++++++++++++++++-------
 1 file changed, 99 insertions(+), 28 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index fcf976967325..0d304a04e7de 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -262,13 +262,13 @@ struct asus_wmi {
 	u32 gpu_mux_dev;
 
 	/* Tunables provided by ASUS for gaming laptops */
-	bool ppt_pl2_sppt_available;
-	bool ppt_pl1_spl_available;
-	bool ppt_apu_sppt_available;
-	bool ppt_plat_sppt_available;
-	bool ppt_fppt_available;
-	bool nv_dyn_boost_available;
-	bool nv_temp_tgt_available;
+	u32 ppt_pl2_sppt;
+	u32 ppt_pl1_spl;
+	u32 ppt_apu_sppt;
+	u32 ppt_platform_sppt;
+	u32 ppt_fppt;
+	u32 nv_dynamic_boost;
+	u32 nv_temp_target;
 
 	u32 kbd_rgb_dev;
 	bool kbd_rgb_state_available;
@@ -1020,11 +1020,21 @@ static ssize_t ppt_pl2_sppt_store(struct device *dev,
 		return -EIO;
 	}
 
+	asus->ppt_pl2_sppt = value;
 	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_pl2_sppt");
 
 	return count;
 }
-static DEVICE_ATTR_WO(ppt_pl2_sppt);
+
+static ssize_t ppt_pl2_sppt_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", asus->ppt_pl2_sppt);
+}
+static DEVICE_ATTR_RW(ppt_pl2_sppt);
 
 /* Tunable: PPT, Intel=PL1, AMD=SPL ******************************************/
 static ssize_t ppt_pl1_spl_store(struct device *dev,
@@ -1054,11 +1064,20 @@ static ssize_t ppt_pl1_spl_store(struct device *dev,
 		return -EIO;
 	}
 
+	asus->ppt_pl1_spl = value;
 	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_pl1_spl");
 
 	return count;
 }
-static DEVICE_ATTR_WO(ppt_pl1_spl);
+static ssize_t ppt_pl1_spl_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", asus->ppt_pl1_spl);
+}
+static DEVICE_ATTR_RW(ppt_pl1_spl);
 
 /* Tunable: PPT APU FPPT ******************************************************/
 static ssize_t ppt_fppt_store(struct device *dev,
@@ -1088,11 +1107,21 @@ static ssize_t ppt_fppt_store(struct device *dev,
 		return -EIO;
 	}
 
+	asus->ppt_fppt = value;
 	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_fpu_sppt");
 
 	return count;
 }
-static DEVICE_ATTR_WO(ppt_fppt);
+
+static ssize_t ppt_fppt_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", asus->ppt_fppt);
+}
+static DEVICE_ATTR_RW(ppt_fppt);
 
 /* Tunable: PPT APU SPPT *****************************************************/
 static ssize_t ppt_apu_sppt_store(struct device *dev,
@@ -1122,11 +1151,21 @@ static ssize_t ppt_apu_sppt_store(struct device *dev,
 		return -EIO;
 	}
 
+	asus->ppt_apu_sppt = value;
 	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_apu_sppt");
 
 	return count;
 }
-static DEVICE_ATTR_WO(ppt_apu_sppt);
+
+static ssize_t ppt_apu_sppt_show(struct device *dev,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", asus->ppt_apu_sppt);
+}
+static DEVICE_ATTR_RW(ppt_apu_sppt);
 
 /* Tunable: PPT platform SPPT ************************************************/
 static ssize_t ppt_platform_sppt_store(struct device *dev,
@@ -1156,11 +1195,21 @@ static ssize_t ppt_platform_sppt_store(struct device *dev,
 		return -EIO;
 	}
 
+	asus->ppt_platform_sppt = value;
 	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_platform_sppt");
 
 	return count;
 }
-static DEVICE_ATTR_WO(ppt_platform_sppt);
+
+static ssize_t ppt_platform_sppt_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", asus->ppt_platform_sppt);
+}
+static DEVICE_ATTR_RW(ppt_platform_sppt);
 
 /* Tunable: NVIDIA dynamic boost *********************************************/
 static ssize_t nv_dynamic_boost_store(struct device *dev,
@@ -1190,11 +1239,21 @@ static ssize_t nv_dynamic_boost_store(struct device *dev,
 		return -EIO;
 	}
 
+	asus->nv_dynamic_boost = value;
 	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "nv_dynamic_boost");
 
 	return count;
 }
-static DEVICE_ATTR_WO(nv_dynamic_boost);
+
+static ssize_t nv_dynamic_boost_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", asus->nv_dynamic_boost);
+}
+static DEVICE_ATTR_RW(nv_dynamic_boost);
 
 /* Tunable: NVIDIA temperature target ****************************************/
 static ssize_t nv_temp_target_store(struct device *dev,
@@ -1224,11 +1283,21 @@ static ssize_t nv_temp_target_store(struct device *dev,
 		return -EIO;
 	}
 
+	asus->nv_temp_target = value;
 	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "nv_temp_target");
 
 	return count;
 }
-static DEVICE_ATTR_WO(nv_temp_target);
+
+static ssize_t nv_temp_target_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", asus->nv_temp_target);
+}
+static DEVICE_ATTR_RW(nv_temp_target);
 
 /* Battery ********************************************************************/
 
@@ -4277,19 +4346,19 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
 		ok = asus->throttle_thermal_policy_available;
 	else if (attr == &dev_attr_ppt_pl2_sppt.attr)
-		ok = asus->ppt_pl2_sppt_available;
+		devid = ASUS_WMI_DEVID_PPT_PL2_SPPT;
 	else if (attr == &dev_attr_ppt_pl1_spl.attr)
-		ok = asus->ppt_pl1_spl_available;
+		devid = ASUS_WMI_DEVID_PPT_PL1_SPL;
 	else if (attr == &dev_attr_ppt_fppt.attr)
-		ok = asus->ppt_fppt_available;
+		devid = ASUS_WMI_DEVID_PPT_FPPT;
 	else if (attr == &dev_attr_ppt_apu_sppt.attr)
-		ok = asus->ppt_apu_sppt_available;
+		devid = ASUS_WMI_DEVID_PPT_APU_SPPT;
 	else if (attr == &dev_attr_ppt_platform_sppt.attr)
-		ok = asus->ppt_plat_sppt_available;
+		devid = ASUS_WMI_DEVID_PPT_PLAT_SPPT;
 	else if (attr == &dev_attr_nv_dynamic_boost.attr)
-		ok = asus->nv_dyn_boost_available;
+		devid = ASUS_WMI_DEVID_NV_DYN_BOOST;
 	else if (attr == &dev_attr_nv_temp_target.attr)
-		ok = asus->nv_temp_tgt_available;
+		devid = ASUS_WMI_DEVID_NV_THERM_TARGET;
 	else if (attr == &dev_attr_boot_sound.attr)
 		devid = ASUS_WMI_DEVID_BOOT_SOUND;
 	else if (attr == &dev_attr_panel_od.attr)
@@ -4535,18 +4604,20 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_platform;
 
+	/* ensure defaults for tunables */
+	asus->ppt_pl2_sppt = 5;
+	asus->ppt_pl1_spl = 5;
+	asus->ppt_apu_sppt = 5;
+	asus->ppt_platform_sppt = 5;
+	asus->ppt_fppt = 5;
+	asus->nv_dynamic_boost = 5;
+	asus->nv_temp_target = 75;
+
 	asus->charge_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_CHARGE_MODE);
 	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
 	asus->egpu_connect_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
 	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
-	asus->ppt_pl2_sppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PL2_SPPT);
-	asus->ppt_pl1_spl_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PL1_SPL);
-	asus->ppt_fppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_FPPT);
-	asus->ppt_apu_sppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_APU_SPPT);
-	asus->ppt_plat_sppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PLAT_SPPT);
-	asus->nv_dyn_boost_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_NV_DYN_BOOST);
-	asus->nv_temp_tgt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_NV_THERM_TARGET);
 	asus->panel_overdrive_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PANEL_OD);
 	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
 						&& dmi_match(DMI_BOARD_NAME, "RC71L");
-- 
2.44.0


