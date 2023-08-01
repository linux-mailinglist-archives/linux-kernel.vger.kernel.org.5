Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625D176A9C7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjHAHOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjHAHOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:14:12 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C73F1736
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 00:14:10 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 898BC5D1;
        Tue,  1 Aug 2023 09:14:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1690874047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qtne1oRy95jjB378HJsXyUADvrjcstZr+O9u6YT0B9I=;
        b=tbq/CepJ8AtWLx+C6gXI2AE4u64RKxNxntWUkBYdPp16wYrkzRRljwnGn2giTPi/AhTKHJ
        UQO1ydStgCDQLClUyPprXyZDNZJk1mjQJcQ2NTFdivZ/Bu63QniTaVvbRH4WR8IYIlK7m9
        +jqGeJlPZrzOHkEgkbVpJLQ9D44N4B/Ysc3LL2YB/39Jy28UvaDbMIoadmdDf5T3JIWwgK
        E5IE7w43QIt1E6Xchkw/GojVmIT3biea9BBbgRtn4dSA+Dh2lJYbBMUlVGHfJ384F5XWBq
        /BZo57Aa4Kx01InrCBtnpykZ7bzDsjC9n+jSoc/YD3TToSBoFUbVlmJ4o7UU6Q==
MIME-Version: 1.0
Date:   Tue, 01 Aug 2023 09:14:07 +0200
From:   Michael Walle <michael@walle.cc>
To:     Wadim Mueller <wafgo01@gmail.com>
Cc:     Wadim Mueller <wafgo01@gmail.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SPI-NOR: Add support for Micron mt35x01g
In-Reply-To: <20230728150810.205656-1-wadim.mueller@continental-corporation.com>
References: <20230728150810.205656-1-wadim.mueller@continental-corporation.com>
Message-ID: <7ac5ad977aae9ba124d81588a8521cbc@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2023-07-28 17:08, schrieb Wadim Mueller:
> From: Wadim Mueller <wafgo01@gmail.com>
> 
> Currently only the mt35xu512aba and mt35xu02g are supported,
> support for the 1G version is missing. This patch adds
> the corresponding entry in the micron_parts structure.
> 
> Verification and tests were done on a custom NXP S32G2 board with the
> mt35xu01g qspi nor populated
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> ---
>  drivers/mtd/spi-nor/micron-st.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/micron-st.c 
> b/drivers/mtd/spi-nor/micron-st.c
> index 4b919756a205..fe97583547fe 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -166,6 +166,11 @@ static const struct flash_info micron_nor_parts[] 
> = {
>  		MFR_FLAGS(USE_FSR)
>  		.fixups = &mt35xu512aba_fixups
>  	},
> +	{ "mt35xu01g", INFO(0x2c5b1b, 0, 128 * 1024, 1024)
> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_READ)
> +		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
> +		MFR_FLAGS(USE_FSR)
> +	},

I guess this flash have SFDP tables. Please dump them according to [1].
If so, please have a look wether this flash works with the generic
driver [2]. No NO_SFDP_FLAGS() with new drivers. also the 4B_OPCODES
should *hopefully* be superfluous due to the 4bait SFDP table.

-michael

[1] https://lore.kernel.org/r/4304e19f3399a0a6e856119d01ccabe0@walle.cc/
[2] 
https://elixir.bootlin.com/linux/v6.4-rc6/source/drivers/mtd/spi-nor/core.c#L2019


>  	{ "mt35xu02g", INFO(0x2c5b1c, 0, 128 * 1024, 2048)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_READ)
>  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
