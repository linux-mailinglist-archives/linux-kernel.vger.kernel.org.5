Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40D4762A3D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjGZEXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjGZEXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:23:17 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D13C4ED2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 21:15:28 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1bbaa549c82so673153fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 21:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690344927; x=1690949727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCKirh+uoqmU1szsL3L/BLfSKNOonNfgrGL1EltZyqU=;
        b=OYzHF25byjK0fkgoDH6YuBwOMXECrIrBSbSt7/4YVHdwRx4drSmjVZ2cOG3uGA/eFT
         GYYAnSULkZOu8Y7BJDYhPzUXavC+rzH5cqJZzOpdmcCFt1T5haiaxbNyAzh7pvaS97vU
         611tXOZJU1x04+AhK/u/FF4IQaDv5PBoSM8LqceeddBWA6mKCuZAtgvJ/zgz+jL+UKLS
         bAtvV2BInnGZqzimELYdqGPqbrbkmGtPAY+qR3GdZ2qc3lSG7h3TOVBDR8zF0Qgu3wYq
         ALdSqIBQKmYvDylxi+acvfPUNyCOXDxhgEG43xXfZOD11DZtDSLJWN+YxINv7hD36i/W
         BvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690344927; x=1690949727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dCKirh+uoqmU1szsL3L/BLfSKNOonNfgrGL1EltZyqU=;
        b=OE/yHJ2DvEYQmdX7ZjM+yamO5psGBwJug/WjWdKQ8Dd99puP8XTZnub3HD0hQsIFpx
         2WGukQQb7Z9WwpGH/90W/2VuiG/14+VMWLpPz/XA8ab/t+EZdsc2fqO5GIXNTblcflfn
         +rZQQa/XJN1DsN9K7fQe5vprp9T3GNB9tzHmrvlwTK7pM8lVEKEioIuHhDsyKBoffSzQ
         Jp+jWgXNRks7G8aX2fwIF6DuJLsgbMy0duRb+utMXStLmrlScTm2PxGhoh7Ovpq6yZBg
         RZTeV7756j8J2YS0FpTvaW1cAPvawK5HPLyAnPfOL3cwRJzqjhHeeFywGm/es47WUuSj
         6h/A==
X-Gm-Message-State: ABy/qLb48ZGNMxuZbR1NJX702Bp/2JGOyzoeX2mbmdxyI3ZxfyiS8jN/
        lsqdciHhorvCvI7OW3yuMbA=
X-Google-Smtp-Source: APBJJlEdKuT9CCISCEd5ZrTodGop14VFv0E+aNF6qdRCoU1ulbxMRZiw2+9HwMvv+EInJ5XJqjxn3A==
X-Received: by 2002:a05:6870:ac13:b0:1bb:ba55:3fdd with SMTP id kw19-20020a056870ac1300b001bbba553fddmr597584oab.7.1690344926586;
        Tue, 25 Jul 2023 21:15:26 -0700 (PDT)
Received: from [192.168.0.11] (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id d20-20020aa78154000000b00682a8e600f0sm10404947pfn.35.2023.07.25.21.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 21:15:26 -0700 (PDT)
Message-ID: <40acee64-439c-8a93-2788-da4249cb714a@gmail.com>
Date:   Wed, 26 Jul 2023 13:15:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND PATCH v3 11/11] mtd: spi-nor: spansion: switch
 cypress_nor_get_page_size() to use vreg_offset
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        takahiro.kuwano@infineon.com, michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at
References: <20230724081247.4779-1-tudor.ambarus@linaro.org>
 <20230724081247.4779-12-tudor.ambarus@linaro.org>
From:   Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <20230724081247.4779-12-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

On 7/24/2023 5:12 PM, Tudor Ambarus wrote:
> All users of cypress_nor_get_page_size() retrieve n_dice and vreg_offset
> from SFDP. Switch cypress_nor_get_page_size() to always use vreg_offset
> so that we use the same code base for both single and multi chip package
> flashes. cypress_nor_get_page_size() is now called in the post_sfdp()
> hook instead of post_bfpt(), as vreg_offset and n_dice are parsed after
> BFPT and we now use them to get the page size in the post_sfdp hook.
> Consequently the null checks on n_dice and vreg_offset are moved to
> the post_sfdp() hook.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/mtd/spi-nor/spansion.c | 105 +++++++++++++--------------------
>  1 file changed, 42 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
> index 4027f0038ce5..0b01af33aa57 100644
> --- a/drivers/mtd/spi-nor/spansion.c
> +++ b/drivers/mtd/spi-nor/spansion.c
> @@ -471,28 +471,17 @@ static int cypress_nor_set_addr_mode_nbytes(struct spi_nor *nor)
>  	return 0;
>  }
>  
> -static int cypress_nor_get_page_size_single_chip(struct spi_nor *nor)
> -{
> -	struct spi_mem_op op =
> -		CYPRESS_NOR_RD_ANY_REG_OP(nor->params->addr_mode_nbytes,
> -					  SPINOR_REG_CYPRESS_CFR3V, 0,
> -					  nor->bouncebuf);
> -	int ret;
> -
> -	ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
> -	if (ret)
> -		return ret;
> -
> -	if (nor->bouncebuf[0] & SPINOR_REG_CYPRESS_CFR3_PGSZ)
> -		nor->params->page_size = 512;
> -	else
> -		nor->params->page_size = 256;
> -
> -	return 0;
> -}
> -
> -
> -static int cypress_nor_get_page_size_mcp(struct spi_nor *nor)
> +/**
> + * cypress_nor_get_page_size() - Get flash page size configuration.
> + * @nor:	pointer to a 'struct spi_nor'
> + *
> + * The BFPT table advertises a 512B or 256B page size depending on part but the
> + * page size is actually configurable (with the default being 256B). Read from
> + * CFR3V[4] and set the correct size.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int cypress_nor_get_page_size(struct spi_nor *nor)
>  {
>  	struct spi_mem_op op =
>  		CYPRESS_NOR_RD_ANY_REG_OP(nor->params->addr_mode_nbytes,
> @@ -522,23 +511,6 @@ static int cypress_nor_get_page_size_mcp(struct spi_nor *nor)
>  	return 0;
>  }
>  
> -/**
> - * cypress_nor_get_page_size() - Get flash page size configuration.
> - * @nor:	pointer to a 'struct spi_nor'
> - *
> - * The BFPT table advertises a 512B or 256B page size depending on part but the
> - * page size is actually configurable (with the default being 256B). Read from
> - * CFR3V[4] and set the correct size.
> - *
> - * Return: 0 on success, -errno otherwise.
> - */
> -static int cypress_nor_get_page_size(struct spi_nor *nor)
> -{
> -	if (nor->params->n_dice)
> -		return cypress_nor_get_page_size_mcp(nor);
> -	return cypress_nor_get_page_size_single_chip(nor);
> -}
> -
>  static void cypress_nor_ecc_init(struct spi_nor *nor)
>  {
>  	/*
> @@ -575,20 +547,26 @@ s25fs256t_post_bfpt_fixup(struct spi_nor *nor,
>  	if (nor->bouncebuf[0])
>  		return -ENODEV;
>  
> -	return cypress_nor_get_page_size(nor);
> +	return 0;
>  }
>  
>  static int s25fs256t_post_sfdp_fixup(struct spi_nor *nor)
>  {
>  	struct spi_nor_flash_parameter *params = nor->params;
>  
> +	if (!params->n_dice || !params->vreg_offset) {
> +		dev_err(nor->dev, "%s failed. The volatile register offset could not be retrieved from SFDP.\n",
> +			__func__);
> +		return -EOPNOTSUPP;
> +	}
> +
S25FS256T failed here. I realized that S25FS256T doesn't have SCCR map...
With fix like below, it works. Make sense?

	params->vreg_offset = devm_kmalloc(nor->dev, sizeof(u32), GFP_KERNEL);
	if (!params->vreg_offset)
		return -ENOMEM;

	params->vreg_offset[0] = SPINOR_REG_CYPRESS_VREG;
	params->n_dice = 1;


>  	/* PP_1_1_4_4B is supported but missing in 4BAIT. */
>  	params->hwcaps.mask |= SNOR_HWCAPS_PP_1_1_4;
>  	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_1_1_4],
>  				SPINOR_OP_PP_1_1_4_4B,
>  				SNOR_PROTO_1_1_4);
>  
> -	return 0;
> +	return cypress_nor_get_page_size(nor);
>  }
>  
>  static int s25fs256t_late_init(struct spi_nor *nor)
> @@ -623,10 +601,20 @@ s25hx_t_post_bfpt_fixup(struct spi_nor *nor,
>  
>  static int s25hx_t_post_sfdp_fixup(struct spi_nor *nor)
>  {
> -	struct spi_nor_erase_type *erase_type =
> -					nor->params->erase_map.erase_type;
> +	struct spi_nor_flash_parameter *params = nor->params;
> +	struct spi_nor_erase_type *erase_type = params->erase_map.erase_type;
>  	unsigned int i;
>  
> +	if (!params->n_dice || !params->vreg_offset) {
> +		dev_err(nor->dev, "%s failed. The volatile register offset could not be retrieved from SFDP.\n",
> +			__func__);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* The 2 Gb parts duplicate info and advertise 4 dice instead of 2. */
> +	if (params->size == SZ_256M)
> +		params->n_dice = 2;
> +
>  	/*
>  	 * In some parts, 3byte erase opcodes are advertised by 4BAIT.
>  	 * Convert them to 4byte erase opcodes.
> @@ -644,10 +632,6 @@ static int s25hx_t_post_sfdp_fixup(struct spi_nor *nor)
>  		}
>  	}
>  
> -	/* The 2 Gb parts duplicate info and advertise 4 dice instead of 2. */
> -	if (nor->params->size == SZ_256M)
> -		nor->params->n_dice = 2;
> -
>  	return cypress_nor_get_page_size(nor);
>  }
>  
> @@ -655,12 +639,6 @@ static int s25hx_t_late_init(struct spi_nor *nor)
>  {
>  	struct spi_nor_flash_parameter *params = nor->params;
>  
> -	if (!params->n_dice || !params->vreg_offset) {
> -		dev_err(nor->dev, "%s failed. The volatile register offset could not be retrieved from SFDP.\n",
> -			__func__);
> -		return -EOPNOTSUPP;
> -	}
> -
>  	/* Fast Read 4B requires mode cycles */
>  	params->reads[SNOR_CMD_READ_FAST].num_mode_clocks = 8;
>  	params->ready = cypress_nor_sr_ready_and_clear;
> @@ -694,6 +672,17 @@ static int cypress_nor_set_octal_dtr(struct spi_nor *nor, bool enable)
>  static int s28hx_t_post_sfdp_fixup(struct spi_nor *nor)
>  {
>  	struct spi_nor_flash_parameter *params = nor->params;
> +
> +	if (!params->n_dice || !params->vreg_offset) {
> +		dev_err(nor->dev, "%s failed. The volatile register offset could not be retrieved from SFDP.\n",
> +			__func__);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* The 2 Gb parts duplicate info and advertise 4 dice instead of 2. */
> +	if (params->size == SZ_256M)
> +		params->n_dice = 2;
> +
>  	/*
>  	 * On older versions of the flash the xSPI Profile 1.0 table has the
>  	 * 8D-8D-8D Fast Read opcode as 0x00. But it actually should be 0xEE.
> @@ -719,10 +708,6 @@ static int s28hx_t_post_sfdp_fixup(struct spi_nor *nor)
>  	 */
>  	params->rdsr_addr_nbytes = 4;
>  
> -	/* The 2 Gb parts duplicate info and advertise 4 dice instead of 2. */
> -	if (params->size == SZ_256M)
> -		params->n_dice = 2;
> -
>  	return cypress_nor_get_page_size(nor);
>  }
>  
> @@ -737,12 +722,6 @@ static int s28hx_t_late_init(struct spi_nor *nor)
>  {
>  	struct spi_nor_flash_parameter *params = nor->params;
>  
> -	if (!params->n_dice || !params->vreg_offset) {
> -		dev_err(nor->dev, "%s failed. The volatile register offset could not be retrieved from SFDP.\n",
> -			__func__);
> -		return -EOPNOTSUPP;
> -	}
> -
>  	params->set_octal_dtr = cypress_nor_set_octal_dtr;
>  	params->ready = cypress_nor_sr_ready_and_clear;
>  	cypress_nor_ecc_init(nor);

All other S25Hx and S28Hx devices work fine.

Thanks,
Takahiro

