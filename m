Return-Path: <linux-kernel+bounces-144108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 695C78A41EC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88B4CB212EA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DD22E647;
	Sun, 14 Apr 2024 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aR2/29ts"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5111E53F;
	Sun, 14 Apr 2024 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713091703; cv=none; b=Tp913DViTThHBEvaD+kGeaoHHhG8sulhkGWAgaNx5AFO9ZFLyDepJwpsPCOdh0Nz+1/LuMpLPumvLg5wLwd3UN7ChQN/AcHC55bSH1zJmLVF29+E0y0bcoc59L6hF9EYga4KFXmH4y0N8FcBxNI7TGtH5YHGFrmRM5UMqq7OBp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713091703; c=relaxed/simple;
	bh=ppeZY3dWzDAzZxs0tI8WOxOiEzHzWsZcatHCpGuDVA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iskWKZ6TRlgrQfHf/QXb/PcMROZcGkUou2EEywUQuxjZrLLwgVufPPGLpu4yFtOFF89yGjXzzEVluVFNw8QkyWdclIjm5Vxawvi9v2EnS25Sm6X1RtB1T2BtRuuf+wZaTjR8A6n3LR9RwsTNMy5lBWsflRdK+gfXoVMH7oGGHMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aR2/29ts; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a44665605f3so229389566b.2;
        Sun, 14 Apr 2024 03:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713091700; x=1713696500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/mEm9VxMgunJVGx3eWq8zXkvnaXSuLo3RVjgAEd/rI=;
        b=aR2/29tsjFwIgRzCoy7LhqvDZB6GE1o85HsJX4DHe8RXAZ70hxhrIdmzGxqA6rE3+p
         xh/FCH+w61kz1vpxkMpXOIIWx++qLZWvGe7R4Sl2Irk0Kn9UbBPfDdipI/KS2xJ07m/N
         a2YQ45ZWmHsN/hMbFGk3IMJAVUbw4p6eTObT07Pn9/PvSvTqajTxkzmnzIYAP1vjA9Vj
         O6UW7vpzWqgNW+NgwjnaUZhSG3R44tW52jEd2KjQ32j8bdwBfXtUtD/dSIJ/h1Cmxotv
         oMiZmiouJBL1AQFIIFI+lZU2KUSpzDtrseqYc5KvN4wTueuEgBiA4ZhJ148COegbNN/+
         RZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713091700; x=1713696500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/mEm9VxMgunJVGx3eWq8zXkvnaXSuLo3RVjgAEd/rI=;
        b=Y7guVblLjqZJNo9fYzBwbCYHLtePZNl0b5syzbcHUL05BUFSIz5nhpIU1ty+owZ/Xd
         vsSBOUVqErQv4+IpOpaqEKmZjUqlzOFZzyd9MFpiBo+Q+XVP5yGq7cASsJmjxZsoU3DW
         hpWjM+YD0xDE49aGo/jMUFbwzIA1VATLJNB1gV0Rm/PYpgooWQERM5s7Agv+bQNZiti+
         aCwkOzF+1I9Lj4Z8KoiGo6seiK4H9qCtWMzDcuhO94rCD93lLvwrDbfjJvPxQwPAbjRu
         tqznYSzGuJ4T5x7m+Q1VSc4eFWCXDGBKFgVE+HBvYl+d2pzQJey/8tWIZKV89Ilkq/5D
         /NLg==
X-Forwarded-Encrypted: i=1; AJvYcCVTiOVYNeXQlDdcJXneRPIgd/xBLupMF/2qfOVuwfVz+HBXQJDgb/UnJJYtlxqEpVb+EbXgihYyGgGkfCQe5uHasR5XD/s8ab8RCHbY
X-Gm-Message-State: AOJu0Yw4yqCy1sz10c6l4GbZ9qs3nht5XFNv67CouQlx/v1zgcXUEwlP
	svPLRGEwcWXsojWkgiVq83KEZsnwNhpJ8W/qlrb95F8V7aUCzn5S
X-Google-Smtp-Source: AGHT+IHioJIDXt3U+RODv/eSjkVBLxKX703mo9NFte/m+z5JlwQDMaUrTXF1oC/MLZwQ0sZ4qwSY3g==
X-Received: by 2002:a17:907:7244:b0:a52:3010:af03 with SMTP id ds4-20020a170907724400b00a523010af03mr5152756ejc.5.1713091700187;
        Sun, 14 Apr 2024 03:48:20 -0700 (PDT)
Received: from jernej-laptop.localnet (APN-123-252-50-gprs.simobil.net. [46.123.252.50])
        by smtp.gmail.com with ESMTPSA id cr19-20020a170906d55300b00a46b4c09670sm4070532ejc.131.2024.04.14.03.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 03:48:19 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 John Watts <contact@jookia.org>
Cc: linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 John Watts <contact@jookia.org>
Subject: Re: [PATCH v2] ASoC: sunxi: sun4i-i2s: Support 32-bit audio formats
Date: Sun, 14 Apr 2024 12:48:17 +0200
Message-ID: <1787594.VLH7GnMWUR@jernej-laptop>
In-Reply-To: <20240403-sunxi_s32-v2-1-29ebf6ad590a@jookia.org>
References: <20240403-sunxi_s32-v2-1-29ebf6ad590a@jookia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne sreda, 3. april 2024 ob 05:47:35 CEST je John Watts napisal(a):
> The I2S cores used in the H3 onwards support 32-bit sample rates.
> Support these by adding a per-variant PCM format list.
> 
> Signed-off-by: John Watts <contact@jookia.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
> This patch enables support for 32-bit audio in the sunxi I2S driver.
> 
> I have only tested this on the Allwinner T113 but I'm fairly
> certain it will work on older boards.
> ---
> Changes in v2:
> - Specify PCM formats for each variant instead of failing in hw_params
> - Link to v1: https://lore.kernel.org/r/20240326-sunxi_s32-v1-1-899f71dcb1e6@jookia.org
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index a736f632bf0b..59830f2a0d30 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -156,6 +156,7 @@ struct sun4i_i2s;
>  /**
>   * struct sun4i_i2s_quirks - Differences between SoC variants.
>   * @has_reset: SoC needs reset deasserted.
> + * @pcm_formats: available PCM formats
>   * @reg_offset_txdata: offset of the tx fifo.
>   * @sun4i_i2s_regmap: regmap config to use.
>   * @field_clkdiv_mclk_en: regmap field to enable mclk output.
> @@ -175,6 +176,7 @@ struct sun4i_i2s;
>   */
>  struct sun4i_i2s_quirks {
>  	bool				has_reset;
> +	snd_pcm_format_t		pcm_formats;
>  	unsigned int			reg_offset_txdata;	/* TX FIFO */
>  	const struct regmap_config	*sun4i_i2s_regmap;
>  
> @@ -1092,8 +1094,18 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
>  	return 0;
>  }
>  
> +static int sun4i_i2s_dai_startup(struct snd_pcm_substream *sub, struct snd_soc_dai *dai)
> +{
> +	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> +	struct snd_pcm_runtime *runtime = sub->runtime;
> +
> +	return snd_pcm_hw_constraint_mask64(runtime, SNDRV_PCM_HW_PARAM_FORMAT,
> +					    i2s->variant->pcm_formats);
> +}
> +
>  static const struct snd_soc_dai_ops sun4i_i2s_dai_ops = {
>  	.probe		= sun4i_i2s_dai_probe,
> +	.startup	= sun4i_i2s_dai_startup,
>  	.hw_params	= sun4i_i2s_hw_params,
>  	.set_fmt	= sun4i_i2s_set_fmt,
>  	.set_sysclk	= sun4i_i2s_set_sysclk,
> @@ -1101,9 +1113,10 @@ static const struct snd_soc_dai_ops sun4i_i2s_dai_ops = {
>  	.trigger	= sun4i_i2s_trigger,
>  };
>  
> -#define SUN4I_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
> -			 SNDRV_PCM_FMTBIT_S20_LE | \
> -			 SNDRV_PCM_FMTBIT_S24_LE)
> +#define SUN4I_FORMATS_ALL (SNDRV_PCM_FMTBIT_S16_LE | \
> +			   SNDRV_PCM_FMTBIT_S20_LE | \
> +			   SNDRV_PCM_FMTBIT_S24_LE | \
> +			   SNDRV_PCM_FMTBIT_S32_LE)
>  
>  static struct snd_soc_dai_driver sun4i_i2s_dai = {
>  	.capture = {
> @@ -1111,14 +1124,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
>  		.channels_min = 1,
>  		.channels_max = 8,
>  		.rates = SNDRV_PCM_RATE_8000_192000,
> -		.formats = SUN4I_FORMATS,
> +		.formats = SUN4I_FORMATS_ALL,
>  	},
>  	.playback = {
>  		.stream_name = "Playback",
>  		.channels_min = 1,
>  		.channels_max = 8,
>  		.rates = SNDRV_PCM_RATE_8000_192000,
> -		.formats = SUN4I_FORMATS,
> +		.formats = SUN4I_FORMATS_ALL,
>  	},
>  	.ops = &sun4i_i2s_dai_ops,
>  	.symmetric_rate = 1,
> @@ -1340,8 +1353,12 @@ static int sun4i_i2s_runtime_suspend(struct device *dev)
>  	return 0;
>  }
>  
> +#define SUN4I_FORMATS_A10 (SUN4I_FORMATS_ALL & ~SNDRV_PCM_FMTBIT_S32_LE)
> +#define SUN4I_FORMATS_H3 SUN4I_FORMATS_ALL
> +
>  static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
>  	.has_reset		= false,
> +	.pcm_formats		= SUN4I_FORMATS_A10,
>  	.reg_offset_txdata	= SUN4I_I2S_FIFO_TX_REG,
>  	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
>  	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
> @@ -1360,6 +1377,7 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
>  
>  static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
>  	.has_reset		= true,
> +	.pcm_formats		= SUN4I_FORMATS_A10,
>  	.reg_offset_txdata	= SUN4I_I2S_FIFO_TX_REG,
>  	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
>  	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
> @@ -1383,6 +1401,7 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
>   */
>  static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
>  	.has_reset		= true,
> +	.pcm_formats		= SUN4I_FORMATS_A10,
>  	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
>  	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
>  	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
> @@ -1401,6 +1420,7 @@ static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
>  
>  static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
>  	.has_reset		= true,
> +	.pcm_formats		= SUN4I_FORMATS_H3,
>  	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
>  	.sun4i_i2s_regmap	= &sun8i_i2s_regmap_config,
>  	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8),
> @@ -1419,6 +1439,7 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
>  
>  static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
>  	.has_reset		= true,
> +	.pcm_formats		= SUN4I_FORMATS_H3,
>  	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
>  	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
>  	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
> @@ -1437,6 +1458,7 @@ static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
>  
>  static const struct sun4i_i2s_quirks sun50i_h6_i2s_quirks = {
>  	.has_reset		= true,
> +	.pcm_formats		= SUN4I_FORMATS_H3,
>  	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
>  	.sun4i_i2s_regmap	= &sun50i_h6_i2s_regmap_config,
>  	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8),
> @@ -1455,6 +1477,7 @@ static const struct sun4i_i2s_quirks sun50i_h6_i2s_quirks = {
>  
>  static const struct sun4i_i2s_quirks sun50i_r329_i2s_quirks = {
>  	.has_reset		= true,
> +	.pcm_formats		= SUN4I_FORMATS_H3,
>  	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
>  	.sun4i_i2s_regmap	= &sun50i_h6_i2s_regmap_config,
>  	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8),
> 
> ---
> base-commit: 13227c2baa6b345451128828c9c2b0ec3868bd0d
> change-id: 20240326-sunxi_s32-f2ab25b8e688
> 
> Best regards,
> 





