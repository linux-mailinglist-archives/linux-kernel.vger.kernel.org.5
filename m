Return-Path: <linux-kernel+bounces-164072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AD28B7879
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4648D284B80
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499521BED97;
	Tue, 30 Apr 2024 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JXuJ+FY0"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61821BED60
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485770; cv=none; b=KUWMSRUmfolfQwRT9Dla2HS4zRWJoAd8xfOsEkooGWnpe3jLeW80eRB2A0plmO86SBgEffFfa1cs2YPnFwovaDqIq5csF9ZikCN25EwCdFKEBLhLUYNFoSc9Pr+TCAnqhfiUdh7UiBUya6dpyUSjdcp/a8vMH39D2AOj99u3Cfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485770; c=relaxed/simple;
	bh=eDseprbctVXAhiZOvRsQsRjQ1srjlolDCUwu7Poiuqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qu3yOzliOEsrkqzXUqTdJNxZtjlZFSjStCwjoQIz9fIb5I+qEAvhrWNPBrLfu9dOhnibmXrKRKRrMGbEqGpSqL+C8xTHUIkxsnObEsRrmwtkM3YxzhJQaK0D82r7jCACFMvL8sHg9ebwis87pIULsAoFzcdpMv6goKQnwS7WuPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JXuJ+FY0; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a58872c07d8so1172672566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714485767; x=1715090567; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVmB3IwNsO++LEmxsGA1Of52OGeiLTZOoIEqlaO4Y6U=;
        b=JXuJ+FY0c0lAPiN6GB2Bftfx2yBNQjdDyx2Vqhmu6/+risPyomjPYAhmOZJaa+3BXb
         iinwmCmGuEc4H/bqmw8lVdKGp2ePsAiQpN0iwDpHEygvh6TNvCvENONKSpDhGAgIxNrY
         wFTQ65p/NHJmHOQXidyMw1wib/2MSYOe0K/5WdnQgGcbhYhNbA3tbTi89PG96qo3th6j
         rlGFEpsqsMPDx0M/hxv9VxJ0eEKwE5yyxTuGJ6MTRqnPqKPkLN+b7H927IOXsTIGCJDT
         SfOjkWLYFZ03yy5aQRkIzYZa70STynBdeopSugN5jTUjr1FWxt86c3Oxxe6jvSRwHZTd
         p9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714485767; x=1715090567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVmB3IwNsO++LEmxsGA1Of52OGeiLTZOoIEqlaO4Y6U=;
        b=wvazS6sj6UydD7Bs+9lq4qC8bhXYKxny63uZo528vipgQXxuAfXpVX/vREpneODZIT
         Jg4wSM/mjG2zVD0bCuc+GNFWQEUMbjjCvULy2VCtV7iHrz8s4PH7r+00C7+UMXZ/I37E
         ansapMorFI4idjHgMuGiCN2DPPRCIs+VkLeBKKZfIFI6j1evK7z9Yhprx68rgX5HPom8
         /6QUvqDZE4YVP1ONN5Wz2wK0QLvbyjjOKrpMstC6jdiCOD0Ms+hTTQSofTjFZM4vWu11
         fAQRaWCvxqBoEQU6R59Wk3R3cBgYVo7amzD+q4DIf2SiWtNPwWVD1SmROExLjGBQ9B43
         XI0A==
X-Forwarded-Encrypted: i=1; AJvYcCVZ3H9zQnEZa/DShIq7iFU+OD0End3nQ/DuQYD3nrCJeX8+8JkY9fgLrhTMFbyFUxvw75WFpm9pYBM83J68d3MHNhmcS0ydw6DgmIvZ
X-Gm-Message-State: AOJu0Yxh/A/Ifgu0ofubM54pIHtHHFhGOGOTymXT5fgH22Wc3W33GKzJ
	MrLGX15G0BuoC0X3PpW8up9NISKRgzUaszMGcWsL+9PgOk8NbbYBknWI37AtZh4=
X-Google-Smtp-Source: AGHT+IFp03X1JFPDrIujOHhWiOUjRy/996U+B0l6yK76tZHW13kgA6dvKPQweqrNY0l31/l3LaTzjw==
X-Received: by 2002:a17:906:3ac3:b0:a58:ebdd:8aa4 with SMTP id z3-20020a1709063ac300b00a58ebdd8aa4mr2360562ejd.20.1714485766998;
        Tue, 30 Apr 2024 07:02:46 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id pv27-20020a170907209b00b00a5940af3f67sm31434ejb.16.2024.04.30.07.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:02:46 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 30 Apr 2024 16:02:13 +0200
Subject: [PATCH 04/13] ASoC: arm: Use snd_soc_substream_to_rtd() for
 accessing private_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-asoc-snd-substream-clean-v1-4-6f8a8902b479@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=eDseprbctVXAhiZOvRsQsRjQ1srjlolDCUwu7Poiuqc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmMPnwqTKqjOWhyghuqcWCQALMCLVh7T8zMCEGN
 dvM+Z0GdNKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZjD58AAKCRDBN2bmhouD
 18RiD/4qLIFwqpuprQ1tMuUxq4zKnCWe3121KK341e3C6K9aJyN/BTLnFTKGCeHCS8O34sFL66W
 T7sO0tVkpzvEVFOfhdAxTxVSNxk8b8r6nlylo9rzqkM9QzU1SQsGJxog0QKojxAO0I6sntjpOI1
 C4eLl6KKsV1j1hvxU76kJP6e32eMeIdiZaAxMmQsQSK0v013+TK6DZ0Pzoka7GW21s3JFCovROF
 vXxmHvtZZeMHmbCCg5y/XZBWunSMfsNrjjgO+mIu7XV7gkK7P9MQYjLZJqqQZ+vhoD2Qg9UAnk7
 OQE9DLavtk9A5wwayHHudVq/E4K3OsGqYV+1R5o5G1+IXBsr5pk5VcYEwd60z1VKxXXSO/b83Yc
 ENbgYWPE1yLUGcTgo4uG5za0uVWxDFi/b7wDRbmmROHuH09+9ryGv2cvKPGHQDn8f6u5L/cH8NS
 Ks+CcsLhi9wVjDnpMDTWNA/8OLpqgOgk1oqEI3Ef0cIjYKbQDoqPj8qg/30LXXJWsi3ixd/UGXX
 LNNqCHmIDRExk6Qjid/ky+fQP2yP3ITflnWYCAlkkGB6jsfhk/qkiIbv4uytjIVSSs+x9OJUdPk
 73ZmPvgfk/AnUFwJpDnK2XdUlBKSk6Z3H5g0na7JWMYATpXKrxMAJjcyW1bMqbdfGqkv8gNWzrz
 mSfEosfDuUmcoLg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Do not open-code snd_soc_substream_to_rtd().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/arm/pxa2xx-pcm-lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/arm/pxa2xx-pcm-lib.c b/sound/arm/pxa2xx-pcm-lib.c
index 51d2ff80df16..571e9d909cdf 100644
--- a/sound/arm/pxa2xx-pcm-lib.c
+++ b/sound/arm/pxa2xx-pcm-lib.c
@@ -33,7 +33,7 @@ int pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 			 struct snd_pcm_hw_params *params)
 {
 	struct dma_chan *chan = snd_dmaengine_pcm_get_chan(substream);
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_dmaengine_dai_dma_data *dma_params;
 	struct dma_slave_config config;
 	int ret;
@@ -79,7 +79,7 @@ EXPORT_SYMBOL(pxa2xx_pcm_prepare);
 
 int pxa2xx_pcm_open(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_dmaengine_dai_dma_data *dma_params;
 	int ret;

-- 
2.43.0


