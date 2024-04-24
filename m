Return-Path: <linux-kernel+bounces-156475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2176E8B0312
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72FA1F25745
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF7E1586D2;
	Wed, 24 Apr 2024 07:19:46 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90508157E6C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943185; cv=none; b=sZgQ94d/RZhr/8JFcalfoDZBFdsDhx1632zDWMcExgpuGSKdVS6+kAkV6LDYUwr51XQ9WhuzMpnVDBVgdrQBBe65IDExgjtO59n7XJhyDDnL9AGFk54uLbTj5LvX+ZpKqbGK0V3ojafWxrVukbMe3/5ocIA0GzMfpBij7DvDzAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943185; c=relaxed/simple;
	bh=peBdXF+tZbOPnP/wixBXjaNOlL9aVdZLMZ7AgmJF0Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/qIXmoERBcjNO50tYIsmMeRYKT+zztongLKrhg+Ibjk7HNToF0pZ7miqstu0U54KATBs8Rk/U4Wy++cNdJ3UKQ323jcOGhxuKHcQvKs8JBRWKYM6Z4BzBK4AQWG7lTIX/3pu5odJZit58EWsr04mYhpj0TSklH370nF2EE9ABk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzWul-0003XV-IH; Wed, 24 Apr 2024 09:19:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzWuk-00E2OB-Mt; Wed, 24 Apr 2024 09:19:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzWuk-007gCX-20;
	Wed, 24 Apr 2024 09:19:34 +0200
Date: Wed, 24 Apr 2024 09:19:34 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: George Stark <gnstark@salutedevices.com>
Cc: neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, 
	martin.blumenstingl@googlemail.com, thierry.reding@gmail.com, hkallweit1@gmail.com, 
	linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@salutedevices.com, 
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH 1/2] pwm: meson: drop unneeded check in get_state callback
Message-ID: <wkn6ybnnlco7vrqbpclfxaajt5cvywpr633au7qcr6vpjihabq@kb7q6y4khh2k>
References: <20240423161356.2522636-1-gnstark@salutedevices.com>
 <20240423161356.2522636-2-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3xwbvuajde4meb2t"
Content-Disposition: inline
In-Reply-To: <20240423161356.2522636-2-gnstark@salutedevices.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--3xwbvuajde4meb2t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello George,

On Tue, Apr 23, 2024 at 07:13:55PM +0300, George Stark wrote:
> Drop checking state argument for null pointer in meson_pwm_get_state()
> due to it is called only from pwm core with always valid arguments.
>=20
> Fixes: 211ed630753d ("pwm: Add support for Meson PWM Controller")
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

I'd apply this one with the following changes if you agree:

 - capitalize "drop" in the Subject line
 - s/get_state/.get_state()/
 - make "null" all caps (i.e. "NULL")
 - swap the order of Signed-off-by lines to have yours last.

Alternatively send it in a v2 together with addressing the comment in
the second patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3xwbvuajde4meb2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYosoUACgkQj4D7WH0S
/k7G1gf+PGBuQXOKBKGgHuOhdu/hGX+YqKlLX7bGKVF4a/6Hj5zjVxP2W2WeOd42
o5lwOx0Aby2qxA2/greyP1XODpf86xX9J5CPuk0h9haNt10XVsLP+tzX0bpgorYY
ltKCskC3VzFM4L+l7tiSF+8478kLzjpzwKR/lg1jr6ib5IH8g/riSNpJekMstrK6
FUnzSKBW1r01wv8T7OW+cy3f35ygttE//Bii1OSiEGqU/gtouoEtoy2AKZrIwCuP
C28ArBOOsUmbVTW/0U9g7wakmNlxaLVqC8kJPVrG4cz5ndaDczWjQV02MlbvrkO/
XaP6LMwi1REygGrxkME/m1VxDaxEVQ==
=gKa2
-----END PGP SIGNATURE-----

--3xwbvuajde4meb2t--

