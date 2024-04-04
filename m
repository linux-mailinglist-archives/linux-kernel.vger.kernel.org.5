Return-Path: <linux-kernel+bounces-131502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F868988C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96AC51F2AA93
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201D4127B4D;
	Thu,  4 Apr 2024 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DenBLcO7"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1FF823C3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237262; cv=none; b=EMMoncgTlp6mHNtC2Fat05br2J4q53SecM8rHzqTmv8fzfdCIGOx1oiaPXz+coWpvJbEUiRoC9edoVMl1z7xo3vuGQ1/ggK12JytxzcFORRH3WMtfSY/g+yhhi4UCWDAW8BMEXrlaADWtgYOTrvJyp83YjhNjuWufUp8TBSHoCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237262; c=relaxed/simple;
	bh=1xonfEH9qCKfyupF7LQD1iQBzCeNQ8w4vSbFJbQIZUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSQcwfZQwSAznf4G066ak3Jg92er8EGexF3Tc6qNODTTFTxDyYuxcoBTYDlfBkKW/AgoFWFd0DWK9Enz5zw+RNcE2vKLKjRrbT3/tqGt3VY5LzlXIj2NrrirJxUDw85rBUs/xuRLtLqnu2GoDNfx3O/xqHHDO7q4GeTuMkcW1jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DenBLcO7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4162ad8ddd0so3871395e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 06:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712237258; x=1712842058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+QvjOxBYyCIVt+TCovHzEXfrii3YX6ZKRNwZxO+VV38=;
        b=DenBLcO7GDv7NUNOCw8Ng16MGC4ToPbNyBdsTYWI5qFtBW2tRzIfORvdT4HC5FLl5f
         orb5m+akATik6rqAonnZrTuWngE1pnTVnLElY8wSoYs2t5WmiVdsfLBp1ajEbV44Ko01
         FkVuzsHVhdpk/mVnu8E6MEOfAJUp9p38fUq8ZeXYfSHEjfJUKnWkHdslmgt9I4Gf6ugR
         7eKX8HYPPc4lL+RKGncW2QkpKMaP4D+jYA/q5S+ZB9N3XGCme1fTOGSxNnw6g+LE6NCc
         KoOJr5e3Wqu978ABcVzs6I7qvmzbxPu1Oo/3YWJw3ikCH1+Aa8+gflNyWo6gM8AIyoeS
         9UJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712237258; x=1712842058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+QvjOxBYyCIVt+TCovHzEXfrii3YX6ZKRNwZxO+VV38=;
        b=T5H6dlqjvvq2DgOOEHyeZq3jp7fjv16Zh52uoZe0gXUSphINJIU8Op6VSxqmcRLlGb
         CHWdXgu8feR3xKG1TsxdLKw3Pym5Ai89v90ecuyknaSd8ytZtGXddovBaZ0/8LURI5U+
         htPMx2x5iO08DDY27v9fB44vZKpkO5pyxqePt72wyt22VqZnqgODITOx4TJ8wR+LQHdX
         x3FYB5zHLwLWiLeY9FjbUmIUlCk6LVGteKsHQdBX/zcT7PX1c1qOvVVlBEpY+gqgfhKY
         XZ+kB5bhWa2ycIIw4Fxb72/avbbn5zzyFQQPV3SAdeCz3GwdUvXr+1R/MTnU7cBCyvwl
         k6Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWh2BwtFWYPNAo3Ea3ZnLttU91XbOqfi6vxCHWciRGNIMNsQKBa+PwM6lA0X5oFo1kFOEf3W9K7M/NbFBC54eKqLC7WV8YFGkl4Zt1f
X-Gm-Message-State: AOJu0YzCL5Fw5u3gcKpQPeeO5+WLl7j4f/iYOqKilkEUF5ljvxQqu2l4
	yyNylNmXZhU3XkFyqicPGhL9O0n059hk6SNqoo0VehXOQjVdF3UdrJTZhB60k7M=
X-Google-Smtp-Source: AGHT+IFGhwTBUj9bJaKIL2ZegGzqwM5xHorQyIh5Xx3b5iDFxJb1wkOAhh4R6RzX/lCW1Yy9ACA48w==
X-Received: by 2002:a05:600c:5698:b0:414:86a3:8e8d with SMTP id jt24-20020a05600c569800b0041486a38e8dmr2031963wmb.22.1712237258155;
        Thu, 04 Apr 2024 06:27:38 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id r19-20020a05600c459300b0041408e16e6bsm2727579wmo.25.2024.04.04.06.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 06:27:37 -0700 (PDT)
Message-ID: <45f12590-4f79-4875-a497-cbb1ac3deb38@linaro.org>
Date: Thu, 4 Apr 2024 15:27:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86: ideapad-laptop: switch platform profiles
 using thermal management key
Content-Language: en-US
To: Gergo Koteles <soyer@irl.hu>, Ike Panhc <ike.pan@canonical.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7c358ad8dd6de7889fa887954145a181501ac362.1712236099.git.soyer@irl.hu>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <7c358ad8dd6de7889fa887954145a181501ac362.1712236099.git.soyer@irl.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/04/2024 15:10, Gergo Koteles wrote:
> Ideapad laptops have thermal management or performance mode switch key
> (Fn + Q). They report KEY_PROG4.
> 
> If supported, cycle platform profiles instead.
> 
> Tested on Yoga7 14ARB7.
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> ---
> Changes in v3:
>   - add dytc_profile_cycle function
> Changes in v2:
>   - only switch platform profiles if supported, otherwise keep the
>     behavior.
> 
> [2]: https://lore.kernel.org/all/797884d8cab030d3a2b656dba67f3c423cc58be7.1712174794.git.soyer@irl.hu/
> [1]: https://lore.kernel.org/all/85254ce8e87570c05e7f04d6507701bef954ed75.1712149429.git.soyer@irl.hu/
> ---
>   drivers/platform/x86/ideapad-laptop.c | 31 +++++++++++++++++++++++++--
>   1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 901849810ce2..c7ea3ed14aba 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -858,6 +858,30 @@ static void dytc_profile_refresh(struct ideapad_private *priv)
>   	}
>   }
>   
> +static void dytc_profile_cycle(struct ideapad_private *priv)
> +{
> +	switch (priv->dytc->current_profile) {
> +	case PLATFORM_PROFILE_LOW_POWER:
> +		dytc_profile_set(&priv->dytc->pprof,
> +				 PLATFORM_PROFILE_BALANCED);
> +		break;
> +	case PLATFORM_PROFILE_BALANCED:
> +		dytc_profile_set(&priv->dytc->pprof,
> +				 PLATFORM_PROFILE_PERFORMANCE);
> +		break;
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		dytc_profile_set(&priv->dytc->pprof,
> +				 PLATFORM_PROFILE_LOW_POWER);
> +		break;
> +	default:
> +		dev_warn(&priv->platform_device->dev,
> +			 "Unexpected platform profile %d",
> +			 priv->dytc->current_profile);
> +	}
> +	/* Notify user space the profile changed */
> +	platform_profile_notify();
> +}

Cycling is done through modulo.

Quick and dirty example:

static int profiles[] = {
	PLATFORM_PROFILE_LOW_POWER,
	PLATFORM_PROFILE_BALANCED,
	PLATFORM_PROFILE_PERFORMANCE
};

static int current_profile_index = 0;

static void dytc_profile_cycle(struct ideapad_private *priv)
{
	current_profile_index++

	current_profile_index =
		current_profile_index % ARRAY_SIZE(profiles);

	dytc_profile_set(&priv->dytc->pprof,
			profiles[current_profile_index]);

	platform_profile_notify();
}


>   static const struct dmi_system_id ideapad_dytc_v4_allow_table[] = {
>   	{
>   		/* Ideapad 5 Pro 16ACH6 */
> @@ -1181,8 +1205,11 @@ static void ideapad_check_special_buttons(struct ideapad_private *priv)
>   		switch (bit) {
>   		case 6:	/* Z570 */
>   		case 0:	/* Z580 */
> -			/* Thermal Management button */
> -			ideapad_input_report(priv, 65);
> +			/* Thermal Management / Performance Mode button */
> +			if (priv->dytc)
> +				dytc_profile_cycle(priv);
> +			else
> +				ideapad_input_report(priv, 65);
>   			break;
>   		case 1:
>   			/* OneKey Theater button */
> 
> base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


