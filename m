Return-Path: <linux-kernel+bounces-8678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AFD81BAFA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E99D1C2451A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0141E539F0;
	Thu, 21 Dec 2023 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X/Xz+CqP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AB953A1C;
	Thu, 21 Dec 2023 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7DADC1BF20A;
	Thu, 21 Dec 2023 15:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703172973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qih4URF6rrbQJOr6/rCfK90mkaE3j03/vJR1RzN9ObQ=;
	b=X/Xz+CqPOdunaGw7bvYkZ5aRHYFvdVD+OXsd/tSQfSOuFvqesHloinh7kqzKp1E8nrXMtF
	Muc5f5onNiea/qpkIvsKlQptW/EoZEErHWPtLCBD4pvseQ/V+m2cAaHkqOH44kbOZ0ELEJ
	MIUnWt3/iUBKSMDJJ6LgUiXQ0SXtHijZUa+41AcIlogzuOBr+duepnfPg2Z0YFkwDWTXt6
	lBuVt2thCnx/s+TTf8OPy28e3fGKUMLvZqeO+DWZ+oUdiclrF/l+uw3KltprYCQ/X7D0mH
	yt2uckt4zAbF1Iba9A8SYadiNcrBvEXPjgs8/GIgJ2UXSQVfBRrEvFXGQzNS/A==
Date: Thu, 21 Dec 2023 16:36:10 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight
 <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, Dent Project
 <dentproject@linuxfoundation.org>, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH net-next v2 8/8] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <20231221163610.47038996@kmaincent-XPS-13-7390>
In-Reply-To: <88ed0c94-d052-4564-be0c-79a0f502eda8@sirena.org.uk>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
	<20231201-feature_poe-v2-8-56d8cac607fa@bootlin.com>
	<20231204225956.GG981228@pengutronix.de>
	<20231205064527.GJ981228@pengutronix.de>
	<4b96b8c8-7def-46e5-9c85-d9e925fb9251@sirena.org.uk>
	<20231205140203.GK981228@pengutronix.de>
	<88ed0c94-d052-4564-be0c-79a0f502eda8@sirena.org.uk>
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

On Tue, 5 Dec 2023 15:57:28 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Tue, Dec 05, 2023 at 03:02:03PM +0100, Oleksij Rempel wrote:
> > On Tue, Dec 05, 2023 at 12:55:18PM +0000, Mark Brown wrote: =20
> > > On Tue, Dec 05, 2023 at 07:45:27AM +0100, Oleksij Rempel wrote: =20
>=20
> > > > CC regulator devs here too. =20
>=20
> > > Again, I'm not sure what if any question there is? =20
>=20
> > PSE is kind of PMIC for Ethernet ports. I assume, it is good to let you
> > know at least about existence drivers. =20
>=20
> OK...  I mean, if they're not using the regulator framework I'm not sure
> it has much impact - there are plenty of internal regulators in devices
> already so it wouldn't be *too* unusual other than the fact that AFAICT
> this is somewhat split between devices within the subsystem?  Neither of
> the messages was super clear.

PSE Power Interface (which is kind of the RJ45 in PSE world) have similar
functionalities as regulators. We wondered if registering a regulator for
each PSE PI (RJ45 ports) is a good idea. The point is that the PSE controll=
er
driver will be its own regulator consumer.
I can't find any example in Linux with such a case of a driver being a prov=
ider
and a consumer of its own regulator. This idea of a regulator biting its own
tail seems weird to me. Maybe it is better to implement the PSE functionali=
ties
even if they are like the regulator functionalities.

What do you think?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

