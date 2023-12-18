Return-Path: <linux-kernel+bounces-4052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF11817744
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C328D284DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBF7481BD;
	Mon, 18 Dec 2023 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXfV4YdX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2260E4237E;
	Mon, 18 Dec 2023 16:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F15C433C7;
	Mon, 18 Dec 2023 16:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702916359;
	bh=O2FEuDifDL2P4lnmBQkiXP99VZ+Qm7eQRuu60BX1nSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IXfV4YdXf5jsq5qlVkCEFGHdm48BTHmeqPG6MW0lYxHcHpDvZ6a7qmRepwayqI7UG
	 CreEzroBp3BvhY7ErEe7YGRp5mb2mR+AgdIw7ayhcvN6F/d8EAQImqvz8Ua+akkib9
	 4+gI4V5eldQgpJ3GG9okMaI2YbyNNIAYwIOhPQfYZM4ySzQhk9RCFf9EMhHKtXxDwy
	 XZPk2WBOHiUbfvnny+tP/H3N5O1wKLEx3LpOUPVUDEzlW8aHSiSAbYygJECrRaDgJ6
	 9EwZPHaKEYtrgwiPmcMuL2wsXYVFCOLpEwIjxnWTqLH+2QSEQD0uq4hr8eMMAMXOf1
	 xgrMS3GbdCDpQ==
Date: Mon, 18 Dec 2023 16:19:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/5] cpufreq: sun50i: Add D1 support
Message-ID: <20231218-qualified-mahogany-05e1d6630152@spud>
References: <20231218110543.64044-1-fusibrandon13@gmail.com>
 <20231218110543.64044-4-fusibrandon13@gmail.com>
 <20231218-blabber-slapstick-ab7ae45af019@spud>
 <20231218155345.476e71ea@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WIOIVM4fGS0/A+5Z"
Content-Disposition: inline
In-Reply-To: <20231218155345.476e71ea@donnerap.manchester.arm.com>


--WIOIVM4fGS0/A+5Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 03:53:45PM +0000, Andre Przywara wrote:
> On Mon, 18 Dec 2023 14:55:30 +0000
> Conor Dooley <conor@kernel.org> wrote:
>=20
> Hi,
>=20
> > On Mon, Dec 18, 2023 at 12:05:41PM +0100, Brandon Cheo Fusi wrote:
> > > Add support for D1 based devices to the Allwinner H6 cpufreq
> > > driver
> > >=20
> > > Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> > > ---
> > >  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq=
/sun50i-cpufreq-nvmem.c
> > > index 32a9c88f8..ccf83780f 100644
> > > --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > > +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > > @@ -160,6 +160,7 @@ static struct platform_driver sun50i_cpufreq_driv=
er =3D {
> > > =20
> > >  static const struct of_device_id sun50i_cpufreq_match_list[] =3D {
> > >  	{ .compatible =3D "allwinner,sun50i-h6" },
> > > +	{ .compatible =3D "allwinner,sun20i-d1" }, =20
> >=20
> > I thought the feedback in v2 was to drop this change, since the
> > devicetree has the sun50i-h6 as a fallback compatible?
>=20
> Well, this is the *board* (fallback) compatible string, so we cannot assi=
gn

Oh of course... That's both me and Jernej that tripped up on this.
Brandon, please ignore the comment from me on this patch.

Thanks,
Conor.

--WIOIVM4fGS0/A+5Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYBxAAAKCRB4tDGHoIJi
0vwCAP9HxMt2rr0zzqQjlPunuOySoBKZQSCHZ/XtknDCK5QmRAEAmC4SAoti4deM
mI0Y9cwGsZF8WY18EbSqa4VWObGbdwA=
=bD8L
-----END PGP SIGNATURE-----

--WIOIVM4fGS0/A+5Z--

