Return-Path: <linux-kernel+bounces-43098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9292840B85
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFF96B273FF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699F115B119;
	Mon, 29 Jan 2024 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="QtaHTFH/"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1655A159584;
	Mon, 29 Jan 2024 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545689; cv=none; b=AtyELXHNlMS1ge2qmd3TE6DlGccHydadtzi8SxWtVpCpHNmkObvPTekysnGxtj6J2W7PMxREeT+BPbYD9/ANfJ1DAjyfLZR2ynfR89+MsRT8SDxsCWzyTCaaxRLqjO/EDSEHs9dLgOE6PoRv4sGy6eMh0HGCkoQwQymjv9LreGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545689; c=relaxed/simple;
	bh=XPyEjE/NSjThDCbkP+v910TdNDZnze3KCcGGK4rItJQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C68/Rdtfij72OMm3Bd8SCdhAcfLeZPxsdLCFTiZXIzCLOu7Jfu5m4FYNQL++HcWQyraZXUX+SqLwnSVOEze1BXb9fjKzYVzdvAgWTEi9cwmPi+2XjLyvf4Onh5Jlz9myMuVFhLy3/j70YZf1KkkeRO25Mnt48RyJTqtUqXkgHMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=QtaHTFH/; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T5fM0N006968;
	Mon, 29 Jan 2024 10:27:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=NlZTDzTBH3fvSFLWZS7A61Ze30PaFxijMjapvhdkuCc=; b=
	QtaHTFH/F0YpDsnxxjF0IhYFWR+0/Y4VkCLEZ6Lg94P0wYjwN/i6RfVqrbrL4Z6G
	TjF/nTWLfKSnvYPlE6FUDKUxqykLNX3Cg9POGNWRVws+C1M3kqXAZC7FD9zk5h3L
	4TaPEvkbQh0dAUiAQa7NE03SkTXTfbNsGrSqKhe1IgwHSolx1MbM5ToASvK1XZO/
	EEvJJm8sA0m0j6GM+rmKZ/Qj1BZxHqbWsGTWzUHuo5o0EiblSHV2bqIT0oJXoibW
	veir8FVfSncGj0SQVyMz3AF/n5f0Bj8FFnU32XYpHY8rG5NT6qLK3pr5TKrSG1oS
	a51z2QgvJkzscEJnBARxOg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vvy4nta8p-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:27:57 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 16:27:45 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 16:27:45 +0000
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.204])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 88861820249;
	Mon, 29 Jan 2024 16:27:45 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 12/18] ASoC: cs35l56: Firmware file must match the version of preloaded firmware
Date: Mon, 29 Jan 2024 16:27:31 +0000
Message-ID: <20240129162737.497-13-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240129162737.497-1-rf@opensource.cirrus.com>
References: <20240129162737.497-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SsMX5iOukd5eVccGOIut1gKNvXHRdnn0
X-Proofpoint-GUID: SsMX5iOukd5eVccGOIut1gKNvXHRdnn0
X-Proofpoint-Spam-Reason: safe

Check during initialization whether the firmware is already patched.
If so, include the firmware version in the wm_adsp fwf_name string.

If the firmware has already been patched by the BIOS the driver
can only replace it if it has control of hard RESET.

If the driver cannot replace the firmware, it can still load a wmfw
(for ALSA control definitions) and/or a bin (for additional tunings).
But these must match the version of firmware that is running on the
CS35L56.

The firmware is pre-patched if FIRMWARE_MISSING == 0.

Including the firmware version in the fwf_name string will
qualify the firmware file name:

Normal (unpatched or replaceable firmware):
  cs35l56-rev-dsp1-misc[-system_name].[wmfw|bin]

Preloaded firmware:
  cs35l56-rev[-s]-VVVVVV-dsp1-misc[-system_name].[wmfw|bin]

Where:
   [-s] is an optional -s added into the name for a secured CS35L56
   VVVVVV is the 24-bit firmware version in hexadecimal.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 608f1b0dbdde ("ASoC: cs35l56: Move DSP part string generation so that it is done only once")
---
 include/sound/cs35l56.h           |  3 ++
 sound/soc/codecs/cs35l56-shared.c | 36 +++++++++++++++++++--
 sound/soc/codecs/cs35l56.c        | 52 +++++++++++++++++--------------
 3 files changed, 65 insertions(+), 26 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 4db36c893d9d..5d6aefc41e64 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -75,6 +75,7 @@
 #define CS35L56_DSP1_AHBM_WINDOW_DEBUG_0		0x25E2040
 #define CS35L56_DSP1_AHBM_WINDOW_DEBUG_1		0x25E2044
 #define CS35L56_DSP1_XMEM_UNPACKED24_0			0x2800000
+#define CS35L56_DSP1_FW_VER				0x2800010
 #define CS35L56_DSP1_HALO_STATE_A1			0x2801E58
 #define CS35L56_DSP1_HALO_STATE				0x28021E0
 #define CS35L56_DSP1_PM_CUR_STATE_A1			0x2804000
@@ -285,6 +286,8 @@ int cs35l56_is_fw_reload_needed(struct cs35l56_base *cs35l56_base);
 int cs35l56_runtime_suspend_common(struct cs35l56_base *cs35l56_base);
 int cs35l56_runtime_resume_common(struct cs35l56_base *cs35l56_base, bool is_soundwire);
 void cs35l56_init_cs_dsp(struct cs35l56_base *cs35l56_base, struct cs_dsp *cs_dsp);
+int cs35l56_read_prot_status(struct cs35l56_base *cs35l56_base,
+			     bool *fw_missing, unsigned int *fw_version);
 int cs35l56_hw_init(struct cs35l56_base *cs35l56_base);
 int cs35l56_get_bclk_freq_id(unsigned int freq);
 void cs35l56_fill_supply_names(struct regulator_bulk_data *data);
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 9a70db0fa418..33835535ef84 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -628,10 +628,35 @@ void cs35l56_init_cs_dsp(struct cs35l56_base *cs35l56_base, struct cs_dsp *cs_ds
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_init_cs_dsp, SND_SOC_CS35L56_SHARED);
 
+int cs35l56_read_prot_status(struct cs35l56_base *cs35l56_base,
+			     bool *fw_missing, unsigned int *fw_version)
+{
+	unsigned int prot_status;
+	int ret;
+
+	ret = regmap_read(cs35l56_base->regmap, CS35L56_PROTECTION_STATUS, &prot_status);
+	if (ret) {
+		dev_err(cs35l56_base->dev, "Get PROTECTION_STATUS failed: %d\n", ret);
+		return ret;
+	}
+
+	*fw_missing = !!(prot_status & CS35L56_FIRMWARE_MISSING);
+
+	ret = regmap_read(cs35l56_base->regmap, CS35L56_DSP1_FW_VER, fw_version);
+	if (ret) {
+		dev_err(cs35l56_base->dev, "Get FW VER failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_read_prot_status, SND_SOC_CS35L56_SHARED);
+
 int cs35l56_hw_init(struct cs35l56_base *cs35l56_base)
 {
 	int ret;
-	unsigned int devid, revid, otpid, secured;
+	unsigned int devid, revid, otpid, secured, fw_ver;
+	bool fw_missing;
 
 	/*
 	 * When the system is not using a reset_gpio ensure the device is
@@ -690,8 +715,13 @@ int cs35l56_hw_init(struct cs35l56_base *cs35l56_base)
 		return ret;
 	}
 
-	dev_info(cs35l56_base->dev, "Cirrus Logic CS35L56%s Rev %02X OTP%d\n",
-		 cs35l56_base->secured ? "s" : "", cs35l56_base->rev, otpid);
+	ret = cs35l56_read_prot_status(cs35l56_base, &fw_missing, &fw_ver);
+	if (ret)
+		return ret;
+
+	dev_info(cs35l56_base->dev, "Cirrus Logic CS35L56%s Rev %02X OTP%d fw:%d.%d.%d (patched=%u)\n",
+		 cs35l56_base->secured ? "s" : "", cs35l56_base->rev, otpid,
+		 fw_ver >> 16, (fw_ver >> 8) & 0xff, fw_ver & 0xff, !fw_missing);
 
 	/* Wake source and *_BLOCKED interrupts default to unmasked, so mask them */
 	regmap_write(cs35l56_base->regmap, CS35L56_IRQ1_MASK_20, 0xffffffff);
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 8899c02c6dea..597677422547 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -804,7 +804,7 @@ static struct snd_soc_dai_driver cs35l56_dai[] = {
 	}
 };
 
-static void cs35l56_secure_patch(struct cs35l56_private *cs35l56)
+static void cs35l56_reinit_patch(struct cs35l56_private *cs35l56)
 {
 	int ret;
 
@@ -816,19 +816,10 @@ static void cs35l56_secure_patch(struct cs35l56_private *cs35l56)
 		cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_AUDIO_REINIT);
 }
 
-static void cs35l56_patch(struct cs35l56_private *cs35l56)
+static void cs35l56_patch(struct cs35l56_private *cs35l56, bool firmware_missing)
 {
-	unsigned int firmware_missing;
 	int ret;
 
-	ret = regmap_read(cs35l56->base.regmap, CS35L56_PROTECTION_STATUS, &firmware_missing);
-	if (ret) {
-		dev_err(cs35l56->base.dev, "Failed to read PROTECTION_STATUS: %d\n", ret);
-		return;
-	}
-
-	firmware_missing &= CS35L56_FIRMWARE_MISSING;
-
 	/*
 	 * Disable SoundWire interrupts to prevent race with IRQ work.
 	 * Setting sdw_irq_no_unmask prevents the handler re-enabling
@@ -901,34 +892,49 @@ static void cs35l56_dsp_work(struct work_struct *work)
 	struct cs35l56_private *cs35l56 = container_of(work,
 						       struct cs35l56_private,
 						       dsp_work);
+	unsigned int firmware_version;
+	bool firmware_missing;
+	int ret;
 
 	if (!cs35l56->base.init_done)
 		return;
 
 	pm_runtime_get_sync(cs35l56->base.dev);
 
+	ret = cs35l56_read_prot_status(&cs35l56->base, &firmware_missing, &firmware_version);
+	if (ret)
+		goto err;
+
 	/* Populate fw file qualifier with the revision and security state */
-	if (!cs35l56->dsp.fwf_name) {
-		cs35l56->dsp.fwf_name = kasprintf(GFP_KERNEL, "%02x%s-dsp1",
+	kfree(cs35l56->dsp.fwf_name);
+	if (firmware_missing) {
+		cs35l56->dsp.fwf_name = kasprintf(GFP_KERNEL, "%02x-dsp1", cs35l56->base.rev);
+	} else {
+		/* Firmware files must match the running firmware version */
+		cs35l56->dsp.fwf_name = kasprintf(GFP_KERNEL,
+						  "%02x%s-%06x-dsp1",
 						  cs35l56->base.rev,
-						  cs35l56->base.secured ? "-s" : "");
-		if (!cs35l56->dsp.fwf_name)
-			goto err;
+						  cs35l56->base.secured ? "-s" : "",
+						  firmware_version);
 	}
 
+	if (!cs35l56->dsp.fwf_name)
+		goto err;
+
 	dev_dbg(cs35l56->base.dev, "DSP fwf name: '%s' system name: '%s'\n",
 		cs35l56->dsp.fwf_name, cs35l56->dsp.system_name);
 
 	/*
-	 * When the device is running in secure mode the firmware files can
-	 * only contain insecure tunings and therefore we do not need to
-	 * shutdown the firmware to apply them and can use the lower cost
-	 * reinit sequence instead.
+	 * The firmware cannot be patched if it is already running from
+	 * patch RAM. In this case the firmware files are versioned to
+	 * match the running firmware version and will only contain
+	 * tunings. We do not need to shutdown the firmware to apply
+	 * tunings so can use the lower cost reinit sequence instead.
 	 */
-	if (cs35l56->base.secured)
-		cs35l56_secure_patch(cs35l56);
+	if (!firmware_missing)
+		cs35l56_reinit_patch(cs35l56);
 	else
-		cs35l56_patch(cs35l56);
+		cs35l56_patch(cs35l56, firmware_missing);
 
 
 	/*
-- 
2.39.2


