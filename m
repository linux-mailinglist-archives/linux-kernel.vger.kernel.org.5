Return-Path: <linux-kernel+bounces-127483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00388894C5B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2392844DE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F11054BF4;
	Tue,  2 Apr 2024 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PN61uJa9"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37263D968;
	Tue,  2 Apr 2024 07:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041949; cv=none; b=dPO/BIMeqRoNGjg8HizlTLiuBQ5l8DFzEnf9D+0eAaFY1v0nsEj7bHimRBE38OgYrwojCToBRLnKTPR+kTTztFnTxrR0NMmml/FW7rJA5AJY8Til9a09p32VkN6MrvkoGSY0lmXxQT7mUpDMto6Gb3KKQs60MuqDJ7oZ1YrJJtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041949; c=relaxed/simple;
	bh=UsLK0heJUS0ZdOtjODmExf7eqS2NsI4dk3TuxOHSLlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwE0MR2jJWilfihhLVir0DFOpGPhFXy9CaYMCOYn9S4xkBMrGDRxdZsNuFsNTXPg2a2L0tPaElAn8J+XVaoQ8/Tmtxp4+n7KEEr/z/vyKmLsKsy50CawrhrNIrquXvFoGVjY97uxq6oDYeNBiJ3LJrKkkb4VWToKyO/P4lBUiT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PN61uJa9; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 5E971FF80C;
	Tue,  2 Apr 2024 07:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712041945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9FxQAwvoRhx4YNmaJ3JdZe1YTK1lfejPZbAcyRGLNHk=;
	b=PN61uJa9OJF7vyS/QUuAHlU/hjt68rFy2GCnPQ+VJh0NBlBQgsqcYIYMzGzCLxzSKIfpgN
	ZOSJMZxnG6/HpbLRRpX3f9pAIrseevZbGVL2S6nwS5D38h+UsBdS3OzTq8tu0FXHshgSVw
	mTouQhTIk9dyAU1mbpkkdHkEnnozTxULKVo4/xAgtfJM7tYJHrYOPj3kahE/RKwDs2d9D0
	M94xPxdsjuWHPH7qlJFTkqvYot0DZtQBlYIu9S2hnEVz3rFMNknWhAG4BpjRhtRWZcgghI
	GWccWmcV6NJjUbNsL6RiptQyL4EBCBWqR8xODHC0Md9rp/HN+kf53je0Z9Xc1g==
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
Subject: [PATCH v2 05/13] ASoC: ti: davinci-i2s: Use external clock to drive sample rate generator
Date: Tue,  2 Apr 2024 09:12:05 +0200
Message-ID: <20240402071213.11671-6-bastien.curutchet@bootlin.com>
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

McBSP's internal sample rate generator can be programed to be driven by
its internal clock or by an external clock source located on CLKS pin.
The external clock source case is not handled by the driver.

Handle an optional clock related to this external clock source. If
present, the driver uses the clock located on CLKS pin as input for the
sample rate generator. Thus, the external clock rate is used to compute
divisors. If this optional clock is not present, the sample rate
generator is driven by the McBSP's functional clock.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 sound/soc/ti/davinci-i2s.c | 65 ++++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 16 deletions(-)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index cd64f1384e18..578b4ae28b71 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -134,6 +134,7 @@ struct davinci_mcbsp_dev {
 	int				mode;
 	u32				pcr;
 	struct clk			*clk;
+	struct clk			*ext_clk;
 	/*
 	 * Combining both channels into 1 element will at least double the
 	 * amount of time between servicing the dma channel, increase
@@ -364,7 +365,8 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(dai);
 	struct snd_interval *i = NULL;
 	int mcbsp_word_length, master;
-	unsigned int rcr, xcr, srgr, clk_div, freq, framesize;
+	unsigned int rcr, xcr, clk_div, freq, framesize;
+	unsigned int srgr = 0;
 	u32 spcr;
 	snd_pcm_format_t fmt;
 	unsigned element_cnt = 1;
@@ -385,9 +387,13 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	switch (master) {
 	case SND_SOC_DAIFMT_BP_FP:
-		freq = clk_get_rate(dev->clk);
-		srgr = DAVINCI_MCBSP_SRGR_FSGM |
-		       DAVINCI_MCBSP_SRGR_CLKSM;
+		if (dev->ext_clk) {
+			freq = clk_get_rate(dev->ext_clk);
+		} else {
+			freq = clk_get_rate(dev->clk);
+			srgr = DAVINCI_MCBSP_SRGR_CLKSM;
+		}
+		srgr |= DAVINCI_MCBSP_SRGR_FSGM;
 		srgr |= DAVINCI_MCBSP_SRGR_FWID(mcbsp_word_length *
 						8 - 1);
 		if (dev->i2s_accurate_sck) {
@@ -691,12 +697,36 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	dev->clk = clk_get(&pdev->dev, NULL);
+	/*
+	 * The optional is there for backward compatibility.
+	 * If 'fck' is not present, the clk_get(dev, NULL) that follows may find something
+	 */
+	dev->clk = devm_clk_get_optional(&pdev->dev, "fck");
 	if (IS_ERR(dev->clk))
-		return -ENODEV;
-	ret = clk_enable(dev->clk);
+		return dev_err_probe(&pdev->dev, PTR_ERR(dev->clk), "Invalid functional clock\n");
+	if (!dev->clk) {
+		dev->clk = devm_clk_get(&pdev->dev, NULL);
+		if (IS_ERR(dev->clk))
+			return dev_err_probe(&pdev->dev, PTR_ERR(dev->clk),
+					     "Missing functional clock\n");
+	}
+
+	dev->ext_clk = devm_clk_get_optional(&pdev->dev, "clks");
+	if (IS_ERR(dev->ext_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(dev->ext_clk), "Invalid external clock\n");
+
+	ret = clk_prepare_enable(dev->clk);
 	if (ret)
-		goto err_put_clk;
+		return ret;
+
+	if (dev->ext_clk) {
+		dev_dbg(&pdev->dev, "External clock used for sample rate generator\n");
+		ret = clk_prepare_enable(dev->ext_clk);
+		if (ret) {
+			dev_err_probe(&pdev->dev, ret, "Failed to enable external clock\n");
+			goto err_disable_clk;
+		}
+	}
 
 	dev->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, dev);
@@ -704,7 +734,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	ret = snd_soc_register_component(&pdev->dev, &davinci_i2s_component,
 					 &davinci_i2s_dai, 1);
 	if (ret != 0)
-		goto err_release_clk;
+		goto err_disable_ext_clk;
 
 	ret = edma_pcm_platform_register(&pdev->dev);
 	if (ret) {
@@ -716,10 +746,12 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 
 err_unregister_component:
 	snd_soc_unregister_component(&pdev->dev);
-err_release_clk:
-	clk_disable(dev->clk);
-err_put_clk:
-	clk_put(dev->clk);
+err_disable_ext_clk:
+	if (dev->ext_clk)
+		clk_disable_unprepare(dev->ext_clk);
+err_disable_clk:
+	clk_disable_unprepare(dev->clk);
+
 	return ret;
 }
 
@@ -729,9 +761,10 @@ static void davinci_i2s_remove(struct platform_device *pdev)
 
 	snd_soc_unregister_component(&pdev->dev);
 
-	clk_disable(dev->clk);
-	clk_put(dev->clk);
-	dev->clk = NULL;
+	clk_disable_unprepare(dev->clk);
+
+	if (dev->ext_clk)
+		clk_disable_unprepare(dev->ext_clk);
 }
 
 static const struct of_device_id davinci_i2s_match[] __maybe_unused = {
-- 
2.44.0


