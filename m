Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0297516D8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjGMDoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbjGMDoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:44:08 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8922213C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:44:01 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b708e49059so2409261fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689219840; x=1691811840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CTbP1J/nwSjcXc7oGaL+bm/G4DKvNXMu7J3uatvOts8=;
        b=LzYjIz0eKJ+o/UWAmmsgfqVJOA1psg+NeklD99vZZrKysIsFzn7kvdqowRUo6DcKc8
         edsE3s4ux7XOtFXCHe6iGNbPOQXOpviCYf9ba9gNOY3tjtTpIqAMk+0Yz9D4ZMtYGdHQ
         3/3pFNYG7MN3Pp+HXRkwsmsnysEmH7DDCsNIOrR3E47JMQVoTsq92YbSeMfDKI+OvJDi
         yOVMeld5zffDEKOToL+LPrbxrPKO7K1MwQWNdiYeAdm6/hlZTWPeb8Ie/in7iEwzcSjx
         1+nyus0js/G7Y22WVKszxu/99xWQ1h0RAW2erUM7trr8mUQ4tdtE30h43TaKF2jPW8SY
         Ro+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689219840; x=1691811840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTbP1J/nwSjcXc7oGaL+bm/G4DKvNXMu7J3uatvOts8=;
        b=BcHjh4vcsA62ucbxXUwQ5RJkNqdLJupzabdHB+E/aQ1JVpmAYYeRxv0WV7GcjN9md5
         lBzZteg2X6XS3tbBboFttOOogy+MbKhlNUEWqTpNo2a75GbgYUk5rrMoOPlhM2rgh6Zr
         BO/KdjHrm/PatJB+mZCb+jATgtEwph12F88M28JFVyM0zgn7gu6HnW3s2xoTsw5LiakI
         Psne16x5/Aefp993KFNfeAUNgAJnX/yvTX1mBHmbEkiE1sRGOguBUX0I9Uo174ft/anA
         SBFwIC0IFppzH+MJIb58ZUg+sLd0/LaqjtOfGa9LF0LK0XQFd3K4TbR3mjvVZ8f3cedY
         Qihg==
X-Gm-Message-State: ABy/qLaA6nvjBbihFNEdOiFgMKWkpqrfs7u6HQB4s3S/lA+3NnmZn3pG
        9mcv/3MRsJuI12hiSYz4CZ2IQSHS3P57qazbwug=
X-Google-Smtp-Source: APBJJlGF7GVH8kjO6cwksonghpUEBQvgHWbMEBanqIT6DT7j1keMqjRkNlU4G/0MeBcxb7F0cr7aYg==
X-Received: by 2002:a2e:9a8a:0:b0:2b4:765b:f6ee with SMTP id p10-20020a2e9a8a000000b002b4765bf6eemr200703lji.41.1689219839633;
        Wed, 12 Jul 2023 20:43:59 -0700 (PDT)
Received: from [192.168.0.173] ([79.115.63.146])
        by smtp.gmail.com with ESMTPSA id v6-20020aa7cd46000000b0051e3385a395sm3690688edw.3.2023.07.12.20.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 20:43:59 -0700 (PDT)
Message-ID: <19800e51-a871-be9f-9eb5-5829237e2613@linaro.org>
Date:   Thu, 13 Jul 2023 06:43:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] mtd: micron-st: enable lock/unlock for mt25qu512a
Content-Language: en-US
To:     Mamta Shukla <mamta.shukla@leica-geosystems.com>,
        pratyush@kernel.org, michael@walle.cc, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     bsp-development.geo@leica-geosystems.com
References: <20230705154942.3936658-1-mamta.shukla@leica-geosystems.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230705154942.3936658-1-mamta.shukla@leica-geosystems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05.07.2023 18:49, Mamta Shukla wrote:
> mt25qu512a[1] supports locking/unlocking through BP bits in SR.
> 
> Tested using mtd-utils- flash_lock/flash_unlock for MT25QU512ABB8E12.
> 
> Link: https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-b/mt25q_qlkt_u_512_abb_0.pdf?rev=b259aadc3bea49ea8210a41c9ad58211
> Signed-off-by: Mamta Shukla <mamta.shukla@leica-geosystems.com>
> ---
>  Changes in v2:
>  - add Link tag
>  - fix chip part number mt25ql512a->mt25qu512a
> 
>  drivers/mtd/spi-nor/micron-st.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
> index 4b919756a205..08e94340ebaa 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -229,6 +229,8 @@ static const struct flash_info st_nor_parts[] = {
>  		MFR_FLAGS(USE_FSR)
>  	},
>  	{ "mt25qu512a",  INFO6(0x20bb20, 0x104400, 64 * 1024, 1024)
> +		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
> +		      SPI_NOR_BP3_SR_BIT6)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
>  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
>  		MFR_FLAGS(USE_FSR)

Can you try the following instead? We try to use SFDP parsing whenever
possible.
	{ "mt25qu512a",  INFO6(0x20bb20, 0x104400, 0, 0)
		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
		SPI_NOR_BP3_SR_BIT6)
		PARSE_SFDP
		MFR_FLAGS(USE_FSR)

You then have to dump the SFDP tables and do a sanity check to make sure
everything's fine after your changes. You can an example on how to do
that on the commit message from
https://lore.kernel.org/linux-mtd/8b7d2420-26b6-405b-8ef7-75e0a0201402@linaro.org/T/#m3550973e0884ec4a288d344fabd4a9c3b64af46e
