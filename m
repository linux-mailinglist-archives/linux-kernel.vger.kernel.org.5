Return-Path: <linux-kernel+bounces-127253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C188948CD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B051284281
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D540C111A3;
	Tue,  2 Apr 2024 01:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="iAMm8R7d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PFU8mhr5"
Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DB2134B0;
	Tue,  2 Apr 2024 01:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712021724; cv=none; b=jynbf4snE3uI3pNE7jtT0FZ4tkzrTLJ9aaiNzzT1XKA/TliUhkkzCxW00Rvgid3xMMEnNGO4RnDgwSUmIExnSkheV0Ne6r7tWMKiQQPcrpQ3SnW+bU7UwWYDpeBVJiig1T2Xuv5ksCbQ1affuBZkQaLjTZHsds4yj1ig0P92W2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712021724; c=relaxed/simple;
	bh=OrHplRfcnZ2imM1ewc/Kt6UGrLNoK8qKbR3ImRe298w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CEU5voQrc6snaCoxTaxrw/cjWM7YzzGC5PUkqnBG0Qwjcl8zFRXsqJtejxrJF/WPhqz2vYGIFr1TqHWXk5SxUp12G+OWhCWA+IMp20/lw7apgeybKcEO5OdSNRfAtBkvB/PIQgOiFdVpYzZldILZ1UQT3sV/xKLxk4KPP4TvTII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=iAMm8R7d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PFU8mhr5; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 292AF18000C3;
	Mon,  1 Apr 2024 21:35:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 01 Apr 2024 21:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1712021721; x=
	1712108121; bh=CBr/0u1bSUYQwQ6YOzePLq+t60cDxs4sgmMsCMugwHQ=; b=i
	AMm8R7d0GZlut1/+lwInZai5HG0PWYpSeL8r5WZKDjToe+XFXkskl/p1XZxWYyix
	YPUn4y1OVskh5o/01xl0coFSHMs9lrKqdEUeBE4sg4p1UVaFOZeeZ+AVQua0B3PI
	pHEYkCXRfVYkp8VLjPrwDPfzaDDn585pe1QUouEmcYVqXJ0gos9onD8oIbK3Gn9k
	PMoL5qlCtVs6LhuFVtC00D9aXbT//zD8OvBG+okdh8qOBsf9xB3909u9AXbicGI2
	wKMC5jgRInAfovOpv8J7ZKNGPZn5EY4SMFul4Jg6MLQiw69O63bVcqtDp52v5Yd8
	J/g8m+HFaYmt3ViQF9cjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712021721; x=
	1712108121; bh=CBr/0u1bSUYQwQ6YOzePLq+t60cDxs4sgmMsCMugwHQ=; b=P
	FU8mhr5UReJZ0Ne48pRWe4UC/bQqZ156QtHQgwW8TsJKBn10hYESV93wfLoJC28W
	r24EK+q9f2spb00rvx/poDOzlOsUklcari8YMMW3uTVMy/Iij4ldFob0CFbiJvLk
	QWcoND66dJV/psPzTBlB5KNBNB7I1EEcPMqbL62AJGRLiNCk3Oa9jBcs0iYB+vfG
	yu/eoSQ7ORZw7o6BYIxW4DpX8NsHzNUXq97mEfwmPgD4P5wHmMcIXbkD20e4u2Rz
	jCNzxo13g4h+be69oTOgbaLlHmAaYPQoNlDLKt1clnKHAAzs1cz7mNqK37H7VdxZ
	3PVdzrAPc4bNoCyNtBZTw==
X-ME-Sender: <xms:2WALZmik5O2YhaOgE-eb9zSSoiVXY--6ep4HU1bKFhliENm3Lay4AA>
    <xme:2WALZnCM5b2_E2DNoy9v5c5kDS6-J0-VoZzQcXTdsi-0y-SdZ8uB4IytDXa3di6oH
    vctUc97Ue7307iR26k>
X-ME-Received: <xmr:2WALZuHDiaVJu0DO9ZfS_28Dw4rqSAGBKyGxneKImSVBacyX8rpqnICo47q6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:2WALZvT48zf5wybQugbYl8ETScZPLFvC2btGL0oaWSfb7naSQ08YsQ>
    <xmx:2WALZjz8v1nhFjDfchI38HSbZkT5HhkiLmsjEW6TL00zPfyTJhD2Eg>
    <xmx:2WALZt7pksM7WKNmFPZP7sJouPpQJqbwexIAveUIQ_wSD7LVRbcKOg>
    <xmx:2WALZgyZ8NKtDHgVCpEyU385d_RqaAElzh9-FNUJzmK1xfH8zlRvPA>
    <xmx:2WALZqnz41p6Bngb11biZld008dMivd78Ys8UeRlxsk6iPXNRsO-9BFHTJE>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 21:35:18 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v1 4/9] platform/x86: asus-wmi: support toggling POST sound
Date: Tue,  2 Apr 2024 14:34:48 +1300
Message-ID: <20240402013453.18205-5-luke@ljones.dev>
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

Add support for toggling the BIOS POST sound on some ASUS laptops.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       |  9 ++++
 drivers/platform/x86/asus-wmi.c               | 51 +++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h    |  3 ++
 3 files changed, 63 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index ef1ac1a20a71..41b92e53e88a 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -194,3 +194,12 @@ Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
 		Set the target temperature limit of the Nvidia dGPU:
 			* min=75, max=87
+
+What:		/sys/devices/platform/<platform>/boot_sound
+Date:		Apr 2024
+KernelVersion:	6.10
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set if the BIOS POST sound is played on boot.
+			* 0 - False,
+			* 1 - True
\ No newline at end of file
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index fa5735af7675..fcf976967325 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -2104,6 +2104,54 @@ static ssize_t panel_od_store(struct device *dev,
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
@@ -4189,6 +4237,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_ppt_platform_sppt.attr,
 	&dev_attr_nv_dynamic_boost.attr,
 	&dev_attr_nv_temp_target.attr,
+	&dev_attr_boot_sound.attr,
 	&dev_attr_panel_od.attr,
 	&dev_attr_mini_led_mode.attr,
 	&dev_attr_available_mini_led_mode.attr,
@@ -4241,6 +4290,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->nv_dyn_boost_available;
 	else if (attr == &dev_attr_nv_temp_target.attr)
 		ok = asus->nv_temp_tgt_available;
+	else if (attr == &dev_attr_boot_sound.attr)
+		devid = ASUS_WMI_DEVID_BOOT_SOUND;
 	else if (attr == &dev_attr_panel_od.attr)
 		ok = asus->panel_overdrive_available;
 	else if (attr == &dev_attr_mini_led_mode.attr)
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


