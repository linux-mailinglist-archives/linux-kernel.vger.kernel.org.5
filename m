Return-Path: <linux-kernel+bounces-127299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D0B894960
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710CB1C23EA3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A58817732;
	Tue,  2 Apr 2024 02:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="IIg2wY8T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gyOFG4MR"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEEA175A9;
	Tue,  2 Apr 2024 02:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024802; cv=none; b=mEpVMj/sQmA1oZpFIctnu9wdXknoi09tpNalXlV7eBGEVL1Hr/Sxo/cAbAAGqWmgTDXefgu7FwbgUCl0+to7YwBstH/BzqI0adsitJ1OrZMvwQLEBCBQ1hfl+eIuYTgXtPARwgKk7+8OQCzTntG/DbFnhyI2S8ttVfG9ci043WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024802; c=relaxed/simple;
	bh=6Nbg7HJanlxSp+EVpawDpDIMndRCVKMPWk+fTGgikQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0Sm7qZVhH63rE2w4C1nfEcZShMDveRCJjDjDgXO3955HhblxeqcOcEh4VwrHIBSDHw4ZdXBwg7By+2+VB6fAdVQWd2LR+67+p/yoXr8kWvw86Je9LtdKtRCF8AaJcw666X21iPMWDwT3flCFLFK/kaX7nPxKmf+7qKpwEWKkpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=IIg2wY8T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gyOFG4MR; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 35B331C000B2;
	Mon,  1 Apr 2024 22:26:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 01 Apr 2024 22:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1712024798; x=
	1712111198; bh=8vCreOtmdp1HVovlQHQZwFGuVhfQqWoudJkCsID7108=; b=I
	Ig2wY8TIT+nz5WjK4gh4wXz0eBvHCx6aX4B5LV8ZUvf8A2zs0V/pgryTA90YDOC9
	YAzhr7w/ANtTC8jMAuwdsfx9aMrp8Osy0Gn6at+Tbon0wvBwyLio0zoZ5CMlOOtU
	a1tsBM1IrMxER8BpMn0J/Glotx08JZGUB6B0G96GpGw1oQfa0ugsTobJcvjK2PCJ
	s/LEYc+odI6dhsgk1G6AS6gmFsGexGL+KB+ogB/0AVGZzQdvh16JEuVl5VL4rEUM
	ZUbFP4jcPbS9tsfFQtjMgSbNrlB4Uu98ggCKP3qIuxSMNfhq4/APdu2ufTuMujig
	VvmfTLohunx+UVVgojhpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712024798; x=
	1712111198; bh=8vCreOtmdp1HVovlQHQZwFGuVhfQqWoudJkCsID7108=; b=g
	yOFG4MR+UcOyrRZFmTG1gRrTHaRvopQA5rOEVjvQi3kSXo1GDUvJaWIE2xTpNXhq
	fdfaPCkALZYJt9tKv3Z3LcRE9LdnVHq0l2fI3DZ5nmHSLNykUClpKa2O0c67ppnv
	mppLgGZRaNCbb8Kqe+AvLGQTglLXSK3GUcXYQAflOxAAHoU4VEq3zVknVwMX+7DP
	CUwqp+UpOPoG5vQ2HZ0qojbiMvv1QM9xbCK/zdqcxO4wt6pV/jfhk4Eb1ye7COkH
	x/23Kv++2RvfszFCDuCUCXLys/KX1M0KqpUcBwsuoyqXmua2cSMhRNfCNqXefjBs
	5M+YPjHdZQnhpRRgZE1cQ==
X-ME-Sender: <xms:3mwLZkdkybXa_zHNn1M1sORzD5Wmkf7JfPRasCru9ji-oXkhyDkmWw>
    <xme:3mwLZmOYQaIyRRw0HvOdyiLDCFvftllVHWJrnuPVAaF0ib1c5D1sqR67tPZ8COPKZ
    mQ5ZZoDR0BNF2U-f94>
X-ME-Received: <xmr:3mwLZlgse1Fq9uprKmIDRB9_xH8MvxiIHazv0QVsVN2P0vXOGwYtJL0pQyxS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:3mwLZp9dTNFDJxEY5u6CLzzBL4IQWdrIsHmpnuazupBC691j7TvNnQ>
    <xmx:3mwLZgt7eCZ88YWo56mfVQxqPgkshEKlvxgxTMOkAqhuNEhzs3LUKw>
    <xmx:3mwLZgHi4hheobluL4-LFLK-iCugktNS4elR0piJoqDiHaQhGdKVXw>
    <xmx:3mwLZvOxMBn8U5T7hwh96BqUL5kyYlw3x3GxIvx6H4WMPQuQhThHXg>
    <xmx:3mwLZkhphHZBM0zoRq8D63Eior-HV2OJc6PHessDjVHLcwrCd6iYsG4yw0M>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 22:26:35 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 5/9] platform/x86: asus-wmi: store a min default for ppt options
Date: Tue,  2 Apr 2024 15:26:03 +1300
Message-ID: <20240402022607.34625-6-luke@ljones.dev>
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
index b795f9c1941f..c80afa385532 100644
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


