Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041F8793678
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjIFHk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjIFHk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:40:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3901F1702
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:40:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bcfe28909so479939866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 00:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693985999; x=1694590799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=orvUtnN2ovbrorDPALco13qgAyfYNfZYZYYlqBkdr5o=;
        b=ByfFeEMqIEYJ0J68EyaLt3GA1d1hTbsNN9a+qE8HVY5i1oHuPfLhdBp2JIlO1Q61c1
         uLmm2ysQBv+ho5FWNST4d5s+MHng1mAhvEEqY+0VlT0UwmgzI3Vr923QoApFjo0pHPlX
         +ddghVCHwSvPD1vU6XUERDojr3douVqXQ19G6NWaQKVzuc0uowdyOdn1bY3szC/gL2S+
         8mbDlW2IOh3BJS/sLnaEkCeEHyOEDoxaxNOqlhH6D6hpovM4b5mIC8tUQ9R7smpgRw0y
         +5bYO7Y2GwU0OHQS2GOlfNEMcDVu5f/UsTR0LPosGBiZ/98zbk3hl1+KkODNT/KoJRBw
         qoig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693985999; x=1694590799;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=orvUtnN2ovbrorDPALco13qgAyfYNfZYZYYlqBkdr5o=;
        b=EF68gGNZW3lYAgxMskJfuZ74frA5G8DKSezMEdhEtDjm6QpUMiSzQ1fZuLo67Orgp/
         zfObTugc0abs/Ix/OwRIYejxR1sPkmkWuI2vpHVNiPi9jcEyBaZoRuMZj3Jjfw7alvgC
         6WrpzVIQ9XBWxbB9Hvto+vTGXQAZXtOqr6Pzu4sG0TC3qXLxCRC8m8L1XYr2aq3xqbbP
         8TLMOMu8v9x4RV3ml/2ShoAWOtdmlF5/SvL21BXeEWJZBeA/AnD6Jznb3RlvgVXi2F11
         DwjurZeitTMENSYFSCAuU0xlysgijiph5O2L6rXhx2RBvjELg5PYZNbLzFae0JuoMz+6
         Vy2w==
X-Gm-Message-State: AOJu0Ywt562K/aYQ+hQdqS4uUoW8kVVbCyHzQV3BS6v1c/2mPe2NEtaF
        E8TDFv96CGVXiGlCAlfyFcksUw==
X-Google-Smtp-Source: AGHT+IHiQSnCMmZF2IYo0dQojmRNvIMHTjIHbz8K7G0CiRy1PCg/A0xcmeRnekZzhuBTvgBwx/GFqg==
X-Received: by 2002:a17:907:a056:b0:9a6:4f23:9d8f with SMTP id gz22-20020a170907a05600b009a64f239d8fmr1555676ejc.47.1693985999381;
        Wed, 06 Sep 2023 00:39:59 -0700 (PDT)
Received: from [192.168.0.173] ([79.115.63.137])
        by smtp.gmail.com with ESMTPSA id c11-20020a170906924b00b009929ab17be0sm8607665ejx.162.2023.09.06.00.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 00:39:58 -0700 (PDT)
Message-ID: <47dbbc77-6ff4-2a5e-213e-f909ee90805f@linaro.org>
Date:   Wed, 6 Sep 2023 10:39:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 40/41] mtd: spi-nor: atmel: drop duplicate entry
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-40-291a0f39f8d8@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v2-40-291a0f39f8d8@kernel.org>
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
> The Atmel AT26DF321 and AT25DF321 have the same ID. Both were just
> discovered by reading their IDs, that is, there is no probing by name.
> Thus only the first one in the list was ever probed. The AT25DF is the
> newer series. Drop the older one.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>

keep the first entry, to have the name backward compatible. It's not a
hard rule to have the name backward compatible, but if we can, let's
keep it.


Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/mtd/spi-nor/atmel.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
> index 18e904962d0e..95f0e139284e 100644
> --- a/drivers/mtd/spi-nor/atmel.c
> +++ b/drivers/mtd/spi-nor/atmel.c
> @@ -206,13 +206,6 @@ static const struct flash_info atmel_nor_parts[] = {
>  		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
>  		.no_sfdp_flags = SECT_4K,
>  		.fixups = &atmel_nor_global_protection_fixups
> -	}, {
> -		.id = SNOR_ID(0x1f, 0x47, 0x00),
> -		.name = "at26df321",
> -		.size = SZ_4M,
> -		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
> -		.no_sfdp_flags = SECT_4K,
> -		.fixups = &atmel_nor_global_protection_fixups
>  	}, {
>  		.id = SNOR_ID(0x1f, 0x47, 0x01),
>  		.name = "at25df321a",
> 
