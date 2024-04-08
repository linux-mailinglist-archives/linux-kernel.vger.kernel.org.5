Return-Path: <linux-kernel+bounces-135494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEA289C6AD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4791F22521
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9D9127B61;
	Mon,  8 Apr 2024 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmXhM+cj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA63126F0A;
	Mon,  8 Apr 2024 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585795; cv=none; b=X8BSbLA08yn6hACCm/Z96ERXdigThJdiQxjH4Zzpa3jczNA/lZ6K7yZVTzq23+oL9hLZKKl3S0cLMhR7QxcreIM2eRDWvSQPvZw9tB3/rFRFlyu23yEmzxv6UTJtFv/tFu+aP5Cm34DA9/+XI9m8FlT4JjPuVlyWaUdkjaGeNe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585795; c=relaxed/simple;
	bh=X165AnuBYRCLHgg1FBFdg4DExbBHQa5z8zpoZFRqZc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbAtJ2dVy6GyU1P/3aKdMM3ZE1vjWSnU8VRGCfrl+7OoWJC7b0PwyMy/eYgliy72YOjo0mE+j4sWHv5yCDNCS/EHvx8LoW7HjGUxdlTsGLyM/le4wJ3Wk+1id/T77RkBZp2eS3/7kQwJTLSQNte4J9ww9+/xrZ0HR1DvE+UdMXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmXhM+cj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF22AC433C7;
	Mon,  8 Apr 2024 14:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712585795;
	bh=X165AnuBYRCLHgg1FBFdg4DExbBHQa5z8zpoZFRqZc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KmXhM+cj2OPb3adXuSg4edYNC0GHkDzr9jQhOPgzYHgxP7oalPHLskK8lw2xJlZ8m
	 RxTpWeSEPRLXsaQSg+wCB2PqVGr+0sNbuHHzZWojgt7EZ8D+vjRYYMGbcpcQlhvoSu
	 oITPvZ9sZDp+tkkSpQWbBgq+8TF+3CHnPfcxJ7dceIaTIYl9/KCWYwA8mXJ0RACXM0
	 MY5JOZjN7SX/GGmWgpy+HqwcTtk9jqHCWh7V8A+nEl5/cXTwrW0O/DDmYApFEgYT2H
	 SIjuANUKwzGZrknnNcBipQ9xCHmSJ5uQ9p20157HSlLM0buWXQ8kq4uAl+klFo2eeN
	 41eE1k1B60YZw==
Date: Mon, 8 Apr 2024 15:16:29 +0100
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
Subject: Re: [PATCH v2 08/11] spi: cadence-qspi: add early busywait to
 cqspi_wait_for_bit()
Message-ID: <1f7087ad-824e-47fe-9953-ed5152c8f18f@sirena.org.uk>
References: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
 <20240405-cdns-qspi-mbly-v2-8-956679866d6d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M+xzRGuQWIs7ztiG"
Content-Disposition: inline
In-Reply-To: <20240405-cdns-qspi-mbly-v2-8-956679866d6d@bootlin.com>
X-Cookie: Drive defensively.  Buy a tank.


--M+xzRGuQWIs7ztiG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 05:02:18PM +0200, Th=E9o Lebrun wrote:

> If the CQSPI_BUSYWAIT_EARLY quirk flag is on, call
> readl_relaxed_poll_timeout() with no sleep at the start of
> cqspi_wait_for_bit(). If its short timeout expires, a sleeping
> readl_relaxed_poll_timeout() call takes the relay.
>=20
> Behavior is hidden behind a quirk flag to keep the previous behavior the
> same on all platforms.
>=20
> The reason is to avoid hrtimer interrupts on the system. All read
> operations take less than 100=B5s.

Why would this be platform specific, this seems like a very standard
optimisation technique?

--M+xzRGuQWIs7ztiG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYT/DwACgkQJNaLcl1U
h9ANxgf+Mzi0qALbTQtJ/4YLKSo7Rz0O7xI80u/4JR5cdbLhKIR9wyfq/zYpC1ou
GugX7jgji68/5rmgbPrXCgMFmfmy2h/EjN3t5sEUIMjtHum2Wxo7AMvAE3l4SPvw
MsrJvoxg975ApHEXE9CZlzKHaof5nQ7xK4j2tyqCK/1TkUh2zXKFhG0uB/AnIQJg
jqC0+lTHXviEqqjqx0CM5wcmuzkx19rxpVNsa6wgVy1z9Iy2BF+gR9c04CLiA438
Og1GynxgfKht138oDVWMEyx9YnMW4DcN8Z8VG82u52z/G/2fUFVGYuy77gNrt9f5
nbsZFB8X1UwZHCYA+oX1w5wz/xt4nQ==
=/C1O
-----END PGP SIGNATURE-----

--M+xzRGuQWIs7ztiG--

