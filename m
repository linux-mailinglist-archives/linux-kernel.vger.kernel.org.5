Return-Path: <linux-kernel+bounces-130461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA28897879
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7A11F27030
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32069154BEA;
	Wed,  3 Apr 2024 18:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="UXk5clxU"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC381D54B;
	Wed,  3 Apr 2024 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712169870; cv=none; b=e+u1L2012zVgBJd9nAdPe2k5kVsYZ8VKJHpmjIsNz7nQnvyuIbPvUboAc87g2Srh7nztN0vMXgArbR+dKwBWzNQYeWRmA9t9XR/20Zflsb0nyoBG2jIkF3xtfoJeBdIUs66dH4Agz09u4n4VUxp/jdBjgyuivDgHu0CS1+dQAVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712169870; c=relaxed/simple;
	bh=1EkD6J6ZXdEoxa2rk1uEMRnFWIrrNOpvsjrJATOctzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpPGhJRs3cnsGwehAZSV9uPd4lAnlykH7T+ihOvzokXgZjwjy36t3PKwE8Zrghsa3PjPkd4KWApP9aW5oJw6hXl/9Gzp9EKWZ+zH8PTXRsYrohswFwZU3EQA9GS4wgfEyXWN0UxKNuvdVJy9MfVd28MtVAOc+m3P5/Sei+VOHWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=UXk5clxU; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 508411C007F; Wed,  3 Apr 2024 20:44:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1712169859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aHQCuvhMEh7H83JBQJudhosI61BGysrG7OtmjAOZ5xo=;
	b=UXk5clxUqDzVZJJMscF+lK21IIOKV+kpj5+ZBGVSWLmfVowENY57Q7QW0g0diN2QjJ67AB
	d9kj242B1vQNV+Xw1YG6SYuAlapyD6xT3LuwrDol+te5KdPVpsJnrYAxwi0yT3FG4j+c6g
	euehjMJ7If2ojxZbxRNoS4XlGMjNIyo=
Date: Wed, 3 Apr 2024 20:44:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: git@luigi311.com
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 05/25] media: i2c: imx258: Add regulator control
Message-ID: <Zg2jgmmqw0nXDYcF@duo.ucw.cz>
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-6-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O21qkBwoedtlBEgw"
Content-Disposition: inline
In-Reply-To: <20240403150355.189229-6-git@luigi311.com>


--O21qkBwoedtlBEgw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The device tree bindings define the relevant regulators for the
> sensor, so update the driver to request the regulators and control
> them at the appropriate times.

> @@ -995,9 +1007,19 @@ static int imx258_power_on(struct device *dev)
>  	struct imx258 *imx258 =3D to_imx258(sd);
>  	int ret;
> =20
> +	ret =3D regulator_bulk_enable(IMX258_NUM_SUPPLIES,
> +				    imx258->supplies);
> +	if (ret) {

Will this make it fail for all current users?

Best regards,
								Pavel
							=09
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--O21qkBwoedtlBEgw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZg2jggAKCRAw5/Bqldv6
8hP5AKCepr5aI0IdUd8z6pbcafo2ln1O4QCeKiMkegDwZZl1QHdwdT3bX0OqjyQ=
=Juic
-----END PGP SIGNATURE-----

--O21qkBwoedtlBEgw--

