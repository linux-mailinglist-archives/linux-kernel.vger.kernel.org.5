Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FB1793515
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 08:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241110AbjIFGCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 02:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjIFGCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 02:02:03 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC59CE5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 23:01:58 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so4646978a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 23:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693980117; x=1694584917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fmkd8VP9gXsmjmbSn6l4vGzj4ilqsiP27iDHTTduH9k=;
        b=J2gv4Xut1oCpmNubuph5FYpUFdbqA3syde2ua1u8HlPwWp5Rwz4gxtw2P69XcfMQhn
         mf6hJ53QhTEmuywe32VfdV41RIk0bGA0IgvYVNkheQwe7YcMx/VEtRMq6tGk2QkxkW2/
         iLDD4P3gZu66ossj6gJbKJVt8Snnq3TIvvb5iANjVZ0wZ9RyppXsGqV1jmRwbXociONw
         VUodc5mqeeqIwV32R2mdh/BMUKNRJn2FsANXPD2CM2OXG/3spLnoEhh9nvg1PPO0bH+x
         L9nqt4lC3lI7bMhVS3DH6HovuigCBMlYZIAbRZDXd7LUIulYuijB+mqvB02H5R5fOkz7
         /+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693980117; x=1694584917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fmkd8VP9gXsmjmbSn6l4vGzj4ilqsiP27iDHTTduH9k=;
        b=hMQq5ZRgm85SHv4HtXfRELIVp6rGWATiuSXoDEX2mYbitVvwylLlGeZJxfOTteWqH1
         kVKcZAKXmInfFNRXxQUjzAYSLQiwGUjNYdMaf4dwfEfc36EtVxlprGw4KGKZhQcui9jm
         AV4a72WsYvPhx6ywiwOVOBBQpB2ZQJYDLJ7lyJMFdyK5M6PKlYxZ5T0LhLaA8j4MlND2
         gRJhmWBKGxIhu8vUBRkd8VO/Nop8ddZeNoRMTH5CgOCR1eTzEnvPnNU8vf88BFSEmA8k
         jHSC0fUONkr9gZFPYxXh0h9/6GAMkb8/SBKTjgPgN4s+zbOOVECsjZ/g80jQF7Tf4WFG
         fgXw==
X-Gm-Message-State: AOJu0YzAUp2KKuoMWRyMdu6sOyIbPb7IIAIvfYtC8xzWC3PGb+RLUs0t
        xw7tZ37EL3KZmzt0cYrs71vlJQ==
X-Google-Smtp-Source: AGHT+IGxzsBJntuV2GhRqANudW/cEQMqixad9U6PRWIX16cjg27INOw+GO5ulnYLrYQKUACni/sXBg==
X-Received: by 2002:aa7:cf09:0:b0:522:cb97:f196 with SMTP id a9-20020aa7cf09000000b00522cb97f196mr1439220edy.36.1693980117219;
        Tue, 05 Sep 2023 23:01:57 -0700 (PDT)
Received: from [192.168.0.107] ([79.115.63.137])
        by smtp.gmail.com with ESMTPSA id r9-20020aa7d589000000b0052a1c0c859asm8032172edq.59.2023.09.05.23.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 23:01:56 -0700 (PDT)
Message-ID: <e7387e77-0397-4d1f-99d5-d465c63951d9@linaro.org>
Date:   Wed, 6 Sep 2023 07:01:54 +0100
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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

We might get in trouble here if SFDP advertises a wrong flash size. And
this is because in BP, instead of relying on the info->sector_size, we
now compute locally the sector size based on the size advertised by
SFDP. And if the SFDP flash size is wrong, we'll break BP for this
flash. I'm ok taking this risk, but please update the commit message and
inform readers about what they may hit, and what would be the fix. With
that feel free to add:

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

