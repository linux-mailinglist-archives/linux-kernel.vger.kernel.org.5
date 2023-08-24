Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71303786A55
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjHXIl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240550AbjHXIlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:41:47 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF2F1727
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:41:44 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c3c8adb27so843544266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692866503; x=1693471303;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wq0ip0Gqdvj6brH2crnHRblQCGLzB23cq73iMEAyaAA=;
        b=NWFF63qQ/S1kdVdK9DGciU4Ny9ilkHD9sSJ1BgedzuuADOJSJTzrSs1xLOvNO3LGGr
         XelkBJVXTSJFvZUd4WAJryHiCckUtV6qxrNS4yKbN/Uh2dIKDw3CXpB0BXaoGDmDNTuL
         ZnoMMBbhT1FXoc+uGpBCBz7u/JTjAP2vsimXzKOAi7flufghAc6bGRpKGBHAt76HFbW8
         zL0BUKpiOGxNr+dxqsVH0BodGHZnxs93ouj3Jv5L1YG9IJVCJNxYKbJcpy4gBuL6ZtsX
         KVqJDbbV9aWEnbAvcdUI1heAPfMCYGFWRjizxmWv+5T7J/NWw63AcMumWofgV+bSkoMf
         FACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692866503; x=1693471303;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wq0ip0Gqdvj6brH2crnHRblQCGLzB23cq73iMEAyaAA=;
        b=I2gPjDF3DFR1FD2onVkoXabaZCcAvr9s3mjhw6YfCsMZOYX3BtJhKQ78KgnkE3a3yR
         6TfMaYmq4nLHtR30LWZ72ckcH9/owFv1HOQwPIr9A1ITSLRxPvWLQaqthGSz5JPt10t6
         BzFSckrB9nNyD6o3HXAXujEDkZJmzhyEN+HMx5CIwHJSNKyZgj2KmPxExli9lIYPRYHU
         M0jSHhPAmnYdMZaytDblHwC30Xz3UccHioOWkyjtLiq0OyTbDmD20XcEE1VBN5hQHaV6
         OdxB+BBtGuze2JXFNqiBSQcNXvSwKKp15xqEYfktb/3a7mPXPk4qYcDHozK2hXqSliEV
         nsOA==
X-Gm-Message-State: AOJu0YzLAGu4xzPKBgQqbldwe9TdiEr9VDPtGmgyXjzjSKAG/eUoiIO1
        bb2nU55R+XRkSwE4QfAFHTSUNQ==
X-Google-Smtp-Source: AGHT+IG4nIn8vVWb1lv02CMNTQ6rhDxNZrC5TOgJ583puuk+b5ZooIuUGJdS10m8Ww6z/lu2PNwFMw==
X-Received: by 2002:a17:906:255a:b0:99c:47a:8bcd with SMTP id j26-20020a170906255a00b0099c047a8bcdmr10123732ejb.67.1692866503250;
        Thu, 24 Aug 2023 01:41:43 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.239])
        by smtp.gmail.com with ESMTPSA id jw11-20020a17090776ab00b0099d0a8ccb5fsm10672470ejc.152.2023.08.24.01.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 01:41:42 -0700 (PDT)
Message-ID: <a6dc9a8e-5225-3768-08f4-0cf7800aa438@linaro.org>
Date:   Thu, 24 Aug 2023 09:41:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2 07/41] mtd: spi-nor: store .n_banks in struct
 spi_nor_flash_parameter
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-7-291a0f39f8d8@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v2-7-291a0f39f8d8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/23 08:09, Michael Walle wrote:
> First, fixups might want to replace the n_banks parameter, thus we need
> it in the (writable) parameter struct. Secondly, this way we can have a
> default in the core and just skip setting the n_banks in the flash_info
> database. Most of the flashes doesn't have more than one bank.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/mtd/spi-nor/core.c | 7 ++++---
>  drivers/mtd/spi-nor/core.h | 2 ++
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index d27ad1295ee0..e27f1323fa0b 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2862,7 +2862,7 @@ static void spi_nor_init_flags(struct spi_nor *nor)
>  	if (flags & NO_CHIP_ERASE)
>  		nor->flags |= SNOR_F_NO_OP_CHIP_ERASE;
>  
> -	if (flags & SPI_NOR_RWW && nor->info->n_banks > 1 &&
> +	if (flags & SPI_NOR_RWW && nor->params->n_banks > 1 &&
>  	    !nor->controller_ops)
>  		nor->flags |= SNOR_F_RWW;
>  }
> @@ -2926,8 +2926,8 @@ static int spi_nor_late_init_params(struct spi_nor *nor)
>  	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params->locking_ops)
>  		spi_nor_init_default_locking_ops(nor);
>  
> -	if (nor->info->n_banks > 1)
> -		params->bank_size = div64_u64(params->size, nor->info->n_banks);
> +	if (params->n_banks > 1)
> +		params->bank_size = div64_u64(params->size, params->n_banks);
>  
>  	return 0;
>  }
> @@ -2997,6 +2997,7 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
>  	params->size = info->size;
>  	params->bank_size = params->size;
>  	params->page_size = info->page_size ?: SPI_NOR_DEFAULT_PAGE_SIZE;
> +	params->n_banks = info->n_banks;
>  
>  	if (!(info->flags & SPI_NOR_NO_FR)) {
>  		/* Default to Fast Read for DT and non-DT platform devices. */
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 25bc18197614..2fc999f2787c 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -358,6 +358,7 @@ struct spi_nor_otp {
>   *			in octal DTR mode.
>   * @rdsr_addr_nbytes:	dummy address bytes needed for Read Status Register
>   *			command in octal DTR mode.
> + * @n_banks:		number of banks.
>   * @n_dice:		number of dice in the flash memory.
>   * @vreg_offset:	volatile register offset for each die.
>   * @hwcaps:		describes the read and page program hardware
> @@ -394,6 +395,7 @@ struct spi_nor_flash_parameter {
>  	u8				addr_mode_nbytes;
>  	u8				rdsr_dummy;
>  	u8				rdsr_addr_nbytes;
> +	u8				n_banks;
>  	u8				n_dice;
>  	u32				*vreg_offset;
>  
> 
