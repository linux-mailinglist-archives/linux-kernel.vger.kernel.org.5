Return-Path: <linux-kernel+bounces-65443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C0A854D25
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16ADC281DF2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30735FDAC;
	Wed, 14 Feb 2024 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H+jixvZO"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A23E5D732;
	Wed, 14 Feb 2024 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925326; cv=none; b=JtoTsTdAumfYRnnMRG69RMbcUpyCGFsR0zZ0ymXEgnRJVyWgSEORUs0mHFyBYOV8d15KlWCJ7sJHHsCXkzweoefZf7c1O5iXd9Cdlf/NfWZmjBDdpYE/NMwmczVBokJp/g3i1ibT7Z23moN6bLZ2AsTsRwRWLV5X69mfrZZRFe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925326; c=relaxed/simple;
	bh=fNbaUQKnlqEMDtnT9Negz1cAQM5I1BvNB5V3Wy7E/7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjNVqDn2lCBKFP6d5nSdGJ8c3S7dkAe3inll4YROP2R70oRgW1/Om9Pn/BRxR/IVwKTYkLuqdG3pRVnzvkgkIa9PvSTdkY7PE+5ISNC1aHEwA5HefGvUjhXoR300+UkbKXZ7Skg9gMJ2Ddw32l3+A6zGbYrpYsmmU8v7FJTiiQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H+jixvZO; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F1C5A1BF204;
	Wed, 14 Feb 2024 15:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707925314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Na5G4sxiicAdKoJQUQHlrk8NKd8DIbup+Qjfv3MfFOA=;
	b=H+jixvZObQoWqFarWziwlCexqzc1ILdE2JO0jQ/4k3ZZGF0oB2Nu0xg+QsZi0QTY4FMDAV
	7cLDqjnpiPOp/U6nJTMgD4YgyNsiOdkeEEgIRN89s7ajuOJKtKzY5hN5zQj5+XBzxJiTe/
	cTZaaxt2rJbDVQ5ujTtwcAop0eybMTcU6hQg9gjkPHPaotTzZC9QrpNGsX8AjJz+DUZal3
	WYUi8LAAPdd5jouNPy6+HxD5odAIvuk0Xn2zwgykX7FNlz92HnNEvO117cDGHPwVBMDbQK
	ZXRx7fEV0TaSw8qrAK3L+MqFM/hWC/EnmuxXzAZPCHe9lg7kMVbwRMno2IlzcA==
Date: Wed, 14 Feb 2024 16:41:50 +0100
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
Message-ID: <20240214164150.5be591d0@kmaincent-XPS-13-7390>
In-Reply-To: <20240214141310.119364c4@kmaincent-XPS-13-7390>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
	<20240208-feature_poe-v3-10-531d2674469e@bootlin.com>
	<20240209144349.GA3678044-robh@kernel.org>
	<20240214141310.119364c4@kmaincent-XPS-13-7390>
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

On Wed, 14 Feb 2024 14:13:10 +0100
K=C3=B6ry Maincent <kory.maincent@bootlin.com> wrote:

> Hello Rob,
>=20
> Thanks for your review!
>=20
> On Fri, 9 Feb 2024 14:43:49 +0000
> Rob Herring <robh@kernel.org> wrote:
>=20
> > On Thu, Feb 08, 2024 at 02:08:47PM +0100, Kory Maincent wrote: =20
> > > Before hand we set "#pse-cell" to 1 to define a PSE controller with  =
 =20
> >=20
> > #pse-cells
> >  =20
> > > several PIs (Power Interface). The drawback of this was that we could=
 not
> > > have any information on the PI except its number.   =20
> >=20
> > Then increase it to what you need. The whole point of #foo-cells is tha=
t=20
> > it is variable depending on what the provider needs.=20
> >  =20
> > > Add support for pse_pis and pse_pi node to be able to have more
> > > information on the PI like the number of pairset used and the pairset
> > > pinout.   =20
> >=20
> > Please explain the problem you are trying to solve, not your solution. =
I=20
> > don't understand what the problem is to provide any useful suggestions=
=20
> > on the design. =20
>=20
> Please see Oleksij's reply.
> Thank you Oleksij, for the documentation!!
>=20
> > >=20
> > > Sponsored-by: Dent Project <dentproject@linuxfoundation.org>   =20
> >=20
> > Is this a recognized tag? First I've seen it. =20
>=20
> This is not a standard tag but it has been used several times in the past.

Not so much used indeed:
$ git log --grep=3D"Sponsored" | grep Sponsored    =20
    Sponsored by:  The FreeBSD Foundation
    Sponsored by:  The FreeBSD Foundation
    Sponsored by:  The FreeBSD Foundation
    Sponsored by:  The FreeBSD Foundation
    Sponsored-by: Google Chromium project
    Sponsored: Google ChromeOS
    Sponsored: Google ChromeOS

Is it ok to keep it?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

