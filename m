Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFDE75A736
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjGTHGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjGTHGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:06:01 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021792D4C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:05:38 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id CC0443D5;
        Thu, 20 Jul 2023 09:05:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1689836715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZuZ0IsGyRwuV/pG7ohuA1WOX4CqA3bP0jKsrGlL0cfM=;
        b=SUVogaP+43ffhfTrNLFzMzHID7BYVfGb16nIG2mCAvEh9wVbH6PgNyQrIwWAq2SaxMe3bC
        /XSoPJE/9y0WWQ6mBkWs65q+irhyjcenJtrJlXtcbBhSsF+TOuZxhay4CnZiy3w5xdnJ5Y
        SPqXhI1mi3WWXZJd034cP5EXJPo+tRJgIiJYgaxepMoS4LLLV0auR8SVHbycUnDY5mNQkE
        sqZ00JnEgk99ZHlO+AI7Kqvj1g2FzM1SLEnruBi1+y0P9pYWCT2Qf9H99XVlnh10V20WzL
        9aEdXsgMcSg6lWl0tu7Tpay+l1HgnD+DUefPEZOfoWUNxbE0dqoHVSQpHJrF6A==
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 09:05:15 +0200
From:   Michael Walle <michael@walle.cc>
To:     Victor Lim <vlim@gigadevice.com>
Cc:     tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        akumarma@amd.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, vikhyat.goyal@amd.com,
        Victor Lim <vlim@gigadevice.com>
Subject: Re: [PATCH V1 1/1] linux: drivers: mtd: spi-nor: gigadevice.c
In-Reply-To: <20230720042834.12296-1-vlim@gigadevice.com>
References: <20230720042834.12296-1-vlim@gigadevice.com>
Message-ID: <62663146a51c2beac4eff48abe1f61f8@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-07-20 06:28, schrieb Victor Lim:
> Adding gigedevice new part numbers
> 
> Signed-off-by: Victor Lim <vlim@gigadevice.com>

This is already v3 of this series. Please track and keep a change log.

Your previous ones were here:
https://lore.kernel.org/linux-mtd/20221204080000.4100-1-vlim@gigadevice.com/
https://lore.kernel.org/linux-mtd/20221206111037.8999-1-vlim@gigadevice.com/

> ---
>  drivers/mtd/spi-nor/gigadevice.c | 79 ++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/gigadevice.c 
> b/drivers/mtd/spi-nor/gigadevice.c
> index d57ddaf1525b..285fa42f2d97 100644
> --- a/drivers/mtd/spi-nor/gigadevice.c
> +++ b/drivers/mtd/spi-nor/gigadevice.c
> @@ -67,6 +67,85 @@ static const struct flash_info 
> gigadevice_nor_parts[] = {
>  		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6)
>  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
>  		.fixups = &gd25q256_fixups },
> +/* adding these parts */

Why this comment?

> +	{ "gd25lx256e",  INFO(0xc86819, 0, 64 * 1024, 512,
> +			      SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
> +			      SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ |
> +			      SPI_NOR_OCTAL_DTR_PP |
> +			      SPI_NOR_IO_MODE_EN_VOLATILE)
> +		.fixups = &gd25lx256e_fixups },
> +	{"gd25b512", INFO(0xc8471A, 0, 64 * 1024, 1024,	SECT_4K |
> +	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},

Did you even compile this? INFO() doesn't take 5 arguments.
I'll stop here.

If you decide to post another version. Please read through all
the feedback you've got and esp. 
Documentation/process/submitting-patches.rst

Make it one patch per added part, don't include legacy flags if not 
needed,
include a test report and the dump of the SFDP tables.

Thanks,
-michael
