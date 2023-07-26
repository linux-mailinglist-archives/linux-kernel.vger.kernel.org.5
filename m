Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A168B763276
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjGZJi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjGZJhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:37:54 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076A0271B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:37:25 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686baccf661so711797b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690364245; x=1690969045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pbMdrz248O7BLJa1aLDDOR2eghYsSzQm2AIXBS8r1OQ=;
        b=q0euknq/4bvrmZKnU0EX15hLdlUIMLI+/co6+9dYcn9y5ctA68nCG144eqw0Dk8teF
         KVjBdQDqhbVE9/cQ2rmB2cL42FBUqEVGtuTR32fW1PlEuy1BG+Scqb+JpAXMCTCjog2H
         3aD+GvuMabNFHF+TEafQF+R12auLdYlQCAG83/HPlfHJUIHji94mbNnDvIkn5Pq1SsQY
         OdCbl0W+R2Q7bhs8ZK/j0ijApy96BoCXsU/TM2/6xwJS3u9xvcVMSjlJ9q0UsQ3UcFqp
         wx9H+qc1knnKFA2owk5+tsuQpn3c043HcKSr8wdecfwrxXLUugMk3TBRdapZRKU7+cRB
         ZaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690364245; x=1690969045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbMdrz248O7BLJa1aLDDOR2eghYsSzQm2AIXBS8r1OQ=;
        b=Dd3KR4hoXcmf3gw6SwnezpVxhekCZUJBv+gMGwRuQS/zDjq5C5dEdHzSTlrQyQXI+X
         XoBNvkBqKtnO59XByl0tQsmxscPeztfxhAAo4H+ploAvkoutKI8raCimjTCtWAvX6LaQ
         /VowCn1CeuQ4r1QjCeYjgaIO4o5nhagfC6SUV1ibDmKwTt+cv+JME0Qsplbd0U2kSNHf
         9yxaRlqPjKv9IE5eeKHluNPL1U7MHmFigJhQOOL3Hm9xmNzq3KItTwopZ2IatXydKZBe
         i/xXBXtbXs9fmV0YjpnZZtUbDPEwae0edawYBKBUKN7mdKYI8x2YpU+fzeuygEZTnmO7
         SdIw==
X-Gm-Message-State: ABy/qLZgdrP3AwJYONqF/dYmTELujSIirY6u8j94X2wHo62wY+F3UAtM
        tqkg+cOG/U4kcPK2/4Fri8Q=
X-Google-Smtp-Source: APBJJlHdtwcTal98+4CgceUf/WoACIQ/0R2Z2XI7/kx1iXSXyDj50UGS1XhalZqhTBFwhBJzG5UGJg==
X-Received: by 2002:a05:6a21:3383:b0:138:1c5b:2653 with SMTP id yy3-20020a056a21338300b001381c5b2653mr1359756pzb.41.1690364245264;
        Wed, 26 Jul 2023 02:37:25 -0700 (PDT)
Received: from [192.168.0.11] (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78752000000b00686c40ccaf2sm992250pfo.9.2023.07.26.02.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 02:37:24 -0700 (PDT)
Message-ID: <3464becc-b2d1-02f1-4214-2bc69edddca4@gmail.com>
Date:   Wed, 26 Jul 2023 18:37:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 09/11] mtd: spi-nor: spansion: let SFDP determine the
 flash and sector size
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        takahiro.kuwano@infineon.com, michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at
References: <20230726075257.12985-1-tudor.ambarus@linaro.org>
 <20230726075257.12985-10-tudor.ambarus@linaro.org>
From:   Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <20230726075257.12985-10-tudor.ambarus@linaro.org>
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
> sector_size is used to determine the flash size and the erase size in
> case of uniform erase. n_sectors is used to determine the flash_size.
> But the flash size and the erase sizes are determined when parsing SFDP,
> let SFDP determine them.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/mtd/spi-nor/spansion.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
> index 1c5671a3751a..30a3ffbfa381 100644
> --- a/drivers/mtd/spi-nor/spansion.c
> +++ b/drivers/mtd/spi-nor/spansion.c
> @@ -873,11 +873,11 @@ static const struct flash_info spansion_nor_parts[] = {
>  		PARSE_SFDP
>  		MFR_FLAGS(USE_CLPEF)
>  		.fixups = &s25fs256t_fixups },
> -	{ "s25hl512t",  INFO6(0x342a1a, 0x0f0390, 256 * 1024, 256)
> +	{ "s25hl512t",  INFO6(0x342a1a, 0x0f0390, 0, 0)
>  		PARSE_SFDP
>  		MFR_FLAGS(USE_CLPEF)
>  		.fixups = &s25hx_t_fixups },
> -	{ "s25hl01gt",  INFO6(0x342a1b, 0x0f0390, 256 * 1024, 512)
> +	{ "s25hl01gt",  INFO6(0x342a1b, 0x0f0390, 0, 0)
>  		PARSE_SFDP
>  		MFR_FLAGS(USE_CLPEF)
>  		.fixups = &s25hx_t_fixups },
> @@ -886,11 +886,11 @@ static const struct flash_info spansion_nor_parts[] = {
>  		MFR_FLAGS(USE_CLPEF)
>  		FLAGS(NO_CHIP_ERASE)
>  		.fixups = &s25hx_t_fixups },
> -	{ "s25hs512t",  INFO6(0x342b1a, 0x0f0390, 256 * 1024, 256)
> +	{ "s25hs512t",  INFO6(0x342b1a, 0x0f0390, 0, 0)
>  		PARSE_SFDP
>  		MFR_FLAGS(USE_CLPEF)
>  		.fixups = &s25hx_t_fixups },
> -	{ "s25hs01gt",  INFO6(0x342b1b, 0x0f0390, 256 * 1024, 512)
> +	{ "s25hs01gt",  INFO6(0x342b1b, 0x0f0390, 0, 0)
>  		PARSE_SFDP
>  		MFR_FLAGS(USE_CLPEF)
>  		.fixups = &s25hx_t_fixups },
> @@ -901,22 +901,22 @@ static const struct flash_info spansion_nor_parts[] = {
>  		.fixups = &s25hx_t_fixups },
>  	{ "cy15x104q",  INFO6(0x042cc2, 0x7f7f7f, 512 * 1024, 1)
>  		FLAGS(SPI_NOR_NO_ERASE) },
> -	{ "s28hl512t",   INFO(0x345a1a,      0, 256 * 1024, 256)
> +	{ "s28hl512t",   INFO(0x345a1a,      0, 0, 0)
>  		PARSE_SFDP
>  		MFR_FLAGS(USE_CLPEF)
>  		.fixups = &s28hx_t_fixups,
>  	},
> -	{ "s28hl01gt",   INFO(0x345a1b,      0, 256 * 1024, 512)
> +	{ "s28hl01gt",   INFO(0x345a1b,      0, 0, 0)
>  		PARSE_SFDP
>  		MFR_FLAGS(USE_CLPEF)
>  		.fixups = &s28hx_t_fixups,
>  	},
> -	{ "s28hs512t",   INFO(0x345b1a,      0, 256 * 1024, 256)
> +	{ "s28hs512t",   INFO(0x345b1a,      0, 0, 0)
>  		PARSE_SFDP
>  		MFR_FLAGS(USE_CLPEF)
>  		.fixups = &s28hx_t_fixups,
>  	},
> -	{ "s28hs01gt",   INFO(0x345b1b,      0, 256 * 1024, 512)
> +	{ "s28hs01gt",   INFO(0x345b1b,      0, 0, 0)
>  		PARSE_SFDP
>  		MFR_FLAGS(USE_CLPEF)
>  		.fixups = &s28hx_t_fixups,

Tested-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
