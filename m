Return-Path: <linux-kernel+bounces-158056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAEA8B1AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01142834AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26153F9D2;
	Thu, 25 Apr 2024 06:15:05 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B22B27473
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714025705; cv=none; b=Zw7Z2PnvA18jPRM9tSdpqo5aIG5FgodMPS96Gx9sAMrCtpF16HC02PayLQHVOjgmAdFSe/S8fZWK9zzNUXXgjRrxTTCiJGdlpmfyKsfvipoP4QxBzEbjluw90wYAlIpfSqTswnYYrXUVXtWZsMgMf56a4SmgPefWSDZ/N0oRFgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714025705; c=relaxed/simple;
	bh=KsjKRFHHKQ+0GZOnUi9xLCWM4ubx9cXXQiLPw7we0eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXopc4gaHqVXIMMsLmkrI6KapI5pvFQ/83DNSLsIVqGtIQxdeOQwrvDtF6DIMbw3c39prg3j/ihSviM7ER5S1A2nlLQtfohZv3tWp21xRGFkn9PnNwziiaa5cdeMnyMZDDh0tPihEek/74KXqr/xlwOR4/bfvZxSjxYiSE7wopE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzsNW-0005pe-V0; Thu, 25 Apr 2024 08:14:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzsNT-00EDGW-EW; Thu, 25 Apr 2024 08:14:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzsNT-008Mht-17;
	Thu, 25 Apr 2024 08:14:39 +0200
Date: Thu, 25 Apr 2024 08:14:39 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Xilin Wu <wuxilin123@gmail.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Junhao Xie <bigfoot@classfun.cn>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Bjorn Andersson <andersson@kernel.org>, 
	Tengfei Fan <quic_tengfan@quicinc.com>, Molly Sophia <mollysophia379@gmail.com>, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 02/10] pwm: Add SI-EN SN3112 PWM support
Message-ID: <nuq56pinjqonlo4crfibtb2ddlwvldurkphomsyyqp6iupqpbk@u6kun3qvstw2>
References: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
 <20240424-ayn-odin2-initial-v1-2-e0aa05c991fd@gmail.com>
 <af62742c-8d6d-4fa9-b2e4-f83253e6e388@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rl24wix7isqmyofu"
Content-Disposition: inline
In-Reply-To: <af62742c-8d6d-4fa9-b2e4-f83253e6e388@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--rl24wix7isqmyofu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Apr 24, 2024 at 09:37:25PM +0200, Konrad Dybcio wrote:
> On 4/24/24 17:29, Xilin Wu via B4 Relay wrote:
> > +
> > +	/* use random value to apply changes */
> > +	ret =3D sn3112_write_reg(priv, SN3112_REG_APPLY, 0x66);
>=20
> "a random value"? sounds suspicious..

I smiled about that one, too, remembering https://xkcd.com/221/

> [...]
> > +#if IS_ENABLED(CONFIG_GPIOLIB)
> > +	/* enable hardware shutdown pin */
> > +	if (priv->sdb)
> > +		gpiod_set_value(priv->sdb, 1);
> > +#endif
> > +
> > +	/* power-off sn5112 power vdd */
> > +	regulator_disable(priv->vdd);
> > +
> > +	pwmchip_remove(chip);
>=20
> devm_pwmchip_add?

Note using devm_xyz only works if all requests before are also using
devm. (There are a few exceptions, but these need proper thinking and
extensive commenting.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rl24wix7isqmyofu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYp9M4ACgkQj4D7WH0S
/k5jTgf+JqJAnfN3fXmdz5yWJWeCDGj4DZTK3E0EJ2lu7asHWc+Pp6fM19DKN/F0
dsr14eDwjo1po1ptkFeRa04QeB7yeqMay3j0d5X4XUOm/SIHEI2Mn/ky5ZlVOwr7
ciorY8ICvuZ4YI/4306YGVmlbcndaA9ubGwykp0c9JYUqdSMWgwBGy4dVqHoKPmR
RiM2SBTJAVd5Qw2LmSMMZ+uU25dWYCiM4eHrkbphTMhYItgqvTWkZhiTEdDVmU/p
2RqsoyKgfJKcMfW8eF31vZd7qkRjPErqQU76uzhW0Cm9nPDJERrXkkB+fGEzOcAh
6ros37wvCLEtFIp5fA2kOsh/PhCMeQ==
=Hs3D
-----END PGP SIGNATURE-----

--rl24wix7isqmyofu--

