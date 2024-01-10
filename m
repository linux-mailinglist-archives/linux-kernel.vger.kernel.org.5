Return-Path: <linux-kernel+bounces-22368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF01829CBC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9411F25225
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652BD4B5D2;
	Wed, 10 Jan 2024 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgFa3wsS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13914B5B4;
	Wed, 10 Jan 2024 14:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAE3C433C7;
	Wed, 10 Jan 2024 14:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704897779;
	bh=AFSkkbHfhrMGjKTObrS4+Az4PqGEZgeRydKAgna01yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hgFa3wsSXiUDfIW7lYT0djmbRxf2uNVnXqdkxdJHIeOrC4YLzwi9Nzq2b+zQyzF18
	 rROYUHZrVoVjfykVIEA8HFIhh7E1gKE7b/XMr5KrXdsdOXoLgIGarIr2jc6sTan67i
	 Ev2nnfgEnks9zWeWHaaktLClEAdPyaU/CNAe1XESVqj381sV9rqpWdOQGqWOyWXhZ3
	 +IE2NkSFy+mh7xVC47KUBk9RZhTKGmpae+UWiX/qH5SGCyKd6ld3Y3xZWHDyZLsV1u
	 UMiISJ9YK9o+SI/EIaLTSPw12j+230fkDPI27TXIn15rWfD5YmDLe/4BVgVZQwCE4/
	 8bPxCcAGHadEA==
Date: Wed, 10 Jan 2024 14:42:52 +0000
From: Conor Dooley <conor@kernel.org>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
	chao.wei@sophgo.com, krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com, palmer@dabbelt.com,
	paul.walmsley@sifive.com, richardcochran@gmail.com,
	robh+dt@kernel.org, sboyd@kernel.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com, guoren@kernel.org, jszhang@kernel.org,
	inochiama@outlook.com, samuel.holland@sifive.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v7 2/4] dt-bindings: clock: sophgo: support SG2042
Message-ID: <20240110-untoasted-underfed-fe81479506f6@spud>
References: <cover.1704694903.git.unicorn_wang@outlook.com>
 <925d99d5b4ece01337cb3389aaea4b631894dd1d.1704694903.git.unicorn_wang@outlook.com>
 <f88b79c3-e44b-4136-ae56-10e1f2502e2d@linaro.org>
 <MA0P287MB2822C7A3C1DC7786708E860BFE692@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oKRhGC3CUc0pW3v5"
Content-Disposition: inline
In-Reply-To: <MA0P287MB2822C7A3C1DC7786708E860BFE692@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>


--oKRhGC3CUc0pW3v5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Jan 10, 2024 at 08:53:42AM +0800, Chen Wang wrote:
> On 2024/1/8 15:04, Krzysztof Kozlowski wrote:
> > On 08/01/2024 07:49, Chen Wang wrote:
> > > From: Chen Wang <unicorn_wang@outlook.com>
> > >=20
> > > Add bindings for the clock generator on the SG2042 RISC-V SoC.
> > >=20
> > > Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > >   .../bindings/clock/sophgo,sg2042-clkgen.yaml  |  53 ++++++
> > >   .../dt-bindings/clock/sophgo,sg2042-clkgen.h  | 169 +++++++++++++++=
+++
> > >   2 files changed, 222 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/clock/sophgo,s=
g2042-clkgen.yaml
> > >   create mode 100644 include/dt-bindings/clock/sophgo,sg2042-clkgen.h
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2042-cl=
kgen.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.ya=
ml
> > > new file mode 100644
> > > index 000000000000..f9935e66fc95
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/sophgo,sg2042-clkgen.ya=
ml
> > > @@ -0,0 +1,53 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/clock/sophgo,sg2042-clkgen.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Sophgo SG2042 Clock Generator
> > > +
> > > +maintainers:
> > > +  - Chen Wang <unicorn_wang@outlook.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: sophgo,sg2042-clkgen
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  sophgo,system-ctrl:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +    description:
> > > +      Phandle to SG2042 System Controller node. On SG2042, part of c=
ontrol
> > > +      registers of Clock Controller are defined in System controller=
=2E Clock
> > > +      driver will use this phandle to get the register map base to p=
lus the
> > > +      offset of the registers to access them.
> > Do not describe the driver, but hardware. What registers are in
> > system-ctrl? What are their purpose? Why this hardware needs them?
> Understood, will fix the words in revision, thanks.

I hope that I am not misunderstanding things, but I got a bit suspicious
of this binding and look at the driver, and saw that there are clocks
registered like:

| static int sg2042_clk_register_gates(struct sg2042_clk_data *clk_data,
| 				     const struct sg2042_gate_clock gate_clks[],
| 				     int num_gate_clks)
| {
| 	struct clk_hw *hw;
| 	const struct sg2042_gate_clock *gate;
| 	int i, ret =3D 0;
| 	void __iomem *reg;
|=20
| 	for (i =3D 0; i < num_gate_clks; i++) {
| 		gate =3D &gate_clks[i];
| 		if (gate->flag_sysctrl)
| 			reg =3D clk_data->iobase_syscon + gate->offset_enable;
| 		else
| 			reg =3D clk_data->iobase + gate->offset_enable;

iobase_syscon is the base address of the system controller that this
property points at & iobase is the base address of the clock controller
itself.

| 		hw =3D clk_hw_register_gate(NULL,
| 					  gate->name,
| 					  gate->parent_name,
| 					  gate->flags,
| 					  reg,
| 					  gate->bit_idx,
| 					  0,
| 					  &sg2042_clk_lock);

As far as I can tell, in this particular case, for any gate clock that
flag_sysctrl is set, none of the registers actually lie inside the
clkgen region, but instead are entirely contained in the sysctrl region.

I think that this is because your devicetree does not correctly define
the relationship between clocks, and these clocks are actually provided
by the system controller block and are inputs to the clkgen block.

| 		if (IS_ERR(hw)) {
| 			pr_err("failed to register clock %s\n", gate->name);
| 			ret =3D PTR_ERR(hw);
| 			break;
| 		}
|=20
| 		clk_data->onecell_data.hws[gate->id] =3D hw;
| 	}
|=20
| 	/* leave unregister to outside if failed */
| 	return ret;
| }

I had a much briefer look at the `sg2042_pll_clock`s that make use of
the regmap, and it doesn't seem like they "mix and match" registers
between both blocks, and instead only have registers in the system
controller? If so, it doesn't seem like this clkgen block should be
providing the PLL clocks either, but instead be taking them as inputs.

Reading stuff like
https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/system-con=
trol.rst#pll_stat-offset-0x0c0
(and onwards) makes it seem like those PLLs are fully contained within
the system controller register space.

It seems like
https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/clock-reg.=
rst
is the register map for the clkgen region? It seems like that region
only contains gates and divider clocks, but no PLLs.

Am I missing something, or is this description of the clock controllers
on the soc incomplete?

Cheers,
Conor.

--oKRhGC3CUc0pW3v5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ6s7AAKCRB4tDGHoIJi
0jF+AP9U7Ip0sysdDHuU+lFng6/5u2ae4C0Zbk+jM2PBGR7HbAEA0T6L0+7y1+bA
lUN9qeJRKWXmmXuVZl3nwSez1T3RUAU=
=tbPZ
-----END PGP SIGNATURE-----

--oKRhGC3CUc0pW3v5--

