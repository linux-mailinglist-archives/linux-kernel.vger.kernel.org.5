Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F8E79352A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 08:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237904AbjIFGMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 02:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjIFGMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 02:12:21 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DE8184
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 23:12:16 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fef56f7223so30462035e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 23:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693980734; x=1694585534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h94JAIHyqIQXwlFMVI95h36aEWO8zTCPUM5D+TVtu0g=;
        b=mix5OEhRmNZb51W2v9afhibEXvSh+rn/J0AtC3vm7rtrUKQdWcdixhiNOIrBBSpfl6
         w4QHuGS+i0ySR0TM0HtZCANZx6SW9xaTHJZI/QKAlZ7Xw7kZqJ+gK13Y3usyDjCimd3H
         zjqqdwL0FnBQjw8RmJ2kv2WNMTMKhgqg8w+zl+3QQx3FcMQc5CAG2Ds5+05QEeYAgQui
         Gdg2wxLGBTx5e61SRzQGPD4E6i0ayAhCvhOi3Dux1JDfIsQ2V3OOkW5IMRE7tIQ249lv
         nrqivQ9GDTqgYEbC4uPkj08v9E8TAxy4dquEm4t3sjhHWwinP1rzsTHBbj8J/t6ShJSG
         1RGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693980734; x=1694585534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h94JAIHyqIQXwlFMVI95h36aEWO8zTCPUM5D+TVtu0g=;
        b=gbih4Y0dN8H43R7aSuKeOPj0nB72I5uExuof2g3PSMN7tYxEnMHe2TR2+giLzwVU5Y
         nF/lfdiZqn+WnS65P5zoskYFS3xRJwZJqwkd4gTpSAswbA07TRrQb7WN8AycHHHinLzF
         jCg44HcnNSeGryfQN1v/G/b/rXqsqe0V27M+zRDZyffcEgl0SXmXwlbml9ELh1dS3wLn
         KKFxIwSB8DLQVtd4xr1lM2VhX9MhijxRiFxkP9teUc4cFk9V3dweSdS7U5nBWERx391C
         ERF2oFDgZ98hJl5axH0wwWjhU/lLVnECKVNePHsm2oqh5Qwgn87NpDLeiyJxCv3Xdy/9
         FA1Q==
X-Gm-Message-State: AOJu0YxRnnuu1otOgoYlzwnyLEaEER5o6wTh3BJnC6QCqtSiFI7KEIIl
        Kf93MroWWdL95Slshh7FFRSrjQ==
X-Google-Smtp-Source: AGHT+IGVvTfP4UQKN/H3MG8p5oeiXQme+JMYKYt/haFIYwn19+NNGA9kOcyL8bJXtlHO6ls1g2sYOQ==
X-Received: by 2002:a05:600c:a388:b0:3fe:173e:4a34 with SMTP id hn8-20020a05600ca38800b003fe173e4a34mr1449277wmb.40.1693980734582;
        Tue, 05 Sep 2023 23:12:14 -0700 (PDT)
Received: from [192.168.0.107] ([79.115.63.137])
        by smtp.gmail.com with ESMTPSA id f7-20020a1c6a07000000b003fe407ca05bsm21957172wmc.37.2023.09.05.23.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 23:12:14 -0700 (PDT)
Message-ID: <4cbc9c03-7b47-48e9-8a91-f08c44284579@linaro.org>
Date:   Wed, 6 Sep 2023 07:12:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/41] mtd: spi-nor: move the .id and .id_len into an
 own structure
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-13-291a0f39f8d8@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v2-13-291a0f39f8d8@kernel.org>
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
> Create a new structure to hold a flash ID and its length. The goal is to
> have a new macro SNOR_ID() which can have a flexible id length. This way
> we can get rid of all the individual INFOx() macros.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  drivers/mtd/spi-nor/core.c      |  6 +++---
>  drivers/mtd/spi-nor/core.h      | 33 ++++++++++++++++++++++++---------
>  drivers/mtd/spi-nor/micron-st.c |  4 ++--
>  drivers/mtd/spi-nor/spansion.c  |  4 ++--
>  drivers/mtd/spi-nor/sysfs.c     |  6 +++---
>  drivers/mtd/spi-nor/winbond.c   |  1 -
>  6 files changed, 34 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 4ba1778eda4b..80c340c7863a 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2028,8 +2028,8 @@ static const struct flash_info *spi_nor_match_id(struct spi_nor *nor,
>  	for (i = 0; i < ARRAY_SIZE(manufacturers); i++) {
>  		for (j = 0; j < manufacturers[i]->nparts; j++) {
>  			part = &manufacturers[i]->parts[j];
> -			if (part->id_len &&
> -			    !memcmp(part->id, id, part->id_len)) {
> +			if (part->id &&
> +			    !memcmp(part->id->bytes, id, part->id->len)) {
>  				nor->manufacturer = manufacturers[i];
>  				return part;
>  			}
> @@ -3370,7 +3370,7 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
>  	 * If caller has specified name of flash model that can normally be
>  	 * detected using JEDEC, let's verify it.
>  	 */
> -	if (name && info->id_len) {
> +	if (name && info->id) {
>  		const struct flash_info *jinfo;
>  
>  		jinfo = spi_nor_detect(nor);
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index c42b65623da7..81535f31907f 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -446,12 +446,22 @@ struct spi_nor_fixups {
>  	int (*late_init)(struct spi_nor *nor);
>  };
>  
> +/**
> + * struct spi_nor_id - SPI NOR flash ID.
> + *
> + * @bytes: the flash's ID bytes. The first three bytes are the JEDIC ID.

typo, JEDIC. But are there 3 bytes of ID specified by JEDEC? I remeber
there's only the MFR ID specified, the rest are flash specific, which
are not mentioned by JEDEC.

> + * @len:   the number of bytes of ID.
> + */
> +struct spi_nor_id {
> +	const u8 *bytes;
> +	u8 len;
> +};
> +
>  /**
>   * struct flash_info - SPI NOR flash_info entry.
> + * @id:   pointer to struct spi_nor_id or NULL, which means "no ID" (mostly
> + *        older chips).
>   * @name: the name of the flash.
> - * @id:             the flash's ID bytes. The first three bytes are the
> - *                  JEDIC ID. JEDEC ID zero means "no ID" (mostly older chips).
> - * @id_len:         the number of bytes of ID.
>   * @size:           the size of the flash in bytes.
>   * @sector_size:    (optional) the size listed here is what works with
>   *                  SPINOR_OP_SE, which isn't necessarily called a "sector" by
> @@ -510,8 +520,7 @@ struct spi_nor_fixups {
>   */
>  struct flash_info {
>  	char *name;
> -	u8 id[SPI_NOR_MAX_ID_LEN];
> -	u8 id_len;
> +	const struct spi_nor_id *id;
>  	size_t size;
>  	unsigned sector_size;
>  	u16 page_size;
> @@ -554,12 +563,18 @@ struct flash_info {
>  #define SPI_NOR_ID_3ITEMS(_id) ((_id) >> 16) & 0xff, SPI_NOR_ID_2ITEMS(_id)
>  
>  #define SPI_NOR_ID(_jedec_id, _ext_id)					\
> -	.id = { SPI_NOR_ID_3ITEMS(_jedec_id), SPI_NOR_ID_2ITEMS(_ext_id) }, \
> -	.id_len = !(_jedec_id) ? 0 : (3 + ((_ext_id) ? 2 : 0))
> +	.id = &(const struct spi_nor_id){				\
> +		.bytes = (const u8[]){ SPI_NOR_ID_3ITEMS(_jedec_id),	\
> +				       SPI_NOR_ID_2ITEMS(_ext_id) },	\
> +		.len = !(_jedec_id) ? 0 : (3 + ((_ext_id) ? 2 : 0)),	\
> +	}
>  
>  #define SPI_NOR_ID6(_jedec_id, _ext_id)					\
> -	.id = { SPI_NOR_ID_3ITEMS(_jedec_id), SPI_NOR_ID_3ITEMS(_ext_id) }, \
> -	.id_len = 6
> +	.id = &(const struct spi_nor_id){				\
> +		.bytes = (const u8[]){ SPI_NOR_ID_3ITEMS(_jedec_id),	\
> +				       SPI_NOR_ID_3ITEMS(_ext_id) },	\
> +		.len = 6,						\
> +	}
>  
>  #define SPI_NOR_GEOMETRY(_sector_size, _n_sectors, _n_banks)		\
>  	.size = (_sector_size) * (_n_sectors),				\
> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
> index 5406a3af2ce0..229c951efcce 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -78,7 +78,7 @@ static int micron_st_nor_octal_dtr_en(struct spi_nor *nor)
>  		return ret;
>  	}
>  
> -	if (memcmp(buf, nor->info->id, nor->info->id_len))
> +	if (memcmp(buf, nor->info->id->bytes, nor->info->id->len))
>  		return -EINVAL;
>  
>  	return 0;
> @@ -114,7 +114,7 @@ static int micron_st_nor_octal_dtr_dis(struct spi_nor *nor)
>  		return ret;
>  	}
>  
> -	if (memcmp(buf, nor->info->id, nor->info->id_len))
> +	if (memcmp(buf, nor->info->id->bytes, nor->info->id->len))
>  		return -EINVAL;
>  
>  	return 0;
> diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
> index e6468569f178..d7012ab3de2c 100644
> --- a/drivers/mtd/spi-nor/spansion.c
> +++ b/drivers/mtd/spi-nor/spansion.c
> @@ -228,7 +228,7 @@ static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
>  		return ret;
>  	}
>  
> -	if (memcmp(buf, nor->info->id, nor->info->id_len))
> +	if (memcmp(buf, nor->info->id->bytes, nor->info->id->len))
>  		return -EINVAL;
>  
>  	return 0;
> @@ -272,7 +272,7 @@ static int cypress_nor_octal_dtr_dis(struct spi_nor *nor)
>  		return ret;
>  	}
>  
> -	if (memcmp(buf, nor->info->id, nor->info->id_len))
> +	if (memcmp(buf, nor->info->id->bytes, nor->info->id->len))
>  		return -EINVAL;
>  
>  	return 0;
> diff --git a/drivers/mtd/spi-nor/sysfs.c b/drivers/mtd/spi-nor/sysfs.c
> index c09bb832b3b9..2dfdc555a69f 100644
> --- a/drivers/mtd/spi-nor/sysfs.c
> +++ b/drivers/mtd/spi-nor/sysfs.c
> @@ -35,8 +35,8 @@ static ssize_t jedec_id_show(struct device *dev,
>  	struct spi_device *spi = to_spi_device(dev);
>  	struct spi_mem *spimem = spi_get_drvdata(spi);
>  	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
> -	const u8 *id = nor->info->id_len ? nor->info->id : nor->id;
> -	u8 id_len = nor->info->id_len ?: SPI_NOR_MAX_ID_LEN;
> +	const u8 *id = nor->info->id ? nor->info->id->bytes : nor->id;
> +	u8 id_len = nor->info->id ? nor->info->id->len : SPI_NOR_MAX_ID_LEN;
>  
>  	return sysfs_emit(buf, "%*phN\n", id_len, id);
>  }
> @@ -78,7 +78,7 @@ static umode_t spi_nor_sysfs_is_visible(struct kobject *kobj,
>  
>  	if (attr == &dev_attr_manufacturer.attr && !nor->manufacturer)
>  		return 0;
> -	if (attr == &dev_attr_jedec_id.attr && !nor->info->id_len && !nor->id)
> +	if (attr == &dev_attr_jedec_id.attr && !nor->info->id && !nor->id)
>  		return 0;
>  
>  	return 0444;
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index c21fed842762..7873cc394f07 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -121,7 +121,6 @@ static const struct flash_info winbond_nor_parts[] = {
>  	{ "w25q80bl", INFO(0xef4014, 0, 64 * 1024,  16)
>  		NO_SFDP_FLAGS(SECT_4K) },
>  	{ "w25q128", INFO(0xef4018, 0, 0, 0)
> -		PARSE_SFDP

this is a leftover that should be squashed in a previous commit.

I'm fine with the overal idea, but please fix the comment about the 3
bytes of jedec id.

>  		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
>  	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> 
