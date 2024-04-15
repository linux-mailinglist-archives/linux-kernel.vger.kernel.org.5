Return-Path: <linux-kernel+bounces-145471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9423A8A5691
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B481C20A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739B679952;
	Mon, 15 Apr 2024 15:35:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2C174E37
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195317; cv=none; b=KrFWq3br+NS07tFK8RHQvdw4kC+TtmXfP/pVu2DrVznqo4gGlt5pla58N/oSwK4QnBsck9Rk/hfaiWj5LEdSsfNJ7qdPTn6nhuC2dY43Y8HAyH1AMUOPqe60srHqeuQ0lJ3ojIJUe7m2JBthlrApTQY9oYdhn8DmyXRRJBRzTow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195317; c=relaxed/simple;
	bh=P5tZrhGvuxKA7BZJEa8Mfe5VMy/aWKWrZbt9tytXFvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tx3kGhfYmpC0N/Sq77HiR/oskpQdwscQoeW4+fJ0XOO0yvVg9wAgQvLK0atk92qAHeDBeYYcPBWVY0MkTE/Q57o44YUEE33RaVB2rCCWwCZhCyCae7GWFcjPVgbo0JyxTDYXY8Xt2gDi9fhVoP35h3FwEqhgkaADws1Qo6UjZ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwOMG-0004MS-Bl; Mon, 15 Apr 2024 17:35:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwOMF-00CRvv-7A; Mon, 15 Apr 2024 17:34:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rwOMF-001joF-0S;
	Mon, 15 Apr 2024 17:34:59 +0200
Date: Mon, 15 Apr 2024 17:34:59 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Raag Jadav <raag.jadav@intel.com>
Cc: jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, 
	andriy.shevchenko@linux.intel.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: dwc: allow suspend/resume for 16 channels
Message-ID: <3xyvaqfbm3wud675co3pbli2ha7doalhoazcjnwnewqi6muqn5@4xj6sjrlpfr4>
References: <20240415074051.14681-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jhv2bnx5kb2cgyz2"
Content-Disposition: inline
In-Reply-To: <20240415074051.14681-1-raag.jadav@intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--jhv2bnx5kb2cgyz2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Apr 15, 2024 at 01:10:51PM +0530, Raag Jadav wrote:
> With 16 channel pwm support, we're registering two instances of pwm_chip
> with 8 channels each. We need to update PM functions to use both instances
> of pwm_chip during power state transitions.
>=20
> Introduce struct dwc_pwm_drvdata and use it as driver_data, which will
> maintain both instances of pwm_chip along with dwc_pwm_info and allow us
> to use them inside suspend/resume handles.
>=20
> Fixes: ebf2c89eb95e ("pwm: dwc: Add 16 channel support for Intel Elkhart =
Lake")
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
> Changes since v1:
> - Drop error message for -ENOMEM
> - s/data/ddata/

Thanks for addressing these concerns. I applied this patch to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
now.

I consider sending this to Linus before v6.9, but I'd let it cook in
next a few days before doing so.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jhv2bnx5kb2cgyz2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYdSSIACgkQj4D7WH0S
/k5voQf/S6JRIzY0Isn0KWRXQC4582LSqdS5RQqbHvtW+4zIRaIwOuysE1bNGVcV
hmWb9H8HtsqXnmYIMwxvdgYbdEs2oTj4l8JchfbH2OKTQfRCXG1NYMahHM4+ieQX
vdlIO5tDusi/xHaByrpMtGmvDJOQnv0EDcLlKcYT1S98q74pmzembkirn2pjKyrN
2kLfx44GwDWRkIeWV2xD1gzmE71vW9/Ag2ii0EhN9NM5fahaEL3boin2Q5NkJ87E
JeHES3p1KVs1liOXKmqr2YZs0DkKQ9ZLgnc1fDVaujJT919xExOxW92X+N0vtm6R
qpbB/QdwJa3+1x9Wm4wtHPqgVj8isw==
=yDR7
-----END PGP SIGNATURE-----

--jhv2bnx5kb2cgyz2--

