Return-Path: <linux-kernel+bounces-62067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 592D2851AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E33E1C2234F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68AC4654B;
	Mon, 12 Feb 2024 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YiMAb9cB"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B12F46551
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757885; cv=none; b=BITzpIEetBDlA4IJ5K8Etnz5ifaHG2qV8aksT4lFcoOfwpFNuoXtof7+hmyakzUF4QsfUxI0c6Wo3hvfrNMZMs7Vhdg5u1F+cJE/zEt+cdSNjsBC4EBkJGwAYdprk1WgfRJZKnFdrBT8SjxoXFSc1JESM1moQ0iNrnCmKJaHAzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757885; c=relaxed/simple;
	bh=45yRGF4FB4tNV5Am4KTFPJYvWefFkp+bk+Ru65wYll8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rNvIxZXhbKc639l3T9yNnJgpy5FI5h0GlVlvqDOUQsiNta1/VF4DZwUo4Y3Z4wnFol8wwzB0S0oANG4XJ8XAFoF6BqgDnlQZ8VQj9DpkU0cupxYuFQbO41kjKhs+1mt1VFXabEC/Z05LRXUw7cW73UfsUnj6aIH4vyJy46d+YPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YiMAb9cB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41097f9a9a4so15427345e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707757882; x=1708362682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z88dR7PUkTcRGj5lNakDVXVkWGFXVN89MP6hxtmCpLI=;
        b=YiMAb9cBc7b0t6okVwgW/miYKO65BIBt4W0U2yC1bj7xosVHp/g5ZmW9+R/iJ+Bu1/
         n2ddlNnAZHzShJjAaVDN0wR0jC73xXhddNhIs87rWo3Rd4hoBK7bubbsqesxJxS0vv6K
         jWwUoAcPmMagz2/WMNPNHX1YLs5UFe59QlK4pdMjhHVbCXM+N96sgvfV4exgSta8ky9K
         mwsKgcwgznGYYr80nyplmrIzCGwT6dxMWc6dTjDl4siuT9NTDY0s+xnhdVId3xqr91mQ
         w177wU/5lgAQBC88QiJoLEgU86vp34Tv1Zpk9lx4Wjyu0XthV81xwmhyS00LN/ke0BmM
         h7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757882; x=1708362682;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z88dR7PUkTcRGj5lNakDVXVkWGFXVN89MP6hxtmCpLI=;
        b=Q3os1PMYTCO1YPZtYFQeKt9sf1L4bv2NTEbrnYK5HY2K3jXN80FRIa4DzQxWdOgnJV
         +4HEJY1TolQLVwO0KGsLnMO0lBLDzFXRHQLa8sTD+4AUGM0LhHBh9hAvYDoRag2djwYQ
         K1r4fQ+UOesoQfdU0euP2k126hJV9KSyHJEScACCLVoARSSG1vU/hJoI6AOWCtPzxOoA
         B21JELkKjqd+XEI5mk6BErDMZD24pmjIJ7gOLTc7+q/hCAq16T+bv+Vb9LcTtt2OsQKX
         zev1Mc0IoDrXhQ2oxMo8ZMmrNc1PDp33v+1oI4vy9TPBlYG8Gb4kejDvXxUlguJMGaRr
         GOyA==
X-Forwarded-Encrypted: i=1; AJvYcCWwxnhkrcnqUgxGap1CTrsMKAs4X85vEuEmpPlvVq0ncXQKXadnaGCYFwwRxWTkn0A0L52Uh0KbO4hfz8WAxrwQ3uP/8TpsKZi6w1XB
X-Gm-Message-State: AOJu0YxePvheVV5SbZenFFzgdsxc8iBTPfn/aHD6tLgOQiwD8A34RSOL
	U8wf49V7UM6Yb63IWDECAmTive5uNdongqLR2A0VDJCBFrWq7gaelG+kgheJRdQ=
X-Google-Smtp-Source: AGHT+IGBNdxn1mzGqbZ273VsCbHhIKxKw+Ok3uY/Ud8yKtGlif2B8ukwVxDWaYYg5Y0mAqINm6+ORw==
X-Received: by 2002:a5d:490b:0:b0:33b:2fdd:daf8 with SMTP id x11-20020a5d490b000000b0033b2fdddaf8mr5110953wrq.21.1707757881869;
        Mon, 12 Feb 2024 09:11:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWeNEu1npYYlncp0jQv1FNO760HTnDLPJSlgdJ0xDQ+O/KSiOHvDOI8s9zWA64eeGlff5F7BMYt8iSkGsr+K9rs+rN+t9FGYcP0LyJC92jlwTegS1pwTEL5thLaa7DSz+vJW3fWkWZQldhcpgFMlyDOGesAsr4kdrJYUpM0ZFCwofWi0/ipDx8SaDRPLKO4J7gaFWo+mhtZg6RbJP74TjW5FYnn0YQiqTJDDpqH784wWQ8bCaV1vv31j2sDsQncyfP6pPyEmrudmzrwRP/caPcOxuim6djy4H0qAlR2paKyuOE1GsAPcjN5J3wV72vkycBt5XnOGhnVTyYGew5s5LVNeLQYhwy2XjMhrje59yN/EClZmau90cGXAt/+nUmawRK+EThaZv7C3Vhki3gdguOYFP2Di3GNctrQ+q743KoM95N7tPRY7XsGKwmQdF/aDY3V7UPCLMZXgmA5musziHNXSf38O15ZWzzkspJXsXku4H1imwJLg+mI8n2lCA1BJOCTXem9WfvCweNfc2XU2LCL/ssaysmxvmdnp6kA0i9lZA8Fa9X0IH0hEr4wecZTbxrOTUi63Gdv12yDbXIVq4Ad7cQkZ7/S92GQ
Received: from ?IPV6:2a01:e0a:982:cbb0:fcee:f026:296d:135f? ([2a01:e0a:982:cbb0:fcee:f026:296d:135f])
        by smtp.gmail.com with ESMTPSA id ck13-20020a5d5e8d000000b0033b684d6d5csm7440536wrb.20.2024.02.12.09.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 09:11:21 -0800 (PST)
Message-ID: <6cbbf8ff-8e8b-4b37-846c-a9d4084f3f2d@linaro.org>
Date: Mon, 12 Feb 2024 18:11:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 04/20] drivers: crypto: meson: add MMIO helpers
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
 <20240212135108.549755-5-avromanov@salutedevices.com>
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
In-Reply-To: <20240212135108.549755-5-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/02/2024 14:50, Alexey Romanov wrote:
> Add MMIO access helpers: meson_dma_start() and meson_dma_ready().
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/crypto/amlogic/amlogic-gxl-cipher.c |  2 +-
>   drivers/crypto/amlogic/amlogic-gxl-core.c   | 24 ++++++++++++++++-----
>   drivers/crypto/amlogic/amlogic-gxl.h        |  2 ++
>   3 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> index 7eff3ae7356f..1fe916b0a138 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> @@ -225,7 +225,7 @@ static int meson_cipher(struct skcipher_request *areq)
>   
>   	reinit_completion(&mc->chanlist[flow].complete);
>   	mc->chanlist[flow].status = 0;
> -	writel(mc->chanlist[flow].t_phy | 2, mc->base + ((mc->pdata->descs_reg + flow) << 2));
> +	meson_dma_start(mc, flow);
>   	wait_for_completion_interruptible_timeout(&mc->chanlist[flow].complete,
>   						  msecs_to_jiffies(500));
>   	if (mc->chanlist[flow].status == 0) {
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
> index 54113c524ec5..372c30f72072 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-core.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
> @@ -23,18 +23,32 @@
>   
>   #include "amlogic-gxl.h"
>   
> +void meson_dma_start(struct meson_dev *mc, int flow)
> +{
> +	u32 offset = (mc->pdata->descs_reg + flow) << 2;
> +
> +	writel(mc->chanlist[flow].t_phy | 2, mc->base + offset);
> +}
> +
> +static bool meson_dma_ready(struct meson_dev *mc, int flow)
> +{
> +	u32 offset = (mc->pdata->status_reg + flow) << 2;
> +	u32 data = readl(mc->base + offset);
> +
> +	if (data)
> +		writel_relaxed(0xF, mc->base + offset);
> +
> +	return data;
> +}
> +
>   static irqreturn_t meson_irq_handler(int irq, void *data)
>   {
>   	struct meson_dev *mc = (struct meson_dev *)data;
>   	int flow;
> -	u32 p;
>   
>   	for (flow = 0; flow < mc->flow_cnt; flow++) {
>   		if (mc->chanlist[flow].irq == irq) {
> -			p = readl(mc->base + ((mc->pdata->status_reg + flow) << 2));
> -			if (p) {
> -				writel_relaxed(0xF, mc->base +
> -					      ((mc->pdata->status_reg + flow) << 2));
> +			if (meson_dma_ready(mc, flow)) {
>   				mc->chanlist[flow].status = 1;
>   				complete(&mc->chanlist[flow].complete);
>   				return IRQ_HANDLED;
> diff --git a/drivers/crypto/amlogic/amlogic-gxl.h b/drivers/crypto/amlogic/amlogic-gxl.h
> index a36b9bac63a0..59fc6a67e0a9 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl.h
> +++ b/drivers/crypto/amlogic/amlogic-gxl.h
> @@ -163,6 +163,8 @@ struct meson_alg_template {
>   #endif
>   };
>   
> +void meson_dma_start(struct meson_dev *mc, int flow);
> +
>   int meson_enqueue(struct crypto_async_request *areq, u32 type);
>   
>   int meson_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

