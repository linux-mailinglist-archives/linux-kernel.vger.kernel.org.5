Return-Path: <linux-kernel+bounces-164673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C44A8B80EB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2846C288176
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CED19DF41;
	Tue, 30 Apr 2024 19:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rr319o1M"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BC3199E9E;
	Tue, 30 Apr 2024 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714506836; cv=none; b=f0FqWIOWRBP9FXC7N22U7/YnzJaY4X/R3ORnrpejmilFlsUF4YvF0qx6ewOFf+y9fJ8UjimycKyCRP8HjUm7zJJkX/dOzx6Z4JQtbxp+gYLXjvPPdIS7262R3VFf7GWBkhTB/KzCzELEZ0KmQWUDTfew9gupXiv5n2UU0dhn9/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714506836; c=relaxed/simple;
	bh=/57uI0NnDO2LrGAjhLyCD8a8uhYqBrJbnu0u7FZxjEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HuBmo5BXh9QIHrA1iI0rK3Gm7vUqFEaz4pKblHXeOFbnvmQFmbNxiSGjg6gad4NdY3rM4ZfN/vinzfX5fKBdBoFe09eOtqozhqd8l8vq3cKEEIiW97G/jwykHdmu2awCyK7+54obOM/QaOBcXquIAzuWz8nHr1bAi8a42eIMGT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rr319o1M; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5872b74c44so693152966b.3;
        Tue, 30 Apr 2024 12:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714506833; x=1715111633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQq1oWqrCF0TfrogSNrGXKQjYOwjvsMuDYhQTiGCeqo=;
        b=Rr319o1MdPtfRjoocsjULxV0wIXGOBwQ9QefvKHZIlSEJ7tkqgc/G3HdeHmVCCNQnx
         y7kp+4czTCkdpp1+2zM3qxppbK9SFK9p9uwPQDqNsrgKChInNFRys52HAfj4choZNWDN
         TlvgQeE98HE1aFjfcq/D4Zdr3EdAdMlyWoBvDdaaXy5FJh6vnEt07qZ8VS09mZXaZmYM
         YxT34l5eR6nerhNit7mEvfCkMxNNswuixRv1suIWa1VZP9KFutl/+PbQG1DD26kAm79E
         UVlw3GJUhlJ6EpxkULZHm3yWjPlC+i+IyHzkX3KHNeH11gRwAVWgbyldUgSh/5liZ4wr
         xW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714506833; x=1715111633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQq1oWqrCF0TfrogSNrGXKQjYOwjvsMuDYhQTiGCeqo=;
        b=iCj2io3BR5o2b5A7AkL0DyeCx9MQbcVMoio53MFpT7+BUgVQzWPAGNobLDAZT2JDHg
         O5DZbfGd6h5xZ/5VUG03kj5Rhc/ZyjHMDsI6TLIqFPv+97ov2ocCHCY/obtkFIO7XWLT
         E6u8ffbiOIr+JMZPnagyv7eYBT7KZsUkJ8qKOgy6vZGhFMZEir7AFVF9LVAvUeEj3zEx
         lqgI4VPhYUDxN6M5bh557gUTths0jdYhW5uLphyGE0duHHuXCsdGFb/CgZWJ6EGfk5ko
         hS2ayMWfWUr5SUfPa0qgXmHTCfhyzhDfbBJV1Y9hJT6XIp3nENVNK+1948TmnnZ00h4R
         1DKA==
X-Forwarded-Encrypted: i=1; AJvYcCVjC/RVHiTazn7kBsYXl0vmMpM35p395+vwy30oKLZek5DwsOjg0piLM3wfrsuGaLpuUZgLIzaMXS5G/7ErV06XuZJJtsCE7sXV5ALGJDl02mMUEAl8XTu4Z/DpP3dE1etR30/xj2sOJxyAmpqv/X1TfXmQz4DEdK0un+fE3CxCU1wFQ4wjvsz5o+TPR0M9ZuB4UPs/pIJXGgxRbokbXoQ5iAw=
X-Gm-Message-State: AOJu0YyyrxhjlQDixv8IjzX/6YMwDiytsXrL+uhehdmNXeESngG8HItk
	WXncpZmmu1bFY7JA8pdm+uxxSfC1c0gHIw9eH+HF1Tbgt6kMmPMx
X-Google-Smtp-Source: AGHT+IHcHyFMebv11hNczXbfOSBPzOfPEK56ZS5IQDWu8DzPrwNQuSSocR8UcDfVrVvZhY8lrKqE1g==
X-Received: by 2002:a17:906:a084:b0:a55:387b:eef9 with SMTP id q4-20020a170906a08400b00a55387beef9mr455005ejy.10.1714506832645;
        Tue, 30 Apr 2024 12:53:52 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906058d00b00a522d34fee8sm15418045ejn.114.2024.04.30.12.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 12:53:52 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
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
 Samuel Holland <samuel@sholland.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-sunxi@lists.linux.dev,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject:
 Re: [PATCH 13/13] ASoC: sunxi: Use snd_soc_substream_to_rtd() for accessing
 private_data
Date: Tue, 30 Apr 2024 21:53:49 +0200
Message-ID: <3292058.44csPzL39Z@jernej-laptop>
In-Reply-To: <20240430-asoc-snd-substream-clean-v1-13-6f8a8902b479@linaro.org>
References:
 <20240430-asoc-snd-substream-clean-v1-0-6f8a8902b479@linaro.org>
 <20240430-asoc-snd-substream-clean-v1-13-6f8a8902b479@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne torek, 30. april 2024 ob 16:02:22 GMT +2 je Krzysztof Kozlowski napisal(a):
> Do not open-code snd_soc_substream_to_rtd().
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  sound/soc/sunxi/sun50i-dmic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sunxi/sun50i-dmic.c b/sound/soc/sunxi/sun50i-dmic.c
> index c76628bc86c6..fedfa4fc95fb 100644
> --- a/sound/soc/sunxi/sun50i-dmic.c
> +++ b/sound/soc/sunxi/sun50i-dmic.c
> @@ -74,7 +74,7 @@ static const struct dmic_rate dmic_rate_s[] = {
>  static int sun50i_dmic_startup(struct snd_pcm_substream *substream,
>  			       struct snd_soc_dai *cpu_dai)
>  {
> -	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
>  	struct sun50i_dmic_dev *host = snd_soc_dai_get_drvdata(snd_soc_rtd_to_cpu(rtd, 0));
>  
>  	/* only support capture */
> 
> 





