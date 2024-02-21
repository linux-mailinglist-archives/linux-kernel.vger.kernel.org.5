Return-Path: <linux-kernel+bounces-75611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161CF85EBF1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480701C21D18
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D5F55C3C;
	Wed, 21 Feb 2024 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="Do/QualS"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D930C86632;
	Wed, 21 Feb 2024 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708555520; cv=none; b=OWURP5KA7z06jYFHwg2O7RKMdqOt4CKRV4/HdRSlpKR2IdUgF3bt+9rBN1CltR0tsnMCwPDRrt9eYzmBSMNJQIZ8XVc2ExVuz/cmf5OVbzhpPaL778yAKOYU0j0QQ/KNTiMseTnHF+xpTGGkosYkq7GRyg0VSqSeJlQ6tMsxa2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708555520; c=relaxed/simple;
	bh=fDkXZQyzvS8dAR3rkIWG/K/wRLGBKBMUb6eh57byNQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKVxwjTdGs4MOTuvM6cbyjRcIvmbp+BV94m5wIh+T2j4kqrJpyXfZOJWRvDyqcvo+uSEzHFxmInipkLMzb8B0aD2taoT5mRytZdefcDoz5PYINQ5MoFcKG6VDOxwwczawfoGBGiNoZpqr2X9JJBUJXIvDP/k8qBqyW6Lm/GCw2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=Do/QualS; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 192821C0080; Wed, 21 Feb 2024 23:45:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1708555515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s1SEjDExyUooD+Jplmcfeg3a+A+/P8S2geYCCDEDfDw=;
	b=Do/QualS6TWwqfjCVIUtecQ7axmrxAqkVrtY+0y1OCoNY6quxfCKL58g5jKDmz+OE20bfi
	bS9pOcfCewqt62b5yFrd6ESlhTSyeHL6AH3PECsvRPRo+HInsL0WOoFGZzu0lpGxc/q7K/
	9qc7PY2zRl7gZHYbAlchwqw1wIX5P50=
Date: Wed, 21 Feb 2024 23:45:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: phone-devel@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>,
	fiona.klute@gmx.de, martijn@brixit.nl, samuel@sholland.org,
	heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	megi@xff.cz
Subject: Re: [PATCH] dt-bindings: usb: typec: anx7688: start a binding
 document
Message-ID: <ZdZ8+vwoILO3pf0h@duo.ucw.cz>
References: <ZcaCXYOf6o4VNneu@duo.ucw.cz>
 <3a662ef2-1888-4f24-bebe-3ce32da9d277@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VEdryfHzoLY8OQfU"
Content-Disposition: inline
In-Reply-To: <3a662ef2-1888-4f24-bebe-3ce32da9d277@linaro.org>


--VEdryfHzoLY8OQfU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > +  reset-gpios:
> > +    maxItems: 1
>=20
> blank line
>=20
> > +  avdd10-supply:
> > +    description:
> > +      1.0V power supply
>=20
> Keep description in one line and add a blank line. This code is not that
> readable.
>=20
> > +  i2c-supply:
> > +    description:
> > +      Power supply
>=20
> Drop all useless descriptions (so : true)

Ok, fixed, I hope I got it right.

> > +  vbus-supply:
> > +    description:
> > +      Power supply
> > +  vbus_in-supply:
>=20
> No underscores in property names.

Ok.

> > +  connector:
> > +    type: object
> > +    $ref: ../connector/usb-connector.yaml
>=20
> Full path, so /schemas/connector/......
>=20
> > +    unevaluatedProperties: false
>=20
> Drop

> > +
> > +    description:
> > +      Properties for usb c connector.
>=20
> > +
> > +    properties:
> > +      compatible:
> > +        const: usb-c-connector
> > +
> > +      power-role: true
> > +
> > +      data-role: true
> > +
> > +      try-power-role: true
>=20
> I don't understand why do you have here properties. Do you see any
> binding like this?

Well, it looks like I copied these mistakes from analogix,anx7411.yaml .

> > +
> > +    required:
> > +      - compatible
>=20
> Drop, why is it needed?

Again, copy from analogix,anx7411.yaml .

Should I try to fix up analogix,anx7411.yaml , and submit that, first,
or is it easier if you do that?

Thanks and best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--VEdryfHzoLY8OQfU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZdZ8+gAKCRAw5/Bqldv6
8gr4AJ97KMZrugfihrFG/IvlUx3HrasLBACeOE+16JUA5PzpDbeRrZPUpXx/JiY=
=Iun9
-----END PGP SIGNATURE-----

--VEdryfHzoLY8OQfU--

