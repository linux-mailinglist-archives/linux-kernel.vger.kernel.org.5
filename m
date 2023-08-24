Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBB9786A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbjHXIgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240525AbjHXIg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:36:29 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2CF1724
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:36:27 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c136ee106so843385966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692866186; x=1693470986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sWopwPv8ous9ki9Iav1zXX25cx/NnM092QNuDsTCdtc=;
        b=zN9OqJoiScNS/SIxQD/qp958oo9i0Nu+Ikxx5e84AtGXc/xJzcSLNTW7d4EGg2V36Q
         i0nR/za34WgDGrAX0wO5LKXimIadfV/TdyxTAFg6LZB/SWGpcxGccsPmf+tbeUGbQzP5
         nSrcyVXMNjdPrTgA6r4eocDlSkd5BYn8Sjar5mbhx0VdCkNWhb0Taw7453hhdrOSr3Se
         XHa6CQrw7qhqwmcG+Rz7LOy/o5YNJc/Q7pGjyLgJtGXiQkQywPthBYC9/9YQpIvcPGhd
         M6CHRikJOr4Z0wz35Yckkq+pKMtFUq7Vk484HV+aDirhCR+LaRCqAuzJHiJzjsyQ86VX
         inJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692866186; x=1693470986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWopwPv8ous9ki9Iav1zXX25cx/NnM092QNuDsTCdtc=;
        b=ham3ywIj0Jri3fUbtIqKto9uYbnUHcHJNMBnohrkbCleQONJaP7XEqfCM4JgqxAMvl
         7vekw47v1uaG/a+EZe9TPccqVuxrxVit+dciqDEaBddP4QR9KWBBnO53bGlemLequ7Kl
         WR4GV3az5mWrx5uG3El4ig04Bg7vdkjWpmzx6B/6qKr2t3/wzQAOteAa2f9SwVyVnao/
         5SvuxUF0ibBabDFPEjc1fpm9XTxrefZunZJkHcxQR6uC+nkL3FeXwPmSSDR2rZ8utUD4
         FYWbWF0rqI2xo3RdIQU5sOWIaIibcFtbz3+LapiQ3EW9cSOTq19b9pIISv3bT8mVxwiO
         UX1w==
X-Gm-Message-State: AOJu0YzNyO5T1VAGqPyBqyEbhkVEGCrOgPSZ6hbKpVn37GFajGYPpsEL
        xJ+3Z/OaNonZmClGsA+yusacTA==
X-Google-Smtp-Source: AGHT+IHLbz9eBqluFsAUpDNy5UWDgtlm/GcG0LRUnCkx35YQQ6S2YlTWQbYe0B/t5xl9+VtDkroHrw==
X-Received: by 2002:a17:906:5c3:b0:9a1:b52a:beee with SMTP id t3-20020a17090605c300b009a1b52abeeemr5219374ejt.64.1692866186194;
        Thu, 24 Aug 2023 01:36:26 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.239])
        by smtp.gmail.com with ESMTPSA id z1-20020a170906240100b0097073f1ed84sm10730467eja.4.2023.08.24.01.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 01:36:25 -0700 (PDT)
Message-ID: <f8fe1378-686f-5889-8f0f-e1cda237ee3f@linaro.org>
Date:   Thu, 24 Aug 2023 09:36:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2 06/41] mtd: spi-nor: default page_size to 256 bytes
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-6-291a0f39f8d8@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v2-6-291a0f39f8d8@kernel.org>
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
> The INFO() macro always set the page_size to 256 bytes. Make that an
> optional parameter. This default is a sane one for all older flashes,
> newer ones will set the page size by its SFDP tables anyway.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/spi-nor/core.c | 7 +------
>  drivers/mtd/spi-nor/core.h | 8 ++++++--
>  2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index f4cc2eafcc5e..d27ad1295ee0 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2018,11 +2018,6 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
>  static const struct flash_info spi_nor_generic_flash = {
>  	.name = "spi-nor-generic",
>  	.n_banks = 1,
> -	/*
> -	 * JESD216 rev A doesn't specify the page size, therefore we need a
> -	 * sane default.
> -	 */
> -	.page_size = 256,
>  	.parse_sfdp = true,
>  };
>  
> @@ -3001,7 +2996,7 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
>  	params->writesize = 1;
>  	params->size = info->size;
>  	params->bank_size = params->size;
> -	params->page_size = info->page_size;
> +	params->page_size = info->page_size ?: SPI_NOR_DEFAULT_PAGE_SIZE;

how about to get rid of info->page_size entirely and directly use the
default?
