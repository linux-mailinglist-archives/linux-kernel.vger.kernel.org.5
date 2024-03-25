Return-Path: <linux-kernel+bounces-116560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8C988A0B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED932C531E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B02916190E;
	Mon, 25 Mar 2024 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="uf4Ae7xA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S39Fo3xH"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652DB148826;
	Mon, 25 Mar 2024 05:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711345823; cv=none; b=aaE7R/HcbEOFVzehCXu4EcXaJfpSQ2iC8P+1nw2EbAjFI9o9jfNoyZq1FbKV1VXSMcMm1PtKfvS3dSe52UN6o16SPVlruzr74YOKgQ7oYv7dy4/c7+S61z1WvVr42XFLsSuIJd3R2VzNs5hCu2ZsdZ+4wXu1QEqUHY1fKDhhHO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711345823; c=relaxed/simple;
	bh=p6viwjhIPG/4maAHg16dp/v0cv+yZfYIpNrhB6LD84U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIZFGoXA8xUqdf77ugMcStQD/B0dW/ebVmGEn6QWtakNT86ZmcoLNS8/IhK+2n6yaQEqFb9gui55PDFxD7KKqnTpucRAe3wBZKyktWaT4ZxvzeqBD7YeUvTW19LzGGmEWSIrr/FXTmS/KI3LkduQ4sp2haHll5t2ky+Ohbo2qso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=uf4Ae7xA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S39Fo3xH; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6C35A13800F3;
	Mon, 25 Mar 2024 01:50:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 25 Mar 2024 01:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1711345820; x=
	1711432220; bh=IhR5W2G5gfMUMiqo0xIhsNkDZHETXlmyvnRu3odf1MQ=; b=u
	f4Ae7xAfqLkWWuqCrsy80ddYMp5bbxuSQ2n34CjUhi4Kd9N2wrQ/I7vDHJpk7FIm
	aGPgc2UvDbZrJltlCyloq4UFYNmD0pPeOjz3tv+1kGh/dMlNpGlSOfymTaNCG0iw
	/EdK9eslJHpaG3bW7gtGbz5QwhhL1QTwgHkp3uEWL2pSilmkDepjT4xAW6tv8J/I
	+pQ2HppxlJDn2Ftx1Vor2ClZvwTDqcHSXRV5T4bSQVDP/D4hk8Nt2czRBR8NqOHV
	/nWesb1vQ6ZlWtLgZrF1wwAxGbgBtn2ItoW+uN5buh52CTPj9AFzHPb6aQkY8HRT
	vnLqxPp8vUYl8LbB5ap1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711345820; x=
	1711432220; bh=IhR5W2G5gfMUMiqo0xIhsNkDZHETXlmyvnRu3odf1MQ=; b=S
	39Fo3xHHZpBXMh1U0I9/PEoqqu8BT0ahdR81WasD4fSuFdS07dtHHi0gv3dkI6c3
	ixXkRwXxtvp8Kw3O9SiwhCzX0hBzI5XkTywEy5do+poTONVWuGap5gwp6sA4Tg0G
	jwhbbR3TxXGEvYIw5ZJQtLIy/jfRK/JpBjXJzFzsg4NTTjWuruF3gUwMU3bm+oUh
	gYCac89AEZ3M91X38j1Zr5/eKceO68DGE0EUzhuKvi8WTi5ULm5xVZlFxF7JMdMp
	sOYN8S02GDEVRC2MQLLsCfLMOOF/IbwyhbComv20k11yycIfShZxlgivdkpi9+dT
	9UebWucd6Y3aNMIZzTCJQ==
X-ME-Sender: <xms:nBABZrsAhxdJQrZxjh-_CH4GPb_7WhWBgCJSQi6ETfMymunOHKrQoA>
    <xme:nBABZsdtfW14ySdIY4q55PYIJqgMJPvo_cYzDs-hgIznTXoQM1hYcDC_ydZCUX7Qq
    DBmLy76wVzm-1OTwok>
X-ME-Received: <xmr:nBABZuzf3AtkkhYdPX-tfsCq_Kpk9wkkyaAYL1x8BRD9T1Lyun1i4wxHHAYn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtkedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:nBABZqPLrNgXX-WBvH3LOAUy-iyCee9Ktnkrt4Gw7qMtDP-huiTB_A>
    <xmx:nBABZr_qDtFkQAGFQk4sD5EvULi8e8Ggaf4vyViKCXasaQaS6k0dPA>
    <xmx:nBABZqUpPPVgrqiWVY-pMUh_KwzTWdRBRSHA-clxKZIT1Khe1LkPwA>
    <xmx:nBABZseKwWSoyN6TWn6YOjcHszz5RI_LkRdQj_1wFm7t5va-04GtuA>
    <xmx:nBABZrwKcidBfqkLFceED49fzO2n1ghdHShdIJF-z7zkod-GAMswBg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 01:50:17 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 4/9] platform/x86: asus-wmi: support toggling POST sound
Date: Mon, 25 Mar 2024 18:49:33 +1300
Message-ID: <20240325054938.489732-5-luke@ljones.dev>
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

Add support for toggling the BIOS POST sound on some ASUS laptops.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       |  9 ++++
 drivers/platform/x86/asus-wmi.c               | 51 +++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h    |  3 ++
 3 files changed, 63 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 61a745d2476f..5645dbac4ce8 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -194,3 +194,12 @@ Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
 		Set the target temperature limit of the Nvidia dGPU:
 			* min=75, max=87
+
+What:		/sys/devices/platform/<platform>/boot_sound
+Date:		Jun 2023
+KernelVersion:	6.10
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set if the BIOS POST sound is played on boot.
+			* 0 - False,
+			* 1 - True
\ No newline at end of file
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 094a93f24667..6cac9c3eb8b2 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -2106,6 +2106,54 @@ static ssize_t panel_od_store(struct device *dev,
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
@@ -4227,6 +4275,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_ppt_platform_sppt.attr,
 	&dev_attr_nv_dynamic_boost.attr,
 	&dev_attr_nv_temp_target.attr,
+	&dev_attr_boot_sound.attr,
 	&dev_attr_panel_od.attr,
 	&dev_attr_mini_led_mode.attr,
 	&dev_attr_available_mini_led_mode.attr,
@@ -4279,6 +4328,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
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


