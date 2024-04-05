Return-Path: <linux-kernel+bounces-133593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD21589A612
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E38A1F229B5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7272517554B;
	Fri,  5 Apr 2024 21:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9M1TERB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A861C36;
	Fri,  5 Apr 2024 21:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712352477; cv=none; b=VbHNtgtIYirQqArYTIm8/rdssBSHi5o0+RuCBIywxb6Fs2E2dF4qhzcsEr6hBRVLk87WEW/HNEHvQ0G0QVJR6Pya49O6R0mwgB+dKdOBp030SaHGY9yquarT7QWTf9wIJViYIH2BmgLKzGMQATX5p76zNb6p9XSsC7TQUKFDnC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712352477; c=relaxed/simple;
	bh=r2AHaawq9cdbJnZDM+X6rRc0imhgSLAPwqlxMUSDGOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jB6Ppjkiq20med6RFN7SMPlBU33jS5wiBliBnmMpcmqbdgGwrYYuTqPmd3YI02Gp6vICVokprIoN/7GGk/lxsQ/lzb9HeCL29LlVuecLSc8UMB2MyKMeVk8W1NAj2ChH1SDp6i/AGJKYoNGhtS7wQf0nfux3qKTOvw2bh8KpV5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9M1TERB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9E6C433F1;
	Fri,  5 Apr 2024 21:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712352477;
	bh=r2AHaawq9cdbJnZDM+X6rRc0imhgSLAPwqlxMUSDGOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R9M1TERBNdUBUxjGWLDBBHVDTiGhHCxiwRRpDaU4V7f1bEXwX07toqqFlHTNJlzpJ
	 2OZmOFPmUxvw1L/3ceMv7Q2zsw/PZhC+6Vjpo2h2wRCA5b8DX1VWU3rp3Ms/Ocvmqm
	 2VXhZklSsIN6cDfBgd83zcnGGHGNoz2K8Ke15tUvQ072nDN+0S/N37BqZauKcODUdg
	 BC3nxxV99mv2moMKsUfOJErisDj4BoKQZlfJpFT/zkaB1XrlKpS9xMO5aU1hZwCDEX
	 aQpFJDvkXL0P8d+6LoQMUmWYSHPm3MjxP4NPdZydfMQ2SrNXkwTiy8JYrt5ZjIJG1o
	 tpHqWoHrG/OTg==
Date: Fri, 5 Apr 2024 22:27:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] Support ROHM BD96801 scalable PMIC
Message-ID: <8740ff6f-5dcc-40b0-b2d5-9a6d137efc4f@sirena.org.uk>
References: <cover.1712058690.git.mazziesaccount@gmail.com>
 <f7d454ac-6ecb-4431-a1de-c9b5d1240969@gmail.com>
 <eb03ec33-0627-4986-be04-8e35da390d6b@sirena.org.uk>
 <b6279be8-cf7d-4608-b556-3c01587f0d43@gmail.com>
 <f1e3d31d-8c24-4cdc-ae26-747f383a937b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XOy5ZYZQYVihvc4r"
Content-Disposition: inline
In-Reply-To: <f1e3d31d-8c24-4cdc-ae26-747f383a937b@gmail.com>
X-Cookie: Honk if you love peace and quiet.


--XOy5ZYZQYVihvc4r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 12:19:40PM +0300, Matti Vaittinen wrote:

> Well, good thing is that now I can fix the regulator_irq_helper() to do:

> --- a/drivers/regulator/irq_helpers.c
> +++ b/drivers/regulator/irq_helpers.c
> @@ -352,6 +352,9 @@ void *regulator_irq_helper(struct device *dev,
>=20
>         h->irq =3D irq;
>         h->desc =3D *d;
> +       h->desc.name =3D devm_kstrdup(dev, d->name, GFP_KERNEL);
> +       if (!h->desc.name)
> +               return ERR_PTR(-ENOMEM);
>=20
>         ret =3D init_rdev_state(dev, h, rdev, common_errs, per_rdev_errs,
>                               rdev_amount);
>=20
> I'll send a patch if this sounds like a correct thing to do.

Sure.

--XOy5ZYZQYVihvc4r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYQbNcACgkQJNaLcl1U
h9C61wf+JKtHnrbZ1UFskt7o8mY9LHft9p7xpD4Qp/PPBVdJuv9nX1J+VGtXilBY
HSuudVOlwueiKL5JGO/ykEunaoPBWaQ/D8Lslk16WwTc3x2meESJxvSw7s0vpp++
mMRvNvUfLFRhJv3DPNwksFqvB8ALjcIRkU9AAz9M1A4U5JmjlO1mCTyctNxzC8Bz
kM0EdjEyqnmGebL8LHbwKL1vbD5bS1LwM9cfEu6DdvjGAjgMGX4grWLQKwi/cNzX
tS0G1B/YD5Uad2sRQ1nBos+SdGmT2Ey6PrN5clGGqdDilW6i8Asrs+Nxlo+Eml0v
El3iLVDL96gjdtmpuf/VdYGEplkeLQ==
=t/Do
-----END PGP SIGNATURE-----

--XOy5ZYZQYVihvc4r--

