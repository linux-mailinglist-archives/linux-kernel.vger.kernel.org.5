Return-Path: <linux-kernel+bounces-67688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63829856F28
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44BF1F25033
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E087E13B79B;
	Thu, 15 Feb 2024 21:16:46 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4A041C61
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708031806; cv=none; b=fADgjFPWXFSF+xswuj6m7LrYWZbB8GxG0McGRvpSrRocYrlAuOyVvnSzbpxxy287txOJ9G6x11VtLvdV8QgYZopiSp0mxS7dUyeOJMgScqDVqdIk+oVvge8B6t/wYgHjJ/dc0Z9bL5lkjiZHbP9IVK+LUDNL04I7ktZB8OXdlUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708031806; c=relaxed/simple;
	bh=pMD7ChFxXNzBIMximFwf1FhXvVBfQq11HJk6LIY7pBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H62FGTC/BBRvC7kstRM7EqJf3bfkekz1IsS7yei0fHEbQZzxKuqBSyhgiBqhG96rdWaGQJ+DOmGK+5jRCN8mlhX3dQuav6e0zaOt+EchOtDWRsumrKDTLfWvhzW7lJe6wY+moP4Ub28koaC8tWi0/ByQ+qwl2DkkXx8G5R+7nvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raj62-0001Kv-PX; Thu, 15 Feb 2024 22:16:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raj61-000xJo-M1; Thu, 15 Feb 2024 22:16:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raj61-005eqJ-1v;
	Thu, 15 Feb 2024 22:16:41 +0100
Date: Thu, 15 Feb 2024 22:16:41 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 7/8] intel_th: Convert to platform remove callback
 returning void
Message-ID: <jawceotzgdydpz74qr2e5dwgfumwjmt4wxvi43qlwldlbgemzf@v3qa2hoopawv>
References: <20231107202818.4005791-1-u.kleine-koenig@pengutronix.de>
 <20231107202818.4005791-8-u.kleine-koenig@pengutronix.de>
 <i3oybmf3axeyk5rcef5kgfdb4cucd63h24gup6idn62nq3vvav@4mfzwzyamq27>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ti4wgnneboywvsvn"
Content-Disposition: inline
In-Reply-To: <i3oybmf3axeyk5rcef5kgfdb4cucd63h24gup6idn62nq3vvav@4mfzwzyamq27>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--ti4wgnneboywvsvn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Alexander,

On Wed, Jan 10, 2024 at 09:41:54AM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Tue, Nov 07, 2023 at 09:28:26PM +0100, Uwe Kleine-K=F6nig wrote:
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling by
> > returning an error code. However the value returned is ignored (apart
> > from emitting a warning) and this typically results in resource leaks.
> >=20
> > To improve here there is a quest to make the remove callback return
> > void. In the first step of this quest all drivers are converted to
> > .remove_new(), which already returns void. Eventually after all drivers
> > are converted, .remove_new() will be renamed to .remove().
> >=20
> > Trivially convert this driver from always returning zero in the remove
> > callback to the void returning variant.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> I didn't get any feedback to this patch and it didn't make it into next
> up to now.
>=20
> Is this still on someone's radar?

Is there a chance to get this patch into v6.9-rc1? Are you the right one
to talk to about this patch? (According to MAINTAINERS you are.)

The patch was sent during the 6.7 merge window and now already missed
the 6.8 one :-\

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ti4wgnneboywvsvn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXOfzgACgkQj4D7WH0S
/k4dqgf/R8CIYnSvUQlNKDMTNeHPb0E4EE0NNapRAWbY/ewfvmDj4T8A1LqA89/k
zeDbO4LUTvRhl3UH/tzTbFOX+JjZVtjZtVUfXgBpkYvHlDHmSIZMKfKhSJI8SxcI
D41vUbH+fOxysM2ti4+YCS0/04TVIXLhjbjaiUgGKzRNJopEvS6Ug5VRRyOotTW9
tkxzBHX3hYBdMNsqkd0w4MxlSoYJNmeruTlLt5u6yEMcgNgU6T3Bv/Ynd4h6yMA/
cqsI5KDxuKivMEWM9A4gI8abitx0DXJefx5qWosmzPENHelNmCkLsaf9ED5OP6G+
9cpmIPoWvtSP4KvSDy8+js5Terns/A==
=Q0iC
-----END PGP SIGNATURE-----

--ti4wgnneboywvsvn--

