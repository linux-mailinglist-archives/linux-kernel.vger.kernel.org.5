Return-Path: <linux-kernel+bounces-164074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A46C8B7881
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D931C2296E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664CD1BED60;
	Tue, 30 Apr 2024 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WLo0YXhx"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE19179956
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485781; cv=none; b=RZ+FqQtvnAhMHmGTbnaAS+0NNxZoQgfYClf7tS9FF6eeoE5npD3u/OWct7XwAWQ2yl4tT+pBUGXyy10rGQqM2BiaoA3D1yrTJqJKEhU32fJCYuqV6ItsIp9GCw+0iJzGz7BBdHw+j3T56SCIPnKCbkS04u+x6g9uaUrCq+BMQso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485781; c=relaxed/simple;
	bh=ucjMMVrCkGueEU7NLLh2sAE4bDhfGS2t9ibvgfiZuqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b+V/cXUu0nHZ0MvhYwL4THg0aoAqwC0eA8ihKOk8BRB0qFWPte/j3svBHPBNQSHKTEnx33kzbIC5tUtOiZt6iX+VlxN6537CVJUYU/kKGVS0eDGiYI4RoqlpT37MzOTXEdZu4zvq8K9INfcJhR4gyriFkZNRS9RoMthOkbOcx4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WLo0YXhx; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2db13ca0363so91886131fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714485778; x=1715090578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YNgLEZpy94T5of5dDiteuT7S3SOS839FWPGD9Oz3+lU=;
        b=WLo0YXhxs+89zUa1nnsMelZjTBw89jgfn25QCZf2YnTAVyIdcNxNVH0Lma4iVLDHcJ
         DhLNuYoI/GAt3EgQ5AZMBC8rqUuIO/Dk4/cG6WECZUl36U0WwldPMmPgzF2jH+GAkmpI
         SvJmpuui+1JvkEyvj+WAXNdlzfphHwnD0rLW3/vAPw3x/w/RCWHca8AmyJSgODxpRhcV
         7hgQn31zseULhu7zWAGPatUnxULYkPfKinLrpcVbgeIb6moT46mMmbZHL85vNe/VMyHr
         LYCZCUa/1vJdRcEvJArRtxFzHklUSJU0KO091k4H2S5wN41ap3Mgh3ldVCFOsYe6BuMC
         JTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714485778; x=1715090578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNgLEZpy94T5of5dDiteuT7S3SOS839FWPGD9Oz3+lU=;
        b=EEYpK3VHugM3TBkws3vdl4NbXLz8cYfi8t36T92eN+bkXUobiet48fkXh2sKyRNZDx
         zNPPCuLGnYDKSyX0snR3j+eXxEhFo/maSVK3mTHA2eMnEO7JZZlPK4BGoVuBzWJEICk+
         dE3F8CVlv4RL6ElzFV3CwN0s3QBPn5J2RBvEqAYQb5TaNJtygnRHvyG9B782bCRbhSyP
         4e3W0twTNJmMfrOStasdL2B7xeKm7TNNhcRrLM2XeC8nFxIgVXFfe46bM9IPNg0GgoUE
         A+X7CF1YJso10SOnEqBeQn1qAJypbhi3VyM9vm9WD4bB/bFJoocDHBFVkdecWWjw2DxG
         NzvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDPYhOPlJxOUgV65yIcsQyOVDKoWBd9h0LC9cl+EdBNMebNB2m2vhZRroIY+luZqyhm0nPplYXEYs7PmYwPNCdb02+fl5kfRiIOHOB
X-Gm-Message-State: AOJu0Ywl4agP7Xb/KsDKFx/8OcuJr3pNhJkhUlYarG8vQwWh/QuYpjjD
	IK46DvZcBeQ67vC9A+ex8NLMRB+kn4XMy6uRMHtzthGlFPljeOE+4B+91/Nc8TA=
X-Google-Smtp-Source: AGHT+IFjpnpTp49C7eNXISEFR7RNPga2jXB5JGxKI22M+Sgkavx0dXEQC64nAv94ubWY9cbPtavVlQ==
X-Received: by 2002:a2e:9d88:0:b0:2dd:da86:ee38 with SMTP id c8-20020a2e9d88000000b002ddda86ee38mr10711122ljj.8.1714485777680;
        Tue, 30 Apr 2024 07:02:57 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id pv27-20020a170907209b00b00a5940af3f67sm31434ejb.16.2024.04.30.07.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:02:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 30 Apr 2024 16:02:15 +0200
Subject: [PATCH 06/13] ASoC: fsl: Use snd_soc_substream_to_rtd() for
 accessing private_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-asoc-snd-substream-clean-v1-6-6f8a8902b479@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5066;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ucjMMVrCkGueEU7NLLh2sAE4bDhfGS2t9ibvgfiZuqk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmMPnyVTX4VSForeLiGua7AKa1bycRXXidVTl9D
 CaOooFdBBqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZjD58gAKCRDBN2bmhouD
 1x+nD/9L3QfdqNvflH7gpARtP03tnjdskVjY9BZshvK55BYu/8uL8qeQ8m7grVZgtdnFSp17jzg
 psAIaY2iZ3XjkhL1Wm9i2Bco6fY+REaa9ipQVksNn10h2zoFp4l3tKiNz9T6HIW+tr9LB4YJ0ez
 95oxVwwR3mmgoGnOTgoBhBquIQotbSGxNdua1owIxI4ynwBEDk9aSuLzFvyZaK+a5pQqlk8sFHE
 1Zk4N9BanSfRWtR7ZmuLxcDMQFw+f9cLlfnQjEF7qbDegbSaNYOR4VuwuAPVTQgmhL2FDZ9ZZBZ
 VS8nH1w1VupmUXyDCQM9+Ord+ux+JRHtepLks0LWYAmaEYSn0maBsInTR79T6/Z5BTnHY5o05cb
 17XjcuRdjm0E9YceHUg/H7Cu+qPpavOo45i3peulA/Kw8Bmz/UrCoPzgKCZECARmZhBwtFfXKFi
 BFBqwmlfaJ5mO+BUYtGOK0mi8QL8IJGpqneIw6WuwxG8gcximwl6XUtbhpG9dUMulPUId44Q4Lx
 6MRqlOL82xSEpJjTLh5Q1IVtCafvXHdADF0e5NcyPGZeB3xciZX49dPUqRv/agS7rPISpGBqP+3
 2uMcyxscGa3WWW9aQmkwpKw3L4QuI/OgOw5ddiu+DS7516wv6HU8Om/sxKJq6Fm9j1OTCD6HkT0
 JghFY64qvYvldfw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Do not open-code snd_soc_substream_to_rtd().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/fsl/fsl-asoc-card.c | 2 +-
 sound/soc/fsl/imx-card.c      | 6 +++---
 sound/soc/fsl/imx-hdmi.c      | 2 +-
 sound/soc/fsl/imx-pcm-rpmsg.c | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index f6d2564864c6..5ddc0c2fe53f 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -242,7 +242,7 @@ static int fsl_asoc_card_hw_params(struct snd_pcm_substream *substream,
 
 static int fsl_asoc_card_hw_free(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct fsl_asoc_card_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct codec_priv *codec_priv = &priv->codec_priv;
 	struct device *dev = rtd->card->dev;
diff --git a/sound/soc/fsl/imx-card.c b/sound/soc/fsl/imx-card.c
index cb8723965f2f..0e18ccabe28c 100644
--- a/sound/soc/fsl/imx-card.c
+++ b/sound/soc/fsl/imx-card.c
@@ -252,7 +252,7 @@ static unsigned long akcodec_get_mclk_rate(struct snd_pcm_substream *substream,
 					   struct snd_pcm_hw_params *params,
 					   int slots, int slot_width)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct imx_card_data *data = snd_soc_card_get_drvdata(rtd->card);
 	const struct imx_card_plat_data *plat_data = data->plat_data;
 	struct dai_link_data *link_data = &data->link_data[rtd->num];
@@ -289,7 +289,7 @@ static unsigned long akcodec_get_mclk_rate(struct snd_pcm_substream *substream,
 static int imx_aif_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct snd_soc_card *card = rtd->card;
 	struct imx_card_data *data = snd_soc_card_get_drvdata(card);
@@ -405,7 +405,7 @@ static int ak5558_hw_rule_rate(struct snd_pcm_hw_params *p, struct snd_pcm_hw_ru
 static int imx_aif_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_card *card = rtd->card;
 	struct imx_card_data *data = snd_soc_card_get_drvdata(card);
 	struct dai_link_data *link_data = &data->link_data[rtd->num];
diff --git a/sound/soc/fsl/imx-hdmi.c b/sound/soc/fsl/imx-hdmi.c
index e454085c6e5c..fe47b439a818 100644
--- a/sound/soc/fsl/imx-hdmi.c
+++ b/sound/soc/fsl/imx-hdmi.c
@@ -32,7 +32,7 @@ struct imx_hdmi_data {
 static int imx_hdmi_hw_params(struct snd_pcm_substream *substream,
 			      struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct imx_hdmi_data *data = snd_soc_card_get_drvdata(rtd->card);
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
diff --git a/sound/soc/fsl/imx-pcm-rpmsg.c b/sound/soc/fsl/imx-pcm-rpmsg.c
index b84d1dfddba2..ba491cbb9930 100644
--- a/sound/soc/fsl/imx-pcm-rpmsg.c
+++ b/sound/soc/fsl/imx-pcm-rpmsg.c
@@ -316,7 +316,7 @@ static int imx_rpmsg_pcm_prepare(struct snd_soc_component *component,
 				 struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct fsl_rpmsg *rpmsg = dev_get_drvdata(cpu_dai->dev);
 
@@ -461,7 +461,7 @@ static int imx_rpmsg_pcm_trigger(struct snd_soc_component *component,
 				 struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct fsl_rpmsg *rpmsg = dev_get_drvdata(cpu_dai->dev);
 	int ret = 0;
@@ -515,7 +515,7 @@ static int imx_rpmsg_pcm_ack(struct snd_soc_component *component,
 			     struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct fsl_rpmsg *rpmsg = dev_get_drvdata(cpu_dai->dev);
 	struct rpmsg_info *info = dev_get_drvdata(component->dev);

-- 
2.43.0


