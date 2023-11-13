Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D05C7E9D22
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjKMN3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjKMN3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:29:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2C4D6F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:29:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FDAC433C7;
        Mon, 13 Nov 2023 13:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699882144;
        bh=+2mkh4yIyUeEGCrAJG33DcCfBGAjXe3Cgtcf89a4hF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iio+o1ZlrCPEstCtxQLdSWIMmnogrnZwngRPYu01bBu9EjwpelZFO1453Mt3gw1mA
         /nV8HrQuvpJaUUuOBT1DtzwVtse+JJvk47VAd0OOHrbD6JPPbbPSXvJqzr27x/Knfz
         V1Wtg75PZKKRDSa/2tuyO8QAX8eov97/d9k+kMq8B1w7jWplHPX1ccNfQcqYbG3s2a
         COPSGqNdMu/c73cu258LvdttiWiapZknT5p3yjBTtekCi7soPtwWZ8r+4/BNqhAg6Q
         WF5vMq3Nw3IHH8UQiU0uEYsMrus5eE42JwUJLgnvzTs73PU0CL3TbtshGoto1FW17v
         UT077SY6SAVTg==
Date:   Mon, 13 Nov 2023 13:29:01 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Samuel Holland <samuel.holland@sifive.com>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH 1/2] riscv: dts: cv1800b: add pinctrl node for cv1800b
Message-ID: <20231113-mama-underarm-a8bbf0c2a1f1@squawk>
References: <20231113005702.2467-1-jszhang@kernel.org>
 <20231113005702.2467-2-jszhang@kernel.org>
 <58a99001-8260-4970-9fc7-25fe81e557a5@sifive.com>
 <ZVIejw2O6on8QMYy@xhacker>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7Zoqzoerm7+6YMc4"
Content-Disposition: inline
In-Reply-To: <ZVIejw2O6on8QMYy@xhacker>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7Zoqzoerm7+6YMc4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 09:03:11PM +0800, Jisheng Zhang wrote:
> On Sun, Nov 12, 2023 at 08:51:20PM -0500, Samuel Holland wrote:
> > On 2023-11-12 6:57 PM, Jisheng Zhang wrote:
> > > Add the reset device tree node to cv1800b SoC reusing the
> >           ^^^^^
> >           I assume you mean pinctrl here?
>=20
> oops copy and paste the commit msg ;) thanks
> >=20
> > > pinctrl-single driver.
> > >=20
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > ---
> > >  arch/riscv/boot/dts/sophgo/cv-pinctrl.h | 19 +++++++++++++++++++
> > >  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 10 ++++++++++
> > >  2 files changed, 29 insertions(+)
> > >  create mode 100644 arch/riscv/boot/dts/sophgo/cv-pinctrl.h
> > >=20
> > > diff --git a/arch/riscv/boot/dts/sophgo/cv-pinctrl.h b/arch/riscv/boo=
t/dts/sophgo/cv-pinctrl.h
> > > new file mode 100644
> > > index 000000000000..ed78b6fb3142
> > > --- /dev/null
> > > +++ b/arch/riscv/boot/dts/sophgo/cv-pinctrl.h
> >=20
> > A couple of questions: Should this go in include/dt-bindings? And is it=
 worth
>=20
> When I cooked this series two weeks ago, I did put it in dt-binding, but
> then I found commit fe49f2d776f799 ("arm64: dts: ti: Use local header for
> pinctrl register values"), "These definitions were previously put in the
> bindings header to avoid code duplication and to provide some context
> meaning (name), but they do not fit the purpose of bindings." which is
> suggested and acked by Krzysztof, so I just want to follow the style
> here.
>=20
>=20
> > including macros for the actual function mappings, like in the vendor s=
ource[1]?
>=20
> Do you want something as the following?
>=20
> #define UART0_TX	0
> #define CAM_MCLK1	1
> ...
>=20
> #define REG_UART0_TX	0x24
> ...
>=20
> pinctrl-single,pins =3D <REG_UART0_TX UART0_TX>;
>=20
> Other pinctl-single users just uses the register value directly, I have
> no preference. But I'd like to get suggestions from DT and pinctl-single
> maintainers. Hi Rob, Krzysztof, Conor, Tony, what's your opinion?

Basically, if the definitions map directly to registers and are just
used to make writing your devicetree easier then they do not belong
in a binding. This differs from clock or reset indices, where we
essentially make up a set of indices that may or may not correlate to
offsets in the hardware as using the register values without any sort of
abstraction is not defining an ABI.

Cheers,
Conor.
>=20
> >=20
> > [1]:
> > https://github.com/milkv-duo/duo-buildroot-sdk/blob/develop/linux_5.10/=
drivers/pinctrl/cvitek/cv180x_pinlist_swconfig.h
> >=20
> > > @@ -0,0 +1,19 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * This header provides constants for pinctrl bindings for Sophgo CV=
* SoC.
> > > + *
> > > + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> > > + */
> > > +#ifndef _DTS_RISCV_SOPHGO_CV_PINCTRL_H
> > > +#define _DTS_RISCV_SOPHGO_CV_PINCTRL_H
> > > +
> > > +#define MUX_M0		0
> > > +#define MUX_M1		1
> > > +#define MUX_M2		2
> > > +#define MUX_M3		3
> > > +#define MUX_M4		4
> > > +#define MUX_M5		5
> > > +#define MUX_M6		6
> > > +#define MUX_M7		7
> > > +
> > > +#endif
> > > diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boo=
t/dts/sophgo/cv1800b.dtsi
> > > index e04df04a91c0..7a44d8e8672b 100644
> > > --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > > +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > > @@ -6,6 +6,8 @@
> > >  #include <dt-bindings/interrupt-controller/irq.h>
> > >  #include <dt-bindings/reset/sophgo,cv1800b-reset.h>
> > > =20
> > > +#include "cv-pinctrl.h"
> > > +
> > >  / {
> > >  	compatible =3D "sophgo,cv1800b";
> > >  	#address-cells =3D <1>;
> > > @@ -55,6 +57,14 @@ soc {
> > >  		dma-noncoherent;
> > >  		ranges;
> > > =20
> > > +		pinctrl0: pinctrl@3001000 {
> > > +			compatible =3D "pinctrl-single";
> > > +			reg =3D <0x3001000 0x130>;
> > > +			#pinctrl-cells =3D <1>;
> > > +			pinctrl-single,register-width =3D <32>;
> > > +			pinctrl-single,function-mask =3D <0x00000007>;
> > > +		};
> >=20
> > From the vendor driver[2], it looks like this peripheral block only han=
dles
> > pinmuxing, so indeed this looks like a good use of pinctrl-single.
>=20
> This is deffinitely pinctrl-single style pinmux controller ;)
>=20
> >=20
> > [2]:
> > https://github.com/milkv-duo/duo-buildroot-sdk/blob/develop/linux_5.10/=
drivers/pinctrl/cvitek/pinctrl-cv180x.h
> >=20
> > > +
> > >  		rst: reset-controller@3003000 {
> > >  			compatible =3D "sophgo,cv1800b-reset";
> > >  			reg =3D <0x03003000 0x1000>;
> >=20

--7Zoqzoerm7+6YMc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVIkmgAKCRB4tDGHoIJi
0uRlAP9Px887Odlbyj2PwKsTBLE9E6OJ5moG9T721MhExHWzvgEA4FhpvDOu9zKu
fByJynWCnhTHWUzi0litF1aow7IBLwY=
=G+To
-----END PGP SIGNATURE-----

--7Zoqzoerm7+6YMc4--
