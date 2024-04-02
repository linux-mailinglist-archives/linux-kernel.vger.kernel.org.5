Return-Path: <linux-kernel+bounces-127485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06B2894C60
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8B71F22677
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C65D5789E;
	Tue,  2 Apr 2024 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ozIq5YGe"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1694F605;
	Tue,  2 Apr 2024 07:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041951; cv=none; b=T/xNGJRPwZ2oWIcwyLpwH1IRpxs7JCXkJ34JLqD7P7N4UwUtw++fQWeoRBJeUeGy6hy7rfOXBQYgJwtl+ty9SeAXoA06qPoqAlxYQJTfhWWu6iyBj4uP29zS53Cz7KDbGtHU4lZPrSZFvrjqTO391ymRzdPCGK/RkOBNgsJmRlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041951; c=relaxed/simple;
	bh=+FFguuWjmpl99xzEjdNjMqKEsp079adJwqAqXV6U1yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVWmujl9EgA5IJ24/DHQl8KFKg4fR8Aq01FWtUDonzV7yS2HtaDw8r8zzRfcz2okCzeipEA1DYMnJiUZXAtnnLZEpqxaZRcyuSWbZ+CR/9/F8GdHW9gU9bbaZgAc8PtruWOAmE1ZmWHwMgA/NI+nqaOnrKpWZCtwniScT14MmAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ozIq5YGe; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 24E0BFF809;
	Tue,  2 Apr 2024 07:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712041947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOE+gMok9O7xOxfyDenN7oiNfzS579Yi+szYYcmC2sQ=;
	b=ozIq5YGeWp2nIAyMNlSLn5hjNh/fD8pPFu2OxUqr8I827c8oDovhNzoxmqZ2e/g1q5dqwa
	flsAjv9P+ThwbgFVQEtwdbKj3bwsT40toiweRCc5gn9dHR0F3vL59SDiMXBRzFmeTYWA7S
	kL0ud3k09Xc+neLQd4Yta0+Im6MyuQRX+vMnfpEtepT+Tkptc8Oi3f3cbj6tC/zCGjulQ1
	6kswrgHBbFeqFqyJ1k9AoOGGARKHP6x7U8dYtSnrcHZSz2BjcLIeihLVH5wwu5lexDVZgP
	2m9k8Tj03vdLOdQaO2OU1FvufwQoSgdc7gUaxmWn5jbRWWOhRQI8o5n67EWeXA==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
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
Subject: [PATCH v2 07/13] ASoC: ti: davinci-i2s: Add TDM support
Date: Tue,  2 Apr 2024 09:12:07 +0200
Message-ID: <20240402071213.11671-8-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402071213.11671-1-bastien.curutchet@bootlin.com>
References: <20240402071213.11671-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

TDM is not supported by the McBSP driver. The McBSP datasheet does not
name explicitly TDM as a supported format but it is possible to configure
the McBSP to do TDM if all slots are used by McBSP.

Add TDM support. It uses single-phase frame. Slot width is used to
compute the McBSP's word length.

Implement the set_tdm_slot() hook of snd_soc_dai_ops struct. It only
supports TDM if all slots are used by McBSP.

The snd_soc_dai_driver's channels_max is updated from 2 to 128.

This was tested with BP_FC format on a platform designed off of
DAVINCI/OMAP_L138. A check is done in davinci_i2s_set_dai_fmt() to
prevent TDM to be used with BC_FC and BC_FP formats.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 sound/soc/ti/davinci-i2s.c | 92 +++++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 5 deletions(-)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index a2c7c812ea50..f9a67c2bc2f5 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -160,6 +160,9 @@ struct davinci_mcbsp_dev {
 	unsigned int fmt;
 	int clk_div;
 	bool i2s_accurate_sck;
+
+	int tdm_slots;
+	int slot_width;
 };
 
 static inline void davinci_mcbsp_write_reg(struct davinci_mcbsp_dev *dev,
@@ -213,6 +216,63 @@ static void davinci_mcbsp_stop(struct davinci_mcbsp_dev *dev, int playback)
 	toggle_clock(dev, playback);
 }
 
+static int davinci_i2s_tdm_word_length(int tdm_slot_width)
+{
+	switch (tdm_slot_width) {
+	case 8:
+		return DAVINCI_MCBSP_WORD_8;
+	case 12:
+		return DAVINCI_MCBSP_WORD_12;
+	case 16:
+		return DAVINCI_MCBSP_WORD_16;
+	case 20:
+		return DAVINCI_MCBSP_WORD_20;
+	case 24:
+		return DAVINCI_MCBSP_WORD_24;
+	case 32:
+		return DAVINCI_MCBSP_WORD_32;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int davinci_i2s_set_tdm_slot(struct snd_soc_dai *cpu_dai,
+				    unsigned int tx_mask,
+				    unsigned int rx_mask,
+				    int slots, int slot_width)
+{
+	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
+
+	dev_dbg(dev->dev, "slots %d, slot_width %d\n", slots, slot_width);
+
+	if (slots > 128 || !slots) {
+		dev_err(dev->dev, "Invalid number of slots\n");
+		return -EINVAL;
+	}
+
+	if (rx_mask != (1 << slots) - 1) {
+		dev_err(dev->dev, "Invalid RX mask (0x%08x) : all slots must be used by McBSP\n",
+			rx_mask);
+		return -EINVAL;
+	}
+
+	if (tx_mask != (1 << slots) - 1) {
+		dev_err(dev->dev, "Invalid TX mask (0x%08x) : all slots must be used by McBSP\n",
+			tx_mask);
+		return -EINVAL;
+	}
+
+	if (davinci_i2s_tdm_word_length(slot_width) < 0) {
+		dev_err(dev->dev, "%s: Unsupported slot_width %d\n", __func__, slot_width);
+		return -EINVAL;
+	}
+
+	dev->tdm_slots = slots;
+	dev->slot_width = slot_width;
+
+	return 0;
+}
+
 #define DEFAULT_BITPERSAMPLE	16
 
 static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
@@ -238,6 +298,11 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 			DAVINCI_MCBSP_PCR_CLKRM;
 		break;
 	case SND_SOC_DAIFMT_BC_FP:
+		if (dev->tdm_slots || dev->slot_width) {
+			dev_err(dev->dev, "TDM is not supported for BC_FP format\n");
+			return -EINVAL;
+		}
+
 		/*
 		 * McBSP CLKR pin is the input for the Sample Rate Generator.
 		 * McBSP FSR and FSX are driven by the Sample Rate Generator.
@@ -246,6 +311,11 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		pcr |= DAVINCI_MCBSP_PCR_SCLKME;
 		break;
 	case SND_SOC_DAIFMT_BC_FC:
+		if (dev->tdm_slots || dev->slot_width) {
+			dev_err(dev->dev, "TDM is not supported for BC_FC format\n");
+			return -EINVAL;
+		}
+
 		/* codec is master */
 		pcr = 0;
 		break;
@@ -383,7 +453,13 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	master = dev->fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK;
 	fmt = params_format(params);
-	mcbsp_word_length = asp_word_length[fmt];
+	if (dev->slot_width)
+		mcbsp_word_length = davinci_i2s_tdm_word_length(dev->slot_width);
+	else
+		mcbsp_word_length = asp_word_length[fmt];
+
+	if (mcbsp_word_length < 0)
+		return mcbsp_word_length;
 
 	switch (master) {
 	case SND_SOC_DAIFMT_BP_FP:
@@ -483,8 +559,13 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	switch (master) {
 	case SND_SOC_DAIFMT_BP_FP:
 	case SND_SOC_DAIFMT_BP_FC:
-		rcr |= DAVINCI_MCBSP_RCR_RFRLEN1(0);
-		xcr |= DAVINCI_MCBSP_XCR_XFRLEN1(0);
+		if (dev->tdm_slots > 0) {
+			rcr |= DAVINCI_MCBSP_RCR_RFRLEN1(dev->tdm_slots - 1);
+			xcr |= DAVINCI_MCBSP_XCR_XFRLEN1(dev->tdm_slots - 1);
+		} else {
+			rcr |= DAVINCI_MCBSP_RCR_RFRLEN1(0);
+			xcr |= DAVINCI_MCBSP_XCR_XFRLEN1(0);
+		}
 		break;
 	case SND_SOC_DAIFMT_BC_FC:
 	case SND_SOC_DAIFMT_BC_FP:
@@ -609,19 +690,20 @@ static const struct snd_soc_dai_ops davinci_i2s_dai_ops = {
 	.hw_params	= davinci_i2s_hw_params,
 	.set_fmt	= davinci_i2s_set_dai_fmt,
 	.set_clkdiv	= davinci_i2s_dai_set_clkdiv,
+	.set_tdm_slot   = davinci_i2s_set_tdm_slot,
 
 };
 
 static struct snd_soc_dai_driver davinci_i2s_dai = {
 	.playback = {
 		.channels_min = 2,
-		.channels_max = 2,
+		.channels_max = 128,
 		.rates = DAVINCI_I2S_RATES,
 		.formats = DAVINCI_I2S_FORMATS,
 	},
 	.capture = {
 		.channels_min = 2,
-		.channels_max = 2,
+		.channels_max = 128,
 		.rates = DAVINCI_I2S_RATES,
 		.formats = DAVINCI_I2S_FORMATS,
 	},
-- 
2.44.0


