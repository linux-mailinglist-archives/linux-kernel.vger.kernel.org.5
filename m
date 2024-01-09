Return-Path: <linux-kernel+bounces-20799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D727482855D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789071F24A84
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769E738DED;
	Tue,  9 Jan 2024 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="qKWCvr/+"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F91938DD5;
	Tue,  9 Jan 2024 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B7F841C006B; Tue,  9 Jan 2024 12:44:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1704800695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XOjrfD6J1wf36M9V10dI2vhgL32veMT6UVLvbaeKZQg=;
	b=qKWCvr/+FrRHGwKgLxU1KFUtm5nCWJ6SMs0AaQ2MisUbtcBOgc8u++wpufwZPW5egaP1X+
	GrGSFUJohxTlMgDkhHpMvwIgkwKhCrleB6mxSogTSgvY2PNddIb7BnQOvQXtCNT+6+MzfD
	jvSpALMH/z/31/ChYNG1g2cFJWpPP5I=
Date: Tue, 9 Jan 2024 12:44:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 4/7] Input: amimouse - convert to platform
 remove callback returning void
Message-ID: <ZZ0xt75z/qSf5f8V@duo.ucw.cz>
References: <20231226002649.7290-1-sashal@kernel.org>
 <20231226002649.7290-4-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ICWHDsvhgHsBMFXU"
Content-Disposition: inline
In-Reply-To: <20231226002649.7290-4-sashal@kernel.org>


--ICWHDsvhgHsBMFXU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> [ Upstream commit 42b8ff47720258d1f6a4412e780a480c139773a0 ]
>=20
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>=20
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.

We don't really need this for -stable.

Best regards,
								Pavel

> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Link: https://lore.kernel.org/r/20231201133747.1099286-2-u.kleine-koenig@=
pengutronix.de
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--ICWHDsvhgHsBMFXU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZZ0xtwAKCRAw5/Bqldv6
8lApAJ90gRzFv2cb+l/AmyogaG/yFFDLbQCeJVtEREvzO6XZuPRBE3RLj4L+nJ4=
=Nhy4
-----END PGP SIGNATURE-----

--ICWHDsvhgHsBMFXU--

