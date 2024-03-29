Return-Path: <linux-kernel+bounces-124328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1308915B6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA1B1F22D0D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D437B3FB86;
	Fri, 29 Mar 2024 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mAI+6F8z"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2303E2B9B0
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704335; cv=none; b=sG2K4iQeTj4m9203HmS0SV6WnnBxCm2JD6zZMp7VaDvzfoVQ7GbWzfNnwp5ukMrLyYL0KOtxaL/iHIcQUIZfuXPI09IKoyh6HZYALcZQhQXffdmgrbteqdZGH2+ji3ye4psh/RPk8D1X+k0Ob4mm7lrpDjyCTVwID6d5FAkTH9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704335; c=relaxed/simple;
	bh=dZMd+hjwWBu0w3Nr26MjlG54+9irZNQQ5J2LGMlr7cM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=muw1s0qvjKNzHZYKmrE7tKRYPWNSXf/PAD8gXESIcHBuXAEMpYLoAkHIu7Hq6FcnG5f8gs1jEshQ8YVDSsIVu2ms245X5X1tayRkEmr8UcE1U3jHoNrqyHmiM8mlcCBJvn79Fz98aujf6R0LdMbd8I9g4/L6HFAb5wzE9khAP4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mAI+6F8z; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-341cf28e055so1292549f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711704331; x=1712309131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEQURDN2hc0rSK6rdl4NmLGBAAhTVwyKdlzTTBj2f1Y=;
        b=mAI+6F8zjKJ9QZ6icpJr1kulzBogw8afqLcl1BnCfe86M4vnnmlPsgV7eB/idRXS3u
         1r1c1hSEmiWQ9kgwae4WEzj+AhumoJVQgWwcb7PSEJvwUp7+wH7OJIsALroAnpx4dxf4
         iRBq7pFx9UKCrzCV1V8czS4UGLU4uKrnFiyk9JYWmVMYsxEv5cL+zF9r4LOfBDbfoCNc
         2mPHKCTSstamp1Eh5pJWxOkWqXXMuMriUXj/PMyehYgHY2V4VcIPwyS0ubLB9LST8yha
         zoYkiAnIc9upxv7O12pu4jUT1wCCwKzD58fyLfdvoHcr7AGcGJKkc4DJWu2cYv2rfk2u
         GY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704331; x=1712309131;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GEQURDN2hc0rSK6rdl4NmLGBAAhTVwyKdlzTTBj2f1Y=;
        b=RDr/7Xvbsey7HCWkQLX8q/4T6xv0oDfhh5LTIpUeiSVo753nZttAzKwgjPOrZc3Jkt
         xfr0SAWFSAGJm22F1s7r4WBDCJ+/u6oVbB/7h1TJIdJvuvE2hY677SnFnWi8uXbc9b3X
         lGKTF1gI3fekVV9rkUEynkFKv9syHs1/2jLGKX5n63VV7JnOrF7228Z3sk2VO0td9ADj
         eVaUGfGH4WjXPXDYwuIuKbTy3Nexz6xnXu1QEDYX8jVLfKH3b+NztegBrhrpLAKxgpPX
         MY/h9dNQIuC/7+QGG5n7/gijuiQPZ0S+5lqMkBRPTCUhm+yybnSupL3QsfLGpW1sE2L9
         6iyw==
X-Forwarded-Encrypted: i=1; AJvYcCWvb/TnNSLVLdkIYMrUpnCA5zQ6qncPLmq8rMlMvqgjuJ0l4OggAwvgZjNfeAK7QUrcXUxh3eNE3kT/LEUFcQFm+pUT8lnI7/m8t+P6
X-Gm-Message-State: AOJu0YxBeW5c+EtQEm9d0mT3xsnNKuAyNDcZpp6iFDx/rjB3e2I4WEVz
	W1YVAVce+m8pSSay/PFoq0M2CBvl19VcylEWLrZkGT3w4hxaW2tFYhuxkvRVSwI=
X-Google-Smtp-Source: AGHT+IHMYXV+HQAfMGTkNrpH0Nc8z57jRzmZssTg62uPFuuEAS0jJ9N+Vu7WdhPYRHT4wOscd1BfoA==
X-Received: by 2002:adf:ea0a:0:b0:343:2e06:9a10 with SMTP id q10-20020adfea0a000000b003432e069a10mr1254676wrm.15.1711704331306;
        Fri, 29 Mar 2024 02:25:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:3cd8:c97b:1468:c232? ([2a01:e0a:982:cbb0:3cd8:c97b:1468:c232])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d67c3000000b00341ddb65b07sm3742703wrw.63.2024.03.29.02.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 02:25:30 -0700 (PDT)
Message-ID: <15e3114d-0446-4668-83a9-1d28d50f4eb9@linaro.org>
Date: Fri, 29 Mar 2024 10:25:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/3] reset: reset-meson: add support for Amlogic T7 SoC
 Reset Controller
To: kelvin.zhang@amlogic.com, Philipp Zabel <p.zabel@pengutronix.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 Zelong Dong <zelong.dong@amlogic.com>
References: <20240329-t7-reset-v1-0-4c6e2e68359e@amlogic.com>
 <20240329-t7-reset-v1-2-4c6e2e68359e@amlogic.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20240329-t7-reset-v1-2-4c6e2e68359e@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/03/2024 10:17, Kelvin Zhang via B4 Relay wrote:
> From: Zelong Dong <zelong.dong@amlogic.com>
> 
> There are 7 sets of Reset Source in Amlogic T7 SoC Reset Controller,
> and the offset between base and level registers is 0x40.
> Add a new compatible string and struct meson_reset_param to support
> the reset controller on T7 SoC.
> 
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
> ---
>   drivers/reset/reset-meson.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index f78be97898bc..1e9fca3e30e8 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -102,6 +102,11 @@ static const struct meson_reset_param meson_s4_param = {
>   	.level_offset	= 0x40,
>   };
>   
> +static const struct meson_reset_param t7_param = {
> +	.reg_count      = 7,
> +	.level_offset   = 0x40,
> +};
> +
>   static const struct of_device_id meson_reset_dt_ids[] = {
>   	 { .compatible = "amlogic,meson8b-reset",    .data = &meson8b_param},
>   	 { .compatible = "amlogic,meson-gxbb-reset", .data = &meson8b_param},
> @@ -109,6 +114,7 @@ static const struct of_device_id meson_reset_dt_ids[] = {
>   	 { .compatible = "amlogic,meson-a1-reset",   .data = &meson_a1_param},
>   	 { .compatible = "amlogic,meson-s4-reset",   .data = &meson_s4_param},
>   	 { .compatible = "amlogic,c3-reset",   .data = &meson_s4_param},
> +	 { .compatible = "amlogic,t7-reset",   .data = &t7_param},
>   	 { /* sentinel */ },
>   };
>   MODULE_DEVICE_TABLE(of, meson_reset_dt_ids);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

