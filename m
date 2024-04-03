Return-Path: <linux-kernel+bounces-128881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912D789616F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B364F1C2308A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211FC225A2;
	Wed,  3 Apr 2024 00:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="lQu5IM7Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kBaFskUN"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989651CD04;
	Wed,  3 Apr 2024 00:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712104192; cv=none; b=A+mvySOlqvOKk5d9LmNn9ysgoNLqYMSOuSclWRb2nuh0ke0mfGN81oRLbPOJ+ntBqNjEmNRlAviI7lN2VBKvv9p21/JYpyEoDM6Nqs29W4Z1rBJ36cM83AIRx5NMUwAh2CQKgS+LOfMDdx6T30DnVunEqMyM+sjWr8jzLyOqeUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712104192; c=relaxed/simple;
	bh=xDrAjDc6P7boqNQal2P1FLi1EF26TEnE/T12TeB/Hdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7ajKaV8iD6mwKVpHF6BeVmA6NHcP2dfLm7xRGvfYA7SKNsepYEp7/P/ic7m0iy2mwoFBwFHxzv+BWrcp/UQCBHzmYBdyZi+OsY8X5gbkMHeNzhBKI750LFQb59MdOtfH5q32HHJ/fyjXz7xF5UoPmOYSGlol2Da4Yy9pNIACcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=lQu5IM7Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kBaFskUN; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id C8E0913800CF;
	Tue,  2 Apr 2024 20:29:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 02 Apr 2024 20:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1712104189; x=
	1712190589; bh=RJIIf+Rf3H/UO0CsECc6FASEH4kBHZiMeFi6O+VvvUg=; b=l
	Qu5IM7ZE/y0+pBsCUuRE2YwIqjMJKfgyVX7pEBKHaod+E147rzk3VvinLMUKUgEV
	N4SOul3GO2xefZcTko+N4HNALBaOgpZFn9TEHGIuvxVSOXW8VrxxqyXNviWjSz3J
	RDJrrmzpAyZiNyKrJSSWUgoEwq3VhV9ynVFn7eORNR1hRQgZVSYplcMUyXtynx9x
	ZbwjGvhMI50GrM6dWcs7RcQZqDUTNoleALn+Xm/mwTiJnOyPRsz2btOpGiUhngrW
	cLCXhi4zEeIf8bTsRntvYCww9W/LSaA7vxTDzzhpuaoJAaj7QrrQDTCnacoNd8/K
	ri7F73Bkr5lTelNiAGKAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712104189; x=
	1712190589; bh=RJIIf+Rf3H/UO0CsECc6FASEH4kBHZiMeFi6O+VvvUg=; b=k
	BaFskUN6IYIeqckO303fCx4F6efki98GsEJTSW/jbkDThehW9yf9DKwxEin4BEws
	te7Fwx/xY222Y2al+FXtECxsnad8CE2H3llY9K5QzSVU2kwLlmQ0EYB3mhwi8sJz
	6NW+jkBppb0nxnIMSzjpF72dj04q106jcLLl5C5x2GQstcI2l876QC53Ojl8jkQv
	TNK4SiQ5xJy59dE4Hkyiwb3vt4AX5XkXvZT4OoS6t7t9T+kcV4sAoWaW2kCYBMpx
	j+v21Kk/TqJcCkpNjlt2YY3iJt09ppXWEk2q/zyw2CghVPjhInteD9P3rkimskvR
	Fz82yOnjdBwCF9gmzL9oQ==
X-ME-Sender: <xms:_aIMZuvkHG5RUdCS7Oa0Iql6Q1151tpFSwik7XF7shLPXUU9lH06GA>
    <xme:_aIMZje2kvJ34HJ5tObB4D7N1lRFL1PiOplDgg-4nKJtI_E3nUSPBwNpW7pZHR1YZ
    jU6Jmn8JSUZ88kT22w>
X-ME-Received: <xmr:_aIMZpxXQbwgf4EI1BozZ7_-OOtlalf7I4RI0LkUfJUgFj2VEl85hS6Ua0DT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:_aIMZpPhOy3bAj_DetZNtuL64eh3zbVnAS7tuOWFmSMBA20-P5Znrg>
    <xmx:_aIMZu_h8LhMmNGtdAv4Yk6W50aRKqMHWTGWKe2GBoyV4qOJvYWTwg>
    <xmx:_aIMZhWJxzSTCj9y_9TAYYeNrZFXHYnAE0iSN6TJtfZAH-D_K7rPow>
    <xmx:_aIMZnfNF8YdulwB1vSxn3_rhjryXkzHFQ_LvacOSQA5XLp37ipldw>
    <xmx:_aIMZuxaCbUdpwJMmK_Ftd5xkU_jJa9_eJYm68oI5aYE9frpB1VBQlKq>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 20:29:47 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 8/9] platform/x86: asus-wmi: Add support for MCU powersave
Date: Wed,  3 Apr 2024 13:29:16 +1300
Message-ID: <20240403002917.2870959-9-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403002917.2870959-1-luke@ljones.dev>
References: <20240403002917.2870959-1-luke@ljones.dev>
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
 .../ABI/testing/sysfs-platform-asus-wmi       |  9 ++++
 drivers/platform/x86/asus-wmi.c               | 50 +++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 72933527d2e4..28144371a0f1 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -203,3 +203,12 @@ Description:
 		Set if the BIOS POST sound is played on boot.
 			* 0 - False,
 			* 1 - True
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
index 7867178a9121..bf36ac11ad02 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1303,6 +1303,53 @@ static ssize_t nv_temp_target_show(struct device *dev,
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
@@ -4315,6 +4362,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_ppt_platform_sppt.attr,
 	&dev_attr_nv_dynamic_boost.attr,
 	&dev_attr_nv_temp_target.attr,
+	&dev_attr_mcu_powersave.attr,
 	&dev_attr_boot_sound.attr,
 	&dev_attr_panel_od.attr,
 	&dev_attr_mini_led_mode.attr,
@@ -4368,6 +4416,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
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


