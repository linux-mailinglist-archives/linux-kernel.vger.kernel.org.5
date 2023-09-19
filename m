Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677727A5DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjISJY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjISJYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:24:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCAADA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:24:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a9cd066db5so720836066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695115486; x=1695720286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7d8Xb7RH+w6lTYh+PSIBWRE9fbeStGy72q3FCoG4Xc8=;
        b=DSdo9+ZPSOaHYCYx39Edpnfoa/q97SiHVCFNnU9TYkrX43rucwr2DI73niXGVry9/N
         yt05Z/aAhkLSXo2IgmgQXgkuDjch7JSlcySAl3VKTdcDU+Lc8wmIVDZA1gOv+PnZOZJJ
         fTPEEXSqV/ggFUQFPTkh5YV5Tmsja/CAwytbBPuTHL/rEiRF8XDi/UV5bzp+ABp8p0wI
         4u0YoC12X4cCkAPL3MMgSwyyMP1uxg1jVTcueiPyutZ0YmOgWyAXUghZR9u309yzSar5
         zSjxT62w9nBUo1+WwSMhRuANaT5Jr8QWKRMFMKy9pUolEw2zCeIlgXI4iiqh4ONYcvcq
         7AIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695115486; x=1695720286;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7d8Xb7RH+w6lTYh+PSIBWRE9fbeStGy72q3FCoG4Xc8=;
        b=V1ZbE0ji6NfXrNZB2U4+KqJKf1XNeXcjQD19jYP6HwrJ34GeyYJjhLKKYX+h0Q+hLV
         V/Jn7DjktezUyvLdjOcHFAR9tfwGXLzhNramYcSLdV9xdhaaGE7iCVvrC+jDamIHC1cy
         kOM5X7wpVFTnnzeZC3dMdAyqJSAd6cRVeD0PWayjbxHYJqJ/hxEUq0IqrXTxC2W1d3oS
         0Q9nAXrwoWkduN2OtuCsOHGziolUZeCIZdQupMKPCz1cP2vuD/JE1s/Ui23oyuuU5GIj
         eaoykyIki+crga0tZqvLUhm0c8iFJMetFhQJdadQ1LvP/kieaLWm//S8hixs17QOo+UW
         ZWrw==
X-Gm-Message-State: AOJu0Yy4CyAmqxRktOr5AjMGQk7Ow6M1wA2qDSjLtkbFsASnixu0gUYy
        uJuXpUdq4e6XiKCU1zOfovxUeA==
X-Google-Smtp-Source: AGHT+IEEJ8M4Fz+7fZ7oKh7ralJ6TcdfTuoJoPInhorn/OrVtstyhXo33f1GoCzhsCBgdVnWV0aUCQ==
X-Received: by 2002:a17:907:2cef:b0:9a6:7fee:8258 with SMTP id hz15-20020a1709072cef00b009a67fee8258mr10674208ejc.19.1695115486169;
        Tue, 19 Sep 2023 02:24:46 -0700 (PDT)
Received: from [172.20.101.114] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id z9-20020a1709064e0900b0099bd8c1f67esm7535962eju.109.2023.09.19.02.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 02:24:45 -0700 (PDT)
Message-ID: <647d3775-a71d-a880-6d4d-3eb5a89ec9d6@linaro.org>
Date:   Tue, 19 Sep 2023 12:24:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 20/41] mtd: spi-nor: everspin: convert flash_info to
 new format
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v3-0-e60548861b10@kernel.org>
 <20230807-mtd-flash-info-db-rework-v3-20-e60548861b10@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v3-20-e60548861b10@kernel.org>
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
> The INFOx() macros are going away. Convert the flash_info database to
> the new format.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  drivers/mtd/spi-nor/everspin.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/everspin.c b/drivers/mtd/spi-nor/everspin.c
> index d02c32f2f7ad..46776bc10b27 100644
> --- a/drivers/mtd/spi-nor/everspin.c
> +++ b/drivers/mtd/spi-nor/everspin.c
> @@ -9,10 +9,35 @@
>  #include "core.h"
>  
>  static const struct flash_info everspin_nor_parts[] = {
> -	{ "mr25h128", CAT25_INFO(16 * 1024, 1, 256, 2) },
> -	{ "mr25h256", CAT25_INFO(32 * 1024, 1, 256, 2) },
> -	{ "mr25h10",  CAT25_INFO(128 * 1024, 1, 256, 3) },
> -	{ "mr25h40",  CAT25_INFO(512 * 1024, 1, 256, 3) },
> +	{
> +		.name = "mr25h128",
> +		.size = SZ_16K,
> +		.sector_size = SZ_16K,
> +		.page_size = 256,

page size defaults to 256, isn't it? Can we get rid of the page_size
assignments?

> +		.addr_nbytes = 2,
> +		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
> +	}, {
> +		.name = "mr25h256",
> +		.size = SZ_32K,
> +		.sector_size = SZ_32K,
> +		.page_size = 256,
> +		.addr_nbytes = 2,
> +		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
> +	}, {
> +		.name = "mr25h10",
> +		.size = SZ_128K,
> +		.sector_size = SZ_128K,
> +		.page_size = 256,
> +		.addr_nbytes = 3,
> +		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
> +	}, {
> +		.name = "mr25h40",
> +		.size = SZ_512K,
> +		.sector_size = SZ_512K,
> +		.page_size = 256,
> +		.addr_nbytes = 3,
> +		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
> +	}
>  };
>  
>  const struct spi_nor_manufacturer spi_nor_everspin = {
> 
