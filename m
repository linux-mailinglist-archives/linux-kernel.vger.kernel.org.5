Return-Path: <linux-kernel+bounces-8741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C129481BB9A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D01E1F25DBB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58177690A;
	Thu, 21 Dec 2023 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XVVT+V4W"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96C155E59;
	Thu, 21 Dec 2023 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 565394000E;
	Thu, 21 Dec 2023 16:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703175002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gkK4AF7fmwjohH95nu92SeMkvjofU4OWgRfUvJJb7ok=;
	b=XVVT+V4WzVh0CEE9G8BJkmzJRuMJPSQ0fYIRuhZoeEavFCYf+D5n6Zado9dytxztGLfT/8
	huvois90EhKVW2xd3vXCoMdFQ5S+qgQrr/Mii/p065Lwxne1Q86RVhkEsL4swDNJy74sQr
	yBwIl52k3LlbDMeiitvK8XKNJMj/HU0IHl8rGSVRWI8XnGhnpZYw29azFYWsCAXVFmF2C7
	jw0vR8P4X8tzsWNHYs9XRasAPRvSGf9ZBktAryAf3iX6/9FmDNl61Cm9ql7qKn3+dfgaYu
	8QbZph68Rk/3hSO4bYbGr2Nrp+FVsie2NdrLIwAKq3evuE7ED1D/d3eGVwqQdg==
Date: Thu, 21 Dec 2023 17:10:00 +0100
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
Message-ID: <20231221171000.45310167@kmaincent-XPS-13-7390>
In-Reply-To: <ffda1003-b752-402e-8e51-e2e24a840cff@sirena.org.uk>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
	<20231201-feature_poe-v2-8-56d8cac607fa@bootlin.com>
	<20231204225956.GG981228@pengutronix.de>
	<20231205064527.GJ981228@pengutronix.de>
	<4b96b8c8-7def-46e5-9c85-d9e925fb9251@sirena.org.uk>
	<20231205140203.GK981228@pengutronix.de>
	<88ed0c94-d052-4564-be0c-79a0f502eda8@sirena.org.uk>
	<20231221163610.47038996@kmaincent-XPS-13-7390>
	<ffda1003-b752-402e-8e51-e2e24a840cff@sirena.org.uk>
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

On Thu, 21 Dec 2023 15:43:21 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Dec 21, 2023 at 04:36:10PM +0100, K=C3=B6ry Maincent wrote:
> > Mark Brown <broonie@kernel.org> wrote: =20
>=20
> > > OK...  I mean, if they're not using the regulator framework I'm not s=
ure
> > > it has much impact - there are plenty of internal regulators in devic=
es
> > > already so it wouldn't be *too* unusual other than the fact that AFAI=
CT
> > > this is somewhat split between devices within the subsystem?  Neither=
 of
> > > the messages was super clear. =20
>=20
> > PSE Power Interface (which is kind of the RJ45 in PSE world) have simil=
ar
> > functionalities as regulators. We wondered if registering a regulator f=
or
> > each PSE PI (RJ45 ports) is a good idea. The point is that the PSE
> > controller driver will be its own regulator consumer.
> > I can't find any example in Linux with such a case of a driver being a
> > provider and a consumer of its own regulator. This idea of a regulator
> > biting its own tail seems weird to me. Maybe it is better to implement =
the
> > PSE functionalities even if they are like the regulator functionalities=
. =20
>=20
> Is it at all plausible that a system (perhaps an embedded one) might use
> something other than PSE?

Do you mean to supply power to a RJ45 port?
This can be done with a simple regulator. In that case we use the pse_regul=
ator
driver which is a regulator consumer.
I don't know about other cases. Oleksij do you?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

