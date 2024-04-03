Return-Path: <linux-kernel+bounces-128878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5934896169
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB541F29510
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2D01B815;
	Wed,  3 Apr 2024 00:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="aiHyeHH8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ihg1p0CM"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D902E11190;
	Wed,  3 Apr 2024 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712104184; cv=none; b=gdhW8MxDSEeEiBTUag1yGcXY2zc7Xu1RnChmm2JS1rsNgssib61SRlQoVYJ3emSq3+022WKQNx/wQ25pUOnLMu1j6aD/oc36NHTY5Iuk+Q8dCEYHKQtrNIPEIOQlXzEfh7PZGSQkQ/6QUwNlZlEKvJYcd8+WMpdJA2+ol8ZPNws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712104184; c=relaxed/simple;
	bh=6joGT/MnG4WsyuQcvBota9A9uM824aIeASCenrmlyBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EzAnyiWPKm54m3fWAtTBOI+ewzsrKnxQIeScCGmxF2KCpII5CQVfR34gFFZJi+1Ke6C7lQi55zy0cleFWkhmfrUW92BmZYxL+UZ3JZLRPWKXuxxJQr9X1ZVJPjFF4VZm6PDFi/GuErkzP3bGF7so23bM1vcf+/a0yjCq5PWdRR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=aiHyeHH8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ihg1p0CM; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A871C114010D;
	Tue,  2 Apr 2024 20:29:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 02 Apr 2024 20:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1712104181;
	 x=1712190581; bh=4gNqh2mr2s6idJ4KEipqBLuE86xIzsFXyfYe+LDV+Hw=; b=
	aiHyeHH8poXQZHXuDPSy5Qx1LKrJbRq9p6CDma57lW2FxjfZ1rW9aiew4Kbk3gB2
	Cr2/+v4Y5uvg+k2xQFXAzEZzpSjDRlcRhvJuqIy6P3q/e/mZM27uvsJBHJPbZlSp
	hIzFvFTcSRt0KaODFNO8KVlEASEC/AnJzWdSpBXYJXSCCX1oVS9wz2/k6erhjudQ
	CjZfID3Hh+vaV0vCV43n7v+/GgBeUc1liS6kLJ4+qfWd55EDQ9GT1FA+BZcQNuDS
	eWvUkUqC4fklh0XWUj/VnWh3GFQrOG7Qj9kkmrC+SC2oAFMQGvuDU6zSnE051VWA
	xsT2G3y/NxAQDScrFt736g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712104181; x=
	1712190581; bh=4gNqh2mr2s6idJ4KEipqBLuE86xIzsFXyfYe+LDV+Hw=; b=I
	hg1p0CMYpuXlv08LCbWlIPDM1/b/52Tg6tW/rfYSPYGdjFxUjm1CTBL9fgB28wW3
	bkwYfVWyA75t8Kd6KPfghxzUsq+La9AP8emXGOhStPhPo9iUs1w2lwOPipqn1j5L
	+wjsPc8xdppEbxbjqdlvISeEa6XW4UT9GQL4SRg9XKLQcusWZlGJavL36pJ8Du0s
	WOVVHa+r268WNQ6dVSt25024VsSb4AdRMRIGnmCqDn4h3sMOhgT+AP8JnxFg6vmQ
	7GfioltrUd00Lzku7pKI2sM8xB3VUsR3YjWzvCZ5sKABULY/hTpzjk/akuLXD9e3
	ZSDkY6ZsQo4S6QNbBgBfA==
X-ME-Sender: <xms:9aIMZh5Hyb7rCbMW7h2UiKAc9zw83liun9GGeVPgDKW38LIaZXWpRw>
    <xme:9aIMZu5XNu2XptuPSTbIFS6Nag7FMJAN-i9YlqQpyJ5rXBJqxA-5inDXWOzlMacHn
    m8YD8DJV7w_OXa-7ik>
X-ME-Received: <xmr:9aIMZoec6z3hE6bKSCYrEX3ww_0XCogB6O8NqUDUNi2QF96CFiMEcwbt54l2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvges
    lhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpeduudetudehiedvvdevveelhf
    egkeefffdvfeetuefgveefgffgffeiffeitdelieenucevlhhushhtvghrufhiiigvpedu
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:9aIMZqJbSq-UYVt5nWavVO2hMuBfV7kzqH63skr2oI1Fwso9vmsQQg>
    <xmx:9aIMZlJUmKK3JcrrILd7xR6W0SuCMfuRL0SaAhEOZ26hVGDGp_6Fbw>
    <xmx:9aIMZjwvHG8Xbechunyz-C0jKmqJlRkkBoVF-D3IhEzhNSaWve130Q>
    <xmx:9aIMZhKWXac4nVLrK3ox3oE21T22AN1xaRDenkTWQSpoHAUPBUJlOA>
    <xmx:9aIMZt-vriiPuEzZzncnOM0lTIq6EsW7d4bZEjAe_0QbEPU12m7RwxgX>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 20:29:39 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 5/9] platform/x86: asus-wmi: store a min default for ppt options
Date: Wed,  3 Apr 2024 13:29:13 +1300
Message-ID: <20240403002917.2870959-6-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403002917.2870959-1-luke@ljones.dev>
References: <20240403002917.2870959-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Laptops with any of the ppt or nv tunables default to the minimum setting
on boot so we can safely assume a stored value is correct.

This patch adds storing of those values in the local struct, and enables
reading of those values back. To prevent creating a series of byte holes
in the struct the "<name>_available" bool is removed and
`asus_sysfs_is_visible()` uses the `ASUS_WMI_DEVID_<name>` directly.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 127 +++++++++++++++++++++++++-------
 1 file changed, 99 insertions(+), 28 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 3cb907ee07c5..f87500d87f56 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -273,13 +273,13 @@ struct asus_wmi {
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
@@ -1031,11 +1031,21 @@ static ssize_t ppt_pl2_sppt_store(struct device *dev,
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
+	return sysfs_emit(buf, "%u\n", asus->ppt_pl2_sppt);
+}
+static DEVICE_ATTR_RW(ppt_pl2_sppt);
 
 /* Tunable: PPT, Intel=PL1, AMD=SPL ******************************************/
 static ssize_t ppt_pl1_spl_store(struct device *dev,
@@ -1065,11 +1075,20 @@ static ssize_t ppt_pl1_spl_store(struct device *dev,
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
+	return sysfs_emit(buf, "%u\n", asus->ppt_pl1_spl);
+}
+static DEVICE_ATTR_RW(ppt_pl1_spl);
 
 /* Tunable: PPT APU FPPT ******************************************************/
 static ssize_t ppt_fppt_store(struct device *dev,
@@ -1099,11 +1118,21 @@ static ssize_t ppt_fppt_store(struct device *dev,
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
+	return sysfs_emit(buf, "%u\n", asus->ppt_fppt);
+}
+static DEVICE_ATTR_RW(ppt_fppt);
 
 /* Tunable: PPT APU SPPT *****************************************************/
 static ssize_t ppt_apu_sppt_store(struct device *dev,
@@ -1133,11 +1162,21 @@ static ssize_t ppt_apu_sppt_store(struct device *dev,
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
+	return sysfs_emit(buf, "%u\n", asus->ppt_apu_sppt);
+}
+static DEVICE_ATTR_RW(ppt_apu_sppt);
 
 /* Tunable: PPT platform SPPT ************************************************/
 static ssize_t ppt_platform_sppt_store(struct device *dev,
@@ -1167,11 +1206,21 @@ static ssize_t ppt_platform_sppt_store(struct device *dev,
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
+	return sysfs_emit(buf, "%u\n", asus->ppt_platform_sppt);
+}
+static DEVICE_ATTR_RW(ppt_platform_sppt);
 
 /* Tunable: NVIDIA dynamic boost *********************************************/
 static ssize_t nv_dynamic_boost_store(struct device *dev,
@@ -1201,11 +1250,21 @@ static ssize_t nv_dynamic_boost_store(struct device *dev,
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
+	return sysfs_emit(buf, "%u\n", asus->nv_dynamic_boost);
+}
+static DEVICE_ATTR_RW(nv_dynamic_boost);
 
 /* Tunable: NVIDIA temperature target ****************************************/
 static ssize_t nv_temp_target_store(struct device *dev,
@@ -1235,11 +1294,21 @@ static ssize_t nv_temp_target_store(struct device *dev,
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
+	return sysfs_emit(buf, "%u\n", asus->nv_temp_target);
+}
+static DEVICE_ATTR_RW(nv_temp_target);
 
 /* Battery ********************************************************************/
 
@@ -4293,19 +4362,19 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
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
@@ -4551,18 +4620,20 @@ static int asus_wmi_add(struct platform_device *pdev)
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


