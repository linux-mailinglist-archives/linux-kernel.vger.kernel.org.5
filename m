Return-Path: <linux-kernel+bounces-161839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2DE8B520C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAA6CB2126B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5BA13AEE;
	Mon, 29 Apr 2024 07:13:20 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAA410A1D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714374800; cv=none; b=dURBiluibz40OymdPU3uf2bsEnXj/D6MV+2kT+xBPKvfpNcb1Nn8mz2F6pUtdcHxa1zYqUVz4KASADTPbgBUNn1O4A+lyBnRjEE5L5LZqGdT4M0bI/wcySGK+O4HbvRiRJLMPj1F7NfYn2jjh9bmP6KPLOuMKeva8nb3vTT5DYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714374800; c=relaxed/simple;
	bh=ckBKhFZBzN81l8RNVvXQmvyvSCSw0g6m221rKjyVgU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYutc5u9Lig63cm59RZ4nWuapKftoipPMKCyyP6JvHlEO1hzoauiPG7oT8EZkyN3MLwzJGnC2KXfPtg13WppCSFQ0Z0w1EYjUpffKzQB2pR4AKvKNqgSRWYlAo/DO+lqqh6HMzlQIvdMZ4mUkyZ6WLHWs96DbgZesobeNr++AzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1LCN-0003X3-D1; Mon, 29 Apr 2024 09:13:15 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1LCM-00Ew6a-KC; Mon, 29 Apr 2024 09:13:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1LCM-00BDsA-1j;
	Mon, 29 Apr 2024 09:13:14 +0200
Date: Mon, 29 Apr 2024 09:13:14 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 7/8] intel_th: Convert to platform remove callback
 returning void
Message-ID: <rucgdqb5ejtttsd2ksvph3toeow652rdiqnohdsg6ndp6qgcwu@c3rz275bofqg>
References: <20231107202818.4005791-1-u.kleine-koenig@pengutronix.de>
 <20231107202818.4005791-8-u.kleine-koenig@pengutronix.de>
 <i3oybmf3axeyk5rcef5kgfdb4cucd63h24gup6idn62nq3vvav@4mfzwzyamq27>
 <jawceotzgdydpz74qr2e5dwgfumwjmt4wxvi43qlwldlbgemzf@v3qa2hoopawv>
 <qiiln66o6uy2nsqdjcykygp3yumonn7jqp7q4wxf56i6pazics@iqfaiglmsgwt>
 <87edd5y7lz.fsf@ubik.fi.intel.com>
 <rnybbv5sddkgtnxzad7sg2jyosr77vvud6t7ii3sssfsi7td2u@3b5nbhsprcaf>
 <875xwjxgsk.fsf@ubik.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lhk5mqvpojsayxfv"
Content-Disposition: inline
In-Reply-To: <875xwjxgsk.fsf@ubik.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--lhk5mqvpojsayxfv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Alex,

On Mon, Apr 15, 2024 at 09:48:27AM +0300, Alexander Shishkin wrote:
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> writes:
> > Given there are not that many patches left (~50) as of today's next, I'd
> > like to see this patch going in during the next merge window, that I can
> > finalize the (next step of the) quest around platform_driver::remove.
> >
> > Is sending this patch to Greg still on your todo list?
>=20
> Yes, as soon as I finalize other patches on my series. Should be soon.

I know neither your nor Greg's plans, but I wonder if this patch will
make it into v6.10-rc1 given that it still didn't land in next yet.

I intend to change the prototype of platform_driver::remove() after the
merge window leading to v6.10-rc1 closes to cook in next for some time.
If this patch doesn't make it into the mainline before, I'll send it
together with the change adapting the remove callback. That will go in
via Greg's tree, too.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lhk5mqvpojsayxfv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYvSIkACgkQj4D7WH0S
/k5xgQf9GEfJ+cnKLoD4gYUvF8t+rH375B0ZR+kq0oSbf0hhrhr1ncqgNJK3Cdl5
l7WIUPHrdUoj+QGNbedQlS2crcmrgPPVKtwR7RZZW82iXcSgg2V6VGpoKy9WVrE6
IWQBBISYl3l84jrvT1I7nmyoYSV4ZYjVIcqdRTXkL11dNfVcYL0AXdRxhVatl1LO
Xcprbq1tMy/nCQF/BViMB8gI9Miz/IXQK4sB0yM6jI/XEeCWDwJo4Y0oZjTxwbNx
YlJUzI/jl8keD8LMlmq1eNE/xZLabryVldy93WMGPeY1u97ezIiRV4gTBHSHcQ6Y
+XfCkwWuWrImDaYUPSyQ8KufaY5Irw==
=5vjS
-----END PGP SIGNATURE-----

--lhk5mqvpojsayxfv--

