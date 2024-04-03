Return-Path: <linux-kernel+bounces-129449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC67D896B1F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30588B26F8E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B401350CC;
	Wed,  3 Apr 2024 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MIFYDCnC"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3903C133981;
	Wed,  3 Apr 2024 09:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712137523; cv=none; b=revYx73bFHG6NUsVg20iJi69OdtiVGxWJsrBKiwJkOYVBMgvrywCuTw3+cHwfBk63r3AxDvCELLOdg6OL/shLwX9Mf1rYCx/5iHxb4oKhW8Ri/jM+/4uu4uXZ+xrfafC5Zj4ISXTS9VBTHY+j6xVPZmAweB8ygM1tL6ATyum2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712137523; c=relaxed/simple;
	bh=khov9Dp62C4KhM05qzfYcKQ1sM7iWgxjKaoqHOebAjM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBneePIZ2axmBfQEYOoQTxOIttTAwXidWQDErSede6VXAffpLQ34AR55sTnYttaXrP2bd3T8hfC+NmHX98ugbcIxMfXJ7TMOvZn3xBCi4wOhJz2geYb82Ly/vzMy3VS/3kgY6uxe5K75+2xfS9Zb2F2/+Y//MakgJD/XUHxg+p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MIFYDCnC; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E9A70C0007;
	Wed,  3 Apr 2024 09:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712137512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZzKh48tvuliOzzYgV6gXv3vmW8JbdbuTP9eBYehyiwU=;
	b=MIFYDCnCuty2+ygrZEP+g/xbSCtznUvE+sv8lvM+z+Rm1JVrKsMOVkHYMaNqYuCSGo2VzM
	cy6M12I9CA35W9tbez64ShUeEAYEaGm5i6tEoa8GR25m2FNnCOyZHoZfPbcj3IXNJgKV+L
	tkZvmzipjGfX+qZCjAGMBL7E2gH62HaNkOaiFj+fEwvukjMPHFcdYaHnq0T5vbuJNHyBuD
	+ybVfhOOXjBFmuo3jDJBw1PAVxAJZWQv5iEUTzSpmX9/wbjpDf0vJYuHVaCCQojbrxXIYa
	z87szIJCk5lIoXs4A3iKS3Xcc6D/9YoyHLLifKWjnnZXxdHPA9EHXOJ3ybSCIw==
Date: Wed, 3 Apr 2024 11:45:09 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v6 17/17] net: pse-pd: Add TI TPS23881 PSE
 controller driver
Message-ID: <20240403114509.46eeaa21@kmaincent-XPS-13-7390>
In-Reply-To: <8186fea6-c1f4-403b-b717-83c1dd3ad826@lunn.ch>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
	<20240326-feature_poe-v6-17-c1011b6ea1cb@bootlin.com>
	<6bbc6b86-3947-4679-ac0b-fde50129d0f6@lunn.ch>
	<20240329155657.7939ac4b@kmaincent-XPS-13-7390>
	<8186fea6-c1f4-403b-b717-83c1dd3ad826@lunn.ch>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Sat, 30 Mar 2024 15:52:49 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Fri, Mar 29, 2024 at 03:56:57PM +0100, Kory Maincent wrote:
> > On Thu, 28 Mar 2024 17:24:17 +0100
> > Andrew Lunn <andrew@lunn.ch> wrote:
> >  =20
> > > > +static int tps23881_flash_fw_part(struct i2c_client *client,
> > > > +				  const char *fw_name,
> > > > +				  const struct tps23881_fw_conf
> > > > *fw_conf)   =20
> > >=20
> > > Does the device actually have flash? Or is this just downloading to
> > > SRAM? =20
> >=20
> > It is downloading to SRAM. =20
>=20
> So maybe rename these functions.

Ok, I will.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

