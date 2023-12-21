Return-Path: <linux-kernel+bounces-8697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DF981BB37
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCC028393E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC7352F60;
	Thu, 21 Dec 2023 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvPuYSYB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B58162813;
	Thu, 21 Dec 2023 15:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00995C433C8;
	Thu, 21 Dec 2023 15:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703173409;
	bh=p268v/Z0J/H5DA9xBR1KA840CSsR1hZCKg5Z9xk2s3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BvPuYSYBl2X/2ntuQY8d5QQk0Ku6zFRvgcG2d7Z79O9T5f1wQKO9o7+gGxgJ6a/a2
	 mfCYdGFw7CHXl4NAVZpAz3J2YrB8h0NS4C7U2/mjQESTrS4dK37riC8323lwWg1nOb
	 z5etc72DN2g2y8VehSmx21Yd9vc+VbBL20ljCYhb1sHuD6qnBr8qfx33YoVTH91thr
	 wuaGC4M4c3Pgst7X9bupkaLDGvaVG4eZLc3/1+bCDoMe32XubgGgptffMXe3dmMAay
	 N2CgV3x3cyOxo9pnEzoD5Wmv/QIBuUEGZBGlvFNy3EBi8ZWhInb0GC6hbWb0EGLH3p
	 UT/ivN+mvANFw==
Date: Thu, 21 Dec 2023 15:43:21 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
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
Message-ID: <ffda1003-b752-402e-8e51-e2e24a840cff@sirena.org.uk>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
 <20231201-feature_poe-v2-8-56d8cac607fa@bootlin.com>
 <20231204225956.GG981228@pengutronix.de>
 <20231205064527.GJ981228@pengutronix.de>
 <4b96b8c8-7def-46e5-9c85-d9e925fb9251@sirena.org.uk>
 <20231205140203.GK981228@pengutronix.de>
 <88ed0c94-d052-4564-be0c-79a0f502eda8@sirena.org.uk>
 <20231221163610.47038996@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ayY3hi9uzG0eQYAg"
Content-Disposition: inline
In-Reply-To: <20231221163610.47038996@kmaincent-XPS-13-7390>
X-Cookie: Results are not typical.


--ayY3hi9uzG0eQYAg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 04:36:10PM +0100, K=F6ry Maincent wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > OK...  I mean, if they're not using the regulator framework I'm not sure
> > it has much impact - there are plenty of internal regulators in devices
> > already so it wouldn't be *too* unusual other than the fact that AFAICT
> > this is somewhat split between devices within the subsystem?  Neither of
> > the messages was super clear.

> PSE Power Interface (which is kind of the RJ45 in PSE world) have similar
> functionalities as regulators. We wondered if registering a regulator for
> each PSE PI (RJ45 ports) is a good idea. The point is that the PSE contro=
ller
> driver will be its own regulator consumer.
> I can't find any example in Linux with such a case of a driver being a pr=
ovider
> and a consumer of its own regulator. This idea of a regulator biting its =
own
> tail seems weird to me. Maybe it is better to implement the PSE functiona=
lities
> even if they are like the regulator functionalities.

Is it at all plausible that a system (perhaps an embedded one) might use
something other than PSE?

--ayY3hi9uzG0eQYAg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWEXRkACgkQJNaLcl1U
h9AWAwf+OP5Q11gZjq9GXb7vPW2rJm2BAFFBY2+mv5PDmeN23hAQZJ3hk7m0AYwr
5KBzgRuvGPeJ+pPbYmiwxNi8kXh9i8osTopdSP5p+OAzEIdT5DMqaaKJ0uWJlpYX
zS0gp3FM1eH7Td+BrOAvJFlt0OgQLXr8SADS/SwEB16iIg6mHwEdSrDw8ZI66sA/
A7ANAodvCQ0WBYAU5OvDHoNwmzuKyNTHu+Z2Wqq/PLP5qsojZTi6QrbL1hNPqiLE
lCvrWI58JCdfRjyM5f3BoQ05HDPdHTrVs1eTPScpZgHjFrwBk/89TJL87tRsBMi5
d/MFhEW24jlwrBiUU12PL9nk41zkqw==
=r7wZ
-----END PGP SIGNATURE-----

--ayY3hi9uzG0eQYAg--

