Return-Path: <linux-kernel+bounces-104345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DCA87CC5D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6671F22234
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F253BBD0;
	Fri, 15 Mar 2024 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C1EqRKWR"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED68F381C6;
	Fri, 15 Mar 2024 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502096; cv=none; b=CTJpFdKRwKwnDJdpMhb0QC9HQw4phP/0WHuJKwAw02w4qmkN1XTK+5Y0qnAtUzih+zN3yRmcCcpyzSgM1oqD5SxG5unxkY0jMRQukpH2WCKlIiX9Z/cnrEK0xwYZXqJsU4Tdykkb7jusU0bv33+YkxyhjQp8wKcD0IBUpsmZddU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502096; c=relaxed/simple;
	bh=e9C6b7wBIvVr5D8OgogHyChIqRw3FYo/8ckm6eoEVCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YN9tj86y+4Z0Pc91jJvpuQf8WngEcd0G2VY34PaZU2aVSOTfiV8N4IaTDwe9aWBtgjxZfr9fJLdUd3v5D5Ysln2LC+JaOezZfH7lLDVkDkTnWBxTNhhF6oYpT8YFu9ceDN/XGVFx/BdBNHIyV20U570w9C7XKbXiKZpeH1ImL+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C1EqRKWR; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 73A2BE0002;
	Fri, 15 Mar 2024 11:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710502092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ByKbg1sHmU9IHih5m1OFO59QL3ayS3Id0H8zj9ZFbU=;
	b=C1EqRKWRRoWpb0hvc0NO337oFmlSlDZdxBdCKsGzwwGF5Csq8sqOm+720fvcsDajIciV51
	nfa9uLgkJ09294QyRHP2nu6lzF4L9of/FhpstMKQg+xhdB464nkivpPBIXM+TUCvPThgsJ
	G8oPMcRTvFNdWYrpmDybK7s1T8sW4byz6dgvkuJOyfc31TM/YvyE6iENg8ygMlDsAFAYU+
	ThQ9Q3VevjUx6GXpOD0tG202TZ3Js3XIduW0M9iQXJpoM2TQKF/NBwvcuSKRc3apWO29YQ
	YVdZcEQA5SN6lEc+JdXn3KKzK5X/H0AtWqGOU+Ivq/TZFSlexqZ0M72fAT33Yw==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: [PATCH 13/13] ASoC: ti: davinci-i2s: Opitonally drive DX pin during capture streams
Date: Fri, 15 Mar 2024 12:27:45 +0100
Message-ID: <20240315112745.63230-14-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

The McBSP's DX pin that outputs serial data during playback streams can
be used during capture streams to repeatedly output a chosen pattern.
For instance, this can be useful to drive an active-low signal during
captures (by choosing <0> as output pattern).

Enable this behaviour when the device-tree property 'ti,drive-dx' is
present. DX pin is driven with the provided pattern every time a
capture stream is launched.

This property is not compatible with classic playback stream so
davinci_i2s_trigger() returns an error if a playback stream is started
while 'ti,drive-dx' flag is present.

This has been tested on a board designed of a DAVINCI/OMAP-L138 where
the DX pin is linked to the chip select pin of the converters of the
capture side.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 sound/soc/ti/davinci-i2s.c | 74 ++++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 11 deletions(-)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index 13e349e7a6ec..e289a84bdd6a 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -101,6 +101,9 @@
 #define DAVINCI_MCBSP_PCR_FSRM		(1 << 10)
 #define DAVINCI_MCBSP_PCR_FSXM		(1 << 11)
 
+#define PLAYBACK_CLOCK			1
+#define CAPTURE_CLOCK			0
+
 enum {
 	DAVINCI_MCBSP_WORD_8 = 0,
 	DAVINCI_MCBSP_WORD_12,
@@ -164,6 +167,8 @@ struct davinci_mcbsp_dev {
 
 	bool sync_err;
 	bool free_run;
+	bool drive_dx;
+	u32 dx_val;
 };
 
 static inline void davinci_mcbsp_write_reg(struct davinci_mcbsp_dev *dev,
@@ -187,6 +192,19 @@ static void toggle_clock(struct davinci_mcbsp_dev *dev, int playback)
 	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG, dev->pcr);
 }
 
+static int davinci_drive_dx(struct davinci_mcbsp_dev *dev)
+{
+	unsigned int spcr;
+
+	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_DXR_REG, dev->dx_val);
+
+	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+	spcr |= DAVINCI_MCBSP_SPCR_XRST;
+	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
+
+	return 0;
+}
+
 static void davinci_mcbsp_start(struct davinci_mcbsp_dev *dev,
 		struct snd_pcm_substream *substream)
 {
@@ -194,6 +212,9 @@ static void davinci_mcbsp_start(struct davinci_mcbsp_dev *dev,
 	u32 spcr;
 	u32 mask = playback ? DAVINCI_MCBSP_SPCR_XRST : DAVINCI_MCBSP_SPCR_RRST;
 
+	if (!playback && dev->drive_dx)
+		davinci_drive_dx(dev);
+
 	/* Enable transmitter or receiver */
 	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
 	spcr |= mask;
@@ -212,9 +233,17 @@ static void davinci_mcbsp_stop(struct davinci_mcbsp_dev *dev, int playback)
 	/* Reset transmitter/receiver and sample rate/frame sync generators */
 	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
 	spcr &= ~(DAVINCI_MCBSP_SPCR_GRST | DAVINCI_MCBSP_SPCR_FRST);
-	spcr &= playback ? ~DAVINCI_MCBSP_SPCR_XRST : ~DAVINCI_MCBSP_SPCR_RRST;
-	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
-	toggle_clock(dev, playback);
+
+	if (!playback) {
+		spcr &= ~DAVINCI_MCBSP_SPCR_RRST;
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
+		toggle_clock(dev, CAPTURE_CLOCK);
+	}
+	if (playback || dev->drive_dx) {
+		spcr &= ~DAVINCI_MCBSP_SPCR_XRST;
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
+		toggle_clock(dev, PLAYBACK_CLOCK);
+	}
 }
 
 static int davinci_i2s_tdm_word_length(int tdm_slot_width)
@@ -408,6 +437,10 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	}
 	if (inv_fs == true)
 		pcr ^= (DAVINCI_MCBSP_PCR_FSXP | DAVINCI_MCBSP_PCR_FSRP);
+
+	if (dev->drive_dx)
+		pcr |= DAVINCI_MCBSP_PCR_CLKRP;
+
 	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SRGR_REG, srgr);
 	dev->pcr = pcr;
 	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG, pcr);
@@ -562,6 +595,9 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 		xcr |= DAVINCI_MCBSP_XCR_XDATDLY(1);
 	}
 
+	if (dev->drive_dx)
+		xcr |= DAVINCI_MCBSP_XCR_XDATDLY(2);
+
 	if (params_channels(params) == 2) {
 		element_cnt = 2;
 		if (double_fmt[fmt] && dev->enable_channel_combine) {
@@ -611,9 +647,9 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	xcr |= DAVINCI_MCBSP_XCR_XWDLEN1(mcbsp_word_length) |
 		DAVINCI_MCBSP_XCR_XWDLEN2(mcbsp_word_length);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK || dev->drive_dx)
 		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_XCR_REG, xcr);
-	else
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
 		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_RCR_REG, rcr);
 
 	pr_debug("%s - %d  srgr=%X\n", __func__, __LINE__, srgr);
@@ -628,16 +664,21 @@ static int davinci_i2s_prepare(struct snd_pcm_substream *substream,
 	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(dai);
 	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 	u32 spcr;
-	u32 mask = playback ? DAVINCI_MCBSP_SPCR_XRST : DAVINCI_MCBSP_SPCR_RRST;
 
 	davinci_mcbsp_stop(dev, playback);
 
 	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
-	if (spcr & mask) {
+	if (spcr & DAVINCI_MCBSP_SPCR_XRST) {
 		/* start off disabled */
 		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG,
-					spcr & ~mask);
-		toggle_clock(dev, playback);
+					spcr & ~DAVINCI_MCBSP_SPCR_XRST);
+		toggle_clock(dev, PLAYBACK_CLOCK);
+	}
+	if (spcr & DAVINCI_MCBSP_SPCR_RRST) {
+		/* start off disabled */
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG,
+					spcr & ~DAVINCI_MCBSP_SPCR_RRST);
+		toggle_clock(dev, CAPTURE_CLOCK);
 	}
 	if (dev->pcr & (DAVINCI_MCBSP_PCR_FSXM | DAVINCI_MCBSP_PCR_FSRM |
 			DAVINCI_MCBSP_PCR_CLKXM | DAVINCI_MCBSP_PCR_CLKRM)) {
@@ -646,7 +687,7 @@ static int davinci_i2s_prepare(struct snd_pcm_substream *substream,
 		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
 	}
 
-	if (playback) {
+	if (playback || dev->drive_dx) {
 		/* Enable the transmitter */
 		spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
 		spcr |= DAVINCI_MCBSP_SPCR_XRST;
@@ -659,7 +700,7 @@ static int davinci_i2s_prepare(struct snd_pcm_substream *substream,
 		spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
 		spcr &= ~DAVINCI_MCBSP_SPCR_XRST;
 		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
-		toggle_clock(dev, playback);
+		toggle_clock(dev, PLAYBACK_CLOCK);
 	}
 
 	return 0;
@@ -672,6 +713,11 @@ static int davinci_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	int ret = 0;
 	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 
+	if (playback && dev->drive_dx) {
+		dev_err(dev->dev, "Playback is not allowed when drive-cs flag is set\n");
+		return -EINVAL;
+	}
+
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
@@ -779,6 +825,12 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 
 	dev->free_run = !of_property_read_bool(pdev->dev.of_node, "ti,disable-free-run");
 	dev->sync_err = of_property_read_bool(pdev->dev.of_node, "ti,enable-sync-err");
+	dev->drive_dx = false;
+	ret = of_property_read_u32(pdev->dev.of_node, "ti,drive-dx", &dev->dx_val);
+	if (ret && ret != -EINVAL)
+		return ret;
+	if (!ret)
+		dev->drive_dx = true;
 
 	/* setup DMA, first TX, then RX */
 	dma_data = &dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
-- 
2.43.2


