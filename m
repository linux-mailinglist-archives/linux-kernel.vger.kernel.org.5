Return-Path: <linux-kernel+bounces-127257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB2D8948D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6918284E19
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B5914A99;
	Tue,  2 Apr 2024 01:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="uAOHm4W5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VqmFyQpX"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC05E17588;
	Tue,  2 Apr 2024 01:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712021743; cv=none; b=MZy/MOAztRbX97DULJ2+h/fYvwwPLWKWV8hxkPREAdkfxb9qB0jLPscyZNVcwRK9oZNdrx/kwpB5AsNQLyN72xaCF1X6z0J3GGToVmVmWUTuWPqTrXMXBwimoDyWDw7cj6axoD3Hx0sHUPDO6a4f71UbfnS+vmzjBnqBh9vkgn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712021743; c=relaxed/simple;
	bh=B+Xe+RhdulHyjEF5aQf1N4ZtOVABSIAh+4mj8BwCcYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aR/dnvPaZbYHk37hj9oIV1jAXAHiusu4mPiC0sb4B9OQXlGpR6ESFLo8Ai/3XHhK7Hg9BHb3eRBfo2m5/nNs/A13hKf34fbjmKXYDjxhJ095P9QxSQByMgzPqCDqRLGWWLiy1ZBxaOX7OYCN0UQXP9ssbe6+mwL2OGSG8Fm0fzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=uAOHm4W5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VqmFyQpX; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 9A1D21C000CA;
	Mon,  1 Apr 2024 21:35:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 01 Apr 2024 21:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1712021740; x=
	1712108140; bh=p0y/6qz2boqJMyIjEzVzES4qtksoRSl4qOsq7TVgRYo=; b=u
	AOHm4W5pbE+0TuFkGAUp82b/5SZsfTkUIrKKllu4UpSDToozbbJRw6y+ZFVT0U74
	UROv1V+m8/fgVwayiPjQVdPO6Iu7vxRjyc/eMAzC3yLz4LG3tlufGlf4DitgJrbq
	830+u7fhkDOB9Cv3FU59ZRRFlreJnfjL38wqywZP6Z3+1rSJK/LMG/GG/D2RfNpA
	EE+YQimApaD8X7P5RbM43LfpK73YXt51VnGMAvjX0RAeLDRA3fc0zzGGvIcaRW7Y
	7J/gf2Sch50AHof41lGsLkCknP1wBSKj3Luv2cXQDjHdVU0363b/wuA/apy4ohs/
	IZocvdpY0aKo3TfxqxcCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712021740; x=
	1712108140; bh=p0y/6qz2boqJMyIjEzVzES4qtksoRSl4qOsq7TVgRYo=; b=V
	qmFyQpXRgP5GQ/DU92ii34PjCPW30VH6Y270W57frEBYx/b5BrJ1T2I8GX0UKm/r
	oHScH8O9WUmcE1Tvnw30/KuNCDRtBWUYD30zMGDv+DtCDj36MOW0cY3vgedRR8Mi
	Js927e4O48HXGqLtIzcMTdgnEZL9gLQ9uQPidof4otjmSKzntNYbEQMrWKddx6kb
	3sjSlX09SlHe6oLnVSfmhY2SEQ7KZHb5iz93Y+VILp2+3aC71Ano6nvOgAokz3Af
	/lgpxxZ5kcrV+e7WkthvOgRABPieHHU5cnfp//NPVvRSrb6MVBI5hUYdvGxsQp7D
	YGOK+UWPPEPdGqtxc4zSw==
X-ME-Sender: <xms:7GALZsuo_vnFr7AXlXaWFYIKcohwDp3a9xTvwju8ZCnxFkplsSSa1Q>
    <xme:7GALZpdcLirwzFjGFg4whIOzSfz5H2RIUpvRDZCl5zyt9IIsqg7OQyZ5m4Gk-XfjI
    wpX9Rs3SMtVclwz-l0>
X-ME-Received: <xmr:7GALZnxugeGrAT5qeUDh2jE0-h_ybmkzcVoqUWwdt6TcUlRfRQxMSNrwUnoV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:7GALZvPekvQ7wGsPxbGCCzhqNCu8Yf993x7QB75NtwzJykLg3_hl0w>
    <xmx:7GALZs8DH5XzOvBnx1dGGOWpHTapvAv-fqoqqzTtEUd6k8o04laVLQ>
    <xmx:7GALZnU1W-GXJUi1gznc6kaQ19E3W1o0JE03_ixl0Lgfq1IrflosiQ>
    <xmx:7GALZldyVhb4CP7OJMbMpkh-PMesF3jyKYma8fptJL_yLqyADbJq7A>
    <xmx:7GALZszWY74jwIdNalgfjy_xOO0rdnPb2g570GLo2KzQGZ8qqb7_bZeQBN8>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 21:35:37 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v1 8/9] platform/x86: asus-wmi: Add support for MCU powersave
Date: Tue,  2 Apr 2024 14:34:52 +1300
Message-ID: <20240402013453.18205-9-luke@ljones.dev>
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
index ec249eca0d94..a6b648457908 100644
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


