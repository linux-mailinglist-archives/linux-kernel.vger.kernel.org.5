Return-Path: <linux-kernel+bounces-130773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2430C897CF0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F254B29218
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33E81C286;
	Thu,  4 Apr 2024 00:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="Tq/5Wc95";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SNWUhbXI"
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781BB1B800;
	Thu,  4 Apr 2024 00:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712189860; cv=none; b=TlcD+OFmdwKRfGZaNu4zh/eNY8F5MS42pKVG+UU31EK7lC6Nf9yt/fA+3kW3QJfYH6aD5EBaUANrr81h6x4OV+4fiDtTB8RSgMRuHYdO5xgJoQLALLGcwQYOy4sGanNDqwknVuELwVI8eAKsk/FYe3kv3uWJry+OphgEutQ9Czg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712189860; c=relaxed/simple;
	bh=RigxiSjgWoFftuq3+PU0L2MA0yigmESUDun1HkWLGKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SorWKfrbqPu/2ZEFGSh5lmFVsZP8wIEuHi2MSFATHOVTAlBgCOiWpcRv2M7t35EIalvE3Z5yjVd0yti19rjsQMVDSbStMKQpCit3RNVZH9kyGDhlV+fAziD2KtdeHE9bP9oS1+PnsKcIXlKcaKRRJNNukp4gvgnWaKwzmHqxJsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=Tq/5Wc95; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SNWUhbXI; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2E0BD18000FB;
	Wed,  3 Apr 2024 20:17:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 03 Apr 2024 20:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1712189857;
	 x=1712276257; bh=7Az00aewtRWp5Y61/pH0rVHkKLXtEg51elHeqTyC75w=; b=
	Tq/5Wc95MFpvgByIlowrxezmgZ8xzqgxUyvGzRfBDOn6PwhyLOsoTzfCTRR1Z537
	xEU3Oij3S73L6a4R1h7GfElwNkfkY02tb6kE9NSs352IwCMPzXaS3MPg4mKJDbNR
	bB6UrfOETP1A8k2sQf+IFJEL1x1nZspQsPTgd03Oa9J7OsV6Aniia+R8I529BpLC
	O7+ebci/LfBMXx/TTfvFVmYv+R2hPlqNxuaSAAXsRVYYEpcUm/hMlVmR61IYY34P
	eA3cBjOBlwit4SpAZUZjeSXITf2Pr4WKrzGAqWHwHNK0fQnI1t3bfzKO6wuuzHad
	2lF7CUMAlXD0j8rrEQhLTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712189857; x=
	1712276257; bh=7Az00aewtRWp5Y61/pH0rVHkKLXtEg51elHeqTyC75w=; b=S
	NWUhbXIYF66PiJMfzUa6HbmSwjR9GFZRk74fL79TCxCGsYjNfe5bfL4/oihBf+ye
	OaE4r8uQjzCREeXSagHGX/Y13rNhZMg9YG/1paD1jfbk3iaTNkRCXJvETKW7SBT3
	ELtXceV9dEh9JG8gt1WrBgilGUe/g4KHNje7FMLGjnWcCyvC4vzMNmcfTN6UNc0X
	won02uik0FORX+nrWPEJvaj7AaPlb5IULXDGyCND6C2fLoq43FCI2pNhaJPf3mYm
	JRScBwm4txHmaO0T6nUAdXqX27zC2k2NYdyiWdDIgL9ufils94wh//SskAftgN9G
	3RK1FJxi0c0ma60Udw1og==
X-ME-Sender: <xms:ofENZtSgHgSnlg2Qyna6sCcFEXJgZvdksqW45goBVJ8RvlA1xjW7VQ>
    <xme:ofENZmwO76jX6T0APyZ85bxlzbSaFaHarDCZQjRLME8pXfwy46J_MymILbh_fZFHH
    hpA42zppa0x7yrmJtY>
X-ME-Received: <xmr:ofENZi2Erp8j2joyigBByVcRPxqZK3J6HPvSj-r1jdJK_819-ueD1JjCtp5o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvges
    lhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpeduudetudehiedvvdevveelhf
    egkeefffdvfeetuefgveefgffgffeiffeitdelieenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:ofENZlAhbuxW_7SEqCndKD7DTCKJcnyBES3p7aafpMOr7a35Yw4iyw>
    <xmx:ofENZmjT1e79b1SwdXQLJdr4wZvPz9zWUZIjqn77tOBRs1uGj5aIKg>
    <xmx:ofENZpoPwWE0u0FvoZyjApBvDX7IU9H-tSQmFrs6qvFRLNU6gk8OvQ>
    <xmx:ofENZhiSzXO63eXRwEtZRxLpz86TMuAbWu8EAU8RFDJy3j3CypaCrw>
    <xmx:ofENZhXjhVSdwvvMBpuICtDbF7W_xWpKjy0FkkRWxPMrZu8VmGgC17fo>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 20:17:34 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v4 8/9] platform/x86: asus-wmi: Add support for MCU powersave
Date: Thu,  4 Apr 2024 13:16:51 +1300
Message-ID: <20240404001652.86207-9-luke@ljones.dev>
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

Add support for an MCU powersave WMI call. This is intended to set the
MCU in to a low-power mode when sleeping. This mode can cut sleep power
use by around half.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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
index ab98f91e573c..d06d9e0c498c 100644
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
@@ -4317,6 +4364,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_ppt_platform_sppt.attr,
 	&dev_attr_nv_dynamic_boost.attr,
 	&dev_attr_nv_temp_target.attr,
+	&dev_attr_mcu_powersave.attr,
 	&dev_attr_boot_sound.attr,
 	&dev_attr_panel_od.attr,
 	&dev_attr_mini_led_mode.attr,
@@ -4370,6 +4418,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
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


