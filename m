Return-Path: <linux-kernel+bounces-127491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F333B894C71
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604022846CC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D865D8F0;
	Tue,  2 Apr 2024 07:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H78MRbh1"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6EA5A0F8;
	Tue,  2 Apr 2024 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041959; cv=none; b=LVOZ2xT76CvKCuq5VUSw+mPqbd3G8lm2eFVMJajfot3aZQiirGlrjyoUIuE5W6A2w5WTfWT1hpwP18cDh5m0fWBEmYdmVlecCSf8FCggaPYRfJ1lxcMzXcBfwx5LAKYF4OFLtZNvmk3Pda/UYkEq38hcYY6Egy2mpHy9W2b2Wvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041959; c=relaxed/simple;
	bh=n8C2sMFznZ+aSgwy6VZZBdp6GtGS+ViwXxZAO/kOhSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPvIETxcPJpNfVZT96/YhY92/PckDUzP1Nep/ZBMobjYG46eGeBelQ810McmWCzSGLvxgUmLn2hphk6a8wFgVqoYtKKO1ph0MXyJfr4IvKGJzKRUH0MxXcNnZ77hrqF/mR/1BRiBNSVy4+40u38QwL/GYLHTDTATlm3XSdmZ6m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H78MRbh1; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 2DD34FF80B;
	Tue,  2 Apr 2024 07:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712041955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PE3YvX4Y16ibvrY87Lo5u2VWlVZ0kvZSV/V9W8+29Ew=;
	b=H78MRbh18HozjmvX6U8/RisNl1hxS6rRFIyRStLQwOFgG0EzwIze+ki3HBx0wMmJXZgzua
	KFN6OxHpXsXDDjjNAleJizhmSTi4pttKWeWArkxtULPfH2viNPhXZpg5deGc6AHPZeqInm
	D4B9jOJdIDDE2pXS+mZsFmjd059rX9kVoZXXx5TikWiDDlz/h3gOHa0lU5Caqhdncyz3Q/
	x29TNap5WlkPZH2B4MSQ0F9N6iCbvr60ogpdZ+ysBS5VNZFZ8UsOUWmeDVZH9larPRGx7A
	f9jIzh1n4x78gRTTfTCAgm7bMrZCaCl+n7h9lMlNJVWjRyiWCB7AG3CXScxCSg==
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
Subject: [PATCH v2 13/13] ASoC: ti: davinci-i2s: Add T1 framing support
Date: Tue,  2 Apr 2024 09:12:13 +0200
Message-ID: <20240402071213.11671-14-bastien.curutchet@bootlin.com>
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

McBSP's data delay can be configured from 0 to 2 bit clock periods. 0 is
used for DSP_B format, 1 is used for DSP_A format, 2 is unused.

A data delay of 2 bit clock periods can be used to interface to
'T1 framing' devices where data stream is preceded by a 'framing bit'. On
transmission, McBSP inserts a blank period (high-impedance period)
before the first data bit to leave an opportunity for other devices to
set this 'framing bit'. On reception, McBSP discards the 'framing bit'
that precedes the data stream.

Add support for the 'framing bit' according to the
'ti,T1-framing-[tx/rx]' device-tree properties. If a flag is present,
the data delay is set to 2 bit clock periods regardless of the selected
DAI format.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 sound/soc/ti/davinci-i2s.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index fb1e09c78bdf..0f15a743c798 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -161,6 +161,9 @@ struct davinci_mcbsp_dev {
 
 	int tdm_slots;
 	int slot_width;
+
+	bool tx_framing_bit;
+	bool rx_framing_bit;
 };
 
 static inline void davinci_mcbsp_write_reg(struct davinci_mcbsp_dev *dev,
@@ -580,6 +583,15 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 		xcr |= DAVINCI_MCBSP_XCR_XDATDLY(1);
 	}
 
+	if (dev->tx_framing_bit) {
+		xcr &= ~DAVINCI_MCBSP_XCR_XDATDLY(1);
+		xcr |= DAVINCI_MCBSP_XCR_XDATDLY(2);
+	}
+	if (dev->rx_framing_bit) {
+		rcr &= ~DAVINCI_MCBSP_RCR_RDATDLY(1);
+		rcr |= DAVINCI_MCBSP_RCR_RDATDLY(2);
+	}
+
 	if (params_channels(params) == 2) {
 		element_cnt = 2;
 		if (double_fmt[fmt] && dev->enable_channel_combine) {
@@ -796,6 +808,9 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 
 	dev->base = io_base;
 
+	dev->tx_framing_bit = of_property_read_bool(pdev->dev.of_node, "ti,T1-framing-tx");
+	dev->rx_framing_bit = of_property_read_bool(pdev->dev.of_node, "ti,T1-framing-rx");
+
 	/* setup DMA, first TX, then RX */
 	dma_data = &dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
 	dma_data->addr = (dma_addr_t)(mem->start + DAVINCI_MCBSP_DXR_REG);
-- 
2.44.0


