Return-Path: <linux-kernel+bounces-68293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA4385784D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B101528AC63
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801F81CAA5;
	Fri, 16 Feb 2024 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="By0CxpoX"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA8F1BC31;
	Fri, 16 Feb 2024 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073919; cv=none; b=XyqaNTqcsYspObpD6dkmcI6EM4oiorhdVWWDW5eDzVWbqOYKDzdhdbeX1GGelDQr8xFipA56vl6HOxIBZwjN/ANFoRz8Jgq9uyVCGZfiwBLHWBllVXPvmh2OCjugmUXlpYiWSDlGL9i53o7nr4ZGVMJWlYmTcvJCiORy48PrgJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073919; c=relaxed/simple;
	bh=eEtVCkbL1zLpF1IuJ2P51hMpCC9ce5VcXTMVCrOozwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrQdu1C1L5UeDkSkqXKhhyDd+1aeQGqMa2B/xKd/0irGpSOLnu5JF5X4kd5wB/HYgD8pELSFxLq3paitNcyR/p8bn64JsCPCgQLOHmWw4c9SrPxoRlUDI5nZXoRPPgTKwBMxeHGX2KJbrJFPqOoLMLyKb3bGYFHvvDDOPl3OXZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=By0CxpoX; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C6FCFF802;
	Fri, 16 Feb 2024 08:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708073914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CiS06Ba9lRype48ky6kOoEGXIXSDOLtm/1ZqevNezdI=;
	b=By0CxpoXwlqrQa7QSSS1EBd0TrZt65BWnSkr4Wu2tU2J8bmvJds7j8FGPEV6b1V7qImpKR
	F47MRVR7q0Iqxj0rR9SfxvwRbMWAt77IIi3ZdAyLeYPGKSvH/ATcj17q1Y3MnzZWE9gbBN
	T0LKqYZkJYBc+nBHLaSEipLnuBUXcuNk1paQikZzX3SHUnr6JSgHl42X+XgcZKIG9rfKi+
	JwkzlGtlB1Ye+HU0cFWVy1VsZnmEpgroVBIdWJfHZfd229YJH0Z5WsH/1aXTiHr45w99oB
	MJRkqBFcgy5XzDMr28umn6GWNDUufWG0LElKab4rT3ygvO7y07Ffe+GFnWLY1g==
Date: Fri, 16 Feb 2024 09:58:29 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Luis Chamberlain
 <mcgrof@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jonathan
 Corbet <corbet@lwn.net>, netdev@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Russell King <linux@armlinux.org.uk>,
 devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dent Project
 <dentproject@linuxfoundation.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Frank Rowand <frowand.list@gmail.com>, Mark Brown <broonie@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Russ Weight
 <russ.weight@linux.dev>, Eric Dumazet <edumazet@google.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>
Subject: Re: [PATCH net-next v4 11/17] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Message-ID: <20240216095829.44b8797f@kmaincent-XPS-13-7390>
In-Reply-To: <20240216095616.3300aef3@kmaincent-XPS-13-7390>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
	<20240215-feature_poe-v4-11-35bb4c23266c@bootlin.com>
	<170802277529.323906.8697693998570251856.robh@kernel.org>
	<20240216095616.3300aef3@kmaincent-XPS-13-7390>
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

On Fri, 16 Feb 2024 09:56:16 +0100
K=C3=B6ry Maincent <kory.maincent@bootlin.com> wrote:

> On Thu, 15 Feb 2024 12:46:16 -0600
> Rob Herring <robh@kernel.org> wrote:
>=20
> > On Thu, 15 Feb 2024 17:02:52 +0100, Kory Maincent wrote: =20
> > > PSE PI setup may encompass multiple PSE controllers or auxiliary circ=
uits
> > > that collectively manage power delivery to one Ethernet port.
> > > Such configurations might support a range of PoE standards and require
> > > the capability to dynamically configure power delivery based on the
> > > operational mode (e.g., PoE2 versus PoE4) or specific requirements of
> > > connected devices. In these instances, a dedicated PSE PI node becomes
> > > essential for accurately documenting the system architecture. This no=
de
> > > would serve to detail the interactions between different PSE controll=
ers,
> > > the support for various PoE modes, and any additional logic required =
to
> > > coordinate power delivery across the network infrastructure.
> > >=20
> > > The old usage of "#pse-cells" is unsuficient as it carries only the P=
SE PI
> > > index information.
> > >=20
> > > This patch is sponsored by Dent Project <dentproject@linuxfoundation.=
org>.
> > >=20
> > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > ---
> > >=20
> > > Changes in v3:
> > > - New patch
> > >=20
> > > Changes in v4:
> > > - Remove $def
> > > - Fix pairset-names item list
> > > - Upgrade few properties description
> > > - Update the commit message
> > > ---
> > >  .../bindings/net/pse-pd/pse-controller.yaml        | 84
> > > +++++++++++++++++++++- 1 file changed, 81 insertions(+), 3 deletions(=
-)
> > >    =20
> >=20
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_chec=
k'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13): =20
>=20
> Weird, I don't get your errors even with dt-schema up to date.
> Maybe I have version mismatch in other tools.

Ah found it! I had yamllint not up to date.
Sorry for the noise.

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

