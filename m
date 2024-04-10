Return-Path: <linux-kernel+bounces-139288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4F78A00FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A2B28A926
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5C3181B94;
	Wed, 10 Apr 2024 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7aByR5K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932E628FD;
	Wed, 10 Apr 2024 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712779402; cv=none; b=ltR169iKRMzkS+22Om09Do37qo2G8h0hw6nDpDsylbmSYodHPqrHhQ6tA5RO6Alp3R5YUT+HXPq6o/7D73BeVqPq1zr2QR+FCWk815aGK24qFvtzbPphligDYacEmMnj/h18XA7nDwWyoKADy6oHBs7yunIdH8gxYDM9zItz7G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712779402; c=relaxed/simple;
	bh=OQZjFvx3Au1OHLYkCyOKCIW526eMMbQD5hbmY4kRkZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fbd0rCY82kl6hlxblCAGAphF7O9eEm4Kw59QGaFRrTX/cz0QR7r4Pr2ItdqoyvvULefPQwsfmEzE5pK5OQZatUJFsAFBpYj2cPLzb9lp1DpP1jvd91YB8DEqNFmPvAKWl+Lm7gH7EeOWyijI0t1TpRIV/b4RKujL3qydJ9/Xpe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7aByR5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABA9C433C7;
	Wed, 10 Apr 2024 20:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712779402;
	bh=OQZjFvx3Au1OHLYkCyOKCIW526eMMbQD5hbmY4kRkZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c7aByR5KjH2/wHYQghVF8YUXXkVjxKI32XD4S6NRrAk2pXOx+19xgkLxiSMEr8+55
	 iz5OOzQq2kF93WIuCQCJ5+Qzshs1fB10OzsXibnp436RkhbIxxL7hXElUzDu9LqoTR
	 Ku18U3A0y+MRAVF2+p0u/PbnfMiUclRH6cjaT6W5EAnaGTZu7bbPeZTPYQJjYhVFLR
	 1Whji84ZVMxTuHDnrYSzefDAJjxDXV7aKhQcvdyWaGW4bSfm+5cq8cKPTkoMYh6JMB
	 HfuFdFYHgzwxT0Bos7/X2RASdJhxKOBaCnVS/xQinY+uS567eBPdLawPAFfHod5xn7
	 M7QcJkoKBFCQg==
Date: Wed, 10 Apr 2024 21:03:14 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vaishnav Achath <vaishnav.a@ti.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH v3 4/9] spi: cadence-qspi: allow FIFO depth detection
Message-ID: <161eebc1-9417-4ab0-ad8c-c1b17be119b4@sirena.org.uk>
References: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
 <20240410-cdns-qspi-mbly-v3-4-7b7053449cf7@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BRtEqc5sxDPHJ2tk"
Content-Disposition: inline
In-Reply-To: <20240410-cdns-qspi-mbly-v3-4-7b7053449cf7@bootlin.com>
X-Cookie: Jenkinson's Law:


--BRtEqc5sxDPHJ2tk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 11:29:07AM +0200, Th=C3=A9o Lebrun wrote:

> If FIFO depth DT property is provided, check it matches what hardware
> reports and warn otherwise. Else, use hardware provided value.
>=20
> Hardware exposes FIFO depth indirectly because
> CQSPI_REG_SRAMPARTITION is partially read-only.

This breaks an allmodconfig build:

/build/stage/linux/drivers/spi/spi-cadence-quadspi.c: In function =E2=80=98=
cqspi_of_get_
pdata=E2=80=99:
/build/stage/linux/drivers/spi/spi-cadence-quadspi.c:1506:45: error: unused=
 vari
able =E2=80=98ddata=E2=80=99 [-Werror=3Dunused-variable]
 1506 |         const struct cqspi_driver_platdata *ddata =3D cqspi->ddata;
      |                                             ^~~~~
/build/stage/linux/drivers/spi/spi-cadence-quadspi.c: In function =E2=80=98=
cqspi_control
ler_detect_fifo_depth=E2=80=99:
/build/stage/linux/drivers/spi/spi-cadence-quadspi.c:1582:45: error: unused=
 vari
able =E2=80=98ddata=E2=80=99 [-Werror=3Dunused-variable]
 1582 |         const struct cqspi_driver_platdata *ddata =3D cqspi->ddata;
      |                                             ^~~~~
cc1: all warnings being treated as errors

--BRtEqc5sxDPHJ2tk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYW8IEACgkQJNaLcl1U
h9AP3Qf9HrV26p6I6pNjiy1Rr+g3QMlk44F2HNPvnj7jvAfZmd1M6+sG/WykOdPX
Wnkq1igLy45LZzQB/smyw3eFOzlDyZHs7diTtDOKsx7hC1KLYzbX1n7s8IVzx2FD
UDJYdBzop0PAQT6Sk1VrHPgC5TCWwRNlwTs+WKqo+/aLndCxKlS+4ZVZeyGV+FYJ
gE1YZe/Z9EZZoVm86tEd9Os57oQUfq0T6gU29g7H9cDMu0TJy4uwPnnOxbf74GCO
z1qBAffTfUAERgs7anH+e3xNyvejRwTM9spESFKPxeNiH8s0eg9N+tzcGTa5GsAl
I2Dx4GjIaTHoao5epVvxs6ODnuTk5w==
=sDD9
-----END PGP SIGNATURE-----

--BRtEqc5sxDPHJ2tk--

