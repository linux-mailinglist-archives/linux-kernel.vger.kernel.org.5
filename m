Return-Path: <linux-kernel+bounces-74206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3135785D120
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FB51F27691
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F733A8F8;
	Wed, 21 Feb 2024 07:19:21 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9BC364BC
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499961; cv=none; b=qiyhUF8w0a3sLZmVzzVHv9SMD5ZKo9Nt9svIiWhvPBBGJnLZCV0xgEx/AZgKxo811+jQZi7VsWrTRsHQOLRyVnKq0ROaeVu4z13TigTwGwR+3ANGRTFra56ZM1ajs6bZCHMKna+sFNnL9HQusZPavt/lcIPnTEH91XlmI4K9tOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499961; c=relaxed/simple;
	bh=qbA3HmjcAuokoqF8fAWQfarIxcWYV9/MEXRBff9Syic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PivjtWFB1HLF9Vx1gPojGT4t6A1qxWSJgEp9mlOo1lQVn1XJN0YziPXVSi34W+foX6qsII+hbIg0OTcCwrE1JBVNWadDOO/rIz9OTX8t+yPzeeqVn22kunR6TMZwOTBvCH9EfKiLxv+/a5mEYqDNqDqqAVeSmo5vQihL+Nlc0FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcgst-00007V-Tn; Wed, 21 Feb 2024 08:19:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcgst-001zjm-5E; Wed, 21 Feb 2024 08:19:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcgst-008kPz-0E;
	Wed, 21 Feb 2024 08:19:15 +0100
Date: Wed, 21 Feb 2024 08:19:14 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 7/8] intel_th: Convert to platform remove callback
 returning void
Message-ID: <qiiln66o6uy2nsqdjcykygp3yumonn7jqp7q4wxf56i6pazics@iqfaiglmsgwt>
References: <20231107202818.4005791-1-u.kleine-koenig@pengutronix.de>
 <20231107202818.4005791-8-u.kleine-koenig@pengutronix.de>
 <i3oybmf3axeyk5rcef5kgfdb4cucd63h24gup6idn62nq3vvav@4mfzwzyamq27>
 <jawceotzgdydpz74qr2e5dwgfumwjmt4wxvi43qlwldlbgemzf@v3qa2hoopawv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uof22c77cnfofesy"
Content-Disposition: inline
In-Reply-To: <jawceotzgdydpz74qr2e5dwgfumwjmt4wxvi43qlwldlbgemzf@v3qa2hoopawv>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--uof22c77cnfofesy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

On Thu, Feb 15, 2024 at 10:16:41PM +0100, Uwe Kleine-K=F6nig wrote:
> On Wed, Jan 10, 2024 at 09:41:54AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Tue, Nov 07, 2023 at 09:28:26PM +0100, Uwe Kleine-K=F6nig wrote:
> > > The .remove() callback for a platform driver returns an int which mak=
es
> > > many driver authors wrongly assume it's possible to do error handling=
 by
> > > returning an error code. However the value returned is ignored (apart
> > > from emitting a warning) and this typically results in resource leaks.
> > >=20
> > > To improve here there is a quest to make the remove callback return
> > > void. In the first step of this quest all drivers are converted to
> > > .remove_new(), which already returns void. Eventually after all drive=
rs
> > > are converted, .remove_new() will be renamed to .remove().
> > >=20
> > > Trivially convert this driver from always returning zero in the remove
> > > callback to the void returning variant.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > I didn't get any feedback to this patch and it didn't make it into next
> > up to now.
> >=20
> > Is this still on someone's radar?
>=20
> Is there a chance to get this patch into v6.9-rc1? Are you the right one
> to talk to about this patch? (According to MAINTAINERS you are.)
>=20
> The patch was sent during the 6.7 merge window and now already missed
> the 6.8 one :-\

I failed in several attempts to get feedback on this patch. You applied
the last two patches for this driver (that is all patches since the
driver was born). Would you care for that one, too? Tell me if you want
a resend. Note that the other 7 patches from this series are already
cared for, so if you're using b4 am or shazam, make use of -P7.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uof22c77cnfofesy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXVo/IACgkQj4D7WH0S
/k5dzQf/UN8pkmIH4/ffQO0quVHcOVG6MP8lmxHhmGS6FziCt5yBWxEOvwUGBdPD
9IPg8W1mMNALhv+KyAQoCjxilyXYtcbIYrScru9SkHMogipUHd1PT1rqhNtfVakG
Je8PrOzcbN/SED/JE+jLKmG0KNo/z057Rw71sI58cPX5ZmA9hVNjjzKCOyzxnWOB
VMTZ74SQrzkh5M1RUf5YGbmqXiXWc/47YQn/UGBBI7sRFfeTttaKeiNHHaNXRPtZ
OJQ/1o9ATflPeHVvUIMjFfmXqAoQoIGM4fTtYPMgsBTpZhKNHekTWdaXQImJjpTF
HvqIWmixPve3JrQSIfEpU6kAHzUqIA==
=WL9n
-----END PGP SIGNATURE-----

--uof22c77cnfofesy--

