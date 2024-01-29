Return-Path: <linux-kernel+bounces-43092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0BB840B78
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66431F238CD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0B815A4A9;
	Mon, 29 Jan 2024 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="EFy2tc1n"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F91C1586C7;
	Mon, 29 Jan 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545686; cv=none; b=HABj+w5vN5qSq4WrvQcXIncXcu6v+B+eCtEAv5PvzJ3ynxTlgvEEPN+dOdTA9DjFnWJMRZgrIm5WM/oZK6jEWcZrMIlIPVeET1rKHbW5ZsqbBFlrUvPxGM1Cl+r29b0UaEyMT00vczniSCTky4Ol+T9dFMTRFtvtjCJvr9FbHRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545686; c=relaxed/simple;
	bh=fA3074U6W2N0Yw2ySyrL/u/lHE4dXxfuFinoMZR3DQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwpTsozsDipdvUwDKMEvYZjZ6YgXxiOU2AgapnilDCzhUTDMhFIVhjDaYjFSFimT5QFMllZOdKGKngLS7dcrJYLYuMDA2eZD8NOXgIQkL/rMbYGD5r19FUeIbgl6+zjJpW/Yyw6U1MSHGThl3kSBpIRnNi6Xo0YMWXZvtLsGnE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=EFy2tc1n; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T5fM0L006968;
	Mon, 29 Jan 2024 10:27:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=eXrzEl2DxCUyvCv10htUuTphmm7fjbRRc/ehj2Lt7bY=; b=
	EFy2tc1ns4cUOVqbs9K0s05Jb4kvtdoZ8zvA+WBklTlBHlhSCyA8Z/BsMeSae2il
	C0Zam++u7cnXdLGZVO+zeiwo/XLJLbCeOJEdxiBZZF96v+tjhDd3q0fK1yrFTCxT
	fBhj2yo443P9SoLCpm+48IdKDcWpfrZxYsHzWPqiyEMFtYcdjlnE9LzxThK5xRG7
	N5KyedPNvYX6g1K0emrJf+B+xgtOm1k0431abVXaVWRRQ+t+0HkBdZF2bxrJ6S1c
	AWxfjI4rKmJ1rOGTjMue3/FS5dw//299HyqqsYGdis7uDgZ/SFX5bN3OW6NQnXsn
	vlGI6Z3+AqwANY4PfavtPQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vvy4nta8p-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:27:56 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 16:27:45 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 16:27:45 +0000
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.204])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id D43B1820242;
	Mon, 29 Jan 2024 16:27:44 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 10/18] ASoC: cs35l56: Fix for initializing ASP1 mixer registers
Date: Mon, 29 Jan 2024 16:27:29 +0000
Message-ID: <20240129162737.497-11-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: BPRKNpyDPnLXG_eO1Vd2sA2ZRy7Zcfup
X-Proofpoint-GUID: BPRKNpyDPnLXG_eO1Vd2sA2ZRy7Zcfup
X-Proofpoint-Spam-Reason: safe

Defer initializing the state of the ASP1 mixer registers until
the firmware has been downloaded and rebooted.

On a SoundWire system the ASP is free for use as a chip-to-chip
interconnect. This can be either for the firmware on multiple
CS35L56 to share reference audio; or as a bridge to another
device. If it is a firmware interconnect it is owned by the
firmware and the Linux driver should avoid writing the registers.
However, if it is a bridge then Linux may take over and handle
it as a normal codec-to-codec link. Even if the ASP is used
as a firmware-firmware interconnect it is useful to have
ALSA controls for the ASP mixer. They are at least useful for
debugging.

CS35L56 is designed for SDCA and a generic SDCA driver would
know nothing about these chip-specific registers. So if the
ASP is being used on a SoundWire system the firmware sets up the
ASP mixer registers. This means that we can't assume the default
state of these registers. But we don't know the initial state
that the firmware set them to until after the firmware has been
downloaded and booted, which can take several seconds when
downloading multiple amps.

DAPM normally reads the initial state of mux registers during
probe() but this would mean blocking probe() for several seconds
until the firmware has initialized them. To avoid this, the
mixer muxes are set SND_SOC_NOPM to prevent DAPM trying to read
the register state. Custom get/set callbacks are implemented for
ALSA control access, and these can safely block waiting for the
firmware download.

After the firmware download has completed, the state of the
mux registers is known so a work job is queued to call
snd_soc_dapm_mux_update_power() on each of the mux widgets.

Backport note:
This won't apply cleanly to kernels older than v6.6.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: e49611252900 ("ASoC: cs35l56: Add driver for Cirrus Logic CS35L56")
---
 sound/soc/codecs/cs35l56-shared.c |   7 +-
 sound/soc/codecs/cs35l56.c        | 172 +++++++++++++++++++++++++++---
 sound/soc/codecs/cs35l56.h        |   1 +
 3 files changed, 163 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index a812abf90836..9a70db0fa418 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -43,10 +43,9 @@ static const struct reg_default cs35l56_reg_defaults[] = {
 	{ CS35L56_ASP1_FRAME_CONTROL5,		0x00020100 },
 	{ CS35L56_ASP1_DATA_CONTROL1,		0x00000018 },
 	{ CS35L56_ASP1_DATA_CONTROL5,		0x00000018 },
-	{ CS35L56_ASP1TX1_INPUT,		0x00000018 },
-	{ CS35L56_ASP1TX2_INPUT,		0x00000019 },
-	{ CS35L56_ASP1TX3_INPUT,		0x00000020 },
-	{ CS35L56_ASP1TX4_INPUT,		0x00000028 },
+
+	/* no defaults for ASP1TX mixer */
+
 	{ CS35L56_SWIRE_DP3_CH1_INPUT,		0x00000018 },
 	{ CS35L56_SWIRE_DP3_CH2_INPUT,		0x00000019 },
 	{ CS35L56_SWIRE_DP3_CH3_INPUT,		0x00000029 },
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 41aa79848b15..1b51650a19ff 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -59,6 +59,135 @@ static int cs35l56_dspwait_put_volsw(struct snd_kcontrol *kcontrol,
 	return snd_soc_put_volsw(kcontrol, ucontrol);
 }
 
+static const unsigned short cs35l56_asp1_mixer_regs[] = {
+	CS35L56_ASP1TX1_INPUT, CS35L56_ASP1TX2_INPUT,
+	CS35L56_ASP1TX3_INPUT, CS35L56_ASP1TX4_INPUT,
+};
+
+static const char * const cs35l56_asp1_mux_control_names[] = {
+	"ASP1 TX1 Source", "ASP1 TX2 Source", "ASP1 TX3 Source", "ASP1 TX4 Source"
+};
+
+static int cs35l56_dspwait_asp1tx_get(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	int index = e->shift_l;
+	unsigned int addr, val;
+	int ret;
+
+	/* Wait for mux to be initialized */
+	cs35l56_wait_dsp_ready(cs35l56);
+	flush_work(&cs35l56->mux_init_work);
+
+	addr = cs35l56_asp1_mixer_regs[index];
+	ret = regmap_read(cs35l56->base.regmap, addr, &val);
+	if (ret)
+		return ret;
+
+	val &= CS35L56_ASP_TXn_SRC_MASK;
+	ucontrol->value.enumerated.item[0] = snd_soc_enum_val_to_item(e, val);
+
+	return 0;
+}
+
+static int cs35l56_dspwait_asp1tx_put(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	int item = ucontrol->value.enumerated.item[0];
+	int index = e->shift_l;
+	unsigned int addr, val;
+	bool changed;
+	int ret;
+
+	/* Wait for mux to be initialized */
+	cs35l56_wait_dsp_ready(cs35l56);
+	flush_work(&cs35l56->mux_init_work);
+
+	addr = cs35l56_asp1_mixer_regs[index];
+	val = snd_soc_enum_item_to_val(e, item);
+
+	ret = regmap_update_bits_check(cs35l56->base.regmap, addr,
+				       CS35L56_ASP_TXn_SRC_MASK, val, &changed);
+	if (!ret)
+		return ret;
+
+	if (changed)
+		snd_soc_dapm_mux_update_power(dapm, kcontrol, item, e, NULL);
+
+	return changed;
+}
+
+static void cs35l56_mark_asp1_mixer_widgets_dirty(struct cs35l56_private *cs35l56)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(cs35l56->component);
+	const char *prefix = cs35l56->component->name_prefix;
+	char full_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	const char *name;
+	struct snd_kcontrol *kcontrol;
+	struct soc_enum *e;
+	unsigned int val[4];
+	int i, item, ret;
+
+	/*
+	 * Resume so we can read the registers from silicon if the regmap
+	 * cache has not yet been populated.
+	 */
+	ret = pm_runtime_resume_and_get(cs35l56->base.dev);
+	if (ret < 0)
+		return;
+
+	ret = regmap_bulk_read(cs35l56->base.regmap, CS35L56_ASP1TX1_INPUT,
+			       val, ARRAY_SIZE(val));
+
+	pm_runtime_mark_last_busy(cs35l56->base.dev);
+	pm_runtime_put_autosuspend(cs35l56->base.dev);
+
+	if (ret) {
+		dev_err(cs35l56->base.dev, "Failed to read ASP1 mixer regs: %d\n", ret);
+		return;
+	}
+
+	snd_soc_card_mutex_lock(dapm->card);
+	WARN_ON(!dapm->card->instantiated);
+
+	for (i = 0; i < ARRAY_SIZE(cs35l56_asp1_mux_control_names); ++i) {
+		name = cs35l56_asp1_mux_control_names[i];
+
+		if (prefix) {
+			snprintf(full_name, sizeof(full_name), "%s %s", prefix, name);
+			name = full_name;
+		}
+
+		kcontrol = snd_soc_card_get_kcontrol(dapm->card, name);
+		if (!kcontrol) {
+			dev_warn(cs35l56->base.dev, "Could not find control %s\n", name);
+			continue;
+		}
+
+		e = (struct soc_enum *)kcontrol->private_value;
+		item = snd_soc_enum_val_to_item(e, val[i] & CS35L56_ASP_TXn_SRC_MASK);
+		snd_soc_dapm_mux_update_power(dapm, kcontrol, item, e, NULL);
+	}
+
+	snd_soc_card_mutex_unlock(dapm->card);
+}
+
+static void cs35l56_mux_init_work(struct work_struct *work)
+{
+	struct cs35l56_private *cs35l56 = container_of(work,
+						       struct cs35l56_private,
+						       mux_init_work);
+
+	cs35l56_mark_asp1_mixer_widgets_dirty(cs35l56);
+}
+
 static DECLARE_TLV_DB_SCALE(vol_tlv, -10000, 25, 0);
 
 static const struct snd_kcontrol_new cs35l56_controls[] = {
@@ -77,40 +206,44 @@ static const struct snd_kcontrol_new cs35l56_controls[] = {
 };
 
 static SOC_VALUE_ENUM_SINGLE_DECL(cs35l56_asp1tx1_enum,
-				  CS35L56_ASP1TX1_INPUT,
-				  0, CS35L56_ASP_TXn_SRC_MASK,
+				  SND_SOC_NOPM,
+				  0, 0,
 				  cs35l56_tx_input_texts,
 				  cs35l56_tx_input_values);
 
 static const struct snd_kcontrol_new asp1_tx1_mux =
-	SOC_DAPM_ENUM("ASP1TX1 SRC", cs35l56_asp1tx1_enum);
+	SOC_DAPM_ENUM_EXT("ASP1TX1 SRC", cs35l56_asp1tx1_enum,
+			  cs35l56_dspwait_asp1tx_get, cs35l56_dspwait_asp1tx_put);
 
 static SOC_VALUE_ENUM_SINGLE_DECL(cs35l56_asp1tx2_enum,
-				  CS35L56_ASP1TX2_INPUT,
-				  0, CS35L56_ASP_TXn_SRC_MASK,
+				  SND_SOC_NOPM,
+				  1, 0,
 				  cs35l56_tx_input_texts,
 				  cs35l56_tx_input_values);
 
 static const struct snd_kcontrol_new asp1_tx2_mux =
-	SOC_DAPM_ENUM("ASP1TX2 SRC", cs35l56_asp1tx2_enum);
+	SOC_DAPM_ENUM_EXT("ASP1TX2 SRC", cs35l56_asp1tx2_enum,
+			  cs35l56_dspwait_asp1tx_get, cs35l56_dspwait_asp1tx_put);
 
 static SOC_VALUE_ENUM_SINGLE_DECL(cs35l56_asp1tx3_enum,
-				  CS35L56_ASP1TX3_INPUT,
-				  0, CS35L56_ASP_TXn_SRC_MASK,
+				  SND_SOC_NOPM,
+				  2, 0,
 				  cs35l56_tx_input_texts,
 				  cs35l56_tx_input_values);
 
 static const struct snd_kcontrol_new asp1_tx3_mux =
-	SOC_DAPM_ENUM("ASP1TX3 SRC", cs35l56_asp1tx3_enum);
+	SOC_DAPM_ENUM_EXT("ASP1TX3 SRC", cs35l56_asp1tx3_enum,
+			  cs35l56_dspwait_asp1tx_get, cs35l56_dspwait_asp1tx_put);
 
 static SOC_VALUE_ENUM_SINGLE_DECL(cs35l56_asp1tx4_enum,
-				  CS35L56_ASP1TX4_INPUT,
-				  0, CS35L56_ASP_TXn_SRC_MASK,
+				  SND_SOC_NOPM,
+				  3, 0,
 				  cs35l56_tx_input_texts,
 				  cs35l56_tx_input_values);
 
 static const struct snd_kcontrol_new asp1_tx4_mux =
-	SOC_DAPM_ENUM("ASP1TX4 SRC", cs35l56_asp1tx4_enum);
+	SOC_DAPM_ENUM_EXT("ASP1TX4 SRC", cs35l56_asp1tx4_enum,
+			  cs35l56_dspwait_asp1tx_get, cs35l56_dspwait_asp1tx_put);
 
 static SOC_VALUE_ENUM_SINGLE_DECL(cs35l56_sdw1tx1_enum,
 				CS35L56_SWIRE_DP3_CH1_INPUT,
@@ -785,6 +918,15 @@ static void cs35l56_dsp_work(struct work_struct *work)
 	else
 		cs35l56_patch(cs35l56);
 
+
+	/*
+	 * Set starting value of ASP1 mux widgets. Updating a mux takes
+	 * the DAPM mutex. Post this to a separate job so that DAPM
+	 * power-up can wait for dsp_work to complete without deadlocking
+	 * on the DAPM mutex.
+	 */
+	queue_work(cs35l56->dsp_wq, &cs35l56->mux_init_work);
+
 	pm_runtime_mark_last_busy(cs35l56->base.dev);
 	pm_runtime_put_autosuspend(cs35l56->base.dev);
 }
@@ -830,6 +972,7 @@ static void cs35l56_component_remove(struct snd_soc_component *component)
 	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
 
 	cancel_work_sync(&cs35l56->dsp_work);
+	cancel_work_sync(&cs35l56->mux_init_work);
 
 	if (cs35l56->dsp.cs_dsp.booted)
 		wm_adsp_power_down(&cs35l56->dsp);
@@ -897,8 +1040,10 @@ int cs35l56_system_suspend(struct device *dev)
 
 	dev_dbg(dev, "system_suspend\n");
 
-	if (cs35l56->component)
+	if (cs35l56->component) {
 		flush_work(&cs35l56->dsp_work);
+		cancel_work_sync(&cs35l56->mux_init_work);
+	}
 
 	/*
 	 * The interrupt line is normally shared, but after we start suspending
@@ -1049,6 +1194,7 @@ static int cs35l56_dsp_init(struct cs35l56_private *cs35l56)
 		return -ENOMEM;
 
 	INIT_WORK(&cs35l56->dsp_work, cs35l56_dsp_work);
+	INIT_WORK(&cs35l56->mux_init_work, cs35l56_mux_init_work);
 
 	dsp = &cs35l56->dsp;
 	cs35l56_init_cs_dsp(&cs35l56->base, &dsp->cs_dsp);
diff --git a/sound/soc/codecs/cs35l56.h b/sound/soc/codecs/cs35l56.h
index 8159c3e217d9..dc2fe4c91e67 100644
--- a/sound/soc/codecs/cs35l56.h
+++ b/sound/soc/codecs/cs35l56.h
@@ -34,6 +34,7 @@ struct cs35l56_private {
 	struct wm_adsp dsp; /* must be first member */
 	struct cs35l56_base base;
 	struct work_struct dsp_work;
+	struct work_struct mux_init_work;
 	struct workqueue_struct *dsp_wq;
 	struct snd_soc_component *component;
 	struct regulator_bulk_data supplies[CS35L56_NUM_BULK_SUPPLIES];
-- 
2.39.2


