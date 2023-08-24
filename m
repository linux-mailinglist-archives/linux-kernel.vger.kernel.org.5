Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7030B78691B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbjHXH5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240265AbjHXH4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:56:33 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34EB172A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:56:26 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50079d148aeso7093572e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692863785; x=1693468585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PynNwQCUX3wPzw5dhP2cH8FHvUX1+YwHm6lT7fEr4Fk=;
        b=Q583OY567Bl90SHbnnP8GzT0CrUcmo7WHAL1aezYrO1e0h3Vx9t6IyOXR4eOv9A7jZ
         VAz8x8FiVxxeCc7r+omdb7yfqtOa1oG+lQdtR9wDyz7nYO2K80R2Nauvl5Nv8hqLKFKq
         8GX0i+nanDBBNoP5xgiB+VkTGu64nLfPW9BvEd/KYpamN48PAOqU7Og56JuF6ye4QHcj
         org84G0aHZyh7v1cx7wwB6DcaLKIbCtpn2x8KP22ogjPpgL9we7tJRX4JfpI05wZeq4o
         Ai8oyCseik/si85OVXxgPaMrcy2KeucUHnVrJnh1eeHk+KHlwld88xiST/0WN6dJZ9p4
         KCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692863785; x=1693468585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PynNwQCUX3wPzw5dhP2cH8FHvUX1+YwHm6lT7fEr4Fk=;
        b=ZTbHHAUPNW5tiGoefko53qNStrp+jdafAVXRd/VIqRx6CDmgJ8HB6+4yvwxsTMFd7r
         zbrLSdT0H1yJcwzamlPM07pixRLuu2J9uV+CypUdZ0HYiNjrYrYtP6dTmtl1I0ETWT+2
         vGNYLWlUmiCJPo2LqAVvDmlCyDH/EAY3MUJJPPqtuRRjJhImMwO8TCEs1BbRRYTkygXy
         BBAn6vFauUgyijKR/Xr+3/1cvgymxp4bPX/g3AwVd7aFcxbOjVeZ8sb5meNCvk3yaBXG
         IfHnqMgj2PQOOeHJVZF5VhtNElyortNL0P0j3duEFWWVd0+uTNt1uNxZ08Gaur8LUtPx
         byxg==
X-Gm-Message-State: AOJu0YzBQlaDVnedRw22e5xHAOHWbF+0h5kQ6RmevdsV4NGz3xsBiEB7
        RBozUcVXQJb+m7n+jUOA3fwdhg==
X-Google-Smtp-Source: AGHT+IGogkwj/BkRT7dmk4avq99JLxp+gAOVq9hqdVhkIM2YvZFwShINXNgwOOYe7tblzzn44DMcrg==
X-Received: by 2002:a19:520b:0:b0:4ff:9a75:211e with SMTP id m11-20020a19520b000000b004ff9a75211emr9576748lfb.42.1692863784938;
        Thu, 24 Aug 2023 00:56:24 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.239])
        by smtp.gmail.com with ESMTPSA id s10-20020a05600c044a00b003fbe791a0e8sm1926510wmb.0.2023.08.24.00.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 00:56:24 -0700 (PDT)
Message-ID: <ccaf038f-e11a-7669-7f35-5c0405d7ac98@linaro.org>
Date:   Thu, 24 Aug 2023 08:56:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2 02/41] mtd: spi-nor: remove Fujitsu MB85RS1MT support
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-2-291a0f39f8d8@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v2-2-291a0f39f8d8@kernel.org>
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
> This part is not a flash but an EEPROM like FRAM. It is even has a DT
> binding for the (correct) driver (at25), see
> Documentation/devicetree/bindings/eeprom/at25.yaml. Just remove it.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/mtd/spi-nor/Makefile  |  1 -
>  drivers/mtd/spi-nor/core.c    |  1 -
>  drivers/mtd/spi-nor/core.h    |  1 -
>  drivers/mtd/spi-nor/fujitsu.c | 21 ---------------------
>  4 files changed, 24 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
> index 496dae9ca0f3..5e68468b72fc 100644
> --- a/drivers/mtd/spi-nor/Makefile
> +++ b/drivers/mtd/spi-nor/Makefile
> @@ -5,7 +5,6 @@ spi-nor-objs			+= atmel.o
>  spi-nor-objs			+= eon.o
>  spi-nor-objs			+= esmt.o
>  spi-nor-objs			+= everspin.o
> -spi-nor-objs			+= fujitsu.o
>  spi-nor-objs			+= gigadevice.o
>  spi-nor-objs			+= intel.o
>  spi-nor-objs			+= issi.o
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index c44de69c4353..286155002cdc 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2002,7 +2002,6 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
>  	&spi_nor_eon,
>  	&spi_nor_esmt,
>  	&spi_nor_everspin,
> -	&spi_nor_fujitsu,
>  	&spi_nor_gigadevice,
>  	&spi_nor_intel,
>  	&spi_nor_issi,
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 6d31af6c39ed..dfc20a3296fb 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -634,7 +634,6 @@ extern const struct spi_nor_manufacturer spi_nor_atmel;
>  extern const struct spi_nor_manufacturer spi_nor_eon;
>  extern const struct spi_nor_manufacturer spi_nor_esmt;
>  extern const struct spi_nor_manufacturer spi_nor_everspin;
> -extern const struct spi_nor_manufacturer spi_nor_fujitsu;
>  extern const struct spi_nor_manufacturer spi_nor_gigadevice;
>  extern const struct spi_nor_manufacturer spi_nor_intel;
>  extern const struct spi_nor_manufacturer spi_nor_issi;
> diff --git a/drivers/mtd/spi-nor/fujitsu.c b/drivers/mtd/spi-nor/fujitsu.c
> deleted file mode 100644
> index 69cffc5c73ef..000000000000
> --- a/drivers/mtd/spi-nor/fujitsu.c
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2005, Intec Automation Inc.
> - * Copyright (C) 2014, Freescale Semiconductor, Inc.
> - */
> -
> -#include <linux/mtd/spi-nor.h>
> -
> -#include "core.h"
> -
> -static const struct flash_info fujitsu_nor_parts[] = {
> -	/* Fujitsu */
> -	{ "mb85rs1mt", INFO(0x047f27, 0, 128 * 1024, 1)
> -		FLAGS(SPI_NOR_NO_ERASE) },
> -};
> -
> -const struct spi_nor_manufacturer spi_nor_fujitsu = {
> -	.name = "fujitsu",
> -	.parts = fujitsu_nor_parts,
> -	.nparts = ARRAY_SIZE(fujitsu_nor_parts),
> -};
> 
