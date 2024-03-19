Return-Path: <linux-kernel+bounces-107750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 445DE880142
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE67AB2355A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B4181725;
	Tue, 19 Mar 2024 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRnaBHcS"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D02657BE;
	Tue, 19 Mar 2024 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710863782; cv=none; b=fiVnuqJRdP1shHZAuZjw7oTjYJlLKDA6t3SgNX2pdD9fqSMeBwndHgRCPLHCrbH0HzOHkcAvETtYBa6MdyGYtSH4rLZ7/JH3H/7c14zB9UQVN05ntkbg4jbheLaBC4ZbmObLoGqsSCKoc+VqlKSi/TJp2VCaypKGymdKTHoYtI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710863782; c=relaxed/simple;
	bh=kTIWQgBaqX7BCGZ6l0YNbzF24DBdzNGDd7qEdfi2zjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mu3kj6J0rtqzjeCcyHdEwWxe1VvAubA09dTzNTpjaoPsbTldTul1RPbxj9ncOVl5qL2+BFT7/NYpaKD9PHna4wA4+pa4cSB21XIH6c6ZTRWpa1KkE8tFWhhUJUewQ2jueZcM4cCfu2IUwUDSvVXbDmNeM7yu5qrsCnabGjk+1Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRnaBHcS; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513dd2d2415so4466880e87.3;
        Tue, 19 Mar 2024 08:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710863778; x=1711468578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t4IC/jDYnczASn/Z+j5D8kmO/fWJVOdRI8Restnbwbk=;
        b=ZRnaBHcSHAD+8+R8QRL2dOdv4nqz6wfl5XkNZnQboQfE3He7ktwl1Qqzn2lgXwGeRz
         wmzPBxx8Xb2G7aZUk8VbJSZsqiAvIMDjHyangjKl9e36ynPbeylPoEG/AVzZ8tKg/2qW
         hU183za6xaJDMZ6PYPLVkWXHEOP6SsmOR1cw5w1XNbGKNQldVQooETaexRe5lfozFSCw
         DDa2TPJkTqi8gzI8xXt/o+bQfnO/TcdlK2ki2s1g/y3jN4go9RV1HmyH9h3ejdY29X6a
         2Fz2JwXPcdkZbAzn1kCi3mRdpcendQ7PRXOa7EA6M3yjsC7No1/bxtEInEbe4C+y6+Aw
         7eSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710863778; x=1711468578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t4IC/jDYnczASn/Z+j5D8kmO/fWJVOdRI8Restnbwbk=;
        b=CryyjrPH1M+T8YrvdUlG5rBrATQJPkpTd+UNlK68WaCaorlIzx16AcCfE6Yb8w4jBr
         xk2+cQu7WKf2tHXNi77LNmkcxFce1WtIim3TmwazfotpV28rcc1qNP94Nnt3R3jLUhh6
         EDwWcce+YoSy6pFEf7/0ObFpFJCuCatznPh4uDQXj+QTVJshZpLFxxuiHt/M7Dkn0qY4
         /ClWccd8GhioiWqUcDwVVMatxroaNb38IGwtd10OVHS1EVuImn4ZgxLFmMz3q1Xxa+pX
         61C1sFMCJhJ2zPFcjOX8/afQmr9wXPOX6yzXE6UA+lRspV3PrWxZuyVsYDf8nM1lfneG
         zb/g==
X-Forwarded-Encrypted: i=1; AJvYcCWEcnD11AkPlm3UqnzqJZC7+3o+yxes0UcZaNnXz2zz8v8jzmzMkadZrkdv5a2byT5zQCIBC3Gmle43vvu6l/O4gM66W9VOfa9G/J5/FnfHUfaL1uH+Ye3lZ4WtuD2v+RRerut7e5xE1g==
X-Gm-Message-State: AOJu0YzS2bXG1+40ziDySyTbTn3/JZOAeAVHnkLxXzCFLjIgzcUNNrQo
	vZQH3sHan6XfTn2Y2zM40d1lVTjnFsWxRRW4KwcysfH+ALFxMSaq
X-Google-Smtp-Source: AGHT+IHPjsVkIChJGewZZKSNJVAbvELDs1703BC5ZulAjkk2eenekYwRB/mjugs3Enk3gw3PaJ7LfA==
X-Received: by 2002:a19:ca05:0:b0:513:b30c:53c7 with SMTP id a5-20020a19ca05000000b00513b30c53c7mr9644413lfg.10.1710863778027;
        Tue, 19 Mar 2024 08:56:18 -0700 (PDT)
Received: from ?IPV6:2001:999:708:5b57:30d6:2195:bb7b:bb94? ([2001:999:708:5b57:30d6:2195:bb7b:bb94])
        by smtp.gmail.com with ESMTPSA id u13-20020ac25bcd000000b005131434454bsm1959551lfn.228.2024.03.19.08.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 08:56:17 -0700 (PDT)
Message-ID: <9d123584-1feb-404b-890f-2da694cf56d5@gmail.com>
Date: Tue, 19 Mar 2024 17:57:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] ASoC: ti: davinci-i2s: Add TDM support
To: Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-8-bastien.curutchet@bootlin.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20240315112745.63230-8-bastien.curutchet@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 15/03/2024 13:27, Bastien Curutchet wrote:
> TDM is not supported by the McBSP driver. The McBSP datasheet does not
> name explicitly TDM as a supported format but it is possible to configure
> the McBSP to do TDM if all slots are used by McBSP.
> 
> Add TDM support. It uses single-phase frame. Slot width is used to
> compute the McBSP's word length.
> 
> Implement the set_tdm_slot() hook of snd_soc_dai_ops struct. It only
> supports TDM if all slots are used by McBSP.
> 
> The snd_soc_dai_driver's capture.channels_max is updated from 2 to 128.
> 128 is the maximum frame length when using single-phase frame.
> playback.channels_max has not been updated as I could not test TDM on
> playbacks with my hardware.
> 
> This was tested on platform designed off of DAVINCI/OMAP_L138 with BP_FC
> format so this is only supported format for TDM yet. A check is done in
> davinci_i2s_set_dai_fmt() to prevent TDM to be used with other formats
> 
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> ---
>  sound/soc/ti/davinci-i2s.c | 81 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 77 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
> index f4514d4dff07..4adaed010700 100644
> --- a/sound/soc/ti/davinci-i2s.c
> +++ b/sound/soc/ti/davinci-i2s.c
> @@ -160,6 +160,9 @@ struct davinci_mcbsp_dev {
>  	unsigned int fmt;
>  	int clk_div;
>  	bool i2s_accurate_sck;
> +
> +	int tdm_slots;
> +	int slot_width;
>  };
>  
>  static inline void davinci_mcbsp_write_reg(struct davinci_mcbsp_dev *dev,
> @@ -213,6 +216,57 @@ static void davinci_mcbsp_stop(struct davinci_mcbsp_dev *dev, int playback)
>  	toggle_clock(dev, playback);
>  }
>  
> +static int davinci_i2s_tdm_word_length(int tdm_slot_width)
> +{
> +	switch (tdm_slot_width) {
> +	case 8:
> +		return DAVINCI_MCBSP_WORD_8;
> +	case 12:
> +		return DAVINCI_MCBSP_WORD_12;
> +	case 16:
> +		return DAVINCI_MCBSP_WORD_16;
> +	case 20:
> +		return DAVINCI_MCBSP_WORD_20;
> +	case 24:
> +		return DAVINCI_MCBSP_WORD_24;
> +	case 32:
> +		return DAVINCI_MCBSP_WORD_32;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int davinci_i2s_set_tdm_slot(struct snd_soc_dai *cpu_dai,
> +				    unsigned int tx_mask,
> +				    unsigned int rx_mask,
> +				    int slots, int slot_width)
> +{
> +	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
> +
> +	dev_dbg(dev->dev, "%s - slots %d, slot_width %d\n", __func__, slots, slot_width);

The __func__ can be ommited, it is better to leave it for dynamic
debugging by adding "dyndbg=+pmf" module parameter if needed.

> +
> +	if (slots > 128 || !slots) {
> +		dev_err(dev->dev, "Invalid number of slots\n");
> +		return -EINVAL;
> +	}
> +
> +	if (rx_mask != (1 << slots) - 1) {
> +		dev_err(dev->dev, "Invalid RX mask (0x%08x) : all slots must be used by McBSP\n",
> +			rx_mask);
> +		return -EINVAL;

This is only a restriction for RX?

> +	}
> +
> +	if (davinci_i2s_tdm_word_length(slot_width) < 0) {
> +		dev_err(dev->dev, "%s: Unsupported slot_width %d\n", __func__, slot_width);
> +		return -EINVAL;
> +	}
> +
> +	dev->tdm_slots = slots;
> +	dev->slot_width = slot_width;
> +
> +	return 0;
> +}
> +
>  #define DEFAULT_BITPERSAMPLE	16
>  
>  static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
> @@ -228,6 +282,13 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
>  		DAVINCI_MCBSP_SRGR_FWID(DEFAULT_BITPERSAMPLE - 1);
>  
>  	dev->fmt = fmt;
> +
> +	if ((dev->tdm_slots || dev->slot_width) &&
> +	    ((fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) != SND_SOC_DAIFMT_BP_FC)) {
> +		dev_err(dev->dev, "TDM is only supported for BP_FC format\n");
> +		return -EINVAL;

I think this is not a valid statement, Fsync can be generated internally
or coming from external source in TDM mode also.

> +	}
> +
>  	/* set master/slave audio interface */
>  	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
>  	case SND_SOC_DAIFMT_BP_FP:
> @@ -383,7 +444,13 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
>  
>  	master = dev->fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK;
>  	fmt = params_format(params);
> -	mcbsp_word_length = asp_word_length[fmt];
> +	if (dev->slot_width)
> +		mcbsp_word_length = davinci_i2s_tdm_word_length(dev->slot_width);
> +	else
> +		mcbsp_word_length = asp_word_length[fmt];
> +
> +	if (mcbsp_word_length < 0)
> +		return mcbsp_word_length;
>  
>  	switch (master) {
>  	case SND_SOC_DAIFMT_BP_FP:
> @@ -483,8 +550,13 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
>  	switch (master) {
>  	case SND_SOC_DAIFMT_BP_FP:
>  	case SND_SOC_DAIFMT_BP_FC:
> -		rcr |= DAVINCI_MCBSP_RCR_RFRLEN1(0);
> -		xcr |= DAVINCI_MCBSP_XCR_XFRLEN1(0);
> +		if (dev->tdm_slots > 0) {
> +			rcr |= DAVINCI_MCBSP_RCR_RFRLEN1(dev->tdm_slots - 1);
> +			xcr |= DAVINCI_MCBSP_XCR_XFRLEN1(dev->tdm_slots - 1);
> +		} else {
> +			rcr |= DAVINCI_MCBSP_RCR_RFRLEN1(0);
> +			xcr |= DAVINCI_MCBSP_XCR_XFRLEN1(0);
> +		}
>  		break;
>  	case SND_SOC_DAIFMT_BC_FC:
>  	case SND_SOC_DAIFMT_BC_FP:
> @@ -609,6 +681,7 @@ static const struct snd_soc_dai_ops davinci_i2s_dai_ops = {
>  	.hw_params	= davinci_i2s_hw_params,
>  	.set_fmt	= davinci_i2s_set_dai_fmt,
>  	.set_clkdiv	= davinci_i2s_dai_set_clkdiv,
> +	.set_tdm_slot   = davinci_i2s_set_tdm_slot,
>  
>  };
>  
> @@ -621,7 +694,7 @@ static struct snd_soc_dai_driver davinci_i2s_dai = {
>  	},
>  	.capture = {
>  		.channels_min = 2,
> -		.channels_max = 2,
> +		.channels_max = 128,
>  		.rates = DAVINCI_I2S_RATES,
>  		.formats = DAVINCI_I2S_FORMATS,
>  	},

-- 
Péter

