Return-Path: <linux-kernel+bounces-127298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B363689495E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F1C1C23D32
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779D417588;
	Tue,  2 Apr 2024 02:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="GES26GoJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tg9+1ajy"
Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A8817559;
	Tue,  2 Apr 2024 02:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024797; cv=none; b=mZtvFSn0uQHJxDme98c8EmwzSo/wi7AMF0aItsnQ20stdruZBA/GEPlohuKDMt0XTkCoLWxqaS18KlfSINMqDii3a6lqFOhw9W1Hr+X3AYULPRtbEGtzlBhoUI2KG1g+leR1WztQ/UkvFL7MW5Y8WMZ/oaDazYTaDt9Vy7XBXa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024797; c=relaxed/simple;
	bh=xykdxOfz2jEm1yIquNvZ1gKBij8yxhYzNxLswTnbRfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBrHNEjoYSrnX+vwFtUlJXDhPSi6rzaTxIMAOSiO2iR5ASve+0pZPrb3IXf+rveUVDB/6dIEQE8zGP84rI6nhu5nW/EtWSsfrRkOwBkuDpNfJKSnJIwZ9lBziyPEfoDgmeuI0/adZztoNS4x+M9wmd7Twl1ebgPu5sRP2aAjkt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=GES26GoJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tg9+1ajy; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id A308418000D8;
	Mon,  1 Apr 2024 22:26:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 01 Apr 2024 22:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1712024794; x=
	1712111194; bh=OCy0b+3c9e5ebi4YdsSvBDHKTUpcvrfM5ZhA2KWSXkY=; b=G
	ES26GoJ2x3kIUm5Np4B7by/gHKRWvbwJ7qkNFeEY+0+SJ5j7+q8/2EBSGH2zhD3W
	mUbyumKGvaTRWDkIvqLKwCIxZyQZriAGEceSBRwuMTtXjYdgdsoGEiP9TI80qjaP
	01uLBzTXbypCmWXJxR7x/uCwBH3Ktt3/62U9FN6CX3dQMtBPbqnzHVJk5Gy8htEj
	cOU2A1OTW4oXOdpOhce+AUAYj46aqatlNVsHK80c8PACh1Or/DOhHLoilyJkNQDW
	Q+nG0ljw2pg3bP0bfVvxoZKTpRC/OvydZhLjNYFw1u/xD7tcoJdRskJ0AfTTshiz
	+BfwFFsyLujpiez9GHN+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712024794; x=
	1712111194; bh=OCy0b+3c9e5ebi4YdsSvBDHKTUpcvrfM5ZhA2KWSXkY=; b=t
	g9+1ajyJBfo+Ns2QJkn8pYnsabZ+7rWrvq9JztaldMWRaPYDSjlTMcVDYHzIZDTQ
	vF7Bm4r3I/K3RC6ojDMpsy6nFx4OJSWY/9ty4Gj4wAeMhgaIKTwT+qaPzUjtRMG4
	ORozdDDIn/PfE8rV7riJ9HCP3hiNIEgufeQTQ2ubMJkGXj3ArVUTW5ocqYq5+8RU
	T/g3N19SAWy9tOrMBZGHjATa6vbeM8fm7GdPjkxr6FlxPY26euyYemjdGVPNhY52
	r7Gitu1rUsrW8ZAmNoa7I9BjUNNXm5tXH0LRRF/IU76KxQb3WCUMxJKGs/IEdZZD
	qB9tH9L54apupVbsl21+w==
X-ME-Sender: <xms:2WwLZrkG1JjHPLkGsZzJrHyeFvGMgAcDhKlo8mXeEBD_YYPjdBubxQ>
    <xme:2WwLZu0u03goD2sgBdn8BPTXHGrdYfp3XkHaFv7aTvMTDQaSJO7zHA1xoBx7VhRDk
    KbLdqysoXQMoHa75YA>
X-ME-Received: <xmr:2WwLZhpB8O3il6Gnn0_8qyJOYmTemUAdjWdbE6DhodTv0TSW6qA1CPSItpYq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:2WwLZjmApP4UVXspg9lDuLzbZm-epO1sqYiZdsnJBAWlDJ8lCCePsQ>
    <xmx:2WwLZp2SDRYx-Kp9n3MKQL_L0dSI6MMaeMyVch8WWQrcm0KLOyg9-A>
    <xmx:2WwLZisXI2WwunOKrb3qmV0YcHpKgRbpXK62wlsFZT8H7g4OoCRoRA>
    <xmx:2WwLZtUQA69-P9TDbhkdZTZbDxp0POz8l0yQK7NLPIseqVr3IyL1xQ>
    <xmx:2mwLZjqMJI18tf_8wN-8iKeABcxgZyvCtmbut9pvPOA9bZeYyBXMbSOt4QE>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 22:26:30 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 4/9] platform/x86: asus-wmi: support toggling POST sound
Date: Tue,  2 Apr 2024 15:26:02 +1300
Message-ID: <20240402022607.34625-5-luke@ljones.dev>
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
index b5bd42e5f4ef..b795f9c1941f 100644
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


