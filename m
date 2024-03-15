Return-Path: <linux-kernel+bounces-104343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A0C87CC5A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C96E0B22B7E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B90C381D9;
	Fri, 15 Mar 2024 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f1mkYBOY"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDA92E62D;
	Fri, 15 Mar 2024 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502093; cv=none; b=TknOor+zCLe4HmC/7TmNomPdei0wS5QBvk416NUv5D1e3v/K2Yv+ctqPfeWhxu8P8YqoGWjwi2RvC7DHyZ96ECsBDkjUd5hXhlFx1+gkxkcMxKRPd5QMyqeqmQXVsTr2vR69HqiSCZ00uSxBTTt9h+GwM2GuQ/SQCkwFiq8fiLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502093; c=relaxed/simple;
	bh=AwAqDOZzz46Ed6tx9rUXvHKRqYi8N1dzTDMvRTXZYWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJ5qrkA/dzEOsZ10RxsbwW139o+PX/sxxIYBrSR29h2UUG107YN44dX++UVA33SvftpWg9xgCMkwpttc034MjWhAQdfpNmreTXlGipGI/M5ot/FR1FKHboNBrvvGW768DTssFKKrcVlj+RkliZQbqO3CVjLEENlEClkC8UzQXkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f1mkYBOY; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id F0518E0008;
	Fri, 15 Mar 2024 11:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710502089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=esZKn+SlazHXsQkGa0+kdlqCRWQZg4hF1p4IJ88VcZA=;
	b=f1mkYBOYCtNZ7HhGkubtHbUKhGnUYVSZ3KcO56/kpibDdUQ4NRvccmSm6ViJmBJOyD+aCR
	5SnTQabldHU02Ky9VeqcY/o26cmeNLeS10I6LjC6VNAyNexFPiD7hIRm1/lA7V6d/++QSR
	pNwq3ucoQKHmXfhtAmk13mDMM/f92NqJoXjRQwKPXAk+YD+VJ+B5tMeznnds1fdRm00K4O
	JojzL00fbfKulO/hnFZRZU2CXHGO6+gLZu4F7RwzIRbE+BIDsrb+z0Nz23dFtKSxLMDjAB
	XN9D7MM8IfBUhffvLDebl2rNOPFRL1Ys2S5cDGX/ILm2j1lHsdMdETphHozCDw==
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
Subject: [PATCH 11/13] ASoC: ti: davinci-i2s: Add S24_LE to supported formats
Date: Fri, 15 Mar 2024 12:27:43 +0100
Message-ID: <20240315112745.63230-12-bastien.curutchet@bootlin.com>
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

S24_LE is supported by McBSP but not by the driver.

Add S24_LE to driver's supported formats. Using it enables the sign
extension in DRR (Data Receive Register). The other formats are kept
with the zero extension in DRR.

Remove data_type table as it is no longer used.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 sound/soc/ti/davinci-i2s.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index 67307e75f2a8..13e349e7a6ec 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -61,6 +61,9 @@
 
 #define DAVINCI_MCBSP_SPCR_RRST		(1 << 0)
 #define DAVINCI_MCBSP_SPCR_RINTM(v)	((v) << 4)
+#define DAVINCI_MCBSP_SPCR_RJUST(v)	((v) << 13)
+#define DAVINCI_MCBSP_SPCR_RJUST_Z_LE	DAVINCI_MCBSP_SPCR_RJUST(0)
+#define DAVINCI_MCBSP_SPCR_RJUST_S_LE	DAVINCI_MCBSP_SPCR_RJUST(1)
 #define DAVINCI_MCBSP_SPCR_XRST		(1 << 16)
 #define DAVINCI_MCBSP_SPCR_XINTM(v)	((v) << 20)
 #define DAVINCI_MCBSP_SPCR_GRST		(1 << 22)
@@ -107,15 +110,10 @@ enum {
 	DAVINCI_MCBSP_WORD_32,
 };
 
-static const unsigned char data_type[SNDRV_PCM_FORMAT_S32_LE + 1] = {
-	[SNDRV_PCM_FORMAT_S8]		= 1,
-	[SNDRV_PCM_FORMAT_S16_LE]	= 2,
-	[SNDRV_PCM_FORMAT_S32_LE]	= 4,
-};
-
 static const unsigned char asp_word_length[SNDRV_PCM_FORMAT_S32_LE + 1] = {
 	[SNDRV_PCM_FORMAT_S8]		= DAVINCI_MCBSP_WORD_8,
 	[SNDRV_PCM_FORMAT_S16_LE]	= DAVINCI_MCBSP_WORD_16,
+	[SNDRV_PCM_FORMAT_S24_LE]	= DAVINCI_MCBSP_WORD_24,
 	[SNDRV_PCM_FORMAT_S32_LE]	= DAVINCI_MCBSP_WORD_32,
 };
 
@@ -443,8 +441,23 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	snd_pcm_format_t fmt;
 	unsigned element_cnt = 1;
 
-	/* general line settings */
 	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+
+	/* Determine xfer data type */
+	fmt = params_format(params);
+	switch (fmt) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+	case SNDRV_PCM_FORMAT_S32_LE:
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		spcr |= DAVINCI_MCBSP_SPCR_RJUST_S_LE;
+		break;
+	default:
+		dev_warn(dev->dev, "davinci-i2s: unsupported PCM format\n");
+		return -EINVAL;
+	}
+
+	/* general line settings */
 	if (dev->free_run)
 		spcr |= DAVINCI_MCBSP_SPCR_FREE;
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
@@ -548,12 +561,6 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 		rcr |= DAVINCI_MCBSP_RCR_RDATDLY(1);
 		xcr |= DAVINCI_MCBSP_XCR_XDATDLY(1);
 	}
-	/* Determine xfer data type */
-	fmt = params_format(params);
-	if ((fmt > SNDRV_PCM_FORMAT_S32_LE) || !data_type[fmt]) {
-		printk(KERN_WARNING "davinci-i2s: unsupported PCM format\n");
-		return -EINVAL;
-	}
 
 	if (params_channels(params) == 2) {
 		element_cnt = 2;
@@ -692,6 +699,7 @@ static void davinci_i2s_shutdown(struct snd_pcm_substream *substream,
 
 #define DAVINCI_I2S_RATES	SNDRV_PCM_RATE_8000_96000
 #define DAVINCI_I2S_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+				 SNDRV_PCM_FMTBIT_S24_LE | \
 				 SNDRV_PCM_FMTBIT_S32_LE)
 
 static int davinci_i2s_dai_probe(struct snd_soc_dai *dai)
-- 
2.43.2


