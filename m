Return-Path: <linux-kernel+bounces-141995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F278A25E2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971C41C217A8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADF41BF34;
	Fri, 12 Apr 2024 05:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p59qphZh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CFA1B977;
	Fri, 12 Apr 2024 05:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712900801; cv=none; b=Js2Suvc4zGcJs6xj7h4skhpHZj77a/B8mnZB/cz2MKUxOTYMQpkxnMkvQp3b5yyr3vUzrqjPTdfv7nf7yloh8DgW/mBmmRzAemFWHjUI+RRGWwRaAo0VnVgz2SOtZOYSLKnB3iRscXH+nL2tRjt9oW6yZEw6gvFZ3x0yiJDxpng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712900801; c=relaxed/simple;
	bh=Ay524JZmxpoTbV8GuHOb9vG7nbsde/vcILHmqZNFhL4=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=r7wXAGZZ4dTbq6M2EJzMxSqWVSK7ZT9Dk8hyUNs+8dBMuEvSQaCAGGROHmcXBb7UNHdet3dyu+VXWeqKdE4HW7O8kDfehIGSBIdBRFI3bnUxBP8A+/3OR+QYUAaN1t4ZlbaokpVncGGAbUuY3UqAmrA5mKak1ATFTXGN5EFEuuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p59qphZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E72BC2BBFC;
	Fri, 12 Apr 2024 05:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712900800;
	bh=Ay524JZmxpoTbV8GuHOb9vG7nbsde/vcILHmqZNFhL4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=p59qphZhyxnonI3QWaQ9INVrnBfqJ5VuU/0x4sZWU/l4iBKYPqYFTKpKBauooOMiC
	 A7dHP+jwbhFI2vNHEOp39KuWq8o8xRVbS1Lc33pm9Ic+VxnThaO4iamkXaqzz4pJVk
	 1pjalWCxVnrcYtfFESilAw0JHPaZzAXclrDyvShQIP5vlJjmMkky2TV+lFFdfvQDgt
	 8hR1jkv0Mq3vyKaDxthrqWMFqxXIjG8DHfc6Q9hnBFJjt3EO6tkynNYtNC+2vKJBIy
	 kKuiYFXLly42XPoSjc0zzUIbH6i3ynIeLEcprVRDoKjYXivmy6oJkCOH1vLZK3TWFc
	 hiCDIAFnoWCpg==
Message-ID: <f97cb190debc849b598e6675f8780470.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <D0H8EDEDKGV9.2FT5JGT59AU8A@bootlin.com>
References: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com> <20240410-mbly-olb-v1-5-335e496d7be3@bootlin.com> <daa732cb31d947c308513b535930c729.sboyd@kernel.org> <D0H8EDEDKGV9.2FT5JGT59AU8A@bootlin.com>
Subject: Re: [PATCH 05/11] clk: eyeq: add driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Thu, 11 Apr 2024 22:46:38 -0700
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2024-04-11 03:46:04)
> Hello,
>=20
> On Thu Apr 11, 2024 at 5:22 AM CEST, Stephen Boyd wrote:
> > Quoting Th=C3=A9o Lebrun (2024-04-10 10:12:34)
> > > diff --git a/drivers/clk/clk-eyeq.c b/drivers/clk/clk-eyeq.c
> > > new file mode 100644
> > > index 000000000000..bb2535010ae6
> > > --- /dev/null
> > > +++ b/drivers/clk/clk-eyeq.c
> > > @@ -0,0 +1,644 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * PLL clock driver for the Mobileye EyeQ5, EyeQ6L and EyeQ6H platfo=
rms.
> > > + *
> > > + * This controller handles read-only PLLs, all derived from the same=
 main
> > > + * crystal clock. It also exposes divider clocks, those are children=
 to PLLs.
> > > + * Parent clock is expected to be constant. This driver's registers =
live in
> > > + * a shared region called OLB. Some PLLs are initialised early by of=
_clk_init().
> >
> > Is OLB a different DT node? It sounds like maybe this is trying to jam a
> > driver into DT when the OLB node should be a #clock-cells node.
>=20
> Yes OLB is a different DT node. It looks like on EyeQ5:
>=20
>         olb: system-controller@e00000 {
>                 compatible =3D "mobileye,eyeq5-olb", "syscon", "simple-mf=
d";
>                 reg =3D <0 0xe00000 0x0 0x400>;
>                 ranges =3D <0x0 0x0 0xe00000 0x400>;
>                 #address-cells =3D <1>;
>                 #size-cells =3D <1>;
>=20
>                 reset: reset-controller@e00000 {
>                         compatible =3D "mobileye,eyeq5-reset";
>                         reg =3D <0x000 0x0c>, <0x200 0x34>, <0x120 0x04>;
>                         reg-names =3D "d0", "d1", "d2";
>                         #reset-cells =3D <2>;
>                 };
>=20
>                 clocks: clock-controller@e0002c {
>                         compatible =3D "mobileye,eyeq5-clk";
>                         reg =3D <0x02c 0x50>, <0x11c 0x04>;

Is this reg property always the same value '0x2c'?

>                         reg-names =3D "plls", "ospi";
>                         #clock-cells =3D <1>;
>                         clocks =3D <&xtal>;
>                         clock-names =3D "ref";
>                 };
>=20
>                 pinctrl: pinctrl@e000b0 {
>                         compatible =3D "mobileye,eyeq5-pinctrl";
>                         reg =3D <0x0b0 0x30>;
>                 };
>         };


>=20
> Keep in mind OLB is a complex beast. On EyeQ5, it hosts something like
> 150 registers, describing 20ish various hardware features. We have to
> expose registers to drivers for one-off reads/writes. One example found
> upstream: I2C speed mode register. Others will be Ethernet, eMMC DMA
> config, etc. A syscon makes sense.

Syscons are a slippery slope. It makes it easy to give up abstracting
the 20ish hardware features and makes the resulting drivers which use
the syscon highly platform specific.

Regardless of having a syscon or not, the binding should collapse the
sub-nodes into the olb node. If that requires making a different
compatible for different olb nodes, then that's actually better because
there may be some quirk for one of the olbs and not the other and we
won't be able to fix that without a compatible string update. It would
also make the reg-names property go away, because the sub-functionality
drivers would have the register offsets hard-coded as some offset from
the base of olb, instead of encoding that in DT.

>=20
> I2C looks like like this for example, look at mobileye,olb.
>=20
>         i2c@300000 {
>                 compatible =3D "mobileye,eyeq5-i2c", "arm,primecell";
>                 reg =3D <0x300000 0x1000>;
>                 interrupt-parent =3D <&gic>;
>                 interrupts =3D <GIC_SHARED 1 IRQ_TYPE_LEVEL_HIGH>;
>                 clock-frequency =3D <400000>;
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
>                 clocks =3D <&i2c_ser_clk>, <&i2c_clk>;
>                 clock-names =3D "i2cclk", "apb_pclk";
>                 mobileye,olb =3D <&olb 0>;
>         };
>=20
> See commits 7d4c57abb928 and 1b9a8e8af0d9:
>   i2c: nomadik: support Mobileye EyeQ5 I2C controller
>   dt-bindings: i2c: nomadik: add mobileye,eyeq5-i2c bindings and example

Why isn't i2c speed mode another clk exposed by OLB that rounds to the
different rates?

>=20
> > > +
> > > +       for (i =3D 0; i < data->div_count; i++) {
> > > +               const struct eqc_div *div =3D &data->divs[i];
> > > +               void __iomem *base =3D NULL;
> > > +               struct clk_hw *parent;
> > > +               unsigned int j;
> > > +
> > > +               /*
> > > +                * Multiple divider clocks can request the same resou=
rce. Store
> > > +                * resource pointers during probe(). For each divider=
 clock,
> > > +                * check if previous clocks referenced the same resou=
rce name.
> > > +                *
> > > +                * See EQ6HC_SOUTH_DIV_OSPI_REF and EQ6HC_SOUTH_DIV_O=
SPI_SYS.
> > > +                */
> > > +               for (j =3D 0; j < i; j++) {
> > > +                       if (strcmp(data->divs[j].resource_name, div->=
resource_name) =3D=3D 0) {
> > > +                               base =3D div_resources[j];
> > > +                               break;
> > > +                       }
> > > +               }
> > > +
> > > +               /* Resource is first encountered. */
> > > +               if (!base) {
> > > +                       base =3D devm_platform_ioremap_resource_bynam=
e(pdev, div->resource_name);
> > > +                       if (IS_ERR(base)) {
> > > +                               dev_warn(dev, "failed to iomap resour=
ce for %s\n", div->name);
> > > +                               priv->cells->hws[div->index] =3D base;
> > > +                               continue;
> > > +                       }
> > > +               }
> >
> > I don't get this code at all. The driver should simply map the
> > resources because it knows that there's an io resource. I'll look at the
> > binding which is probably wrong and causing the driver to be written
> > this way.
>=20
> This is here for a single reason: EyeQ6H south OLB has two clocks that
> live in the same register:
>=20
>  - div-ospi-ref, reg offset 0x90, mask GENMASK(9,  8) =3D=3D 0x300.
>  - div-ospi-sys, reg offset 0x90, mask GENMASK(12, 4) =3D=3D 0x1FF0.
>=20
> Calling twice devm_platform_ioremap_resource_byname() with the same
> resource name gives an error. So we need to buffer resources already
> requested.
>=20
> If there is a simpler & better solution I'd be happy to take it.

Sure, don't call platform_ioremap_resource() and friends more than once
per index. But why is the code written in a way that that is happening?
Maybe the driver can ioremap resources, and then register clks for those
resources. I suspect the only way of getting here is that the driver is
focused on registering clks, and ioremapping resources while registering
clks. Don't do that, because then you have to write code to track
resources.

>=20
>=20
> [...]
>=20
> > > +       /*
> > > +        * We expect named resources if divider clocks are present.
> > > +        * Else, we only expect one resource.
> > > +        */
> >
> > Please avoid named resources. They give the false sense of hope that the
> > binding can re-order the reg property when that can't be done. Instead,
> > just index and know which index to use in the driver.
>=20
> It is unclear what you mean by not being able to re-order reg property?
> Are you talking about reg-names being most often defined as items const
> list and therefore cannot be reordered? Here binding declare things
> using minItems/maxItems/enum so it can be reordered, looking like:

Yes, that's wrong.

>=20
>   properties:
>     reg:
>       minItems: 2
>       maxItems: 2
>     reg-names:
>       minItems: 2
>       maxItems: 2
>       items:
>         enum: [ plls, ospi ]
>=20
> If this is not what you are talking about then I rambled about garbage
> and I'll use indexed resources.
>=20

You cannot reorder strings in a DT binding property after the fact.
While the code will keep working if the reg-names elements are
re-ordered, the binding will be backwards incompatible, because the
reg-names property must have the same order. It can be convenient to use
reg-names if you have a long list of reg properties to map, but having
two or one elements isn't a very strong argument.

