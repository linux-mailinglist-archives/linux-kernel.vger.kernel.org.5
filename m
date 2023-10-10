Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF257BF4D8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442646AbjJJHwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442632AbjJJHv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:51:59 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04078C4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 00:51:51 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 57D9140005;
        Tue, 10 Oct 2023 07:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696924310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=USilIgMsNbS10KLiGwlOraTVUj4wmhatBdmP9jLwLMs=;
        b=IIq1jLbM9v33XJ7hiIW5p49ICAYlbIBytS/d+ZsUS5VsFUIxntw6CG5TMngugXLaJtwmUI
        FkZHDbvG5AqCe/IQkIZNHB8lrBfRSTXlfwStzuw/z5WgLaBfFarZPm/jP3oi3MbfGUANK3
        Wyn19JZ4XNUT+Z8hAQUO2+phVU5CdS9r8TZN5S5WOmFyMC88a/76PDanL2WxBrxbNmdGv1
        9L9bdd05xXy2fqapBdMNFolw05QizTP5vkFbXvYTS3emzTm3Ysuh3+NlyVgHjqK7DHbxUh
        n2zID1RS6dA1/4FrvG37Cs4UmOZjh7zR8hidTIduVH4oBTB/AFCjyH26zU1AfQ==
Date:   Tue, 10 Oct 2023 09:51:44 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     dregan@mail.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, f.fainelli@gmail.com,
        rafal@milecki.pl, joel.peshkin@broadcom.com,
        computersforpeace@gmail.com, dan.beygelman@broadcom.com,
        william.zhang@broadcom.com, frieder.schrempf@kontron.de,
        linux-kernel@vger.kernel.org, vigneshr@ti.com, richard@nod.at,
        bbrezillon@kernel.org, kdasu.kdev@gmail.com,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Adam Borowski <kilobyte@angband.pl>
Subject: Re: [PATCH 1/3] mtd: rawnand: Add destructive operation
Message-ID: <20231010095144.520c9b2c@xps-13>
In-Reply-To: <trinity-003579bf-615b-47b8-b1a9-f0d37f650f45-1696905960546@3c-app-mailcom-lxa01>
References: <trinity-003579bf-615b-47b8-b1a9-f0d37f650f45-1696905960546@3c-app-mailcom-lxa01>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

dregan@mail.com wrote on Tue, 10 Oct 2023 04:46:00 +0200:

For the next iteration, would you mind sending the series with
git-send-email or at least handle the fact that patch 2 and 3 should be
an answer of patch 1 so that the three mails are kept together?

> Erase and program operations need the write protect (wp) pin to be
> de-asserted to take effect. Add the concept of destructive
> operation and pass the information to exec_op() so controllers know
> when they should de-assert this pin without having to decode
> the command opcode. Based on changes proposed by Boris Brezillon.
>=20
> https://github.com/bbrezillon/linux/commit/e612e1f2c69a33ac5f2c91d13669f0=
f172d58717
>=20
> Signed-off-by: David Regan <dregan@mail.com>

Given that there are almost no changes in this patch the author and
first SoB should remain Boris and you should add your SoB after.

>=20
> ---
>  drivers/mtd/nand/raw/nand_base.c | 6 ++++--
>  include/linux/mtd/rawnand.h      | 9 +++++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand=
_base.c
> index d4b55155aeae..47cc2c35153b 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -1494,7 +1494,8 @@ static int nand_exec_prog_page_op(struct nand_chip =
*chip, unsigned int page,
>  			    NAND_COMMON_TIMING_NS(conf, tWB_max)),
>  		NAND_OP_WAIT_RDY(NAND_COMMON_TIMING_MS(conf, tPROG_max), 0),
>  	};
> -	struct nand_operation op =3D NAND_OPERATION(chip->cur_cs, instrs);
> +	struct nand_operation op =3D NAND_DESTRUCTIVE_OPERATION(chip->cur_cs,
> +							      instrs);
>  	int naddrs =3D nand_fill_column_cycles(chip, addrs, offset_in_page);
>=20
>  	if (naddrs < 0)
> @@ -1917,7 +1918,8 @@ int nand_erase_op(struct nand_chip *chip, unsigned =
int eraseblock)
>  			NAND_OP_WAIT_RDY(NAND_COMMON_TIMING_MS(conf, tBERS_max),
>  					 0),
>  		};
> -		struct nand_operation op =3D NAND_OPERATION(chip->cur_cs, instrs);
> +		struct nand_operation op =3D NAND_DESTRUCTIVE_OPERATION(chip->cur_cs,
> +								      instrs);
>=20
>  		if (chip->options & NAND_ROW_ADDR_3)
>  			instrs[1].ctx.addr.naddrs++;
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index 90a141ba2a5a..31aceda8616c 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -1008,6 +1008,7 @@ struct nand_op_parser {
>   */
>  struct nand_operation {
>  	unsigned int cs;
> +	bool deassert_wp;
>  	const struct nand_op_instr *instrs;
>  	unsigned int ninstrs;
>  };
> @@ -1019,6 +1020,14 @@ struct nand_operation {
>  		.ninstrs =3D ARRAY_SIZE(_instrs),			\
>  	}
>=20
> +#define NAND_DESTRUCTIVE_OPERATION(_cs, _instrs)		\
> +	{							\
> +		.cs =3D _cs,					\
> +		.deassert_wp =3D true,				\
> +		.instrs =3D _instrs,				\
> +		.ninstrs =3D ARRAY_SIZE(_instrs),			\
> +	}
> +
>  int nand_op_parser_exec_op(struct nand_chip *chip,
>  			   const struct nand_op_parser *parser,
>  			   const struct nand_operation *op, bool check_only);
> --
> 2.37.3
>=20
>=20


Thanks,
Miqu=C3=A8l
