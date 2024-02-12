Return-Path: <linux-kernel+bounces-61387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CBE8511B5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84E00281B11
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A676A2BAF0;
	Mon, 12 Feb 2024 11:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="b8QQ0vrK"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D035848E;
	Mon, 12 Feb 2024 11:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707735741; cv=none; b=caI35A458Pm06A2e0mTOe/QnS7VPSrArtyZDLPMS5u3qp6uT7b1zsdsYV8ZTPbaJvie2tYFW7gIWuOLbLyU3hlh0gpaEj29GAMWR6P/FWTNJOx+p7fujLK5uF9S2iz7CTvN9KpfRDCdDseBQR9XwZPvdQAl8V2XspIcvZoLGi30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707735741; c=relaxed/simple;
	bh=6iNftqy+LpvtlMyVb8d/nUzm5YWyNegu0BDiFscW17E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMfHfGAR9M3dJpU56ZsHuEDjod5WucnhrjK8wlCJNoA8AjykGFmDotspgY2ICzXqB3/OvCmixEEb8m/bQ9pQjW/2Yh76PNav27qPIFwMvjt9B7HzA48wfcQNblUAq4dBj+h/+N78T91fd2v720S/q3uuq7tUeH4wWR7ZBtaipP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=b8QQ0vrK; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E337F1C006B; Mon, 12 Feb 2024 12:02:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1707735729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c5mAcojUSjY2ipf+E8fz6wuoXQVlOWqLNtkwBoyCzlM=;
	b=b8QQ0vrK4C17kFaIIJql7BUMI6i8eKkP/0odbnpnYzmw8IAiHybKesWDYv06yd4AhMJip6
	lB8x6MjoiQCRtCZ7q1TU9i9Q1aHW65vbTFOdg3PJS95zKVrDro4/4gxbjyPjblIoA5hxgL
	LRr3vT75CGJdeNoojpEl5vuOUF8sCyE=
Date: Mon, 12 Feb 2024 12:02:09 +0100
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
Message-ID: <Zcn6sSOqb+QpZtCC@duo.ucw.cz>
References: <ZcaCXYOf6o4VNneu@duo.ucw.cz>
 <3a662ef2-1888-4f24-bebe-3ce32da9d277@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="za5YJkWmS+Xk6BYI"
Content-Disposition: inline
In-Reply-To: <3a662ef2-1888-4f24-bebe-3ce32da9d277@linaro.org>


--za5YJkWmS+Xk6BYI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> > Add binding for anx7688 usb type-c bridge. I don't have a datasheet,
> > but I did best I could.
> >=20
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >=20
>=20
> You miss proper diffstat which makes reviewing difficult.

> Actually entire patch is corrupted and impossible to apply.

Sorry about that.

> Anyway, where is any user of this? Nothing in commit msg explains
>  this.

User being is worked on:

https://lore.kernel.org/lkml/2024020126-emote-unsubtly-3394@gregkh/T/

Thanks for comments. I'll go through them and try to improve things.

Best regards,
								Pavel

>=20
> > diff --git a/Documentation/devicetree/bindings/usb/analogix,anx7688.yam=
l b/Documentation/devicetree/bindings/usb/analogix,anx7688.yaml
> > new file mode 100644
> > index 000000000000..b9d60586937f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/analogix,anx7688.yaml
> > @@ -0,0 +1,140 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/analogix,anx7688.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analogix ANX7688 Type-C controller
> > +
> > +maintainers:
> > +  - Pavel Machek <pavel@ucw.cz>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - analogix,anx7688
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    maxItems: 1
>=20
> blank line
>=20
> > +  enable-gpios:
> > +    maxItems: 1
> > +  cabledet-gpios:
> > +    maxItems: 1
> > +
> > +  avdd10-supply:
> > +    description:
> > +      1.0V power supply
>=20
> Keep description in one line and add a blank line. This code is not that
> readable.
>=20
> > +  dvdd10-supply:
> > +    description:
> > +      1.0V power supply
> > +  avdd18-supply:
> > +    description:
> > +      1.8V power supply
> > +  dvdd18-supply:
> > +    description:
> > +      1.8V power supply
> > +  avdd33-supply:
> > +    description:
> > +      3.3V power supply
> > +  i2c-supply:
> > +    description:
> > +      Power supply
>=20
> Drop all useless descriptions (so : true)
>=20
> > +  vconn-supply:
> > +    description:
> > +      Power supply
> > +  hdmi_vt-supply:
> > +    description:
> > +      Power supply
> > +
> > +  vbus-supply:
> > +    description:
> > +      Power supply
> > +  vbus_in-supply:
>=20
> No underscores in property names.
>=20
> > +    description:
> > +      Power supply
> > +
> > +  connector:
> > +    type: object
> > +    $ref: ../connector/usb-connector.yaml
>=20
> Full path, so /schemas/connector/......
>=20
> > +    unevaluatedProperties: false
>=20
> Drop
>=20
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
>=20
> > +
> > +    required:
> > +      - compatible
>=20
> Drop, why is it needed?
>=20
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - connector
> > +
> > +additionalProperti
>=20
> I don't know what's further but this patch is not a patch... Please read
> submitting-patches, organize your patchset correctly into manageable
> logical chunks and send them as proper patchset, not one junk.
>=20
> b4 helps here a lot...
>=20
> >=20
>=20
> Best regards,
> Krzysztof

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--za5YJkWmS+Xk6BYI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZcn6sQAKCRAw5/Bqldv6
8q4MAKCs0lVJVkjm4x4MFHurUFu5tmbWGACgv9eckvxYpEmf2RO8FsiX/FvLRgc=
=ZJDH
-----END PGP SIGNATURE-----

--za5YJkWmS+Xk6BYI--

