Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8736793FB3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240419AbjIFOzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242017AbjIFOzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:55:45 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10CF1BE9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 07:55:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-402cc6b8bedso33389985e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694012108; x=1694616908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K2Wn4ae4ktta97Pgw/pk1HevY2o9bgfbLOIPVEo+6uo=;
        b=d/20ieqOmCDaPOBHI5HzBx1R/swyM8GY6v11VVFpDkW3NNAbvKWmSvxoDM2DjG/uQ8
         4o4Fdews30yY13hAzrEpbnyYLs6nPDU/FXIuIaSFg5PD1qG+OhMFJbRC/JrgPMPqm4+K
         uyQU9pQL6wnc6VFPx/Qt6QJOgyEhIsdPJsJnvwAoW9WNKvdjlQ2n1+/xq8Rv63qsbvPR
         FmUGrHwVx3/QbYZW6uqnj2if8uwJlrURzHMKmOTt/HJMEZ1DWI2Z1bupLFhj7yYSYRLl
         dST78zLB5yfC0q9BbYwKtKnWzKd7iSbOP8ZY4rpq7n77Px8RrsEqbhYwpv1n7LSnLmyo
         zePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694012108; x=1694616908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2Wn4ae4ktta97Pgw/pk1HevY2o9bgfbLOIPVEo+6uo=;
        b=XwB4MPPp2yvbOYsJaW+2tWB6xMG3BcOACUJrJ583LOSetICeVth21/LyTNFtT+Sjur
         B8QKQm9p8MBCAG27+hUHIspXBkZeHzu6OOILe3B87KrOpodHmq7T8wwcnpJEXKbz9DOA
         z62K+hAvT4KLDU7wZJqCCAWHkhbkwth9m5qAhgoQwdHTcw2qlkh+ab7oDux4jnqhO3kF
         bh1+vaWyezztcSpYj32h886p0BYKoloSlJS1wNhl3FC1jlJF+9jOSwy1gf5QKoBJ4xy9
         BzJcusZEHMzsM1/oOXifP3gDUyoaRSB26QvRAnzDvpoNUouEtVU4uZ5gF6TCs+vqSOYE
         WbOg==
X-Gm-Message-State: AOJu0YwAdIMdSXqDXZo/vlPi5S1HNEE1m6tlbGShFzqadOEzm21tUMwj
        +hT7ENKskVYnph0SmGK3+S/t/Q==
X-Google-Smtp-Source: AGHT+IE3K0yYjy7mbycfqUP/NML0G6BqwnctmDjHglxipAfPndVh7dADzkl2VD+yuxfLkpcQLHcjkA==
X-Received: by 2002:a7b:ce94:0:b0:401:b652:b6cf with SMTP id q20-20020a7bce94000000b00401b652b6cfmr2442432wmj.13.1694012107951;
        Wed, 06 Sep 2023 07:55:07 -0700 (PDT)
Received: from [192.168.0.107] ([79.115.63.137])
        by smtp.gmail.com with ESMTPSA id y23-20020a7bcd97000000b003fbc9d178a8sm23501217wmj.4.2023.09.06.07.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 07:55:07 -0700 (PDT)
Message-ID: <530942be-4175-43d5-a111-c433be7eff72@linaro.org>
Date:   Wed, 6 Sep 2023 15:55:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/41] mtd: spi-nor: drop .parse_sfdp
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-11-291a0f39f8d8@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v2-11-291a0f39f8d8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/23 08:09, Michael Walle wrote:
> Drop the size parameter to indicate we need to do SFDP, we can do that
> because it is guaranteed that the size will be set by SFDP and because
> PARSE_SFDP forced the SFDP parsing it must be overwritten.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  drivers/mtd/spi-nor/core.c       |  3 +--
>  drivers/mtd/spi-nor/core.h       | 23 ++++++++++++++++-------
>  drivers/mtd/spi-nor/eon.c        |  3 +--
>  drivers/mtd/spi-nor/gigadevice.c |  3 +--
>  drivers/mtd/spi-nor/issi.c       |  4 +---
>  drivers/mtd/spi-nor/macronix.c   |  1 -
>  drivers/mtd/spi-nor/spansion.c   | 12 ------------
>  drivers/mtd/spi-nor/sst.c        |  1 -
>  drivers/mtd/spi-nor/winbond.c    |  7 ++-----
>  9 files changed, 22 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 368851ff9f40..4ba1778eda4b 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2017,7 +2017,6 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
>  
>  static const struct flash_info spi_nor_generic_flash = {
>  	.name = "spi-nor-generic",
> -	.parse_sfdp = true,
>  };
>  
>  static const struct flash_info *spi_nor_match_id(struct spi_nor *nor,
> @@ -3069,7 +3068,7 @@ static int spi_nor_init_params(struct spi_nor *nor)
>  
>  	spi_nor_init_default_params(nor);
>  
> -	if (nor->info->parse_sfdp) {
> +	if (spi_nor_needs_sfdp(nor)) {
>  		ret = spi_nor_parse_sfdp(nor);
>  		if (ret) {
>  			dev_err(nor->dev, "BFPT parsing failed. Please consider using SPI_NOR_SKIP_SFDP when declaring the flash\n");
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index fba3ea8536a5..9e6ad02b03b0 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -460,9 +460,6 @@ struct spi_nor_fixups {
>   * @page_size:      (optional) the flash's page size. Defaults to 256.
>   * @addr_nbytes:    number of address bytes to send.
>   *
> - * @parse_sfdp:     true when flash supports SFDP tables. The false value has no
> - *                  meaning. If one wants to skip the SFDP tables, one should
> - *                  instead use the SPI_NOR_SKIP_SFDP sfdp_flag.
>   * @flags:          flags that indicate support that is not defined by the
>   *                  JESD216 standard in its SFDP tables. Flag meanings:
>   *   SPI_NOR_HAS_LOCK:        flash supports lock/unlock via SR
> @@ -521,7 +518,6 @@ struct flash_info {
>  	u8 n_banks;
>  	u8 addr_nbytes;
>  
> -	bool parse_sfdp;
>  	u16 flags;
>  #define SPI_NOR_HAS_LOCK		BIT(0)
>  #define SPI_NOR_HAS_TB			BIT(1)
> @@ -598,9 +594,6 @@ struct flash_info {
>  			.n_regions = (_n_regions),			\
>  		},
>  
> -#define PARSE_SFDP							\
> -	.parse_sfdp = true,						\
> -
>  #define FLAGS(_flags)							\
>  		.flags = (_flags),					\
>  
> @@ -740,6 +733,22 @@ static inline struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
>  	return container_of(mtd, struct spi_nor, mtd);
>  }
>  
> +/**
> + * spi_nor_needs_sfdp() - returns true if SFDP parsing is used for this flash.
> + *
> + * Return: true if SFDP parsing is needed
> + */
> +static inline bool spi_nor_needs_sfdp(const struct spi_nor *nor)
> +{
> +	/*
> +	 * The flash size is one property parsed by the SFDP. We use it as an
> +	 * indicator whether we need SFDP parsing for a particular flash. I.e.
> +	 * non-legacy flash entries in flash_info will have a size of zero iff
> +	 * SFDP should be used.
> +	 */
> +	return nor->info->size;

the condition looks broken. the method returns bool, but here you return
size_t probably. And when size is zero one shall parse sfdp, not the
other way around.

maybe return (nor->info->size == 0)?

> +}
> +
>  #ifdef CONFIG_DEBUG_FS
>  void spi_nor_debugfs_register(struct spi_nor *nor);
>  void spi_nor_debugfs_shutdown(void);
> diff --git a/drivers/mtd/spi-nor/eon.c b/drivers/mtd/spi-nor/eon.c
> index 50a11053711f..434aaf155856 100644
> --- a/drivers/mtd/spi-nor/eon.c
> +++ b/drivers/mtd/spi-nor/eon.c
> @@ -25,8 +25,7 @@ static const struct flash_info eon_nor_parts[] = {
>  	{ "en25qh64",   INFO(0x1c7017, 0, 64 * 1024,  128)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ) },
>  	{ "en25qh128",  INFO(0x1c7018, 0, 64 * 1024,  256) },
> -	{ "en25qh256",  INFO(0x1c7019, 0, 64 * 1024,  512)
> -		PARSE_SFDP },
> +	{ "en25qh256",  INFO(0x1c7019, 0, 64 * 1024,  0) },
>  	{ "en25s64",	INFO(0x1c3817, 0, 64 * 1024,  128)
>  		NO_SFDP_FLAGS(SECT_4K) },
>  };
> diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
> index d57ddaf1525b..7cf142c75529 100644
> --- a/drivers/mtd/spi-nor/gigadevice.c
> +++ b/drivers/mtd/spi-nor/gigadevice.c
> @@ -62,8 +62,7 @@ static const struct flash_info gigadevice_nor_parts[] = {
>  		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>  			      SPI_NOR_QUAD_READ) },
> -	{ "gd25q256", INFO(0xc84019, 0, 64 * 1024, 512)
> -		PARSE_SFDP
> +	{ "gd25q256", INFO(0xc84019, 0, 64 * 1024, 0)
>  		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6)
>  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
>  		.fixups = &gd25q256_fixups },
> diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
> index accdf7aa2bfd..9d22b799ce94 100644
> --- a/drivers/mtd/spi-nor/issi.c
> +++ b/drivers/mtd/spi-nor/issi.c
> @@ -62,8 +62,7 @@ static const struct flash_info issi_nor_parts[] = {
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ) },
>  	{ "is25lp128",  INFO(0x9d6018, 0, 64 * 1024, 256)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ) },
> -	{ "is25lp256",  INFO(0x9d6019, 0, 64 * 1024, 512)
> -		PARSE_SFDP
> +	{ "is25lp256",  INFO(0x9d6019, 0, 64 * 1024, 0)
>  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
>  		.fixups = &is25lp256_fixups },
>  	{ "is25wp032",  INFO(0x9d7016, 0, 64 * 1024,  64)
> @@ -73,7 +72,6 @@ static const struct flash_info issi_nor_parts[] = {
>  	{ "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "is25wp256", INFO(0x9d7019, 0, 0, 0)
> -		PARSE_SFDP
>  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
>  		FLAGS(SPI_NOR_QUAD_PP)
>  		.fixups = &is25lp256_fixups },
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index eb149e517c1f..0f3bd3ed8eff 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -83,7 +83,6 @@ static const struct flash_info macronix_nor_parts[] = {
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
>  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
>  	{ "mx25uw51245g", INFOB(0xc2813a, 0, 0, 0, 4)
> -		PARSE_SFDP
>  		FLAGS(SPI_NOR_RWW) },
>  	{ "mx25v8035f",  INFO(0xc22314, 0, 64 * 1024,  16)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
> index 709822fced86..e6468569f178 100644
> --- a/drivers/mtd/spi-nor/spansion.c
> +++ b/drivers/mtd/spi-nor/spansion.c
> @@ -849,59 +849,47 @@ static const struct flash_info spansion_nor_parts[] = {
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
>  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
>  	{ "s25fs256t",  INFO6(0x342b19, 0x0f0890, 0, 0)
> -		PARSE_SFDP
>  		MFR_FLAGS(USE_CLPEF)
>  		.fixups = &s25fs256t_fixups },
>  	{ "s25hl512t",  INFO6(0x342a1a, 0x0f0390, 0, 0)
> -		PARSE_SFDP
>  		MFR_FLAGS(USE_CLPEF)
>  		.fixups = &s25hx_t_fixups },
>  	{ "s25hl01gt",  INFO6(0x342a1b, 0x0f0390, 0, 0)
> -		PARSE_SFDP
>  		MFR_FLAGS(USE_CLPEF)
>  		.fixups = &s25hx_t_fixups },
>  	{ "s25hl02gt",  INFO6(0x342a1c, 0x0f0090, 0, 0)
> -		PARSE_SFDP
>  		MFR_FLAGS(USE_CLPEF)
>  		FLAGS(NO_CHIP_ERASE)
>  		.fixups = &s25hx_t_fixups },
>  	{ "s25hs512t",  INFO6(0x342b1a, 0x0f0390, 0, 0)
> -		PARSE_SFDP
>  		MFR_FLAGS(USE_CLPEF)
>  		.fixups = &s25hx_t_fixups },
>  	{ "s25hs01gt",  INFO6(0x342b1b, 0x0f0390, 0, 0)
> -		PARSE_SFDP
>  		MFR_FLAGS(USE_CLPEF)
>  		.fixups = &s25hx_t_fixups },
>  	{ "s25hs02gt",  INFO6(0x342b1c, 0x0f0090, 0, 0)
> -		PARSE_SFDP
>  		MFR_FLAGS(USE_CLPEF)
>  		FLAGS(NO_CHIP_ERASE)
>  		.fixups = &s25hx_t_fixups },
>  	{ "cy15x104q",  INFO6(0x042cc2, 0x7f7f7f, 512 * 1024, 1)
>  		FLAGS(SPI_NOR_NO_ERASE) },
>  	{ "s28hl512t",   INFO(0x345a1a,      0, 0, 0)
> -		PARSE_SFDP
>  		MFR_FLAGS(USE_CLPEF)
>  		.fixups = &s28hx_t_fixups,
>  	},
>  	{ "s28hl01gt",   INFO(0x345a1b,      0, 0, 0)
> -		PARSE_SFDP
>  		MFR_FLAGS(USE_CLPEF)
>  		.fixups = &s28hx_t_fixups,
>  	},
>  	{ "s28hs512t",   INFO(0x345b1a,      0, 0, 0)
> -		PARSE_SFDP
>  		MFR_FLAGS(USE_CLPEF)
>  		.fixups = &s28hx_t_fixups,
>  	},
>  	{ "s28hs01gt",   INFO(0x345b1b,      0, 0, 0)
> -		PARSE_SFDP
>  		MFR_FLAGS(USE_CLPEF)
>  		.fixups = &s28hx_t_fixups,
>  	},
>  	{ "s28hs02gt",   INFO(0x345b1c,      0, 0, 0)
> -		PARSE_SFDP
>  		MFR_FLAGS(USE_CLPEF)
>  		.fixups = &s28hx_t_fixups,
>  	},
> diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
> index 197d2c1101ed..57df68eab6aa 100644
> --- a/drivers/mtd/spi-nor/sst.c
> +++ b/drivers/mtd/spi-nor/sst.c
> @@ -115,7 +115,6 @@ static const struct flash_info sst_nor_parts[] = {
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ) },
>  	{ "sst26vf032b", INFO(0xbf2642, 0, 0, 0)
>  		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
> -		PARSE_SFDP
>  		.fixups = &sst26vf_nor_fixups },
>  	{ "sst26vf064b", INFO(0xbf2643, 0, 64 * 1024, 128)
>  		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index cd99c9a1c568..c21fed842762 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -126,8 +126,7 @@ static const struct flash_info winbond_nor_parts[] = {
>  	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
>  		.fixups = &w25q256_fixups },
> -	{ "w25q256jvm", INFO(0xef7019, 0, 64 * 1024, 512)
> -		PARSE_SFDP },
> +	{ "w25q256jvm", INFO(0xef7019, 0, 64 * 1024, 0) },
>  	{ "w25q256jw", INFO(0xef6019, 0, 64 * 1024, 512)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>  			      SPI_NOR_QUAD_READ) },
> @@ -135,10 +134,8 @@ static const struct flash_info winbond_nor_parts[] = {
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ |
>  			      SPI_NOR_DUAL_READ) },
>  	{ "w25q512nwq", INFO(0xef6020, 0, 0, 0)
> -		PARSE_SFDP
>  		OTP_INFO(256, 3, 0x1000, 0x1000) },
> -	{ "w25q512nwm", INFO(0xef8020, 0, 64 * 1024, 1024)
> -		PARSE_SFDP
> +	{ "w25q512nwm", INFO(0xef8020, 0, 64 * 1024, 0)
>  		OTP_INFO(256, 3, 0x1000, 0x1000) },
>  	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> 
