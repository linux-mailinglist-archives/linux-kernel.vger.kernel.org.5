Return-Path: <linux-kernel+bounces-127489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AABC894C6B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F319B233EC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A6C3AC2B;
	Tue,  2 Apr 2024 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dvS9r/61"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0752858ACD;
	Tue,  2 Apr 2024 07:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041957; cv=none; b=OtoeNAWCug/YQixgS87jqsJ9R6l7mdrUqGQdIqE0o0GRexLGyohck6sEDcQUKbU8pdzMSGspsC6y/YzQp/eRWk7HCgbyQ9f1X5GdgnDaVmH77ANrfL/x8RHEAgp9V57qUi6x18XktVdUeb/rJ9HyNakP/1UT/zrCB9D3CRKcr4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041957; c=relaxed/simple;
	bh=aEvLZ42Sz56/Mq00rxNsquYsuc4I6XXsq0WZKRms/uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqaTEMwHGukrMAlWltOkG/9PVV2ED2xTw3xIw2X+96oDsf06xNfk8Ne733kwnE0hw4Lub1apxVVc3RcsmFacvWOc8176XgpFa/ekynBtxl0WfWuPw1T8QcHclc5vhn0gc6xR7gsuB5WPoB+osTED5bxHGvtXP1XdtKRQVpjvISk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dvS9r/61; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id C648CFF805;
	Tue,  2 Apr 2024 07:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712041953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kGgoavkWPYXIisQyOjz1zAZv2po0MrsfHiyY+MEsubo=;
	b=dvS9r/61DMhpSthZq/wkIW2aWqRag/BQv+j4bSdjOV/esteKS+egqrnc7QtqUWc8nibjmR
	j+AmfM0ylUJpWTKVJyDKowEaSb5gJaHegHh8+z8hzk7liatrp9emg4ARQDCM64Oaa+q6D6
	vrbagM0FUuDMfk1f67aHZzOgNkuKplfoWnPVdYpL7SRe+7hqT61c4A1oebNIHZgMAkj4L9
	Vp2N3oDvdfo7AUle6eKLeTEwmjPJGWJ1LTfPd5FfZrZi5vxdtUFvqPtY2qP7QskiGB9pSN
	ZPIDajAWHBsW3YsJr44/nHqUIUrbHo0y9jVrmDmFoBp2BayzJMdtbr3Oxkbh8A==
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
Subject: [PATCH v2 11/13] ASoC: ti: davinci-i2s: Add S24_LE to supported formats
Date: Tue,  2 Apr 2024 09:12:11 +0200
Message-ID: <20240402071213.11671-12-bastien.curutchet@bootlin.com>
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
index 7fb41987175b..fb1e09c78bdf 100644
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
 
@@ -467,8 +465,23 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
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
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		spcr |= DAVINCI_MCBSP_SPCR_RINTM(3);
 		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
@@ -566,12 +579,6 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
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
@@ -710,6 +717,7 @@ static void davinci_i2s_shutdown(struct snd_pcm_substream *substream,
 
 #define DAVINCI_I2S_RATES	SNDRV_PCM_RATE_8000_96000
 #define DAVINCI_I2S_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+				 SNDRV_PCM_FMTBIT_S24_LE | \
 				 SNDRV_PCM_FMTBIT_S32_LE)
 
 static int davinci_i2s_dai_probe(struct snd_soc_dai *dai)
-- 
2.44.0


