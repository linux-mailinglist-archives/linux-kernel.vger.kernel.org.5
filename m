Return-Path: <linux-kernel+bounces-62069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06301851B01
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8501C22794
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CF13D39F;
	Mon, 12 Feb 2024 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LI9nh+eC"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAEA47F5C
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757909; cv=none; b=nzsiVm+g8ZTEjzjCzqvd4EwsK1tU4GDRT4Hn8TKQwCbMY/YmtI1kL9AjRPSZ3O6Ay/RIi12WLwoD7u9xUCw1OeFE5R/ie6srsHQlR24/2POgcWnXCX2X1bVwA4EkErYBAkDQqt59azjKAaqz2VZbU5BH+c7rEOuTcKFx7Uzf6NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757909; c=relaxed/simple;
	bh=uulIj6TfB/ZV4I5bkj6MyGgQMxfCzMPW7BLDpK0dpek=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SfAvLsuPJ+QwNIzxe0B+tm+r2gzAN7JBKP8Pu9uBJbfGhwMcoP+c+L3ijO1iuwmBpbn7JQCFNEhylFWXQM0v+N2Ks4JQ0zzq61xuiHl3/Iqr0DNS5NUyA82X9RsCdWWFegXDTkDhyqc6I9ye+YmsbfInrzcpp4oRfeN2n5qLHFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LI9nh+eC; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33b28aadb28so2206743f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707757906; x=1708362706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eVnKk/5FnfiICNJz+devKSEGOObsIesF/dGQJ+bTx3c=;
        b=LI9nh+eCpsycHVzZEvFGBTkg0gEYu4suyst9pnwHa8Lh3vb33bfpyCov5PgfXe5YGX
         UVEQNm+74tMdKKL7N/F+CQ4+5VkCpAjnA7CqhieLObd1NAB2XbANx9e1he2klR6YdXB9
         dBLixacdaEa24uejKU3chCNw7nA/TTnpRV/Mq7C0d4tlcEnlZGxb6T1e/g8yAOA5/di/
         Gb9UBbhUluKWahRZWnYCl/Ss/q/FhwUXf2LkDbZlqS9anOmjQ9JHSNQ0LNHyYUhWB0z9
         vmvTkIxSbeGFm2WipOBUtAztdISKfKKXCT8kVGIvAFSLuG9FfL47w+Fg2CG9Z/WNmS7i
         mRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757906; x=1708362706;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eVnKk/5FnfiICNJz+devKSEGOObsIesF/dGQJ+bTx3c=;
        b=GZVSIjc86ouLC1WpeDO+bHqZ/CzmL26qT9cIbcCn9Povh96MQKBFkwcJX8uZFL+i35
         BLkDbmEjnpGyU3KZuKjyWp0gsWn55zJXXogkMWQCzVObn1acF0xX0uFCH0uoiJeMsWvh
         gjcvvcJAHjtz16t0IKCCVuDWEvCnJ4cRndLTv5qfmq4lUGbXO+VPzW2OxIfasSaWBG+q
         x7Zq9/RgNgI+JMih6teg2D2V9/le2TpOGB6Y99xqtv1KKbYyGBamWi8gXCzM1wT/nQZ6
         QKWyUCbziuSvMA5tg5nv0CP2mtMCoQHvgRCgNvvaVXoONbSVosDlO44XdIq9ZzMdBYD/
         +D9w==
X-Gm-Message-State: AOJu0YyBRsTdwu7clLE5djdgPwNVLATT/6Jk14i558xAQjzXRFcqfmhd
	g1gvISQ4HKrsB6le0BVKwWbieF6MCNL5CIzw+As5i1ORFrKe6F6/h7p3rNPP5hM=
X-Google-Smtp-Source: AGHT+IFDyA3iUozb7O4U2GHtBdZnEM2GYv8Nn3cefwc2OPHBrLiZEfC59GkTOu5wa+sUrLRTx1u+SQ==
X-Received: by 2002:a05:6000:120a:b0:33b:6369:6485 with SMTP id e10-20020a056000120a00b0033b63696485mr4649346wrx.24.1707757906192;
        Mon, 12 Feb 2024 09:11:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWcj4BaboNfVdwv9LDtaSrk5oLkki+VTqOdnwarKJmJHX1HpzGqW0aLPCEIggG9gFU1C1SnlCQYPQloRYRJMJLicBFHps1J/ZI2ZYpEm/AVnK7qYVPWzXlbjO4FHjOAs/50IHWvYq1Vkz4nk0JzhMoUbRzJnGCaNT5OQQU3iJEmaN9+8tvPuYwqyTrwXJr1Pc18saQOFL3JMYBWasIUoTI7g9vSuoTBzNjy61dlYEdWmITF2nQ15NuYXH4lrKM7b/Vy7f/WPIZqngAjZm/Xd6Pw/k1Tifbr9U0b+9ka2n62HKz0AgpTyRwJVTHeeyFxCDJaLO82gbygzxTHWj+FQyTwqN1Y50FdqWqlXPONyZmA2cpAmJGhWe/zdCjtFXRU8gLGRWIScfgQ1xGUQnAFP+dtVTqQkHSNE9tWVq0ciCHry4xx3cG5LXQYSk/ZA2BPO7NCLROsuQW1/yuywyGqgmmIHu9Qi5XsBUgU0fcKcluDcGhCn3udY+/4anqCKTXztN1lsqR9vInWo1IXj6W3dFwOsaZzQXDgn7vN/pT78gKsD1K+XcKb+gHdyHotkaIZeMyGBLuC7dWlrhW1TmRj/349Z1AUiZ7twtDG
Received: from ?IPV6:2a01:e0a:982:cbb0:fcee:f026:296d:135f? ([2a01:e0a:982:cbb0:fcee:f026:296d:135f])
        by smtp.gmail.com with ESMTPSA id ck13-20020a5d5e8d000000b0033b684d6d5csm7440536wrb.20.2024.02.12.09.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 09:11:45 -0800 (PST)
Message-ID: <3c0b7daf-29f9-4569-9aa3-fe8f381de821@linaro.org>
Date: Mon, 12 Feb 2024 18:11:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 05/20] drivers: crypto: meson: move get_engine_number()
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, clabbe@baylibre.com,
 herbert@gondor.apana.org.au, davem@davemloft.net, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, vadim.fedorenko@linux.dev
Cc: linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@salutedevices.com
References: <20240212135108.549755-1-avromanov@salutedevices.com>
 <20240212135108.549755-6-avromanov@salutedevices.com>
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
Organization: Linaro Developer Services
In-Reply-To: <20240212135108.549755-6-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/02/2024 14:50, Alexey Romanov wrote:
> Move get_engine_number() function from cipher.c to core.c
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/crypto/amlogic/amlogic-gxl-cipher.c | 9 ++-------
>   drivers/crypto/amlogic/amlogic-gxl-core.c   | 5 +++++
>   drivers/crypto/amlogic/amlogic-gxl.h        | 2 ++
>   3 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> index 1fe916b0a138..18e9e2d39b1f 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> @@ -17,11 +17,6 @@
>   #include <crypto/internal/skcipher.h>
>   #include "amlogic-gxl.h"
>   
> -static int get_engine_number(struct meson_dev *mc)
> -{
> -	return atomic_inc_return(&mc->flow) % mc->flow_cnt;
> -}
> -
>   static bool meson_cipher_need_fallback(struct skcipher_request *areq)
>   {
>   	struct scatterlist *src_sg = areq->src;
> @@ -282,7 +277,7 @@ int meson_skdecrypt(struct skcipher_request *areq)
>   	rctx->op_dir = MESON_DECRYPT;
>   	if (meson_cipher_need_fallback(areq))
>   		return meson_cipher_do_fallback(areq);
> -	e = get_engine_number(op->mc);
> +	e = meson_get_engine_number(op->mc);
>   	engine = op->mc->chanlist[e].engine;
>   	rctx->flow = e;
>   
> @@ -300,7 +295,7 @@ int meson_skencrypt(struct skcipher_request *areq)
>   	rctx->op_dir = MESON_ENCRYPT;
>   	if (meson_cipher_need_fallback(areq))
>   		return meson_cipher_do_fallback(areq);
> -	e = get_engine_number(op->mc);
> +	e = meson_get_engine_number(op->mc);
>   	engine = op->mc->chanlist[e].engine;
>   	rctx->flow = e;
>   
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
> index 372c30f72072..51291fdcf8b6 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-core.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
> @@ -23,6 +23,11 @@
>   
>   #include "amlogic-gxl.h"
>   
> +int meson_get_engine_number(struct meson_dev *mc)
> +{
> +	return atomic_inc_return(&mc->flow) % mc->flow_cnt;
> +}
> +
>   void meson_dma_start(struct meson_dev *mc, int flow)
>   {
>   	u32 offset = (mc->pdata->descs_reg + flow) << 2;
> diff --git a/drivers/crypto/amlogic/amlogic-gxl.h b/drivers/crypto/amlogic/amlogic-gxl.h
> index 59fc6a67e0a9..5f5e3115fcdf 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl.h
> +++ b/drivers/crypto/amlogic/amlogic-gxl.h
> @@ -163,6 +163,8 @@ struct meson_alg_template {
>   #endif
>   };
>   
> +int meson_get_engine_number(struct meson_dev *mc);
> +
>   void meson_dma_start(struct meson_dev *mc, int flow);
>   
>   int meson_enqueue(struct crypto_async_request *areq, u32 type);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

