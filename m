Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B697B7562C4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjGQMbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGQMbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:31:42 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D236FB9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:31:41 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id AF02F968;
        Mon, 17 Jul 2023 14:31:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1689597099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jB2Vzy9Nk2D5WxMfnpRq96P+gZedJhoPX3lCcWj+beI=;
        b=pENPrUWOV/sZNmDeoIWjLvEQZyQH+kJxomjQ4NdK2d07gvXYNBkCVcpyHv5Nlos2GRhQH4
        gjePQQjvZmVpEbBAdh6aeu6gtfVTq/CL1H3Z2/X8rxhfhm+hkBoafK0LAL56qh2H65P2Ck
        klYnx4ZRLgTSRP6FNDVCTX13aZxePl1vTNHg0V5y5clliYCGhf3fiEb7/RdxK8dHMD9Emy
        epX1dBo5f5wC1RDbrCnxKKWbykuY3aSM/U4d+X1Xvj6De9HIjJnsDhxiDculO3jVXDnt6v
        5PiRPzoXiPkoOmc3SPP/AtemRbUZb1EK5WzTE4yKO7VVJWBwQtVLFJ5jHoXuKA==
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 14:31:39 +0200
From:   Michael Walle <michael@walle.cc>
To:     SSunk <ssunkkan@gmail.com>
Cc:     tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        SSunk <ssunkkan@gmail.com>
Subject: Re: [PATCH] Add support for XMC
 XM25QH128C/XM25QH256C/XM25QU256C/XM25QH512C/XM25QU512C
In-Reply-To: <20230717110625.8844-1-ssunkkan@gmail.com>
References: <20230717110625.8844-1-ssunkkan@gmail.com>
Message-ID: <bfc85475bdcea46ea6c3ece98cc1e9cc@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Add more XMC chip support

Please elaborate.

> Signed-off-by: SSunk <ssunkkan@gmail.com>

We need a proper first and last name.

> ---
>  drivers/mtd/spi-nor/xmc.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
> index 051411e86339..b2374187ec4f 100644
> --- a/drivers/mtd/spi-nor/xmc.c
> +++ b/drivers/mtd/spi-nor/xmc.c
> @@ -16,6 +16,22 @@ static const struct flash_info xmc_nor_parts[] = {
>  	{ "XM25QH128A", INFO(0x207018, 0, 64 * 1024, 256)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>  			      SPI_NOR_QUAD_READ) },
> +	{ "XM25QH128C", INFO(0x204018, 0, 64 * 1024, 256)
> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> +			      SPI_NOR_QUAD_READ) },
> +	{ "XM25QH256C", INFO(0x204019, 0, 64 * 1024, 512)
> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> +			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +	{ "XM25QU256C", INFO(0x204119, 0, 64 * 1024, 512)
> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> +			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +	{ "XM25QH512C", INFO(0x204020, 0, 64 * 1024, 1024)
> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> +			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +	{ "XM25QU512C", INFO(0x204120, 0, 64 * 1024, 1024)
> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> +			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +

XMC parts seem to have SFDP tables and they should work out of the box
without any patches with the generic spi nor driver [1]. Therefore,
you don't need any entry at all.

-michael

[1] 
https://elixir.bootlin.com/linux/v6.4-rc6/source/drivers/mtd/spi-nor/core.c#L2019
