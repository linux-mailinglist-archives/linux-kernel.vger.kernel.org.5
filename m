Return-Path: <linux-kernel+bounces-116558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 614F588A0A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF3A1F3A5EF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAB81487E8;
	Mon, 25 Mar 2024 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="hlvo5M1v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qh9mhyJF"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B601487FE;
	Mon, 25 Mar 2024 05:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711345826; cv=none; b=DyPiZVgu880AV9lRWigYJloSWbfZSPM0VGQuH48DcjSqQ131BNGEtILI3vl7nPRGKfhpQbjdXtZMLHHgUlh0rQQK/1UjxDPyhOTR+vuNaZR4Zfw3TAeQkqfbzoztQzZ0Dvyvf2EqtkQCDk/lA4Mh+ut2X9bg4VzcZvd1JkYF1RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711345826; c=relaxed/simple;
	bh=H0XXl2nd4p7lkG53n8fVjt+PQ+8UAhbKACuzm1iveiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+gWcsHDQqp28jkUEyMRPGXjzmpmTr3gEXw2qY4rC2Gn73oTHzC/unE4/zABsBwFbqTbW9aOid10mNxlOMP+Kap2bnGnaJBIYXWt+j+NE0IyIFyjwufvuM4/DiDLZM2GpO+Rsb/aIyGynG87Rxg+IJA3grn1S3ybl9RGBkXjFoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=hlvo5M1v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qh9mhyJF; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id AC48113800F3;
	Mon, 25 Mar 2024 01:50:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 25 Mar 2024 01:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1711345823; x=
	1711432223; bh=IIk1CZbCz3Dnvbmp1NYtis5LnvpXyEWO8o6T/E3NbVo=; b=h
	lvo5M1v/76OOBRHqXmKyqXgxmS8S6XrXfhAAA2LhIF1sC7gmTYUdC7DLchMopTv9
	VWce9A1kNs7FqmyA0JDFxrvtZKJ8iHo/Iym/2uc592lyu3qsEXkiu40MNU8nMh4C
	UZDW3P3e43uLSFHzBbUc89VXOEoFR6rRqJ8nDbhjk1WRAqce2ELD7oiQU7LYPL3N
	ReHZnCrH4DakYZiZhuXKNOaxvt0nCBW3fWOJqd/vv0UQpKT7sr/QzOdyGemAjnNe
	68/Zz5pxGCvJAmfXNRTkZAWEukFzK6m9GQkZHW/F4RNvF65PS+Frq/x7ZeOLAGK7
	2WNoTeum8j/ZCmqN2JhQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711345823; x=
	1711432223; bh=IIk1CZbCz3Dnvbmp1NYtis5LnvpXyEWO8o6T/E3NbVo=; b=Q
	h9mhyJFzHFbMOATIlq4qnNdCFiPOt4eS18VevlCjAvWiMrpzqqS6QBtYPesaQ9hT
	xftZddFCxUzqeMLG7Wby/fyPRFzay79FPn4AD06f/tdZVK98ihbFiMAoibEFkTOe
	4/UUi3yEEuG8IppvwhTIMuZhtdrSJ6yZFCcf1QmQj1XGiOwfoYwP+i43wGZHX21T
	OPCya59KGAX2I3519Bd69D2h786LHbcNDj5/rWKPAY42tOP2biXB0K+9+LlRnNpv
	IL9UeYMsC98UaUTbnoXlt58jdog4ykINP13fobNA91OwH1QKP+TpkPzURrLUxQzW
	4elVTcFu0yYtBOOjCw2Ww==
X-ME-Sender: <xms:nxABZgsHnoxomLEpPl9R3Ujp0vDV_S8lsLZ-rrW36yWBDjc5Uigu6A>
    <xme:nxABZtf9til8DQIm3Iq4BADI-1W3YLaKGoWFCKszAIM4cCeWRVHSIVIs9LRZ2EFCQ
    FtXOWdiWNMclpEZKP0>
X-ME-Received: <xmr:nxABZryWjZadstuLgdiPCQvSdbuc3NCBMxPjCiSWv4I0fQBKl4bz9Q7tTBtk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtkedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:nxABZjOC6ZHixCUCUgnMiJ5ZB3rbJLocR3YCUGjGs0FLXM2orFGBLA>
    <xmx:nxABZg8GrmiHHROu4JYqc8XZ5phlhNGN_N_h5gf_Ru-rDuG0bHY-AA>
    <xmx:nxABZrWqRAQLcwgxZUvZXpFN2dyMjIlzHkQ7oL3eGKkWkd6iPsKc7Q>
    <xmx:nxABZpfeFEreP-BfK1VFqr2XEvMQ6s55QLk_0zbxweHtAUrmYkPd-Q>
    <xmx:nxABZgxFl-yFHIZS5aHNAxVgcLibTQEKAaT9XN0-LGRIQk1PlGwtQQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 01:50:20 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 5/9] platform/x86: asus-wmi: store a min default for ppt options
Date: Mon, 25 Mar 2024 18:49:34 +1300
Message-ID: <20240325054938.489732-6-luke@ljones.dev>
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
index 6cac9c3eb8b2..1e369b673a72 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -271,13 +271,13 @@ struct asus_wmi {
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
 
 	bool kbd_rgb_mode_available;
 	u32 kbd_rgb_dev;
@@ -1021,11 +1021,21 @@ static ssize_t ppt_pl2_sppt_store(struct device *dev,
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
@@ -1055,11 +1065,20 @@ static ssize_t ppt_pl1_spl_store(struct device *dev,
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
@@ -1089,11 +1108,21 @@ static ssize_t ppt_fppt_store(struct device *dev,
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
@@ -1123,11 +1152,21 @@ static ssize_t ppt_apu_sppt_store(struct device *dev,
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
@@ -1157,11 +1196,21 @@ static ssize_t ppt_platform_sppt_store(struct device *dev,
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
@@ -1191,11 +1240,21 @@ static ssize_t nv_dynamic_boost_store(struct device *dev,
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
@@ -1225,11 +1284,21 @@ static ssize_t nv_temp_target_store(struct device *dev,
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
 
@@ -4315,19 +4384,19 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
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
@@ -4588,18 +4657,20 @@ static int asus_wmi_add(struct platform_device *pdev)
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


