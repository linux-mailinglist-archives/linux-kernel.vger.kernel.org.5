Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9713280726C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378865AbjLFOaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378832AbjLFOaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:30:10 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91A6D40
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:30:15 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c9f572c4c5so64178341fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 06:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701873013; x=1702477813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ecDK9XgOWPDwKNtXxUXDKXSM0zmyupQJGPO18jvHP6A=;
        b=fG9Xra+RRWmWRTGa0vySPcEsTKVcOE51X/E33gXUqlEtZfJlEG9xb2G8QUzpi33dXV
         BUtdqucaZQhhsLhnjnNAdAf8N51BSM1YPVMT9xrRjwED+QGASuVSui+IU37jBRt85tPP
         ZYJqLpbRtYbY2jQSIAd49whUflpitWL9D/vh381gK33IkQdIBYTlhbjDGArN8P1haTep
         sHeUApGcYNsAi2LJxMEW3e6Lba3mBPs+TH00xxX2f0cPv+C6pyZgdncPlaaTUMb4nucV
         bPdXs3WiaEKnaCBFkWb7hwf54LFooICmHGTIRU3JX2Z5/7F4QONrCVGtVix47j3oMTwV
         gp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701873013; x=1702477813;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ecDK9XgOWPDwKNtXxUXDKXSM0zmyupQJGPO18jvHP6A=;
        b=O7FtXtq8GeRuGnusDKGOydyawhPZU3gc64pgrVIEDQ9yCmo0jInpyIAJZ51F1r5Qzv
         U7jRbfVsXh2jP8WEkZzNFc1fCmrbzPggHpt+DLuVnI4ZOeNxwzn+v2a9fitj6BgDkcI2
         bBMY7fH5IoXoYhYYJECphzdkVqOvVxwK2k4kNLeNErtaMiq1DrYWok/S+u1D0bRSPici
         tKP5A+xrpsn+jkXjJup4YDXuZApMgAP5L6IfgpzdEzLbr9bzUvvkTc6j6X3r1p961UCd
         PBL/KzVn0fSZXUQBiTC50sIFaBw8JBX0ph/9DzEdDgWKk9znJkHVLlSg7gSpuBj7eoT9
         ebAQ==
X-Gm-Message-State: AOJu0YxrIr6TbwLoi8M7W6mpIs9moErcoXchzWMw4sTUZ8VHetVPsHez
        7Hjw6JwvgHNO7yWIS9/x2+Dikw==
X-Google-Smtp-Source: AGHT+IFFLwb6J1kg4M4UnYbam4jWK0loSvNCLNafUtgmro7h6iWF18QP/GUyGS9AQ5j9Y3MfsdsiMQ==
X-Received: by 2002:a05:6512:29a:b0:50c:d30:3a05 with SMTP id j26-20020a056512029a00b0050c0d303a05mr695875lfp.25.1701873013467;
        Wed, 06 Dec 2023 06:30:13 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id gs20-20020a170906f19400b00a18374ade6bsm8391001ejb.67.2023.12.06.06.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 06:30:12 -0800 (PST)
Message-ID: <e2305642-55f1-4893-bea3-b170ac0a5348@linaro.org>
Date:   Wed, 6 Dec 2023 14:30:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Content-Language: en-US
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        broonie@kernel.org, pratyush@kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, sbinding@opensource.cirrus.com,
        lee@kernel.org, james.schulman@cirrus.com, david.rhodes@cirrus.com,
        rf@opensource.cirrus.com, perex@perex.cz, tiwai@suse.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, linux-mtd@lists.infradead.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@tuxon.dev, michal.simek@amd.com,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        git@amd.com, amitrkcian2002@gmail.com
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-8-amit.kumar-mahapatra@amd.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20231125092137.2948-8-amit.kumar-mahapatra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Amit,

On 11/25/23 09:21, Amit Kumar Mahapatra wrote:
> Each flash that is connected in stacked mode should have a separate
> parameter structure. So, the flash parameter member(*params) of the spi_nor
> structure is changed to an array (*params[2]). The array is used to store
> the parameters of each flash connected in stacked configuration.
> 
> The current implementation assumes that a maximum of two flashes are
> connected in stacked mode and both the flashes are of same make but can
> differ in sizes. So, except the sizes all other flash parameters of both
> the flashes are identical.

Do you plan to add support for different flashes in stacked mode? If
not, wouldn't it be simpler to have just an array of flash sizes instead
of duplicating the entire params struct?

> 
> SPI-NOR is not aware of the chip_select values, for any incoming request
> SPI-NOR will decide the flash index with the help of individual flash size
> and the configuration type (single/stacked). SPI-NOR will pass on the flash
> index information to the SPI core & SPI driver by setting the appropriate
> bit in nor->spimem->spi->cs_index_mask. For example, if nth bit of
> nor->spimem->spi->cs_index_mask is set then the driver would
> assert/de-assert spi->chip_slect[n].
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---
>  drivers/mtd/spi-nor/core.c  | 272 +++++++++++++++++++++++++++++-------
>  drivers/mtd/spi-nor/core.h  |   4 +
>  include/linux/mtd/spi-nor.h |  15 +-
>  3 files changed, 240 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 93ae69b7ff83..e990be7c7eb6 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c

cut

> @@ -2905,7 +3007,10 @@ static void spi_nor_init_fixup_flags(struct spi_nor *nor)
>  static int spi_nor_late_init_params(struct spi_nor *nor)
>  {
>  	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
> -	int ret;
> +	struct device_node *np = spi_nor_get_flash_node(nor);
> +	u64 flash_size[SNOR_FLASH_CNT_MAX];
> +	u32 idx = 0;
> +	int rc, ret;
>  
>  	if (nor->manufacturer && nor->manufacturer->fixups &&
>  	    nor->manufacturer->fixups->late_init) {
> @@ -2937,6 +3042,44 @@ static int spi_nor_late_init_params(struct spi_nor *nor)
>  	if (params->n_banks > 1)
>  		params->bank_size = div64_u64(params->size, params->n_banks);
>  
> +	nor->num_flash = 0;
> +
> +	/*
> +	 * The flashes that are connected in stacked mode should be of same make.
> +	 * Except the flash size all other properties are identical for all the
> +	 * flashes connected in stacked mode.
> +	 * The flashes that are connected in parallel mode should be identical.
> +	 */
> +	while (idx < SNOR_FLASH_CNT_MAX) {
> +		rc = of_property_read_u64_index(np, "stacked-memories", idx, &flash_size[idx]);

This is a little late in my opinion, as we don't have any sanity check
on the flashes that are stacked on top of the first. We shall at least
read and compare the ID for all.

Cheers,
ta
