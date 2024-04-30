Return-Path: <linux-kernel+bounces-164501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD77D8B7E51
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191991C22476
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7713517BB39;
	Tue, 30 Apr 2024 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAj7O+2D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57FD17B4F7;
	Tue, 30 Apr 2024 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714497550; cv=none; b=b0+RjzodyY36Tmdfdn/4CqvYHGTjvBi+/REP/BZKeBXwMcghVT+l1tbuoC2xr1mAmV2K493RfGSMTA9IvtfNNr5z+SzqBsM9jt1I+G7E14JCiktGwzpF46wMpoAlXARTf+yiE0nWLKLwDhbqPOn4af5Jm54bggw5SIODPs4JmPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714497550; c=relaxed/simple;
	bh=Hl84TvAqxxlDZYztV1+LhdywsTGPVKAUCUmWwRA6F10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VryiuD0MakUYPl15mAdqltHCFWOpblMvhYcJme4OQ3vRYCE4Jkz/9Ivs0mCpBpmuoI3fWANVlT1eeOOzZD6KTyvGzrtSbMCi5pPhSaFKDLN7EDtKTRwXnHz6Nn+m52YWeG6ZnzVk4L5LPxutTXt7XNlMPW23QEDJYHZIx1LG/Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAj7O+2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8ADC2BBFC;
	Tue, 30 Apr 2024 17:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714497549;
	bh=Hl84TvAqxxlDZYztV1+LhdywsTGPVKAUCUmWwRA6F10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SAj7O+2D9ywIR68QNsYaRjlNlrzaCUFA+aTd+0d9tAjPE6fh4ODW6b2DcsKfSvxxP
	 DfxfEi0ZsZo8/zo6Cr1ygLSEd0o5vmYCVlAs7KGtpeiKVN659sZ/vIEa6ZMbj3W74c
	 cqUftGTIK6C/Ux+JtLGbfhqwL+/LIH8xqNHtwfJFglDj02PNVbH0oKK1kHo/XU4ULJ
	 SKuJYcswvJ6v+Mv6P7WBkZtJRWbz/igy197MA0GePQr/Ld03OwsGK9/B6/T/AjWUeo
	 5U15BvuGhWd6/MR+wnGeMBF+WUb3Dd726nHoatUQGdll4kpNpFya3My2ZEPYdYDRKb
	 vqfMB6xBNpJFQ==
Date: Tue, 30 Apr 2024 18:19:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	alexandru.tachici@analog.com, lars@metafoo.de, jic23@kernel.org,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
	andy@kernel.org, nuno.sa@analog.com, marcelo.schmitt@analog.com,
	bigunclemax@gmail.com, dlechner@baylibre.com, okan.sahin@analog.com,
	fr0st61te@gmail.com, alisa.roman@analog.com,
	marcus.folkesson@gmail.com, schnelle@linux.ibm.com,
	liambeguin@gmail.com
Subject: Re: [PATCH v7 0/6] iio: adc: ad7192: Add AD7194 support
Message-ID: <20240430-shower-unsuited-84ebb854173a@spud>
References: <20240430162946.589423-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5vRzUlLC0qr34dqn"
Content-Disposition: inline
In-Reply-To: <20240430162946.589423-1-alisa.roman@analog.com>


--5vRzUlLC0qr34dqn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 07:29:40PM +0300, Alisa-Dariana Roman wrote:
> Dear maintainers,
>=20
> Thank you all for the feedback!
>=20
> I am submitting the upgraded series of patches for the ad7192 driver.
>=20
> Please consider applying in order.
>=20

Delivery has failed to these recipients or groups:

alexandru.tachici@analog.com
The email address you entered couldn't be found. Please check the recipient=
's email address and try to resend the message. If the problem continues, p=
lease contact your email admin.

rg alexandru.tachici@analog.com
MAINTAINERS
1199:M:	Alexandru Tachici <alexandru.tachici@analog.com>

drivers/hwmon/pmbus/adm1266.c
509:MODULE_AUTHOR("Alexandru Tachici <alexandru.tachici@analog.com>");

drivers/hwmon/ltc2992.c
941:MODULE_AUTHOR("Alexandru Tachici <alexandru.tachici@analog.com>");

Documentation/hwmon/adm1266.rst
11:Author: Alexandru Tachici <alexandru.tachici@analog.com>

Documentation/hwmon/ltc2992.rst
11:Author: Alexandru Tachici <alexandru.tachici@analog.com>

drivers/net/ethernet/adi/adin1110.c
1736:MODULE_AUTHOR("Alexandru Tachici <alexandru.tachici@analog.com>");

Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
10:  - Alexandru Tachici <alexandru.tachici@analog.com>

Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
11:  - Alexandru Tachici <alexandru.tachici@analog.com>

Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
10:  - Alexandru Tachici <alexandru.tachici@analog.com>

Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
11:  - Alexandru Tachici <alexandru.tachici@analog.com>

Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
10:  - Alexandru Tachici <alexandru.tachici@analog.com>

Documentation/devicetree/bindings/net/adi,adin.yaml
10:  - Alexandru Tachici <alexandru.tachici@analog.com>

Documentation/devicetree/bindings/net/adi,adin1110.yaml
10:  - Alexandru Tachici <alexandru.tachici@analog.com>

You may wanna consider finding someone else in your company to maintain
these devices.

Thanks,
Conor.

--5vRzUlLC0qr34dqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjEoBgAKCRB4tDGHoIJi
0rb6AP9i0g5NCNhucxDKvvBoqwLgltRhyGb3UvhfV++GdaFp1AEA3R+ROczA4X3i
NrR2k5c0nkkdiyByolcZhCKz2CpmNg4=
=5KqF
-----END PGP SIGNATURE-----

--5vRzUlLC0qr34dqn--

