Return-Path: <linux-kernel+bounces-102233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEC687AFA3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1558B25735
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342527764B;
	Wed, 13 Mar 2024 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhCb20h/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DC41A38FC;
	Wed, 13 Mar 2024 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349756; cv=none; b=eriAaE3iOKi7cgyMHsmtcwkynpo5hkZhLAn4fZX7kGC3m0KfzaqKBd9mtLkBI2DCbhM3YM0fb82djyph7JhEnv/AX9NWQN0A84gwVsPFZWsaJ1m9uHlp2W5VSs9mr9LrFWETY3hnUTQpsc3QRlRli1oB+LvFCaemPubCZLNlETw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349756; c=relaxed/simple;
	bh=ioJ2BZjpPgaqeC0AtukiiPlc0mA5O/xNI4j2xvOl6FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmXp/8Ugf6IT7aFz1GJ+hgSEPRgwPWT8Rqce1eUROfBf3rMChpdwhleRmgwi83q0LnURh+QJ3Tu4unfFYJ88KJXLIETRfasuTAn+PrqtwmON/HjJdBumvT+B6o2y4mpWoi3ZObXwTvrnkOUGrsMkJfXg0Xw7N8j88/mWTl2wDds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhCb20h/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0209C433C7;
	Wed, 13 Mar 2024 17:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349756;
	bh=ioJ2BZjpPgaqeC0AtukiiPlc0mA5O/xNI4j2xvOl6FU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dhCb20h/r2WQ6R9xd7S/kYj/Hr0WbPhawbqXHt7I+qQ06nLbHocLrjaEa0OlwWXpn
	 bQX3YVALeczP74Gx1gZRzfSlPYd22eU3rFF9WiamGAlOXLf0ouVJ58mz8eZRfKx5d+
	 HBbVx0tq0JlV9w+7ywgLEuktKJo735BxO6cSlQVh9wcRbe1JQOcspyGnSedM3GNOU7
	 Ax4/I7zC25MF+cyT9WI83ua/b/OYIMOS+NM2l092D53GBwBIfWxhWiaCWwncDrco0z
	 ycPCiWUBzs7tbS2gwW5YJ/Pq5lr5Kj12eJ4DYyYHlsq5i9rYXIW+OWi7y32PvWQKKw
	 lC3uHD8ap0YBg==
Date: Wed, 13 Mar 2024 17:09:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Marek Vasut <marex@denx.de>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Maxime Ripard <maxime@cerno.tech>,
	Robert Foss <robert.foss@linaro.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 5.4 47/51] regmap: Add bulk read/write callbacks into
 regmap_config
Message-ID: <eea5677a-734a-41c0-97fa-93cf9cd1340e@sirena.org.uk>
References: <20240313170212.616443-1-sashal@kernel.org>
 <20240313170212.616443-48-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QR2Zq33ZLLgndqGX"
Content-Disposition: inline
In-Reply-To: <20240313170212.616443-48-sashal@kernel.org>
X-Cookie: It's later than you think.


--QR2Zq33ZLLgndqGX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 01:02:08PM -0400, Sasha Levin wrote:
> From: Marek Vasut <marex@denx.de>
>=20
> [ Upstream commit d77e745613680c54708470402e2b623dcd769681 ]
>=20
> Currently the regmap_config structure only allows the user to implement
> single element register read/write using .reg_read/.reg_write callbacks.
> The regmap_bus already implements bulk counterparts of both, and is being
> misused as a workaround for the missing bulk read/write callbacks in
> regmap_config by a couple of drivers. To stop this misuse, add the bulk
> read/write callbacks to regmap_config and call them from the regmap core
> code.

New feature.

--QR2Zq33ZLLgndqGX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXx3bUACgkQJNaLcl1U
h9CGGgf/Tg0S2g5h9O9iPyWzm2HInqU1EH/s084iQJfQV/VAUgHTP7d5XyOrC06O
E+K0V/ZZ6yEEmmV9NbrWy0mFq2pchFij0ciw7KHJOAA+GrYUqmrPH2Qu1uAcni4/
yjauQz6Oqb8Aac/6H2rK5bbS7OSDccmjkG7LI1H75v6qkZ0dGnvG2DDCfxNvaXGJ
xjcMj8n6rOM90JWxukQTnuGm096lYY+Yui1wrPxPQBNJROhzrLki8R7LXUp9DwVz
CjI3Nit+PpZOsACZXKMeVn/U2/N6ZIJbUceeRe91GbQWcaDdY5BAyluyUHp+Z08T
p1y7YldbHvFiM6hWoTyMe9dvbGephw==
=DXAD
-----END PGP SIGNATURE-----

--QR2Zq33ZLLgndqGX--

