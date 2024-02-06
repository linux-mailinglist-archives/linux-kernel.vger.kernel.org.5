Return-Path: <linux-kernel+bounces-55002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A009584B621
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56ECF2833D2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C6E130AE9;
	Tue,  6 Feb 2024 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oixt2Inw"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47070130E54
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225238; cv=none; b=sLUH9Uw1wIQo29r48+pCjy/zDqj4j/qoAE+FAQVwz2StyQEnmmouSgY5rG+W3e/lNhQBshtvBGILgS5XuJ6c6atqpidoTTD3GSHGAudA/ELEk9HAM+zMU1ILJoX3oclzzGL+YzgntV/Y7u5JTgEeLwizrx2sblyrB47mpK/TvbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225238; c=relaxed/simple;
	bh=0wG/xpO6lDLpTF91Vap4Bazg+QsPIH33E0MkBvi4mos=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KvrnY6uYS0TPrB9qV9/iCriMAB9/oioMYhNzunoSRaUjISLlhxLTisWxGAN9n7NlMsumGHsBVtCYOZLrkyfrlBStuDxRj8CxW5PEYLA/5O6J76nYlGYBySrH7ONgtG2VMDUqNOOA5YmjLKtMUMvRDRBoCDISGCELUtebVomQPlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Oixt2Inw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fc6343bd2so37447685e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 05:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707225234; x=1707830034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9B16m+06LbX6wDbCkZpe/xuqNeZkgF803HLiKs3kjO0=;
        b=Oixt2Inw5Kji6Wdyody8FDW7oXzF2pMuw10UnjxsSD6tEKew8mMq5DUTu3EwQHmMe+
         EFZijvNCCeO/1Fx949Ud37qsE4+1pW16sKdlOzo81CRpAeprBPTYOblUctF+nUUZR7Vd
         UauwUxdjiy6Y19zXxl5SQDNdknhQs2vCO0eVnM3VFKa+OkRv8avpPGGacmDS+B/n+02H
         TGOKf0zLptOD4tK0I0pCTOz5bk42FDn2BxJ68wWlT1qRLvWrEgsXdr/sLkW/zSaGHFCH
         18RjnEMy8BiblPbUWhcKUMlFhMTyrydavTaQa1fGK6/Y3Y2v7gKosBEP76YqYEu+eXq8
         fPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707225234; x=1707830034;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9B16m+06LbX6wDbCkZpe/xuqNeZkgF803HLiKs3kjO0=;
        b=ipTJiJEj11R0VgsROnLhIeHL1/a7k4l5Tt5Nk0aW7dYCIxdtpo2F0rThEjFvWe8V7k
         Gtp+xRnMQ4ozKt+pojyY0Cf2hDTCvuAoGKl3y+x9Ejay858TyUo4iQz/GzXY1N7zPj+T
         pzT8uRvvn1k5gkNzdbDlnlqNDvyK/c0PtFnjezPjV219nD+qtZmOv/0O0/xKXrq3UN68
         eLHTxv/cMYWc3cMVX3k4w/Ffxdvta70ajBgBUrpBBl9xI/lhittbZLFeSYCagH330Una
         k/iZiq7XCmyLED3MaEbkdFBtTcz1iDMNTf7OSKKlzBdsOFwp8EPlcoq4mGVVHtPt4umV
         zsnQ==
X-Gm-Message-State: AOJu0Yyo3NH0y7GvU9csO5wFMVt4YzVwqSBj7l84/FzMpzFS6aaCFf1N
	Tl5OxKk2CcBMlJJ7ncalzucy827p66qPYwpGSvO+Prw8/D/8eU2K51hfqhsydBo=
X-Google-Smtp-Source: AGHT+IFDru2OHPt1vZz4TL1tShfilpiGvCvzNmEKKnqKr1/i7v5eLYOLt+XUrcVsKKeSh+Nn2d5HXQ==
X-Received: by 2002:adf:ce92:0:b0:33b:136b:557a with SMTP id r18-20020adfce92000000b0033b136b557amr1159010wrn.70.1707225234369;
        Tue, 06 Feb 2024 05:13:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUTpb+DI1pQ5crDtRGpCInXvp9arz29Zchi0jyutYuw3WZjHFsLhzHhJow5TVYWq2tXXlJlSahGXSCSW04f2QGpkJcyazNKPz+eRaUcOzWxMHTEb2Fo3jFPRzHhMyHxgHuB/jFUv/xNG/4EJEDMrdtMQexABlaJ94xmxderAAbQx46huKc8dTJK5NP1ljzvjCpemM1N26NRy6N+no3q9k5e7skv9JkwEHaWc2tuVywuaNQMlESl0C+uiw8FKkFy5KkuIZSuWG/WEZyJgeQ+bdt7BqOmvYAgBeLtHmwK66hSgZGzPHDOGqFVoQ6qxjuikMctQc97Mx8dWwIqSzkZRCa1DgSbHV8Xl7Y2r2PCwLs33x3nyVOCF6dds7m+eQ2WN29fATpDcLaYO9Yg5QFD/cuuTzTbAOCGgaVPiAmzEiYdKHp/py5yNyaQTSQtGJfVfKyIMO9TSPTyQNcGQlju20WUuYQ8I2GGREHHcRrPJUSk2YXDMIa5IoWhAIJSrO56MGxzj1VaBbGMxMjFCgjxDgan/1gg5adrEEy6gOttr4NLPMEE2Hgr2r6pRNe5GgMW
Received: from ?IPV6:2a01:e0a:982:cbb0:ba23:8574:fa8:28dd? ([2a01:e0a:982:cbb0:ba23:8574:fa8:28dd])
        by smtp.gmail.com with ESMTPSA id jq16-20020a05600c55d000b0040fb0bf6abesm1941867wmb.29.2024.02.06.05.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 05:13:53 -0800 (PST)
Message-ID: <99a9dd91-9e83-4ca2-93c6-a4de8616e64d@linaro.org>
Date: Tue, 6 Feb 2024 14:13:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 09/20] drivers: crypto: meson: process more than
 MAXDESCS descriptors
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, clabbe@baylibre.com,
 herbert@gondor.apana.org.au, davem@davemloft.net, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com
Cc: linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@salutedevices.com
References: <20240205155521.1795552-1-avromanov@salutedevices.com>
 <20240205155521.1795552-10-avromanov@salutedevices.com>
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
In-Reply-To: <20240205155521.1795552-10-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 05/02/2024 16:55, Alexey Romanov wrote:
> 1. The old alhorithm was not designed to process a large
> amount of memory, and therefore gave incorrect results.
> 
> 2. Not all Amlogic SoC's use 3 KEY/IV descriptors.
> Add keyiv descriptors count parameter to platform data.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/crypto/amlogic/amlogic-gxl-cipher.c | 443 ++++++++++++--------
>   drivers/crypto/amlogic/amlogic-gxl-core.c   |   1 +
>   drivers/crypto/amlogic/amlogic-gxl.h        |   2 +
>   3 files changed, 281 insertions(+), 165 deletions(-)
> 
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> index c662c4b86e97..9c96e7b65e1e 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> @@ -17,35 +17,41 @@
>   #include <crypto/internal/skcipher.h>
>   #include "amlogic-gxl.h"
>   
> -static bool meson_cipher_need_fallback(struct skcipher_request *areq)
> +static bool meson_cipher_need_fallback_sg(struct skcipher_request *areq,
> +					  struct scatterlist *sg)
>   {
> -	struct scatterlist *src_sg = areq->src;
> -	struct scatterlist *dst_sg = areq->dst;
> +	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
> +	unsigned int blocksize = crypto_skcipher_blocksize(tfm);
> +	unsigned int cryptlen = areq->cryptlen;
> +
> +	while (cryptlen) {
> +		unsigned int len = min(cryptlen, sg->length);
> +
> +		if (!IS_ALIGNED(sg->offset, sizeof(u32)))
> +			return true;
> +		if (len % blocksize != 0)
> +			return true;
> +
> +		cryptlen -= len;
> +		sg = sg_next(sg);
> +	}
> +
> +	return false;
> +}
>   
> +static bool meson_cipher_need_fallback(struct skcipher_request *areq)
> +{
>   	if (areq->cryptlen == 0)
>   		return true;
>   
> -	if (sg_nents(src_sg) != sg_nents(dst_sg))
> +	if (meson_cipher_need_fallback_sg(areq, areq->src))
>   		return true;
>   
> -	/* KEY/IV descriptors use 3 desc */
> -	if (sg_nents(src_sg) > MAXDESC - 3 || sg_nents(dst_sg) > MAXDESC - 3)
> -		return true;
> +	if (areq->dst == areq->src)
> +		return false;
>   
> -	while (src_sg && dst_sg) {
> -		if ((src_sg->length % 16) != 0)
> -			return true;
> -		if ((dst_sg->length % 16) != 0)
> -			return true;
> -		if (src_sg->length != dst_sg->length)
> -			return true;
> -		if (!IS_ALIGNED(src_sg->offset, sizeof(u32)))
> -			return true;
> -		if (!IS_ALIGNED(dst_sg->offset, sizeof(u32)))
> -			return true;
> -		src_sg = sg_next(src_sg);
> -		dst_sg = sg_next(dst_sg);
> -	}
> +	if (meson_cipher_need_fallback_sg(areq, areq->dst))
> +		return true;
>   
>   	return false;
>   }
> @@ -76,6 +82,211 @@ static int meson_cipher_do_fallback(struct skcipher_request *areq)
>   	return err;
>   }
>   
> +struct cipher_ctx {
> +	struct {
> +		dma_addr_t addr;
> +		unsigned int len;
> +	} keyiv;
> +
> +	struct skcipher_request *areq;
> +	struct scatterlist *src_sg;
> +	struct scatterlist *dst_sg;
> +
> +	unsigned int src_offset;
> +	unsigned int dst_offset;
> +	unsigned int cryptlen;
> +	unsigned int tloffset;
> +};
> +
> +static int meson_map_scatterlist(struct skcipher_request *areq, struct meson_dev *mc)
> +{
> +	int nr_sgs, nr_sgd;
> +
> +	if (areq->src == areq->dst) {
> +		nr_sgs = dma_map_sg(mc->dev, areq->src, sg_nents(areq->src),
> +							DMA_BIDIRECTIONAL);
> +		if (!nr_sgs) {
> +			dev_err(mc->dev, "Invalid SG count %d\n", nr_sgs);
> +			return -EINVAL;
> +		}
> +	} else {
> +		nr_sgs = dma_map_sg(mc->dev, areq->src, sg_nents(areq->src),
> +							DMA_TO_DEVICE);
> +		if (!nr_sgs) {
> +			dev_err(mc->dev, "Invalid SG count %d\n", nr_sgs);
> +			return -EINVAL;
> +		}
> +
> +		nr_sgd = dma_map_sg(mc->dev, areq->dst, sg_nents(areq->dst),
> +							DMA_FROM_DEVICE);
> +		if (!nr_sgd) {
> +			dev_err(mc->dev, "Invalid SG count %d\n", nr_sgd);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void meson_unmap_scatterlist(struct skcipher_request *areq, struct meson_dev *mc)
> +{
> +	if (areq->src == areq->dst) {
> +		dma_unmap_sg(mc->dev, areq->src, sg_nents(areq->src), DMA_BIDIRECTIONAL);
> +	} else {
> +		dma_unmap_sg(mc->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
> +		dma_unmap_sg(mc->dev, areq->dst, sg_nents(areq->dst), DMA_FROM_DEVICE);
> +	}
> +}
> +
> +static void meson_setup_keyiv_descs(struct cipher_ctx *ctx)
> +{
> +	struct meson_cipher_req_ctx *rctx = skcipher_request_ctx(ctx->areq);
> +	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(ctx->areq);
> +	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
> +	struct meson_alg_template *algt = container_of(alg,
> +		struct meson_alg_template, alg.skcipher.base);
> +	struct meson_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
> +	struct meson_dev *mc = op->mc;
> +	unsigned int ivsize = crypto_skcipher_ivsize(tfm);
> +	unsigned int blockmode = algt->blockmode;
> +	int i;
> +
> +	if (ctx->tloffset)
> +		return;
> +
> +	if (blockmode == DESC_OPMODE_CBC) {
> +		memcpy(op->key + AES_MAX_KEY_SIZE, ctx->areq->iv, ivsize);
> +		ctx->keyiv.len = AES_MAX_KEY_SIZE + ivsize;
> +		dma_sync_single_for_device(mc->dev, ctx->keyiv.addr,
> +					   ctx->keyiv.len, DMA_TO_DEVICE);
> +	}
> +
> +	for (i = 0; i < mc->pdata->setup_desc_cnt; i++) {
> +		struct meson_desc *desc =
> +			&mc->chanlist[rctx->flow].tl[ctx->tloffset];
> +		int offset = i * 16;
> +
> +		desc->t_src = cpu_to_le32(ctx->keyiv.addr + offset);
> +		desc->t_dst = cpu_to_le32(offset);
> +		desc->t_status = cpu_to_le32(DESC_OWN | DESC_MODE_KEY | ctx->keyiv.len);
> +
> +		ctx->tloffset++;
> +	}
> +}
> +
> +static bool meson_setup_data_descs(struct cipher_ctx *ctx)
> +{
> +	struct meson_cipher_req_ctx *rctx = skcipher_request_ctx(ctx->areq);
> +	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(ctx->areq);
> +	struct meson_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
> +	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
> +	struct meson_alg_template *algt = container_of(alg,
> +						       struct meson_alg_template,
> +						       alg.skcipher.base);
> +	struct meson_dev *mc = op->mc;
> +	struct meson_desc *desc = &mc->chanlist[rctx->flow].tl[ctx->tloffset];
> +	unsigned int blocksize = crypto_skcipher_blocksize(tfm);
> +	unsigned int blockmode = algt->blockmode;
> +	unsigned int maxlen = rounddown(DESC_MAXLEN, blocksize);
> +	unsigned int todo;
> +	u32 v;
> +
> +	ctx->tloffset++;
> +
> +	todo = min(ctx->cryptlen, maxlen);
> +	todo = min(todo, ctx->cryptlen);
> +	todo = min(todo, sg_dma_len(ctx->src_sg) - ctx->src_offset);
> +	todo = min(todo, sg_dma_len(ctx->dst_sg) - ctx->dst_offset);
> +
> +	desc->t_src = cpu_to_le32(sg_dma_address(ctx->src_sg) + ctx->src_offset);
> +	desc->t_dst = cpu_to_le32(sg_dma_address(ctx->dst_sg) + ctx->dst_offset);
> +
> +	ctx->cryptlen -= todo;
> +	ctx->src_offset += todo;
> +	ctx->dst_offset += todo;
> +
> +	v = DESC_OWN | blockmode | op->keymode | todo;
> +	if (rctx->op_dir == MESON_ENCRYPT)
> +		v |= DESC_ENCRYPTION;
> +
> +	if (!ctx->cryptlen || ctx->tloffset == MAXDESC)
> +		v |= DESC_LAST;
> +
> +	desc->t_status = cpu_to_le32(v);
> +
> +	return v & DESC_LAST;
> +}
> +
> +static int meson_kick_hardware(struct cipher_ctx *ctx)
> +{
> +	struct meson_cipher_req_ctx *rctx = skcipher_request_ctx(ctx->areq);
> +	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(ctx->areq);
> +	struct meson_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
> +	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
> +	struct meson_alg_template *algt = container_of(alg,
> +						       struct meson_alg_template,
> +						       alg.skcipher.base);
> +	struct meson_dev *mc = op->mc;
> +	unsigned int ivsize = crypto_skcipher_ivsize(tfm);
> +	unsigned int blockmode = algt->blockmode;
> +	enum dma_data_direction new_iv_dir;
> +	dma_addr_t new_iv_phys;
> +	void *new_iv;
> +	int err;
> +
> +	if (blockmode == DESC_OPMODE_CBC) {
> +		struct scatterlist *sg;
> +		unsigned int offset;
> +
> +		if (rctx->op_dir == MESON_ENCRYPT) {
> +			sg = ctx->dst_sg;
> +			offset = ctx->dst_offset;
> +			new_iv_dir = DMA_FROM_DEVICE;
> +		} else {
> +			sg = ctx->src_sg;
> +			offset = ctx->src_offset;
> +			new_iv_dir = DMA_TO_DEVICE;
> +		}
> +
> +		if (ctx->areq->src == ctx->areq->dst)
> +			new_iv_dir = DMA_BIDIRECTIONAL;
> +
> +		offset -= ivsize;
> +		new_iv = sg_virt(sg) + offset;
> +		new_iv_phys = sg_dma_address(sg) + offset;
> +	}
> +
> +	if (blockmode == DESC_OPMODE_CBC &&
> +		rctx->op_dir == MESON_DECRYPT) {
> +		dma_sync_single_for_cpu(mc->dev, new_iv_phys,
> +					ivsize, new_iv_dir);
> +		memcpy(ctx->areq->iv, new_iv, ivsize);
> +	}
> +
> +	reinit_completion(&mc->chanlist[rctx->flow].complete);
> +	meson_dma_start(mc, rctx->flow);
> +	err = wait_for_completion_interruptible_timeout(
> +			&mc->chanlist[rctx->flow].complete, msecs_to_jiffies(500));
> +	if (err == 0) {
> +		dev_err(mc->dev, "DMA timeout for flow %d\n", rctx->flow);
> +		return -EINVAL;
> +	} else if (err < 0) {
> +		dev_err(mc->dev, "Waiting for DMA completion is failed (%d)\n", err);
> +		return err;
> +	}
> +
> +	if (blockmode == DESC_OPMODE_CBC &&
> +		rctx->op_dir == MESON_ENCRYPT) {
> +		dma_sync_single_for_cpu(mc->dev, new_iv_phys,
> +					ivsize, new_iv_dir);
> +		memcpy(ctx->areq->iv, new_iv, ivsize);
> +	}
> +
> +	ctx->tloffset = 0;
> +
> +	return 0;
> +}
> +
>   static int meson_cipher(struct skcipher_request *areq)
>   {
>   	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
> @@ -84,176 +295,78 @@ static int meson_cipher(struct skcipher_request *areq)
>   	struct meson_dev *mc = op->mc;
>   	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
>   	struct meson_alg_template *algt;
> -	int flow = rctx->flow;
> -	unsigned int todo, eat, len;
> -	struct scatterlist *src_sg = areq->src;
> -	struct scatterlist *dst_sg = areq->dst;
> -	struct meson_desc *desc;
> -	int nr_sgs, nr_sgd;
> -	int i, err = 0;
> -	unsigned int keyivlen, ivsize, offset, tloffset;
> -	dma_addr_t phykeyiv;
> -	void *backup_iv = NULL, *bkeyiv;
> -	u32 v;
> -
> -	algt = container_of(alg, struct meson_alg_template, alg.skcipher.base);
> +	struct cipher_ctx ctx = {
> +		.areq = areq,
> +		.src_offset = 0,
> +		.dst_offset = 0,
> +		.src_sg = areq->src,
> +		.dst_sg = areq->dst,
> +		.cryptlen = areq->cryptlen,
> +	};
> +	unsigned int ivsize = crypto_skcipher_ivsize(tfm);

I'm getting build errors with W=1 build:

drivers/crypto/amlogic/amlogic-gxl-cipher.c:306:22: error: unused variable ‘ivsize’ [-Werror=unused-variable]
   306 |         unsigned int ivsize = crypto_skcipher_ivsize(tfm);
       |                      ^~~~~~

> +	int err;
>   
> -	dev_dbg(mc->dev, "%s %s %u %x IV(%u) key=%u flow=%d\n", __func__,
> +	dev_dbg(mc->dev, "%s %s %u %x IV(%u) key=%u ctx.flow=%d\n", __func__,
>   		crypto_tfm_alg_name(areq->base.tfm),
>   		areq->cryptlen,
>   		rctx->op_dir, crypto_skcipher_ivsize(tfm),
> -		op->keylen, flow);
> +		op->keylen, rctx->flow);
> +
> +	algt = container_of(alg, struct meson_alg_template, alg.skcipher.base);
>   
>   #ifdef CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG
>   	algt->stat_req++;
> -	mc->chanlist[flow].stat_req++;
> +	mc->chanlist[rctx->flow].stat_req++;
>   #endif
>   
> -	/*
> -	 * The hardware expect a list of meson_desc structures.
> -	 * The 2 first structures store key
> -	 * The third stores IV
> -	 */
> -	bkeyiv = kzalloc(48, GFP_KERNEL | GFP_DMA);
> -	if (!bkeyiv)
> +	op->key = kzalloc(48, GFP_KERNEL | GFP_DMA);
> +	if (!op.key)
>   		return -ENOMEM;

drivers/crypto/amlogic/amlogic-gxl-cipher.c: In function ‘meson_cipher’:
drivers/crypto/amlogic/amlogic-gxl-cipher.c:323:16: error: ‘op’ is a pointer; did you mean to use ‘->’?
   323 |         if (!op.key)
       |                ^

>   
> -	memcpy(bkeyiv, op->key, op->keylen);
> -	keyivlen = op->keylen;
> +	memcpy(op->key, op->key, op->keylen);
> +	ctx.keyiv.len = op->keylen;
> +	if (ctx.keyiv.len == AES_KEYSIZE_192)
> +		ctx.keyiv.len = AES_MAX_KEY_SIZE;
>   
> -	ivsize = crypto_skcipher_ivsize(tfm);
> -	if (areq->iv && ivsize > 0) {
> -		if (ivsize > areq->cryptlen) {
> -			dev_err(mc->dev, "invalid ivsize=%d vs len=%d\n", ivsize, areq->cryptlen);
> -			err = -EINVAL;
> -			goto theend;
> -		}
> -		memcpy(bkeyiv + 32, areq->iv, ivsize);
> -		keyivlen = 48;
> -		if (rctx->op_dir == MESON_DECRYPT) {
> -			backup_iv = kzalloc(ivsize, GFP_KERNEL);
> -			if (!backup_iv) {
> -				err = -ENOMEM;
> -				goto theend;
> -			}
> -			offset = areq->cryptlen - ivsize;
> -			scatterwalk_map_and_copy(backup_iv, areq->src, offset,
> -						 ivsize, 0);
> -		}
> -	}
> -	if (keyivlen == AES_KEYSIZE_192)
> -		keyivlen = AES_MAX_KEY_SIZE;
> -
> -	phykeyiv = dma_map_single(mc->dev, bkeyiv, keyivlen,
> +	ctx.keyiv.addr = dma_map_single(mc->dev, op->key, ctx.keyiv.len,
>   				  DMA_TO_DEVICE);
> -	err = dma_mapping_error(mc->dev, phykeyiv);
> +	err = dma_mapping_error(mc->dev, ctx.keyiv.addr);
>   	if (err) {
>   		dev_err(mc->dev, "Cannot DMA MAP KEY IV\n");
>   		goto theend;
>   	}
>   
> -	tloffset = 0;
> -	eat = 0;
> -	i = 0;
> -	while (keyivlen > eat) {
> -		desc = &mc->chanlist[flow].tl[tloffset];
> -		memset(desc, 0, sizeof(struct meson_desc));
> -		todo = min(keyivlen - eat, 16u);
> -		desc->t_src = cpu_to_le32(phykeyiv + i * 16);
> -		desc->t_dst = cpu_to_le32(i * 16);
> -		v = DESC_MODE_KEY | DESC_OWN | 16;
> -		desc->t_status = cpu_to_le32(v);
> -
> -		eat += todo;
> -		i++;
> -		tloffset++;
> -	}
> -
> -	if (areq->src == areq->dst) {
> -		nr_sgs = dma_map_sg(mc->dev, areq->src, sg_nents(areq->src),
> -				    DMA_BIDIRECTIONAL);
> -		if (!nr_sgs) {
> -			dev_err(mc->dev, "Invalid SG count %d\n", nr_sgs);
> -			err = -EINVAL;
> -			goto theend;
> -		}
> -		nr_sgd = nr_sgs;
> -	} else {
> -		nr_sgs = dma_map_sg(mc->dev, areq->src, sg_nents(areq->src),
> -				    DMA_TO_DEVICE);
> -		if (!nr_sgs || nr_sgs > MAXDESC - 3) {
> -			dev_err(mc->dev, "Invalid SG count %d\n", nr_sgs);
> -			err = -EINVAL;
> -			goto theend;
> -		}
> -		nr_sgd = dma_map_sg(mc->dev, areq->dst, sg_nents(areq->dst),
> -				    DMA_FROM_DEVICE);
> -		if (!nr_sgd || nr_sgd > MAXDESC - 3) {
> -			dev_err(mc->dev, "Invalid SG count %d\n", nr_sgd);
> -			err = -EINVAL;
> -			goto theend;
> -		}
> -	}
> -
> -	src_sg = areq->src;
> -	dst_sg = areq->dst;
> -	len = areq->cryptlen;
> -	while (src_sg) {
> -		desc = &mc->chanlist[flow].tl[tloffset];
> -		memset(desc, 0, sizeof(struct meson_desc));
> -
> -		desc->t_src = cpu_to_le32(sg_dma_address(src_sg));
> -		desc->t_dst = cpu_to_le32(sg_dma_address(dst_sg));
> -		todo = min(len, sg_dma_len(src_sg));
> -		v = op->keymode | DESC_OWN | todo | algt->blockmode;
> -		if (rctx->op_dir)
> -			v |= DESC_ENCRYPTION;
> -		len -= todo;
> -
> -		if (!sg_next(src_sg))
> -			v |= DESC_LAST;
> -		desc->t_status = cpu_to_le32(v);
> -		tloffset++;
> -		src_sg = sg_next(src_sg);
> -		dst_sg = sg_next(dst_sg);
> -	}
> +	err = meson_map_scatterlist(areq, mc);
> +	if (err)
> +		goto theend;
>   
> -	reinit_completion(&mc->chanlist[flow].complete);
> -	meson_dma_start(mc, flow);
> +	ctx.tloffset = 0;
>   
> -	err = wait_for_completion_interruptible_timeout(&mc->chanlist[flow].complete,
> -							msecs_to_jiffies(500));
> -	if (err == 0) {
> -		dev_err(mc->dev, "DMA timeout for flow %d\n", flow);
> -		err = -EINVAL;
> -	} else if (err < 0) {
> -		dev_err(mc->dev, "Waiting for DMA completion is failed (%d)\n", err);
> -	} else {
> -		/* No error */
> -		err = 0;
> -	}
> +	while (ctx.cryptlen) {
> +		meson_setup_keyiv_descs(&ctx);
>   
> -	dma_unmap_single(mc->dev, phykeyiv, keyivlen, DMA_TO_DEVICE);
> +		if (meson_setup_data_descs(&ctx)) {
> +			err = meson_kick_hardware(&ctx);
> +			if (err)
> +				break;
> +		}
>   
> -	if (areq->src == areq->dst) {
> -		dma_unmap_sg(mc->dev, areq->src, sg_nents(areq->src), DMA_BIDIRECTIONAL);
> -	} else {
> -		dma_unmap_sg(mc->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
> -		dma_unmap_sg(mc->dev, areq->dst, sg_nents(areq->dst), DMA_FROM_DEVICE);
> -	}
> +		if (ctx.src_offset == sg_dma_len(ctx.src_sg)) {
> +			ctx.src_offset = 0;
> +			ctx.src_sg = sg_next(ctx.src_sg);
> +		}
>   
> -	if (areq->iv && ivsize > 0) {
> -		if (rctx->op_dir == MESON_DECRYPT) {
> -			memcpy(areq->iv, backup_iv, ivsize);
> -		} else {
> -			scatterwalk_map_and_copy(areq->iv, areq->dst,
> -						 areq->cryptlen - ivsize,
> -						 ivsize, 0);
> +		if (ctx.dst_offset == sg_dma_len(ctx.dst_sg)) {
> +			ctx.dst_offset = 0;
> +			ctx.dst_sg = sg_next(ctx.dst_sg);
>   		}
>   	}
> +
> +	dma_unmap_single(mc->dev, ctx.keyiv.addr, ctx.keyiv.len, DMA_TO_DEVICE);
> +	meson_unmap_scatterlist(areq, mc);
> +
>   theend:
> -	kfree_sensitive(bkeyiv);
> -	kfree_sensitive(backup_iv);
> +	kfree_sensitive(op->key);
>   
>   	return err;
>   }
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
> index 22ff2768b5e5..f93e14f5717d 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-core.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
> @@ -199,6 +199,7 @@ static const struct meson_pdata meson_gxl_pdata = {
>   	.descs_reg = 0x0,
>   	.status_reg = 0x4,
>   	.need_clk = true,
> +	.setup_desc_cnt = 3,
>   };
>   
>   static const struct of_device_id meson_crypto_of_match_table[] = {
> diff --git a/drivers/crypto/amlogic/amlogic-gxl.h b/drivers/crypto/amlogic/amlogic-gxl.h
> index a0d83c82906d..eb2f8cd72b65 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl.h
> +++ b/drivers/crypto/amlogic/amlogic-gxl.h
> @@ -83,11 +83,13 @@ struct meson_flow {
>    * @reg_descs:	offset to descriptors register
>    * @reg_status:	offset to status register
>    * @need_clk:	clock input is needed
> + * @setup_desc_cnt:	number of setup descriptor to configure.
>    */
>   struct meson_pdata {
>   	u32 descs_reg;
>   	u32 status_reg;
>   	bool need_clk;
> +	u32 setup_desc_cnt;
>   };
>   
>   /*

Thanks,
Neil


