Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E8C786A62
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240563AbjHXImi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbjHXImT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:42:19 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B268D1728
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:42:17 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52a3aa99bcdso1962330a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692866536; x=1693471336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=puURoaQfBrDJF9LCn2Zc0LTYGt1gtTe27qvoHHoLoso=;
        b=m70jlyC5KmxF+VRYoKneKTTm5TuR5xHF+mzbh7p9LG+r3xpMlQhPYmazDXN0DF3XES
         niN1faNCh/sa3DW5+llfmk8hoh+nSn+Cu2/zl5muEx+slGnJ4RPgDTEwT3hdTsFhh+P7
         BgvbCfZ0BNqZX7DQowClJfL9L1UYwy+BLmKlFS+e0IYvxf9gRkLiBMcc/Bm4gnwRAOOm
         vGT2ziGkxb3Nc78GG0Io14Xfdv1bM+BRFYNSAlmEsis8EH4/I5D3DrB+aUF8FBicJvWq
         j7qnB/QsJENCR7a4d9FsltYrwI6XxIOXD0l1dNL40cI/EgB1UjdfhQEJqXyqAoayx5TU
         CilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692866536; x=1693471336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puURoaQfBrDJF9LCn2Zc0LTYGt1gtTe27qvoHHoLoso=;
        b=Y1BfdaDGC3ABoebLwOCAATGqRyzGf405kG3y2OMlhFUQhb+sNMTtXSdujs1eumL0es
         X7cOEGRj7iCn8kUExw8LJzf9A0u0yXJfj+DQOoxKEyBKK2I1tUMbPRgAP+yNJXEPeIWP
         b3Bpath8McOo6CYD76pUKqBCbIHGpBl/2LGRN2XrzGXsYuU2OztBWlCJMVfdjQzMbMLH
         Ks3WOvqG5TdLym63woA7hrlDck52Kpyg5sTWuy2o+MOnn71SZFWS3J6/eygv4mBq/0ce
         d0/ZcWq52obaXTo+hzBGCfolmGmIOr5fDvxs7rn11yLNKUIyHa1grdYDNDMtTtJ3jigP
         o4YA==
X-Gm-Message-State: AOJu0YzioCAxZut77sAUltskJA3JtVtR/3UlJTYwoKzFmIgo2O67VhqL
        Si4YTf1+4miys4vlqw1cVrFZiQ==
X-Google-Smtp-Source: AGHT+IHNUFAhYyu/BT2VvKG1iuTaw9fuREQvuxHATujHtPzh13LPG8RFDxXgINPzaRx9NaaoAV2j5A==
X-Received: by 2002:a17:906:255a:b0:99c:47a:8bcd with SMTP id j26-20020a170906255a00b0099c047a8bcdmr10124636ejb.67.1692866536147;
        Thu, 24 Aug 2023 01:42:16 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.239])
        by smtp.gmail.com with ESMTPSA id gq6-20020a170906e24600b0099c53c44083sm10612118ejb.79.2023.08.24.01.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 01:42:15 -0700 (PDT)
Message-ID: <8d42e8a2-d697-e3e8-a576-910d669883b3@linaro.org>
Date:   Thu, 24 Aug 2023 09:42:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2 08/41] mtd: spi-nor: default .n_banks to 1
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-8-291a0f39f8d8@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v2-8-291a0f39f8d8@kernel.org>
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
> If .n_banks is not set in the flash_info database, the default value
> should be 1. This way, we don't have to always set the .n_banks
> parameter in flash_info.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/mtd/spi-nor/core.c   | 3 +--
>  drivers/mtd/spi-nor/core.h   | 8 ++++----
>  drivers/mtd/spi-nor/xilinx.c | 1 -
>  3 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index e27f1323fa0b..68baf6032639 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2017,7 +2017,6 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
>  
>  static const struct flash_info spi_nor_generic_flash = {
>  	.name = "spi-nor-generic",
> -	.n_banks = 1,
>  	.parse_sfdp = true,
>  };
>  
> @@ -2997,7 +2996,7 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
>  	params->size = info->size;
>  	params->bank_size = params->size;
>  	params->page_size = info->page_size ?: SPI_NOR_DEFAULT_PAGE_SIZE;
> -	params->n_banks = info->n_banks;
> +	params->n_banks = info->n_banks ?: SPI_NOR_DEFAULT_N_BANKS;
>  
>  	if (!(info->flags & SPI_NOR_NO_FR)) {
>  		/* Default to Fast Read for DT and non-DT platform devices. */
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 2fc999f2787c..8627d0b95be6 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -15,6 +15,7 @@
>   * have the page size defined within their SFDP tables.
>   */
>  #define SPI_NOR_DEFAULT_PAGE_SIZE 256
> +#define SPI_NOR_DEFAULT_N_BANKS 1
>  
>  /* Standard SPI NOR flash operations. */
>  #define SPI_NOR_READID_OP(naddr, ndummy, buf, len)			\
> @@ -453,7 +454,7 @@ struct spi_nor_fixups {
>   * @size:           the size of the flash in bytes.
>   * @sector_size:    the size listed here is what works with SPINOR_OP_SE, which
>   *                  isn't necessarily called a "sector" by the vendor.
> - * @n_banks:        the number of banks.
> + * @n_banks:        (optional) the number of banks. Defaults to 1.
>   * @page_size:      (optional) the flash's page size. Defaults to 256.
>   * @addr_nbytes:    number of address bytes to send.
>   *
> @@ -570,7 +571,7 @@ struct flash_info {
>  /* Used when the "_ext_id" is two bytes at most */
>  #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors)		\
>  	SPI_NOR_ID((_jedec_id), (_ext_id)),				\
> -	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), 1),
> +	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), 0),
>  
>  #define INFOB(_jedec_id, _ext_id, _sector_size, _n_sectors, _n_banks)	\
>  	SPI_NOR_ID((_jedec_id), (_ext_id)),				\
> @@ -578,13 +579,12 @@ struct flash_info {
>  
>  #define INFO6(_jedec_id, _ext_id, _sector_size, _n_sectors)		\
>  	SPI_NOR_ID6((_jedec_id), (_ext_id)),				\
> -	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), 1),
> +	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), 0),
>  
>  #define CAT25_INFO(_sector_size, _n_sectors, _page_size, _addr_nbytes)	\
>  		.size = (_sector_size) * (_n_sectors),			\
>  		.sector_size = (_sector_size),				\
>  		.page_size = (_page_size),				\
> -		.n_banks = 1,						\
>  		.addr_nbytes = (_addr_nbytes),				\
>  		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,		\
>  
> diff --git a/drivers/mtd/spi-nor/xilinx.c b/drivers/mtd/spi-nor/xilinx.c
> index 284e2e4970ab..8d4539e32dfe 100644
> --- a/drivers/mtd/spi-nor/xilinx.c
> +++ b/drivers/mtd/spi-nor/xilinx.c
> @@ -26,7 +26,6 @@
>  		.size = 8 * (_page_size) * (_n_sectors),		\
>  		.sector_size = (8 * (_page_size)),			\
>  		.page_size = (_page_size),				\
> -		.n_banks = 1,						\
>  		.flags = SPI_NOR_NO_FR
>  
>  /* Xilinx S3AN share MFR with Atmel SPI NOR */
> 
