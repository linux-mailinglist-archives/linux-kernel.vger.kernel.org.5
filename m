Return-Path: <linux-kernel+bounces-8840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 526E381BCF2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DA82284DC2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33C96280D;
	Thu, 21 Dec 2023 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OcPzfVO6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FAE59923;
	Thu, 21 Dec 2023 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7071140002;
	Thu, 21 Dec 2023 17:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703179197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aw/lKS/opw7hiyt0Mph1iVo2GHwDT3KpcULUDaFPK4k=;
	b=OcPzfVO6FT/EaxegBvLaBlNxWxkuMT3RXYlOGRLRnYun34YObAaqaFJqHf1gafMS3STFjm
	wzM+z1sOGIBc2HoaR6Cj7UeEWNb2ykJyT679nSGpO+RCkvXFZjCQ0nIzvNVj286hHG4Wj3
	NdjHizwlywBRVBK+tHxSZkVbjLa3U4EHHzsiULqYdB1k7dCzzDxSxoj/6EVMUVTLwISDwE
	B5pCMkQq6moZkhSsBXhHryY42i/KM099RhCuCnWQzgwdHyKOn1Y1yRZVSuDuhxZfS2vHLs
	JtBKy37pG7QzxIoaffcc2nsZcZETRkGtQ932cDV2ZR/iW0rPTQcgy5pYZO13Bg==
Date: Thu, 21 Dec 2023 18:19:55 +0100
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
Message-ID: <20231221181955.422e676e@kmaincent-XPS-13-7390>
In-Reply-To: <501f671d-4e03-490b-a9d6-e1f39bb99115@sirena.org.uk>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
	<20231201-feature_poe-v2-8-56d8cac607fa@bootlin.com>
	<20231204225956.GG981228@pengutronix.de>
	<20231205064527.GJ981228@pengutronix.de>
	<4b96b8c8-7def-46e5-9c85-d9e925fb9251@sirena.org.uk>
	<20231205140203.GK981228@pengutronix.de>
	<88ed0c94-d052-4564-be0c-79a0f502eda8@sirena.org.uk>
	<20231221163610.47038996@kmaincent-XPS-13-7390>
	<ffda1003-b752-402e-8e51-e2e24a840cff@sirena.org.uk>
	<20231221171000.45310167@kmaincent-XPS-13-7390>
	<501f671d-4e03-490b-a9d6-e1f39bb99115@sirena.org.uk>
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

On Thu, 21 Dec 2023 16:20:10 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Dec 21, 2023 at 05:10:00PM +0100, K=C3=B6ry Maincent wrote:
> > Mark Brown <broonie@kernel.org> wrote: =20
> > > On Thu, Dec 21, 2023 at 04:36:10PM +0100, K=C3=B6ry Maincent wrote: =
=20
> > > > Mark Brown <broonie@kernel.org> wrote:   =20
>=20
> > > > > OK...  I mean, if they're not using the regulator framework I'm n=
ot
> > > > > sure it has much impact - there are plenty of internal regulators=
 in
> > > > > devices already so it wouldn't be *too* unusual other than the fa=
ct
> > > > > that AFAICT this is somewhat split between devices within the
> > > > > subsystem?  Neither of the messages was super clear.   =20
>=20
> > > > PSE Power Interface (which is kind of the RJ45 in PSE world) have
> > > > similar functionalities as regulators. We wondered if registering a
> > > > regulator for each PSE PI (RJ45 ports) is a good idea. The point is
> > > > that the PSE controller driver will be its own regulator consumer.
> > > > I can't find any example in Linux with such a case of a driver bein=
g a
> > > > provider and a consumer of its own regulator. This idea of a regula=
tor
> > > > biting its own tail seems weird to me. Maybe it is better to implem=
ent
> > > > the PSE functionalities even if they are like the regulator
> > > > functionalities.   =20
>=20
> > > Is it at all plausible that a system (perhaps an embedded one) might =
use
> > > something other than PSE? =20
>=20
> > Do you mean to supply power to a RJ45 port? =20
>=20
> Whatever it is that PSE does.
>=20
> > This can be done with a simple regulator. In that case we use the
> > pse_regulator driver which is a regulator consumer.
> > I don't know about other cases. Oleksij do you? =20
>=20
> In that case it sounds like you need the split to allow people to
> substitute in a non-PSE supply, and everything ought to be doing the
> consumer thing?

In case of non-PSE supply we would indeed have a wrapper like this
pse_regulator driver.=20

My question was about PSE:
A PSE may indeed need a regulator to work properly. In that case the PSE is
indeed a consumer.
The PSE may also power one or several RJ45 ports. The power capabilities of=
 each
port have some capabilities like regulators (enable/disable, power limit,
current and voltage status ...) and capabilities specific to PoE (class, ty=
pe
...).
These capabilities are modified by ethtool which will call ops within the P=
SE
driver.=20
As the power capabilities for each ports are kind of similar to regulator
capabilities we wonder if it is a good idea to register regulator for each =
ports
of a PSE to avoid rewriting the wheel.

So we will have PSE drivers which are regulators consumer for the chip,
regulator providers for all its ports and regulator consumers also for all =
its
ports. Is it clearer? Would that sound ok for you?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

