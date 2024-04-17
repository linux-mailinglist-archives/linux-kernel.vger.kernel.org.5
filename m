Return-Path: <linux-kernel+bounces-148299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A34F48A808F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6842839A4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B7713B794;
	Wed, 17 Apr 2024 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fYP3I7It"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C7413AD15;
	Wed, 17 Apr 2024 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349142; cv=none; b=R3n16G5//3mjrl4RqEtH4CF8QWDUd+Hl5cgYb5GdtPAv4qZQnA8nR2ITwFqOgO0h5DmYh8cAjsqCa4O5GYz/eNV9bFG0WqlpCUqv+QNC1RNlpn0fwWBbFG0uGquAdBLvdIPefNiVwL2nU0t6ucZpmu6Ey97/DHd6hGFHiv+1/xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349142; c=relaxed/simple;
	bh=BM7rs1SdV3LyhZYH9YWa1wei3BlvWHxD0cOW8M/PPLI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ib/IHFUIPi1J6h6MkKAqRKeHn+e/LwKsIZuZG3obiTuIqae9uVYidfd8VW2PY7JEQJyqHk59wvMQafZSLT3emH79DsfT9Q/ZCEWN1QAcvwG+CEyP6vKTlbm1M+BrB7HXDVS4Ony2JAn6eodFQ4pWXgqPcjJN232cGI0lzhsfpkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fYP3I7It; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9CC27FF80A;
	Wed, 17 Apr 2024 10:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713349137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vB5bAUdnNxyy+6y08T73+Suwg5SgTJ0aP0zmKopaBPg=;
	b=fYP3I7ItgQ/SYOzGXx+Pkc82zm110Xrk/yXWKiTDp6Hxge77+0t057lqUH95IG5E8IYssZ
	/5EZLqvMMgesYZhD6qeQKaDtsNJCrFo7vvMX2YDVNBpUl53nS5bFII9fumMK77RvQ6qIBC
	48TQSd/O3jYrhgNYGh6UHcZRrk4cYf+TevS4NMHI0EX3L/F+tecn3QeWc3ZKGEuNgtNv3l
	1iuGfnXsvdBGtfNZLQAz8uKiat9S52SSHbTnaF2Qr112ANwRKraLSWmXIXGgzfKUbEu5Ex
	QRRjVQ3VqgBeoq43Xu8GYITG5Bncyb3Z4jVm/vhn6z8WgecTLwz/TPWVgDyAiw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Apr 2024 12:18:56 +0200
Message-Id: <D0MBKV3HNRN2.1IZURE1Q8ZTIH@bootlin.com>
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
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com>
 <20240410-mbly-olb-v1-5-335e496d7be3@bootlin.com>
 <daa732cb31d947c308513b535930c729.sboyd@kernel.org>
 <D0H8EDEDKGV9.2FT5JGT59AU8A@bootlin.com>
 <f97cb190debc849b598e6675f8780470.sboyd@kernel.org>
In-Reply-To: <f97cb190debc849b598e6675f8780470.sboyd@kernel.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Fri Apr 12, 2024 at 7:46 AM CEST, Stephen Boyd wrote:
> Quoting Th=C3=A9o Lebrun (2024-04-11 03:46:04)
> > On Thu Apr 11, 2024 at 5:22 AM CEST, Stephen Boyd wrote:
> > > Quoting Th=C3=A9o Lebrun (2024-04-10 10:12:34)
> > > > diff --git a/drivers/clk/clk-eyeq.c b/drivers/clk/clk-eyeq.c
> > > > new file mode 100644
> > > > index 000000000000..bb2535010ae6
> > > > --- /dev/null
> > > > +++ b/drivers/clk/clk-eyeq.c
> > > > @@ -0,0 +1,644 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * PLL clock driver for the Mobileye EyeQ5, EyeQ6L and EyeQ6H plat=
forms.
> > > > + *
> > > > + * This controller handles read-only PLLs, all derived from the sa=
me main
> > > > + * crystal clock. It also exposes divider clocks, those are childr=
en to PLLs.
> > > > + * Parent clock is expected to be constant. This driver's register=
s live in
> > > > + * a shared region called OLB. Some PLLs are initialised early by =
of_clk_init().
> > >
> > > Is OLB a different DT node? It sounds like maybe this is trying to ja=
m a
> > > driver into DT when the OLB node should be a #clock-cells node.
> >=20
> > Yes OLB is a different DT node. It looks like on EyeQ5:
> >=20
> >         olb: system-controller@e00000 {
> >                 compatible =3D "mobileye,eyeq5-olb", "syscon", "simple-=
mfd";
> >                 reg =3D <0 0xe00000 0x0 0x400>;
> >                 ranges =3D <0x0 0x0 0xe00000 0x400>;
> >                 #address-cells =3D <1>;
> >                 #size-cells =3D <1>;
> >=20
> >                 reset: reset-controller@e00000 {
> >                         compatible =3D "mobileye,eyeq5-reset";
> >                         reg =3D <0x000 0x0c>, <0x200 0x34>, <0x120 0x04=
>;
> >                         reg-names =3D "d0", "d1", "d2";
> >                         #reset-cells =3D <2>;
> >                 };
> >=20
> >                 clocks: clock-controller@e0002c {
> >                         compatible =3D "mobileye,eyeq5-clk";
> >                         reg =3D <0x02c 0x50>, <0x11c 0x04>;
>
> Is this reg property always the same value '0x2c'?

On EyeQ5 yes.
On EyeQ6L and EyeQ6H (next revisions, different compatible), no.

> >                         reg-names =3D "plls", "ospi";
> >                         #clock-cells =3D <1>;
> >                         clocks =3D <&xtal>;
> >                         clock-names =3D "ref";
> >                 };
> >=20
> >                 pinctrl: pinctrl@e000b0 {
> >                         compatible =3D "mobileye,eyeq5-pinctrl";
> >                         reg =3D <0x0b0 0x30>;
> >                 };
> >         };
>
>
> >=20
> > Keep in mind OLB is a complex beast. On EyeQ5, it hosts something like
> > 150 registers, describing 20ish various hardware features. We have to
> > expose registers to drivers for one-off reads/writes. One example found
> > upstream: I2C speed mode register. Others will be Ethernet, eMMC DMA
> > config, etc. A syscon makes sense.
>
> Syscons are a slippery slope. It makes it easy to give up abstracting
> the 20ish hardware features and makes the resulting drivers which use
> the syscon highly platform specific.

I see where you are coming from. In my mind syscons make sense here
because most features in the block are only small additions/tweaks to
existing blocks. A few examples:

 - eMMC DMA integration config
 - eMMC high impedance register
 - OSPI high impedance register

Those cannot be abstracted. The main node is elsewhere and it needs
access to those registers.

Some other registers however will be able to be abstracted away, as
custom clocks for example (eg I'm seeing SGMII PLL control register).
That is not the case for all however.

> Regardless of having a syscon or not, the binding should collapse the
> sub-nodes into the olb node. If that requires making a different
> compatible for different olb nodes, then that's actually better because
> there may be some quirk for one of the olbs and not the other and we
> won't be able to fix that without a compatible string update. It would
> also make the reg-names property go away, because the sub-functionality
> drivers would have the register offsets hard-coded as some offset from
> the base of olb, instead of encoding that in DT.

Do you have examples of existing nodes that both are syscons and expose
multiple resources (clocks, resets, etc)? I did not envision this as
possible which is why I didn't go this route. Also, this would require
big changes to dt-bindings currently in v6.9-rc.

To be honest, I do not comprehend what aggregating sub-nodes into a
single one brings. Here we have one node per feature, each exposing
their small feature set, with a single driver handling each. Devicetree
is longer but more straight forward, with small resource provider nodes
versus a big behemoth handling all of it. Simple and easy: my brain
has an easy time grasping it all.

What you are proposing sounds more complex, for no clear benefit to my
eyes. Can you expand on what that brings? I guess answer has been given
elsewhere in depth, so answer might just be a link to the right
resource. This is an open question, not reserved to Stephen. Thanks!

> > I2C looks like like this for example, look at mobileye,olb.
> >=20
> >         i2c@300000 {
> >                 compatible =3D "mobileye,eyeq5-i2c", "arm,primecell";
> >                 reg =3D <0x300000 0x1000>;
> >                 interrupt-parent =3D <&gic>;
> >                 interrupts =3D <GIC_SHARED 1 IRQ_TYPE_LEVEL_HIGH>;
> >                 clock-frequency =3D <400000>;
> >                 #address-cells =3D <1>;
> >                 #size-cells =3D <0>;
> >                 clocks =3D <&i2c_ser_clk>, <&i2c_clk>;
> >                 clock-names =3D "i2cclk", "apb_pclk";
> >                 mobileye,olb =3D <&olb 0>;
> >         };
> >=20
> > See commits 7d4c57abb928 and 1b9a8e8af0d9:
> >   i2c: nomadik: support Mobileye EyeQ5 I2C controller
> >   dt-bindings: i2c: nomadik: add mobileye,eyeq5-i2c bindings and exampl=
e
>
> Why isn't i2c speed mode another clk exposed by OLB that rounds to the
> different rates?

It would be a new clock referenced from DT on which we would only do
clk_set_rate(priv->clk_freq). How would it fit in the clock tree? It
wouldn't have any parent, even though in practice is it parented to an
internal Nomadik I2C clock that is not being exposed.

I thought it would be an issue to have a clock modeled as having no
parent (because its true parent is not exposed) which is a blatant lie.

> > > > +       for (i =3D 0; i < data->div_count; i++) {
> > > > +               const struct eqc_div *div =3D &data->divs[i];
> > > > +               void __iomem *base =3D NULL;
> > > > +               struct clk_hw *parent;
> > > > +               unsigned int j;
> > > > +
> > > > +               /*
> > > > +                * Multiple divider clocks can request the same res=
ource. Store
> > > > +                * resource pointers during probe(). For each divid=
er clock,
> > > > +                * check if previous clocks referenced the same res=
ource name.
> > > > +                *
> > > > +                * See EQ6HC_SOUTH_DIV_OSPI_REF and EQ6HC_SOUTH_DIV=
_OSPI_SYS.
> > > > +                */
> > > > +               for (j =3D 0; j < i; j++) {
> > > > +                       if (strcmp(data->divs[j].resource_name, div=
->resource_name) =3D=3D 0) {
> > > > +                               base =3D div_resources[j];
> > > > +                               break;
> > > > +                       }
> > > > +               }
> > > > +
> > > > +               /* Resource is first encountered. */
> > > > +               if (!base) {
> > > > +                       base =3D devm_platform_ioremap_resource_byn=
ame(pdev, div->resource_name);
> > > > +                       if (IS_ERR(base)) {
> > > > +                               dev_warn(dev, "failed to iomap reso=
urce for %s\n", div->name);
> > > > +                               priv->cells->hws[div->index] =3D ba=
se;
> > > > +                               continue;
> > > > +                       }
> > > > +               }
> > >
> > > I don't get this code at all. The driver should simply map the
> > > resources because it knows that there's an io resource. I'll look at =
the
> > > binding which is probably wrong and causing the driver to be written
> > > this way.
> >=20
> > This is here for a single reason: EyeQ6H south OLB has two clocks that
> > live in the same register:
> >=20
> >  - div-ospi-ref, reg offset 0x90, mask GENMASK(9,  8) =3D=3D 0x300.
> >  - div-ospi-sys, reg offset 0x90, mask GENMASK(12, 4) =3D=3D 0x1FF0.
> >=20
> > Calling twice devm_platform_ioremap_resource_byname() with the same
> > resource name gives an error. So we need to buffer resources already
> > requested.
> >=20
> > If there is a simpler & better solution I'd be happy to take it.
>
> Sure, don't call platform_ioremap_resource() and friends more than once
> per index. But why is the code written in a way that that is happening?
> Maybe the driver can ioremap resources, and then register clks for those
> resources. I suspect the only way of getting here is that the driver is
> focused on registering clks, and ioremapping resources while registering
> clks. Don't do that, because then you have to write code to track
> resources.

So code would look like (removing reg-names as it brings nothing, and
error checking for brevity):

void __iomem *div_resources[EQC_MAX_DIV_COUNT];
unsigned int max_div_resource_index =3D 0;
const struct eqc_div *div;
struct clk_hw *parent;
void __iomem *base;
struct clk_hw *hw;

// Learn what resources should be acquired
for (i =3D 0; i < data->div_count; i++) {
	div =3D &data->divs[i];

	if (div->resource_index > max_div_resource_index)
		max_div_resource_index =3D div->resource_index;
}

// Grab resources (starting at 1 because 0 is for PLLs)
for (i =3D 1; i < max_div_resource_index; i++) {
	div_resources[i] =3D devm_platform_ioremap_resource(pdev, i);
	// TODO: error checking
}

// Register clocks
for (i =3D 0; i < data->div_count; i++) {
	div =3D &data->divs[i];
	base =3D div_resources[div->resource_index];

	parent =3D priv->cells->hws[div->parent];
	hw =3D clk_hw_register_divider_table_parent_hw(dev, div->name,
			parent, 0, base, div->shift, div->width,
			CLK_DIVIDER_EVEN_INTEGERS, NULL, NULL);
	priv->cells->hws[div->index] =3D hw;
	// TODO: error checking
}

>
> >=20
> >=20
> > [...]
> >=20
> > > > +       /*
> > > > +        * We expect named resources if divider clocks are present.
> > > > +        * Else, we only expect one resource.
> > > > +        */
> > >
> > > Please avoid named resources. They give the false sense of hope that =
the
> > > binding can re-order the reg property when that can't be done. Instea=
d,
> > > just index and know which index to use in the driver.
> >=20
> > It is unclear what you mean by not being able to re-order reg property?
> > Are you talking about reg-names being most often defined as items const
> > list and therefore cannot be reordered? Here binding declare things
> > using minItems/maxItems/enum so it can be reordered, looking like:
>
> Yes, that's wrong.
>
> >=20
> >   properties:
> >     reg:
> >       minItems: 2
> >       maxItems: 2
> >     reg-names:
> >       minItems: 2
> >       maxItems: 2
> >       items:
> >         enum: [ plls, ospi ]
> >=20
> > If this is not what you are talking about then I rambled about garbage
> > and I'll use indexed resources.
> >=20
>
> You cannot reorder strings in a DT binding property after the fact.
> While the code will keep working if the reg-names elements are
> re-ordered, the binding will be backwards incompatible, because the
> reg-names property must have the same order. It can be convenient to use
> reg-names if you have a long list of reg properties to map, but having
> two or one elements isn't a very strong argument.

I didn't know that beforehands. I completely get what you mean now.
Why it is that way is unclear to me but whatever. It is even documented:
https://elixir.bootlin.com/linux/v6.8.6/source/Documentation/devicetree/bin=
dings/writing-bindings.rst#L64

Thanks Stephen,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


