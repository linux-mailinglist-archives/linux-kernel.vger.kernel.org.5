Return-Path: <linux-kernel+bounces-6638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 867EA819B57
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB261F21C3D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8715F1DA5D;
	Wed, 20 Dec 2023 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NNf55OlG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD830200AA;
	Wed, 20 Dec 2023 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 789211C0003;
	Wed, 20 Dec 2023 09:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703064312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sifAEnbUU3pMPnoP5SosHRqLSU4AUQ7u5NuQSR8RRrQ=;
	b=NNf55OlGNijrFkKbooo+fj5AZdCjP0uppiK69f7E4/akc3jrgMhXpD7iuXHUVjxQyPOTlT
	3MvLYvUi9kMm8ne/S0NP/KWGwlA1EWLknA8hLm7P4lKZTmZd80TGmkhlAe4VQHEMUc9Yk6
	M7N8BSXYauAkU3X5SHGayVEXOhX230m/R3lu+IK3U8YwVe5uddDLXPR4b2kWU8J/Ufi27x
	Zolq+Fj+p3rxkMWl4mlAE8tBZW/z2vCUd+HcS7RxlGVupzth0+4UEX1B+JRzYc4ZRmkvM7
	gaNghWspi3cpWcgS/cbPdR0ulyl13bsVL1AxvS8WwH6+tf5MqKlAEVVbYnXFBw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Dec 2023 10:25:11 +0100
Message-Id: <CXT1WVQ3YTND.ICHBOMMNR837@bootlin.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 1/4] dt-bindings: reset: mobileye,eyeq5-reset: add
 bindings
Cc: <linux-mips@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
X-Mailer: aerc 0.15.2
References: <20231218-mbly-reset-v1-0-b4688b916213@bootlin.com>
 <20231218-mbly-reset-v1-1-b4688b916213@bootlin.com>
 <c6d8c1f2-082d-43c1-8768-c0004d3fe386@linaro.org>
In-Reply-To: <c6d8c1f2-082d-43c1-8768-c0004d3fe386@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

Thanks for your comments. I have a question for one:

On Tue Dec 19, 2023 at 8:40 AM CET, Krzysztof Kozlowski wrote:
> On 18/12/2023 18:16, Th=C3=A9o Lebrun wrote:
> > Add DT-Schema bindings for the EyeQ5 reset controller.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  .../bindings/reset/mobileye,eyeq5-reset.yaml       | 69 ++++++++++++++=
+++++
> >  MAINTAINERS                                        |  2 +
> >  include/dt-bindings/reset/mobileye,eyeq5-reset.h   | 80 ++++++++++++++=
++++++++
> >  3 files changed, 151 insertions(+)
> >=20

[...]

> > diff --git a/include/dt-bindings/reset/mobileye,eyeq5-reset.h b/include=
/dt-bindings/reset/mobileye,eyeq5-reset.h
> > new file mode 100644
> > index 000000000000..ce59fe5409ac
> > --- /dev/null
> > +++ b/include/dt-bindings/reset/mobileye,eyeq5-reset.h
> > @@ -0,0 +1,80 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +/*
> > + * Copyright (C) 2023 Mobileye Vision Technologies Ltd.
> > + */
> > +
> > +#ifndef _DT_BINDINGS_RESET_MOBILEYE_EYEQ5_RESET_H
> > +#define _DT_BINDINGS_RESET_MOBILEYE_EYEQ5_RESET_H
> > +
> > +/* Domain 0 */
> > +
> > +/* 0..2 are reserved */
>
> No, they are not. IDs cannot be reserved. IDs start from 0 and are
> incremented by 1. Reserving an ID contradicts to entire point of that
> ID, so either drop entire file or make this proper IDs.

Those are hardware IDs. I get what you mean is that they should not leak
into bindings. That implies a mapping operation from bindings IDs to
understood-by-hardware IDs. Can you confirm this is what you expect?

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

