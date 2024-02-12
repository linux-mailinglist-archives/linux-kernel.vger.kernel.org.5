Return-Path: <linux-kernel+bounces-62070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDF0851B05
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F416285FF3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06FF3EA77;
	Mon, 12 Feb 2024 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JR2V/GPR"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DB018E11
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757928; cv=none; b=Zeodq48iJZ8wZXCePSeEdxgkWKn6+sTfUTf0KtznwgTeY9oWFy8n/Bt9syfPARbgQk5g55wiVaKRxNPa/sDEQH1NYcKXtbfFq7TzBENAnfMa2cPjc7bLEpGsRi2nfWbm3Zy+DOHQttNyERJhxLT1PT3Cx9AzI/slPwJLBQzcbyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757928; c=relaxed/simple;
	bh=AOKDYfTzOevd6oEG4hegYqP/lOdXkJf0Xk0718CKQUs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CVlAtsfqRq3Yh/wZNcF6h8bKNwP3KBz8kOMt93VIk3Uc0zeFcyycMpAfeDJEuupsZySt6+9KIFNoK7xa5tzeDaYNEFfmlvSkcl2xWXOgVrPx1IM1GvZUTL+lZKhGMptmHPUGHXOV5X3PH82QI6OBw/e+YXtU5UENMxqI2hh7T1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JR2V/GPR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40f02b8d176so28568105e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707757924; x=1708362724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIw0R7nsSvKK8fOD6O78NCUKigSi0poWhSyBj8iQ8hQ=;
        b=JR2V/GPRIC/YoDf2nrpPMngSYprpbe4G/ZMocRonp0rlfXHM5aIkv3NvKw3TGfilvK
         bGSYFBj3TmPg2jWkvhSKf0aqYesjtdEPapyKVjXSyvtOpa+Iy5uDJn7w5XrJ4hNXVeF9
         iqSbi61tzt9C3UdAVLC37nr05EbEdrE5/SY1gM51YqQ/zHl3iHgjTvkcL/ucaInprGYX
         1gYxjfdiz2JCI8giPCNlvB+HgD5sgPt4scGHWJ40vHj3vZUAwJLESfRqlOLe8SJ7Ra34
         0jqz9VBQ8TpM/E45FmkJEC2bYMkBjRd5f4aweZA2k8mEDAnOC1a+GbUe8+oeEbYoCHVo
         k6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757924; x=1708362724;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CIw0R7nsSvKK8fOD6O78NCUKigSi0poWhSyBj8iQ8hQ=;
        b=w8owSjYkYqza1nEoW7/SqQnCRPmRrptuJrpk0tgvfBE9iD1LGOJDId1Abep6OwwrEI
         YOKBagV9QvfgVmhuwWd7AJvyEIBZuoiY5O9FaVJV6UBeiEfvtMvnPwgmezG8A2Nl7c73
         lmmTxJfwN4McyPjCHpAupIlixnAjj1EijlRLjSwkNmXhu+6L9x7CPGR1f8SlNVi90YED
         q4jlrVggWF0/9s43dZ5EN2mYVKHlG0G4CG3fTHQzWyAebx4VQiIFMXNWjc680+oMU/uH
         zlyH2s71/Kc4kEFgns5yaK8NH2OJYJHxxYbAhkkryWBF+dMosY3AehBpyfrhPlNlddqi
         Pt2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxlLlKKc6Hfpc1zq99lComtGIASITXt4uJia3a1ZrV80T4+5/gh/t81M7b/16nI0HKfcPTA7Onx7gDiyGc2eQvmoMpbP1yUzYbLZti
X-Gm-Message-State: AOJu0YzVVXpyVELWYKDTTccPOqiTPfeJKFWVoVIv0Wo9s5cdAq0HzamX
	6rahBLGYs8lwsONjaSLsDTe4Eu1umLVThFLUK5CtsfkJk4nR4wbOz8wq4ENt/Ko=
X-Google-Smtp-Source: AGHT+IGG0gvC8xdOVFXyoqKOjK7KF6KAFOvp0BE030yTwmcKUhHcYQ3Qv0oP3y688dKM5aOms1BUvg==
X-Received: by 2002:a5d:4589:0:b0:33a:f798:bfa with SMTP id p9-20020a5d4589000000b0033af7980bfamr5537587wrq.64.1707757924302;
        Mon, 12 Feb 2024 09:12:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUx2T3llGMN6IWpDztHmG0RqS2HbgLZscF1BXAdMlQj3uB4OacuwdQh3FbxCqZ1uZw/tSFYTX9iTkJjYwvXv7oCxmEY3Tx5QgId05p2FtB9WduXI7P2S+G4kXhob4ZRqlNO6crw7MmUFl2y9GN55MjZqF193H7HryTRpc8P6KxDd3U3FxU3LFnbALdsNWrF9WErn7by9pAph7PxJqwb7RqylPiSWoIBoap+twrOwPZ03cgPYCPIYmMNlgdYEtjH7+BwTOO4UyQjFZOiYFmDYhg+lWUch7f5zcQq6iXRt9R8kY81hn9Z5d8+Fcg+9kTmf3RWxYHZC5OZHso6w98iopX5hHqJqZ+yO7u0agQqEzITo+W2ryKrrjnaKur0Z9hSUa2SXciub8aBD0W8eKjmCiuj9Ce2DnnrtFsB+vDKdzs9qCxHtcxzfhNNjxrzb8X89IqC62KkBWmHY+nNPSHEdFxxgmAaBggO6YvJVN9rXeABGYx/M8B77k8pKV7ibEnX2X1PKwNpSZa2DA69kMbWM7XH2FeTV3wlvGIlAMN42b/tLa3FbMz1WyiJIFUTggWU6x6YzGojrTlad1S+Z9ApE3hXBwKIMIl0ajKs
Received: from ?IPV6:2a01:e0a:982:cbb0:fcee:f026:296d:135f? ([2a01:e0a:982:cbb0:fcee:f026:296d:135f])
        by smtp.gmail.com with ESMTPSA id ck13-20020a5d5e8d000000b0033b684d6d5csm7440536wrb.20.2024.02.12.09.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 09:12:03 -0800 (PST)
Message-ID: <e4f025d1-267d-4c80-b211-bdadfc31d2b1@linaro.org>
Date: Mon, 12 Feb 2024 18:12:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 06/20] drivers: crypto: meson: drop status field from
 meson_flow
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
 <20240212135108.549755-7-avromanov@salutedevices.com>
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
In-Reply-To: <20240212135108.549755-7-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/02/2024 14:50, Alexey Romanov wrote:
> This field is used only to check for timeout. But there is more
> convenient way to achive the same goal.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/crypto/amlogic/amlogic-gxl-cipher.c | 13 +++++++++----
>   drivers/crypto/amlogic/amlogic-gxl-core.c   |  1 -
>   drivers/crypto/amlogic/amlogic-gxl.h        |  2 --
>   3 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> index 18e9e2d39b1f..dc0b100c5de2 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> @@ -219,13 +219,18 @@ static int meson_cipher(struct skcipher_request *areq)
>   	}
>   
>   	reinit_completion(&mc->chanlist[flow].complete);
> -	mc->chanlist[flow].status = 0;
>   	meson_dma_start(mc, flow);
> -	wait_for_completion_interruptible_timeout(&mc->chanlist[flow].complete,
> -						  msecs_to_jiffies(500));
> -	if (mc->chanlist[flow].status == 0) {
> +
> +	err = wait_for_completion_interruptible_timeout(&mc->chanlist[flow].complete,
> +							msecs_to_jiffies(500));
> +	if (err == 0) {
>   		dev_err(mc->dev, "DMA timeout for flow %d\n", flow);
>   		err = -EINVAL;
> +	} else if (err < 0) {
> +		dev_err(mc->dev, "Waiting for DMA completion is failed (%d)\n", err);
> +	} else {
> +		/* No error */
> +		err = 0;
>   	}
>   
>   	dma_unmap_single(mc->dev, phykeyiv, keyivlen, DMA_TO_DEVICE);
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
> index 51291fdcf8b6..f7c60ebffbc3 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-core.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
> @@ -54,7 +54,6 @@ static irqreturn_t meson_irq_handler(int irq, void *data)
>   	for (flow = 0; flow < mc->flow_cnt; flow++) {
>   		if (mc->chanlist[flow].irq == irq) {
>   			if (meson_dma_ready(mc, flow)) {
> -				mc->chanlist[flow].status = 1;
>   				complete(&mc->chanlist[flow].complete);
>   				return IRQ_HANDLED;
>   			}
> diff --git a/drivers/crypto/amlogic/amlogic-gxl.h b/drivers/crypto/amlogic/amlogic-gxl.h
> index 5f5e3115fcdf..e27908992ae3 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl.h
> +++ b/drivers/crypto/amlogic/amlogic-gxl.h
> @@ -59,7 +59,6 @@ struct meson_desc {
>    * @engine:	ptr to the crypto_engine for this flow
>    * @keylen:	keylen for this flow operation
>    * @complete:	completion for the current task on this flow
> - * @status:	set to 1 by interrupt if task is done
>    * @irq:	IRQ number for amlogic-crypto
>    * @t_phy:	Physical address of task
>    * @tl:		pointer to the current ce_task for this flow
> @@ -68,7 +67,6 @@ struct meson_desc {
>   struct meson_flow {
>   	struct crypto_engine *engine;
>   	struct completion complete;
> -	int status;
>   	int irq;
>   	unsigned int keylen;
>   	dma_addr_t t_phy;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

