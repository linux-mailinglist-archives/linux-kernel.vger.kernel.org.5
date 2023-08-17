Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A10077F79C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351372AbjHQNV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351385AbjHQNU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:20:56 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216842135
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:20:53 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6035F1BF20A;
        Thu, 17 Aug 2023 13:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692278452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TpkYJnEPG/Xi0SDa3SsdHsTZH3oAXFOzG5T3t2lM324=;
        b=IzdrsoV8tGuQYKemeHLyhFseeaBfFOOlh4vxvABN0qMP0IEb0+M23SX4fb408x6nwaEDkh
        gvpJktO/3CkI1m+NXwtJCHU5w/Dze72wZ15fBGQakMi+KXlx+fX9G/w6QXZlHeYS7LR/zd
        xAYikvjHkt3z/wX4TdIyOWWO8ofgYKlTNJ8LbQgfOwmsKbBcmGrhzBoBXOIzKoRDoEZeLB
        vVLsD/ck+quwgSwl6VhiucdoiHHYVWDIAK6hbl6yhEBosmz7rtLtdpOgJCKiFlPVAAs1iV
        ARjIA+dXWNEdVhspbMocz0Hoj+aR+m1uFiAIxmLKbRXSyQjx3eGhz1UT7EP7Dg==
Date:   Thu, 17 Aug 2023 15:20:50 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     SSunk <ssunkkan@gmail.com>
Cc:     tudor.ambarus@linaro.org, pratyush@kernel.org, michael@walle.cc,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add support for more XMC series
Message-ID: <20230817152050.6679eae3@xps-13>
In-Reply-To: <20230817124655.13023-1-ssunkkan@gmail.com>
References: <20230817124655.13023-1-ssunkkan@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

ssunkkan@gmail.com wrote on Thu, 17 Aug 2023 20:46:55 +0800:

> Add XMC XM25QH128C/XM25QH256C/XM25QU256C/XM25QH512C/XM25QU512C
> and set the parse_sfdp flag.

Please look at the git history and correct the title.

> Signed-off-by: Kankan Sun <ssunkkan@gmail.com>
> ---
>  drivers/mtd/spi-nor/xmc.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
> index 051411e86339..b2374187ec4f 100644
> --- a/drivers/mtd/spi-nor/xmc.c
> +++ b/drivers/mtd/spi-nor/xmc.c
> @@ -16,6 +16,22 @@ static const struct flash_info xmc_nor_parts[] =3D {
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

You say you enable SFDP in the commit log but the diff shows the
opposite?

> +
>  };
> =20
>  const struct spi_nor_manufacturer spi_nor_xmc =3D {


Thanks,
Miqu=C3=A8l
