Return-Path: <linux-kernel+bounces-143671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3C98A3C2C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 12:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0141C20C01
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1E138FA3;
	Sat, 13 Apr 2024 10:13:06 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88491944F
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713003186; cv=none; b=rX2tqJYzJ8k5EKN8X38eS2z1CpRnzi8omUQhmTOrDYCkbNpLqt/XALNXA7L2S1BWFB3iZQ17kBEC3dh9Pb6LGzGc/Nv7d1SgFY09gnCZaD2JZPaIaMWDi1lIhIC0/OF7noTaL75iLr+T4AZwqb5a/kvcqQsc/uXOP56e3v4J+LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713003186; c=relaxed/simple;
	bh=z83jMz1ZVsAZkRW5PBfAK0WbIrqpcvbkOgy0dvBggvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6liaDKz4TIF7yKSRRd33rPY5L+pIgEh9cy6kNV6uJagVBFDvSkOxygk+iPcLhak1ABsk5nVQdw6dgobM4tfErglamkYQ0g3GxdGCgxr0zd6RoLaoxpu70SXsHRWDeLsujfSuGQStBpffm5Ix7Rpmoq+2UEr0Ule5T2KP2YSIIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvaNY-0006XS-N8; Sat, 13 Apr 2024 12:13:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvaNX-00C2qC-PY; Sat, 13 Apr 2024 12:12:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvaNX-000ijd-2H;
	Sat, 13 Apr 2024 12:12:59 +0200
Date: Sat, 13 Apr 2024 12:12:56 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, Puneet Gupta <puneet.gupta@amd.com>, 
	Nipun Gupta <nipun.gupta@amd.com>, linux-kernel@vger.kernel.org, 
	Abhijit Gangurde <abhijit.gangurde@amd.com>, kernel@pengutronix.de, 
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: Re: [PATCH] cdx: Convert to platform remove callback returning void
Message-ID: <wyt4jvdvbq4wrgxslwkdeg3e6mhjtfue4xwdec7sil3whhromv@57xjgduvont7>
References: <5d40f57e978bcce003133306712ec96439e93595.1709886922.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s3i7kmvt6klw55wa"
Content-Disposition: inline
In-Reply-To: <5d40f57e978bcce003133306712ec96439e93595.1709886922.git.u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--s3i7kmvt6klw55wa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

On Fri, Mar 08, 2024 at 09:51:05AM +0100, Uwe Kleine-K=F6nig wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>=20
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

we just talked in irc about this thread that might have fell through the
cracks on your side.

Thanks for reconsidering to apply it for v6.10-rc1,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--s3i7kmvt6klw55wa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYaWqcACgkQj4D7WH0S
/k42XAf+L94X/O0zykfTHe+CVju3dQcPIDr2btWJmpUSedAQdec4cmTn1IL2O4PU
UKS1sgvdO1Qid0qVJHrsEcZrFzeVOAxU9PEkKNl0G35iF3Ku3M8Rz1NJoSQrWjU7
J0m+4rbd8ZbWRcMMr4q+EOXa09QB508899blAXP+zV729MKnskvjhfWkuIlfPMFK
eayd3cv6MF1LGnq0/XgoB99enlGH9DJeucdSC8F+zVMxRHkU/ni1UJNVSMWmxZ4x
3ri8rjDAsd9cKn7De4AOdkjoTcLuTyP3Q06D6e5eFzyeuO5JMNGd1LUhC5i2r/bD
S1wLHuY50mgFlhRzEBZciME1rX6HLg==
=tSsa
-----END PGP SIGNATURE-----

--s3i7kmvt6klw55wa--

