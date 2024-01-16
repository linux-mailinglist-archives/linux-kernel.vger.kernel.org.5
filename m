Return-Path: <linux-kernel+bounces-27382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DAD82EF11
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C772D1C233BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4B71BC2C;
	Tue, 16 Jan 2024 12:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mxo/VPcv"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F336719470
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3376ead25e1so7694110f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 04:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705408389; x=1706013189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OhwDIlaEEN6IPWd1oZ/unSnl3T485q1gaJvRsEwi2vU=;
        b=mxo/VPcv9Ze9RQggQ9I99Ox+u2jh/Jye1O9yGDmvkEWHU9UNuo4QH5EKwX89DKmxLW
         ZFDuwEGTz1iJiCx3ODv6oeaD4G7unkZkG86hrdHNOCm6FJ/jtJn8qHO2kshWjNcQxueI
         9QMOuLOKqjptvFSpN1YgHLd54PYmW09W85OVs72ta7pV2SPkExBUKA6UsQ+Q7o9k1d+K
         hdwB420AuiYlwNpjcgswD9jNX6zFYWX/M+xL60Whx4gNuPNYulWsjHo/kRJN89PTyYEL
         CrPX3pbuIB6gPWQZ5sbveL3KBqC6XEgV+8JmhrJzykDTM1LpvSfVwhNpGGwZIhDEsmQp
         DTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705408389; x=1706013189;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OhwDIlaEEN6IPWd1oZ/unSnl3T485q1gaJvRsEwi2vU=;
        b=SLq2SZSHAKrXe/supL3QsQBxJ0PikfZZhEJ3TvrMB3nNr1ITMsmjl+yVzN/EiWeXw/
         KFNcUvTCwYSd4KB+bxy9iYlzkuMpUCzD0doucLKqxfx/XwfR4dNSzpcZrxQO0SL+bNyX
         I8aV6FWQhz82rx4GwkCm2dAd92lhG28HzBvzPL0jHb3mJB6q3xQ5RqvOwMkCsdyfKFWZ
         FtZ+/Jb9ZMeibfdwAB9/IGfBLPRnhfyUWG9fV1k/IjgZ8+dhUKTTOfJ7F1x6fRSjsOwa
         gkqaN3c49w0JlAFAQlS5JEpgX6Z0xKp6t1y++U9DP4m0aSiIz69rNFenVex9F/k5LkAr
         jpjw==
X-Gm-Message-State: AOJu0Yxf3olit0jE2XGTatU2djVnjkxrWDab/UOySUmZTfNpdTac4IOh
	P0Io1CxL04Xikt692yW84oUE30OEIU5WAA==
X-Google-Smtp-Source: AGHT+IFgwZ7izOeDPTthu6pYyW2p4PI/uPvVFhtOSZUOvCWzjb3MxbacVOYISzw2xSeZlOWjyex6jA==
X-Received: by 2002:a05:600c:45d0:b0:40e:6ee8:c13e with SMTP id s16-20020a05600c45d000b0040e6ee8c13emr2391947wmo.197.1705408388946;
        Tue, 16 Jan 2024 04:33:08 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id p12-20020a05600c430c00b0040e596320bfsm6855662wme.0.2024.01.16.04.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 04:33:08 -0800 (PST)
Message-ID: <dda000cb-9d3d-40d8-9a6c-170d491f48f1@linaro.org>
Date: Tue, 16 Jan 2024 12:33:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] ASoC: codecs: msm8916-wcd-digital: drop dead gain
 hacks
Content-Language: en-US
To: Johan Hovold <johan+linaro@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Banajit Goswami <bgoswami@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240116093903.19403-1-johan+linaro@kernel.org>
 <20240116093903.19403-8-johan+linaro@kernel.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240116093903.19403-8-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johan,

did you see any issue with this codec?

These are not really hacks, to make the gains effective it has to be 
applied in a particular order.


On 16/01/2024 09:39, Johan Hovold wrote:
> -		/* apply the digital gain after the interpolator is enabled */

As you noticed in the comments, the gains have to be reprogrammed after 
interpolator and its clks are enabled.


> -		usleep_range(10000, 10100);
> -		snd_soc_component_write(component, rx_gain_reg[w->shift],
> -			      snd_soc_component_read(component, rx_gain_reg[w->shift]));
> -		break;
>   	case SND_SOC_DAPM_POST_PMD:
>   		snd_soc_component_update_bits(component, LPASS_CDC_CLK_RX_RESET_CTL,
>   					      1 << w->shift, 1 << w->shift);
> @@ -630,9 +613,6 @@ static int msm8916_wcd_digital_enable_dec(struct snd_soc_dapm_widget *w,
>   		snd_soc_component_update_bits(component, tx_mux_ctl_reg,
>   				    TX_MUX_CTL_HPF_BP_SEL_MASK,
>   				    TX_MUX_CTL_HPF_BP_SEL_NO_BYPASS);
> -		/* apply the digital gain after the decimator is enabled */
same here.

> -		snd_soc_component_write(component, tx_gain_reg[w->shift],
> -			      snd_soc_component_read(component, tx_gain_reg[w->shift]));

