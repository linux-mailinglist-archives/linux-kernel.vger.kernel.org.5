Return-Path: <linux-kernel+bounces-127303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B1A894968
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8551C244E9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A4D18EA8;
	Tue,  2 Apr 2024 02:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="a6dNI14p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XS+AZFRp"
Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121AF18633;
	Tue,  2 Apr 2024 02:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024815; cv=none; b=YvkjyrlfqLRQ/1kpWEgXfBrQkPyIUq2bYE3y3MRF2kBveBP1XRD4KZWPEzPkj62GDHLgHERB6qnVBceSYbBwlWh8RAJvrKVhovX3iixsZCwL41mFI0d3c13fhzn+9BZxiFYgw/Q2MFuiQ6qySEweVkR+jCS3CddILCF3EAXfuxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024815; c=relaxed/simple;
	bh=n99dCLRp8ISXkNDLjTLaMp+/5Ar652WbbI/D0ElRLqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2SNIpPsfPAL32TBl9195JNnLP9bObW3Qm1b1ssu1OTFzvWVza6Q9vypIK4OW0f4ibVyjHLngXldmQ3WnsdV9F9v2y+B44xyJ3lbHaFDAdVAuLi1+e4nXzZ/M/LIfNhJ6n6XsO3cYCrhUYLcKyzmaJ7FHVOggX+MqtLqrsqRQL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=a6dNI14p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XS+AZFRp; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id D152218000D8;
	Mon,  1 Apr 2024 22:26:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 01 Apr 2024 22:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1712024812; x=
	1712111212; bh=7QfXQgaY7xZyYxNLvLcve7hd/L3NfO6jXnYr5RR0nC0=; b=a
	6dNI14piOmudojHpxfnMeKbl8gJBDouXT77cYUD+/+yBaT4LWYxDYJUj83sHJJhu
	XINoVBkG5OHCvIplnZyE1FCYoOaW13bJdBtrmsx1hI/2kJrOkBVKyEmK6C9Mdjvi
	nVxFu5xKUHRFFNVdh8rerHkhR6hB4RrRQVufyjeVKMuI4lFHPmXoQH4tlMXuK7RQ
	xxawiPsH3Xv1b8+nsrySeUvxIWgC2d9+2E/7lzaRp9rj5fhyFckrTjgEp3JqY5H2
	c0Exaob0PHozH5aDd5Mu5eZ6s1yje6wMSdosEAnWkQExV1Ye/cpPuiaTVkX29QII
	QXBGP9WTL1TveOtAMM5TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712024812; x=
	1712111212; bh=7QfXQgaY7xZyYxNLvLcve7hd/L3NfO6jXnYr5RR0nC0=; b=X
	S+AZFRpfs5esCT+MCC9ZbEUCith2eUbdNZ2FY4Zdvf/FA0f9lIfs3jVl+rQhgV4N
	//E2Ln1R38vkr8QQrCGPxSz3KNjuJkZ3GjYeL5qGG71uKojp0SLZurslebmbe87C
	bJd5xLOEUEg0G12NzIruExNaKjTaemp4uJ+TQLjggVPqn11rWE6er4xPAz88teyy
	nTIZ23bKit9dvtOGKlybRnhYppukoYOgViN5zqB/rHoJlMBliy4kIoN41RmVgCnA
	oiOWow5cxaFH7Iy35Lw8QaV6f5MF8IcUetzJp2gcNcJO44N3LQxGotrhVThyYNmD
	R162EGRD2oFUL/nF5q9Gw==
X-ME-Sender: <xms:7GwLZsFT005YtRXZneLlczoKHWOdOEJzh3RAUpcuq7PLU98J-HXNHw>
    <xme:7GwLZlUrHEnl5A2Qg6zkw3j-7RbLFej51WxfUaZnnEpAQdQlYvK_DOK9LYunBdPj0
    cPWvU13PtcPMk8mWx0>
X-ME-Received: <xmr:7GwLZmIpqQ-JRa4wErOHehSopPk0DPx5Tlc5ZLKbnQPWhnnuKLnzOmDPDcli>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:7GwLZuEWcA3Dw40vKWtJbwxZUs7LJ31d62DAkV3xhjrwpEeKeH5J4w>
    <xmx:7GwLZiWo997RzMykOj3Uj_4l1B0aHwEUpA-ynVuRI9b6x2LR9nowow>
    <xmx:7GwLZhNyhgmlgGcs68p8qbK3p3uJkgw3y3iTY2nujkZwzyqo_3q3oQ>
    <xmx:7GwLZp013e7P2i8eB_5ltgsFDIH-ZYgVJDUKUc9W13YslJALWQst6w>
    <xmx:7GwLZkIrMalHlaJ0cc5Bqtxm5Pex2DVwB3JYrLHg8fLbWgYiCr9EgezO3Sk>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 22:26:49 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 8/9] platform/x86: asus-wmi: Add support for MCU powersave
Date: Tue,  2 Apr 2024 15:26:06 +1300
Message-ID: <20240402022607.34625-9-luke@ljones.dev>
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

Add support for an MCU powersave WMI call. This is intended to set the
MCU in to a low-power mode when sleeping. This mode can cut sleep power
use by around half.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       | 11 +++-
 drivers/platform/x86/asus-wmi.c               | 50 +++++++++++++++++++
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 41b92e53e88a..28144371a0f1 100644
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
+Date:		Apr 2024
+KernelVersion:	6.10
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set if the MCU can go in to low-power mode on system sleep
+			* 0 - False,
+			* 1 - True
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index ddf568ef8c5e..cf872eed0986 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1292,6 +1292,53 @@ static ssize_t nv_temp_target_show(struct device *dev,
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
@@ -4299,6 +4346,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_ppt_platform_sppt.attr,
 	&dev_attr_nv_dynamic_boost.attr,
 	&dev_attr_nv_temp_target.attr,
+	&dev_attr_mcu_powersave.attr,
 	&dev_attr_boot_sound.attr,
 	&dev_attr_panel_od.attr,
 	&dev_attr_mini_led_mode.attr,
@@ -4352,6 +4400,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
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


