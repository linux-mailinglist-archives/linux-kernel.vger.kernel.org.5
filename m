Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE4E76460B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjG0FrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjG0Fq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:46:58 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148393C02
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:46:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bb893e6365so3446965ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436775; x=1691041575;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EUn9yYpipOsPEKP8WCT3aJstBvAywf03drnVcolpjFQ=;
        b=T0m50/Ab2Zy9M/PiC+pYMHYO68NQ8ZURcm02JQndKWBBa5y5sZNk5CBcNEshS5mD1n
         3kp82ZVL3VL2TaBNU7kE6X1JB8CXnCzmpOhquDiQw/4sAqwh1S84fXd0Il9ihjO6A7T9
         CH1SxbDnOjBqMFaKEzYT9PY/VxS1fIv1FkSXcN+eC200RaqVn2cJ/l1SAZj/iP+EPguh
         76ZeAF3KtsB0HIXSCHaSxdL6dn68SZ/N7K4bnD/eCg4izDDP3BR+Ry4EveGb1V6ALBS+
         sliowhwvrgWtsoTYdGFcpGUBBVeS1pkkw+moKE+WK5jaefGvvkogR+VuPdlcsyEGEf4R
         8mdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436775; x=1691041575;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUn9yYpipOsPEKP8WCT3aJstBvAywf03drnVcolpjFQ=;
        b=botP9AHfZdg9aZVHVSX1CtEIS6UpR8jd5kbULkHOwUubQZ4834HKtKQQJGABPAaQ+P
         1a/cg/1I/hgF+hcmqWTK+DcHgcwtYW0UzaU5q3hpqD4i66VsnoEC1p6s+1dZN+NPiyk5
         TucuYsHT48/25/xW2OYvGvzKDMwPHoxzu9aVpGo7x3G7VlDQxHn3nKBpTwtqwHWyQTCJ
         4SUqLevdaEw9jo4CERR6yoZjC59s3nJhRBAxHwPfp3UNiWqKQI4WLBcZWY25pG1RGYTF
         B7txpEA5OKUCRtdQ4YvnUqrIEL5WFzV8DkLZTjrL6eTi2CPV4zdsigJ75gXxZz3cT4g1
         p12g==
X-Gm-Message-State: ABy/qLYYidpF4KSW+mu44zjX2Qt61PD1FKHXdPQDrEB0crsbX3f3cOu3
        2GkozqbUURMQuc0Wa3jYqsyC5g==
X-Google-Smtp-Source: APBJJlE3Ta64vctib96xNN471wnaq/5n6QG87YGVu++oTzT/S44ftJCxLMUGZn/ELwioFYqemFntnQ==
X-Received: by 2002:a17:902:7882:b0:1b8:59f0:c748 with SMTP id q2-20020a170902788200b001b859f0c748mr3620942pll.2.1690436774805;
        Wed, 26 Jul 2023 22:46:14 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id jn13-20020a170903050d00b001b895a17429sm560862plb.280.2023.07.26.22.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 22:46:14 -0700 (PDT)
Message-ID: <3202ac5b-a697-64b0-375c-d2ae2aa9ffdd@tuxon.dev>
Date:   Thu, 27 Jul 2023 08:46:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] crypto: drivers - avoid memcpy size warning
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Ayush Sawal <ayush.sawal@chelsio.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Yangtao Li <frank.li@vivo.com>,
        Sergiu Moga <sergiu.moga@microchip.com>,
        Ryan Wanner <Ryan.Wanner@microchip.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230724135327.1173309-1-arnd@kernel.org>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230724135327.1173309-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.07.2023 16:53, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Some configurations with gcc-12 or gcc-13 produce a warning for the source
> and destination of a memcpy() in atmel_sha_hmac_compute_ipad_hash() potentially
> overlapping:
> 
> In file included from include/linux/string.h:254,
>                   from drivers/crypto/atmel-sha.c:15:
> drivers/crypto/atmel-sha.c: In function 'atmel_sha_hmac_compute_ipad_hash':
> include/linux/fortify-string.h:57:33: error: '__builtin_memcpy' accessing 129 or more bytes at offsets 408 and 280 overlaps 1 or more bytes at offset 408 [-Werror=restrict]
>     57 | #define __underlying_memcpy     __builtin_memcpy
>        |                                 ^
> include/linux/fortify-string.h:648:9: note: in expansion of macro '__underlying_memcpy'
>    648 |         __underlying_##op(p, q, __fortify_size);                        \
>        |         ^~~~~~~~~~~~~
> include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
>    693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>        |                          ^~~~~~~~~~~~~~~~~~~~
> drivers/crypto/atmel-sha.c:1773:9: note: in expansion of macro 'memcpy'
>   1773 |         memcpy(hmac->opad, hmac->ipad, bs);
>        |         ^~~~~~
> 
> The same thing happens in two more drivers that have the same logic:
> 
> drivers/crypto/chelsio/chcr_algo.c: In function 'chcr_ahash_setkey':
> include/linux/fortify-string.h:57:33: error: '__builtin_memcpy' accessing 129 or more bytes at offsets 260 and 132 overlaps 1 or more bytes at offset 260 [-Werror=restrict]
> drivers/crypto/bcm/cipher.c: In function 'ahash_hmac_setkey':
> include/linux/fortify-string.h:57:33: error: '__builtin_memcpy' accessing between 129 and 4294967295 bytes at offsets 840 and 712 overlaps between 1 and 4294967167 bytes at offset 840 [-Werror=restrict]
> 
> I don't think it can actually happen because the size is strictly bounded
> to the available block sizes, at most 128 bytes, though inlining decisions
> could lead gcc to not see that.
> 
> Add an explicit size check to make sure gcc also sees this function is safe
> regardless of inlining.
> 
> Note that the -Wrestrict warning is currently disabled by default, but it
> would be nice to finally enable it, and these are the only false
> postives that I see at the moment. There are 9 other crypto drivers that
> also use an identical memcpy() but don't show up in randconfig build
> warnings for me, presumably because of different inlining decisions.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev> # atmel-sha

> ---
>   drivers/crypto/atmel-sha.c         | 3 +++
>   drivers/crypto/bcm/cipher.c        | 3 +++
>   drivers/crypto/chelsio/chcr_algo.c | 3 +++
>   3 files changed, 9 insertions(+)
> 
> diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
> index f2031f934be95..52a3c81b3a05a 100644
> --- a/drivers/crypto/atmel-sha.c
> +++ b/drivers/crypto/atmel-sha.c
> @@ -1770,6 +1770,9 @@ static int atmel_sha_hmac_compute_ipad_hash(struct atmel_sha_dev *dd)
>   	size_t bs = ctx->block_size;
>   	size_t i, num_words = bs / sizeof(u32);
>   
> +	if (bs > sizeof(hmac->opad))
> +		return -EINVAL;
> +
>   	memcpy(hmac->opad, hmac->ipad, bs);
>   	for (i = 0; i < num_words; ++i) {
>   		hmac->ipad[i] ^= 0x36363636;
> diff --git a/drivers/crypto/bcm/cipher.c b/drivers/crypto/bcm/cipher.c
> index 70b911baab26d..8633ca0286a10 100644
> --- a/drivers/crypto/bcm/cipher.c
> +++ b/drivers/crypto/bcm/cipher.c
> @@ -2327,6 +2327,9 @@ static int ahash_hmac_setkey(struct crypto_ahash *ahash, const u8 *key,
>   		 __func__, ahash, key, keylen, blocksize, digestsize);
>   	flow_dump("  key: ", key, keylen);
>   
> +	if (blocksize > sizeof(ctx->opad))
> +		return -EINVAL;
> +
>   	if (keylen > blocksize) {
>   		switch (ctx->auth.alg) {
>   		case HASH_ALG_MD5:
> diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
> index 0eade4fa6695b..5c8e10ee010ff 100644
> --- a/drivers/crypto/chelsio/chcr_algo.c
> +++ b/drivers/crypto/chelsio/chcr_algo.c
> @@ -2201,6 +2201,9 @@ static int chcr_ahash_setkey(struct crypto_ahash *tfm, const u8 *key,
>   
>   	SHASH_DESC_ON_STACK(shash, hmacctx->base_hash);
>   
> +	if (bs > sizeof(hmacctx->opad))
> +		return -EINVAL;
> +
>   	/* use the key to calculate the ipad and opad. ipad will sent with the
>   	 * first request's data. opad will be sent with the final hash result
>   	 * ipad in hmacctx->ipad and opad in hmacctx->opad location
