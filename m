Return-Path: <linux-kernel+bounces-54603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD35184B16C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71797B23E82
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10F512D163;
	Tue,  6 Feb 2024 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpvYxnNe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF4212D144;
	Tue,  6 Feb 2024 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212224; cv=none; b=hzNJ97UM5sjC0VWPlNxWyo/kYwmMS+ykXMJ1wDkqotwwmAKtvBCflK2NE3ILnnDRb6XrghoEPZ2tKNWcEqf8HKYx8ckEc8IC2WQIYO0LRma8hJ9F2adfjE9I3g8ZThzybTkLSQLxJ2NdbnSW17OF3hdniuiviZNRgQ/CyK4TedQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212224; c=relaxed/simple;
	bh=n9wbGFyXLlnEtppmjA5N2JmZBb/52gXSfzdrpFBWtNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVgH2oeFkMQIyDtdls0GjDDQ8Am9N9jPBvrdINjVLlJVK/Xg6E9/Sx2lvm428G6ctQQQz5wK+Xa4V+v9dWVKFJYEVbgOJKZu7yO7vX070BbTqK7e0t6JOfbSRhNRIaDPqsp567Wp9WXN7V6XdA4buIo1L6i479ZAJDRzk+3x52c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpvYxnNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3944C433C7;
	Tue,  6 Feb 2024 09:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707212223;
	bh=n9wbGFyXLlnEtppmjA5N2JmZBb/52gXSfzdrpFBWtNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rpvYxnNenRQTKnAAg1z44tyrCb5MgQHOaJeG5M9mcHamGe+dRq7KY2M/efg0LQ12T
	 e1JfrjtJbiBRui7HTwF8GhSd55jUM+CAvNavFNqQ8y+I6DyIrmmyF6mUhhWSG7xrsz
	 mr52SI0dTYphvk7+XAnv+K1Qfcm+nKiepa4G9vaeyMJtO3OomiE/EK5+XiTGfVpZOK
	 8/AFjeLLXdwwQ4btwd+a9p9cSL05EIb+qem4/+HeVHCxcaUsgmNo6WGv2pVYhAVM54
	 gYwRW4SGfhohpGWw/bT6yWg4so1EPOQtROZupW3BX44TOkOMDs/Z0t5Ra4+YJG0wu4
	 P+g5g91xxopWQ==
Date: Tue, 6 Feb 2024 09:36:59 +0000
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?B?UGF3ZcWC?= Owoc <frut3k7@gmail.com>
Cc: Robert Marko <robimarko@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: spidev: Add Qualcomm spidev device compatible
Message-ID: <ZcH9u7Vo2sFERIHJ@finisterre.sirena.org.uk>
References: <20240205191808.998754-1-frut3k7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C+ZbumJ7nzlgQ4kY"
Content-Disposition: inline
In-Reply-To: <20240205191808.998754-1-frut3k7@gmail.com>
X-Cookie: You might have mail.


--C+ZbumJ7nzlgQ4kY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 08:18:05PM +0100, Pawe=C5=82 Owoc wrote:
> Add compatible string for Qualcomm spidev device (used for QCA4024).

> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -710,6 +710,7 @@ static const struct spi_device_id spidev_spi_ids[] =
=3D {
>  	{ .name =3D "spi-authenta" },
>  	{ .name =3D "em3581" },
>  	{ .name =3D "si3210" },
> +	{ .name =3D "spidev" },
>  	{},

Why?

>  	{ .compatible =3D "lwn,bk4", .data =3D &spidev_of_check },
>  	{ .compatible =3D "menlo,m53cpld", .data =3D &spidev_of_check },
>  	{ .compatible =3D "micron,spi-authenta", .data =3D &spidev_of_check },
> +	{ .compatible =3D "qca,spidev", .data =3D &spidev_of_check },

No, this needs to correspond to the hardware being controlled via spidev
not to an implementation detail.  Any new compatibles also need to be
documented.

I'm also missing patch 2 of this series so don't know what's going on
there.

--C+ZbumJ7nzlgQ4kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXB/boACgkQJNaLcl1U
h9COOAf/Ys678Eo64BOror1BapTdw7+/zdCdwtU3Sg+PwIuUnOJ/39HpJ+BWTFy5
gu0eRpQqBQalAPN3R8KnRTpVV7518MKBRvHzGBoSoRxrml1S/ZWAoE/AqmRYHAz5
9BZjRlIQ+Kae/f3KFR8SprmNAK/KbSVKDEVc3hnadyYWQg3qK9zPOVesP90SRPh7
4Cn7oCjhW1JjFHkA7jdYyMYwztjUvbyCyhoiDyDCmOeiMPpGZejG8qdfB8Emvt12
xzQ7yIp8e0pIzYXPzq0T2oMFfi/TDJsmSuvFPKAJe4Cuc4eUZfiKca9R6sQYX77K
JC/eTWRmm3964LTympefNrcOfd8ntg==
=sxPE
-----END PGP SIGNATURE-----

--C+ZbumJ7nzlgQ4kY--

