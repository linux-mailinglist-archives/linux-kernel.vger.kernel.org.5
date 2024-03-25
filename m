Return-Path: <linux-kernel+bounces-116556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EFB88A866
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27BDDBA7155
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A67F161337;
	Mon, 25 Mar 2024 08:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="HHXlbh2C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qDKLBsoq"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398D6148834;
	Mon, 25 Mar 2024 05:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711345835; cv=none; b=jseezxeemhKSm9MOd552H/xxheXf2h52dIPkybxyho8yFMgJnyEwunG8rVPqa2fhNCOo0Cc1PUTy07+LpI/ZOfoBbvgh1NFq6kd3+QSOGbS/bXGeej2hLg3D9rYlivQ7VeuKZYI/eG25CFg5VnKUkJ91nwhmq2tGQx7ywFgEz4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711345835; c=relaxed/simple;
	bh=ZdcfXpihbbQEwKIkgL1dODkb3keZi0sbRmWnhwRmT4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/uGRCAvGZSm6S4PiQjp0TGkVwHnpC1Co45b2oimScLuhfxt11Y0RBz73u+lUyVtZnRsbCwEhnn0WmG72PlZomcD7LyCGjkt8pphZkekjHv8okbbnz/zib2GI5QPCtZsjGm4HN2gHzMRY4K3uF8zY54VYXTPeBHhEQvlP/Xrodw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=HHXlbh2C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qDKLBsoq; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6D91C13800F7;
	Mon, 25 Mar 2024 01:50:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 25 Mar 2024 01:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1711345833; x=
	1711432233; bh=f3M67v1Lcp0geLZRgsuKjZQbybJOk5gP7WvK57TATWM=; b=H
	HXlbh2C+J9dIUnGL7LhvVhvIJPzbIn564gJ6NyYZ6DZQFtdtTfgL2Gh5lZ2o+mK0
	VJYMdW1MlPJ0qNgNf3yyRcI2xeNm9/HgXtufNgCFMIBF54LdXFdqSiOOx/3MEgGd
	1FbQoXOfjeTbyeNOgsd/daM1tVp1ZzqIx9IUTWscSWecvUfS9IGDAr/ySpUhzgIP
	xO+1uWBUFiJIxRYCAGx8xiQbw6N0lsxHFl5EJviEWzphdZG/lBm8Fd9RJHJyvG7Q
	ik3/A02LsuDFy8sqyKzbkalWyDERxIgoSXnj7DJeBZqysgucAB/2iH7fqmG/s/N7
	gasDEaoppYDxOsRPmQVlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711345833; x=
	1711432233; bh=f3M67v1Lcp0geLZRgsuKjZQbybJOk5gP7WvK57TATWM=; b=q
	DKLBsoqWKWyWuC6KsBZoSsm98GxusIA0hE0KC1N3I7uveEZOYj+ipkASkaR/xqld
	E5TXINRfhl15xzTMH+QYVjrx5d3Zt8iS6cx93SXIUS7cMTeMB5uzWzKrsIIWXZgl
	K3jGSlGeQhoKwtPmcuhKZDgwZXz7yCd6J2QODrpC/lqkEInhqFn/g90Y+Y3agt4X
	0sv7sNu7Mqx6nYB6EAbNuJPO43rYQb8du5zdMkH+o+Gm5Mvs+ZKE48zZCvAtGMq6
	1a5wmDs0t83rm12x8eMLWjZ4713V2elnc/hX+DPl9I8+nR/2y1CCzgig/AMInLcm
	esyxoZ109wks0rXSd7gUA==
X-ME-Sender: <xms:qRABZlS3hHpb7Zq3iGm5TMM8DmFaO3yDmdNC5_Ol30xX1RDYV6iE2g>
    <xme:qRABZuyinYgBy-xaQPK72PX8RyHYbaP_XIvH3NpbDqJnhqfPQ7w6toYJWtLDlwpTU
    rmL9VthxCjQrjZOVxo>
X-ME-Received: <xmr:qRABZq2-bpxTObsvxHSiThFtkE4_M7ysz_UfUui-XvGG2V1_Rz5XCoAY7hwN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtkedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:qRABZtAJ1iyrm4V4rWo_tMbG2zTMHcRHUSCu8ZCqROpajShRFcOoAg>
    <xmx:qRABZujR9gua83MTWu6Mt3KQ5UkWkZCDwX14U3zYYUNTN5RuqGNVtg>
    <xmx:qRABZhpsdAvY_c8CBTicmr9NNfsTdVigDCV0qLdDmrET7DSLCPMIew>
    <xmx:qRABZpj0RiBHtAByov7ZGqFlijIpmaj6-ImUQcLWRX2eKlCo2NBNUw>
    <xmx:qRABZpWZnmJcRQ30GRCktxF7M2ITSGQnUkoQtprZSkhw9CQO1wZaAA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 01:50:30 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 8/9] platform/x86: asus-wmi: Add support for MCU powersave
Date: Mon, 25 Mar 2024 18:49:37 +1300
Message-ID: <20240325054938.489732-9-luke@ljones.dev>
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

Add support for an MCU powersave WMI call. This is intended to set the
MCU in to a low-power mode when sleeping. This mode can cut sleep power
use by around half.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       | 11 +++-
 drivers/platform/x86/asus-wmi.c               | 50 +++++++++++++++++++
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 5645dbac4ce8..ab8e5ab1bba9 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -202,4 +202,13 @@ Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
 		Set if the BIOS POST sound is played on boot.
 			* 0 - False,
-			* 1 - True
\ No newline at end of file
+			* 1 - True
+
+What:		/sys/devices/platform/<platform>/mcu_powersave
+Date:		Mar 2023
+KernelVersion:	6.10
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set if the MCU can go in to low-power mode on system sleep
+			* 0 - False,
+			* 1 - True
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index de338f7180e0..9927a48b2dc3 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1293,6 +1293,53 @@ static ssize_t nv_temp_target_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(nv_temp_target);
 
+/* Ally MCU Powersave ********************************************************/
+static ssize_t mcu_powersave_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	int result;
+
+	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MCU_POWERSAVE);
+	if (result < 0)
+		return result;
+
+	return sysfs_emit(buf, "%d\n", result);
+}
+
+static ssize_t mcu_powersave_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int result, err;
+	u32 enable;
+
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	result = kstrtou32(buf, 10, &enable);
+	if (result)
+		return result;
+
+	if (enable > 1)
+		return -EINVAL;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_MCU_POWERSAVE, enable, &result);
+	if (err) {
+		pr_warn("Failed to set MCU powersave: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set MCU powersave (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "mcu_powersave");
+
+	return count;
+}
+static DEVICE_ATTR_RW(mcu_powersave);
+
 /* Battery ********************************************************************/
 
 /* The battery maximum charging percentage */
@@ -4337,6 +4384,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_ppt_platform_sppt.attr,
 	&dev_attr_nv_dynamic_boost.attr,
 	&dev_attr_nv_temp_target.attr,
+	&dev_attr_mcu_powersave.attr,
 	&dev_attr_boot_sound.attr,
 	&dev_attr_panel_od.attr,
 	&dev_attr_mini_led_mode.attr,
@@ -4390,6 +4438,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		devid = ASUS_WMI_DEVID_NV_DYN_BOOST;
 	else if (attr == &dev_attr_nv_temp_target.attr)
 		devid = ASUS_WMI_DEVID_NV_THERM_TARGET;
+	else if (attr == &dev_attr_mcu_powersave.attr)
+		devid = ASUS_WMI_DEVID_MCU_POWERSAVE;
 	else if (attr == &dev_attr_boot_sound.attr)
 		devid = ASUS_WMI_DEVID_BOOT_SOUND;
 	else if (attr == &dev_attr_panel_od.attr)
-- 
2.44.0


