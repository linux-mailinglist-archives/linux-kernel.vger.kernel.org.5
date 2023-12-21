Return-Path: <linux-kernel+bounces-8854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC97281BD4D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1FB01C20BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A220634E6;
	Thu, 21 Dec 2023 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiLC3W/b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC7C62813;
	Thu, 21 Dec 2023 17:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339C3C433C7;
	Thu, 21 Dec 2023 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703180049;
	bh=tZpLiDPgbcp1+gCDmMjOIB9hnwodSBsk4RRE8sDpJcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FiLC3W/bBfhAafv1SxSf2paV6MA+73GTSjIQPNTVbA3a/z5CbQ+uegwTThhTO2ell
	 Ly0HSOa6lw8Gt+vasc30GJ6UNe7o4ukCOPF3gmVncl5YUsKFBudcN3BrWYSXE+JJ5J
	 83jUoXjp58UcFNmJMU9Mru0z0sVo/Yqg9E4Cae9tChCV31ZdQ/GYxhMdDLOXMPkW4A
	 v9hiboc7vpYqeAFE42xg7JLDXtSAjldYSFCMqVONES7nfnnW/6HNgSaTdfV6Yvd3BJ
	 +//arj+dNTqLygKmB0+69WmoVf19UiPi9cq7DYpGPc0NKhsGgMI1EbOeE1ukcuDyz4
	 qwy+vxFz8M9hg==
Date: Thu, 21 Dec 2023 17:34:02 +0000
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
Message-ID: <8a8b0735-f1fa-401d-9f92-bb9ce8bd1e7d@sirena.org.uk>
References: <20231204225956.GG981228@pengutronix.de>
 <20231205064527.GJ981228@pengutronix.de>
 <4b96b8c8-7def-46e5-9c85-d9e925fb9251@sirena.org.uk>
 <20231205140203.GK981228@pengutronix.de>
 <88ed0c94-d052-4564-be0c-79a0f502eda8@sirena.org.uk>
 <20231221163610.47038996@kmaincent-XPS-13-7390>
 <ffda1003-b752-402e-8e51-e2e24a840cff@sirena.org.uk>
 <20231221171000.45310167@kmaincent-XPS-13-7390>
 <501f671d-4e03-490b-a9d6-e1f39bb99115@sirena.org.uk>
 <20231221181955.422e676e@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SyGCkrmxiABQ1d98"
Content-Disposition: inline
In-Reply-To: <20231221181955.422e676e@kmaincent-XPS-13-7390>
X-Cookie: Results are not typical.


--SyGCkrmxiABQ1d98
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 06:19:55PM +0100, K=F6ry Maincent wrote:

> So we will have PSE drivers which are regulators consumer for the chip,
> regulator providers for all its ports and regulator consumers also for al=
l its
> ports. Is it clearer? Would that sound ok for you?

That does sound fine, and like there's a use case for substituting in a
non-PSE regulator in embedded systems so we get something for the effort.
You might want to take a look at the arizona MFD for an example of a
driver for a device which includes a regulator that may optionally be
unused - it's not ideal but it does work.

--SyGCkrmxiABQ1d98
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWEdwkACgkQJNaLcl1U
h9D2YwgAhrLCcIl4Dri+vJaS3qntIoQNnzudbw464z0YawWeutbUGmUF1yTPrL3r
310g2eca0UDhGXTI0jksOmy1IQHZNleh2psZ5n7qAHqzLPRKj5h3IbQZ7DtogYbd
eWSdibMpOp8cqtYnMCNRjIznmGYfZPepV4TawWqarPC5qbO7pN3fjjawYc9YD1Hp
94vhC35OOxe28vLxszoFVHpioVq3qYSFTfDMlaiAL+7sFNTlP+hbZeY09NP9jLU6
gBlqjJSnrE81CEBI/M+TdmFlfhGn71d1BlH7E+CRHCv96ExNBiXQKrBJSB7ItHnq
g89pBtKDvcVWHTk/9AI6B1JWV/FoqA==
=tjbD
-----END PGP SIGNATURE-----

--SyGCkrmxiABQ1d98--

