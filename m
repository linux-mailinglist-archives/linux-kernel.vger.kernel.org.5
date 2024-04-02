Return-Path: <linux-kernel+bounces-127488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D6C894C67
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B433283E3E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3777759178;
	Tue,  2 Apr 2024 07:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TyJGS7gJ"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695D358213;
	Tue,  2 Apr 2024 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041955; cv=none; b=V436upICC+AFMbCwi2T8/xZp2wLNitZ9itxbxKH2wLR5A81397dOlvroDxh+GwRI9GGE3k4QXaFnupq28aXGl5kwF8xXIvpqosvfNvNesKF782L9K2YJ8sMmB4iftP++EwSuXknHKpunccKwAQrFL7popcsuHAYvsX9VIgV8pzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041955; c=relaxed/simple;
	bh=raqZRXpSAUQKXil8z5AtZK8I91UM9WjPAbTjuIxfsT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gn30zC3GQqJBF3mnVh9CGK2YUURJUuDLGEh4gF3bo4OTmiSuW+WoiWWUuEKqMELfLiRuCdo2AOmw4ZkTYborIdqgv2lnb50PsLJFRDPwyM4WZ0odBKFkkU2j6L91KcdnlpoDv1rJbzOKJ/lrfpVqLhXewoonjKe5cAenizbutFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TyJGS7gJ; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 61BB1FF804;
	Tue,  2 Apr 2024 07:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712041952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ryoqfTLjKn66TnerPCn7gg2/Qxg9JuXh/P0bs+WVTIc=;
	b=TyJGS7gJDTLORWyHUtik2qmgLQWu+1QobOj/bZ5fKukP7/xQkT/y7Li1gBUe9ykjzhBrof
	KvQqwPNmN8Y9cp60ztHZ9N1u5JiWbBgN5oQja5XKgv00D9eaytCihDmi4C3W0Fcvsl23Fz
	lPzMRoPKJuTsnAsGn87OX+Eb3ifq252qOl6QdrykwSYhbH6rfEDCbqj1aSGNMdAMdPcUKx
	MamDCqbugQImrX1SZIIkvqGijCUmYONdL7vrhpTQiCd+DyEYMKQgdnTyACA0QCKjShRgmE
	Oz7VXxpiGajXIq9uNf4iYAYO92EsuWb9DYst/t0FdJiM8ttu/4vHYGLkNgSKbg==
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
Subject: [PATCH v2 10/13] ASoC: ti: davinci-i2s: Link free-run mode to SND_SOC_DAIFMT_[GATED/CONT]
Date: Tue,  2 Apr 2024 09:12:10 +0200
Message-ID: <20240402071213.11671-11-bastien.curutchet@bootlin.com>
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

McBSP has free-running mode where serial clocks continue to run during
emulation halts. This mode is always enabled by the driver.

Set free-running mode when SND_SOC_DAIFMT_CONT is selected by DAI
format, unset it when SND_SOC_DAIFMT_GATED is selected.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 sound/soc/ti/davinci-i2s.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index 82a0dfa07cec..7fb41987175b 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -280,6 +280,7 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 {
 	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
 	unsigned int pcr;
+	unsigned int spcr;
 	unsigned int srgr;
 	bool inv_fs = false;
 	/* Attention srgr is updated by hw_params! */
@@ -288,6 +289,23 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		DAVINCI_MCBSP_SRGR_FWID(DEFAULT_BITPERSAMPLE - 1);
 
 	dev->fmt = fmt;
+
+	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_MASK) {
+	case SND_SOC_DAIFMT_CONT:
+		spcr |= DAVINCI_MCBSP_SPCR_FREE;
+		dev_dbg(dev->dev, "Free-running mode ON\n");
+		break;
+	case SND_SOC_DAIFMT_GATED:
+		spcr &= ~DAVINCI_MCBSP_SPCR_FREE;
+		dev_dbg(dev->dev, "Free-running mode OFF\n");
+		break;
+	default:
+		dev_err(dev->dev, "Invalid clock gating\n");
+		return -EINVAL;
+	}
+	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
+
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
 	case SND_SOC_DAIFMT_BP_FP:
@@ -452,10 +470,10 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	/* general line settings */
 	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
-		spcr |= DAVINCI_MCBSP_SPCR_RINTM(3) | DAVINCI_MCBSP_SPCR_FREE;
+		spcr |= DAVINCI_MCBSP_SPCR_RINTM(3);
 		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
 	} else {
-		spcr |= DAVINCI_MCBSP_SPCR_XINTM(3) | DAVINCI_MCBSP_SPCR_FREE;
+		spcr |= DAVINCI_MCBSP_SPCR_XINTM(3);
 		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
 	}
 
-- 
2.44.0


