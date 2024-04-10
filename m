Return-Path: <linux-kernel+bounces-139299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECDB8A011C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305BC1F24AD0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C864181B94;
	Wed, 10 Apr 2024 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fe1rQ3cG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5212E3FE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712780192; cv=none; b=nnGBN67r7xKgp6qhYUDtUvjMZwNJG3Kg8XNYvVSxoZXokHMHKPc+JgueFNtynGXnAG5x5UnsPPa3nG9GTz+8BRXxxTNqQl4j3DRkXowWzwRags9ugYQ9BD1EyhtUnYo8TYmk/VjhnIccQI8OWRp6O2C0D2P6xGH5S/TfWtV4MzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712780192; c=relaxed/simple;
	bh=OFX3cJHQcAd/OU+KZoF9dby2TwnpRJ+fJmkGn3cUSSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lD4ERHothPgqm5BF8jBGoOjuGrgOJBZdE8xCp2TmcD3QcbZ3VHj4ZXx8QZTZ0Ta53oZ3uITFtAygqrWYHTGsdr++13wyK6en+QWYRqdhC0EHKcJjIvv1aBKWgZExRmiWjNgAkcW9pL+6fXugN3cHlBy0sdd3yQ3Qe7lDoxEHvvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fe1rQ3cG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6552C433F1;
	Wed, 10 Apr 2024 20:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712780190;
	bh=OFX3cJHQcAd/OU+KZoF9dby2TwnpRJ+fJmkGn3cUSSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fe1rQ3cGeVTVqifr/j+elAtxe0KM6R8Iu2HRWRCwOcNprOGKwOsKX945yp/L4NcL/
	 e2PoqUC/MWQh10WmvYh/RXCY0U45Pjipyffx5Fdx8NUHamvdwq6eh/GBl/dFKiH7A9
	 xo8h4bgvweiFYkWSIq9/uCF96IT7LKJj8sRKg49j1tHQouIwkDuM1wySvo5QZiZJ6T
	 xfgpCYTaB0/k+3q0sOKP432sDbMjRLg6LiIIn8KGb5h0VWqfuSDktFHtgdcPWzpJb+
	 uIyJ1fpo1a1n3L+KzSQusc5g9aqutx931P7L/X8ktrBVs3HvlTvOpt6Q2pzJ8UCuDD
	 f5qCuVVe/zs3w==
Date: Wed, 10 Apr 2024 21:16:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] regmap: spi: Add missing MODULE_DESCRIPTION()
Message-ID: <8dd5a474-ec45-4f0d-b1a9-e91e54c990fc@sirena.org.uk>
References: <20240410200031.1656581-1-andriy.shevchenko@linux.intel.com>
 <3602aa7a-15c9-4e77-8aa9-a12f2136530c@sirena.org.uk>
 <Zhbyu-qI97eBxtxU@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="maigQXm7iw5LCTEy"
Content-Disposition: inline
In-Reply-To: <Zhbyu-qI97eBxtxU@smile.fi.intel.com>
X-Cookie: A bachelor is an unaltared male.


--maigQXm7iw5LCTEy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 10, 2024 at 11:12:43PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 10, 2024 at 09:05:17PM +0100, Mark Brown wrote:

> > regmap.

> Hmm...

> drivers/base/regmap/regmap-i3c.c:59:MODULE_DESCRIPTION("Regmap I3C Module");
> drivers/base/regmap/regmap-mdio.c:120:MODULE_DESCRIPTION("Regmap MDIO Module");
> drivers/base/regmap/regmap-sdw-mbq.c:100:MODULE_DESCRIPTION("Regmap SoundWire MBQ Module");
> drivers/base/regmap/regmap-sdw.c:101:MODULE_DESCRIPTION("Regmap SoundWire Module");
> drivers/base/regmap/regmap-spi.c:168:MODULE_DESCRIPTION("Regmap SPI Module");

Feel free to fix the others as well.

--maigQXm7iw5LCTEy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYW85oACgkQJNaLcl1U
h9CAZAf/eo8p+blYn6Ptv4IHfGKv5fowJJJkA/vXGxE0KHyi0C++PboD8/0YAAe7
fNymUUJSxbKn8M/EZhc/4H/n0ksbDRaNqj44p6oySzH3BQi23vcosGsXPJiCsULU
oZHx0VZPLZKyULvdjkG+qVpbDSsPl8Dr+GCzu/8C/eGFqslSEpNi7JtdJQeOskWT
DCHB/nTxtVusLcExNXSIQphTdrd0nUFARauynLxxQcpoSnZ4KlLMFwVGinddfAma
IybhopoAynXKLlzZa/bxBEHafO2V9p7RMqJNpDHEUBl256xX0CqRbGo8McFupKMm
CQEXCCnejDRZN3KNoGI+UcubgtRatg==
=+aeD
-----END PGP SIGNATURE-----

--maigQXm7iw5LCTEy--

