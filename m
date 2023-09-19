Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CD37A5DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjISJYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjISJYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:24:17 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1E2118
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:24:11 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52f3ba561d9so11832670a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695115450; x=1695720250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NdipXS3XvV3KRj6rKJENXG4HLWYuJ+l0yvNmUVb9N/c=;
        b=ikBHsfdQ6hj3GlrJ2vPYlUSXLGOR2p9uHW2jCdMHca2pjZXO7UzDXPRdsn1bXsSu2m
         Wf6RUkSANlK30IzEuUrsrnRP9q+FsHrB6yKRrkZuKSuxDM1u51pXu3iKiP38dxSWAfbT
         1L2GuA77m18zG6xxZxO06aDLoFIoNVqbPDLv4yhE1dxQfn5uG+CdDfles32qrjT0vjpn
         QxSOjh1yfFfF0L45+BydGyCGAN8Sk/9Lmo62v1tfZj/SlL09R9JGvby+xjgspPaW3ATT
         9CQ/JRYE7qRKxw6TUDN1BAo54wY3XFlAxZhFBQ+QLxwnufQ3jhd2fz1GMG7FQnW+QnaE
         KjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695115450; x=1695720250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NdipXS3XvV3KRj6rKJENXG4HLWYuJ+l0yvNmUVb9N/c=;
        b=cp1SPvSkqBW0+bOmZFbSAqlk7pWN+jH1p/2rX1tOTgmuhuASZgCgI0Qkht+t0cxUAB
         l/Jiz0P9oyxHYefQFQZJRQpmJ6exT+hXv/r7raZ6gRg+AwwLEsoFhZKrGosEbq4qEZvK
         8rpv6uURLOcpg9lim4hb4UVHXw82BSjq+jlDW9CS4OylZn4AzTWiXNAch6/vx1gvyZ1l
         a9pnfGytPItAoA7NpzLafRvSPsN0oPJsQ42PUsoNFTGWReca4GlTTS7IjORp1Vg/bQTu
         T4mEoqEyq6T3Z80v9UaAVljITYIs3bWInTrzqwZEd7Psqqkg8igEAmulRBysNDQzZdHr
         u9AA==
X-Gm-Message-State: AOJu0YyxXoxHVCS5lYUwdEwH8s2BRED3ag84CowWFwoON5qxRmQJHKtQ
        4k8U6ELkfGvEqb0iiFMPLIwRVA==
X-Google-Smtp-Source: AGHT+IH64zfLtuxYw8F4H8HPvhGHakyXs2btpSGa7cXl1iulH3IKtlfCFKRCmJjpUSb+qNWnsdiHGw==
X-Received: by 2002:a05:6402:2789:b0:51e:5bd5:fe7e with SMTP id b9-20020a056402278900b0051e5bd5fe7emr2697704ede.17.1695115449717;
        Tue, 19 Sep 2023 02:24:09 -0700 (PDT)
Received: from [172.20.101.114] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id o17-20020a056402039100b0052f66414ec6sm7161533edv.56.2023.09.19.02.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 02:24:08 -0700 (PDT)
Message-ID: <80641a1c-d922-22cc-edd4-76d475e1aac8@linaro.org>
Date:   Tue, 19 Sep 2023 12:24:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 05/41] mtd: spi-nor: convert .n_sectors to .size
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v3-0-e60548861b10@kernel.org>
 <20230807-mtd-flash-info-db-rework-v3-5-e60548861b10@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v3-5-e60548861b10@kernel.org>
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



On 08.09.2023 13:16, Michael Walle wrote:
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

this should use nor->params instead, but we can do it later on. New
flash additions must specify the sector size, otherwise we get a
division by zero below. I see you introduce a default value in patch 10,
which will guard us. I assume  you checked that there's no flash that
specifies BP and sector size of zero up to patch 9 inclusively,
otherwise we'll break bisect-ability. Let me know if yes, and I'll
update the commit message when applying.

> +	u64 n_sectors = div_u64(nor->params->size, sector_size);
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
