Return-Path: <linux-kernel+bounces-154515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 909018ADD05
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA14F1C21AC6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C79208A8;
	Tue, 23 Apr 2024 05:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEULjgGt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688961C2AD;
	Tue, 23 Apr 2024 05:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713848450; cv=none; b=V4Nv42J66zZLzjzweS8bcVCFKipIOKcWIPE29DV6sumZ8qUy+Ka5fDVE6rhelSxOl4PUINIvjLMV49DxykhbMLeYCqzwJS0gy6Gu+3sgXMYXYdj0HHhjOg+9UVuYU75yXbe7wIcHIPwKzxzm2Z15kdyUD9O3fdwBqn5MNaFEuHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713848450; c=relaxed/simple;
	bh=SOc+Ms3uALZsNMus4DrdwDpupnWEV4dkrH8W6cFGem4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8FXFbbJ8kB0hzKC28NrhXnwOm7b2lB7qfbsq3aFhFwK6Tqfjxxs1prwqqTL/AYDcdUVU9VGUwOBHquYxWmfRXHc3bamO/BZNvkdsQKH2bDCSmzK2xVh74dGcou3x5BWc65CtrzHx9wXwk+cA84yBVvdvUtVz173SRCNUaOjnio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEULjgGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89593C116B1;
	Tue, 23 Apr 2024 05:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713848450;
	bh=SOc+Ms3uALZsNMus4DrdwDpupnWEV4dkrH8W6cFGem4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WEULjgGtG9pUusMHkzJio7CBtJzCX0wTPpniSFhg3esEUNDapT4wPGFrizt59zDK2
	 /RhX4VV433oK4EC/gCzHKMTtQSkZyjUJbbcgRTs3oG13pl/0jXGuJkW3CJihcX0d23
	 kJ4l/7mSDufEODc1mr+/jTp81U8YTKf/N+/LkVRD0QMBt69qz5Jz49XbDx2P+2robK
	 QIjSXvwQc4Zl2DAGqsMj91X016Whkq9mKnuDC2rGQtus3C9ID5FCGo0UrcklkGdCUs
	 P71KjbG/CVeU4SVx7sCV6+VCaI5VfeGDIyPNAqGidqdLhWrObhFiuk+FVdCn6qe5x8
	 1ugOg495aisqg==
Date: Tue, 23 Apr 2024 14:00:41 +0900
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
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v3 0/9] spi: cadence-qspi: add Mobileye EyeQ5
 support
Message-ID: <ZidAefc0Ejrklopf@finisterre.sirena.org.uk>
References: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
 <171283699002.32012.7629247540689477794.b4-ty@kernel.org>
 <D0QT350IJHFH.36EXE1UT9QM10@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ulKGnILG9Yl7Nn+x"
Content-Disposition: inline
In-Reply-To: <D0QT350IJHFH.36EXE1UT9QM10@bootlin.com>
X-Cookie: TANSTAAFL


--ulKGnILG9Yl7Nn+x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 06:52:47PM +0200, Th=E9o Lebrun wrote:

> All commits tagged "(no commit info)" do not show up in your for-next
> branch. Is that expected and is there anything I can do? There was one
> pending -Wunused-variable compiler warning to be addressed for
> example, see [0].

Please submit any patches you'd like to see included.  If there were
outstanding issues that need fixing then fixing those prior to
submitting would be sensible.

--ulKGnILG9Yl7Nn+x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYnQHgACgkQJNaLcl1U
h9CiTQf+J6VV/3FJ2hxvA+80nH5z+mJ9Iwc/Kx5I/LUnP9UfIjsvyTdg6m1miSGY
fJpY+P1GwtyJH1Vh0e8n8NrZ1m39dg4o0g3NwXH6S95rpAJcP7CXtO0/hEMIj8Ks
q1l6E0J01/8oGfX0D9FlG/0h8srDNPe8E7CxQCibg/nN2XU3L1xnZ8wvOPGNSWMs
oha6E/4yjhDFasrQr2PwxsCZLXSGY/DECIosUnvtJKEVLiuuvTnSOdcCn7krpdwm
dZTzFdaQNXA82tmuRHkISObATy2ZJbEPypfx6BrH/PVO4ga6Yzy6TiQ0xUEKDRMP
S6/8FJ/EozYzzvlQ9sKuOBu3oOTdQw==
=OhHK
-----END PGP SIGNATURE-----

--ulKGnILG9Yl7Nn+x--

