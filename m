Return-Path: <linux-kernel+bounces-130768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20694897CE4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6A728C534
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFF128E8;
	Thu,  4 Apr 2024 00:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="jAIN0kFz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fby9lLUd"
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D7FDF60;
	Thu,  4 Apr 2024 00:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712189844; cv=none; b=Sf9ER2ETU/5YmiCPg32asKsg78gorHd7BDuvPNt6DZ+/TL8rjYDVenCeCeu07q2hAlXQWwg/LcmSU/OCF9RRJLDaoJTqjnRHQJanL8CtK1wOqR19Grg8CJ3RhoWGt9tgabHr5s4DxpqozZNVroGk1SnqPwOFmyGs5Fq6Bci0xqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712189844; c=relaxed/simple;
	bh=Mz2Hn9Bbhw910i4Va4lX79i4MDQkEifZDcencG6pzOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4kespmac/hlGb+QyinD1XP8LKR00zAgmQpAJsLoU7z7JIiNfa/v/VisHkxzM3PIz3d5tLi15wansQsMMHKwLiUbX/pzhh3j5/tAnFa/4UR+7qz1+LPreDOSueEeC6iHSsoTy+cJocUb8fx7WrP6l1rVcXTx+Kj2xyXSV6eq0Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=jAIN0kFz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fby9lLUd; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4702918000DD;
	Wed,  3 Apr 2024 20:17:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 03 Apr 2024 20:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1712189840;
	 x=1712276240; bh=tL6GKGUnXV/u+rWud7+JFDCJA0/ShoGl8Oqjq39YEUQ=; b=
	jAIN0kFzBkzRHNWYK+/0Veg1LXl8WK+61kAESsD042e3wrD5DHuagB/X5Z34E8yp
	1fF5TDHWmxQCFsNSXHx4e2/AhnollVEwkGGJoOUnW3p/V71FaLnU3JjBFPxO/QW2
	hIlwqTcE4enqnFSv8aAsln5Ewox09Yj2I3+o6ZYTNi3Ry0bRu6spKKcOx+IWMikb
	qHvonaQ8crkgIE0ydrnNQBeT8ATAXdqPIf9Me9er0cVSi4xy3VjdjzKFibmI7avT
	Taxm2ZysOfftWhUQJ4vxt6U935G+6/8j+JMTsOoAZPOwybkFA/vZLqq42gvMASUY
	/PK5JyRAJ8x9N6iJSexSlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712189840; x=
	1712276240; bh=tL6GKGUnXV/u+rWud7+JFDCJA0/ShoGl8Oqjq39YEUQ=; b=f
	by9lLUdqxncsltzmyzger4bnnJDSXHAkiCrWR4Y+fRuZpNww9PhF5hTOIvZxF87z
	wJ+q/UhweoQi5cgAP2Mss7UEQrqkCDVtvvME7pi6dD+5QLzreXIZgXSVxDvV1Pn+
	uv7ia7LvmjLrdDYtIO6OL1gMLtzhcNznZSj9f/d6mtVvKqLjl7DLonezuM/DONjz
	XBqNT2Ti+5eAcbcK+jn1jZTU7yOfCWi1lz1bxwZFQL4otowr/ZTsowR5nQfmZW+2
	L5PQ/PQ8b6XVZkcvuU06bD8pZKQbgNFDSnbUuXQWjIikWqvZOrlaNXB3sqh/ijx/
	l+LQPs8b7ddqULKWkJu2w==
X-ME-Sender: <xms:kPENZltHP20Q4Any-800UJ7X9f-f9XP9qO7EHL1JDcKjrHN2No38sw>
    <xme:kPENZuc_51f8iGEhSQugJ5RrAqX9bT2YhY5SGdpicmT7ssDzfgTckZ53zE6PJaOVT
    p5vu3a4Ig6jtLb2Zk8>
X-ME-Received: <xmr:kPENZowXNGMISqarRjRrnzzr8xCCuAcyuPhpjLkpE01QhQ-51SyI0pmOIaVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvges
    lhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpeduudetudehiedvvdevveelhf
    egkeefffdvfeetuefgveefgffgffeiffeitdelieenucevlhhushhtvghrufhiiigvpedu
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:kPENZsM6SWwCyHExOnBdfCMlwb1iN8aNvQCLYjJK20jpdUSp-doWVA>
    <xmx:kPENZl_7AGgFk3yXZgBZJiINfvfE2ALN1b_mvomfOHvwwdP9cqV65A>
    <xmx:kPENZsX9vMinCYbt0HGHk2eqCO2coFcD60eu7TXV57lmi9bILIt9eA>
    <xmx:kPENZmecsH5SRJ1MKmL4eez-GGuGF4Q_Qi-TP0_NBLj1tEEk2cFdyg>
    <xmx:kPENZlw5SVz1c8-Can0xdIHe6-VadXjyiLfnP8028ocNXS6VmrwYBMlM>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 20:17:17 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v4 4/9] platform/x86: asus-wmi: support toggling POST sound
Date: Thu,  4 Apr 2024 13:16:47 +1300
Message-ID: <20240404001652.86207-5-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404001652.86207-1-luke@ljones.dev>
References: <20240404001652.86207-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for toggling the BIOS POST sound on some ASUS laptops.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       |  9 ++++
 drivers/platform/x86/asus-wmi.c               | 51 +++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h    |  3 ++
 3 files changed, 63 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index ef1ac1a20a71..72933527d2e4 100644
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
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 6896d056d227..6c353b8e8da9 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -2115,6 +2115,54 @@ static ssize_t panel_od_store(struct device *dev,
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
@@ -4207,6 +4255,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_ppt_platform_sppt.attr,
 	&dev_attr_nv_dynamic_boost.attr,
 	&dev_attr_nv_temp_target.attr,
+	&dev_attr_boot_sound.attr,
 	&dev_attr_panel_od.attr,
 	&dev_attr_mini_led_mode.attr,
 	&dev_attr_available_mini_led_mode.attr,
@@ -4259,6 +4308,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
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


