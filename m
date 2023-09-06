Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3AC793662
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjIFHg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjIFHgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:36:55 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49697CC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:36:51 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso56899531fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 00:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693985809; x=1694590609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T3kMRwBIHC7L8+hEho76HheQRei1P0MX42m7+GGNLw4=;
        b=odv+/W4S4i8N7vLBdQntAbSnrFb7TojpK7a6zcqarTPsF78qSYkCBBNfdXidQsiGMo
         niPy6OO+LjhHYr1TlCv+RAtepSuw6kqFdwuQzlRoErC6u3DgGE/k0tmVXulY+V2JQ11j
         6fXEeoTd/bNKKYvQl3Jqce7P7k12BDG6GZGo3NmbZy7CVZZPL5fzpN1c3qbUkERtUwW/
         /dVwnr1TOEsc4WdNS565jWMP4DC87swBe0+DVphp9K+8wc/wyBO3JGkyiOLObFLFr2f+
         Ph3UvuVhpDrea9QpysbT9dvsDyh0GdZ9NDcYqLCtGGfJ50wm7NZmSB6WlU2OsHgTDJE8
         slVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693985809; x=1694590609;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3kMRwBIHC7L8+hEho76HheQRei1P0MX42m7+GGNLw4=;
        b=CGixS8fg+hvpmXfrcaZmzO4QIzqvanLBjU7P8NLoXb4IzQ1R8Qd+cOStfJLgkiEl9V
         KqBqrn4Lih6KObuffQ3tO/uNK3BXpsEHjsYoGhXrqeI0znzEioamubRnE6uVxeehia3R
         gZAkdxVJCtxjRTMelvS9ucKOsDVSKYbZItizlOiyOSNNpRSQOU44Qm9ePvm3AQ/TtJQT
         ZOqWeCBi4IrZf40hd2OqxUJs3ryiw39rGU/YS8DyFghUhKXfbLKkQ/b/JaC7yOCLl0RZ
         xBxo0kcUVBdt3Ov7+CEX1hwcUaAEgv24mZai/HJAuiN62nxvKQWpt2y26oHUfTcDn5Xn
         6clw==
X-Gm-Message-State: AOJu0Yz+LjBQ9djl6BfTut3vfOAYJfSZwKm7t4bLaNvDDlP533WyV6Cp
        32FNZoTkyNwwimr8c8HCystbFetUnWog5JunTKE=
X-Google-Smtp-Source: AGHT+IF0P5fI6+5e3fP2lk2EB2fGR+1oTVzbbUKz9IKexLEKvu26Dsutoepc01lrH+mHTeAdv6rGPg==
X-Received: by 2002:a2e:3e1a:0:b0:2be:5b09:5544 with SMTP id l26-20020a2e3e1a000000b002be5b095544mr1417388lja.27.1693985809487;
        Wed, 06 Sep 2023 00:36:49 -0700 (PDT)
Received: from [192.168.0.173] ([79.115.63.137])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6844000000b003197b85bad2sm19652385wrw.79.2023.09.06.00.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 00:36:49 -0700 (PDT)
Message-ID: <eec52fd8-663d-7e56-3627-2b33259027b6@linaro.org>
Date:   Wed, 6 Sep 2023 10:36:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 39/41] mtd: spi-nor: winbond: sort flash_info entries
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-39-291a0f39f8d8@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <20230807-mtd-flash-info-db-rework-v2-39-291a0f39f8d8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.08.2023 10:09, Michael Walle wrote:
> The flash ID is the new primary key into our database. Sort the entry by
> it. Keep the most specific ones first, because there might be ID
> collisions between shorter and longer ones.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>

I'm fine with the sorting by ID.


Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/mtd/spi-nor/winbond.c | 166 +++++++++++++++++++++---------------------
>  1 file changed, 83 insertions(+), 83 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index 1f95c4ccecd9..6ce50c3f3c27 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -72,37 +72,25 @@ static const struct flash_info winbond_nor_parts[] = {
>  		.name = "w25x16",
>  		.size = SZ_2M,
>  		.no_sfdp_flags = SECT_4K,
> -	}, {
> -		.id = SNOR_ID(0xef, 0x60, 0x15),
> -		.name = "w25q16dw",
> -		.size = SZ_2M,
> -		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
> -		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>  	}, {
>  		.id = SNOR_ID(0xef, 0x30, 0x16),
>  		.name = "w25x32",
>  		.size = SZ_4M,
>  		.no_sfdp_flags = SECT_4K,
>  	}, {
> -		.id = SNOR_ID(0xef, 0x70, 0x15),
> -		.name = "w25q16jv-im/jm",
> -		.size = SZ_2M,
> -		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
> -		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> +		.id = SNOR_ID(0xef, 0x30, 0x17),
> +		.name = "w25x64",
> +		.size = SZ_8M,
> +		.no_sfdp_flags = SECT_4K,
>  	}, {
>  		.id = SNOR_ID(0xef, 0x40, 0x12),
>  		.name = "w25q20cl",
>  		.size = SZ_256K,
>  		.no_sfdp_flags = SECT_4K,
>  	}, {
> -		.id = SNOR_ID(0xef, 0x50, 0x12),
> -		.name = "w25q20bw",
> -		.size = SZ_256K,
> -		.no_sfdp_flags = SECT_4K,
> -	}, {
> -		.id = SNOR_ID(0xef, 0x60, 0x12),
> -		.name = "w25q20ew",
> -		.size = SZ_256K,
> +		.id = SNOR_ID(0xef, 0x40, 0x14),
> +		.name = "w25q80bl",
> +		.size = SZ_1M,
>  		.no_sfdp_flags = SECT_4K,
>  	}, {
>  		.id = SNOR_ID(0xef, 0x40, 0x16),
> @@ -110,57 +98,84 @@ static const struct flash_info winbond_nor_parts[] = {
>  		.size = SZ_4M,
>  		.no_sfdp_flags = SECT_4K,
>  	}, {
> -		.id = SNOR_ID(0xef, 0x60, 0x16),
> -		.name = "w25q32dw",
> -		.size = SZ_4M,
> +		.id = SNOR_ID(0xef, 0x40, 0x17),
> +		.name = "w25q64",
> +		.size = SZ_8M,
> +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> +	}, {
> +		.id = SNOR_ID(0xef, 0x40, 0x18),
> +		.name = "w25q128",
>  		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
> +	}, {
> +		.id = SNOR_ID(0xef, 0x40, 0x19),
> +		.name = "w25q256",
> +		.size = SZ_32M,
>  		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> -		.otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
> +		.fixups = &w25q256_fixups,
>  	}, {
> -		.id = SNOR_ID(0xef, 0x70, 0x16),
> -		.name = "w25q32jv",
> -		.size = SZ_4M,
> +		.id = SNOR_ID(0xef, 0x40, 0x20),
> +		.name = "w25q512jvq",
> +		.size = SZ_64M,
> +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> +	}, {
> +		.id = SNOR_ID(0xef, 0x50, 0x12),
> +		.name = "w25q20bw",
> +		.size = SZ_256K,
> +		.no_sfdp_flags = SECT_4K,
> +	}, {
> +		.id = SNOR_ID(0xef, 0x50, 0x14),
> +		.name = "w25q80",
> +		.size = SZ_1M,
> +		.no_sfdp_flags = SECT_4K,
> +	}, {
> +		.id = SNOR_ID(0xef, 0x60, 0x12),
> +		.name = "w25q20ew",
> +		.size = SZ_256K,
> +		.no_sfdp_flags = SECT_4K,
> +	}, {
> +		.id = SNOR_ID(0xef, 0x60, 0x15),
> +		.name = "w25q16dw",
> +		.size = SZ_2M,
>  		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
>  		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>  	}, {
> -		.id = SNOR_ID(0xef, 0x80, 0x16),
> -		.name = "w25q32jwm",
> +		.id = SNOR_ID(0xef, 0x60, 0x16),
> +		.name = "w25q32dw",
>  		.size = SZ_4M,
>  		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
>  		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>  		.otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
>  	}, {
> -		.id = SNOR_ID(0xef, 0x80, 0x17),
> -		.name = "w25q64jwm",
> +		.id = SNOR_ID(0xef, 0x60, 0x17),
> +		.name = "w25q64dw",
>  		.size = SZ_8M,
>  		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
>  		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>  	}, {
> -		.id = SNOR_ID(0xef, 0x80, 0x18),
> -		.name = "w25q128jwm",
> +		.id = SNOR_ID(0xef, 0x60, 0x18),
> +		.name = "w25q128fw",
>  		.size = SZ_16M,
>  		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
>  		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>  	}, {
> -		.id = SNOR_ID(0xef, 0x80, 0x19),
> -		.name = "w25q256jwm",
> +		.id = SNOR_ID(0xef, 0x60, 0x19),
> +		.name = "w25q256jw",
>  		.size = SZ_32M,
> -		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
>  		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>  	}, {
> -		.id = SNOR_ID(0xef, 0x30, 0x17),
> -		.name = "w25x64",
> -		.size = SZ_8M,
> -		.no_sfdp_flags = SECT_4K,
> +		.id = SNOR_ID(0xef, 0x60, 0x20),
> +		.name = "w25q512nwq",
> +		.otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
>  	}, {
> -		.id = SNOR_ID(0xef, 0x40, 0x17),
> -		.name = "w25q64",
> -		.size = SZ_8M,
> +		.id = SNOR_ID(0xef, 0x70, 0x15),
> +		.name = "w25q16jv-im/jm",
> +		.size = SZ_2M,
> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
>  		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>  	}, {
> -		.id = SNOR_ID(0xef, 0x60, 0x17),
> -		.name = "w25q64dw",
> -		.size = SZ_8M,
> +		.id = SNOR_ID(0xef, 0x70, 0x16),
> +		.name = "w25q32jv",
> +		.size = SZ_4M,
>  		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
>  		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>  	}, {
> @@ -168,64 +183,49 @@ static const struct flash_info winbond_nor_parts[] = {
>  		.name = "w25q64jvm",
>  		.size = SZ_8M,
>  		.no_sfdp_flags = SECT_4K,
> -	}, {
> -		.id = SNOR_ID(0xef, 0x60, 0x18),
> -		.name = "w25q128fw",
> -		.size = SZ_16M,
> -		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
> -		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>  	}, {
>  		.id = SNOR_ID(0xef, 0x70, 0x18),
>  		.name = "w25q128jv",
>  		.size = SZ_16M,
>  		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
>  		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> -	}, {
> -		.id = SNOR_ID(0xef, 0x50, 0x14),
> -		.name = "w25q80",
> -		.size = SZ_1M,
> -		.no_sfdp_flags = SECT_4K,
> -	}, {
> -		.id = SNOR_ID(0xef, 0x40, 0x14),
> -		.name = "w25q80bl",
> -		.size = SZ_1M,
> -		.no_sfdp_flags = SECT_4K,
> -	}, {
> -		.id = SNOR_ID(0xef, 0x40, 0x18),
> -		.name = "w25q128",
> -		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
> -	}, {
> -		.id = SNOR_ID(0xef, 0x40, 0x19),
> -		.name = "w25q256",
> -		.size = SZ_32M,
> -		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> -		.fixups = &w25q256_fixups,
>  	}, {
>  		.id = SNOR_ID(0xef, 0x70, 0x19),
>  		.name = "w25q256jvm",
> -	}, {
> -		.id = SNOR_ID(0xef, 0x60, 0x19),
> -		.name = "w25q256jw",
> -		.size = SZ_32M,
> -		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>  	}, {
>  		.id = SNOR_ID(0xef, 0x71, 0x19),
>  		.name = "w25m512jv",
>  		.size = SZ_64M,
>  		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>  	}, {
> -		.id = SNOR_ID(0xef, 0x60, 0x20),
> -		.name = "w25q512nwq",
> +		.id = SNOR_ID(0xef, 0x80, 0x16),
> +		.name = "w25q32jwm",
> +		.size = SZ_4M,
> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
> +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>  		.otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
> +	}, {
> +		.id = SNOR_ID(0xef, 0x80, 0x17),
> +		.name = "w25q64jwm",
> +		.size = SZ_8M,
> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
> +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> +	}, {
> +		.id = SNOR_ID(0xef, 0x80, 0x18),
> +		.name = "w25q128jwm",
> +		.size = SZ_16M,
> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
> +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> +	}, {
> +		.id = SNOR_ID(0xef, 0x80, 0x19),
> +		.name = "w25q256jwm",
> +		.size = SZ_32M,
> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
> +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>  	}, {
>  		.id = SNOR_ID(0xef, 0x80, 0x20),
>  		.name = "w25q512nwm",
>  		.otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
> -	}, {
> -		.id = SNOR_ID(0xef, 0x40, 0x20),
> -		.name = "w25q512jvq",
> -		.size = SZ_64M,
> -		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
>  	},
>  };
>  
> 
