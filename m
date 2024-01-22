Return-Path: <linux-kernel+bounces-33991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DBC83718B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44DFC1F31344
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDBB53E10;
	Mon, 22 Jan 2024 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Du/KA8rT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25B453812;
	Mon, 22 Jan 2024 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948517; cv=none; b=Vmbs7zG/MUvuEmXxvXnuzJ26pHDiFrPQ9xKfXAZ/iW1S/QJ9fml30ZzNq9UaytCQPfvvCvH3uVJ7CgIG53yJEyaGKsSEOPWMpj7vQG8dVz0AcAeAnbdOtyz71aPyhVwWm3sR5VEhC2ZPOpInscISYpF4aV1tBpMNq0dSwL/29r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948517; c=relaxed/simple;
	bh=AmKgOrFYeZcl7xeSVP/i13Nb5YyEv45rIRjYAFiF5gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ly2aj2+PcDBk6Rl0H9bBzPj4Jfj1jHzNInhEADO4x82RtrgKUjG1nHdH1NX78LBN4EvTivBL282PL5qK2VwhdHOzswTEsv0ChErHV/d6TJr09++TfjYD05WL80x9LPNowE6eCw3lrqWPcSO7pq2OHrVMt7P4G8A6pkvSisu9Sto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Du/KA8rT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C189C433C7;
	Mon, 22 Jan 2024 18:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705948517;
	bh=AmKgOrFYeZcl7xeSVP/i13Nb5YyEv45rIRjYAFiF5gI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Du/KA8rTpObMYrHbsX0TJWCfGISbIuCM4nY6qZSAADOkvC6cav9798q8/U8Pizkbg
	 pHGsKbB2zXH/0jzJ45zsMY/q/oEmRjv2oFJLYvPrfJWgJyzOb8ZsgS1sS3r7gskaxO
	 iDMkW47V3WdGF6QV0uNUfIMGwMjvZF+1ZNlYSQyPi9VG7Qh5u+Gp9S50WXBckpvh03
	 nnH10xMyjwXDJPLwQnwsLPsJM2zdhsU6Xm+iB22RobgXHb+IEIoslMaU3FSj5yleNA
	 6bxH9DLdCwIb4YJIoGfP4uP5/kEBkTA7iNqosh1nvPLwQpn9FcrKylZhZMGt4qA5nl
	 XfyQmHOqNGlPA==
Date: Mon, 22 Jan 2024 18:35:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Klaus Kudielka <klaus.kudielka@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] SPI updates for v6.8
Message-ID: <be96e4bc-0a4d-444c-88cf-fc77fefd64fd@sirena.org.uk>
References: <20240107223817.EDB59C433C7@smtp.kernel.org>
 <d8724cd416494bb5cd5b0350266fce0cb7b3b210.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k67nLMvRnMsshTbL"
Content-Disposition: inline
In-Reply-To: <d8724cd416494bb5cd5b0350266fce0cb7b3b210.camel@gmail.com>
X-Cookie: Nice guys don't finish nice.


--k67nLMvRnMsshTbL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 07:30:09PM +0100, Klaus Kudielka wrote:
> On Sun, 2024-01-07 at 22:38 +0000, Mark Brown wrote:

> > =A0- Support for multiple chip selects.

> [skipped the rest]
>=20
> Hi, it seems I have an issue related with this new feature.
>=20
> I just booted 6.8.0-rc1 on Turris Omnia (CONFIG_SPI_ORION=3Dy,
> device tree: arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts)

> and got the following error:
>=20
> [    0.090231] spi_master spi0: No. of CS is more than max. no. of suppor=
ted CS
> [    0.097358] spi_master spi0: Failed to create SPI device for /soc/spi@=
10600/flash@0

> End result: the three MTD partitions I used to have on the SPI-NOR are go=
ne.

Yes, this was found on another platform - there's a patch which should
address this (unless the number is more than 8) in CI:

   https://lore.kernel.org/linux-spi/20240122-spi-multi-cs-max-v1-1-a7e98cd=
5f6c7@kernel.org/T/#u

--k67nLMvRnMsshTbL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWutWAACgkQJNaLcl1U
h9B5/wf/SRB9JrlDYGQrKjFySIk9gFKcuIZfZCDsIWyBn3BglO2sWATPBvDGv8rw
//0ay00R3qHUh2q88MvrBYLc28daRTIIhBSICBw2ialw9vtHcoxRffkhfhoVNmfq
1dNLGNQZjOaR7C/lco1b51XMmJDb7AQAi86mZPUeXRoGV6LUaeFwYUmMQYsNYdya
SchkQs3GmY+OG8AFalVQjZ2x1Y6cKp5mjkLcDNBjpGGCkGLQy+CkkOKBMCr58X/9
c8v2wNZi1yMaOS3fIWYJNllqjV3EjgtNdOjBdM8p6uTYb8o/5pHEbY/LWOK/NP9f
XovzpLM3mmhqZO4jcoPWr2oQ28zr2w==
=K8aC
-----END PGP SIGNATURE-----

--k67nLMvRnMsshTbL--

