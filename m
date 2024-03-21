Return-Path: <linux-kernel+bounces-110322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8833C885D2F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ABE71F21C1E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732AB12C535;
	Thu, 21 Mar 2024 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JVQmafOY"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20715A934;
	Thu, 21 Mar 2024 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037730; cv=none; b=eB5Xdb9hzMHLn0Lt2iyXTCg1D9r51olHEnsvNDEdfK9DZ0w6eu5t0w7OS7Po03tL0nLOFWZH8QxS26W6COaYDQr7CtA1WSaWB6VTfhKbodC8rvwjvWSCiIaaU3W5Ppf8q37j3aHiALryuyU1ipVzKkm2j8u6og9JNDUhoQOKTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037730; c=relaxed/simple;
	bh=uw1fUO1KkmlnLMpuvD4Agl5GA1mZui2h2+xJbDsq49M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ug72Mj8gDb+Gj3F6fdnGilnxXHsm0i9cXjtOwU1v+Q1eruouXDPddyU+acYY8DGp4Zzl4GonrjnZ7BOE1weswWBjmZnBdID1zDq4FI3dHw03TJRYY+We1z71lWoIw+4i00ckGj40x2k9RrteYVi+NKhtEhhE4AXn2O6UdOGlA80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JVQmafOY; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 01D6640005;
	Thu, 21 Mar 2024 16:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711037726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ss8gXzP5nhwWey64bCP2DtTV4v6oGXUHUEc5COfyiuA=;
	b=JVQmafOYYWEykWC9frbdpTxxpEAxB6Fmsi4emB05jKPNrdIr0NnFWYXegP8Lg++svK4vVb
	0xWtbphUl+JSSrsM/LE/p1I9PFg8ZnZHVJqQCVxqyHjKiJmyvJ9x+GsevTt7FHkCypQjkm
	UYJbkFFOqwd/1dTM2ynNbkYtL3xiECxySYsjaIOE/joy4/3L2xefVz+e0p6zOHkAfs0ooe
	RxnCnDPCaP9RsU5eYpNAwzaPJgPwYC3EgMxndB4EwJanto9AWvYtH3C5GcrecWgN1I0oKB
	oqPpnTi//xPyrWpQMV8pUbhP6e3CPIwE745aCszXMVlRB2OoZPY+Obb8xBtw2g==
Date: Thu, 21 Mar 2024 17:15:24 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
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
Subject: Re: [PATCH net-next v5 13/17] net: pse-pd: Use regulator framework
 within PSE framework
Message-ID: <20240321171524.0b04bfcc@kmaincent-XPS-13-7390>
In-Reply-To: <ZeWi90H-B4XeSkFs@pengutronix.de>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
	<20240227-feature_poe-v5-13-28f0aa48246d@bootlin.com>
	<ZeObuKHkPN3tiWz_@pengutronix.de>
	<20240304102708.5bb5d95c@kmaincent-XPS-13-7390>
	<ZeWi90H-B4XeSkFs@pengutronix.de>
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

Hello Oleksij,

On Mon, 4 Mar 2024 11:31:19 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> >   =20
> > > Should be tested, but if, instead of "vin-supply", we will use
> > > "pse-supply" it will make most part of pse_regulator.c obsolete. =20
> >=20
> > Don't know, if it is done at the pse-pi node level it may not break
> > pse_regulator.c. Not sure about it. =20
>=20
> me too. Before your patch set, the regulator topology for PoDL PSE was
> following:
> power-source
>   fixed-regulator
>      PoDL_PSE-consumer
>=20
> Now it will be:
> power-source
>   fixed-regulator
>      PoDL_PSE-consumer
>        PSE-PI-provider
>          PSE-PI-consumer
>=20
> By porting porting PSE framework to regulator, probably it make sense to
> remove two levels of regulators?
> power-source
>   fixed-regulator
>      PSE-PI-consumer

Sorry, I forgot to reply about this.
This is specific to pse_regulator driver. Could we tackle this change in an=
other
patch series when the current patch series got applied?
Also I don't have the hardware to test it.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

