Return-Path: <linux-kernel+bounces-144690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95188A493F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C4A0B25A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B56374F5;
	Mon, 15 Apr 2024 07:41:57 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F60374C4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713166917; cv=none; b=pcBloSV2JRUAs5wCjedYVJSZxrVGBtfhefnDS5yqBc70xsh7ZFLKoXam/7OlkDni17NzjTIsNy+n3Dl93EGHAcwhrWgbFhsPgij9bDNWCBkWW0/kfHCPraCsYcQFNR6HySGdpvR3cRaSKC+r2/9CJS2bW5Wg5UNWb/BXsel+8Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713166917; c=relaxed/simple;
	bh=SsSiodcH/hkzQJOSbPGU6e4kOgrztHohBQiyWyMxvRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fe2Dg9VM2VNwzru0Y0Mp8GOX9EpoF4D3g7k7F6GlGMnl2qrBZOYXs8i2xXXRTVG1eMu2/+7yTml2wNCRY/KBelH/Nwz2QDcXtOtI4ChghoCJvUeK1HitN4pkRAYs2FThrypVIph18sum/xb7b0nofKrerxUWPjbhjaFWv0niNrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwGyP-0002fT-2w; Mon, 15 Apr 2024 09:41:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwGyO-00CNli-Lw; Mon, 15 Apr 2024 09:41:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwGyO-001Qpi-1v;
	Mon, 15 Apr 2024 09:41:52 +0200
Date: Mon, 15 Apr 2024 09:41:52 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 0/2] uio: Convert to platform remove callback returning
 void
Message-ID: <svxqalqrcc3iskr34osrx5g6itbbypcsojbzmvknv53gr56yzc@ucalmaxjoi5b>
References: <cover.1709933231.git.u.kleine-koenig@pengutronix.de>
 <g4bpnb64ylia6rlhqbjm5xctuy3uu6wnfu5sxuqkrze24y72od@e3tpnrwwl75t>
 <2024041517-helper-suitable-0e42@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6rheskpp2l3vatfp"
Content-Disposition: inline
In-Reply-To: <2024041517-helper-suitable-0e42@gregkh>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--6rheskpp2l3vatfp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

On Mon, Apr 15, 2024 at 09:31:35AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 15, 2024 at 09:19:00AM +0200, Uwe Kleine-K=F6nig wrote:
> > > Uwe Kleine-K=F6nig (2):
> > >   uio: fsl_elbc_gpcm: Convert to platform remove callback returning v=
oid
> > >   uio: pruss: Convert to platform remove callback returning void
> >=20
> > The commit 1019fa4839c9 ("uio: pruss: Remove this driver") (currently in
> > next) makes the pruss patch obsolete. The fsl_elbc_gpcm patch was
> > applied.
>=20
> Yes, that's why I only applied one, sorry if I didn't let you know.

Everything's fine on my end. Given I monitor next now with the goal to
change struct platform_driver::remove after the upcoming merge window, I
noticed myself. My message was only informational, no blame intended.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6rheskpp2l3vatfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYc2j8ACgkQj4D7WH0S
/k7DKgf/YRqtlVamYYFNQ2ED7EJ/JLkWMMjyGE8q3fYiU/k5DJP27O9yB4LhoUEZ
kQMfLYw/efMWK6hmDWvuR9NiBFxXqWFGOZYucx47+4AMDeiUXj3yn8ul2CGSVEae
00dq2fnuUrWRmmPaFPkQri/BxnNK/463mhEpe53Eg83UsPyF4DElx9tgB4HAkMaI
GnBhY7RdpUENChXa+QedqgzjW3mf2gNKmSyLXbKmSC/9ctKzKCQZFQthCgMEuBVq
kt29/AjZK3K6rZAe2rBKqUuUZFJxZTFRedSIKGr2BjUE/K9PXtfnMnIOqN2hWKfW
0n9+PqAkGHq0I2L62MS47hcf7Pfz4g==
=urgc
-----END PGP SIGNATURE-----

--6rheskpp2l3vatfp--

