Return-Path: <linux-kernel+bounces-127486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C00894C62
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551F3284937
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758F158217;
	Tue,  2 Apr 2024 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eollKoDn"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987443CF72;
	Tue,  2 Apr 2024 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041952; cv=none; b=b8uufct3EaP++1wNGX9aKa9Xbg8pmAHTB4vi+L1vNXeUD4FEnWiYD8nBYd/YTI9+kuT4TmNg4tbiANdQuWWcuE5wZV3C3FrSZ1DundmeD/EoTj3nvHmuLAGgXNvL9Wg56G13RkA7bZCOuHLSQ/Eu3IEvU+Ui3mVZ1uibC3HxI60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041952; c=relaxed/simple;
	bh=GJaodrsvsUKepJh5HOvgM3By9lC7drwoFVmPzzyuZSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=soYxJRWkq1F4xUJhs3LEBkkgnrEc760PGKN/3MxXNzWnmcG+K8fnE5J84aPqmMvNbFukbFs8wp2NxS7z6aRsHD+Qm98Kd50+60pD6wA8a71cfrIT0qXGXlRXnTi8BuwvLfOTKU9MCum5z+eXRvPSxJW08iO15TVfO2246MDAI8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eollKoDn; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 6FD7BFF80B;
	Tue,  2 Apr 2024 07:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712041949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B8mmblUe82t+hx13yGYU8qdAec50yUQsVghOvUGSIMk=;
	b=eollKoDn3KuG4KvaXPrltRHFBIsN36vPdK3DJkycbYXA+vraNbsfDEX9Yj6Z8BE6AvfK/a
	PhSP4VEgcmO09RYy7UQPwQPmg01KsFtKCzzp2JykNFDdd2XYeOVbVkMGU7j2eLXqbmzP82
	n4U9dFbj/BT4O289prGUTXXguyYsQ0B56MsM2sicYKtf+WyErz+lSIKTmZxxpXreqX7fSp
	jvECNCfqj6pzCBueS//S9/kKK8JcNOoxqq4i6dUnh9IxL+VR45OsNcBHt3QuClB+G8fLoS
	t9dTLg4iWF6odauJGkBQPsUU6wuWcJgqUwEgMLy5YX7SV+nGQ4nTdNANDcPtkg==
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
Subject: [PATCH v2 08/13] ASoC: ti: davinci-i2s: Add handling of BP_FC format
Date: Tue,  2 Apr 2024 09:12:08 +0200
Message-ID: <20240402071213.11671-9-bastien.curutchet@bootlin.com>
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
index f9a67c2bc2f5..e51f05cda941 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -310,6 +310,12 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
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
 		if (dev->tdm_slots || dev->slot_width) {
 			dev_err(dev->dev, "TDM is not supported for BC_FC format\n");
@@ -500,6 +506,23 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
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
2.44.0


