Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5DF7869FD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbjHXIZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236591AbjHXIZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:25:46 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADD51709
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:25:44 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fee769fcc3so44680175e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692865542; x=1693470342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ufDuOrMZ6PX5JtRvNn4ZirU+4EA1nSr1OgPphDzyH8Q=;
        b=veuxEedyZ+2JZm3y+1GOuqEXAWuiRN/ynvhk9QgzsFCQ1flNWPcgeZREQYx8gBBqMI
         oPInzhVbfpFGrfM8Ae8nWMGWDUm8y2f/MIy7mCjN3DAZ8D6u6V3WO/F3iOdyCnJwQOvk
         YpIsirR4URjHAEJgpQr+b7JZUCQUZNcLw5HKCJIc1Tr3MKJu2QmcyWDo0CtzGANenGA7
         SPIwEvyx/KGLqj2ERLaRMl2d+gEBAk2ICSHHKNky/WArUdOnt39rtfZ4P33p8ptI3vF0
         9JLyAo7Tg15wVvUIiyK2vG1qC3g/6oC5TLgWLu7u2PvTKN39rCXXAGdO865YtwJIFgRg
         Z7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692865542; x=1693470342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufDuOrMZ6PX5JtRvNn4ZirU+4EA1nSr1OgPphDzyH8Q=;
        b=OGxvxrT5Yllhykhjyb9fod3asMKso4n/FaIbu+xQiU44ROUBDaVYpqNPI3HOP612t+
         Jo7huzyvVB61EJZ7oVVaBlGaEcGpxItcsgDKlXrC6Bj3zWIsr8vzfxZr2QTsIo+N9KVO
         LFjkHtWnjI9Oa8+25P5cctbPPY7Uhgx3ZeW+TZdUoEtbTJdG2OPMyujHcZAFxtHkgDDy
         P6k1sodV371ghu+DserD94ElN7wpCYGzjKaWaemLjIfpiMnX5MRpD1c9fZXDbxXz9Eyv
         JatCLMNUZWxdJwNYOhyRp55dDdbFnsQcWfDhJfSzKSw2ZFa4HJDJGcqjdyZdqceyV01y
         sTwA==
X-Gm-Message-State: AOJu0Yy0G/WxZQzHxXMzNbPvYlLxppYupthCtn0HqT65QlaloUccB6ZP
        /yu+o1Lt7DhFUuzq2tLEOuq8Tw==
X-Google-Smtp-Source: AGHT+IHPKNu2kUb4ciPw/tpNDJNSqsuJa6veUIyEOWqVFnVhTYNl0ohIzznHmH/Hti0seds6z4MUXw==
X-Received: by 2002:a7b:cd14:0:b0:3fc:1a6:7764 with SMTP id f20-20020a7bcd14000000b003fc01a67764mr11224846wmj.16.1692865542273;
        Thu, 24 Aug 2023 01:25:42 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.239])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c020600b003fc04d13242sm1954471wmi.0.2023.08.24.01.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 01:25:41 -0700 (PDT)
Message-ID: <3df0728d-60d8-1cff-a0d9-f3de505dfa17@linaro.org>
Date:   Thu, 24 Aug 2023 09:25:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2 05/41] mtd: spi-nor: convert .n_sectors to .size
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-5-291a0f39f8d8@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v2-5-291a0f39f8d8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/23 08:09, Michael Walle wrote:
> .n_sectors is rarely used. In fact it is only used in swp.c and to
> calculate the flash size in the core. The use in swp.c might be
> converted to use the (largest) flash erase size. For now, we just
> locally calculate the sector size.
> 
> Simplify the flash_info database and set the size of the flash directly.
> This also let us use the SZ_x macros.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  drivers/mtd/spi-nor/core.c   | 2 +-
>  drivers/mtd/spi-nor/core.h   | 8 ++++----
>  drivers/mtd/spi-nor/swp.c    | 9 +++++----
>  drivers/mtd/spi-nor/xilinx.c | 4 ++--
>  4 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 286155002cdc..f4cc2eafcc5e 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2999,7 +2999,7 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
>  
>  	/* Set SPI NOR sizes. */
>  	params->writesize = 1;
> -	params->size = (u64)info->sector_size * info->n_sectors;
> +	params->size = info->size;

would be good to check the sanity of info->size to not be null and to be
divisible by sector_size.

>  	params->bank_size = params->size;
>  	params->page_size = info->page_size;
>  
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index dfc20a3296fb..12c35409493b 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -443,9 +443,9 @@ struct spi_nor_fixups {
>   * @id:             the flash's ID bytes. The first three bytes are the
>   *                  JEDIC ID. JEDEC ID zero means "no ID" (mostly older chips).
>   * @id_len:         the number of bytes of ID.
> + * @size:           the size of the flash in bytes.
>   * @sector_size:    the size listed here is what works with SPINOR_OP_SE, which
>   *                  isn't necessarily called a "sector" by the vendor.
> - * @n_sectors:      the number of sectors.
>   * @n_banks:        the number of banks.
>   * @page_size:      the flash's page size.
>   * @addr_nbytes:    number of address bytes to send.
> @@ -505,8 +505,8 @@ struct flash_info {
>  	char *name;
>  	u8 id[SPI_NOR_MAX_ID_LEN];
>  	u8 id_len;
> +	size_t size;
>  	unsigned sector_size;
> -	u16 n_sectors;
>  	u16 page_size;
>  	u8 n_banks;
>  	u8 addr_nbytes;
> @@ -556,8 +556,8 @@ struct flash_info {
>  	.id_len = 6
>  
>  #define SPI_NOR_GEOMETRY(_sector_size, _n_sectors, _n_banks)		\
> +	.size = (_sector_size) * (_n_sectors),				\
>  	.sector_size = (_sector_size),					\
> -	.n_sectors = (_n_sectors),					\
>  	.page_size = 256,						\
>  	.n_banks = (_n_banks)
>  
> @@ -575,8 +575,8 @@ struct flash_info {
>  	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), 1),
>  
>  #define CAT25_INFO(_sector_size, _n_sectors, _page_size, _addr_nbytes)	\
> +		.size = (_sector_size) * (_n_sectors),			\
>  		.sector_size = (_sector_size),				\
> -		.n_sectors = (_n_sectors),				\
>  		.page_size = (_page_size),				\
>  		.n_banks = 1,						\
>  		.addr_nbytes = (_addr_nbytes),				\
> diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
> index 5ab9d5324860..40bf52867095 100644
> --- a/drivers/mtd/spi-nor/swp.c
> +++ b/drivers/mtd/spi-nor/swp.c
> @@ -34,17 +34,18 @@ static u8 spi_nor_get_sr_tb_mask(struct spi_nor *nor)
>  static u64 spi_nor_get_min_prot_length_sr(struct spi_nor *nor)
>  {
>  	unsigned int bp_slots, bp_slots_needed;
> +	unsigned int sector_size = nor->info->sector_size;
> +	u64 n_sectors = div_u64(nor->params->size, sector_size);

if params(info)->size is zero here, we get into trouble.

>  	u8 mask = spi_nor_get_sr_bp_mask(nor);
>  
>  	/* Reserved one for "protect none" and one for "protect all". */
>  	bp_slots = (1 << hweight8(mask)) - 2;
> -	bp_slots_needed = ilog2(nor->info->n_sectors);
> +	bp_slots_needed = ilog2(n_sectors);
>  
>  	if (bp_slots_needed > bp_slots)
> -		return nor->info->sector_size <<
> -			(bp_slots_needed - bp_slots);
> +		return sector_size << (bp_slots_needed - bp_slots);
>  	else
> -		return nor->info->sector_size;
> +		return sector_size;
>  }
>  
>  static void spi_nor_get_locked_range_sr(struct spi_nor *nor, u8 sr, loff_t *ofs,
> diff --git a/drivers/mtd/spi-nor/xilinx.c b/drivers/mtd/spi-nor/xilinx.c
> index 34267591282c..284e2e4970ab 100644
> --- a/drivers/mtd/spi-nor/xilinx.c
> +++ b/drivers/mtd/spi-nor/xilinx.c
> @@ -23,8 +23,8 @@
>  
>  #define S3AN_INFO(_jedec_id, _n_sectors, _page_size)			\
>  		SPI_NOR_ID(_jedec_id, 0),				\
> +		.size = 8 * (_page_size) * (_n_sectors),		\

here it's fine.

>  		.sector_size = (8 * (_page_size)),			\
> -		.n_sectors = (_n_sectors),				\
>  		.page_size = (_page_size),				\
>  		.n_banks = 1,						\
>  		.flags = SPI_NOR_NO_FR
> @@ -138,7 +138,7 @@ static int xilinx_nor_setup(struct spi_nor *nor,
>  		page_size = (nor->params->page_size == 264) ? 256 : 512;
>  		nor->params->page_size = page_size;
>  		nor->mtd.writebufsize = page_size;
> -		nor->params->size = 8 * page_size * nor->info->n_sectors;
> +		nor->params->size = nor->info->size;
>  		nor->mtd.erasesize = 8 * page_size;
>  	} else {
>  		/* Flash in Default addressing mode */
> 
