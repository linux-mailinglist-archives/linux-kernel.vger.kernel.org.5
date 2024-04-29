Return-Path: <linux-kernel+bounces-163018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ED38B63A6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E8B284198
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE57C15B56D;
	Mon, 29 Apr 2024 20:30:51 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025A315B572
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422651; cv=none; b=rejHv9abrUqGmhoToZlVK4qY/DMg+sc9/kV4BukREXxSiSh11ZjB2q0PbEPl4HIdEOqRiuVcKCtJlqKgqFtDLQHbXk+5WHQptcLTJakzPiuVJgN3BtQgB9q4jAr1iLomHCg13a16LLaOHqpRk0fZ0lYEDQSCeGuGRTe7G8kAcC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422651; c=relaxed/simple;
	bh=pBhVrD24rhjqUw6MC3m/vF5Vnl9vshYrCWZYtDq6rWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bok23laTNy+O27PdmcZR3MG1lSQlWvLZ4U1arJXk3f5CaWWZ4aWwGWvL5iYU4VegNVsAyWuu0cv7xjNBXeXtA61uY2ZxKSw0n/G+bP6rXrtz4p244ruUKq4vhioKRnu5VSUdESQ7zGU9O32/UDUDauzTBU+YgyIRYfgSAb6/ROs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1XeC-0001t4-6i; Mon, 29 Apr 2024 22:30:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1XeB-00F2hq-Jj; Mon, 29 Apr 2024 22:30:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1XeB-00BjCv-1i;
	Mon, 29 Apr 2024 22:30:47 +0200
Date: Mon, 29 Apr 2024 22:30:47 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] parport: amiga: Mark driver struct with __refdata to
 prevent section mismatch
Message-ID: <wgsua47zswruupzxsmi5dr42oyhxqygbuh4de63k2lbqejevx4@e4adtgy4syif>
References: <2e3783106bf6bd9a7bdeb12b706378fb16316471.1711748999.git.u.kleine-koenig@pengutronix.de>
 <49ab91032bf9b57cd5fb6d306c38884d059dce2f.1711748999.git.u.kleine-koenig@pengutronix.de>
 <zoyfbhbrjyefxooa4nvvg6563r5pjdjo6odgg4wqwbumnhjw6z@nobzlb454jiw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b52gwbzzlhss6bj4"
Content-Disposition: inline
In-Reply-To: <zoyfbhbrjyefxooa4nvvg6563r5pjdjo6odgg4wqwbumnhjw6z@nobzlb454jiw>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--b52gwbzzlhss6bj4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Apr 15, 2024 at 04:37:44PM +0200, Uwe Kleine-K=F6nig wrote:
> On Fri, Mar 29, 2024 at 10:54:39PM +0100, Uwe Kleine-K=F6nig wrote:
> > As described in the added code comment, a reference to .exit.text is ok
> > for drivers registered via module_platform_driver_probe(). Make this
> > explicit to prevent the following section mismatch warning
> >=20
> > 	WARNING: modpost: drivers/parport/parport_amiga: section mismatch in r=
eference: amiga_parallel_driver+0x8 (section: .data) -> amiga_parallel_remo=
ve (section: .exit.text)
> >=20
> > that triggers on an allmodconfig W=3D1 build.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> I'd like to enable these warnings even for W=3D0 builds, so it would be
> great to get it into the main line soon.
>=20
> If you apply it, please notice that I fat-fingered the parameters to git
> send-email and it was sent in a thread. So (assuming you're using b4)
> you'd need:
>=20
>         b4 am -P _ -v1 49ab91032bf9b57cd5fb6d306c38884d059dce2f.171174899=
9.git.u.kleine-koenig@pengutronix.de

Gentle ping!? It would be great to get this patch in during the
upcoming merge window.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--b52gwbzzlhss6bj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYwA3YACgkQj4D7WH0S
/k5pQggAuUhMdZby1efDy4qLEUMK5QAKYv7ihaz58M7snwC5aD7Vdrru9jCiVivX
Zl0aESQnHD1P/BZqkIK6U8kzCRlzQXhvXt+l0gQrknvuTHnVnjwpao6VrMiZSUuZ
1HMVVY/XGj0GvcjzU4DNWm/g2q+GRIzkh+Xwra89Tvc/1t0lw6nHXb9I03ZCHQKa
fTSznBcxRp1zz3tezSul4xm3eF7/ivCUS+xF1oFw7KjJC4qzo7Tzadma6lHVzkmd
UDIu7k+lC2K3QvVRjTMuSDS3PfAs34a4q1/aEHXvFFWXhaabEttwM5P/tWFbN4gT
EFXmtQGxMatwg0PuEaOVypBC+jWu5A==
=ef66
-----END PGP SIGNATURE-----

--b52gwbzzlhss6bj4--

