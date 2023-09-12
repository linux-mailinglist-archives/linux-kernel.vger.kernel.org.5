Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0D679C9C2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjILIXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjILIXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:23:22 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F356BE6F;
        Tue, 12 Sep 2023 01:23:17 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD2B61C0044;
        Tue, 12 Sep 2023 08:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694506996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z8fD/yAC4w2my4BDixnegMB4l7KS4KNOuWpV/OdZog8=;
        b=AthQbrDo0M7SClZnqh8x8ZTyh3QWGY0awuM9ZQ7mmuhQJUXQl5jqtiy+aa2QIG8EslNRcS
        aJ4ACkl0juraoEUnFrddMPt0AqNnciHvHqp9MCRcUjjstXHF5sstSksUaxiILuubBNJwJ7
        g3wMbI3t7KnfpYczCrlVY1ZBNnyjCgmaM2x4+I/xrbwVFFnQPSF1Ky2iNH+ifgDC6j7+Qd
        5EGWSOiqhAmA2IqRzUGfixNw7PAuNeiQL9KkgffkxCbsICf1ywL7ULqIohF2siWuptXbMY
        ElMwrGVzM2zAFfxL/0FakZbscYUDeehJW2ajXTVyBsmwAw/zhKKSPxX3Hk5PmQ==
Date:   Tue, 12 Sep 2023 10:20:05 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Ralph Siemsen <ralph.siemsen@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] clk: renesas: r9a06g032: fix kerneldoc warning
Message-ID: <20230912101559.2d9f41d1@xps-13>
In-Reply-To: <20230911175215.263009-1-ralph.siemsen@linaro.org>
References: <20230911175215.263009-1-ralph.siemsen@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralph,

ralph.siemsen@linaro.org wrote on Mon, 11 Sep 2023 13:52:15 -0400:

> This fixes the following W=3D1 warning during build:
> > drivers/clk/renesas/r9a06g032-clocks.c:119: warning: Function parameter=
 or member 'dual' not described in 'r9a06g032_clkdesc' =20
>=20
> Added documentation for member 'dual'. Also added names for the other
> structures in the same union, with documentation. Adjusted names of
> members within the 'div' structure to avoid duplication.

It would be better to use the imperative form: s/added/add/,
s/adjusted/adjust/, etc.

I would also split this patch because you are doing two different
actions here: adding "dual" to the kdoc *and* naming other anonymous
structures.

I would use something like this for the first patch:
"
Mention the 'dual' structure in the kdoc. This fixes the following
W=3D1...
"

And rephrase the commit log for the second patch, something along:
"
Clarify the content of the r9a06g032_clkdesc structure by naming the
remaining anonymous structures defined inside. Renaming each field and
updating the doc then becomes necessary in order to avoid name
duplications and kdoc warnings.
"

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309101314.kTRoxND5-lkp@i=
ntel.com/
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> ---
> Second post, as the Subject: line accidentally got messed up previously.
>=20
>  drivers/clk/renesas/r9a06g032-clocks.c | 64 ++++++++++++++------------
>  1 file changed, 34 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas=
/r9a06g032-clocks.c
> index 55db63c7041a..61296c81f9b5 100644
> --- a/drivers/clk/renesas/r9a06g032-clocks.c
> +++ b/drivers/clk/renesas/r9a06g032-clocks.c
> @@ -102,19 +102,22 @@ enum gate_type {
>   * @source:    the ID+1 of the parent clock element.
>   *             Root clock uses ID of ~0 (PARENT_ID);
>   * @gate:      clock enable/disable
> - * @div_min:   smallest permitted clock divider
> - * @div_max:   largest permitted clock divider
> - * @reg:       clock divider register offset, in 32-bit words
> - * @div_table: optional list of fixed clock divider values;
> + * @div:       substructure for clock divider
> + * @div.min:   smallest permitted clock divider
> + * @div.max:   largest permitted clock divider
> + * @div.reg:   clock divider register offset, in 32-bit words
> + * @div.table: optional list of fixed clock divider values;
>   *             must be in ascending order, zero for unused
> - * @div:       divisor for fixed-factor clock
> - * @mul:       multiplier for fixed-factor clock
> - * @group:     UART group, 0=3DUART0/1/2, 1=3DUART3/4/5/6/7
> - * @sel:       select either g1/r1 or g2/r2 as clock source
> - * @g1:        1st source gate (clock enable/disable)
> - * @r1:        1st source reset (module reset)
> - * @g2:        2nd source gate (clock enable/disable)
> - * @r2:        2nd source reset (module reset)
> + * @ffc:       substructure for fixed-factor clocks
> + * @ffc.div:   divisor for fixed-factor clock
> + * @ffc.mul:   multiplier for fixed-factor clock
> + * @dual:      substructure for dual clock gates
> + * @dual.group: UART group, 0=3DUART0/1/2, 1=3DUART3/4/5/6/7
> + * @dual.sel:  select either g1/r1 or g2/r2 as clock source
> + * @dual.g1:   1st source gate (clock enable/disable)
> + * @dual.r1:   1st source reset (module reset)
> + * @dual.g2:   2nd source gate (clock enable/disable)
> + * @dual.r2:   2nd source reset (module reset)
>   *
>   * Describes a single element in the clock tree hierarchy.
>   * As there are quite a large number of clock elements, this
> @@ -131,13 +134,13 @@ struct r9a06g032_clkdesc {
>  		struct r9a06g032_gate gate;
>  		/* type =3D K_DIV  */
>  		struct {
> -			unsigned int div_min:10, div_max:10, reg:10;
> -			u16 div_table[4];
> -		};
> +			unsigned int min:10, max:10, reg:10;
> +			u16 table[4];
> +		} div;
>  		/* type =3D K_FFC */
>  		struct {
>  			u16 div, mul;
> -		};
> +		} ffc;
>  		/* type =3D K_DUALGATE */
>  		struct {
>  			uint16_t group:1;
> @@ -178,26 +181,26 @@ struct r9a06g032_clkdesc {
>  	.type =3D K_FFC, \
>  	.index =3D R9A06G032_##_idx, \
>  	.name =3D _n, \
> -	.div =3D _div, \
> -	.mul =3D _mul \
> +	.ffc.div =3D _div, \
> +	.ffc.mul =3D _mul \
>  }
>  #define D_FFC(_idx, _n, _src, _div) { \
>  	.type =3D K_FFC, \
>  	.index =3D R9A06G032_##_idx, \
>  	.source =3D 1 + R9A06G032_##_src, \
>  	.name =3D _n, \
> -	.div =3D _div, \
> -	.mul =3D 1 \
> +	.ffc.div =3D _div, \
> +	.ffc.mul =3D 1 \
>  }
>  #define D_DIV(_idx, _n, _src, _reg, _min, _max, ...) { \
>  	.type =3D K_DIV, \
>  	.index =3D R9A06G032_##_idx, \
>  	.source =3D 1 + R9A06G032_##_src, \
>  	.name =3D _n, \
> -	.reg =3D _reg, \
> -	.div_min =3D _min, \
> -	.div_max =3D _max, \
> -	.div_table =3D { __VA_ARGS__ } \
> +	.div.reg =3D _reg, \
> +	.div.min =3D _min, \
> +	.div.max =3D _max, \
> +	.div.table =3D { __VA_ARGS__ } \
>  }
>  #define D_UGATE(_idx, _n, _src, _g, _g1, _r1, _g2, _r2) { \
>  	.type =3D K_DUALGATE, \
> @@ -1063,14 +1066,14 @@ r9a06g032_register_div(struct r9a06g032_priv *clo=
cks,
> =20
>  	div->clocks =3D clocks;
>  	div->index =3D desc->index;
> -	div->reg =3D desc->reg;
> +	div->reg =3D desc->div.reg;
>  	div->hw.init =3D &init;
> -	div->min =3D desc->div_min;
> -	div->max =3D desc->div_max;
> +	div->min =3D desc->div.min;
> +	div->max =3D desc->div.max;
>  	/* populate (optional) divider table fixed values */
>  	for (i =3D 0; i < ARRAY_SIZE(div->table) &&
> -	     i < ARRAY_SIZE(desc->div_table) && desc->div_table[i]; i++) {
> -		div->table[div->table_size++] =3D desc->div_table[i];
> +	     i < ARRAY_SIZE(desc->div.table) && desc->div.table[i]; i++) {
> +		div->table[div->table_size++] =3D desc->div.table[i];
>  	}
> =20
>  	clk =3D clk_register(NULL, &div->hw);
> @@ -1333,7 +1336,8 @@ static int __init r9a06g032_clocks_probe(struct pla=
tform_device *pdev)
>  		case K_FFC:
>  			clk =3D clk_register_fixed_factor(NULL, d->name,
>  							parent_name, 0,
> -							d->mul, d->div);
> +							d->ffc.mul,
> +							d->ffc.div);
>  			break;
>  		case K_GATE:
>  			clk =3D r9a06g032_register_gate(clocks, parent_name, d);


Thanks,
Miqu=C3=A8l
