Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10F0793637
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjIFHZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjIFHZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:25:44 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E123E62
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:25:32 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so52426261fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 00:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693985131; x=1694589931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mUAOYZdXRcgmDE4GJOIyJRjMyBBPbYoHip/KFygnL6I=;
        b=RYEWX/lCDGo2EddE+b94EyW52lHeTiv5ttuiHLrm4uqahS7kBAeiTBBLzMHQ06LwhX
         Vje8c8382chL9quyrywzPij1k8TehL3P1FDhkdoYDz3dDLLgn2SXXZWzLQnjsusUiSkw
         adVLXv17DELtwVH/DQLN/w7MYnzk+6vA+pc6ZrdBgq5wFMK2XzAxEsah/4a60i4g9Q5e
         e7l7LiokThH5FTOlwS5Dl3RjRVT90l0qe352hNIoXj7UIqvnPLRaTd9t4HQ3gh/8zXnM
         uhCh6N6lRIOgbYdO04K18FURYerBdo2ZR2ftRUhQtogAEOde5ct9mzAt3eVlQtoSUYjD
         iM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693985131; x=1694589931;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mUAOYZdXRcgmDE4GJOIyJRjMyBBPbYoHip/KFygnL6I=;
        b=YZ9xnM9HGPALkRW3L3RBX8NoKOpsnhoB2l00KhACempdvmvx0xDp8oR2fPHfi0wLve
         VrMPntEJxJ4DTVeOOfy2IMgyrOswUaCGIyyJkJbuY8s6/w6xGoDGyFD+921B8q3xxgoZ
         ad7Y6F0PHmmE3CrYEd6TYhllC8Dxo8k3Z2pEaD3nzhEP00crIOGGpRRlLYZj0yRLRcFG
         I8g0jXmfy+R9Ys0AStb15DgarCz++4KB9Or/ZI9QCL9n9tE9bu3gJs71cQ2NHRkvVWeD
         R5FMNWAXtwnty80GLlHSnIbZciV1kXx0ovVBlmIzJp9zU4bTPmSdVcUlZL1eTAD13F46
         ZzjQ==
X-Gm-Message-State: AOJu0YyP2yqp9Jb7lU8w9LEkUKxVjfuVuRiWChZu4olNIUwxs6BZfkFI
        Eo6IWImDlY6JQe1T/ecQg224Vw==
X-Google-Smtp-Source: AGHT+IGkbZGflpIW5BJD/uJXYniQZ1XaQe3cfHAUvuH3jHWmBuLCMVyCFN4J0k3Fj5x5wa+Nspf96g==
X-Received: by 2002:a2e:9016:0:b0:2b7:11f8:27d with SMTP id h22-20020a2e9016000000b002b711f8027dmr1422317ljg.7.1693985130776;
        Wed, 06 Sep 2023 00:25:30 -0700 (PDT)
Received: from [192.168.0.173] ([79.115.63.137])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c1d0800b003fef6881350sm19682389wms.25.2023.09.06.00.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 00:25:30 -0700 (PDT)
Message-ID: <fdd524be-c339-09b1-e306-8002ee851b31@linaro.org>
Date:   Wed, 6 Sep 2023 10:25:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 14/41] mtd: spi-nor: rename .otp_org to .otp and make
 it a pointer
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-14-291a0f39f8d8@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <20230807-mtd-flash-info-db-rework-v2-14-291a0f39f8d8@kernel.org>
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
> Move the OTP ops out of the flash_info structure. Besides of saving some
> space, there will be a new macro SNOR_OTP() which can be used to set the
> ops:
>   .otp = SNOR_OTP(...),
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/mtd/spi-nor/core.c | 2 +-
>  drivers/mtd/spi-nor/core.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 80c340c7863a..1c443fe568cf 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2978,7 +2978,7 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
>  	struct device_node *np = spi_nor_get_flash_node(nor);
>  
>  	params->quad_enable = spi_nor_sr2_bit1_quad_enable;
> -	params->otp.org = &info->otp_org;
> +	params->otp.org = info->otp;
>  
>  	/* Default to 16-bit Write Status (01h) Command */
>  	nor->flags |= SNOR_F_HAS_16BIT_SR;
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 81535f31907f..c22f5cf65a58 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -555,7 +555,7 @@ struct flash_info {
>  
>  	u8 mfr_flags;
>  
> -	const struct spi_nor_otp_organization otp_org;
> +	const struct spi_nor_otp_organization *otp;
>  	const struct spi_nor_fixups *fixups;
>  };
>  
> @@ -605,7 +605,7 @@ struct flash_info {
>  		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,		\
>  
>  #define OTP_INFO(_len, _n_regions, _base, _offset)			\
> -		.otp_org = {						\
> +		.otp = &(const struct spi_nor_otp_organization){	\
>  			.len = (_len),					\
>  			.base = (_base),				\
>  			.offset = (_offset),				\
> 
