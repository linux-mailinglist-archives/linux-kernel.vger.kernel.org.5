Return-Path: <linux-kernel+bounces-51915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 826DE8490AC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 22:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DEF282B99
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1BB33985;
	Sun,  4 Feb 2024 21:30:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07392C86E
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 21:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707082200; cv=none; b=qaLrbYFugBgcvAuZS3bmJcyDeNnsBAzaYUhK5b3wFKfaWRgIbRzKazqHG8YhWUNnuVMRHbB1Xmo2sURK56LQ1n1QAU5/QuKDLRC8w0jw13Om0NePewYs+x+O9VQJHuPKQTEbOsxm29fgsIbm2NCgzW1Xkp9GkUm48grPHbEq1dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707082200; c=relaxed/simple;
	bh=gWNgzaqzune7TGLgUbGGYous35DnLM8EJ4ZMDBYEuJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3RW/ZYA3Y+XvQu6we5UizKSoMUwCzQnULSwRhW6DUf9OgpoFTGqaQURq0tIVZj4qcLZhcdTaYmb+A6A7vqlhwHaU1k1MkEPVE+QlFy5KcXkoiMFlbTXYK6x4Ww8n74qA934UnZD3PPAkbtqkgV8uEbuKNSz0rkCCGGRB6tBP8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rWk3k-0001FB-Vg; Sun, 04 Feb 2024 22:29:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rWk3j-004Ve7-Ti; Sun, 04 Feb 2024 22:29:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rWk3j-00F29F-2i;
	Sun, 04 Feb 2024 22:29:51 +0100
Date: Sun, 4 Feb 2024 22:29:51 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Thorsten Scherer <t.scherer@eckelmann.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] siox: make siox_bus_type const
Message-ID: <oixce2fflwe6rodxsv625ogbymqlblw7qvvbxmtp7tpgarqpju@ufnqi7j364md>
References: <20240204-bus_cleanup-siox-v1-1-2d12583d3a6c@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4q3fuj3ylhholgv6"
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-siox-v1-1-2d12583d3a6c@marliere.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--4q3fuj3ylhholgv6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ricardo,

On Sun, Feb 04, 2024 at 05:36:03PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the siox_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
>=20
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/siox/siox-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
> index 561408583b2b..a1eda7bd76ed 100644
> --- a/drivers/siox/siox-core.c
> +++ b/drivers/siox/siox-core.c
> @@ -543,7 +543,7 @@ static void siox_shutdown(struct device *dev)
>  		sdriver->shutdown(sdevice);
>  }
> =20
> -static struct bus_type siox_bus_type =3D {
> +static const struct bus_type siox_bus_type =3D {
>  	.name =3D "siox",
>  	.match =3D siox_match,
>  	.probe =3D siox_probe,

while I like this change, I wonder about the "Now" in the commit log.
Doing the homework, this is about commit d492cc2573a0 ("driver core:
device.h: make struct bus_type a const *") which is in 6.4-rc1. Would
you please care to mention that commit as the one that makes this siox
change possible?

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4q3fuj3ylhholgv6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXAAc4ACgkQj4D7WH0S
/k4s9Af/QB+rLnHB02hNPhuBJli4ziKQC5YsDnKvHelaGTNXS/OT1Z6uP2deeQWT
8N6D1yWZvoLNjLzEdRmb+/aeNhB57stbASDom/+w/i5CV8pQNua8zRVOBixBFPiH
be5KQtdhtPbd7ga29mVjz9H2C2snppLKwHp75Gep3Ulb8xvtBGJE9lmQXRVc5d4f
T5ZkrfhPFa11tDlmKvMAQmPRUymTcCmoGg5gWRkYIa46sqHn2zCc+y34I7KO6M8S
VdGUQ9mjChb/e6IwV93op267Bv4dueFHas0sHh+NP9CUgnYb0P4EmyqJu9n+dhf/
t/qP2QokB3r7B5ueU5g5acYPa5ZLMg==
=YAp6
-----END PGP SIGNATURE-----

--4q3fuj3ylhholgv6--

