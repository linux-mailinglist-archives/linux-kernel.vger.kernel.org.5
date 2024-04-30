Return-Path: <linux-kernel+bounces-164070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799568B7870
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EEE0281FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1F01A38ED;
	Tue, 30 Apr 2024 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mn1WoN4O"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD091A38C3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485766; cv=none; b=lDh26U7LtVVn0ZHJLM4D8pPSPMPWFfoFsxAHD7wFjab1NY+FoEvZeRmwPKoQ1+g+ODb9jo7f/7lX3Mb/6nuyzbQ09cuzNX0vxVOdGo6O7svb0RqFRVw+dLX0YaQt708j+Hb7Tm5acAeazcwyYx5VwN7v/UR+rkgPPEi/D27o0xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485766; c=relaxed/simple;
	bh=NWayqZgMTQyhrridkNgCIJtQs25nYri5VnM17XYp3Mo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TsSJdMw7tdbqMvhnKFXf9GP3RjdkCF7bRodqgdEd3HhIzkJyUvsoKTuT+PchkU9xrz5FBl56zhmxSIlzjHgKh9zDzn9YEoOS9FY3x81uq3/0i1A2YXmzxhAGc4aNId6PTuH8/8kaC5IfTfjxxBVylekydMhCbRSf31PVM/IwnGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mn1WoN4O; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a587831809eso688576466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714485762; x=1715090562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5IV4t0pNrZLc8K3zjbiMUiExRG0rwvdrAQLRnesERno=;
        b=Mn1WoN4O8pznAiLFMdVQ9Uq3Fh/qnHcV3hdeWGJS6hyk68CeSVVz9Zsr8sNGu9IQEd
         2q5v86GMsTNBOTvqEfWiiQCbuDRVmi8/aOrezhbTjQR8Gd9u/dtvIFwgN8BtFEOlZVRO
         W3KsNKynECP2UeuzqrshDVEbhey/gzYIUCkEnND5SQD1XUlGARqDEHuUEiCNWb/4AgsF
         t/SWHrRyXlDTAvblEHnuuj7nim4+HoO5boc9c5QtAgGMGewYQkuTCz1jMDNDmTyvOO5+
         aAPXpWf4ibW32ggUC22fiM6ZpMyUFZPEgNgvdhbe+rPm9eogY3cow3TiSwtMiQ2f2zWS
         KhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714485762; x=1715090562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IV4t0pNrZLc8K3zjbiMUiExRG0rwvdrAQLRnesERno=;
        b=QIHGr8qYP+rmW42jVYra+/c05iMUfWSS+z379sIA5k6DOnAY1UtOnRSyxI2S4wSSKR
         IfrHoh6+xKUvayfYv7nrymBd25kRnIO0Tw61hbD3F1+y/OPMjjqSC8ZkORVb1S0dST3S
         4mud5T3xbTGDD3OFX+5IfS0WwbYg9C9g/5O8/frDZkLyveDdO4j0jgaPqqdpJ4mhQXuk
         MBXOLlQjZQ67i7KqjQSm9Itu0u1EoNFwDZj7MqT42NZo0zAdWUyN2c0j8h/L1UKb/7lY
         BuHCWnMrynFJvf56u7Xdb0KsOWOZB1h2L871DDy+/jIRSd+LqEVZTi7Uz9rWFKKL07NA
         MH0g==
X-Forwarded-Encrypted: i=1; AJvYcCUDQTidSE230kNehXS8/TV9D88EzI7FMZLbAmW5T/vFHVTms3X+hIGcoQSzQZ9qhwH8Hf1TQ6QysxcXurQezM5thPYIRNitdEkMrE6/
X-Gm-Message-State: AOJu0Yw52tsMCdmzPP5lqVf37xcc//9whl6jneAfwnNTJWAa+aEvnLkD
	zEyx4zll7d8tIAoCrcaPRgR3yzWMIkiNTMHpx6/46HSQ6yfTJiZrhb57hoT9P2E=
X-Google-Smtp-Source: AGHT+IHiryIlMBuC9NM2KOjVX/FiEZN10FwJJA8ZsqNvWyktK2eDEXsG0W+ylaSuA6HZE7/EUxYrVw==
X-Received: by 2002:a17:906:5851:b0:a52:54d8:6d21 with SMTP id h17-20020a170906585100b00a5254d86d21mr10321769ejs.7.1714485761837;
        Tue, 30 Apr 2024 07:02:41 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id pv27-20020a170907209b00b00a5940af3f67sm31434ejb.16.2024.04.30.07.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:02:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 30 Apr 2024 16:02:11 +0200
Subject: [PATCH 02/13] ASoC: tegra: Use snd_soc_substream_to_rtd() for
 accessing private_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-asoc-snd-substream-clean-v1-2-6f8a8902b479@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2412;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=NWayqZgMTQyhrridkNgCIJtQs25nYri5VnM17XYp3Mo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmMPnuu9RjFk0ZahGK7moh34+XMb8y5IAinmHhw
 3VHDPhugCqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZjD57gAKCRDBN2bmhouD
 1zWOD/4+tyzs1xgp6ykzyyJogYehC2MKqc9o7BAwaYhBihjzf+kvS/a49wjR8gzDJ7Vh3y3/hwL
 aLdHFckj8wwv4l0ss9+e4sAMLoHDo7uUPKc+rfA+yOS8XjuXoRm8FI6LehOSZcU8NK5w+LQWJ3U
 ceuoYZ1qz1qlNuzBLWh3xpsoRbk5sjR2sakihrnAleKyfoasgq6+XdUIQ0VJqWO3MEUcYPC/eXU
 h0snq64j4az27aiyUMbwLNSs6H3gn3+qoBo7CHTzJnJ0JDyk11jeRzxeQyznlPWuSUIqCMkCeft
 uT+ECq9fYZbdwFZIupds9jdP/39elefh2kxAnzlm5ROlK2Z/TDTgDQeaEvraSuji6ucd/CTWMOv
 VkU3vwo2GtZi3mVhPPnkMo6Nz5ObAvyQbuIY180agGlUo1VC1+m9LeJ98LBIPAdLIkbp6biPcfM
 6AHQapXJgPIkZGgszpxcOMdIHIf7X4eaVUkr12gdIijUr7p/VilIGXBzL7mADqRC3+Pzk5Q590A
 8MyHOr4aKOGAWSWyPRn1clfTUJnmOg92ZBgTm7yfpzUeQRED96dVL+70aCGXXlCP1V+EwhgZecx
 m2VLP4rPyvCJT3suEVLW0aKsOrnHxRm5mvO2RcJ5U/k/EfE5uCaHFZFgyQE+iEqtAyQa0sQ1Vex
 ffzIPP9MiKJu/1A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Do not open-code snd_soc_substream_to_rtd().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/tegra/tegra_asoc_machine.c | 2 +-
 sound/soc/tegra/tegra_pcm.c          | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/tegra/tegra_asoc_machine.c b/sound/soc/tegra/tegra_asoc_machine.c
index 192e9692bdf2..775ce433fdbf 100644
--- a/sound/soc/tegra/tegra_asoc_machine.c
+++ b/sound/soc/tegra/tegra_asoc_machine.c
@@ -290,7 +290,7 @@ static unsigned int tegra_machine_mclk_rate_6mhz(unsigned int srate)
 static int tegra_machine_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
 	struct snd_soc_card *card = rtd->card;
 	struct tegra_machine *machine = snd_soc_card_get_drvdata(card);
diff --git a/sound/soc/tegra/tegra_pcm.c b/sound/soc/tegra/tegra_pcm.c
index 42acb56543db..4bdbcd2635ef 100644
--- a/sound/soc/tegra/tegra_pcm.c
+++ b/sound/soc/tegra/tegra_pcm.c
@@ -76,7 +76,7 @@ EXPORT_SYMBOL_GPL(tegra_pcm_platform_unregister);
 int tegra_pcm_open(struct snd_soc_component *component,
 		   struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_dmaengine_dai_dma_data *dmap;
 	struct dma_chan *chan;
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
@@ -127,7 +127,7 @@ EXPORT_SYMBOL_GPL(tegra_pcm_open);
 int tegra_pcm_close(struct snd_soc_component *component,
 		    struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 
 	if (rtd->dai_link->no_pcm)
 		return 0;
@@ -142,7 +142,7 @@ int tegra_pcm_hw_params(struct snd_soc_component *component,
 			struct snd_pcm_substream *substream,
 			struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_dmaengine_dai_dma_data *dmap;
 	struct dma_slave_config slave_config;
 	struct dma_chan *chan;

-- 
2.43.0


