Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332BA793679
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbjIFHkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbjIFHkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:40:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9F0E6E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:40:19 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99357737980so509603966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 00:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693986017; x=1694590817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BuUCTpEsoTeM3wxxff5fzdirFgNIUQLOysT5sVaJC10=;
        b=ar2Cja2yDmCfxuCUHAl92ohUZf6QQqmpmC/a02DIL2R6ogEp6O7Fu6A0uEAyUY6KTN
         p5Ni7pt/7gjANUBJnOmO2rh847a5gJZeJ9CacbdlV2/k6ku5/80RZyu5sbdq8qD1Rotr
         W8j1vRpiIS8HHtP8fzO02ZoveieEtlYQum0vPkZ54LQaPDaP81/Mn219O8GE0u6iJEIb
         p4gmObr2p7MhgaB6u/O7Sq55yYgsll69Cax3NVPQZVy42NZJJTTiaBAjInd58YCgTqpL
         YhfhQiA+dxzPZ01K2ZxoOw4Fse0wKa6eTH4/eBsBQayvrv6i8B2ItM9td88CwIMEspMV
         tu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693986017; x=1694590817;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BuUCTpEsoTeM3wxxff5fzdirFgNIUQLOysT5sVaJC10=;
        b=Q8lO4bgkQ+208G/RauBdF/cZZX0K7NaD81klT5Aa6OdmREcuZpKZxoxrctH3Vpzz4n
         Nk/HszcNUMRWvM4gu1kFqg4DzthNaeU0TNGYXkecGF/NByA4Lz/Lw/RXP3PYfRa8zBBv
         rF9R6UbR2LSQUo0EvEgKt19tvPFzOAZGPFqU1EXoaugAcyQE2hNbyWF34oDc1sapMr4I
         lzchoUPjZW4xrPmKdSRT5UXvuutn6bb4uR5wM4h39vcv9WFu5AjnDdhGgtBTd9AV5qVF
         c2zCaSYa1g4+AdoPeJLe4rfOyfhj4ltCgtnGwSZKR3Mw5Aqzjkym+2i20xozwJECPel5
         uhtA==
X-Gm-Message-State: AOJu0YxqcZu5VvZSvQlymn+skrxZuNs8RbTHmr96UW+Rn1lseJ1Z6Sg/
        wPCSu0ZHmEs599HSVh8uB15toA==
X-Google-Smtp-Source: AGHT+IEUUsYk4gKEVGbyn0dBc48Ky0YgYjurPjh7f7S6Xm6VHVgPPVg5dQMVtVEmokxNpsVShQ/I7Q==
X-Received: by 2002:a17:906:530c:b0:9a5:e440:38dd with SMTP id h12-20020a170906530c00b009a5e44038ddmr1682445ejo.45.1693986017572;
        Wed, 06 Sep 2023 00:40:17 -0700 (PDT)
Received: from [192.168.0.173] ([79.115.63.137])
        by smtp.gmail.com with ESMTPSA id rp24-20020a170906d97800b009a5c98fd82asm8526472ejb.81.2023.09.06.00.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 00:40:17 -0700 (PDT)
Message-ID: <5f7142ae-08db-41f9-d8ab-ed19e7afb9d5@linaro.org>
Date:   Wed, 6 Sep 2023 10:40:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 41/41] mtd: spi-nor: core: get rid of the INFOx()
 macros
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-41-291a0f39f8d8@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v2-41-291a0f39f8d8@kernel.org>
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
> Now that all flash_info tables are converted to the new format, remove
> the old INFOx() macros.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>


Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/mtd/spi-nor/core.h | 65 ----------------------------------------------
>  1 file changed, 65 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 420e5ca2cfe1..1febb4a3c59b 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -573,71 +573,6 @@ struct flash_info {
>  		.n_regions = (_n_regions),				\
>  	})
>  
> -#define SPI_NOR_ID_2ITEMS(_id) ((_id) >> 8) & 0xff, (_id) & 0xff
> -#define SPI_NOR_ID_3ITEMS(_id) ((_id) >> 16) & 0xff, SPI_NOR_ID_2ITEMS(_id)
> -
> -#define SPI_NOR_ID(_jedec_id, _ext_id)					\
> -	.id = &(const struct spi_nor_id){				\
> -		.bytes = (const u8[]){ SPI_NOR_ID_3ITEMS(_jedec_id),	\
> -				       SPI_NOR_ID_2ITEMS(_ext_id) },	\
> -		.len = !(_jedec_id) ? 0 : (3 + ((_ext_id) ? 2 : 0)),	\
> -	}
> -
> -#define SPI_NOR_ID6(_jedec_id, _ext_id)					\
> -	.id = &(const struct spi_nor_id){				\
> -		.bytes = (const u8[]){ SPI_NOR_ID_3ITEMS(_jedec_id),	\
> -				       SPI_NOR_ID_3ITEMS(_ext_id) },	\
> -		.len = 6,						\
> -	}
> -
> -#define SPI_NOR_GEOMETRY(_sector_size, _n_sectors, _n_banks)		\
> -	.size = (_sector_size) * (_n_sectors),				\
> -	.sector_size = (_sector_size == SZ_64K) ? 0 : (_sector_size),	\
> -	.n_banks = (_n_banks)
> -
> -/* Used when the "_ext_id" is two bytes at most */
> -#define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors)		\
> -	SPI_NOR_ID((_jedec_id), (_ext_id)),				\
> -	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), 0),
> -
> -#define INFO0(_sector_size, _n_sectors)					\
> -	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), 0),
> -
> -#define INFOB(_jedec_id, _ext_id, _sector_size, _n_sectors, _n_banks)	\
> -	SPI_NOR_ID((_jedec_id), (_ext_id)),				\
> -	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), (_n_banks)),
> -
> -#define INFO6(_jedec_id, _ext_id, _sector_size, _n_sectors)		\
> -	SPI_NOR_ID6((_jedec_id), (_ext_id)),				\
> -	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), 0),
> -
> -#define CAT25_INFO(_sector_size, _n_sectors, _page_size, _addr_nbytes)	\
> -		.size = (_sector_size) * (_n_sectors),			\
> -		.sector_size = (_sector_size),				\
> -		.page_size = (_page_size),				\
> -		.addr_nbytes = (_addr_nbytes),				\
> -		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,		\
> -
> -#define OTP_INFO(_len, _n_regions, _base, _offset)			\
> -		.otp = &(const struct spi_nor_otp_organization){	\
> -			.len = (_len),					\
> -			.base = (_base),				\
> -			.offset = (_offset),				\
> -			.n_regions = (_n_regions),			\
> -		},
> -
> -#define FLAGS(_flags)							\
> -		.flags = (_flags),					\
> -
> -#define NO_SFDP_FLAGS(_no_sfdp_flags)					\
> -		.no_sfdp_flags = (_no_sfdp_flags),			\
> -
> -#define FIXUP_FLAGS(_fixup_flags)					\
> -		.fixup_flags = (_fixup_flags),				\
> -
> -#define MFR_FLAGS(_mfr_flags)						\
> -		.mfr_flags = (_mfr_flags),				\
> -
>  /**
>   * struct spi_nor_manufacturer - SPI NOR manufacturer object
>   * @name: manufacturer name
> 
