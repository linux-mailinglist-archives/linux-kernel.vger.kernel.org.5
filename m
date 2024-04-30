Return-Path: <linux-kernel+bounces-164087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A41B8B78D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79DCFB23EC8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC51621C17A;
	Tue, 30 Apr 2024 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JTHWtZ9I"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83DB1C65E0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485803; cv=none; b=Q1qxQglkslbxSLwKtWmrfbIN3MhalBpVS3+J9DYgauW1o4zNfFADk9ycm8aDGW9tVGPHwxYU8CdBx+0y9lo6SylngIa9ZkHy8/oUqf9v1zpdzHRZGKe6PGdJV56UXdR6vORvdAYpo8eyMCANdb64K4GEgTwkaX6blh7TGW8FhdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485803; c=relaxed/simple;
	bh=74+WER8rBVNChp8T011lJzusbjvdwfTeUc05vWQCtnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=llKyOjynDVgr8lX1WmAmQSayMF1N3Msn90PPiT5hc/3p1rYs9RukAFEoEXDw956/sxafMlWS9c1FfxvwSA6kquIIUmLNrlLZdRpEGc7Qow+Rav7c12kOI3iiUr3BTsoFjn/TqqfjVfUzE9YlnZ4YvA+K1F+sHQ84k0RxwIPZiRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JTHWtZ9I; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2dd6a7ae2dcso91592201fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714485795; x=1715090595; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HlReh/uKfKGykX7vYGkVx56/1oeqm3j6UBVK+Qmhu9k=;
        b=JTHWtZ9Is89rHkLNyHWxYkSfcM3YSZF3xxq3O8gQAJjs0/A72TDfD/HKzEsfJCmZRC
         yWQPIJewU5IcLTQOvX2KCnQfPmk8gBLLobgkWaWqWBzLSunRqz/FDu0eNbMy35zhqAcN
         nUgKfhB/HZr2oifdDYrfIwpU1InitCl7l69AIqoZgjN+FGSXqG26fZuchwTCYhvHYiIv
         pGJ4mZM16GTxb6jSktCx+rrBxWvfM7Z21CbnLHXg1oWikao6Isf0Q0G4JY+3pmKDX4+b
         hvOmv3R4NI1p+I5Q8zJnU0+7dT0qbeTbI3fnKQl4zMVWS7bLeykgTbnMpW9nb/ne2+9l
         suTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714485795; x=1715090595;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlReh/uKfKGykX7vYGkVx56/1oeqm3j6UBVK+Qmhu9k=;
        b=xIV4lXp++LHghDGZGNB/kECZNz23SXUh5Vnqd4aXXkMKvXi4z2AR09+QRj8oc29vTr
         3lxDBcp0QXEFGSc64RNPJogK/pDCS9ho8Kib+7J1O01dgxFpbBgAdAbiD6KocCZv9/e5
         hGfX52QbDZK9QHDDKIEa4hzKMHj957V2zOa9u7ImC6xUmQHFtVmmT5mRluF4am1SwEFI
         TQYyq3/1qHo+ZpxsC8h5I6XIVUc3hmqH9GNfTHqLN/P8NUQnWQZXPRhvH6WRN/mnDLOV
         8bIdKKdTmKx948zsS2KvGg3fzV0zOsz5s1p4lqRmUbWEucNL8qLcHJ3+0JsmBq4mIFUA
         z4uw==
X-Forwarded-Encrypted: i=1; AJvYcCWHNhNheQh2pzq0dvcEx7chkE3ky3kZT6sgBEtcxLni4G3ZPuhdJSpO+xYMMaYy2bpEJFFD37msC60ji63k1ARRm7RswPsc8mGGJ4lF
X-Gm-Message-State: AOJu0YyddPFfJieuIViNPA4LPyDJ/PQVaUlgwlxM8dynVp5e9drnlNjl
	gQ1WibdK8RYa0HKSoTVfD0DtrasryNgAVmj2/kGzEbH+sfe36ztZNsLJBDrJCZg=
X-Google-Smtp-Source: AGHT+IEjPyu9X1615THrmlgihVBnJj6snuJyIqe3VYMH9bOXPEPLADlqYnOlMYNNwswyFzCxSlW3hA==
X-Received: by 2002:a2e:9145:0:b0:2df:b2d5:5935 with SMTP id q5-20020a2e9145000000b002dfb2d55935mr8668895ljg.28.1714485792538;
        Tue, 30 Apr 2024 07:03:12 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id pv27-20020a170907209b00b00a5940af3f67sm31434ejb.16.2024.04.30.07.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:03:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 30 Apr 2024 16:02:19 +0200
Subject: [PATCH 10/13] ASoC: mediatek: Use snd_soc_substream_to_rtd() for
 accessing private_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-asoc-snd-substream-clean-v1-10-6f8a8902b479@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13819;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=74+WER8rBVNChp8T011lJzusbjvdwfTeUc05vWQCtnc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmMPn2wIAKWRRmb3f+Eu7E/sNsicAIeRJntuzxZ
 SxYr98J11CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZjD59gAKCRDBN2bmhouD
 1yOiD/9+no2oO2meu/Ufx9CEy3qSO7oTggEWW3FaqAqFcceuY3ZcL6EMZ2biHC/QRNK4ebDskKU
 3O2P3faEC8XJpoITbkbDIiqXeyFCKlF8xXpOUoqJU2b/1DL8tjHLJ65Dg+xoktZHD2NWmNoQiRg
 eIA9zZjygsEGOywLbr00ulna67FOpbcwyo0pYJ3dQYy1TyOTBy9jFGsl8RxPBCcZfhE2P3xy9Op
 3YJQdjnLIEm0nGjkPUwV/mbyv1dB9guABGSShJm5gvvH+W+/cqmtzgzKa5lD3MLc//md1a3Ju+V
 GYH6YWtUfX7QSYdrf2odSjymVm9iBei+GgTtQW9SfPeVHHo17PilaDoe5GVaygZohC2HM2K33n1
 Po5GQ+qHU9/lDaSYbLMh26vyEayDUXnoxPUHaOgSiNZamo6XG6T07CTTJnF0XA0JoNRQd5eyWJs
 BHmwevPcP6/bP/iV9hjNJnOo7ORDuwBCFPhQlH2IgPI/WGR/3ux6Ozr54ngy6kgQ1l8FYVYJ5zm
 lkr1t63qAutgNeS0JPV+5JJfLfhPY0jPjSPT2oOa93zLB79CYb2OCU4CZNxFUoUZ1ICYyxfXdkz
 vSpyKtJNvE/u0Mzrwu0nPoMZhU+mWKpd1utzIbZX8OCoJLTfC5V20Hpv2quS3imeWDvF5BCURTw
 YI43f977A5OcnvA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Do not open-code snd_soc_substream_to_rtd().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/mediatek/mt7986/mt7986-afe-pcm.c |  4 ++--
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c | 14 +++++++-------
 sound/soc/mediatek/mt8186/mt8186-mt6366.c  |  2 +-
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c |  8 ++++----
 sound/soc/mediatek/mt8188/mt8188-mt6359.c  |  6 +++---
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c | 10 +++++-----
 sound/soc/mediatek/mt8195/mt8195-mt6359.c  |  4 ++--
 7 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/sound/soc/mediatek/mt7986/mt7986-afe-pcm.c b/sound/soc/mediatek/mt7986/mt7986-afe-pcm.c
index c1c486e275b9..572ded279b53 100644
--- a/sound/soc/mediatek/mt7986/mt7986-afe-pcm.c
+++ b/sound/soc/mediatek/mt7986/mt7986-afe-pcm.c
@@ -106,7 +106,7 @@ static const struct snd_pcm_hardware mt7986_afe_hardware = {
 static int mt7986_memif_fs(struct snd_pcm_substream *substream,
 			   unsigned int rate)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
 	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
 
@@ -116,7 +116,7 @@ static int mt7986_memif_fs(struct snd_pcm_substream *substream,
 static int mt7986_irq_fs(struct snd_pcm_substream *substream,
 			 unsigned int rate)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
 	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
 
diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
index bfcfc68ac64d..bafbef96a42d 100644
--- a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
@@ -40,7 +40,7 @@ static const struct snd_pcm_hardware mt8186_afe_hardware = {
 static int mt8186_fe_startup(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int id = snd_soc_rtd_to_cpu(rtd, 0)->id;
@@ -82,7 +82,7 @@ static int mt8186_fe_startup(struct snd_pcm_substream *substream,
 static void mt8186_fe_shutdown(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt8186_afe_private *afe_priv = afe->platform_priv;
 	int id = snd_soc_rtd_to_cpu(rtd, 0)->id;
@@ -104,7 +104,7 @@ static int mt8186_fe_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_pcm_hw_params *params,
 			       struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	int id = snd_soc_rtd_to_cpu(rtd, 0)->id;
 	unsigned int channels = params_channels(params);
@@ -153,7 +153,7 @@ static int mt8186_fe_hw_free(struct snd_pcm_substream *substream,
 static int mt8186_fe_trigger(struct snd_pcm_substream *substream, int cmd,
 			     struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_pcm_runtime * const runtime = substream->runtime;
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt8186_afe_private *afe_priv = afe->platform_priv;
@@ -252,7 +252,7 @@ static int mt8186_fe_trigger(struct snd_pcm_substream *substream, int cmd,
 static int mt8186_memif_fs(struct snd_pcm_substream *substream,
 			   unsigned int rate)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_component *component =
 		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
 	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
@@ -269,7 +269,7 @@ static int mt8186_get_dai_fs(struct mtk_base_afe *afe,
 
 static int mt8186_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_component *component =
 		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
 	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
@@ -290,7 +290,7 @@ static int mt8186_get_memif_pbuf_size(struct snd_pcm_substream *substream)
 static int mt8186_fe_prepare(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_pcm_runtime * const runtime = substream->runtime;
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	int id = snd_soc_rtd_to_cpu(rtd, 0)->id;
diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366.c b/sound/soc/mediatek/mt8186/mt8186-mt6366.c
index 8fd31c52b077..771d53611c2a 100644
--- a/sound/soc/mediatek/mt8186/mt8186-mt6366.c
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366.c
@@ -297,7 +297,7 @@ static const struct snd_soc_ops mt8186_da7219_i2s_ops = {
 static int mt8186_rt5682s_i2s_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_card *card = rtd->card;
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
index 9647fe133dc8..ccb6c1f3adc7 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
@@ -91,7 +91,7 @@ int mt8188_afe_fs_timing(unsigned int rate)
 static int mt8188_memif_fs(struct snd_pcm_substream *substream,
 			   unsigned int rate)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_component *component = NULL;
 	struct mtk_base_afe *afe = NULL;
 	struct mt8188_afe_private *afe_priv = NULL;
@@ -300,7 +300,7 @@ static int mt8188_afe_enable_cm(struct mtk_base_afe *afe,
 static int mt8188_afe_fe_startup(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	int id = snd_soc_rtd_to_cpu(rtd, 0)->id;
@@ -334,7 +334,7 @@ static int mt8188_afe_fe_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params,
 				   struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	int id = snd_soc_rtd_to_cpu(rtd, 0)->id;
 	struct mtk_base_afe_memif *memif = &afe->memif[id];
@@ -358,7 +358,7 @@ static int mt8188_afe_fe_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	const struct mt8188_afe_channel_merge *cm = mt8188_afe_found_cm(dai);
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_pcm_runtime * const runtime = substream->runtime;
 	int id = snd_soc_rtd_to_cpu(rtd, 0)->id;
 	struct mtk_base_afe_memif *memif = &afe->memif[id];
diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
index f629fc6bbb53..eba6f4c445ff 100644
--- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
+++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
@@ -557,7 +557,7 @@ enum {
 static int mt8188_dptx_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	unsigned int rate = params_rate(params);
 	unsigned int mclk_fs_ratio = 256;
 	unsigned int mclk_fs = rate * mclk_fs_ratio;
@@ -658,7 +658,7 @@ static int mt8188_dumb_amp_init(struct snd_soc_pcm_runtime *rtd)
 static int mt8188_max98390_hw_params(struct snd_pcm_substream *substream,
 				     struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	unsigned int bit_width = params_width(params);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct snd_soc_dai *codec_dai;
@@ -821,7 +821,7 @@ static const struct snd_soc_ops mt8188_nau8825_ops = {
 static int mt8188_rt5682s_i2s_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_card *card = rtd->card;
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
index 64af9bf363fd..38891d1bd18a 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
@@ -84,7 +84,7 @@ int mt8195_afe_fs_timing(unsigned int rate)
 static int mt8195_memif_fs(struct snd_pcm_substream *substream,
 			   unsigned int rate)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_component *component =
 			snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
 	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
@@ -281,7 +281,7 @@ mt8195_afe_paired_memif_clk_prepare(struct snd_pcm_substream *substream,
 				    struct snd_soc_dai *dai,
 				    int enable)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
 	int id = snd_soc_rtd_to_cpu(rtd, 0)->id;
@@ -310,7 +310,7 @@ mt8195_afe_paired_memif_clk_enable(struct snd_pcm_substream *substream,
 				   struct snd_soc_dai *dai,
 				   int enable)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
 	int id = snd_soc_rtd_to_cpu(rtd, 0)->id;
@@ -342,7 +342,7 @@ mt8195_afe_paired_memif_clk_enable(struct snd_pcm_substream *substream,
 static int mt8195_afe_fe_startup(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	int id = snd_soc_rtd_to_cpu(rtd, 0)->id;
@@ -380,7 +380,7 @@ static int mt8195_afe_fe_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params,
 				   struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	int id = snd_soc_rtd_to_cpu(rtd, 0)->id;
 	struct mtk_base_afe_memif *memif = &afe->memif[id];
diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
index 62e4e34cffbb..ca8751190520 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
@@ -338,7 +338,7 @@ static const struct snd_soc_ops mt8195_hdmitx_dptx_playback_ops = {
 static int mt8195_dptx_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 
 	return snd_soc_dai_set_sysclk(cpu_dai, 0, params_rate(params) * 256,
@@ -394,7 +394,7 @@ static int mt8195_dptx_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 static int mt8195_rt5682_etdm_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_card *card = rtd->card;
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);

-- 
2.43.0


