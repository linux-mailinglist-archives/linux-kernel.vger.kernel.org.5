Return-Path: <linux-kernel+bounces-100119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BEF879201
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D982A1C223D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152767868D;
	Tue, 12 Mar 2024 10:27:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E797866D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 10:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710239264; cv=none; b=aKjvtqGS9FpbwVmJGI03GyS439hxolcc/4vLsv1Uhyt96zFOaUQo8DPF0AiNbazevHDOY2NrmLWWiP0akjKITsM0cFgSlnjPHQj3sUK6/95iHtV28YxotcBANJG0pTcaH5vkc81fokPWB4hNR4Jjemdwqf0eFxvgDZDioyCs3ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710239264; c=relaxed/simple;
	bh=xqfBhuI1lE+rVJm9vLfWs4M0RDKrnWkBLCkCDFOzCCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QImyzvTKIG1L/w3ThUXNqNPwSaa/hwqiw4DLrwMA3bpqqihHDuu+tIPmVfXlfCW1uoFkIeUe0ROim9aSmsDT5qDkfllMkOeav0c+lsTETJ49Y2RZg9bFBuV8rIUoiSuRGP4JT1ASGQOs7oWt08PZH3b21vnaSbOuNZdQEVQU0zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjzMA-0001wu-Pv; Tue, 12 Mar 2024 11:27:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjzMA-005tcR-5H; Tue, 12 Mar 2024 11:27:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjzMA-004gxr-0F;
	Tue, 12 Mar 2024 11:27:38 +0100
Date: Tue, 12 Mar 2024 11:27:37 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH 3/3] auxdisplay: img-ascii-lcd: Convert to platform
 remove callback returning void
Message-ID: <r5ydocz3u3ng6voax2iveoqvvqpuo6s3defjkpqzmuoj222clw@76ilb4kbjlrw>
References: <cover.1710194084.git.u.kleine-koenig@pengutronix.de>
 <44de2d4c1fed6fe96b68ba9ad768d297b8f392a5.1710194084.git.u.kleine-koenig@pengutronix.de>
 <CAMuHMdVvmN2xns_76zSDpUX-v8V16mSP12A=Y4gght9cdgNb+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fuiusb2rlhjutq6u"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVvmN2xns_76zSDpUX-v8V16mSP12A=Y4gght9cdgNb+A@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--fuiusb2rlhjutq6u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 09:17:54AM +0100, Geert Uytterhoeven wrote:
> Hi Uwe,
>=20
> On Mon, Mar 11, 2024 at 10:59=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling by
> > returning an error code. However the value returned is ignored (apart
> > from emitting a warning) and this typically results in resource leaks.
> >
> > To improve here there is a quest to make the remove callback return
> > void. In the first step of this quest all drivers are converted to
> > .remove_new(), which already returns void. Eventually after all drivers
> > are converted, .remove_new() will be renamed to .remove().
> >
> > Trivially convert this driver from always returning zero in the remove
> > callback to the void returning variant.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> Thanks for your patch!
>=20
> > --- a/drivers/auxdisplay/img-ascii-lcd.c
> > +++ b/drivers/auxdisplay/img-ascii-lcd.c
> > @@ -279,13 +279,12 @@ static int img_ascii_lcd_probe(struct platform_de=
vice *pdev)
> >   *
> >   * Return: 0
>=20
> Please remove this line.

Good catch, thanks.

@Andy: Should I resend this patch? Or the whole series? Or do you want
to fixup while applying?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fuiusb2rlhjutq6u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXwLhkACgkQj4D7WH0S
/k5WTAgAit22PIgRe2YUSFmwCR4+0SgXL8IxvwWIDEJRo/uWcxwB9Gj3m3Idb6KA
pkRCNFdV4soD5xMNOve/DKy3uqxigYCpJAPo58yulrlHtyfEIWYhdBFCPyi4M4FG
jf7mw/qu5Z8uO9x5WBaJK1ox2ysp6TxdP4m/bgjr1IbRwvpXC3hA2y3qEC9fp+6J
rF+xQ+pz6SYL7wp/wNeK/4fpEnLUzByfq40HNPjRl/Gff+K43KnaXvdJtS7ahxFd
57qY/v6/s3T4jQj5JQUaWo6Gh39+bbX311x4FQeXCuLTwqSWcE0FyKq8zR0ZItOU
K2V75WVRKetnK6aYX8M3/lQQFTp9Zw==
=IZji
-----END PGP SIGNATURE-----

--fuiusb2rlhjutq6u--

