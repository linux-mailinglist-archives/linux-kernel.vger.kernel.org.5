Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287B679363D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjIFH2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjIFH2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:28:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AD48E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:28:05 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-317c3ac7339so2863981f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 00:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693985284; x=1694590084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9bMJBXttHvX9K+/BKiatIe6dYjJgBiOa9KYUzMQlv8I=;
        b=ubnj4CAkJMuAG7uGpD9fNTN+7MJPz5JE2txjtcPMrPcFwEeHDCdZJthZLsU5KytCoS
         DJlkd+McfzgXnY6CwL0a04EsVrDP+jjg4+xUojd1MAFNyy+Q2u8iiqb++ph1hkNG7A2k
         pYa3kfT9Y9SqM80Vi4XlIBFYaiHOjhGjnwE++6hTO/78OUxjRMnnFYgdIguceKdVaeKP
         6EvQ+mEJ3nhCsnmfxOmg4FrND0g4AvLfSCkstVnBLK3vDzGHogWvX1PAVKBxQroPqmzb
         pyPqQBSCNfof2zjpTIfPsQDzvGZsLvQlSYKxNbGHCjDajM3nkAJENBbVyiGnI24FS9Kz
         Sywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693985284; x=1694590084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9bMJBXttHvX9K+/BKiatIe6dYjJgBiOa9KYUzMQlv8I=;
        b=OHpprX3F84CD5a/hgVLTEbAvOYbKvBjTwS9gBhA3ceA83+Qhw+xR0cjqeAVNGr+Cgg
         lw778sXOLklhZWUo89WctY8KMO4mmLbs6ZG+S7VHZ3hmf0uHc9Gn7VOSvNZgpG7TYS9s
         wNaA3K28NF59WNMHB+xF76mVgi25aV+Zb8xZjG7Kay00pQcCrU6UfZYbJNIZ72cwaugF
         Lq3NZ5srwTgsE3czg2SruRCk5jMVtOIPEHiHdHffIUT5t/TsndTnnJiTLwN4edEfql8h
         eSwlV3KwobO4AnZS4Djx9TrbNVI3HYI9MDTNoZAXyQfYFlTzg7YcBeAUE/ShyXmnoePa
         XP4g==
X-Gm-Message-State: AOJu0YzHIPui44+PCMIRJ/+OwB6KmJW03aGMXn17ZaKpLqiKK88stw0W
        cL+NufSWZSkxXRGrSYlAEyrpxfNQyE8wyXl2JLU=
X-Google-Smtp-Source: AGHT+IESEKh+11MBHDIR/LJxJuSsWfHYFkkQFFN6Z0HotRF5rCUy1y4iVUbnOMUtvc2XvCpzMZP+9g==
X-Received: by 2002:adf:ed88:0:b0:31a:e3ad:f30e with SMTP id c8-20020adfed88000000b0031ae3adf30emr1607176wro.68.1693985284438;
        Wed, 06 Sep 2023 00:28:04 -0700 (PDT)
Received: from [192.168.0.173] ([79.115.63.137])
        by smtp.gmail.com with ESMTPSA id x9-20020adfdd89000000b003196b1bb528sm19688413wrl.64.2023.09.06.00.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 00:28:04 -0700 (PDT)
Message-ID: <863ba1a1-ebd0-b544-705c-72295316140c@linaro.org>
Date:   Wed, 6 Sep 2023 10:28:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 15/41] mtd: spi-nor: add SNOR_ID() and SNOR_OTP()
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-15-291a0f39f8d8@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v2-15-291a0f39f8d8@kernel.org>
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
> After all the preparation, it is now time to introduce the new macros to
> specify flashes in our database: SNOR_ID() and SNOR_OTP(). An flash_info
> entry might now look like:
>     {
>         .id = SNOR_ID(0xef, 0x60, 0x16),
>         .otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
>         .flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
>     }
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>


Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>


> ---
>  drivers/mtd/spi-nor/core.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index c22f5cf65a58..420e5ca2cfe1 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -559,6 +559,20 @@ struct flash_info {
>  	const struct spi_nor_fixups *fixups;
>  };
>  
> +#define SNOR_ID(...)							\
> +	(&(const struct spi_nor_id){					\
> +		.bytes = (const u8[]){ __VA_ARGS__ },			\
> +		.len = sizeof((u8[]){ __VA_ARGS__ }),			\
> +	})
> +
> +#define SNOR_OTP(_len, _n_regions, _base, _offset)			\
> +	(&(const struct spi_nor_otp_organization){			\
> +		.len = (_len),						\
> +		.base = (_base),					\
> +		.offset = (_offset),					\
> +		.n_regions = (_n_regions),				\
> +	})
> +
>  #define SPI_NOR_ID_2ITEMS(_id) ((_id) >> 8) & 0xff, (_id) & 0xff
>  #define SPI_NOR_ID_3ITEMS(_id) ((_id) >> 16) & 0xff, SPI_NOR_ID_2ITEMS(_id)
>  
> 
