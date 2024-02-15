Return-Path: <linux-kernel+bounces-67086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB7C85660D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE0F1C22575
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01426132C0E;
	Thu, 15 Feb 2024 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jfnLugIp"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09D969DF0;
	Thu, 15 Feb 2024 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708007636; cv=none; b=d7wpQ1dLefc89cOlagZQmLk8IaujAsmSoENKCsbagI1NYbQ/c+vbHfOvqkWKlY7Gsr3SB5K/QZ8amJgFvnEWd/I8u+exDmB4ZzbxrovH7d40Kk2gHbwUYP1N4tCaGWf2gFUpZ2huBgWhC3cKAI0qmNqw6vMQS/7ytAlsVzwHar8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708007636; c=relaxed/simple;
	bh=x/C4JrMOvi9rCj9I7QPAKYQAw03CTw9sUHduKSKVXmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ucoBl5hC0jW3oQiw9j1OBOAKIaEA7rg6uG3bd+EO0icp92WljNqTHXP3Rqnx4BMeEpixmz+mvc4OcJGlQDFEgkK4SnD4VIzHwTDrB1QMASk8aLxsoDKrwY5WwqEnH+FpeX9skBZVBqkrUSQkDxxz07xCeZLVpWN9vYND+t6kaeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jfnLugIp; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 489A520002;
	Thu, 15 Feb 2024 14:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708007625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cdrzonxR0aohlaO272Q7MZrzcpjlQwtAuBm+FlVa2Zk=;
	b=jfnLugIptfivZ7YdFpbIK7v/kS9Z5wDYbgN9JxdaFDSBKmFMzZioHeQjDfhB5IjWglucM4
	Sqi0DuPcWmiN2jFy9WL98/pukDSqt8ZnZqlmQPyHcJCMqdvrB6agaUXCwMmTrc78hEyMwR
	p9myXchCskW8S842CIb2DvZ0LqUh0ajdZvF7nyrRcMa4ZvEQomuyZsfYidc7uzMkZY7DK8
	Cokymg3a2p/uT6FDqq/dh8gIDEao+tPQ4fDkDmU+TbMEqdjlRv/3Heh3apBXZUyneqM0pH
	hM1waaf3aoSIhHIIFMwRm7PFg+qencCW54aQTPgtMaM6Kzg9nxdcDA7ca8g+Pw==
Date: Thu, 15 Feb 2024 15:33:42 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis
 Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v3 10/17] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Message-ID: <20240215153342.0be61fe0@kmaincent-XPS-13-7390>
In-Reply-To: <377d2e0f-dc0c-400f-9c10-f4a158146ceb@lunn.ch>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
	<20240208-feature_poe-v3-10-531d2674469e@bootlin.com>
	<20240209144349.GA3678044-robh@kernel.org>
	<20240214141310.119364c4@kmaincent-XPS-13-7390>
	<20240214164150.5be591d0@kmaincent-XPS-13-7390>
	<20240215135130.GA4139246-robh@kernel.org>
	<377d2e0f-dc0c-400f-9c10-f4a158146ceb@lunn.ch>
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

On Thu, 15 Feb 2024 15:01:08 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > > Not so much used indeed:
> > > $ git log --grep=3D"Sponsored" | grep Sponsored    =20
> > >     Sponsored by:  The FreeBSD Foundation
> > >     Sponsored by:  The FreeBSD Foundation
> > >     Sponsored by:  The FreeBSD Foundation
> > >     Sponsored by:  The FreeBSD Foundation
> > >     Sponsored-by: Google Chromium project
> > >     Sponsored: Google ChromeOS
> > >     Sponsored: Google ChromeOS
> > >=20
> > > Is it ok to keep it? =20
> >=20
> > IMO, its use should be documented like other tags, or it should not be=
=20
> > used. Just write a sentence to the same effect. =20
>=20
> Or include a patch to document it :-)

It seems someone has already tried to send a patch to add this tag but it h=
as
not been accepted due to maintainers extra works bring by the tag:
https://lore.kernel.org/lkml/20230817220957.41582-1-giulio.benetti@benettie=
ngineering.com/

I will replace it by a small sentence then.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

