Return-Path: <linux-kernel+bounces-140276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8047F8A11AB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3626D286A85
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B83146D4D;
	Thu, 11 Apr 2024 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mxh/V2il"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01226BB29;
	Thu, 11 Apr 2024 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832376; cv=none; b=D7OjN3HeIlqG4A2rXuQqQr49E+4caGJrDGZbdmIMjPlqoWXwZIgQwd1ul2y6Yki3Q4QVq16GFCBBr0GmdG8YSDK65+fDnifNs5eJg2IQCZNAcXCHJLvNa2Qdz7MNWCZImVjVSU71EmdOnFmlGOJrysVbMPnhKOJAXhjn1hSfpps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832376; c=relaxed/simple;
	bh=OoYa2H46hlE4BhwqnM+waNzdjJPOC9QQSf8jKUDCvJQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=PIV46fBL037AGkSsWPZbAHUDiqjbONsZhNGXOrPdzn3QlJ9zIWhj+dGLt62ZaTGElMQUaX5ql5J04MZryrvvhD2kyuo+w/flZehXRO8wGk0Lo46wI7dIl1wNlMwpOdaNpb9dNHpjd9W3fk8gjhc8zZJ+Awj34u1GA4oVY1poUmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mxh/V2il; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8CB3A240002;
	Thu, 11 Apr 2024 10:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712832365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ew2ILr0DuW/o5wiH4MAXNJgc0vVAo26yBQ6uKtMhuoc=;
	b=mxh/V2ilGwbzd+R6GSvr5YumfCUNL69/2OP5A4DsAxyGgChkB19SuANkcNvRRnaST951SK
	U1Xpm5b4kzHKCkr+CDYzvVDmUMQ+Ihcuucw6bCBRvZBhjd+23bSMzWM30O8dxc7LyZ/F0y
	MCX42dyKyFrcKCAFhN9cZGt76o6ky/lsDvoR3kp8DTQKK/xIPeKnvobrzUX5zCWgO7eDDe
	ZnmPEAhL+mAx5oGNyi1MYCvhLpnthnWUdrHHru79AL+l7MgHhCyWKOr26VfDMOyaRzUeF8
	PoFN0yQ6RkGBNL4GdTLFTlkV8WnpdSJ5Htx67STCiugM62DZAjoGROtZnFQahA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 12:46:04 +0200
Message-Id: <D0H8EDEDKGV9.2FT5JGT59AU8A@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 05/11] clk: eyeq: add driver
Cc: <linux-mips@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Stephen Boyd" <sboyd@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Linus Walleij"
 <linus.walleij@linaro.org>, "Michael Turquette" <mturquette@baylibre.com>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Rob Herring" <robh@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com>
 <20240410-mbly-olb-v1-5-335e496d7be3@bootlin.com>
 <daa732cb31d947c308513b535930c729.sboyd@kernel.org>
In-Reply-To: <daa732cb31d947c308513b535930c729.sboyd@kernel.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Apr 11, 2024 at 5:22 AM CEST, Stephen Boyd wrote:
> Quoting Th=C3=A9o Lebrun (2024-04-10 10:12:34)
> > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > index 50af5fc7f570..1eb6e70977a3 100644
> > --- a/drivers/clk/Kconfig
> > +++ b/drivers/clk/Kconfig
> > @@ -218,6 +218,17 @@ config COMMON_CLK_EN7523
> >           This driver provides the fixed clocks and gates present on Ai=
roha
> >           ARM silicon.
> > =20
> > +config COMMON_CLK_EYEQ
> > +       bool "Clock driver for the Mobileye EyeQ platform"
> > +       depends on OF || COMPILE_TEST
>
> The OF build dependency looks useless as we have the MACH_ dependency
> below.

Indeed. I thought explicit dependency could be useful. Will remove.

> > +       depends on MACH_EYEQ5 || MACH_EYEQ6H || COMPILE_TEST
> > +       default MACH_EYEQ5 || MACH_EYEQ6H
> > +       help
> > +         This driver provides clocks found on Mobileye EyeQ5, EyeQ6L a=
nd Eye6H
> > +         SoCs. Controllers live in shared register regions called OLB.=
 Driver
> > +         provides read-only PLLs, derived from the main crystal clock =
(which
> > +         must be constant). It also exposes some divider clocks.
> > +
> >  config COMMON_CLK_FSL_FLEXSPI
> >         tristate "Clock driver for FlexSPI on Layerscape SoCs"
> >         depends on ARCH_LAYERSCAPE || COMPILE_TEST
> > diff --git a/drivers/clk/clk-eyeq.c b/drivers/clk/clk-eyeq.c
> > new file mode 100644
> > index 000000000000..bb2535010ae6
> > --- /dev/null
> > +++ b/drivers/clk/clk-eyeq.c
> > @@ -0,0 +1,644 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * PLL clock driver for the Mobileye EyeQ5, EyeQ6L and EyeQ6H platform=
s.
> > + *
> > + * This controller handles read-only PLLs, all derived from the same m=
ain
> > + * crystal clock. It also exposes divider clocks, those are children t=
o PLLs.
> > + * Parent clock is expected to be constant. This driver's registers li=
ve in
> > + * a shared region called OLB. Some PLLs are initialised early by of_c=
lk_init().
>
> Is OLB a different DT node? It sounds like maybe this is trying to jam a
> driver into DT when the OLB node should be a #clock-cells node.

Yes OLB is a different DT node. It looks like on EyeQ5:

	olb: system-controller@e00000 {
		compatible =3D "mobileye,eyeq5-olb", "syscon", "simple-mfd";
		reg =3D <0 0xe00000 0x0 0x400>;
		ranges =3D <0x0 0x0 0xe00000 0x400>;
		#address-cells =3D <1>;
		#size-cells =3D <1>;

		reset: reset-controller@e00000 {
			compatible =3D "mobileye,eyeq5-reset";
			reg =3D <0x000 0x0c>, <0x200 0x34>, <0x120 0x04>;
			reg-names =3D "d0", "d1", "d2";
			#reset-cells =3D <2>;
		};

		clocks: clock-controller@e0002c {
			compatible =3D "mobileye,eyeq5-clk";
			reg =3D <0x02c 0x50>, <0x11c 0x04>;
			reg-names =3D "plls", "ospi";
			#clock-cells =3D <1>;
			clocks =3D <&xtal>;
			clock-names =3D "ref";
		};

		pinctrl: pinctrl@e000b0 {
			compatible =3D "mobileye,eyeq5-pinctrl";
			reg =3D <0x0b0 0x30>;
		};
	};

Keep in mind OLB is a complex beast. On EyeQ5, it hosts something like
150 registers, describing 20ish various hardware features. We have to
expose registers to drivers for one-off reads/writes. One example found
upstream: I2C speed mode register. Others will be Ethernet, eMMC DMA
config, etc. A syscon makes sense.

I2C looks like like this for example, look at mobileye,olb.

	i2c@300000 {
		compatible =3D "mobileye,eyeq5-i2c", "arm,primecell";
		reg =3D <0x300000 0x1000>;
		interrupt-parent =3D <&gic>;
		interrupts =3D <GIC_SHARED 1 IRQ_TYPE_LEVEL_HIGH>;
		clock-frequency =3D <400000>;
		#address-cells =3D <1>;
		#size-cells =3D <0>;
		clocks =3D <&i2c_ser_clk>, <&i2c_clk>;
		clock-names =3D "i2cclk", "apb_pclk";
		mobileye,olb =3D <&olb 0>;
	};

See commits 7d4c57abb928 and 1b9a8e8af0d9:
  i2c: nomadik: support Mobileye EyeQ5 I2C controller
  dt-bindings: i2c: nomadik: add mobileye,eyeq5-i2c bindings and example

> > +
> > +static int eqc_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev =3D &pdev->dev;
> > +       void __iomem *div_resources[EQC_MAX_DIV_COUNT];
> > +       struct device_node *np =3D dev->of_node;
> > +       const struct eqc_match_data *data;
> > +       struct eqc_priv *priv =3D NULL;
> > +       struct clk_hw *hw;
> > +       unsigned int i;
> > +
> > +       data =3D device_get_match_data(dev);
> > +       if (!data)
> > +               return -ENODEV;
> > +
> > +       if (data->early_pll_count) {
> > +               /* Device got inited early. Retrieve clock provider fro=
m list. */
> > +               struct eqc_priv *entry;
> > +
> > +               spin_lock(&eqc_list_slock);
> > +               list_for_each_entry(entry, &eqc_list, list) {
> > +                       if (entry->np =3D=3D np) {
> > +                               priv =3D entry;
> > +                               break;
> > +                       }
> > +               }
> > +               spin_unlock(&eqc_list_slock);
> > +
> > +               if (!priv)
> > +                       return -ENODEV;
>
> This can be a sub-function.

Will do.

[...]

> > +       for (i =3D 0; i < data->pll_count; i++) {
> > +               const struct eqc_pll *pll =3D &data->plls[i];
> > +               unsigned long mult, div, acc;
> > +               u32 r0, r1;
> > +               u64 val;
> > +               int ret;
>
> All variables should be declared at the start of the function. Once it
> becomes "too heavy" you can split it up into smaller functions, that
> again have all variables declared at the start of the function.

Will avoid variables declarations at start of loops.

> > +
> > +               val =3D readq(priv->base_plls + pll->reg64);
> > +               r0 =3D val;
> > +               r1 =3D val >> 32;
> > +
> > +               ret =3D eqc_pll_parse_registers(r0, r1, &mult, &div, &a=
cc);
> > +               if (ret) {
> > +                       dev_warn(dev, "failed parsing state of %s\n", p=
ll->name);
> > +                       priv->cells->hws[pll->index] =3D ERR_PTR(ret);
> > +                       continue;
> > +               }
> > +
> > +               hw =3D clk_hw_register_fixed_factor_with_accuracy_fwnam=
e(dev,
> > +                               dev->of_node, pll->name, "ref", 0, mult=
, div, acc);
> > +               priv->cells->hws[pll->index] =3D hw;
> > +               if (IS_ERR(hw))
> > +                       dev_warn(dev, "failed registering %s: %pe\n", p=
ll->name, hw);
> > +       }
> > +
> > +       BUG_ON(ARRAY_SIZE(div_resources) < data->div_count);
>
> Can this be a static assert instead on the arrays these are based on?
> Put some static_assert() near the match data macros.

I hesitated before sending. Will update.

> > +
> > +       for (i =3D 0; i < data->div_count; i++) {
> > +               const struct eqc_div *div =3D &data->divs[i];
> > +               void __iomem *base =3D NULL;
> > +               struct clk_hw *parent;
> > +               unsigned int j;
> > +
> > +               /*
> > +                * Multiple divider clocks can request the same resourc=
e. Store
> > +                * resource pointers during probe(). For each divider c=
lock,
> > +                * check if previous clocks referenced the same resourc=
e name.
> > +                *
> > +                * See EQ6HC_SOUTH_DIV_OSPI_REF and EQ6HC_SOUTH_DIV_OSP=
I_SYS.
> > +                */
> > +               for (j =3D 0; j < i; j++) {
> > +                       if (strcmp(data->divs[j].resource_name, div->re=
source_name) =3D=3D 0) {
> > +                               base =3D div_resources[j];
> > +                               break;
> > +                       }
> > +               }
> > +
> > +               /* Resource is first encountered. */
> > +               if (!base) {
> > +                       base =3D devm_platform_ioremap_resource_byname(=
pdev, div->resource_name);
> > +                       if (IS_ERR(base)) {
> > +                               dev_warn(dev, "failed to iomap resource=
 for %s\n", div->name);
> > +                               priv->cells->hws[div->index] =3D base;
> > +                               continue;
> > +                       }
> > +               }
>
> I don't get this code at all. The driver should simply map the
> resources because it knows that there's an io resource. I'll look at the
> binding which is probably wrong and causing the driver to be written
> this way.

This is here for a single reason: EyeQ6H south OLB has two clocks that
live in the same register:

 - div-ospi-ref, reg offset 0x90, mask GENMASK(9,  8) =3D=3D 0x300.
 - div-ospi-sys, reg offset 0x90, mask GENMASK(12, 4) =3D=3D 0x1FF0.

Calling twice devm_platform_ioremap_resource_byname() with the same
resource name gives an error. So we need to buffer resources already
requested.

If there is a simpler & better solution I'd be happy to take it.

[...]

> > +static void __init eqc_init(struct device_node *np)
> > +{
> > +       const struct eqc_match_data *data;
> > +       unsigned int nb_clks =3D 0;
> > +       struct eqc_priv *priv;
> > +       unsigned int i;
> > +       int ret;
> > +
> > +       data =3D of_match_node(eqc_match_table, np)->data;
> > +
> > +       /* No reason to early init this clock provider. Do it at probe.=
 */
> > +       if (data->early_pll_count =3D=3D 0)
>
> You can have a different match table for this function then.

Ah, clever. Will do.

[...]

> > +       /*
> > +        * We expect named resources if divider clocks are present.
> > +        * Else, we only expect one resource.
> > +        */
>
> Please avoid named resources. They give the false sense of hope that the
> binding can re-order the reg property when that can't be done. Instead,
> just index and know which index to use in the driver.

It is unclear what you mean by not being able to re-order reg property?
Are you talking about reg-names being most often defined as items const
list and therefore cannot be reordered? Here binding declare things
using minItems/maxItems/enum so it can be reordered, looking like:

  properties:
    reg:
      minItems: 2
      maxItems: 2
    reg-names:
      minItems: 2
      maxItems: 2
      items:
        enum: [ plls, ospi ]

If this is not what you are talking about then I rambled about garbage
and I'll use indexed resources.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


