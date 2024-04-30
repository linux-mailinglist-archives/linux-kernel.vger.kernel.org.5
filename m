Return-Path: <linux-kernel+bounces-164089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF12B8B78D7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A66B235F7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A6317B4ED;
	Tue, 30 Apr 2024 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNbBSLjc"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF1E1CB335
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485805; cv=none; b=PzULZ9awNdgbzdFLlVrCCLyvr5RcHXYpVOyAoFaA7Qn4dPU8FIIw0GiDYlLkanPKMS0Fp+hpmjSmUZFv/62mpJ52WR33IjXkun34qVXS3rhM9k8l8dhYSq18Y4EsnCgK+zXUoUtjxOuLVfXrumZifgpfCD1QrRv48TE/D6V8qnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485805; c=relaxed/simple;
	bh=s6T6qKBmGyM2bmAZfxmnWfBAOCON5ixd+eIprC5zOI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nbxVWn8BPqBCsx1RHn5apmAvdQFV1n+stuzRkp1tWfzO2losg2kGceRqjt7sxzYZiWzxJGe6zSzk1UnfbASuusCC7qT/AO3T7o55hWlspRXY8LVv7B0EBRCl5CatujYBoTjoymemP+il5dlrYxxqSHqvAYGW0e2tcFnBmtrQ8N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SNbBSLjc; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2db17e8767cso67516241fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714485800; x=1715090600; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPEO0RWAvqMjT0IhuA0J9gOKQsCIQYXZsdev+OBW9Pk=;
        b=SNbBSLjc1VVziqzGuW+J6hTjz5cJCqdtjKDK0HRpuiHyqTQLAZVOtn20vppB1ukPVU
         XsrSsqBsWFkbZZC+iRwybIKeCyw45gY8GMgURJEY3/VqspucLl4UPP7XInMES1VuskqK
         8qrTABiIgoYeqMTMAwzC5g1BLFTOT+Rr69ZWvQt4Rwq6xdiEc6+ccAEfWwZ4sr1w9ZP0
         XzILH0dVR0Z5kJcIB62n25hpETxUvvYoQ8bTo+i+iLyURIX9g2KV81D/CqvbouexZHia
         YqkWdMa93nZ57i3VVILsZ8dxMxnuhGNopueUQ6ufSa3JOGsAJfvqTfP+ahsiFYh4tH41
         TxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714485800; x=1715090600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPEO0RWAvqMjT0IhuA0J9gOKQsCIQYXZsdev+OBW9Pk=;
        b=aZg0EIKnXy/0MHz18y9OFd85qEQ3lKYjDpL0kXrfNqQuDwJp6iwzBtGC/mHIL0opGI
         ulo2pXNX8Y3TyPqbGiDQbnkNcw8pFVggGbhhZxfWzUlQ1tgCozeG2BRbI5Oc1hnobCXL
         fz//xRM5Fw7YmHhLXS8krFB5xhPaqWce+E0FZedA5EZ4uaZiZ0W1GD8m6zJWmd9xkAkc
         cPv/Y6JzCtBUJhxnjuXNaH/XmULisLVtZYL6yFb9stQUhAAUaE4Rlu2vwIGgC4shwrzh
         ldzFmVB5ph9Oxrn9rByawHsd5ffcZ3+fURieNN2CTORZ27elY67qbUANrsP/tycBAfWi
         ElAA==
X-Forwarded-Encrypted: i=1; AJvYcCVtPN2kTRhEiZyF6K2VWYvvokynbNly4tEhxpGhLxGvh0myuIslY+KeRwfsdhVGAfqD1oRaIYzvA7hA386/8cWIzDsqfNKpNwV6xx53
X-Gm-Message-State: AOJu0Ywae/6Ux6UGyNEGyYzgQiWhE8/AR5qvJHkD2Y2FaFeeRp4+r4Jm
	inyGGMYNmYmWl3lWTtZnN0jvI9XdwJH3rM2+B+Sq2AgK06onAy0Icuv4irGe8oc=
X-Google-Smtp-Source: AGHT+IGh5m+2saezt4d4/Xj30jwjHn2HaB5/1wzlPXeDMAywvUMwy38mdPMQn/OqpOvF0tN4moRDWA==
X-Received: by 2002:ac2:4342:0:b0:516:d0c2:755 with SMTP id o2-20020ac24342000000b00516d0c20755mr1936131lfl.63.1714485799614;
        Tue, 30 Apr 2024 07:03:19 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id pv27-20020a170907209b00b00a5940af3f67sm31434ejb.16.2024.04.30.07.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:03:19 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 30 Apr 2024 16:02:21 +0200
Subject: [PATCH 12/13] ASoC: samsung: Use snd_soc_substream_to_rtd() for
 accessing private_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-asoc-snd-substream-clean-v1-12-6f8a8902b479@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=859;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=s6T6qKBmGyM2bmAZfxmnWfBAOCON5ixd+eIprC5zOI4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmMPn3jE3Jqd/FGkciqXRI8lqVudz+blh1rLunh
 DAPo4JfRZmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZjD59wAKCRDBN2bmhouD
 167MD/9WOiPSu4HFniDht9/iDlJgx4fouuoHImJ/CM8XXopNUpo7cqRR15JqKSLsDj6vLCZnDjI
 XJH4l92Ge2WRJcz0/XCKWm3Oj9AtC7ODuCsB3t2mfhBJxD0iuojyzEbOdRvzU55KzY/Jm2DElBe
 AVz2VKMPgF1zFr4pkhx3dxiMHbLe6UGPzibytjl5whdT2xAoImo+S2NZTWCKOe4+N7Zrs5X4MKN
 nksx0kWoenkduh9GxKCpr++Kokx/YYpvDE8obQfhLY80Z4tPSY6cX4vv9sfrzB9vGeLAU9yTvAc
 Wxh0WUV5cT2zuYc4pUkyqV+EX/Y3tPEE5xSP136C9a7FWO+Rd52ezaWXED2BY3hXspNrTrKXXTD
 nFQfKJ3M0bszW7Tctw01tKYZUa9Qf0bz/0oVbI6rpDgM3+PPLaVWT1D47FaKzfKQ9jnjaZWzOoF
 1F53c9Pv5Cdt+RLqjXfD1JfrGJRJ7hUbPzMQ/arruJidb9QiloV9Dp70EuGD0VudxXWXtwRzztI
 eIzKDw49c8QYUITfwxYEr1QsvBeQMeOGj/PlXQl1p6vj/Y4oFGW1SjDTITGrfjGFfmKEABGvYP6
 yK41SS5+akvGSPouciQ7r2EIqpAZMYxIFkaCVPRLm6VL/jKT9HDivO012DCh8z7Q3NuvimCGlwg
 o5bO2V6wsqvDkUQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Do not open-code snd_soc_substream_to_rtd().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/samsung/midas_wm1811.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/midas_wm1811.c b/sound/soc/samsung/midas_wm1811.c
index f31244156ff6..0841e2e6f8ce 100644
--- a/sound/soc/samsung/midas_wm1811.c
+++ b/sound/soc/samsung/midas_wm1811.c
@@ -127,7 +127,7 @@ static int midas_stop_fll1(struct snd_soc_pcm_runtime *rtd)
 static int midas_aif1_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd	= substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	unsigned int pll_out;
 
 	/* AIF1CLK should be at least 3MHz for "optimal performance" */

-- 
2.43.0


