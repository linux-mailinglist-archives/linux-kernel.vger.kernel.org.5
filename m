Return-Path: <linux-kernel+bounces-30861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EB6832537
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA851C224F9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EDDD52B;
	Fri, 19 Jan 2024 07:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1XXYsT8"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5885DDC5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 07:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650350; cv=none; b=UH+wrF4juPYWEMWkd/puUMyWSpLXVv6ah9ygEydpUkvObTgEnqSJWExc21IdoGQMPqsUPYuQ2S3CuO44tAgvOQCIY3PhpXvQ/T3TzzbLWCHWBx+c6Vooi2S9RE6A7Q79ZoJMg2NL2vY+KVydexQ/blcKnp/3FSBbI4Gs9Qbq41o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650350; c=relaxed/simple;
	bh=Q4LIJG2y70z4o4cUYu3Cup/EpTdk2M6eRV1q2WORKVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uyDOUsdDDYgxKOb2XSRqi5i6h4V1hvQ89eLltAlA47uGYv7dgN3U2hOoh86HuUs7+PNWC3v0GUK/ksJOydFcNk09OobNgwkFSqXQwvFvqxth39tzrrZEkn7QUA66s3pQvlxzoW4OmvKZsGGgNKBLFvnv5cYXlZ3mMvc7Oj5BaP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L1XXYsT8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e9ef9853bso887725e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 23:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705650347; x=1706255147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=axlxMn3mKxrZ+z0NjINZroTLytSc1sa1mWx0FPrBc1I=;
        b=L1XXYsT8dYS1hVglZuzYBiRt8v747GwbqwRhuaFYVzMelUvha9CtC+vDeTp4n7jE4e
         qUbfy9N5XcRmfx6KwC71y6/1Xt1wqVFVjye32tCddB/8c+QDMlsToQf4LwXNFeiIxRqc
         zMWxMywgpESrmFNb78GkNqCWLB4bFz6wDur+Xw7EbILe9neMPYeDPFsYSBr45s4d8m92
         XvI0gdD0x3RFuoyMYRTM/LJ1QgMaf1SZyEdWdh3ZNKav2+yj/J9qdf89SNs4LPpS9JwV
         kZWSRBBf4ZVSBGk/QakX5rsogiKLc7GJ1C/Wu0hqFQmhEXwqkQYOUrO/wORIuaD9vDv2
         1PHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705650347; x=1706255147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axlxMn3mKxrZ+z0NjINZroTLytSc1sa1mWx0FPrBc1I=;
        b=cJo9HS4wiIvFVQkDUXGi85cAH2BKYBWirDdVAiM4fxk9BAq58BdcjJpPASbB7F3m/d
         NvqC1SdFRLUW8dRieeIXkrjCtwEfhEpNenIjLMCMPAQ0Jsz08zjMVDr8GDElnizT7/mW
         AvGiLT+pc3LHCKUX/CBvKmPS5kphct+4EV5hdykUd+eroP23aR7LWKBwcTVb0Wk4ga5H
         1u/PHNykaW2k7x4xUnwilvqLJ8kTyG8dRE5Nal/Nlahdy9QIP5v/A4hNyn+5eg8UYSM4
         1SjdBBQS6NpyZfgW2jqG97KtA3Pphfk+RIbxeNL1js7SyxeTitYfLFKikV8HKYunPiOW
         am5A==
X-Gm-Message-State: AOJu0YxmEy+m27AJmg1K6abGgl+DozXtaGcl08dQGJITxbtCaaG9Ut1Q
	8Olj+ifaQ/rk0bL1mAEOpmE0zUzfn9VFeHYRYvan+MU3duD5TVS67W0f5maYiRs=
X-Google-Smtp-Source: AGHT+IFDofa/AFb3zEbQS9BWqodcUqjTtN/sp/WtGUkdrc4wTm5faoFC+sDHVcwObz4Ml2d7rzEcEA==
X-Received: by 2002:a05:600c:4248:b0:40e:4380:c8e5 with SMTP id r8-20020a05600c424800b0040e4380c8e5mr261612wmm.49.1705650346897;
        Thu, 18 Jan 2024 23:45:46 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id i6-20020adfb646000000b00337bc2176f6sm5800237wre.81.2024.01.18.23.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 23:45:46 -0800 (PST)
Message-ID: <6d8f77e2-7257-4a6c-96de-fd3f1c821b51@linaro.org>
Date: Fri, 19 Jan 2024 07:45:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] ASoC: codecs: lpass-wsa-macro: fix compander
 volume hack
Content-Language: en-US
To: Johan Hovold <johan+linaro@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Banajit Goswami <bgoswami@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240118165811.13672-1-johan+linaro@kernel.org>
 <20240118165811.13672-5-johan+linaro@kernel.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240118165811.13672-5-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/01/2024 16:58, Johan Hovold wrote:
> The LPASS WSA macro codec driver is updating the digital gain settings
> behind the back of user space on DAPM events if companding has been
> enabled.
> 
> As compander control is exported to user space, this can result in the
> digital gain setting being incremented (or decremented) every time the
> sound server is started and the codec suspended depending on what the
> UCM configuration looks like.
> 
> Soon enough playback will become distorted (or too quiet).
> 
> This is specifically a problem on the Lenovo ThinkPad X13s as this
> bypasses the limit for the digital gain setting that has been set by the
> machine driver.
> 
> Fix this by simply dropping the compander gain offset hack. If someone
> cares about modelling the impact of the compander setting this can
> possibly be done by exporting it as a volume control later.
> 
> Note that the volume registers still need to be written after enabling
> clocks in order for any prior updates to take effect.
> 
> Fixes: 2c4066e5d428 ("ASoC: codecs: lpass-wsa-macro: add dapm widgets and route")
> Cc: stable@vger.kernel.org      # 5.11
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   sound/soc/codecs/lpass-wsa-macro.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
> index 7e21cec3c2fb..6ce309980cd1 100644
> --- a/sound/soc/codecs/lpass-wsa-macro.c
> +++ b/sound/soc/codecs/lpass-wsa-macro.c
> @@ -1584,7 +1584,6 @@ static int wsa_macro_enable_interpolator(struct snd_soc_dapm_widget *w,
>   	u16 gain_reg;
>   	u16 reg;
>   	int val;
> -	int offset_val = 0;

TBH, as discussed in my previous review we should just remove 
spkr_gain_offset and associated code path.


--srini

>   	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
>   
>   	if (w->shift == WSA_MACRO_COMP1) {
> @@ -1623,10 +1622,8 @@ static int wsa_macro_enable_interpolator(struct snd_soc_dapm_widget *w,
>   					CDC_WSA_RX1_RX_PATH_MIX_SEC0,
>   					CDC_WSA_RX_PGA_HALF_DB_MASK,
>   					CDC_WSA_RX_PGA_HALF_DB_ENABLE);
> -			offset_val = -2;
>   		}
>   		val = snd_soc_component_read(component, gain_reg);
> -		val += offset_val;
>   		snd_soc_component_write(component, gain_reg, val);
>   		wsa_macro_config_ear_spkr_gain(component, wsa,
>   						event, gain_reg);
> @@ -1654,10 +1651,6 @@ static int wsa_macro_enable_interpolator(struct snd_soc_dapm_widget *w,
>   					CDC_WSA_RX1_RX_PATH_MIX_SEC0,
>   					CDC_WSA_RX_PGA_HALF_DB_MASK,
>   					CDC_WSA_RX_PGA_HALF_DB_DISABLE);
> -			offset_val = 2;
> -			val = snd_soc_component_read(component, gain_reg);
> -			val += offset_val;
> -			snd_soc_component_write(component, gain_reg, val);
>   		}
>   		wsa_macro_config_ear_spkr_gain(component, wsa,
>   						event, gain_reg);

