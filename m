Return-Path: <linux-kernel+bounces-79784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 314A78626A1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1911F220D1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4BE487B6;
	Sat, 24 Feb 2024 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLhlbErp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2667D16429;
	Sat, 24 Feb 2024 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708798443; cv=none; b=M03fWpc4fAt6Tbs4Vm2tC6VuvtDBcrCA9lr/JgVR3gyEOuTPLgefbPx0lNB5xFHmnjir8xxfnuBhp9xMwQhmyylJn4iPMASw+jK6rIg2lyWUlnkJqJqKVxsPAk7ZguSRkhtiEIjYW04bqI7SL2zHqEliGT0Y88IZgUS0+dDdmQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708798443; c=relaxed/simple;
	bh=sPA7yBwyKjsWGwDntNiw7DZEYxFc8Rs89PkJp26a0VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxxpJNKVjdlMocpQXaGWlXBsrQurIv/ZkRilA12o8XSE4BI5LmfC3vrNnWeLS8nJzmqUOHutKL9xe1ndwQDaD1fxt3Uy0LBcRwqvD6eaHFv4GbO+Zf8ogAg+Kig3mUgmeteqthYx+/rTpXAYLSQEJ8ds1eM2T60gq8y7b5V2LbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLhlbErp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6FCC433C7;
	Sat, 24 Feb 2024 18:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708798442;
	bh=sPA7yBwyKjsWGwDntNiw7DZEYxFc8Rs89PkJp26a0VM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MLhlbErpDutscHeKktsiaBqtQmT0xRnXkxi7vmzHuCYEZegrKJJ5x4ZBvZ4V3qq0p
	 1xg+T1bTyK7F8vzENsYq71P8S84sotBy7HE5qdvCV98fyyhh+TJljPuPSQrenya6tw
	 qfwT0//6LbByeoUnHu0vGSTUFNk1PCfB4udXdY0MCeQDNMebDTKjL7O+ftuK+sBAzz
	 ICondCRyY3AWipgsJtYVdZXDJK4u7AX5g5ynV1pPFcTlh4isSN8fSazz3reYdOveQx
	 Y4YpaESeoT3ofYnVpiin8zik5AsxuhVlZsHYdwtUV5ekXo8seovOM0/btxRa4uuDJe
	 Kkoeo+/z+5qag==
Date: Sat, 24 Feb 2024 18:13:49 +0000
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux@roeck-us.net, Conor Dooley <conor.dooley@microchip.com>,
	Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Zev Weiss <zev@bewilderbeest.net>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] regulator: dt-bindings: promote infineon buck
 converters to their own binding
Message-ID: <Zdox3R+0qaWvcfju@finisterre.sirena.org.uk>
References: <20240223-moonrise-feminist-de59b9e1b3ba@spud>
 <20240223-blabber-obnoxious-353e519541a6@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hg+eUjTJNkNGJ6kU"
Content-Disposition: inline
In-Reply-To: <20240223-blabber-obnoxious-353e519541a6@spud>
X-Cookie: You might have mail.


--Hg+eUjTJNkNGJ6kU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 04:21:06PM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> These devices are regulators may need to make use of the common
> regulator properties, but these are not permitted while only documented
> in trivial-devices.yaml

Reviewed-by: Mark Brown <broonie@kernel.org>

--Hg+eUjTJNkNGJ6kU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXaMdwACgkQJNaLcl1U
h9B+jwf/R3DWfPP5cHwVPdFdPFFZK2GRRtEJMJvcUV6JTjlX2lorNDMiNJYP1Zug
/2f2detas0gQ1wO4ThQCmED+lUi+/HOImTsZOMIWFVqGdTQRnexFlU49gPiwU2dD
zLaRaDZGJwshEN/Llscz7NaOeFyzKN8UlW5hVhQhno0/W1+VTi6jjaWddytQuN8h
DxAXaE1P3jG4klKV/AZcfPhY2+WufWTrKLhdxtNqMtMyro+0THFA189pgUKik0Bd
IUfYCmOq2ZV90hqyNAQz+TaKuBcr8D9nOaYSgRXWcsNMj+/sPqc/yvwf7WUuYKXS
7B6YlBYs1+Mjt7FCF03oVFpM6aKRoA==
=tNlX
-----END PGP SIGNATURE-----

--Hg+eUjTJNkNGJ6kU--

