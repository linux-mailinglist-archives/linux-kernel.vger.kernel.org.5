Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E11792529
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbjIEQBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354844AbjIEO7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:59:32 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0300C113
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 07:59:28 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fef56f7223so24521775e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 07:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693925966; x=1694530766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+/C4sBAc43xlqJ9sKWleFnJzWTNOcSlUbtOWwEmgUw=;
        b=X9BAyMz3syn8f2vgfmGv3XuJBuh7vrCZj2kwCBEt90m2ZxGTsrVzGKEpdEJpNfB7/a
         9caSmVy568NrU7zRnB1r/hZjLvhT+fzVLf6p3/AsRnwMPMeTCQMH2Cm951Q3pPoVbIuf
         fXpEoZF/cd7EhPGKOkp1WfthawaA7TBXlVYgkvsp+eqcyv2SDw8hSIF7t/sqgdCJYz2r
         GyVyGRJTALozXkpEBgk1AlfIkqZxFF0z+aE0zcgqVyVCj7lc8ykXgCVuViYcV9phIQqW
         3KvPaA/jJsnil1X2wHLFje7tJhoS80G5KvpsrgqnSGCm604qNb6NVT9m4GpthKqGWPLM
         moAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693925966; x=1694530766;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+/C4sBAc43xlqJ9sKWleFnJzWTNOcSlUbtOWwEmgUw=;
        b=DHPlU/KiXj1voxh6P/KzKa+6QgRoWEtdu/y2bL9EcvvWwCFDVIQlmteHpznAUM9UUd
         vOSXi3Ak2tIloTgK3HAUJ+RXoguCciFoQuZIGLcTPsI8W8kb7QvAHT2e3+wVIztkQg+r
         iufR7dl/lgXqcwU6FsGbMWuyaQ70YjEFBqSi/uLMNoaen2JgUWjibyEjngnavQGFx57m
         Ju3SZNsTB6uQSKw43CqV9x54Idt8Jx5sILOxDyuuQ0nOso8H4LSYvmhQQkla65tl0inV
         BSoBwv/vuNaZc93kBa2v3vMRFlVXYWK0QUZd1pZrcdb1fW1qhZoNz1iJBu5XCLW/GTSx
         LyBQ==
X-Gm-Message-State: AOJu0YzmNBVk5S6aBIvU7yaz9HDFAf3MxlY87vLdVnQo15YtIF48dlm5
        SV1zf48vBm8mo3Ou6OPOMV01tg==
X-Google-Smtp-Source: AGHT+IEo8Dl6nAcvlUSaa3+JvoJD/69d925ILCme1cl7K+K9bVqK8D6YG1fHOuZMniVf4Wx+vw8xRQ==
X-Received: by 2002:a05:600c:364c:b0:401:d803:6243 with SMTP id y12-20020a05600c364c00b00401d8036243mr10478167wmq.32.1693925966360;
        Tue, 05 Sep 2023 07:59:26 -0700 (PDT)
Received: from [192.168.0.107] ([79.115.63.137])
        by smtp.gmail.com with ESMTPSA id x15-20020a1c7c0f000000b003feef82bbefsm17037987wmc.29.2023.09.05.07.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 07:59:25 -0700 (PDT)
Message-ID: <1d7e0f90-fad2-42c3-b07d-e7659a8b6ac5@linaro.org>
Date:   Tue, 5 Sep 2023 15:59:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/41] mtd: spi-nor: push 4k SE handling into
 spi_nor_select_uniform_erase()
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-9-291a0f39f8d8@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v2-9-291a0f39f8d8@kernel.org>
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
> 4k sector erase sizes are only a thing with uniform erase types. Push
> the "we want 4k erase sizes" handling into spi_nor_select_uniform_erase().
> 
> One might wonder why the former sector_size isn't used anymore. It is
> because we either search for the largest erase size or if selected
> through kconfig, the 4k erase size. Now, why is that correct? For this,
> we have to differentiate between (1) flashes with SFDP and (2) without
> SFDP. For (1), we just set one (or two if SECT_4K is set) erase types
> and wanted_size is exactly one of these.
> 
> For (2) things are a bit more complicated. For flashes which we don't

:)

> have in our flash_info database, the generic driver is used and
> sector_size was already 0, which in turn selected the largest erase
> size. For flashes which had SFDP and an entry in flash_info, sector_size
> was always the largest sector and thus the largest erase type.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  drivers/mtd/spi-nor/core.c | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 68baf6032639..c84be791341e 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2512,13 +2512,6 @@ static int spi_nor_select_pp(struct spi_nor *nor,
>  /**
>   * spi_nor_select_uniform_erase() - select optimum uniform erase type
>   * @map:		the erase map of the SPI NOR
> - * @wanted_size:	the erase type size to search for. Contains the value of
> - *			info->sector_size, the "small sector" size in case
> - *			CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is defined or 0 if
> - *			there is no information about the sector size. The
> - *			latter is the case if the flash parameters are parsed
> - *			solely by SFDP, then the largest supported erase type
> - *			is selected.
>   *
>   * Once the optimum uniform sector erase command is found, disable all the
>   * other.
> @@ -2526,13 +2519,16 @@ static int spi_nor_select_pp(struct spi_nor *nor,
>   * Return: pointer to erase type on success, NULL otherwise.
>   */
>  static const struct spi_nor_erase_type *
> -spi_nor_select_uniform_erase(struct spi_nor_erase_map *map,
> -			     const u32 wanted_size)
> +spi_nor_select_uniform_erase(struct spi_nor_erase_map *map)
>  {
>  	const struct spi_nor_erase_type *tested_erase, *erase = NULL;
>  	int i;
>  	u8 uniform_erase_type = map->uniform_erase_type;
>  
> +	/*
> +	 * Search for the biggest erase size, except for when compiled
> +	 * to use 4k erases.
> +	 */
>  	for (i = SNOR_ERASE_TYPE_MAX - 1; i >= 0; i--) {
>  		if (!(uniform_erase_type & BIT(i)))
>  			continue;
> @@ -2544,10 +2540,11 @@ spi_nor_select_uniform_erase(struct spi_nor_erase_map *map,
>  			continue;
>  
>  		/*
> -		 * If the current erase size is the one, stop here:
> +		 * If the current erase size is the 4k one, stop here,
>  		 * we have found the right uniform Sector Erase command.
>  		 */
> -		if (tested_erase->size == wanted_size) {
> +		if (IS_ENABLED(CONFIG_MTD_SPI_NOR_USE_4K_SECTORS) &&

one difference is that the is enabled check may now be evaluated for
each erase type, but looks cleaner and I can live with that as this is
set at probe time anyway.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> +		    tested_erase->size == SZ_4K) {
>  			erase = tested_erase;
>  			break;
>  		}
> @@ -2575,7 +2572,6 @@ static int spi_nor_select_erase(struct spi_nor *nor)
>  	struct spi_nor_erase_map *map = &nor->params->erase_map;
>  	const struct spi_nor_erase_type *erase = NULL;
>  	struct mtd_info *mtd = &nor->mtd;
> -	u32 wanted_size = nor->info->sector_size;
>  	int i;
>  
>  	/*
> @@ -2586,13 +2582,8 @@ static int spi_nor_select_erase(struct spi_nor *nor)
>  	 * manage the SPI flash memory as uniform with a single erase sector
>  	 * size, when possible.
>  	 */
> -#ifdef CONFIG_MTD_SPI_NOR_USE_4K_SECTORS
> -	/* prefer "small sector" erase if possible */
> -	wanted_size = 4096u;
> -#endif
> -
>  	if (spi_nor_has_uniform_erase(nor)) {
> -		erase = spi_nor_select_uniform_erase(map, wanted_size);
> +		erase = spi_nor_select_uniform_erase(map);
>  		if (!erase)
>  			return -EINVAL;
>  		nor->erase_opcode = erase->opcode;
> 
