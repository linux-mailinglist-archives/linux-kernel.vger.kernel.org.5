Return-Path: <linux-kernel+bounces-104340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6E287CC52
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839D11F221CF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ED11B7E8;
	Fri, 15 Mar 2024 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZHaKolmq"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25381CD1B;
	Fri, 15 Mar 2024 11:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502089; cv=none; b=SU+L3oVdvNqWEv0OPt0iK/JYLa64yL05S3I6NP2kB4KNAbQ9yexef1Wd0NQnWqZmL6o9k4B66Og0Q+x0KNE718p+3hZwl8Z6sb985z9cFM6z6KulMInZeqn6XIUDxvlEnZcUfzEHMbFOhdcESQgwKR2ZJzOiDB6cXbwaSuSNd2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502089; c=relaxed/simple;
	bh=q/HkeRlpaieA7+S1Zq4RKJ57Symb70E/kyVvENJqJ7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRmCKKBKOI1SWI+R/WhCiQIlllqtRkN16kgpdNx6DfyWxp+IAswMXZYPNTIh9x8ONDLpVgexIGfYhEAeggYqqy771yWAPME/Mg2HomySK8ngtAgvft6hcRd1OT0QyCxoq4J5SRPJk1Rt4PblxyAdDdqFIU9faAfcVm8hy8a0trU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZHaKolmq; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id F24ECE0010;
	Fri, 15 Mar 2024 11:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710502085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=COu6rizlcU/iAlgPx7V2opJGGo26BYauVb3ba1eZNgM=;
	b=ZHaKolmqERDtyC6GBThHLDu9kWPdkP3m/vJAdQgUzgqrX/8nxn+NRPnnYnib71RMRVqW+I
	0MGJXKjKMYCJqI1uI0Kbl58bDLyuDkjfEqDQ8M7bXCG5ug4d94RbIQXGBWVqMDLGGQIYB2
	Jy7RGIiBMDRNFyF5xT/XUg7yEh0O2ztpBaNHcSVsZliV9AHazDamAU40cqPOlyQtNmz/iH
	AWoRWqR6AGH2pHwRnrcQqLkPSxMMCnovypu9yffAweyAcXDYJmu52ydff/JtCD2aabL9Vs
	riU1JJKtaWs5P1/KpB3Lrhdn2dB3f2BddsZHnndhmkQSmDgJAXw1rKII0RvGNQ==
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
Subject: [PATCH 08/13] ASoC: ti: davinci-i2s: Add handling of BP_FC format
Date: Fri, 15 Mar 2024 12:27:40 +0100
Message-ID: <20240315112745.63230-9-bastien.curutchet@bootlin.com>
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

McBSP is able to drive bit clock and consume frame clock but BP_FC
format is not handled by McBSP driver.

Add BP_FC format support.
When BP_FC is selected:
  - CLKX and CLKR are configured as outputs
  - The sample rate generator is configured to be able to provide bit
    clock.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 sound/soc/ti/davinci-i2s.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index 4adaed010700..7cdd86f47ead 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -306,6 +306,12 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		pcr = DAVINCI_MCBSP_PCR_FSRM | DAVINCI_MCBSP_PCR_FSXM;
 		pcr |= DAVINCI_MCBSP_PCR_SCLKME;
 		break;
+	case SND_SOC_DAIFMT_BP_FC:
+		/* cpu is bitclock provider */
+		pcr = DAVINCI_MCBSP_PCR_CLKXM |
+			DAVINCI_MCBSP_PCR_CLKRM;
+		break;
+
 	case SND_SOC_DAIFMT_BC_FC:
 		/* codec is master */
 		pcr = 0;
@@ -491,6 +497,23 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 		clk_div &= 0xFF;
 		srgr |= clk_div;
 		break;
+	case SND_SOC_DAIFMT_BP_FC:
+		if (dev->ext_clk) {
+			freq = clk_get_rate(dev->ext_clk);
+		} else {
+			freq = clk_get_rate(dev->clk);
+			srgr = DAVINCI_MCBSP_SRGR_CLKSM;
+		}
+		if (dev->tdm_slots && dev->slot_width) {
+			clk_div = freq / (params->rate_num * params->rate_den)
+				 / (dev->tdm_slots * dev->slot_width) - 1;
+		} else {
+			clk_div = freq / (mcbsp_word_length * 16) /
+				  params->rate_num * params->rate_den;
+		}
+		clk_div &= 0xFF;
+		srgr |= clk_div;
+		break;
 	case SND_SOC_DAIFMT_BC_FC:
 		/* Clock and frame sync given from external sources */
 		i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS);
-- 
2.43.2


