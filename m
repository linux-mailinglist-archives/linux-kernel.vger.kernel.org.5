Return-Path: <linux-kernel+bounces-157009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2CE8B0B82
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6AD283C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CD915D5B1;
	Wed, 24 Apr 2024 13:51:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3E215CD57
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966708; cv=none; b=K2DRs/wu7fBp+ZTKN57SUtyY/doH6eGobQ+popLWYDIOEtEx1WkbELmvdWle5lAhWnUeOrJF3pQAQS0slHeczs/6k8Du/ftonyMFhr7WwbQV+XbdBIKvcDngkcY872ohdVfUIVDvl9kBxJEyYdXJ4Lr6s9GZnnkJ5hhjTsmAkf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966708; c=relaxed/simple;
	bh=GHUbYh1dGaNP+Satu0ucIrYHluoGDv9jtiSlSfP1ehg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwJZg/C5cXHaUJkjtA/3avbfo+eoCm1YKP47OL1G1VZj0VgiyGrLDDPfVLWzfP2zwjdSN5DjFbuAWZokiP+xC5cpD9SQq0ql7vewDcJBF/dd9g7UZMi7TE2WK8vXKxxaOmYBVwvILD7y+PTT8GU8fTdpXh2jaiteiMqSfJYfxkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzd24-0006Wx-Ru; Wed, 24 Apr 2024 15:51:32 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzd23-00E5fI-OP; Wed, 24 Apr 2024 15:51:31 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzd23-007pJV-27;
	Wed, 24 Apr 2024 15:51:31 +0200
Date: Wed, 24 Apr 2024 15:51:31 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: kelvin.zhang@amlogic.com, George Stark <gnstark@salutedevices.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Junyi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH v4 1/2] pwm: meson: Add support for Amlogic S4 PWM
Message-ID: <ikwqq5veuad7fehk6qrpebevvn2ezuxwm3h7agloqeomxc5cbg@kj3be67luyxm>
References: <20240424-s4-pwm-v4-0-ee22effd40d0@amlogic.com>
 <20240424-s4-pwm-v4-1-ee22effd40d0@amlogic.com>
 <1jil07f3ps.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iu54kaoqx4r57nc6"
Content-Disposition: inline
In-Reply-To: <1jil07f3ps.fsf@starbuckisacylon.baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--iu54kaoqx4r57nc6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Apr 24, 2024 at 12:32:36PM +0200, Jerome Brunet wrote:
> > +err:
> > +	while (--i >=3D 0) {
> > +		channel =3D &meson->channels[i];
> > +		clk_put(channel->clk);
>=20
> Fine on error but leaks on module unload.
>=20
> Same as George,
>=20
> Add the devm variant of of_clk_get() if you must.

There shouldn't be a reason to still use of_clk_get(). I'd expect that
devm_clk_get() should do the job and if not that's a bug.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--iu54kaoqx4r57nc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYpDmIACgkQj4D7WH0S
/k4DWwf7B/jLf47AuXBENtfvni8lWuon3Tt/DXDsPZRlEb9UoEXv4WxXlFZKVftO
l0q+KF0HHEML/dD9UUE4g8UNe2U7eUlEg7gyUjExBdfPlGM+j3lNOGZDwdqreNle
Gdoit31nRGG4IBuTHQDewkHDPOs92aw0EqeWayTuBlTXdl/F6Sm7qe8/HckfWumO
o9DdQi0o6HUdFpx6WLKRX3HiNebDQSVaWg9BSZeJyFt8uF3ppm6ZfWNKlyDJzxvE
lnQ+8aDWoPghdZFh4OBPg6KCRTd/hgs2jnkVq1py5jjxyoz68cQHxAh+fAho+9sX
EHf+41Kbc2RIW2j8/2JXauQz2hDXXA==
=LRdh
-----END PGP SIGNATURE-----

--iu54kaoqx4r57nc6--

