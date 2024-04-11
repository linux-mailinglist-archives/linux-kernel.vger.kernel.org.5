Return-Path: <linux-kernel+bounces-139929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C758A0938
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086C61F21B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02B114389A;
	Thu, 11 Apr 2024 07:07:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB8A142633
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819228; cv=none; b=UmUd1ucA7OUPFzwm5ys6XB0oIkAWjw1YnlaXtQlJ2W7iYTv5n/8GEfZ5JQjxaz5vtfoW7WdNMqSbqOnMFMSbKRZj8zDd9iPmxog3OBYWjn8iiWfKyNcruMmLfrThfOdI8F3cODJG5Kv2ORIVF+YsrLpylyl7ggp891tTNRHVyWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819228; c=relaxed/simple;
	bh=z102dTd1Nsgv3jalN8kJhAvPFw+vCjjDKRui0D+eUEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXxBYevUcntVS/S278VS97qz+r+DzMNV+CFYsH52r4gSexqLr2GQL0bDmtJVhn0B/yxU/sJDCa6fgaozOGqFtEOc0nzkTQrVR5cA89mho7d+pSKxdKMEMKHqkGdkMM0cjGPg2L+lF0w++9+3/RHhS7Q2Wmhh2MgcMU6RRhthxq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruoWV-0005Mr-SR; Thu, 11 Apr 2024 09:07:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruoWV-00BdY4-50; Thu, 11 Apr 2024 09:07:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruoWV-000OX6-0E;
	Thu, 11 Apr 2024 09:07:03 +0200
Date: Thu, 11 Apr 2024 09:07:02 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 7/8] intel_th: Convert to platform remove callback
 returning void
Message-ID: <rnybbv5sddkgtnxzad7sg2jyosr77vvud6t7ii3sssfsi7td2u@3b5nbhsprcaf>
References: <20231107202818.4005791-1-u.kleine-koenig@pengutronix.de>
 <20231107202818.4005791-8-u.kleine-koenig@pengutronix.de>
 <i3oybmf3axeyk5rcef5kgfdb4cucd63h24gup6idn62nq3vvav@4mfzwzyamq27>
 <jawceotzgdydpz74qr2e5dwgfumwjmt4wxvi43qlwldlbgemzf@v3qa2hoopawv>
 <qiiln66o6uy2nsqdjcykygp3yumonn7jqp7q4wxf56i6pazics@iqfaiglmsgwt>
 <87edd5y7lz.fsf@ubik.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yl2xwhqpkfytrksb"
Content-Disposition: inline
In-Reply-To: <87edd5y7lz.fsf@ubik.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--yl2xwhqpkfytrksb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Alex,

On Wed, Feb 21, 2024 at 08:50:32PM +0200, Alexander Shishkin wrote:
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> writes:
> > On Thu, Feb 15, 2024 at 10:16:41PM +0100, Uwe Kleine-K=F6nig wrote:
> >> On Wed, Jan 10, 2024 at 09:41:54AM +0100, Uwe Kleine-K=F6nig wrote:
> >> > On Tue, Nov 07, 2023 at 09:28:26PM +0100, Uwe Kleine-K=F6nig wrote:
> >> > > The .remove() callback for a platform driver returns an int which =
makes
> >> > > many driver authors wrongly assume it's possible to do error handl=
ing by
> >> > > returning an error code. However the value returned is ignored (ap=
art
> >> > > from emitting a warning) and this typically results in resource le=
aks.
> >> > >=20
> >> > > To improve here there is a quest to make the remove callback return
> >> > > void. In the first step of this quest all drivers are converted to
> >> > > .remove_new(), which already returns void. Eventually after all dr=
ivers
> >> > > are converted, .remove_new() will be renamed to .remove().
> >> > >=20
> >> > > Trivially convert this driver from always returning zero in the re=
move
> >> > > callback to the void returning variant.
> >> > >=20
> >> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >> >=20
> >> > I didn't get any feedback to this patch and it didn't make it into n=
ext
> >> > up to now.
> >> >=20
> >> > Is this still on someone's radar?
> >>=20
> >> Is there a chance to get this patch into v6.9-rc1? Are you the right o=
ne
> >> to talk to about this patch? (According to MAINTAINERS you are.)
> >>=20
> >> The patch was sent during the 6.7 merge window and now already missed
> >> the 6.8 one :-\
> >
> > I failed in several attempts to get feedback on this patch. You applied
> > the last two patches for this driver (that is all patches since the
> > driver was born). Would you care for that one, too? Tell me if you want
> > a resend. Note that the other 7 patches from this series are already
> > cared for, so if you're using b4 am or shazam, make use of -P7.
>=20
> Apologies. This looks good to me, I will pick it up for my next
> submission to Greg unless somebody objects.

Given there are not that many patches left (~50) as of today's next, I'd
like to see this patch going in during the next merge window, that I can
finalize the (next step of the) quest around platform_driver::remove.

Is sending this patch to Greg still on your todo list?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yl2xwhqpkfytrksb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYXjBYACgkQj4D7WH0S
/k5fEAf+Nq54JrvztGVvk0m0iweAHUrUGtKa/QdaIu1S6HXWyc8KHWLfOPVpGSm/
VPRbXnkPNHB24gmJ4/kamiVXJ8ookD6+Z7Co6R5v/siXNy6lYvnR1q6UpkB7ONib
Oxhj5GgBBJSMnKcpZujnQyHJnt5iyAOAogyCeAjz6syL2CPGfKu3TAflAXTJqgyI
t0SMSFzzoID/lnC3mPSUn0pVvU0477JmvPSJBZLC1r3Y5IqdTdA1mYEkXqZwLSDF
PiRmmof2nTlciKRkm3fvrphGvCi3Fm2xlibmNBJ1OoT8BRtzvfHn8zcwZV1VC1nn
1gIYEMb27GE1QUSBlR/A8X+W4QxMSQ==
=dCQr
-----END PGP SIGNATURE-----

--yl2xwhqpkfytrksb--

