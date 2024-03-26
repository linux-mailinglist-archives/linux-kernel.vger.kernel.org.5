Return-Path: <linux-kernel+bounces-119392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D88C988C81E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAFE51C647AF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992C413CC7F;
	Tue, 26 Mar 2024 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="bILQm8jB"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25C613CABC;
	Tue, 26 Mar 2024 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711468345; cv=none; b=nTqAh0/sOmffJVs1nJFXmDmoyZfKohHUYW+07GtozamHCm55cqqNoP3Mdxzw3vwcYOrGGa9zwnkwAg8waMKUw09YtmA1yvxlvGi2Cf/ENlKWBMqAvYcGZMkMlXzCDzn6vwmlQZiuFYedDdAIGsPNrONPJ0h1wMsRcdLEIbWHlbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711468345; c=relaxed/simple;
	bh=Zyzm4+ik2ZIZ+RRLqBpLsZ49PhPd8h/lVV8304aAQE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9aFQORdTip0P26d/hvHUswPr61oSD41BEFQ8xa56NZ3VaL3+v5YXMvoGVoQEdMVNjY5SfeSH+5Io+J32n3wh8BqojbGwY1gl7Sy/ySJxWtFG4ADhHmzpgDh1PfAcL+WFA56F5TfGHlH/BVWQur40QzTa564VDzTGn4zwq5NIp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=bILQm8jB; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 21CB987DF8;
	Tue, 26 Mar 2024 16:52:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711468341;
	bh=y8VR58RDxB8LgNvt513KCxtG12NFq+KcsRROU7mxUDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bILQm8jBIqXCOtNkIc++4xt6UtZpiX9xbZdGYKtC5x3h7u8z7AcBBqXFXH1OdU1vC
	 wwfozrT5oJPiQG4rkAmTr2HPhx28ROtxoxpVOQjYhaaHuJT0glkcXQSqGGW0izsZ/g
	 7XacuXjJgcoovKSa3bEkjTfTx8Gc6PTNVeXbBgu6ylwiL+QbXbZHsXkbONYgduRSPI
	 f5i+2THFojft3tpUR5Cq6CXvMbWBWlkFtx6DFP1Jka67ArCFER7Q65LOv1LzAMS3LK
	 OJJDFuhwaBwICaK0Bqs69ywFDnsFyfG15g7HX1XwqWWbTTBHd3pU4X+9CA8aD0s67Z
	 ijNR7zyT7NWFQ==
Date: Tue, 26 Mar 2024 16:52:15 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@ew.tq-group.com, Michael Krummsdorf
 <michael.krummsdorf@tq-group.com>
Subject: Re: [PATCH] net: dsa: mv88e6xxx: fix usable ports on 88e6020
Message-ID: <20240326165215.5fb4326c@wsk>
In-Reply-To: <35cc888230a0146a7687d8b859e5a6ceffec581a.camel@ew.tq-group.com>
References: <20240326123655.40666-1-matthias.schiffer@ew.tq-group.com>
	<20240326143424.3368d9b1@wsk>
	<35cc888230a0146a7687d8b859e5a6ceffec581a.camel@ew.tq-group.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ybwj9Ab0+CEoQ20xl1ri6JC";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/ybwj9Ab0+CEoQ20xl1ri6JC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Matthias,

> On Tue, 2024-03-26 at 14:34 +0100, Lukasz Majewski wrote:
> > Hi Matthias,
> >  =20
> > > From: Michael Krummsdorf <michael.krummsdorf@tq-group.com>
> > >=20
> > > The switch has 4 ports with 2 internal PHYs, but ports are
> > > numbered up to 6, with ports 0, 1, 5 and 6 being usable.
> > >=20
> > > Fixes: 71d94a432a15 ("net: dsa: mv88e6xxx: add support for
> > > MV88E6020 switch") Signed-off-by: Michael Krummsdorf
> > > <michael.krummsdorf@tq-group.com> Signed-off-by: Matthias Schiffer
> > > <matthias.schiffer@ew.tq-group.com> ---
> > >=20
> > > I was unfortunately too busy to notice the issue when the patch
> > > this Fixes was resubmitted in my name. It would have been better
> > > to change my From into a Based-on-patch-by or similar when
> > > modifying it =20
> >=20
> > The "discussion" about this work was lasting at least a few months
> > with several iterations and changing the design decisions ...
> >  =20
> > > - and
> > > the final version obviously wasn't even tested on an 88E6020... =20
> >=20
> >=20
> > Can you share on which kernel version have you tested the patch that
> > you claim that testing was omitted? =20
>=20
> Hi Lukasz,
>=20
> we are currently testing with commit 71d94a432a15 backported onto a
> recent Linux 6.1.y. At least on this kernel version, the driver will
> reject a Device Tree configuration that uses the=C2=A0ports 5 and 6
> (rightfully so, as num_ports is set to 4), leaving only the
> internal-PHY ports 0 and 1, and none of the *MII ports that are
> likely to be used as CPU ports.
>=20
> So if the accepted version worked fine for you, your configuration
> possibly only used the first two ports,

And then the penny has dropped....


	switch@10 {
			compatible =3D "marvell,mv88e6250";
			reg =3D <0x10>;

			ports {
				#address-cells =3D <1>;
				#size-cells =3D <0>;

				port@0 {
					reg =3D <0>;
					label =3D "lan1";
				};

				port@1 {
					reg =3D <1>;
					label =3D "lan2";
				};

				port@6 {
					reg =3D <6>;
					label =3D "cpu";
					phy-mode =3D "rmii";
					ethernet =3D <&fec2>;

					fixed-link {
						   speed =3D <100>;
						   full-duplex;
					};
				};
			};
		};



> or newer kernels somehow
> ignore num_ports when determining if a port number is valid.
>=20
> We should be able to repeat our test on a newer kernel next week if
> needed.

I think that considering the above snippet - customer was using only
port 0 and 1.

>=20
> Best regards,
> Matthias
>=20
>=20
> >  =20
> > >=20
> > >=20
> > >  drivers/net/dsa/mv88e6xxx/chip.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/net/dsa/mv88e6xxx/chip.c
> > > b/drivers/net/dsa/mv88e6xxx/chip.c index
> > > 9ed1821184ece..c95787cb90867 100644 ---
> > > a/drivers/net/dsa/mv88e6xxx/chip.c +++
> > > b/drivers/net/dsa/mv88e6xxx/chip.c @@ -5503,8 +5503,12 @@ static
> > > const struct mv88e6xxx_info mv88e6xxx_table[] =3D { .family =3D
> > > MV88E6XXX_FAMILY_6250, .name =3D "Marvell 88E6020",
> > >  		.num_databases =3D 64,
> > > -		.num_ports =3D 4,
> > > +		/* Ports 2-4 are not routed to pins
> > > +		 * =3D> usable ports 0, 1, 5, 6
> > > +		 */
> > > +		.num_ports =3D 7,
> > >  		.num_internal_phys =3D 2,
> > > +		.invalid_port_mask =3D BIT(2) | BIT(3) | BIT(4),
> > >  		.max_vid =3D 4095,
> > >  		.port_base_addr =3D 0x8,
> > >  		.phy_base_addr =3D 0x0, =20
> >=20
> >=20
> >=20
> >=20
> > Best regards,
> >=20
> > Lukasz Majewski
> >=20
> > --
> >=20
> > DENX Software Engineering GmbH,      Managing Director: Erika Unter
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> > Germany Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> > lukma@denx.de Achtung externe E-Mail:=C2=A0=C3=96ffnen Sie Anh=C3=A4nge=
 und Links
> > nur, wenn Sie wissen, dass diese aus einer sicheren Quelle stammen
> > und sicher sind. Leiten Sie die E-Mail im Zweifelsfall zur Pr=C3=BCfung
> > an den IT-Helpdesk weiter. Attention external email:=C2=A0Open
> > attachments and links only if you know that they are from a secure
> > source and are safe. In doubt forward the email to the IT-Helpdesk
> > to check it.
> >=20
> > =C2=A0 =20
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/ybwj9Ab0+CEoQ20xl1ri6JC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYC7y8ACgkQAR8vZIA0
zr3e8AgAoVf5u1Y+WC5X9uopKhu4PoN+fE0Eawss66SZxSteYQFku1uK7xotUkbh
hsgNxyg5MO0mUprk04Hlj2FwKJ/b/r0osSIuhl3IQnBURksKIWpzFHQB0waodb5v
kL/IGL78VC+XjlwbuiVqL49kUsAJfnIrL1hk+bE0RsFvuFp0NtUpKNpkCKIA6lRR
Q+eakUtSATBhsMpnn+PL3J2P1ysCau85htvM2iRROxJTAOhRtqyzjC6eZjNvqgsp
XiixKjxwlCrOtzqxwSJoFhai4WFML99uGhti0SAsDDnAPQCe5M+PRzoukPds6jff
lzwDmzIe/X24XWv+oOn/Ml/wTzSbkw==
=ZWew
-----END PGP SIGNATURE-----

--Sig_/ybwj9Ab0+CEoQ20xl1ri6JC--

