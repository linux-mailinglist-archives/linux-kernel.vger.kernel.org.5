Return-Path: <linux-kernel+bounces-72840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC39185B945
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841EF1F21FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A4E63CAC;
	Tue, 20 Feb 2024 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Sy8Camel"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B335D744;
	Tue, 20 Feb 2024 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708425636; cv=none; b=Xq1MjvTeTXYrF6Zui3/zk1aHcsSPJ594+V1JUNcOhxmBE4oA0NLMRKCS1yPnoKEGnMeuRzTgqN1YAfND9p2PJIjUKFjlFnrcNvdmUSPEkoUCQJRGTK2ptuOwWdTDIL6U+0knYv1ZHKiQlpHqWEEsOdEBrQjq2Pl1WomazJSTtI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708425636; c=relaxed/simple;
	bh=wgEKPLuQhowA5lHKPh2DQgm6k4i0knYDD6ZvDFyTHNY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+SsyR+p0Dgw5zDUMR5T68Gn7eBkdgfFMqyL1AzCNooJKbcvxW2AkTwoA2V6dgZ6P/HT2KWgwZCTnFLSx3a/rM5gLbeah/pQXJk1tAS/uQZn/SSfOYWn+eocxn9SWLnT5XqJIeGmOk823UmlE6EQlqz+pqo2Ygm1g84T4aQTaYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Sy8Camel; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 59B2AFF809;
	Tue, 20 Feb 2024 10:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708425632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACLavhsVh+dltMk+C9yWyeUkFI9OfKzbdHBseD8xfZk=;
	b=Sy8CamelugK8+m7lSC73XuxpD6fIj3LuUTyJBBO9DRk18f/sfwdN0E9xLru1XiKcNZzn61
	pod84G04rz0E/l/ZlpJp3oYYnijEixCi1+ZYu4AvW1KRBKJ+MdOILZOpxP5j4X833UeW3S
	vv+G3kf3rm64TTQnpNhJ9tUU8jZXIl4jci89P1RWQP6T+pn3ijru+/IncV/XEHvvjR74cy
	SHeR1gzEx3AQ+QrYMdinFg1aZu/mbP5fRnIC9Rge5gkiExIDKmGH0n7B0t5Zri7v1ibyGF
	9o1oHPe4PrVklFfimFlDb79aYTbMD+v6q+Kjpw6Gm/yrbbhGbOWr7UHsFCh6NQ==
Date: Tue, 20 Feb 2024 11:40:29 +0100
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
Message-ID: <20240220114029.6b1a445d@kmaincent-XPS-13-7390>
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
>=20
>   Probably this kind of property is a good fit:
>   polarity-supported =3D "MDI-X", "MDI", "X", "S";

This property should be on the PD side.
Isn't it better to name it "polarity-provided" for each PSE PIs binding? Wh=
at
do you think?
We agreed that it is mainly for ethtool to show the polarity of a PI, right?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

