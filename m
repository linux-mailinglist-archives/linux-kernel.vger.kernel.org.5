Return-Path: <linux-kernel+bounces-65256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8EF854A35
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843BF1C20A24
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD240535D7;
	Wed, 14 Feb 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o+R85huF"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8FD53E0D;
	Wed, 14 Feb 2024 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707916400; cv=none; b=jJ4220bsZQkjdnBb+w0WxDkrfqQIvWzWCIXor6sBMqmSlCRgtC66v8+AUdK3uigJtr/n3uvzpGgc2T0BvFmnil1yyNvVoSDSWJ/FO7sYZb46l8mQNxykTa9Di8Eys1RMk6vsqRNHdfARhYXhsu9xD8w02s6YI4en+GpRV0rbcD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707916400; c=relaxed/simple;
	bh=trNel9DGiBM9izEKSSd/SarU5GGAHEjWvzZ33PVmI/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtEWuum6EOl0TO95RcezLdMoLYZc+ekG3J6Xl7k7P9y23ElbZUsQu9XjuFx4NHPatW1wOO52tl7Dilyf3DAG8elJ5nmqQRJQp2IX2d1yZIbtF/QWPxXYzsF89saAVvpWETiuevN2cik+ibjnR1yTT4T8+HLmrYK9M+OlzsH+Q9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o+R85huF; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A93444000B;
	Wed, 14 Feb 2024 13:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707916395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yoAjEMlVwFZdXBa82MjfrxBFsO3UeSV1bx1OSrRYZw8=;
	b=o+R85huFFD6K3kjeRghvtDXOyBJKIWQiti408PeQ5wsVaLIvqUe0c4Vv65+MF5zU9e0XAQ
	7t89FsKLZJtQ023ajRy/DL+B0cX7Rz5llmD+XPpwCXAdXNfasJ0c7pHwURc8qgnnMXwqMx
	5fhB6aWU39RpEpN5+7Qyeysk91SVaCiAXHHBBRuu1PpS1plXq+P1S8FrEuEy0PsoLSG63S
	Ca9qyl9dmi/rn/3ekkj9GF1/szixWhVHVRjcr9JxPbpWEqE8fUmWU7JI8tPkw5hVMRka9G
	YBjwBrB6HF8wkQrxn41t7SlM9l98Wh1m/xypGctR1b/GKmo3oHhSgdhgcSb58A==
Date: Wed, 14 Feb 2024 14:13:10 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v3 10/17] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Message-ID: <20240214141310.119364c4@kmaincent-XPS-13-7390>
In-Reply-To: <20240209144349.GA3678044-robh@kernel.org>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
	<20240208-feature_poe-v3-10-531d2674469e@bootlin.com>
	<20240209144349.GA3678044-robh@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

Hello Rob,

Thanks for your review!

On Fri, 9 Feb 2024 14:43:49 +0000
Rob Herring <robh@kernel.org> wrote:

> On Thu, Feb 08, 2024 at 02:08:47PM +0100, Kory Maincent wrote:
> > Before hand we set "#pse-cell" to 1 to define a PSE controller with =20
>=20
> #pse-cells
>=20
> > several PIs (Power Interface). The drawback of this was that we could n=
ot
> > have any information on the PI except its number. =20
>=20
> Then increase it to what you need. The whole point of #foo-cells is that=
=20
> it is variable depending on what the provider needs.=20
>=20
> > Add support for pse_pis and pse_pi node to be able to have more informa=
tion
> > on the PI like the number of pairset used and the pairset pinout. =20
>=20
> Please explain the problem you are trying to solve, not your solution. I=
=20
> don't understand what the problem is to provide any useful suggestions=20
> on the design.

Please see Oleksij's reply.
Thank you Oleksij, for the documentation!!

> >=20
> > Sponsored-by: Dent Project <dentproject@linuxfoundation.org> =20
>=20
> Is this a recognized tag? First I've seen it.

This is not a standard tag but it has been used several times in the past.

> > =20
> > -required:
> > -  - "#pse-cells"
> > +  pse_pis:
> > +    $ref: "#/$defs/pse_pis"
> > +
> > +$defs: =20
>=20
> $defs is for when you need multiple copies of the same thing. I don't=20
> see that here.

I made this choice for better readability but indeed it is used only once.
I will remove it then.

> > +  pse_pis:
> > +    type: object
> > +    description:
> > +      Kind of a matrix to identify the concordance between a PSE Power
> > +      Interface and one or two (PoE4) physical ports.
> > +
> > +    properties:
> > +      "#address-cells":
> > +        const: 1
> > +
> > +      "#size-cells":
> > +        const: 0
> > +
> > +    patternProperties:
> > +      "^pse_pi@[0-9]+$": =20
>=20
> Unit-addresses are hex.

Oops sorry for the mistake.

>=20
> > +        $ref: "#/$defs/pse_pi"
> > +
> > +    required:
> > +      - "#address-cells"
> > +      - "#size-cells"
> > +
> > +  pse_pi:
> > +    description:
> > +      PSE PI device for power delivery via pairsets, compliant with IE=
EE
> > +      802.3-2022, Section 145.2.4. Each pairset comprises a positive a=
nd a
> > +      negative VPSE pair, adhering to the pinout configurations detail=
ed in
> > +      the standard.
> > +    type: object
> > +    properties:
> > +      reg:
> > +        maxItems: 1 =20
>=20
> As you are defining the addressing here, you need to define what the=20
> "addresses" are.

Yes I will add some documentation in next version.

> > +          values are "alternative-a" and "alternative-b". Each name sh=
ould
> > +          correspond to a phandle in the 'pairset' property pointing t=
o the
> > +          power supply for that pairset.
> > +        $ref: /schemas/types.yaml#/definitions/string-array
> > +        minItems: 1
> > +        maxItems: 2
> > +        items:
> > +          - enum:
> > +            - "alternative-a"
> > +            - "alternative-b" =20
>=20
> This leaves the 2nd entry undefined. You need the dictionary form of=20
> 'items' rather than a list. IOW, Drop the '-' under items.

Oh thanks! That is what I was looking for. I was struggling using the right
description.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

