Return-Path: <linux-kernel+bounces-62073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2260F851B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470F51C22972
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5083DBA1;
	Mon, 12 Feb 2024 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xR17mKjb"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577D33D96E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758084; cv=none; b=ihZxVkSCIPnSiq3CCEfb0ztJLdizXZmlMLvuIBUMl3H3kYEum+IMalVNdGVv18IJLHc/EVbnl8JB4Ye8F8gH8cHyWAK8A6dVRGl3Lf9P+HVMrCwBsnxST2d0vxr5fbNqKQZDsuiEomJVHkgijmiyMpNF6jH4qvTw0TIe5nBQLE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758084; c=relaxed/simple;
	bh=+PXsjXarIpnQiKdcC4Ba0lDccq4l2TIEcPd6DW84Rx8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=j2LBgy7dA/sU0XrF9rB8j6WhWTs27Xefj6a6ObSHZNbnTvkJd5J/WqfMU0XzJEOibQUPPQP7ro75nD38rWClugeCVwNQD7QsP37xAGgjK/930zkKSKTHBdc4xvitfeDS1ObaeQHrohbX+wr4dTspQvfKrmg/q/D/G63IP2Qm9W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xR17mKjb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso27464975e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707758080; x=1708362880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKnLGFZeK7ItHj2yxoxH7NiZ3LsjLJy2xTMor9uQY2o=;
        b=xR17mKjb90dHwtfg6XaRJHQ2MRgwHjkPLgMfjDD9ww0+aTfO3veq2WJQ4iGciA8u8V
         SDwk0i0h6IpqXc38lBP88r1gjNrLR2jJ3G86hOrPQDsmtBb587gCGLDfBVrWl1ua3ovZ
         vZXkrNGRC2j9hh1P1LcA5VZ+VVwTFbxs79RK5fLvOA3oALobF65bdABXKzYhDqqo0y4T
         KMtPBzCmSXQAx5Y0UJVHdaOPLy9WUW1kDHXwCxriXD5SKG3M/5cXsUG2ctFfqbz9RSKm
         Z7nHOD9iX7N/BSfuxar5cq0YudLibV44rfN7sQxzzHiWW9HZhkDt7hiICeA8iV00c7KB
         Ztew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707758080; x=1708362880;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XKnLGFZeK7ItHj2yxoxH7NiZ3LsjLJy2xTMor9uQY2o=;
        b=b2lcM7PeluiFTxRtSuNEssdf4vpfoG0UL5cuiw9WNobGg8aNW0rnX/V2OUeUFFRgoE
         mb7906uGlZZUN0ivgUI7OFSBAB1H2KI0ez7CdEHtC4nqtN/gJmzQMzyyVDuKSUVw2WKf
         vDh4sNpBtJcPEInpQ6zp+q9F2kApZG4dfdSpEZEgMsLyHRRwIWfQIFkhfGlSn3iGSDQ8
         loZXX3KJRQUzDKH2rQ6zn8oZeQDp/wsuAk0zLuIuCBZSx/BlQv1eIRnybYnYg7Cvm6XP
         0SkfLcQYAvNnfAQwb12OyILXtlem1zx2FkrG8xJqWLk0uevRWBQfpL5+E6rdWEJFBOsT
         9T1w==
X-Gm-Message-State: AOJu0Yx4UhAGx8jE52StuDvgyzjbGp7hbm83yiipRvNctdkMOhEGplTq
	TazEvOAx281xo2Ow8BzfEiR/5GGbnXuzpJH8hG8LkzG1JarUejkfmXeeWr87ufw=
X-Google-Smtp-Source: AGHT+IFy2Ra10bE50kRkVSHdkj9FIuG5z3f6EZNgXUcoUiyphm44GWBfJF/ChpuKZU7NSUqPli5bgw==
X-Received: by 2002:a5d:500d:0:b0:33b:470f:628e with SMTP id e13-20020a5d500d000000b0033b470f628emr4879054wrt.24.1707758080461;
        Mon, 12 Feb 2024 09:14:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXvMXdtxJsnHKm+fan5sZ2mUa+ZAA98EJlkSU00ERT3nIweUyZB1UJDQ4oJ8WwoFOjtOXRYmMsqixZYaiwTvN7Ffwk/7GEV9bM5pSi6spJwpc4cjDssFHd/U1iJEZfZzofGnpacycFzlLPszS4R3EXxTyw736n3AlyK1YjQ25t5+NCjjTXBWt+KO0PmJ7ypDotH8yaxFEERHNC8E291rpkLttr4Q0rBrf/dev5/D90uWbGOrwPleQiAE4CNi+iSp4QYObO8CcWfEfZMegAkpnjbhHS33hbNyjQ9SE/tA/M9T8TOenHsml+260ajsEwNsDyP9skjM4OCQVGcoELTuWYSeimqNNG9AeLSmHeaTic+TH/iKaZSd9KHudupAeUY58/t23WRL/ZPhlf/TyQN9ONj2vkswBGQAyvo/4n42mbTGNMWWiCrcSdGHQQCbCPKG3jynFB8xUhnCNrx4IqLLgC8wkLoiVHC5BSE4aMFKIkFv5B9P/4NXTyOwtk/n0Ot31SJQ8dmtpdeJpJQ0+2Ez7H7w0/eQzH/YdtuU07QQt3FC8Y2iOTU+6xDMcOoC/4Ku8Xu98bjfAGlZSyV1Sa2i1f9t5IiREsoRMaq
Received: from ?IPV6:2a01:e0a:982:cbb0:fcee:f026:296d:135f? ([2a01:e0a:982:cbb0:fcee:f026:296d:135f])
        by smtp.gmail.com with ESMTPSA id e9-20020a056000120900b0033ae54cdd97sm7275866wrx.100.2024.02.12.09.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 09:14:40 -0800 (PST)
Message-ID: <82b074b3-6ae1-4e00-8648-8dd938d6e334@linaro.org>
Date: Mon, 12 Feb 2024 18:14:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 08/20] drivers: crypto: meson: cleanup defines
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
 <20240212135108.549755-9-avromanov@salutedevices.com>
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
In-Reply-To: <20240212135108.549755-9-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/02/2024 14:50, Alexey Romanov wrote:
> It is bad to use hardcoded values directly in the code.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/crypto/amlogic/amlogic-gxl-cipher.c | 24 ++++++++++-----------
>   drivers/crypto/amlogic/amlogic-gxl.h        | 16 ++++++++------
>   2 files changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> index bc3092a8a2c2..c662c4b86e97 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> @@ -141,8 +141,8 @@ static int meson_cipher(struct skcipher_request *areq)
>   						 ivsize, 0);
>   		}
>   	}
> -	if (keyivlen == 24)
> -		keyivlen = 32;
> +	if (keyivlen == AES_KEYSIZE_192)
> +		keyivlen = AES_MAX_KEY_SIZE;
>   
>   	phykeyiv = dma_map_single(mc->dev, bkeyiv, keyivlen,
>   				  DMA_TO_DEVICE);
> @@ -161,7 +161,7 @@ static int meson_cipher(struct skcipher_request *areq)
>   		todo = min(keyivlen - eat, 16u);
>   		desc->t_src = cpu_to_le32(phykeyiv + i * 16);
>   		desc->t_dst = cpu_to_le32(i * 16);
> -		v = (MODE_KEY << 20) | DESC_OWN | 16;
> +		v = DESC_MODE_KEY | DESC_OWN | 16;
>   		desc->t_status = cpu_to_le32(v);
>   
>   		eat += todo;
> @@ -205,7 +205,7 @@ static int meson_cipher(struct skcipher_request *areq)
>   		desc->t_src = cpu_to_le32(sg_dma_address(src_sg));
>   		desc->t_dst = cpu_to_le32(sg_dma_address(dst_sg));
>   		todo = min(len, sg_dma_len(src_sg));
> -		v = (op->keymode << 20) | DESC_OWN | todo | (algt->blockmode << 26);
> +		v = op->keymode | DESC_OWN | todo | algt->blockmode;
>   		if (rctx->op_dir)
>   			v |= DESC_ENCRYPTION;
>   		len -= todo;
> @@ -348,14 +348,14 @@ static int meson_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
>   	struct meson_dev *mc = op->mc;
>   
>   	switch (keylen) {
> -	case 128 / 8:
> -		op->keymode = MODE_AES_128;
> +	case AES_KEYSIZE_128:
> +		op->keymode = DESC_MODE_AES_128;
>   		break;
> -	case 192 / 8:
> -		op->keymode = MODE_AES_192;
> +	case AES_KEYSIZE_192:
> +		op->keymode = DESC_MODE_AES_192;
>   		break;
> -	case 256 / 8:
> -		op->keymode = MODE_AES_256;
> +	case AES_KEYSIZE_256:
> +		op->keymode = DESC_MODE_AES_256;
>   		break;
>   	default:
>   		dev_dbg(mc->dev, "ERROR: Invalid keylen %u\n", keylen);
> @@ -373,7 +373,7 @@ static int meson_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
>   static struct meson_alg_template algs[] = {
>   {
>   	.type = CRYPTO_ALG_TYPE_SKCIPHER,
> -	.blockmode = MESON_OPMODE_CBC,
> +	.blockmode = DESC_OPMODE_CBC,
>   	.alg.skcipher.base = {
>   		.base = {
>   			.cra_name = "cbc(aes)",
> @@ -402,7 +402,7 @@ static struct meson_alg_template algs[] = {
>   },
>   {
>   	.type = CRYPTO_ALG_TYPE_SKCIPHER,
> -	.blockmode = MESON_OPMODE_ECB,
> +	.blockmode = DESC_OPMODE_ECB,
>   	.alg.skcipher.base = {
>   		.base = {
>   			.cra_name = "ecb(aes)",
> diff --git a/drivers/crypto/amlogic/amlogic-gxl.h b/drivers/crypto/amlogic/amlogic-gxl.h
> index 0a03e8144977..a0d83c82906d 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl.h
> +++ b/drivers/crypto/amlogic/amlogic-gxl.h
> @@ -11,19 +11,21 @@
>   #include <linux/crypto.h>
>   #include <linux/scatterlist.h>
>   
> -#define MODE_KEY 1
> -#define MODE_AES_128 0x8
> -#define MODE_AES_192 0x9
> -#define MODE_AES_256 0xa
> -
>   #define MESON_DECRYPT 0
>   #define MESON_ENCRYPT 1
>   
> -#define MESON_OPMODE_ECB 0
> -#define MESON_OPMODE_CBC 1
> +#define DESC_MODE_KEY (0x1 << 20)
> +#define DESC_MODE_AES_128 (0x8 << 20)
> +#define DESC_MODE_AES_192 (0x9 << 20)
> +#define DESC_MODE_AES_256 (0xa << 20)


>   
>   #define MAXDESC 64
>   
> +#define DESC_OPMODE_ECB (0 << 26)
> +#define DESC_OPMODE_CBC (1 << 26)
> +
> +#define DESC_MAXLEN ((1 << 17) - 1)

GENMASK(16, 0) ?

> +
>   #define DESC_LAST BIT(18)
>   #define DESC_ENCRYPTION BIT(28)
>   #define DESC_OWN BIT(31)

Anyway:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

