Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A167934FF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 07:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjIFFop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 01:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjIFFoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 01:44:44 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6049CDD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 22:44:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a1de3417acso121617866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 22:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693979079; x=1694583879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vUHY9l/ahFbvg+wX1AOKxG+CKEDbszdQhJl5/ZPug+U=;
        b=ASTF3AGd2/mZIrJFPkzUhZhGzv0vgP5zZl+CnFCXl31iBbFXJvxdfFLIWrgShrH6/8
         IT9fp4MGaVbDVnlWOD4Oq7n4eKh+eVlUrXcAKAtDEe8tL+hwXmkgnXzWT3EoDgSozvzn
         RpgKM5bCkKDqknC9RPgmfLTSGmwK5fG5hy2p/pD+/w4B6PJO9vJOzUWMZwWch7VcBqJF
         KqEYpk5SGZbha7n0xl3CVc5YPEmSUd474XwZvCx1J2zvvOAG5Syk/63dzAK53kpL/Zco
         lI9FTTl6hAwh1W+UTjnCjyH/Ry8xx8i/KxoINiEDOxKI4XHWNzswNoIgvEW2UdM0cv++
         k12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693979079; x=1694583879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vUHY9l/ahFbvg+wX1AOKxG+CKEDbszdQhJl5/ZPug+U=;
        b=A6+BwzKE5dUhrwkc4cBoZTch/109wp7YQM+5zZIfEszRc/sCDA5C3SOayygn9Wj5Jz
         FV0C1T42uRUymarE7wjggkmK+ALHGheyi635ATN6FvcHooxapXb+WCHysMsE/YOpjjGJ
         lryWgqPnkrEP++E/E9jipqYddqXX/mG3c4PIdeKHmSutNPkWrmYWpoZYoBwlep1lVmJu
         e2aaQofBF2t++LBzyZzIw5vO7egfWnvAj4x04Vp6v2ujsW5DSUt34D1odBwaUkBGMYXJ
         vD8gILjXv+fOZXm7Gd5xDJNii7KLbcDe1fA/H5CaFW/vgp1bZQ/Olb1m6JmOgEyLjnNc
         Vv5w==
X-Gm-Message-State: AOJu0Ywoi9nYZJyLWcW9uDWhPibXrxnUvniLgFi6MQs+akLIy8HRXijs
        BaomF3hf4qpns3WS2/YAATk9pg==
X-Google-Smtp-Source: AGHT+IFl1BcO96LjspG5iGCfeQZEf2a6mVEE6l1iTne3gvRX8Z+bq8yIcW7UAnLjy+sjJTRGcXSk/g==
X-Received: by 2002:a17:906:53c5:b0:9a2:1e14:86b9 with SMTP id p5-20020a17090653c500b009a21e1486b9mr2036998ejo.0.1693979078634;
        Tue, 05 Sep 2023 22:44:38 -0700 (PDT)
Received: from [192.168.0.107] ([79.115.63.137])
        by smtp.gmail.com with ESMTPSA id z17-20020a170906241100b0099bd7b26639sm8551322eja.6.2023.09.05.22.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 22:44:38 -0700 (PDT)
Message-ID: <21cd9421-52e6-432a-b612-a8bb9c48f98b@linaro.org>
Date:   Wed, 6 Sep 2023 06:44:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/41] mtd: spi-nor: make sector_size optional
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-10-291a0f39f8d8@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v2-10-291a0f39f8d8@kernel.org>
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
> Most of the (old, non-SFDP) flashes use a sector size of 64k. Make that
> a default value so it can be optional in the flash_info database.
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

why do you clear the sector_size?

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
