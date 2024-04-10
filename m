Return-Path: <linux-kernel+bounces-138844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B846F89FB58
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3D49B2ABA6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1E916E873;
	Wed, 10 Apr 2024 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rUfT5de2"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A22216D4DB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761662; cv=none; b=VK3hKo+wlf8904HufqpEAptb/AJk2GrAN/vutxliLBZ+PNgk52zmM78s0w3Q2waBeMR1qkmQ9EIoD8hjv1e3etQAIFHEq9bMnwyj4UVLSivWJiZ8yWeIZOd0uIDhbRL8Bo2Hucz7xVgwB8eDGIyCTqepbB/uKQxAagvBvx1bwuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761662; c=relaxed/simple;
	bh=uahkF1VOEWvbo4wDDrFwOjLhjLjNoYbSCjv9ymH8OPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/zN2X43UnMX0NFn6LZP632tPURFmd3bQeHwVuK+qQjr1mJkm88ufRMmZaGdAL3OzJIgCfUPWTZJnKDEYlJlxLkCKlaZhz1erjfzglRTo887dRm0SawEPiN1269ZD++epDlvARAvUrPyAHRWfTz26jjIOx7C51h9QToIr4aqO+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rUfT5de2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-346359c8785so1108389f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712761657; x=1713366457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+P+72Hlq99kFNnxAOkF8xNKRqdp0Nj1rk4leGd6q+bQ=;
        b=rUfT5de2xpcVvd0Qjs4/cQiBCc7lcADNRcqjK02yAvZN6/LGBSJ5jfEAwu+yG+4VKf
         6fd/StcMagj2tILBeaeecaKRnPekGP5yN3OL68ufh2ULHCuzS9VyzNUozxhyVf7Nnv1N
         6iyMRcVXrEZcRVQW5wkF4jlgDN+gx14aUeKNwHa3UwwBnRcjgLYC+aJxZh68f7GTGAuR
         6s7fNU9T0Y5YHFxl1CCtDvpCVlGlkH5zdvINZG0UzTxsv2u17oFRcnx7RWIw5pNyj+df
         uv5OvIrc1JZqV6TgZKgtoO1tKDQsmXky0JfHwgUdvFXEGSQxyg3CWmsnk2abs+V4FNSw
         XrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712761657; x=1713366457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+P+72Hlq99kFNnxAOkF8xNKRqdp0Nj1rk4leGd6q+bQ=;
        b=ClFrbpXkfTCSY5HgCLq/7cfb84LdlDL59Nj5Xkm6UMJxg6nsL9TFtbdyk41iEzmbZf
         LRabtNNgljhmyQ5fTKH/bpxzFRKws5HxyNAhHK5lTgX/nkjMJMMN+qiu2ixAs77dnnQ1
         cKbtwHNO8LvINabHSXTCc8VJgC68tv2ZAvCCayY2EKnmmVWxM6dMxLGhuFASf25ZsEfO
         Y2ZepnqndF8QTowmgLOTGBns23nzx8mjMOu0LpoWEoulHMOTgl/hTPW3cvXCy8M+LrwT
         Ao5cerYRppYmvhU2IwIAIDwIRjW9vMB1GdUsHoaIjxmFUk4Dad+Z5utMi/BToOf2tASE
         tkgg==
X-Forwarded-Encrypted: i=1; AJvYcCXr1hv6ucIRTmOhfgQrw1+HcbtPlhsAydsAtZhhz2Gl4w5X3o3Ebq0ZN1tfYSerMSw09J/ljuoGCh0oz3nEjESS1kWDYombzNdN458G
X-Gm-Message-State: AOJu0YwUPkDwM/OEjftm1rNocYumSf7RfNUPXkZpDAIkPjdAZJwAJFFS
	hM+HgevVzHgobeSUnFUPqc77eUK4K8/Di8ztOPt0Xjl+nvfEQje0RdYxRtRkn/I=
X-Google-Smtp-Source: AGHT+IFhnB0gsdOm+IB5xuyR92fHk4A/RRmX5WG9qW/Rsc9kuPzli806ObV+/wdLIouJrwCNwH1GSA==
X-Received: by 2002:a5d:47a7:0:b0:343:bb25:82f0 with SMTP id 7-20020a5d47a7000000b00343bb2582f0mr2577063wrb.11.1712761657374;
        Wed, 10 Apr 2024 08:07:37 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id c8-20020adfe748000000b00343a0e2375esm13906254wrn.27.2024.04.10.08.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 08:07:37 -0700 (PDT)
Message-ID: <65b3ec7e-e753-4692-b778-a9246e9e6664@baylibre.com>
Date: Wed, 10 Apr 2024 17:07:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/18] ASoC: mediatek: mt8186-rt1019: Migrate to the
 common mtk_soundcard_startup
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 broonie@kernel.org
Cc: wenst@chromium.org, lgirdwood@gmail.com, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com,
 trevor.wu@mediatek.com, maso.huang@mediatek.com,
 xiazhengqiao@huaqin.corp-partner.google.com, arnd@arndb.de,
 kuninori.morimoto.gx@renesas.com, shraash@google.com,
 nicolas.ferre@microchip.com, u.kleine-koenig@pengutronix.de,
 dianders@chromium.org, frank.li@vivo.com, allen-kh.cheng@mediatek.com,
 eugen.hristev@collabora.com, claudiu.beznea@tuxon.dev,
 jarkko.nikula@bitmer.com, jiaxin.yu@mediatek.com, alpernebiyasak@gmail.com,
 ckeepax@opensource.cirrus.com, zhourui@huaqin.corp-partner.google.com,
 nfraprado@collabora.com, alsa-devel@alsa-project.org,
 shane.chien@mediatek.com, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20240409113310.303261-1-angelogioacchino.delregno@collabora.com>
 <20240409113310.303261-11-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240409113310.303261-11-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

What is the purpose of these change ? I don't see the link with the 
migration to the common mtk_soundcard_startup.

On 09/04/2024 13:33, AngeloGioacchino Del Regno wrote:
> diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
> index bfcfc68ac64d..dbe5afa0e9ee 100644
> --- a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
> +++ b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
> @@ -2729,7 +2729,7 @@ static int mt8186_afe_runtime_resume(struct device *dev)
>   	struct mtk_base_afe *afe = dev_get_drvdata(dev);
>   	struct mt8186_afe_private *afe_priv = afe->platform_priv;
>   	int ret;
> -
> +pr_err("mt8186 afe runtime_resume\n");

Forgot to remove this print ?

>   	ret = mt8186_afe_enable_clock(afe);
>   	if (ret)
>   		return ret;
> @@ -2739,7 +2739,7 @@ static int mt8186_afe_runtime_resume(struct device *dev)
>   		return ret;
>   
>   	if (!afe->regmap || afe_priv->pm_runtime_bypass_reg_ctl)
> -		goto skip_regmap;
> +		return 0;
>   
>   	regcache_cache_only(afe->regmap, false);
>   	regcache_sync(afe->regmap);
> @@ -2758,13 +2758,20 @@ static int mt8186_afe_runtime_resume(struct device *dev)
>   	/* enable AFE */
>   	regmap_update_bits(afe->regmap, AFE_DAC_CON0, AUDIO_AFE_ON_MASK_SFT, BIT(0));
>   
> -skip_regmap:
>   	return 0;
>   }
>   
>   static int mt8186_afe_component_probe(struct snd_soc_component *component)
>   {
> -	mtk_afe_add_sub_dai_control(component);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
> +	int ret;
> +
> +	snd_soc_component_init_regmap(component, afe->regmap);
> +
> +	ret = mtk_afe_add_sub_dai_control(component);
> +	if (ret)
> +		return ret;
> +
>   	mt8186_add_misc_control(component);
>   
>   	return 0;
> @@ -2929,6 +2936,10 @@ static int mt8186_afe_pcm_dev_probe(struct platform_device *pdev)
>   		goto err_pm_disable;
>   	}
>   
> +	ret = regmap_reinit_cache(afe->regmap, &mt8186_afe_regmap_config);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "regmap_reinit_cache fail\n");
> +
>   	/* others */
>   	afe->mtk_afe_hardware = &mt8186_afe_hardware;
>   	afe->memif_fs = mt8186_memif_fs;
> diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
> index dbd157d1a1ea..b87b04928678 100644
> --- a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
> +++ b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
> @@ -413,7 +413,7 @@ static const struct snd_soc_dapm_widget mtk_dai_adda_widgets[] = {
>   			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
>   
>   	SND_SOC_DAPM_SUPPLY_S("AUD_PAD_TOP", SUPPLY_SEQ_ADDA_AUD_PAD_TOP,
> -			      AFE_AUD_PAD_TOP, RG_RX_FIFO_ON_SFT, 0,
> +			      SND_SOC_NOPM, 0, 0,

Is it related to the regmap init function added in the AFE PCM probe ?

>   			      mtk_adda_pad_top_event,
>   			      SND_SOC_DAPM_PRE_PMU),
>   	SND_SOC_DAPM_SUPPLY_S("ADDA_MTKAIF_CFG", SUPPLY_SEQ_ADDA_MTKAIF_CFG,

-- 
Regards,
Alexandre

