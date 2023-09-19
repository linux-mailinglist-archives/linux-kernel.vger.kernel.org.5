Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F1B7A5DC1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjISJZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjISJZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:25:44 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A732F2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:25:38 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9a9cd066db5so720961666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695115536; x=1695720336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EqYqPFsuKPJ27YsPuao4HG1nRy4TwOXvP2qF4wZU/F8=;
        b=iz0gs3zE/JZPfPfEFAStLwWYoUcOBXAkFHve0ZQ4bOkDcqb1YN92cZfPlt2xCoWmHA
         7gaGefCE1hYj5rAwlNoH8h/oOvuaEnQYRzJTAJUIb0GJrsrBv6O3/f/q0AHHbXCyWRHe
         8x0giJCM39a0LZd5fT4j7dA51bN/abdIs7B0yGxo9S/Ku12EQreCCv/NEEBC8CRoC1hi
         OekPNAmox9J1tu9DErt9f8pPBqvuQSsAngGt16O1fDCKGLfy4JQiNft8pAWty5kP71W9
         hRf20Fvj9NnJFoJVAaFcTPTlAXA1HUssIgcqgCCXMnyAlf2pmaJh1OmBzfuJd5vRd0LY
         Sl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695115536; x=1695720336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EqYqPFsuKPJ27YsPuao4HG1nRy4TwOXvP2qF4wZU/F8=;
        b=jyzdPnm+XpvoX6rnPsfXTxMGJdtlPLFsdHY+Gb6SQSZQG/Hpl++WZp5iWuC/wqCGtI
         1B5GhShTEVGAhL4p1Omob7OGsFHstScReK14WmrckTFhclR7avfExdReYoO5TaEVQpeQ
         cmC82wyNekBPgmZsJ4RdYs6IKEcyLu+B8kYEDFkk30hK/y24ISC00FGXBt0XK7RZd2y7
         MZ1Op3kufu0WaYrwKyMfwmiC8ESDdHYQydH4O13HheIhk//phmA2M4nwVOV5KpEXTNZL
         do4yI2X+hvrHdhSkF3rbjUCZcHlGEKK1R5UiJw7WGLfMxLP8AdoRG952hSCTj6AHj7eL
         AnZw==
X-Gm-Message-State: AOJu0YyBTEPnp3iKo66sr7b7LQbCt9Wn90UsqyvL2LiNBMeIRmeKCFJg
        5y3kd79EoK0VREX6UeHgHRM7Mpnqz9nqEFzHSwVXRw==
X-Google-Smtp-Source: AGHT+IEIfQ/nWjCtgsUWYKW3bJ5BrPYUBZqRMxmkK40+vxmtgp+VTWIJv94Z6JqjGYS0EuQwEfuRyw==
X-Received: by 2002:a17:907:7842:b0:9ad:a59f:331a with SMTP id lb2-20020a170907784200b009ada59f331amr10334920ejc.57.1695115536397;
        Tue, 19 Sep 2023 02:25:36 -0700 (PDT)
Received: from [172.20.101.114] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id cf21-20020a170906b2d500b009ad8d444be4sm7482440ejb.43.2023.09.19.02.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 02:25:35 -0700 (PDT)
Message-ID: <417fb0fa-e774-c744-8641-7618347a8d1a@linaro.org>
Date:   Tue, 19 Sep 2023 12:25:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 10/41] mtd: spi-nor: make sector_size optional
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v3-0-e60548861b10@kernel.org>
 <20230807-mtd-flash-info-db-rework-v3-10-e60548861b10@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v3-10-e60548861b10@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08.09.2023 13:16, Michael Walle wrote:
> Most of the (old, non-SFDP) flashes use a sector size of 64k. Make that
> a default value so it can be optional in the flash_info database.
> 
> As a preparation for conversion to the new database format, set the
> sector size to zero if the default value is used. This way, the actual
> change is happening with this patch ant not with a later conversion
> patch.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  drivers/mtd/spi-nor/core.c | 6 ++++--
>  drivers/mtd/spi-nor/core.h | 8 +++++---
>  drivers/mtd/spi-nor/swp.c  | 6 +++++-
>  3 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index c84be791341e..368851ff9f40 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2756,7 +2756,8 @@ static void spi_nor_no_sfdp_init_params(struct spi_nor *nor)
>  {
>  	struct spi_nor_flash_parameter *params = nor->params;
>  	struct spi_nor_erase_map *map = &params->erase_map;
> -	const u8 no_sfdp_flags = nor->info->no_sfdp_flags;
> +	const struct flash_info *info = nor->info;
> +	const u8 no_sfdp_flags = info->no_sfdp_flags;
>  	u8 i, erase_mask;
>  
>  	if (no_sfdp_flags & SPI_NOR_DUAL_READ) {
> @@ -2810,7 +2811,8 @@ static void spi_nor_no_sfdp_init_params(struct spi_nor *nor)
>  		i++;
>  	}
>  	erase_mask |= BIT(i);
> -	spi_nor_set_erase_type(&map->erase_type[i], nor->info->sector_size,
> +	spi_nor_set_erase_type(&map->erase_type[i],
> +			       info->sector_size ?: SPI_NOR_DEFAULT_SECTOR_SIZE,
>  			       SPINOR_OP_SE);

all these info->sector_size checks can be removed if we use
params->sector_size. I'll do it after applying the series.

>  	spi_nor_init_uniform_erase_map(map, erase_mask, params->size);
>  }
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 8627d0b95be6..fba3ea8536a5 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -16,6 +16,7 @@
>   */
>  #define SPI_NOR_DEFAULT_PAGE_SIZE 256
>  #define SPI_NOR_DEFAULT_N_BANKS 1
> +#define SPI_NOR_DEFAULT_SECTOR_SIZE SZ_64K
>  
>  /* Standard SPI NOR flash operations. */
>  #define SPI_NOR_READID_OP(naddr, ndummy, buf, len)			\
> @@ -452,8 +453,9 @@ struct spi_nor_fixups {
>   *                  JEDIC ID. JEDEC ID zero means "no ID" (mostly older chips).
>   * @id_len:         the number of bytes of ID.
>   * @size:           the size of the flash in bytes.
> - * @sector_size:    the size listed here is what works with SPINOR_OP_SE, which
> - *                  isn't necessarily called a "sector" by the vendor.
> + * @sector_size:    (optional) the size listed here is what works with
> + *                  SPINOR_OP_SE, which isn't necessarily called a "sector" by
> + *                  the vendor. Defaults to 64k.
>   * @n_banks:        (optional) the number of banks. Defaults to 1.
>   * @page_size:      (optional) the flash's page size. Defaults to 256.
>   * @addr_nbytes:    number of address bytes to send.
> @@ -565,7 +567,7 @@ struct flash_info {
>  
>  #define SPI_NOR_GEOMETRY(_sector_size, _n_sectors, _n_banks)		\
>  	.size = (_sector_size) * (_n_sectors),				\
> -	.sector_size = (_sector_size),					\
> +	.sector_size = (_sector_size == SZ_64K) ? 0 : (_sector_size),	\
>  	.n_banks = (_n_banks)
>  
>  /* Used when the "_ext_id" is two bytes at most */
> diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
> index 40bf52867095..585813310ee1 100644
> --- a/drivers/mtd/spi-nor/swp.c
> +++ b/drivers/mtd/spi-nor/swp.c
> @@ -34,7 +34,11 @@ static u8 spi_nor_get_sr_tb_mask(struct spi_nor *nor)
>  static u64 spi_nor_get_min_prot_length_sr(struct spi_nor *nor)
>  {
>  	unsigned int bp_slots, bp_slots_needed;
> -	unsigned int sector_size = nor->info->sector_size;
> +	/*
> +	 * sector_size will eventually be replaced with the max erase size of
> +	 * the flash. For now, we need to have that ugly default.
> +	 */
> +	unsigned int sector_size = nor->info->sector_size ?: SPI_NOR_DEFAULT_SECTOR_SIZE;
>  	u64 n_sectors = div_u64(nor->params->size, sector_size);
>  	u8 mask = spi_nor_get_sr_bp_mask(nor);
>  
> 
