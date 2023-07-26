Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CCC763270
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjGZJhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjGZJh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:37:26 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BED21BE8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:36:35 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666e6541c98so6074686b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690364195; x=1690968995;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nk61oX1/MYUdyW6PNrc230vTitw/FwpBYWVnoTlWaUA=;
        b=No2cHOzQ7eUv+boiODVr0cWIKqjTwcXftOWUG+y1SDZfTYGHtNZzoesK5eIoc2R+gR
         AyBug9ruIOHc0gRXqoYy6jcvfoWcntvDLEOyVp5YMRFAsd0JQu+6+Hr16oq0EapmcygN
         J2iuyp8oY4RbCWlWzft4k/sq/vjH9y2ktsztnnEpaHcg1TNQGXj0brbP9Yp7CMhvAfvH
         /6/Vg1oW+5ZFEmOYT+BJGhxuT82yj0wbfYifkkt15HFRwU/qpPEIurYPDlqAi6TPZ23G
         Zo/7Xi9VsQUAydvnBd3acC+Emk2yrkHe2DFaBlzAYTKjfgjJyOZm2pcbUBdmLapFj9B0
         s6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690364195; x=1690968995;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nk61oX1/MYUdyW6PNrc230vTitw/FwpBYWVnoTlWaUA=;
        b=KPr0mCD5vxwzZmNQqmfAzbx5FNLJeLHf9wlJNp/ymMQsS1MJaen0VloBwdl7ti3TUl
         DaoMBmn+p9vehG+Dhvpc8xBHemQQhT37k/Pe2i3DHANXH+Sv/udKzEjpcJ4luiggk3lH
         kT+fE/qJ+ZFSe2HWMMrhO0gT41jyvTDQOM0uepEDnIk+ouTdBdhI8ehA6SMJ77WXv0mW
         T6W21dhdsR7dNRtAaQlRYIeOGj+5uh63C80OuG9B+Ar0zCWAS5jedfx8Y02nZGx9RsWK
         6aiTKIONJ6WUubtJZGPUG3pxG/6bSD6jS07O4JFRI59vFXPG6aN8pAUamdDSzYM/y0op
         wXfw==
X-Gm-Message-State: ABy/qLaVjYCc/cILS9LydtfrpudxpMzMUurAUccSAl9t1yOqOoUdjvA4
        TVDlVhzU+1WAeQk2dXrEL2jHW2sHXu8=
X-Google-Smtp-Source: APBJJlErSx6YYmSKdDYLYtHeTkpzTtINxCEcSouXrYVFjm+IbJc5RiimhEkKxn72ZFv3PcO0Rijecg==
X-Received: by 2002:a05:6a00:2e23:b0:67e:6269:6ea8 with SMTP id fc35-20020a056a002e2300b0067e62696ea8mr2280925pfb.22.1690364194780;
        Wed, 26 Jul 2023 02:36:34 -0700 (PDT)
Received: from [192.168.0.11] (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id f13-20020aa78b0d000000b006815fbe3245sm11043330pfd.37.2023.07.26.02.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 02:36:34 -0700 (PDT)
Message-ID: <16f29fd8-ae31-bb93-3ccf-e722faf033ba@gmail.com>
Date:   Wed, 26 Jul 2023 18:36:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 10/11] mtd: spi-nor: spansion: switch s25hx_t to use
 vreg_offset for quad_enable()
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        takahiro.kuwano@infineon.com, michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at
References: <20230726075257.12985-1-tudor.ambarus@linaro.org>
 <20230726075257.12985-11-tudor.ambarus@linaro.org>
From:   Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <20230726075257.12985-11-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/2023 4:52 PM, Tudor Ambarus wrote:
> All s25hx_t flashes have single or multi chip flavors and already use
> n_dice and vreg_offset in cypress_nor_sr_ready_and_clear. Switch s25hx_t
> to always use vreg_offset for the quad_enable() method, so that we use
> the same code base for both single and multi chip package flashes.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/mtd/spi-nor/spansion.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
> index 30a3ffbfa381..6abef5b515a1 100644
> --- a/drivers/mtd/spi-nor/spansion.c
> +++ b/drivers/mtd/spi-nor/spansion.c
> @@ -24,8 +24,6 @@
>  #define SPINOR_REG_CYPRESS_STR1V					\
>  	(SPINOR_REG_CYPRESS_VREG + SPINOR_REG_CYPRESS_STR1)
>  #define SPINOR_REG_CYPRESS_CFR1			0x2
> -#define SPINOR_REG_CYPRESS_CFR1V					\
> -	(SPINOR_REG_CYPRESS_VREG + SPINOR_REG_CYPRESS_CFR1)
>  #define SPINOR_REG_CYPRESS_CFR1_QUAD_EN		BIT(1)	/* Quad Enable */
>  #define SPINOR_REG_CYPRESS_CFR2			0x3
>  #define SPINOR_REG_CYPRESS_CFR2V					\
> @@ -348,10 +346,6 @@ static int cypress_nor_quad_enable_volatile(struct spi_nor *nor)
>  	u8 i;
>  	int ret;
>  
> -	if (!params->n_dice)
> -		return cypress_nor_quad_enable_volatile_reg(nor,
> -						SPINOR_REG_CYPRESS_CFR1V);
> -
>  	for (i = 0; i < params->n_dice; i++) {
>  		addr = params->vreg_offset[i] + SPINOR_REG_CYPRESS_CFR1;
>  		ret = cypress_nor_quad_enable_volatile_reg(nor, addr);
> @@ -657,15 +651,17 @@ static int s25hx_t_late_init(struct spi_nor *nor)
>  {
>  	struct spi_nor_flash_parameter *params = nor->params;
>  
> +	if (!params->n_dice || !params->vreg_offset) {
> +		dev_err(nor->dev, "%s failed. The volatile register offset could not be retrieved from SFDP.\n",
> +			__func__);
> +		return -EOPNOTSUPP;
> +	}
> +
>  	/* Fast Read 4B requires mode cycles */
>  	params->reads[SNOR_CMD_READ_FAST].num_mode_clocks = 8;
> -
> +	params->ready = cypress_nor_sr_ready_and_clear;
>  	cypress_nor_ecc_init(nor);
>  
> -	/* Replace ready() with multi die version */
> -	if (params->n_dice)
> -		params->ready = cypress_nor_sr_ready_and_clear;
> -
>  	return 0;
>  }
>  

Tested-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
