Return-Path: <linux-kernel+bounces-98363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 418A887792B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B057428148D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AC43A8C1;
	Sun, 10 Mar 2024 23:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="BcdrCg40";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c8TDp037"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FAC1E51E;
	Sun, 10 Mar 2024 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710113856; cv=none; b=Yl6VPgWDFfpryzHrnMAxh8qS611JIRxDJDCHxGFlFdY8l0aQWNwjm3hnk4jSlx+Zb/W/FTi+y1WEzXGOAgaGjx33t9RKB6jBsX2P9eeWwstyPGoCR6p5aixdMRQs0SVMhsAOf5LKyXMmcXLRqB6yqaF6rPXFC8+cIIYf09y1vno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710113856; c=relaxed/simple;
	bh=6BFpYmAbSJFTzloFuLEsrFt816vbVb/XhUp9+tos5Po=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oXYBYTXpisnKv1awGlvyesiUcNoiLbMTIhvN5ocrNy4wenmX3tlMaRpNk/nw3gzZ/+hMcgLTilsPZpOekRv3giT3sQkBB7whGf8uU1MFYd4CI4/SaSczORNH0OsbeCnWWPkpTQX1HTmFFFKPPtlKeiI4n1V9c0lIWfIOza8VBR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=BcdrCg40; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c8TDp037; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id C38771C00088;
	Sun, 10 Mar 2024 19:37:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 10 Mar 2024 19:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1710113851; x=1710200251; bh=MsX57JNWXWXgy5MXZkAs7
	hcdsrp6bnwtQX2LmRVdZMI=; b=BcdrCg40nAR5G8tjRzj1nAUazVGlHI9aTc1Zs
	EZCqhAHS8TNpf+Fc+o+8tj5zVSGBVheedFvKW3SV+Jv7tPTTDNoMKQEQc8TPktcA
	dcS832Jvn0NEQ3gchDTTPHiaxo/51HRzdp55zW7hFdwzsqxsT+plZzHY053nEksy
	JwRQhoZkoq+gRB8PeEzy7zyq0Pg2GJH6g8Q6GSsnY9TtBdTkP9KgfT4SwuiZ+WdO
	eI0XSBDQILAL4+bi6q2lWyCFbdhM0iScx+46OesM+6dZYZdNKnvxvq2t1pLjRNwy
	7pAgD0s/lp4bURnCSESuwI3E6AlFAjuLy+vb7tFfZMSvXLd8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710113851; x=1710200251; bh=MsX57JNWXWXgy5MXZkAs7hcdsrp6
	bnwtQX2LmRVdZMI=; b=c8TDp0371iDMNhwk/TaMsSkdica3RottXvn5N2o7DPWK
	WENAbP6zQx9ojhG6RoUG79hJsgeYpi7UZjW6DyDlI5W1hhVvHKJtpW+l4Yyz2Zrh
	Yg1doxLTY9PnYHNGfthk8BKlhxFQwc4cS+/6brAYIlObl/V07lGlzqfsG4W7cqss
	6HPY/2a4LlEs9EmPxWvkP+bvXI18AP3JhnTOfMoiY1UpjDrEjaYC9oPeqC8YmInC
	ssN1zXux0Kq0NYCXRHP6tNCsvvTj6JxX3OfyZWyD7zKCrosCfHpNVwQhEEcxUwA2
	knWacveDn8jqeOZhfLK0YwCiuEo8lR5cUjDGsXWclA==
X-ME-Sender: <xms:OkTuZUN8J27-Lrymk9uzNJm4wfXMCGpwIaAtB14xDkcGyvClCiq1BQ>
    <xme:OkTuZa82LlB8rfmKD_D6FnbqqumfRaON3OfPOA4labPuliZjdHw4sLsP8ERdpSBz7
    0wuXPDp2VOOrlk3b24>
X-ME-Received: <xmr:OkTuZbTagsu_anY2G-cGoA5BlVfxbEsySmNDzyF3UoXidgYi5NSKVu7rOhZS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedtgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpefgudejtdfhuddukefffeekiefftddtvd
    fhgeduudeuffeuhfefgfegfeetvedvgeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:OkTuZctCCDIusakzXXgbcpUJygE5R_0pcAed22ezgLOor9HO-1O8-A>
    <xmx:OkTuZceW7pJol2G8--af554rJSnWHCLG2xjPbjgyqMF0Ey60xGbFTQ>
    <xmx:OkTuZQ2ZZ_2c0FUba0RBYpomeaV7bGqycbi94jLlMI3wxLItC_UF8g>
    <xmx:O0TuZb6LIFX7yVS2kAsUPllLfsaQoIh5mBX4pz00xIgKnUthN5iphcJJFlI>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Mar 2024 19:37:27 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] platform/x86: asus-wmi: store a min default for ppt options
Date: Mon, 11 Mar 2024 12:37:22 +1300
Message-ID: <20240310233722.30884-1-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
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
reading of those values back.

Secondary to the above it renames some internal variables to be more
consistent (which makes code grepping show all related parts)

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 141 +++++++++++++++++++++++++-------
 1 file changed, 111 insertions(+), 30 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index e4341abb71e0..482e23b55e1e 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -272,12 +272,19 @@ struct asus_wmi {
 
 	/* Tunables provided by ASUS for gaming laptops */
 	bool ppt_pl2_sppt_available;
+	u32 ppt_pl2_sppt;
 	bool ppt_pl1_spl_available;
+	u32 ppt_pl1_spl;
 	bool ppt_apu_sppt_available;
-	bool ppt_plat_sppt_available;
+	u32 ppt_apu_sppt;
+	bool ppt_platform_sppt_available;
+	u32 ppt_platform_sppt;
 	bool ppt_fppt_available;
-	bool nv_dyn_boost_available;
-	bool nv_temp_tgt_available;
+	u32 ppt_fppt;
+	bool nv_dynamic_boost_available;
+	u32 nv_dynamic_boost;
+	bool nv_temp_target_available;
+	u32 nv_temp_target;
 
 	bool kbd_rgb_mode_available;
 	u32 kbd_rgb_dev;
@@ -999,11 +1006,10 @@ static ssize_t ppt_pl2_sppt_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result, err;
 	u32 value;
 
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
 	result = kstrtou32(buf, 10, &value);
 	if (result)
 		return result;
@@ -1022,22 +1028,31 @@ static ssize_t ppt_pl2_sppt_store(struct device *dev,
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
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result, err;
 	u32 value;
 
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
 	result = kstrtou32(buf, 10, &value);
 	if (result)
 		return result;
@@ -1056,22 +1071,30 @@ static ssize_t ppt_pl1_spl_store(struct device *dev,
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
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result, err;
 	u32 value;
 
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
 	result = kstrtou32(buf, 10, &value);
 	if (result)
 		return result;
@@ -1090,22 +1113,31 @@ static ssize_t ppt_fppt_store(struct device *dev,
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
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result, err;
 	u32 value;
 
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
 	result = kstrtou32(buf, 10, &value);
 	if (result)
 		return result;
@@ -1124,22 +1156,31 @@ static ssize_t ppt_apu_sppt_store(struct device *dev,
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
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result, err;
 	u32 value;
 
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
 	result = kstrtou32(buf, 10, &value);
 	if (result)
 		return result;
@@ -1158,22 +1199,31 @@ static ssize_t ppt_platform_sppt_store(struct device *dev,
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
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result, err;
 	u32 value;
 
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
 	result = kstrtou32(buf, 10, &value);
 	if (result)
 		return result;
@@ -1192,22 +1242,31 @@ static ssize_t nv_dynamic_boost_store(struct device *dev,
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
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	struct asus_wmi *asus = dev_get_drvdata(dev);
 	int result, err;
 	u32 value;
 
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
 	result = kstrtou32(buf, 10, &value);
 	if (result)
 		return result;
@@ -1226,11 +1285,21 @@ static ssize_t nv_temp_target_store(struct device *dev,
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
 
@@ -4301,11 +4370,11 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_ppt_apu_sppt.attr)
 		ok = asus->ppt_apu_sppt_available;
 	else if (attr == &dev_attr_ppt_platform_sppt.attr)
-		ok = asus->ppt_plat_sppt_available;
+		ok = asus->ppt_platform_sppt_available;
 	else if (attr == &dev_attr_nv_dynamic_boost.attr)
-		ok = asus->nv_dyn_boost_available;
+		ok = asus->nv_dynamic_boost_available;
 	else if (attr == &dev_attr_nv_temp_target.attr)
-		ok = asus->nv_temp_tgt_available;
+		ok = asus->nv_temp_target_available;
 	else if (attr == &dev_attr_boot_sound.attr)
 		ok = asus->boot_sound_available;
 	else if (attr == &dev_attr_panel_od.attr)
@@ -4566,6 +4635,15 @@ static int asus_wmi_add(struct platform_device *pdev)
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
@@ -4576,9 +4654,12 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->ppt_pl1_spl_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PL1_SPL);
 	asus->ppt_fppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_FPPT);
 	asus->ppt_apu_sppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_APU_SPPT);
-	asus->ppt_plat_sppt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PPT_PLAT_SPPT);
-	asus->nv_dyn_boost_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_NV_DYN_BOOST);
-	asus->nv_temp_tgt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_NV_THERM_TARGET);
+	asus->ppt_platform_sppt_available = asus_wmi_dev_is_present(asus,
+								    ASUS_WMI_DEVID_PPT_PLAT_SPPT);
+	asus->nv_dynamic_boost_available = asus_wmi_dev_is_present(asus,
+								   ASUS_WMI_DEVID_NV_DYN_BOOST);
+	asus->nv_temp_target_available = asus_wmi_dev_is_present(asus,
+								 ASUS_WMI_DEVID_NV_THERM_TARGET);
 	asus->boot_sound_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_BOOT_SOUND);
 	asus->panel_overdrive_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PANEL_OD);
 	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
-- 
2.44.0


