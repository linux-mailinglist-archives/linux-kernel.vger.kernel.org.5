Return-Path: <linux-kernel+bounces-164073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6338F8B787D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A081C2291C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D286B1BF6DF;
	Tue, 30 Apr 2024 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PkdghBtS"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764461BED60
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485776; cv=none; b=f9drTfsn5cdWptPponDRoagbUxFOseAZbI18SIxI3YkkBr2/nBguGwE2jkyFdz+Dmej3BG/I4qHedWBEMgaNG2qK/YFDBD8mr4Z+UqTEG2feBWZTGq2MfS4D0dNj9nJOZ001ndo+Zo1/8+gpCQFlUEY3jnqVZfGo5fxgHYeh2cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485776; c=relaxed/simple;
	bh=/1R0OmMKMV4s3Y8w3vGDBextL0ongiiaeIRyC36ykHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qGnY9DBcTJU1i8ztsBe9DnC/E7xqTLY4YVslTKCUolyLayZatOZImyq9GuRqjMhZhQy1ELKzasa04dx1Kj14Ccf6OKb1vkanZGlAMi6QAb1sOyFGLICmEp61W7aKnoAHOlMOTkH5Z1DSImtJBc8ZF7grlqaCy4B8iX/JWS5kSEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PkdghBtS; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a58e787130fso533422066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714485773; x=1715090573; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KNDmF6F3m74+nDreAw5/fBepQ+vGW6wvqeA9DbjkOo=;
        b=PkdghBtSfxb6D0kM3kA5TqNWNjay/dLOsOHrlOeuvvfuZnHgFP5ZrTR/mgNPXnLrk5
         0cLossExspN5NSFqqDFgr17Q5fqpwVN1GiiW7il0KR8Rin1fxLOJ8lrGObyfXPiPd24N
         2b4dJgHlkim19fhTvSEK/KUAbdZZHf/mZ8+74+Gne9+TaSyJ/1fG3agbw5rPzW2TDtim
         HQ5MxciIgDZYm0OzqRMG8j9EH4yx8YCA8FYsz/9NmOsa9WJJ1rd6o7eKFoA9rAF0/m5p
         G1Im5GcpJ9TNwGAOgi5PUlJMdyCAFgjCREd1dao4XL+gWY4f09t610QR3vRcdrAwO/9p
         VBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714485773; x=1715090573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KNDmF6F3m74+nDreAw5/fBepQ+vGW6wvqeA9DbjkOo=;
        b=jkpHW1NrBkt1XVD0r9KigdPANquu01ALwsrrMWm+5oyrjwEwznFbwNsmPGPkZh4rXS
         OqXr3WZj5G4LignNH9531hUgD40Veccv7sSXacxf2kHjeP6L2Jw7BHSYQaI+8T0Im52C
         4eTex4qpKf0pHwpRSR72wIhmgO+WvXm2DnED6nNyZCWnaLUTwZMCRqrI9BYTn1Y2sK1E
         hTtq5Yc+tiMkrjT4nA6A6HOFJnl394PSxyz41U8Wka5qHPESGVZlsSWuj0vEqQKZpcRe
         5aT8DNwafQ2+e1o2J0/LwOnzkiklnJKEduiCgoyVH5QhX2JzWyzmgNc0eI1l86uP+5gX
         UAcA==
X-Forwarded-Encrypted: i=1; AJvYcCUgAx6+k1MYLQ3CPPPk7+NExFiojJ+VaBOAQjSMrw8QWZhMOwi9byDppkDsh2/tlA5WzPrSgzuY/fl4GfmxOXbo+aJyqZ9gIzExZPWS
X-Gm-Message-State: AOJu0YxljJ2/KzIDdVTMHM5odZozFNTN75Dm6EPOwPVFkxV/LWVGNec9
	v6Zhh44xVaoozaYr7MsCw4CCrcRKPcgy9dCbtNiWa8aH/oHa6tcevxnBHaeDjrM=
X-Google-Smtp-Source: AGHT+IG/ZiponzJElmGagl83BnX3KT4uxCge8Ge47biNA19yQUZRpq529TvSC+CjU+ZaC4bHHg0f4A==
X-Received: by 2002:a17:907:7892:b0:a51:abd8:8621 with SMTP id ku18-20020a170907789200b00a51abd88621mr2756333ejc.19.1714485772679;
        Tue, 30 Apr 2024 07:02:52 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id pv27-20020a170907209b00b00a5940af3f67sm31434ejb.16.2024.04.30.07.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:02:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 30 Apr 2024 16:02:14 +0200
Subject: [PATCH 05/13] ASoC: amd: Use snd_soc_substream_to_rtd() for
 accessing private_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-asoc-snd-substream-clean-v1-5-6f8a8902b479@linaro.org>
References: <20240430-asoc-snd-substream-clean-v1-0-6f8a8902b479@linaro.org>
In-Reply-To: <20240430-asoc-snd-substream-clean-v1-0-6f8a8902b479@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Jarkko Nikula <jarkko.nikula@bitmer.com>, Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Ban Tao <fengzheng923@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev, 
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2245;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=/1R0OmMKMV4s3Y8w3vGDBextL0ongiiaeIRyC36ykHM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmMPnxeEAVYc1UmVefhlabtyjgdGe38YIR/9kHe
 88Pd0erXViJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZjD58QAKCRDBN2bmhouD
 13M+D/4v2IeMte5vzz35J+GSwt7AUvJI6iiLCBM0Feu/9wQWRBj36O7yPQreb40lyCMtfUWWmb8
 PShQ3rPb8K6XWqMorWGoy5zD+sdIlhb3aWdBInfWwoMeTWxADZZqB+m8/PW3NnAEd9TqRNPKDzQ
 jWO60UiF8okwGVwjHAgprvGmhVSjbNI5b5g/PnV4ttO98aUjFne8AK3/v4C1DcS3awukX5VnTy1
 o1tZft+T6oiNutSPknPNyp2e5UMWDq8hNQzw3jdk4AaoJE9hpFvcrsQPZ+VnqOYZgBEvVVxzBvP
 F2I2uZ0c0mauf6GMEdHrqzLHGBc1gp99UZ8uAQssnSLSezJhM1SeIt5OCFiN9uy9UuvLStU2nks
 AQ2HWvKuN0XC7sRtuOgRTf8M30UUcO1Dm1iNeyQ3t4JdCEiXZ/ZQnG0+G8T2RN2gTcHBw76uZtA
 wt6P3w7TbxrYOWmPYbdW3DPPI4BMRNgYcPkq2qUpO3Ni0yaF5U/tH7Zprko1lynY03aPlkdyyeH
 p0Fg98AeEb7XYDd0cAJPC/j2leODUWvm/g8HvufxNzL7j78grTfc59M1lb9ogOQp9e2K1UDEAvB
 Efq5+HYBjP++8fA9Gwf5msphLx/h/eRifC+99A5yPh9l9gtluGNv38A8cEcrlAMPbo/N0GbTHXH
 R12gBWVNQAkbTwQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Do not open-code snd_soc_substream_to_rtd().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/amd/acp/acp-mach-common.c  | 2 +-
 sound/soc/amd/acp3x-rt5682-max9836.c | 2 +-
 sound/soc/amd/ps/ps-sdw-dma.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index 665a6ea0a2a8..a36300a4ed8a 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -217,7 +217,7 @@ static void acp_card_shutdown(struct snd_pcm_substream *substream)
 static int acp_card_rt5682_hw_params(struct snd_pcm_substream *substream,
 				      struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_card *card = rtd->card;
 	struct acp_card_drvdata *drvdata = card->drvdata;
 	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index d6cdb6d9fdd6..357dfd016baf 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -143,7 +143,7 @@ static int rt5682_clk_enable(struct snd_pcm_substream *substream)
 static int acp3x_1015_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *codec_dai;
 	int srate, i, ret;
 
diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
index 66b800962f8c..2f630753278d 100644
--- a/sound/soc/amd/ps/ps-sdw-dma.c
+++ b/sound/soc/amd/ps/ps-sdw-dma.c
@@ -218,7 +218,7 @@ static int acp63_sdw_dma_open(struct snd_soc_component *component,
 	struct acp_sdw_dma_stream *stream;
 	struct snd_soc_dai *cpu_dai;
 	struct amd_sdw_manager *amd_manager;
-	struct snd_soc_pcm_runtime *prtd = substream->private_data;
+	struct snd_soc_pcm_runtime *prtd = snd_soc_substream_to_rtd(substream);
 	int ret;
 
 	runtime = substream->runtime;

-- 
2.43.0


