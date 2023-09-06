Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548D279365C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjIFHfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjIFHfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:35:09 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D1ECC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:35:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401d10e3e54so31958995e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 00:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693985702; x=1694590502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4F7Avj7xOpfFljV7YI4ozRVD1XpBz9VLRFq4+FFIk9Y=;
        b=dAMStatzdnp2cnskNZeroougPHuDxONleLTimpyYUHjlIqDiX2e7UriGPPTYucrrCh
         CMIHYZCU4nWQOg9DmVfwQ/fQB3u1G3En05mMb1s41AS4Mg1BBWSHzd8RGSgfbPn0SUqA
         cvvwv3xSX9O62oNZkwBnoTeaatNb96rdVAx+oheOO7FlnrPci4tYzWP7DK0fo+jxgI7e
         ONgTFNmbghkVUBXQM+a77UqjOKTs/6Ln1YO0EOVza5qYHvRudLFgDlIoP3kCZqAP4IZs
         7hYE6bO/yNGvdXsAmHz6jGPZwRKJ/cjaXrct/9JcopjkEzdXdyngtHxmSiAEjtn87xyK
         8jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693985702; x=1694590502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4F7Avj7xOpfFljV7YI4ozRVD1XpBz9VLRFq4+FFIk9Y=;
        b=NxCHiI5ppEZ0MQXxvLUhGdxmqKdY2ARILPVE4lPIqU/FDNU9nKllme5AsLJrxIEtE0
         IB7Rvr1NBOFMIPii3gj3+pgTaWRdjGXVZZqGWkLU6mOGI5/eT8XpsB2+PF/gCxMJSlJx
         2etvoqQpkQDEaLsyOZKiicND5WSOajjsHjEv5YUE62m7MzKKuexIFL2PYZNQjZ/ZGSzr
         PFKJFCWC/FLFq3pYtsW8Z13Q3PA51WPo/qz3m8aCR70tvfmsUt+bRZtGY7iH0IjqIFRX
         mS5xGzxHdL1aoz0ft7rhhfglNaWH52V4XMKTl40/W+5GCT5W44qn4clZTFWI8QblcHIX
         4umQ==
X-Gm-Message-State: AOJu0YxwhZl75O3GP3CWwapCHJVVRwPWiwYrNWKnVjQ1daAusoC5GtvJ
        JsMyZBuTMcLLN6Y/hnXchoMmbg==
X-Google-Smtp-Source: AGHT+IHh1yamYKvDysTndoWYxNsCGmDQHLNw1NTFk2BhlSy7HbT7tCjf0h4kvVxjEEPOM1nWodUk0Q==
X-Received: by 2002:a1c:7c0e:0:b0:3fe:5501:d293 with SMTP id x14-20020a1c7c0e000000b003fe5501d293mr1386719wmc.30.1693985702633;
        Wed, 06 Sep 2023 00:35:02 -0700 (PDT)
Received: from [192.168.0.173] ([79.115.63.137])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c294500b003fa96fe2bd9sm22123894wmd.22.2023.09.06.00.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 00:35:02 -0700 (PDT)
Message-ID: <aba618e2-ad74-d716-c8d7-e77588b22509@linaro.org>
Date:   Wed, 6 Sep 2023 10:35:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 17/41] mtd: spi-nor: atmel: convert flash_info to new
 format
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-17-291a0f39f8d8@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v2-17-291a0f39f8d8@kernel.org>
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
> The INFOx() macros are going away. Convert the flash_info database to
> the new format.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  drivers/mtd/spi-nor/atmel.c | 122 +++++++++++++++++++++++++++++---------------
>  1 file changed, 80 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
> index d2de2cb0c066..ccc985c48ae3 100644
> --- a/drivers/mtd/spi-nor/atmel.c
> +++ b/drivers/mtd/spi-nor/atmel.c
> @@ -163,48 +163,86 @@ static const struct spi_nor_fixups atmel_nor_global_protection_fixups = {
>  };
>  
>  static const struct flash_info atmel_nor_parts[] = {
> -	{ "at25fs010",  INFO(0x1f6601, 0, 32 * 1024,   4)
> -		FLAGS(SPI_NOR_HAS_LOCK)
> -		NO_SFDP_FLAGS(SECT_4K)
> -		.fixups = &at25fs_nor_fixups },
> -	{ "at25fs040",  INFO(0x1f6604, 0, 64 * 1024,   8)
> -		FLAGS(SPI_NOR_HAS_LOCK)
> -		NO_SFDP_FLAGS(SECT_4K)
> -		.fixups = &at25fs_nor_fixups },
> -	{ "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8)
> -		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
> -		NO_SFDP_FLAGS(SECT_4K)
> -		.fixups = &atmel_nor_global_protection_fixups },
> -	{ "at25df321",  INFO(0x1f4700, 0, 64 * 1024,  64)
> -		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
> -		NO_SFDP_FLAGS(SECT_4K)
> -		.fixups = &atmel_nor_global_protection_fixups },
> -	{ "at25df321a", INFO(0x1f4701, 0, 64 * 1024,  64)
> -		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
> -		NO_SFDP_FLAGS(SECT_4K)
> -		.fixups = &atmel_nor_global_protection_fixups },
> -	{ "at25df641",  INFO(0x1f4800, 0, 64 * 1024, 128)
> -		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
> -		NO_SFDP_FLAGS(SECT_4K)
> -		.fixups = &atmel_nor_global_protection_fixups },
> -	{ "at25sl321",	INFO(0x1f4216, 0, 64 * 1024, 64)
> -		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> -	{ "at26f004",   INFO(0x1f0400, 0, 64 * 1024,  8)
> -		NO_SFDP_FLAGS(SECT_4K) },
> -	{ "at26df081a", INFO(0x1f4501, 0, 64 * 1024, 16)
> -		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
> -		NO_SFDP_FLAGS(SECT_4K)
> -		.fixups = &atmel_nor_global_protection_fixups },
> -	{ "at26df161a", INFO(0x1f4601, 0, 64 * 1024, 32)
> -		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
> -		NO_SFDP_FLAGS(SECT_4K)
> -		.fixups = &atmel_nor_global_protection_fixups },
> -	{ "at26df321",  INFO(0x1f4700, 0, 64 * 1024, 64)
> -		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
> -		NO_SFDP_FLAGS(SECT_4K)
> -		.fixups = &atmel_nor_global_protection_fixups },
> -	{ "at45db081d", INFO(0x1f2500, 0, 64 * 1024, 16)
> -		NO_SFDP_FLAGS(SECT_4K) },
> +	{
> +		.id = SNOR_ID(0x1f, 0x66, 0x01),
> +		.name = "at25fs010",

nitpick, we shall respect the order of the members declared in
flash_info struct.

And I'll let you double check if the conversion is accurate :D.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> +		.sector_size = SZ_32K,
> +		.size = SZ_128K,
> +		.flags = SPI_NOR_HAS_LOCK,
> +		.no_sfdp_flags = SECT_4K,
> +		.fixups = &at25fs_nor_fixups
> +	}, {
> +		.id = SNOR_ID(0x1f, 0x66, 0x04),
> +		.name = "at25fs040",
> +		.size = SZ_512K,
> +		.flags = SPI_NOR_HAS_LOCK,
> +		.no_sfdp_flags = SECT_4K,
> +		.fixups = &at25fs_nor_fixups
> +	}, {
> +		.id = SNOR_ID(0x1f, 0x44, 0x01),
> +		.name = "at25df041a",
> +		.size = SZ_512K,
> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
> +		.no_sfdp_flags = SECT_4K,
> +		.fixups = &atmel_nor_global_protection_fixups,
> +	}, {
> +		.id = SNOR_ID(0x1f, 0x47, 0x00),
> +		.name = "at25df321",
> +		.size = SZ_4M,
> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
> +		.no_sfdp_flags = SECT_4K,
> +		.fixups = &atmel_nor_global_protection_fixups
> +	}, {
> +		.id = SNOR_ID(0x1f, 0x47, 0x01),
> +		.name = "at25df321a",
> +		.size = SZ_4M,
> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
> +		.no_sfdp_flags = SECT_4K,
> +		.fixups = &atmel_nor_global_protection_fixups
> +	}, {
> +		.id = SNOR_ID(0x1f, 0x48, 0x00),
> +		.name = "at25df641",
> +		.size = SZ_8M,
> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
> +		.no_sfdp_flags = SECT_4K,
> +		.fixups = &atmel_nor_global_protection_fixups
> +	}, {
> +		.id = SNOR_ID(0x1f, 0x42, 0x16),
> +		.name = "at25sl321",
> +		.size = SZ_4M,
> +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> +	}, {
> +		.id = SNOR_ID(0x1f, 0x04, 0x00),
> +		.name = "at26f004",
> +		.size = SZ_512K,
> +		.no_sfdp_flags = SECT_4K,
> +	}, {
> +		.id = SNOR_ID(0x1f, 0x45, 0x01),
> +		.name = "at26df081a",
> +		.size = SZ_1M,
> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
> +		.no_sfdp_flags = SECT_4K,
> +		.fixups = &atmel_nor_global_protection_fixups
> +	}, {
> +		.id = SNOR_ID(0x1f, 0x46, 0x01),
> +		.name = "at26df161a",
> +		.size = SZ_2M,
> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
> +		.no_sfdp_flags = SECT_4K,
> +		.fixups = &atmel_nor_global_protection_fixups
> +	}, {
> +		.id = SNOR_ID(0x1f, 0x47, 0x00),
> +		.name = "at26df321",
> +		.size = SZ_4M,
> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
> +		.no_sfdp_flags = SECT_4K,
> +		.fixups = &atmel_nor_global_protection_fixups
> +	}, {
> +		.id = SNOR_ID(0x1f, 0x25, 0x00),
> +		.name = "at45db081d",
> +		.size = SZ_1M,
> +		.no_sfdp_flags = SECT_4K,
> +	},
>  };
>  
>  const struct spi_nor_manufacturer spi_nor_atmel = {
> 
