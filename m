Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0F3793645
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbjIFH2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbjIFH2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:28:48 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8F1E73
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:28:33 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bceca8a41aso51378461fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 00:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693985312; x=1694590112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sH804PAO6K6nueJD7fM1RWcXVjnz7RQr9zhaW5ycbCE=;
        b=aiFW5LhqefmEWlkWKpQXn0ILBn3lcs+CyuEpuL6qLxT/jYjn8dBVDU5tEF3I6Bt6ub
         6NYqR5FlaBsTAhvoCiFotee/80NiCHvzL5zFlYgYwi/PZaA27BSurE27QOV9sKBEXYVF
         HBDMhrLJdw4IPj/y5uVBypsZvzYQZVYqNpXN2XCDT2ye0vilwF0TD9onTzBW+Jofe5O9
         hhKYyHh4BFiauLHYL2wCYhVUs199z67rpbIE+lRzED/YjUTBY5lfyLGXslmd5vlLoR9b
         FsCFFuqIOk7WkxhDnGsCl7lktxa3+wB8RjjLQyPIHwDZp4KEr4ELcqZwoIGXmkNGvKvZ
         Z0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693985312; x=1694590112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sH804PAO6K6nueJD7fM1RWcXVjnz7RQr9zhaW5ycbCE=;
        b=RpfwrU1VQyap+31ohWaejr9p96LhUdZP6jIsIh3I/qRNDEZC3Hp779Uw298yxpGn+W
         gcCJe2/FSX9xK1dOPzqsjAt3J/ZjwoJb6TYCnKccT4x33YdIH1VAqx9wAYGyQvSmdP/C
         nRP+1OgS5iRF2O0hxfjlh/I5olBjZf5maSiwMVNb7tskKWFN01B2ftRbWKt506Kk9xeK
         ux6Yjbwvw47/IKbNjHncyFD9yL9y6Kxqs4N1XsPMP+rLWFlYz6RAdBcgvj+HAkkIe/8t
         Kiwp2CP6kSlDk+LyqcZa0904vHRxabXr1TbqCNXC008YyeUZhz2shgic3i38TJnfMk4p
         CH2Q==
X-Gm-Message-State: AOJu0YxWOCiErsh7p9bfs2oZuSObCTjIRgvw2avrndgom/5Zo7mkk0gh
        szFCgv2p/jutrfQFL+ATPY2H7Q==
X-Google-Smtp-Source: AGHT+IF633tiLuLCHD8zLor1OyXkBgzjzGyZUC4gHP2/KbQqw7cJAf0phMBiV9pIlYouRjpdS3F1pA==
X-Received: by 2002:a2e:8554:0:b0:2bb:bfa5:b72c with SMTP id u20-20020a2e8554000000b002bbbfa5b72cmr1474653ljj.15.1693985312156;
        Wed, 06 Sep 2023 00:28:32 -0700 (PDT)
Received: from [192.168.0.173] ([79.115.63.137])
        by smtp.gmail.com with ESMTPSA id l5-20020adfe585000000b0031c71693449sm19485432wrm.1.2023.09.06.00.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 00:28:31 -0700 (PDT)
Message-ID: <68202daa-75a2-6c2f-7e32-aa9059a6057b@linaro.org>
Date:   Wed, 6 Sep 2023 10:28:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 16/41] mtd: spi-nor: remove or move flash_info comments
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-16-291a0f39f8d8@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v2-16-291a0f39f8d8@kernel.org>
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
> Most of the comments are a relict of the past when the flash_info was
> just one table. Most of them are useless. Remove them.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>


Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>


> ---
>  drivers/mtd/spi-nor/atmel.c    | 1 -
>  drivers/mtd/spi-nor/eon.c      | 1 -
>  drivers/mtd/spi-nor/esmt.c     | 1 -
>  drivers/mtd/spi-nor/everspin.c | 1 -
>  drivers/mtd/spi-nor/intel.c    | 1 -
>  drivers/mtd/spi-nor/issi.c     | 2 --
>  drivers/mtd/spi-nor/macronix.c | 1 -
>  drivers/mtd/spi-nor/spansion.c | 3 ---
>  drivers/mtd/spi-nor/sst.c      | 1 -
>  drivers/mtd/spi-nor/winbond.c  | 1 -
>  drivers/mtd/spi-nor/xmc.c      | 2 +-
>  11 files changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
> index 58968c1e7d2f..d2de2cb0c066 100644
> --- a/drivers/mtd/spi-nor/atmel.c
> +++ b/drivers/mtd/spi-nor/atmel.c
> @@ -163,7 +163,6 @@ static const struct spi_nor_fixups atmel_nor_global_protection_fixups = {
>  };
>  
>  static const struct flash_info atmel_nor_parts[] = {
> -	/* Atmel -- some are (confusingly) marketed as "DataFlash" */
>  	{ "at25fs010",  INFO(0x1f6601, 0, 32 * 1024,   4)
>  		FLAGS(SPI_NOR_HAS_LOCK)
>  		NO_SFDP_FLAGS(SECT_4K)
> diff --git a/drivers/mtd/spi-nor/eon.c b/drivers/mtd/spi-nor/eon.c
> index 434aaf155856..4848ffe8b38f 100644
> --- a/drivers/mtd/spi-nor/eon.c
> +++ b/drivers/mtd/spi-nor/eon.c
> @@ -9,7 +9,6 @@
>  #include "core.h"
>  
>  static const struct flash_info eon_nor_parts[] = {
> -	/* EON -- en25xxx */
>  	{ "en25f32",    INFO(0x1c3116, 0, 64 * 1024,   64)
>  		NO_SFDP_FLAGS(SECT_4K) },
>  	{ "en25p32",    INFO(0x1c2016, 0, 64 * 1024,   64) },
> diff --git a/drivers/mtd/spi-nor/esmt.c b/drivers/mtd/spi-nor/esmt.c
> index fcc3b0e7cda9..12779bec5f99 100644
> --- a/drivers/mtd/spi-nor/esmt.c
> +++ b/drivers/mtd/spi-nor/esmt.c
> @@ -9,7 +9,6 @@
>  #include "core.h"
>  
>  static const struct flash_info esmt_nor_parts[] = {
> -	/* ESMT */
>  	{ "f25l32pa", INFO(0x8c2016, 0, 64 * 1024, 64)
>  		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
>  		NO_SFDP_FLAGS(SECT_4K) },
> diff --git a/drivers/mtd/spi-nor/everspin.c b/drivers/mtd/spi-nor/everspin.c
> index 84a07c2e0536..d02c32f2f7ad 100644
> --- a/drivers/mtd/spi-nor/everspin.c
> +++ b/drivers/mtd/spi-nor/everspin.c
> @@ -9,7 +9,6 @@
>  #include "core.h"
>  
>  static const struct flash_info everspin_nor_parts[] = {
> -	/* Everspin */
>  	{ "mr25h128", CAT25_INFO(16 * 1024, 1, 256, 2) },
>  	{ "mr25h256", CAT25_INFO(32 * 1024, 1, 256, 2) },
>  	{ "mr25h10",  CAT25_INFO(128 * 1024, 1, 256, 3) },
> diff --git a/drivers/mtd/spi-nor/intel.c b/drivers/mtd/spi-nor/intel.c
> index 9179f2d09cba..aba62759a02e 100644
> --- a/drivers/mtd/spi-nor/intel.c
> +++ b/drivers/mtd/spi-nor/intel.c
> @@ -9,7 +9,6 @@
>  #include "core.h"
>  
>  static const struct flash_info intel_nor_parts[] = {
> -	/* Intel/Numonyx -- xxxs33b */
>  	{ "160s33b",  INFO(0x898911, 0, 64 * 1024,  32)
>  		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE) },
>  	{ "320s33b",  INFO(0x898912, 0, 64 * 1024,  64)
> diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
> index b936a28a85df..d31401bcab64 100644
> --- a/drivers/mtd/spi-nor/issi.c
> +++ b/drivers/mtd/spi-nor/issi.c
> @@ -47,7 +47,6 @@ static const struct spi_nor_fixups pm25lv_nor_fixups = {
>  };
>  
>  static const struct flash_info issi_nor_parts[] = {
> -	/* ISSI */
>  	{ "is25cd512",  INFO(0x7f9d20, 0, 32 * 1024,   2)
>  		NO_SFDP_FLAGS(SECT_4K) },
>  	{ "is25lq040b", INFO(0x9d4013, 0, 64 * 1024,   8)
> @@ -76,7 +75,6 @@ static const struct flash_info issi_nor_parts[] = {
>  		FLAGS(SPI_NOR_QUAD_PP)
>  		.fixups = &is25lp256_fixups },
>  
> -	/* PMC */
>  	{ "pm25lv512",   INFO0(32 * 1024,    2)
>  		NO_SFDP_FLAGS(SECT_4K)
>  		.fixups = &pm25lv_nor_fixups
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index 0f3bd3ed8eff..b21e688fe056 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -33,7 +33,6 @@ static const struct spi_nor_fixups mx25l25635_fixups = {
>  };
>  
>  static const struct flash_info macronix_nor_parts[] = {
> -	/* Macronix */
>  	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1)
>  		NO_SFDP_FLAGS(SECT_4K) },
>  	{ "mx25l2005a",  INFO(0xc22012, 0, 64 * 1024,   4)
> diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
> index d7012ab3de2c..1a1d2368c462 100644
> --- a/drivers/mtd/spi-nor/spansion.c
> +++ b/drivers/mtd/spi-nor/spansion.c
> @@ -756,9 +756,6 @@ static const struct spi_nor_fixups s25fs_s_nor_fixups = {
>  };
>  
>  static const struct flash_info spansion_nor_parts[] = {
> -	/* Spansion/Cypress -- single (large) sector size only, at least
> -	 * for the chips listed here (without boot sectors).
> -	 */
>  	{ "s25sl032p",  INFO(0x010215, 0x4d00,  64 * 1024,  64)
>  		NO_SFDP_FLAGS(SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "s25sl064p",  INFO(0x010216, 0x4d00,  64 * 1024, 128)
> diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
> index 57df68eab6aa..1e06c6841a18 100644
> --- a/drivers/mtd/spi-nor/sst.c
> +++ b/drivers/mtd/spi-nor/sst.c
> @@ -61,7 +61,6 @@ static const struct spi_nor_fixups sst26vf_nor_fixups = {
>  };
>  
>  static const struct flash_info sst_nor_parts[] = {
> -	/* SST -- large erase sizes are "overlays", "sectors" are 4K */
>  	{ "sst25vf040b", INFO(0xbf258d, 0, 64 * 1024,  8)
>  		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
>  		NO_SFDP_FLAGS(SECT_4K)
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index 7873cc394f07..2d3ae972b419 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -42,7 +42,6 @@ static const struct spi_nor_fixups w25q256_fixups = {
>  };
>  
>  static const struct flash_info winbond_nor_parts[] = {
> -	/* Winbond -- w25x "blocks" are 64K, "sectors" are 4KiB */
>  	{ "w25x05", INFO(0xef3010, 0, 64 * 1024,  1)
>  		NO_SFDP_FLAGS(SECT_4K) },
>  	{ "w25x10", INFO(0xef3011, 0, 64 * 1024,  2)
> diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
> index 051411e86339..48062ccb22fa 100644
> --- a/drivers/mtd/spi-nor/xmc.c
> +++ b/drivers/mtd/spi-nor/xmc.c
> @@ -9,7 +9,6 @@
>  #include "core.h"
>  
>  static const struct flash_info xmc_nor_parts[] = {
> -	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
>  	{ "XM25QH64A", INFO(0x207017, 0, 64 * 1024, 128)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>  			      SPI_NOR_QUAD_READ) },
> @@ -18,6 +17,7 @@ static const struct flash_info xmc_nor_parts[] = {
>  			      SPI_NOR_QUAD_READ) },
>  };
>  
> +/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
>  const struct spi_nor_manufacturer spi_nor_xmc = {
>  	.name = "xmc",
>  	.parts = xmc_nor_parts,
> 
