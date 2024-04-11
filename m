Return-Path: <linux-kernel+bounces-139958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A638A0999
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC34928193F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98E113DDC6;
	Thu, 11 Apr 2024 07:23:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2786F13E3EF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820202; cv=none; b=LekqMtXvk+qZ8wZRhe0tveAK32VhhP2O32umEngn27dvJaG1ND64Fyz2mA6gLNTu0a33Efw7ymTEYvHo6q+/+kqNglvRKkEf7XzYgrKSxUKAxdsmMPUxf43myiNUj6VttLkKXzjQjkRYj8akl0d9ao76fS++37z6niLS0U+T9NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820202; c=relaxed/simple;
	bh=Wt5if24Q2AzAFpiuYKmYw8tBn3IIAi/AUUMuWz8n4A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wo/jNaPlUJsiTQ7etD1r3VJ5oFHnCdDAsosi3nGXsPKP4k8GB8wxhXk+H31AxZHI6rWgHRxRHXT15VV8g5e1Ez/u+cV+sS6PViCMI7CBZRx4r4EiZuhqAKS55+DnZj8up8wbm1enISirILacJBurfw2F5oKsLFCZwIXDmWWOYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruomD-0001jJ-TE; Thu, 11 Apr 2024 09:23:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruomD-00Bdst-GI; Thu, 11 Apr 2024 09:23:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruomD-000Pf9-1K;
	Thu, 11 Apr 2024 09:23:17 +0200
Date: Thu, 11 Apr 2024 09:23:17 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Johannes Thumshirn <morbidrsa@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mcb: lpc: Convert to platform remove callback returning
 void
Message-ID: <pxr2p4vvn4fr2n7f3eda2geqh5zabmresgj3gfqrls7dag7f2n@abfxhyxszjgc>
References: <20240307175903.189283-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wq7vd63prnpqrjal"
Content-Disposition: inline
In-Reply-To: <20240307175903.189283-2-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--wq7vd63prnpqrjal
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Mar 07, 2024 at 06:59:03PM +0100, Uwe Kleine-K=F6nig wrote:
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

I didn't get any feedback in reply to this patch. My quest to change the
prototype of struct platform_driver::remove depends on that one, so it
would be great if it could make it into the mainline during the next
merge window.

I added Greg to Cc: who's tree the last changes to this driver went in
through. If I don't get feedback until v6.9, I'd ask him to take this
patch without further maintainer feedback.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wq7vd63prnpqrjal
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYXj+QACgkQj4D7WH0S
/k4TEAgAqZjPh6n78yTVmTKep+OdZns+WPVdXyg64mfhi5xyiPnq9UR60jCpd0KL
mLz+w7I4UEWKcEzapFmVtIAM65GMCph2NTsemU7tYP4E4dzFSZi1CkncxSBeLCnv
z9KwcnPN5v05c304rHpvQU/UY1cIBQmoNIZvz621P67pJTpusqUnjJo8p7vxsKLL
kKxsaXBfuxHLQtdT7lWAoDnfdsoFlWswLQkagr8VL/Xq+hA5728ylggHkBBYG0VI
7kruUnBBf+CQZ6BH0sUWmDHufqV7mMwNqHLpynGyrJs7V+7a3H/tgx4ZhWdrz4I7
hHyw0X5CZ+JWxwneD4Z0A5oBjyRTlA==
=PYdu
-----END PGP SIGNATURE-----

--wq7vd63prnpqrjal--

