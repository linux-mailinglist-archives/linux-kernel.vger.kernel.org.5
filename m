Return-Path: <linux-kernel+bounces-8900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D02B81BDE8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390B728C5ED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5136518E;
	Thu, 21 Dec 2023 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljigpITK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD41627E2;
	Thu, 21 Dec 2023 18:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E661C433C7;
	Thu, 21 Dec 2023 18:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703181935;
	bh=D5T8wHGhxAKHwrI/lC8X+GMnYbXpN7+mZX5GeytoQ04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ljigpITKWRoXryXYXE7TF2C2rWPXY88P26mNPS/9U7CNNAjF5Zgv7xB2KPUv4brT3
	 PXS8SzBv56B91NY5jhDj5FMdLD1e2lW8gEtAJh0GRa3CzOWW29o1BubDuLqBcPnKF1
	 p+rUcxAizfn9zOMvUHawaFn6lITidua0/D9rs6oepNSEDamK1ClDAXQnS1s/fG3n7b
	 65MR+q0DuQxdlKBgnwGld9sXNpSb6nquEs7dgOjIzxgB1MwHx4Zt+eynFiDDvsfjYB
	 MTuXW+ZX0eFdIOjOx/6Ork84bt15YpWCDAKWnm7nPvbHDsKeey4pUs6hK+p/uNmzP5
	 rNzVDH9I/ZriA==
Date: Thu, 21 Dec 2023 18:05:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH net-next v2 8/8] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <81f0ddba-5008-43a4-a41c-c7b6ba8e2e3b@sirena.org.uk>
References: <20231204225956.GG981228@pengutronix.de>
 <20231205064527.GJ981228@pengutronix.de>
 <4b96b8c8-7def-46e5-9c85-d9e925fb9251@sirena.org.uk>
 <20231205140203.GK981228@pengutronix.de>
 <88ed0c94-d052-4564-be0c-79a0f502eda8@sirena.org.uk>
 <20231221163610.47038996@kmaincent-XPS-13-7390>
 <ffda1003-b752-402e-8e51-e2e24a840cff@sirena.org.uk>
 <20231221171000.45310167@kmaincent-XPS-13-7390>
 <501f671d-4e03-490b-a9d6-e1f39bb99115@sirena.org.uk>
 <20231221174246.GI1697233@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9BoYyAUBuFErv7HY"
Content-Disposition: inline
In-Reply-To: <20231221174246.GI1697233@pengutronix.de>
X-Cookie: Results are not typical.


--9BoYyAUBuFErv7HY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 21, 2023 at 06:42:46PM +0100, Oleksij Rempel wrote:

> The main question is - how to represent a remote consumer (Powered
> Device)? It looks for me like having a dummy regulator consumer for each
> (PSE PI) withing the PSE framework is the simplest thing to do. User
> should enable this dummy consumer from user space by using already
> existing interface in case of PoDL - ETHTOOL_A_PODL_PSE_ADMIN_CONTROL
> or new interface for Clause 33 PSE.

That's not even a dummy consumer - the physical power output from the
system is a real, physical thing that we can point at just as much as
any other physical device.  Some kind of library/helper thing that
connects up with other interfaces for controlling network ports like you
suggest above does seem like a good fit here.

--9BoYyAUBuFErv7HY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWEfmcACgkQJNaLcl1U
h9Acggf+NDcjJKIBfD5BoXWMfSIkaHsYiitSj17XijQ9AOb+V8MrpL1QbuK2lHzS
yZv4O/Ed2yk2oLnxJ029R54HnKgXQ25hZKFjdGkLxCHSZS+GhzRPHw7QLIG8KeGO
Aw4qjs/Lkd5Nv6sNBs4es4wUiOY5+unwiqOEBZn+doFs6amX0i9Sedk8HqTxpA1l
BjrYbDuacb+WEe2vLU1mTrz1+VF67nSO8R+iyShD7sss5AiiLtxxMwiBlPsZn+ec
rjFGC5L2bxo71F1HTKDyn108V5E/u0kpfhbRab7jSGr3Z+48TjBczb+QaNfkzegY
GswtRELPkEY6dOfiXM/49YnnGd+6mw==
=A5qx
-----END PGP SIGNATURE-----

--9BoYyAUBuFErv7HY--

