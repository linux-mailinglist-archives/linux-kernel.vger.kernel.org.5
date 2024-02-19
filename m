Return-Path: <linux-kernel+bounces-71480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C85485A5F1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF54A1C211E5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6561E890;
	Mon, 19 Feb 2024 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U/s9u0OS"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090121DFE8;
	Mon, 19 Feb 2024 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353076; cv=none; b=tbQQDAvZ/fUmFIU2xrOVxxll6M2zabcs/jOeJ/JcU5SxpExFgYdURmpAPZ2qkWBM07gIKYz5gKfEDSVE4E7LbYwalxY9ijEEFRc2VYAaHjTIi2rcfgJ/Bjbt4NPWHnXgkVhxKP+4uH/RMxFvZ2y6PPInr7H84NkJ6dg41yGznII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353076; c=relaxed/simple;
	bh=kCExhr7TI0B5O0k5tOI7V68szWpBz5xEoI5w1iUnUEw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBeWwuyMX1gUxDV5jgs3x3jUSUCgxCf+Px3+uiUbph0SeHtR7JeB/2vcxagua89/CbJ8LzLt9lOTBJdM6n5t4QUVRpwlGwNDl8EtxPxbMY0HwYXod1qfiFHxk8GMFlDNbI1NriDt+vHbP2x+69lbb4mVTFAsscjIFOIhO3kYB7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U/s9u0OS; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E40C1BF206;
	Mon, 19 Feb 2024 14:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708353072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9h+OMrQCyhqHA7MCzpM0VlZZ6CwDDvEtHV/K94gz0WI=;
	b=U/s9u0OSp/Z7R2FUlgP0FV/wusIZrolBvVwUWtIO4FxFiOGCiQTMv/8XnFtg5S6NqyIWls
	zwzzQt1XSmq6BRxzXIZWCrE1Mn+nR6GJE1CpM4Mfjbsrwlq300d3xNFDglvo2dif8rchV+
	bE75OAq8FhfduMysPMIFJJ77YSaynAKfxd30GD+0b1cOrBQB86OKMpZWQHr476u4qsYGlJ
	ovL1G1kBYbNNJ1RkO0CvO2wOA5A1TXYCrqfB7sVXJbIaECwhCshHM8fD7VprqiA6yqQD3U
	zfE7HMT1o0+nr1XRTfOqoHSTV535PlLcOm6JIluUhlpI+4bFOxV+0O0VJ9/3QA==
Date: Mon, 19 Feb 2024 15:31:06 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight
 <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, Dent Project
 <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v3 14/17] dt-bindings: net: pse-pd: Add
 bindings for PD692x0 PSE controller
Message-ID: <20240219153106.19e83213@kmaincent-XPS-13-7390>
In-Reply-To: <Zc8TAojumif1irE-@pengutronix.de>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
	<20240208-feature_poe-v3-14-531d2674469e@bootlin.com>
	<20240209145727.GA3702230-robh@kernel.org>
	<ZciUQqjM4Z8Tc6Db@pengutronix.de>
	<618be4b1-c52c-4b8f-8818-1e4150867cad@lunn.ch>
	<Zc3IrO_MXIdLXnEL@pengutronix.de>
	<65099b67-b7dc-4d78-ba42-d550aae2c31e@lunn.ch>
	<Zc8TAojumif1irE-@pengutronix.de>
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

On Fri, 16 Feb 2024 08:47:14 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >
> > So, either somebody needs to understand 1000BaseT and can say the
> > proposed binding works, or we explicitly document the binding is
> > limited to 10BaseT and 100BaseT. =20
>=20
> I asked the internet and found the answer: Some PSE/PD implementations
> are not compatible with 1000BaseT.
>=20
> See Figure 33=E2=80=934=E2=80=9410BASE-T/100BASE-TX Endpoint PSE location=
 overview.
> Alternative B show a variant where power is injected directly to pairs
> without using magnetics as it is done for Alternative A (phantom
> delivery - over magnetics).
>=20
> So, we have following variants of 2 pairs PoE:
> +---------+---------------+-------------------+---------------------+----=
----------------+
> | Variant | Alternative   | Polarity          | Power Feeding Type  |
> Compatibility with | |         | (a/b)         | (Direct/Reverse)  |
> (Direct/Phantom)    | 1000BaseT          |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> | 1       | a             | Direct            | Phantom             | Yes
>            |
> +---------+---------------+-------------------+---------------------+----=
----------------+
> | 2       | a             | Reverse           | Phantom             | Yes
>            |
> +---------+---------------+-------------------+---------------------+----=
----------------+
> | 3       | b             | Direct            | Phantom             | Yes
>            |
> +---------+---------------+-------------------+---------------------+----=
----------------+
> | 4       | b             | Reverse           | Phantom             | Yes
>            |
> +---------+---------------+-------------------+---------------------+----=
----------------+
> | 5       | b             | Direct            | Direct              | No
>            |
> +---------+---------------+-------------------+---------------------+----=
----------------+
> | 6       | b             | Reverse           | Direct              | No
>            |
> +---------+---------------+-------------------+---------------------+----=
----------------+

Maybe we could remove the polarity column on this table as it does not bring
more information. It is also already explained on the PI pinout alternatives
table.

Also we should document that a 4pairs PSE supporting only 10/100BaseT (which
mean no magnetics on pinout AlternativeB) may not be compatible with a 4pai=
rs
1GBaseT PD.

> For this case, it will be good if systems knows supported modes, so user
> can get this information  directly. For example with ethtool

Yes.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

