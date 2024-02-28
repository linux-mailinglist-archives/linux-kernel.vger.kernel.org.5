Return-Path: <linux-kernel+bounces-85799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DF086BAEE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8C228229C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5904A71ECB;
	Wed, 28 Feb 2024 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQCD9vb1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757E61361B0;
	Wed, 28 Feb 2024 22:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160481; cv=none; b=RoyqUpJ4luGNhIhMri+iWP+WkRXP4xFAvOOAILFLcVC1anS9MO40hDqfvy+EFDu9lhpDKaBOpkss6Ke53qxN1kQkOtE1quISIZqOdK3jF4kHHj1rmWbSXm49XnmO4Cy8EwNc/3IM6ykjWpQcQb8ZD2Xnp+KpgfiWBYHMZkXY66k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160481; c=relaxed/simple;
	bh=imNeDCybnQTqCSixbtIV0f49WNytkR9qirQh/BflgTg=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=MPjZlbjzsShYHr2tCFAnkQ6SZzQ0nE+2hqV2ahw5nK8trYhtWOQBZi46oex4z/JJPkJn35V5vTlIgfS2euGbD2D2uijeHaRLk+q6lC3Q7O0LPXpEU9Z6ig40656FIHLaj7Hf+l8IsQgjw8Q1VduAxViicG79V74YPR/bOrrS5pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQCD9vb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA43CC433F1;
	Wed, 28 Feb 2024 22:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709160481;
	bh=imNeDCybnQTqCSixbtIV0f49WNytkR9qirQh/BflgTg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=rQCD9vb1vr8YHCT/cgkG3W7cl4iANHxlC78YiqJYGmoVBGqQiEb+hTHozvMqU6wZU
	 ASxO/ZoEKOmJqEd9cagY1syCwVISUecVoZBAimrvdm76l2hPsYHp89/lFlmiyBp/Sc
	 eHAEd7hznx95l2X+bOVA8UybOZfH3P057IOz1nPtsHctrCp3QUC6ITFbPcq4o0v7Gb
	 /IOGef/PdArRlTZRdlCRt/GfXzIXqwGTDL5RZ0slMm1aNqJzJtwk4VifL4MjgprKDd
	 pbRTcOEl4IbYDzkkDAjCZpAhZmuMCdDnOCFgZ/PN3+xVbPZ8j+dEvVxTjInyMGPST9
	 i7+aa6QfDAI+w==
Message-ID: <8acf846e767884978f3bb98646433551.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAP6Zq1g5gwXvYzO5fnHxG-6__gSCpNBY7VeEPyr4Qtijya6EfQ@mail.gmail.com>
References: <20240131182653.2673554-1-tmaimon77@gmail.com> <20240131182653.2673554-4-tmaimon77@gmail.com> <74e003c6d80611ddd826ac21f48b4b3a.sboyd@kernel.org> <CAP6Zq1g5gwXvYzO5fnHxG-6__gSCpNBY7VeEPyr4Qtijya6EfQ@mail.gmail.com>
Subject: Re: [PATCH v23 3/3] clk: npcm8xx: add clock controller
From: Stephen Boyd <sboyd@kernel.org>
Cc: benjaminfair@google.com, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com, robh+dt@kernel.org, tali.perry1@gmail.com, venture@google.com, yuenn@google.com, openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
To: Tomer Maimon <tmaimon77@gmail.com>
Date: Wed, 28 Feb 2024 14:47:58 -0800
User-Agent: alot/0.10

Quoting Tomer Maimon (2024-02-25 10:00:35)
> Hi Stephen,
>=20
> On Thu, 22 Feb 2024 at 07:58, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Tomer Maimon (2024-01-31 10:26:53)
> > > diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
> > > new file mode 100644
> > > index 000000000000..eacb579d30af
> > > --- /dev/null
> > > +++ b/drivers/clk/clk-npcm8xx.c
> > > @@ -0,0 +1,509 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Nuvoton NPCM8xx Clock Generator
> > > + * All the clocks are initialized by the bootloader, so this driver =
allows only
> > [...]
> > > +
> > > +/* external clock definition */
> > > +#define NPCM8XX_CLK_S_REFCLK   "refclk"
> > > +
> > > +/* pll definition */
> > > +#define NPCM8XX_CLK_S_PLL0     "pll0"
> > > +#define NPCM8XX_CLK_S_PLL1     "pll1"
> > > +#define NPCM8XX_CLK_S_PLL2     "pll2"
> > > +#define NPCM8XX_CLK_S_PLL_GFX  "pll_gfx"
> > > +
> > > +/* early divider definition */
> > > +#define NPCM8XX_CLK_S_PLL2_DIV2                "pll2_div2"
> > > +#define NPCM8XX_CLK_S_PLL_GFX_DIV2     "pll_gfx_div2"
> > > +#define NPCM8XX_CLK_S_PLL1_DIV2                "pll1_div2"
> > > +
> > > +/* mux definition */
> > > +#define NPCM8XX_CLK_S_CPU_MUX     "cpu_mux"
> > > +
> > > +/* div definition */
> > > +#define NPCM8XX_CLK_S_TH          "th"
> > > +#define NPCM8XX_CLK_S_AXI         "axi"
> >
> > Please inline all these string #defines to the place they're used.
> The version V21 you mention using define only when the definition is
> used more than once
> https://www.spinics.net/lists/kernel/msg5045826.html
> Should I remove all the string definitions and add the string to the arra=
y?

If it's a clk name for a clk registered in this file it should be
inlined. Is that the case for everything besides refclk? And even refclk
could be inlined so that we don't have to jump to the definition of a
string.

> > > +
> > > +static unsigned long npcm8xx_clk_div_get_parent(struct clk_hw *hw,
> > > +                                               unsigned long parent_=
rate)
> > > +{
> > > +       struct npcm8xx_clk *div =3D to_npcm8xx_clk(hw);
> > > +       unsigned int val;
> > > +
> > > +       regmap_read(div->clk_regmap, div->offset, &val);
> > > +       val =3D val >> div->shift;
> > > +       val &=3D clk_div_mask(div->width);
> > > +
> > > +       return divider_recalc_rate(hw, parent_rate, val, NULL, div->f=
lags,
> > > +                                  div->width);
> > > +}
> > > +
> > > +static const struct clk_ops npcm8xx_clk_div_ops =3D {
> > > +       .recalc_rate =3D npcm8xx_clk_div_get_parent,
> > > +};
> > > +
> > > +static int npcm8xx_clk_probe(struct platform_device *pdev)
> > > +{
> > > +       struct device_node *parent_np =3D of_get_parent(pdev->dev.of_=
node);
> >
> > The parent of this device is not a syscon.
> Once I have registered the map that handles both reset and the clock
> in general is syscon, this is why we will modify the DTS so the clock
> and the reset will be under syscon father node
>                 sysctrl: system-controller@f0801000 {
>                         compatible =3D "syscon", "simple-mfd";
>                         reg =3D <0x0 0xf0801000 0x0 0x1000>;
>=20
>                         rstc: reset-controller {
>                                 compatible =3D "nuvoton,npcm845-reset";
>                                 reg =3D <0x0 0xf0801000 0x0 0xC4>;
>                                 #reset-cells =3D <2>;
>                                 nuvoton,sysgcr =3D <&gcr>;
>                         };
>=20
>                         clk: clock-controller {
>                                 compatible =3D "nuvoton,npcm845-clk";
>                                 #clock-cells =3D <1>;
>                                 clocks =3D <&refclk>;
>                                 clock-names =3D "refclk";
>                         };
>                 };
> You can see other drivers that using the same method like
> https://elixir.bootlin.com/linux/v6.8-rc5/source/Documentation/devicetree=
/bindings/clock/socionext,uniphier-clock.yaml

You will need a similar file like
Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-perictrl=
yaml
then to describe the child nodes.

Socionext may not be the best example to follow. I generally try to
avoid syscon and simply put #reset-cells and #clock-cells in the node
for the device. You can use the auxiliary bus to register drivers for
clk and reset and put them into the resepective driver directories.
Avoid syscon means random drivers can't reach into the device with a
regmap handle and read/write registers that they're not supposed to.

> >
> > > +       struct clk_hw_onecell_data *npcm8xx_clk_data;
> > > +       struct device *dev =3D &pdev->dev;
> > > +       struct regmap *clk_regmap;
> > > +       struct clk_hw *hw;
> > > +       unsigned int i;
> > > +
> > > +       npcm8xx_clk_data =3D devm_kzalloc(dev, struct_size(npcm8xx_cl=
k_data, hws,
> > > +                                                        NPCM8XX_NUM_=
CLOCKS),
> > > +                                       GFP_KERNEL);
> > > +       if (!npcm8xx_clk_data)
> > > +               return -ENOMEM;
> > > +
> > > +       clk_regmap =3D syscon_node_to_regmap(parent_np);
> > > +       of_node_put(parent_np);
> >
> > Is there another binding update that is going to move this node to be a
> > child of the syscon?
> >
> >                 gcr: system-controller@f0800000 {
> >                         compatible =3D "nuvoton,npcm845-gcr", "syscon";
> >                         reg =3D <0x0 0xf0800000 0x0 0x1000>;
> >                 };
> No, sorry but I'm not going to use the GCR node the handle the clock
> and reset modules, the GCR has different memory space.
> the clock driver will have the following device tree

What does the reset driver use the CGR node for? The driver looks like
it's using it to control USB phy resets.

>                sysctrl: system-controller@f0801000 {
>                         compatible =3D "syscon", "simple-mfd";
>                         reg =3D <0x0 0xf0801000 0x0 0x1000>;
>=20
>                         rstc: reset-controller {
>                                 compatible =3D "nuvoton,npcm845-reset";
>                                 reg =3D <0x0 0xf0801000 0x0 0xC4>;

This isn't a valid reg property for a child node like this.

>                                 #reset-cells =3D <2>;
>                                 nuvoton,sysgcr =3D <&gcr>;
>                         };
>=20
>                         clk: clock-controller {
>                                 compatible =3D "nuvoton,npcm845-clk";
>                                 #clock-cells =3D <1>;
>                                 clocks =3D <&refclk>;
>                                 clock-names =3D "refclk";
>                         };
>                 };

