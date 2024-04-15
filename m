Return-Path: <linux-kernel+bounces-145374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CA58A54D7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2101F22D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481F08289C;
	Mon, 15 Apr 2024 14:37:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1861D757E4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191868; cv=none; b=ax/OW8FlORcmR/vJBs3DvOXbpswoRCs9a+uZwxsjK8R1lyRWbl8UdjS/jBCRnQhJ53zCzuSUrodTzv7R5oPrrcO4uaGdPi8fnBCEMcFyQLlFnQnIlmgsNktFY6holDUio5MRLKKI0xS+6gkiwZlFXgrygHwip9HzJVAPoZtT0dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191868; c=relaxed/simple;
	bh=hjfxd08kphO2ZnaWF+LecvTEE4++FOQ1HP7Po6y7ebA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8uBJ8uF1doPptx+UKGU1D0iGLGwRJt64AaPjAbRUR/hJuzP0tG6ZHjmAyuuMsXmEZbOA3IQ9/2jPIZ48nPEKMMaqMQqTRrADgVeO0PSYHtPeUrM7PJHyB9ZaY4g57Ie8rtmnYDmr4kXVTOgEZExlPi8fWyZQjy4rMNv88AQVxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwNSq-0001in-RF; Mon, 15 Apr 2024 16:37:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwNSq-00CRSb-Ek; Mon, 15 Apr 2024 16:37:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwNSq-001gGo-1D;
	Mon, 15 Apr 2024 16:37:44 +0200
Date: Mon, 15 Apr 2024 16:37:44 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] parport: amiga: Mark driver struct with __refdata to
 prevent section mismatch
Message-ID: <zoyfbhbrjyefxooa4nvvg6563r5pjdjo6odgg4wqwbumnhjw6z@nobzlb454jiw>
References: <2e3783106bf6bd9a7bdeb12b706378fb16316471.1711748999.git.u.kleine-koenig@pengutronix.de>
 <49ab91032bf9b57cd5fb6d306c38884d059dce2f.1711748999.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x73g7td6xugmykyl"
Content-Disposition: inline
In-Reply-To: <49ab91032bf9b57cd5fb6d306c38884d059dce2f.1711748999.git.u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--x73g7td6xugmykyl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Mar 29, 2024 at 10:54:39PM +0100, Uwe Kleine-K=F6nig wrote:
> As described in the added code comment, a reference to .exit.text is ok
> for drivers registered via module_platform_driver_probe(). Make this
> explicit to prevent the following section mismatch warning
>=20
> 	WARNING: modpost: drivers/parport/parport_amiga: section mismatch in ref=
erence: amiga_parallel_driver+0x8 (section: .data) -> amiga_parallel_remove=
 (section: .exit.text)
>=20
> that triggers on an allmodconfig W=3D1 build.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I'd like to enable these warnings even for W=3D0 builds, so it would be
great to get it into the main line soon.

If you apply it, please notice that I fat-fingered the parameters to git
send-email and it was sent in a thread. So (assuming you're using b4)
you'd need:

        b4 am -P _ -v1 49ab91032bf9b57cd5fb6d306c38884d059dce2f.1711748999.=
git.u.kleine-koenig@pengutronix.de

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--x73g7td6xugmykyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYdO7cACgkQj4D7WH0S
/k467gf+NsLgkmiS5hL0PctMTidg2yX1F8QYX68gUe/srFG0DQdWvbGjfrZbp4XU
IFjVcI6rzgJPNLNwkcnl5UD6Zy7ooPifvu3sGvvKbRhZtgUyCfOWPcx6N6DfC5fr
qdrtIl7ExysT3XahWol5st/4Hql9e664lLKK0dWv2HByabN6ZZ09eN2WvFgCXg2y
qL1x5NBvbhyPEc0v5DvwAmpD2ncea3aMXmSDixb/ElUcRM5e8QBDxussCUimiYb4
ZGiHE9b0oiOGesoOd3pp2DD7PJ6hNmdYZz6FrNleglsyYgazM0Urf15OqMY5wWbb
gtBKd2yte2Apk5YKovwnreeKp40X4A==
=hdUN
-----END PGP SIGNATURE-----

--x73g7td6xugmykyl--

