Return-Path: <linux-kernel+bounces-54996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FE184B609
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A511F2652D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E5913172E;
	Tue,  6 Feb 2024 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksXfWSc8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84D5130E47;
	Tue,  6 Feb 2024 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225116; cv=none; b=jI4VG3oxOPhpgCt8aSBypu3f0Fy48GEvSeFE8xDs8qki3ZVccEzPefgA3b49W4cQMqKX/qzjDhtK4WKrfSiKrS7vhlAJ1Kp93pA9aBix8VUhEnCkpau0Vf11h/VBGgDt4PfNt+FyuXZ6xxwsP5kQCT0qRVQAWCdCp/JazbZpS0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225116; c=relaxed/simple;
	bh=tSp6Tey2v1ElJKcHuxM63fGPASzD58CHh96vpI7jvz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCO2qvO09Bq1IBZN/mRKEfB1C4PCfwqG2NGnlRre+KjhRcMEZPsCxCcur71R2QRZw6CdmM8gSSn7n5O4I2K6MLgRWsOTdTXBbJPIiNtXxbs0ZUIa6232cBc+2vAQZNs0ob+J+kKFXuiBc7CPL6Kf5Y1VfnbUMO6WsQfujnkeGLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksXfWSc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE29C43394;
	Tue,  6 Feb 2024 13:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707225116;
	bh=tSp6Tey2v1ElJKcHuxM63fGPASzD58CHh96vpI7jvz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ksXfWSc8D4nrezkmx2HKW0p3O0u3LJlxN+GV+th2u4W7X1z9mk9vLsyoWcZaPlD3x
	 kre7ocNWG9rwonYxwtqigM5dLtRBYpnix99qqPOfBSFMo/j0UxWOYEWHi4gX+wyDwb
	 pMmKUT2o3FJ4Ti5NAUslb8bW/OVxl6m2zgJDoS1enayA3NJl1BIRN1Sbw7Xz0mVfWz
	 kmO4SJ+2vxnMvwMRXHCdDExq+w7iq90IOyf48qpyVmDJ9zBTMyDMEGTxH/P3iSFUXD
	 yJjYl+yhObtYg/+t8BT4tGZywEpDjOmnJRgP+ZJ6+RdzU3InT1QTA9mYSxZP2XugzS
	 PqSKCzlNaqNhQ==
Date: Tue, 6 Feb 2024 13:11:53 +0000
From: Mark Brown <broonie@kernel.org>
To: frut3k7 <frut3k7@gmail.com>
Cc: Robert Marko <robimarko@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: spidev: Add Qualcomm spidev device compatible
Message-ID: <ZcIwGRU5NEZGpRy9@finisterre.sirena.org.uk>
References: <20240205191808.998754-1-frut3k7@gmail.com>
 <ZcH9u7Vo2sFERIHJ@finisterre.sirena.org.uk>
 <CAKEyCaB2Cw0Ey73je96xDgofuXDnsC4DgeS9=HkOM6Kufrwbaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TSh9X79ekmcbSvmM"
Content-Disposition: inline
In-Reply-To: <CAKEyCaB2Cw0Ey73je96xDgofuXDnsC4DgeS9=HkOM6Kufrwbaw@mail.gmail.com>
X-Cookie: You might have mail.


--TSh9X79ekmcbSvmM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 02:01:27PM +0100, frut3k7 wrote:
> On Tue, Feb 6, 2024 at 10:37=E2=80=AFAM Mark Brown <broonie@kernel.org> w=
rote:
> > On Mon, Feb 05, 2024 at 08:18:05PM +0100, Pawe=C5=82 Owoc wrote:

> > > +     { .compatible =3D "qca,spidev", .data =3D &spidev_of_check },

> > No, this needs to correspond to the hardware being controlled via spidev
> > not to an implementation detail.  Any new compatibles also need to be
> > documented.

> The device for which I want to add compatibility is originally used in the
> router and this is what the dts fragment looks like:

>=20
>       spi@3 {
>         compatible =3D "qca,spidev";
>         reg =3D <0x00>;
>         spi-max-frequency =3D <0x16e3600>;
>       };
>     };

> According to this commit, Qualcomm use this compatibility:
> https://github.com/dissent1/msm-2/commit/d6160218393552fea1b7973787f2bd15=
4f870ee2

This is out of tree, it's not exactly a good guide for mainline.  The DT
should describe the hardware, not how some particular software stack
chooses to drive it.

> > I'm also missing patch 2 of this series so don't know what's going on
> > there.

> The second patch was sent only to the devicetree bindings project:
> https://lore.kernel.org/all/20240205191828.998783-1-frut3k7@gmail.com/
> It's probably done wrong...

You should send the bindings change along with the driver change, they
usually get merged together.

--TSh9X79ekmcbSvmM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXCMBgACgkQJNaLcl1U
h9AHFgf9Hjyfancm2AjTLS+ltu1mmSm8WBQY0q55vUJxMgzqAJCL2zH/RerHkIB8
KZ49wUhsgB0qB094E2A//CFoI/js1ZtyMrBE25Q8jbBXjfG6oJnXsY6rCBCtnQFe
p9IkHYznA93Ku4HzfTG3FBd/zeXCPo8AChJ4IpDCUISdkaNwxOUXjpFKSQdSOmrR
4CDsRdxSwQhTsyjhS6Raj0GfZkPfuO//12V1PPSO43Wbxg/6C+29NGcNXl+9FcZs
93VOSOypdeOWCMcGksL2bTZJVbKJq3rb6tSweVulnrZF3D0snQM+AsLgEiNOlUH/
HeVI4O9cpr577WANG1Br1u+SYZOaAQ==
=6ka+
-----END PGP SIGNATURE-----

--TSh9X79ekmcbSvmM--

