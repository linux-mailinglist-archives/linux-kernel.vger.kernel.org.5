Return-Path: <linux-kernel+bounces-62071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEAD851B08
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318071C228E8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8128C3F8F4;
	Mon, 12 Feb 2024 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LfAtcXey"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3313F8D4
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757950; cv=none; b=NmMvqBQ1PeWJ7G/ZOGKXt7iIhvN7ZhODA3UWBVPkt4P6b64R6tesdq8J8XJdAnCae3swycxhx2ZWze3gn70pUZDLkUHORtlyaB2HK5YTCGsweu3DJtEia/u7JujaPY2bYnOPZbGQYRLWlg3xcE5lIOU2xfm001SQU1xOSms1Dho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757950; c=relaxed/simple;
	bh=5CAAaKbBOWfqgdMWXlVW5R/sNtGSPiZMgN+ETXEUvkE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Un9yZgK7taswHzTYsMN0cSez2ZT8kbiPGQpEUwyITMUBk7xnRTT2x1iujNFzkggXkNUDvVfh9R+v3tWTGCqlLjxmmmX5weT9hx85aZh38hp9B3ey7rFzZQDL+xPSTZtKQJ3S+ij0VJskIBLx6iRyFSbVrGgjJu+cH3l9m9uV8Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LfAtcXey; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33b960e3b8fso275968f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707757946; x=1708362746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iUFMEG6hGBzuP2fzIahueVya06V53CR/t4OXacspNes=;
        b=LfAtcXeyEWp4dwKUsIeplqek/m3vWQPsZlgr0YEytCvvNk4E8Kb0CLRLLR1ery4vR3
         0yit060ufMcP1BmNfdv/SYIAHu3Gw032owIZGDD5aIviKADcq8hCzlBdKiLYdbEVFmqK
         EU95ncYWSQ9FMdOP5QMijbwYTf5pZd4CPyQy0POrh7oEzfH+c/bB6x7p3XARAvy/VajI
         vai2tOwXSJ050P7UtryMBGJFHX+hQls4U49X12duAaULAkX+Xw+jHN7NM775KEtgIhC0
         NbaN/ZoGGpfXif9t+MDuxbKft7jOIE/yh+2wyYhkhGtLqV0s1iCQ0z2UkJD2cunN14lp
         lLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757946; x=1708362746;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iUFMEG6hGBzuP2fzIahueVya06V53CR/t4OXacspNes=;
        b=b8IuLg4qrLAVGr8ETt8p7A+0OdGJyQqEfagd4wn9DE8EwZCgVbuZG6vqYR0CtUbqFf
         OfsvTQBvRlfbtJf5JLng5+b+UEcWOl+MAljYEI49ZptGFXGbBWk9QyIf8G/OBV3r06GH
         A8xYktDp9DQZ0iEUgCACW9KhO9hpONES5Ybtpz31MgbXBjfOPvjiKpvruDQpfmm9WS6l
         +qkNdLQFjJxXJ+auOQFVXYD5jUsWhhXFpl1bYlTkq60F64YpmTUcJSKA1LoTayqkJWw9
         MqylL1ldJsSdKSKs7aPWPxzGhlDV1StckB6atrUffs8HnVOtNjZTfWtYPYPw/odskEu5
         XNqA==
X-Forwarded-Encrypted: i=1; AJvYcCV28Vb0K+lHUyJcJqLeSBwD35HJFI4rDhbAkH19FFtEn8HqKyjDNakKPYhN8WJdYRgx1pnnQ31gcQ82mw45aCAam87BpS3m/QOhK0OP
X-Gm-Message-State: AOJu0YzSD3jeZ2tfVXMBjtfj8vrgbw9ZQY/klPSxQn7RzfiFC6dy6Flg
	7/KJbMa+qfdgurVh+Y0JDTiH3sIF1E52OZg8Z3YKBTl36tNwcKcj+kRtz+NZqeM=
X-Google-Smtp-Source: AGHT+IF80oet3+jgmg4XyhbsJscfa5G5KkD3HA66bmXt2O3MdIyzgC6cND7cNxRofYyR830vEIsnnw==
X-Received: by 2002:a05:6000:10cd:b0:33b:81cc:bd15 with SMTP id b13-20020a05600010cd00b0033b81ccbd15mr2220900wrx.37.1707757946194;
        Mon, 12 Feb 2024 09:12:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDdDcd20fH/8E8P+RgtCFJF0xrUYhLzUi1gaCNtVU75oqSCnEJfs+GvUqsM7neB109DSgxsdBtqbPHogpb4zHvUephGeASkCSkHIYPcRw64CZuvJBejvJXm9MNIh5KlVf/XnLoVeGBjwgb3xWjjFas1pyWMckAJSxHwKQefVFvXzb4MiQrbD5qPoX+d4xAZhbXteU8pxCKD7GnY/v6I3XQYS1HezEoJV2XZCzDL3ypPCHJUtWi02zzYZj1NKlrHiKRlTzvqRzCf+fAPU7t5B9/r8qsoz403zvK04DuaEZui8cw8SqIf7vUxSZ63tTcLwiNI2Q5E+1XXVIKq+63a7nPU9aUWjqEeF9rh7ceLlhM9k5Ci4oPfrkafUtyDBX8m/giDdwqVn21JUKbrG7jDw86OzW26yOyDDWGbdN2zhEQ/iLHvQa2kIHz5yAGq+0NwFdObkEtBLZaMo7JSTVJBlPKGQ49Cm0HkIw/nbWEQHJ7V6Rl0oTliUEU85rRl73k2eBxxHooy5O/jwHufmYv2mDWb79ay3p74u9pTmY+bqsvJWDB8kiCq8BWOGW41uHNgCQcthzraa9V593G3n4VT0APuE5dooZn1zq5
Received: from ?IPV6:2a01:e0a:982:cbb0:fcee:f026:296d:135f? ([2a01:e0a:982:cbb0:fcee:f026:296d:135f])
        by smtp.gmail.com with ESMTPSA id ck13-20020a5d5e8d000000b0033b684d6d5csm7440536wrb.20.2024.02.12.09.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 09:12:25 -0800 (PST)
Message-ID: <09b4656d-a16c-4ae9-b1be-4320e093b974@linaro.org>
Date: Mon, 12 Feb 2024 18:12:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 07/20] drivers: crypto: meson: move algs definition and
 cipher API to cipher.c
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
 <20240212135108.549755-8-avromanov@salutedevices.com>
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
In-Reply-To: <20240212135108.549755-8-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/02/2024 14:50, Alexey Romanov wrote:
> Because that is proper place for them. In particular,
> it takes less of exported symbol between compiling entities.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/crypto/amlogic/amlogic-gxl-cipher.c |  98 +++++++++++++++--
>   drivers/crypto/amlogic/amlogic-gxl-core.c   | 110 ++++----------------
>   drivers/crypto/amlogic/amlogic-gxl.h        |  14 +--
>   3 files changed, 119 insertions(+), 103 deletions(-)
> 
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> index dc0b100c5de2..bc3092a8a2c2 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> @@ -271,7 +271,7 @@ int meson_handle_cipher_request(struct crypto_engine *engine, void *areq)
>   	return 0;
>   }
>   
> -int meson_skdecrypt(struct skcipher_request *areq)
> +static int meson_skdecrypt(struct skcipher_request *areq)
>   {
>   	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
>   	struct meson_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
> @@ -289,7 +289,7 @@ int meson_skdecrypt(struct skcipher_request *areq)
>   	return crypto_transfer_skcipher_request_to_engine(engine, areq);
>   }
>   
> -int meson_skencrypt(struct skcipher_request *areq)
> +static int meson_skencrypt(struct skcipher_request *areq)
>   {
>   	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
>   	struct meson_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
> @@ -307,7 +307,7 @@ int meson_skencrypt(struct skcipher_request *areq)
>   	return crypto_transfer_skcipher_request_to_engine(engine, areq);
>   }
>   
> -int meson_cipher_init(struct crypto_tfm *tfm)
> +static int meson_cipher_init(struct crypto_tfm *tfm)
>   {
>   	struct meson_cipher_tfm_ctx *op = crypto_tfm_ctx(tfm);
>   	struct meson_alg_template *algt;
> @@ -333,7 +333,7 @@ int meson_cipher_init(struct crypto_tfm *tfm)
>   	return 0;
>   }
>   
> -void meson_cipher_exit(struct crypto_tfm *tfm)
> +static void meson_cipher_exit(struct crypto_tfm *tfm)
>   {
>   	struct meson_cipher_tfm_ctx *op = crypto_tfm_ctx(tfm);
>   
> @@ -341,8 +341,8 @@ void meson_cipher_exit(struct crypto_tfm *tfm)
>   	crypto_free_skcipher(op->fallback_tfm);
>   }
>   
> -int meson_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
> -		     unsigned int keylen)
> +static int meson_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
> +			    unsigned int keylen)
>   {
>   	struct meson_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
>   	struct meson_dev *mc = op->mc;
> @@ -369,3 +369,89 @@ int meson_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
>   
>   	return crypto_skcipher_setkey(op->fallback_tfm, key, keylen);
>   }
> +
> +static struct meson_alg_template algs[] = {
> +{
> +	.type = CRYPTO_ALG_TYPE_SKCIPHER,
> +	.blockmode = MESON_OPMODE_CBC,
> +	.alg.skcipher.base = {
> +		.base = {
> +			.cra_name = "cbc(aes)",
> +			.cra_driver_name = "cbc-aes-gxl",
> +			.cra_priority = 400,
> +			.cra_blocksize = AES_BLOCK_SIZE,
> +			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER |
> +				CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
> +				CRYPTO_ALG_NEED_FALLBACK,
> +			.cra_ctxsize = sizeof(struct meson_cipher_tfm_ctx),
> +			.cra_module = THIS_MODULE,
> +			.cra_alignmask = 0xf,
> +			.cra_init = meson_cipher_init,
> +			.cra_exit = meson_cipher_exit,
> +		},
> +		.min_keysize	= AES_MIN_KEY_SIZE,
> +		.max_keysize	= AES_MAX_KEY_SIZE,
> +		.ivsize		= AES_BLOCK_SIZE,
> +		.setkey		= meson_aes_setkey,
> +		.encrypt	= meson_skencrypt,
> +		.decrypt	= meson_skdecrypt,
> +	},
> +	.alg.skcipher.op = {
> +		.do_one_request = meson_handle_cipher_request,
> +	},
> +},
> +{
> +	.type = CRYPTO_ALG_TYPE_SKCIPHER,
> +	.blockmode = MESON_OPMODE_ECB,
> +	.alg.skcipher.base = {
> +		.base = {
> +			.cra_name = "ecb(aes)",
> +			.cra_driver_name = "ecb-aes-gxl",
> +			.cra_priority = 400,
> +			.cra_blocksize = AES_BLOCK_SIZE,
> +			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER |
> +				CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
> +				CRYPTO_ALG_NEED_FALLBACK,
> +			.cra_ctxsize = sizeof(struct meson_cipher_tfm_ctx),
> +			.cra_module = THIS_MODULE,
> +			.cra_alignmask = 0xf,
> +			.cra_init = meson_cipher_init,
> +			.cra_exit = meson_cipher_exit,
> +		},
> +		.min_keysize	= AES_MIN_KEY_SIZE,
> +		.max_keysize	= AES_MAX_KEY_SIZE,
> +		.setkey		= meson_aes_setkey,
> +		.encrypt	= meson_skencrypt,
> +		.decrypt	= meson_skdecrypt,
> +	},
> +	.alg.skcipher.op = {
> +		.do_one_request = meson_handle_cipher_request,
> +	},
> +},
> +};
> +
> +int meson_cipher_register(struct meson_dev *mc)
> +{
> +	return meson_register_algs(mc, algs, ARRAY_SIZE(algs));
> +}
> +
> +void meson_cipher_unregister(struct meson_dev *mc)
> +{
> +	meson_unregister_algs(mc, algs, ARRAY_SIZE(algs));
> +}
> +
> +void meson_cipher_debugfs_show(struct seq_file *seq, void *v)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(algs); i++) {
> +		seq_printf(seq, "%s %s %lu %lu\n",
> +			   algs[i].alg.skcipher.base.base.cra_driver_name,
> +			   algs[i].alg.skcipher.base.base.cra_name,
> +#ifdef CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG
> +			   algs[i].stat_req, algs[i].stat_fb);
> +#else
> +			   0ul, 0ul);
> +#endif
> +	}
> +}
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
> index f7c60ebffbc3..22ff2768b5e5 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-core.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
> @@ -65,66 +65,6 @@ static irqreturn_t meson_irq_handler(int irq, void *data)
>   	return IRQ_HANDLED;
>   }
>   
> -static struct meson_alg_template mc_algs[] = {
> -{
> -	.type = CRYPTO_ALG_TYPE_SKCIPHER,
> -	.blockmode = MESON_OPMODE_CBC,
> -	.alg.skcipher.base = {
> -		.base = {
> -			.cra_name = "cbc(aes)",
> -			.cra_driver_name = "cbc-aes-gxl",
> -			.cra_priority = 400,
> -			.cra_blocksize = AES_BLOCK_SIZE,
> -			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER |
> -				CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
> -				CRYPTO_ALG_NEED_FALLBACK,
> -			.cra_ctxsize = sizeof(struct meson_cipher_tfm_ctx),
> -			.cra_module = THIS_MODULE,
> -			.cra_alignmask = 0xf,
> -			.cra_init = meson_cipher_init,
> -			.cra_exit = meson_cipher_exit,
> -		},
> -		.min_keysize	= AES_MIN_KEY_SIZE,
> -		.max_keysize	= AES_MAX_KEY_SIZE,
> -		.ivsize		= AES_BLOCK_SIZE,
> -		.setkey		= meson_aes_setkey,
> -		.encrypt	= meson_skencrypt,
> -		.decrypt	= meson_skdecrypt,
> -	},
> -	.alg.skcipher.op = {
> -		.do_one_request = meson_handle_cipher_request,
> -	},
> -},
> -{
> -	.type = CRYPTO_ALG_TYPE_SKCIPHER,
> -	.blockmode = MESON_OPMODE_ECB,
> -	.alg.skcipher.base = {
> -		.base = {
> -			.cra_name = "ecb(aes)",
> -			.cra_driver_name = "ecb-aes-gxl",
> -			.cra_priority = 400,
> -			.cra_blocksize = AES_BLOCK_SIZE,
> -			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER |
> -				CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
> -				CRYPTO_ALG_NEED_FALLBACK,
> -			.cra_ctxsize = sizeof(struct meson_cipher_tfm_ctx),
> -			.cra_module = THIS_MODULE,
> -			.cra_alignmask = 0xf,
> -			.cra_init = meson_cipher_init,
> -			.cra_exit = meson_cipher_exit,
> -		},
> -		.min_keysize	= AES_MIN_KEY_SIZE,
> -		.max_keysize	= AES_MAX_KEY_SIZE,
> -		.setkey		= meson_aes_setkey,
> -		.encrypt	= meson_skencrypt,
> -		.decrypt	= meson_skdecrypt,
> -	},
> -	.alg.skcipher.op = {
> -		.do_one_request = meson_handle_cipher_request,
> -	},
> -},
> -};
> -
>   static int meson_debugfs_show(struct seq_file *seq, void *v)
>   {
>   	struct meson_dev *mc __maybe_unused = seq->private;
> @@ -138,20 +78,8 @@ static int meson_debugfs_show(struct seq_file *seq, void *v)
>   			   0ul);
>   #endif
>   
> -	for (i = 0; i < ARRAY_SIZE(mc_algs); i++) {
> -		switch (mc_algs[i].type) {
> -		case CRYPTO_ALG_TYPE_SKCIPHER:
> -			seq_printf(seq, "%s %s %lu %lu\n",
> -				   mc_algs[i].alg.skcipher.base.base.cra_driver_name,
> -				   mc_algs[i].alg.skcipher.base.base.cra_name,
> -#ifdef CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG
> -				   mc_algs[i].stat_req, mc_algs[i].stat_fb);
> -#else
> -				   0ul, 0ul);
> -#endif
> -			break;
> -		}
> -	}
> +	meson_cipher_debugfs_show(seq, v);
> +
>   	return 0;
>   }
>   DEFINE_SHOW_ATTRIBUTE(meson_debugfs);
> @@ -228,38 +156,40 @@ static int meson_allocate_chanlist(struct meson_dev *mc)
>   	return err;
>   }
>   
> -static int meson_register_algs(struct meson_dev *mc)
> +int meson_register_algs(struct meson_dev *mc, struct meson_alg_template *algs,
> +			unsigned int count)
>   {
>   	int err, i;
>   
> -	for (i = 0; i < ARRAY_SIZE(mc_algs); i++) {
> -		mc_algs[i].mc = mc;
> -		switch (mc_algs[i].type) {
> +	for (i = 0; i < count; i++) {
> +		switch (algs[i].type) {
>   		case CRYPTO_ALG_TYPE_SKCIPHER:
> -			err = crypto_engine_register_skcipher(&mc_algs[i].alg.skcipher);
> +			err = crypto_engine_register_skcipher(&algs[i].alg.skcipher);
>   			if (err) {
>   				dev_err(mc->dev, "Fail to register %s\n",
> -					mc_algs[i].alg.skcipher.base.base.cra_name);
> -				mc_algs[i].mc = NULL;
> +					algs[i].alg.skcipher.base.base.cra_name);
> +				meson_unregister_algs(mc, algs, count);
>   				return err;
>   			}
>   			break;
>   		}
> +		algs[i].mc = mc;
>   	}
>   
>   	return 0;
>   }
>   
> -static void meson_unregister_algs(struct meson_dev *mc)
> +void meson_unregister_algs(struct meson_dev *mc, struct meson_alg_template *algs,
> +			   unsigned int count)
>   {
>   	int i;
>   
> -	for (i = 0; i < ARRAY_SIZE(mc_algs); i++) {
> -		if (!mc_algs[i].mc)
> +	for (i = 0; i < count; i++) {
> +		if (!algs[i].mc)
>   			continue;
> -		switch (mc_algs[i].type) {
> +		switch (algs[i].type) {
>   		case CRYPTO_ALG_TYPE_SKCIPHER:
> -			crypto_engine_unregister_skcipher(&mc_algs[i].alg.skcipher);
> +			crypto_engine_unregister_skcipher(&algs[i].alg.skcipher);
>   			break;
>   		}
>   	}
> @@ -318,9 +248,9 @@ static int meson_crypto_probe(struct platform_device *pdev)
>   	if (err)
>   		goto error_flow;
>   
> -	err = meson_register_algs(mc);
> +	err = meson_cipher_register(mc);
>   	if (err)
> -		goto error_alg;
> +		goto error_flow;
>   
>   	if (IS_ENABLED(CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG)) {
>   		struct dentry *dbgfs_dir;
> @@ -334,8 +264,6 @@ static int meson_crypto_probe(struct platform_device *pdev)
>   	}
>   
>   	return 0;
> -error_alg:
> -	meson_unregister_algs(mc);
>   error_flow:
>   	meson_free_chanlist(mc, mc->flow_cnt - 1);
>   	return err;
> @@ -349,7 +277,7 @@ static void meson_crypto_remove(struct platform_device *pdev)
>   	debugfs_remove_recursive(mc->dbgfs_dir);
>   #endif
>   
> -	meson_unregister_algs(mc);
> +	meson_cipher_unregister(mc);
>   
>   	meson_free_chanlist(mc, mc->flow_cnt - 1);
>   }
> diff --git a/drivers/crypto/amlogic/amlogic-gxl.h b/drivers/crypto/amlogic/amlogic-gxl.h
> index e27908992ae3..0a03e8144977 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl.h
> +++ b/drivers/crypto/amlogic/amlogic-gxl.h
> @@ -167,10 +167,12 @@ void meson_dma_start(struct meson_dev *mc, int flow);
>   
>   int meson_enqueue(struct crypto_async_request *areq, u32 type);
>   
> -int meson_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
> -		     unsigned int keylen);
> -int meson_cipher_init(struct crypto_tfm *tfm);
> -void meson_cipher_exit(struct crypto_tfm *tfm);
> -int meson_skdecrypt(struct skcipher_request *areq);
> -int meson_skencrypt(struct skcipher_request *areq);
> +int meson_register_algs(struct meson_dev *mc, struct meson_alg_template *algs,
> +			unsigned int count);
> +void meson_unregister_algs(struct meson_dev *mc, struct meson_alg_template *algs,
> +			   unsigned int count);
> +
> +int meson_cipher_register(struct meson_dev *mc);
> +void meson_cipher_unregister(struct meson_dev *mc);
> +void meson_cipher_debugfs_show(struct seq_file *seq, void *v);
>   int meson_handle_cipher_request(struct crypto_engine *engine, void *areq);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

