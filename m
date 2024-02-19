Return-Path: <linux-kernel+bounces-71491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365F685A625
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF0B6B2191B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B19C37163;
	Mon, 19 Feb 2024 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hcJH9P9m"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5CD1DFE8;
	Mon, 19 Feb 2024 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353528; cv=none; b=WHalSSriSEUMvvgX8D3xDhu1QuHkI1saSqn/Leu/cjmpYlvDD9NXjrLuXxW62HwRPqigYSZHbaoEul4Xs4pEfqmew2MBq13r+xSbb9tW+LKOW94VoSATiFtwzlY8ANMhvdkiYDTbeL27R+YASUibketRD6W/f6y/w23oiqJJ/C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353528; c=relaxed/simple;
	bh=V33FKlInx1KJB20TacJi7c48XX2d5TgiGJuyJLQhp3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khBoxxiFa4EdvC3v1SGgQ9ox3nkwJu8GZNQEGgardH8nciLIuN/NWszYdP+FBAw3UTU7orenYzXqBRtGYNQVPS+5h3juPEZ3cdIgckyKVJ5on1ycwLKgrgg71jpb/mtmyoPch9ST8hCGlWFU++9/OwU7Z8N++OjOx9fciii8Ypk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hcJH9P9m; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 38DE81BF20E;
	Mon, 19 Feb 2024 14:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708353524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dlMyt/GJrB0JNCkR9mOHZ/+ThyT2C/+DYVpdAxe/hfA=;
	b=hcJH9P9mEQdasxaR15/c5bbDhmL8Cr/KWh2ZitP7vTgc0Z2gT+VmaBJfxTCoXNLgIdmAXY
	h3QyZ0CpfPfbQPrwxOQFWGtHCSbI4QU+yzptWL7C9R2zwHVLW6oXpFvE4Bp45eePioVmXo
	ub2k0nPcu0dMPKiRFRgUrmmxhmfIw/2+tUXXRTVbL7g0h2ndfO/R41JP4Qm/rrej/HnC0S
	YWbldHcqA3n4MRrOKQ7JOFcKE6/AKOq0GLa3yaPVkPHzUKPx9R9Gk1mi0xPQ8cp5dLWeFo
	Uam0aGLjIoKPCFiaUtRWQsDcnEQYi0FWs/sxTl6TfEPK3wOW1K4Ep9Yr5CGfzw==
Date: Mon, 19 Feb 2024 15:38:40 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v4 14/17] dt-bindings: net: pse-pd: Add
 bindings for PD692x0 PSE controller
Message-ID: <20240219153840.507be7b3@kmaincent-XPS-13-7390>
In-Reply-To: <ZdCjJcPbbBGYVtuo@pengutronix.de>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
	<20240215-feature_poe-v4-14-35bb4c23266c@bootlin.com>
	<ZdCjJcPbbBGYVtuo@pengutronix.de>
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

On Sat, 17 Feb 2024 13:14:29 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Thu, Feb 15, 2024 at 05:02:55PM +0100, Kory Maincent wrote:
> > Add the PD692x0 I2C Power Sourcing Equipment controller device tree
> > bindings documentation.
> >=20
> > This patch is sponsored by Dent Project <dentproject@linuxfoundation.or=
g>.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > --- =20
> ...
> > +        pse_pis {
> > +          #address-cells =3D <1>;
> > +          #size-cells =3D <0>;
> > +
> > +          pse_pi0: pse_pi@0 {
> > +            reg =3D <0>;
> > +            #pse-cells =3D <0>;
> > +            pairset-names =3D "alternative-a", "alternative-b";
> > +            pairsets =3D <&phys0>, <&phys1>;
> > +          };
> > +          pse_pi1: pse_pi@1 {
> > +            reg =3D <1>;
> > +            #pse-cells =3D <0>;
> > +            pairset-names =3D "alternative-a";
> > +            pairsets =3D <&phys2>; =20
>=20
> According to latest discussions, PSE PI nodes will need some
> additional, board specific, information:
> - this controller do not implements polarity switching, we need to know
>   what polarity is implemented on this board. The 802.3 spec provide not
>   really consistent names for polarity configurations:
>   - Alternative A MDI-X
>   - Alternative A MDI
>   - Alternative B X
>   - Alternative B S
>   The board may implement one of polarity configurations per alternative
>   or have additional helpers to switch them without using PSE
>   controller.
>   Even if specification explicitly say:
>   "The PD shall be implemented to be insensitive to the polarity of the p=
ower
>    supply and shall be able to operate per the PD Mode A column and the PD
>    Mode B column in Table 33=E2=80=9313"
>   it is possible to find reports like this:
>   https://community.ui.com/questions/M5-cant-take-reversed-power-polarity=
-/d834d9a8-579d-4f08-80b1-623806cc5070

Mmh not sure we want to support broken cases that does not follow the spec.
Should we?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

