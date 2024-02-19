Return-Path: <linux-kernel+bounces-71522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6939385A699
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E98F281884
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DAB381D9;
	Mon, 19 Feb 2024 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DQrOLR+8"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFB73C498;
	Mon, 19 Feb 2024 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354512; cv=none; b=jNapdEJcLoe8HZ56BttbMPzHLq9r7l4VlHE+dSrvNZ8nR1vSU4otUH05p6ErdHP7t2I/qA/bD3qzAegAK+j4DfEZNZ4may4UG8e8S4lY8V9lTn8DoHxYkS6W2Xl3wMiLvOeckI7jN4Fg6ft4CskbcAbDAdUt9k4x8UAUeW0XlFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354512; c=relaxed/simple;
	bh=HfxplOuL4q2xzVZw2TcJFzzqRvoMGhVC0FGr2EalnFk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Unf5x23o891Jexzu68TLpUPK0XbPbeWWieGcndx0BSckvgMA2Nom//TXXLGKtNBaHuJcfwZvV1ZDEPP1Jt4GA0Hf1Uks35Fxi5IKTEoYa67sx87jH23YwpMC4UXi4PEp/2uIrjIJY8O9PEXLB9kcIuRPNtYwIeV9Jjs2HTdK8pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DQrOLR+8; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 010D64000D;
	Mon, 19 Feb 2024 14:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708354507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lC1i1N0UNT/0y8QCJSxQOgeE4oJ6ZMsxZMZkpa3P++M=;
	b=DQrOLR+8qm0bY5slL6AB6BEDjk5hcfQb6M/P+U/Yz4hAszxWqXlg7zof7bpVXHb6qdKWTw
	6pfod3Ipext1BnHghowE0GYoMePMiFejmBxRovogdYzKujHPwRJTvaYD4GiMPuznwvlM5d
	pMcNd+J3Wioq1qwLUEzVT7jK2i3EnL+7NCruF52BF1DyUMdPAcVo5Qcq0QI5DjLxMEEvKN
	BEfpk6D7byjJwG/neMbHlQIBSnc4srjB+vBb4puI2KRovGSUl7jQL0gw+WP+C9GOxUJTmS
	7Goniy3e24fzWP/GB2WPy1IT4jvkCxPUgtgtXZGZTXn/TH1g9AW4/UbqdWVcdg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Feb 2024 15:55:06 +0100
Message-Id: <CZ954Q11FWMI.39QMRYTRZAO1C@bootlin.com>
Subject: Re: [PATCH 02/23] dt-bindings: gpio: nomadik: add optional ngpios
 property
Cc: "Bartosz Golaszewski" <brgl@bgdev.pl>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Thomas Bogendoerfer"
 <tsbogend@alpha.franken.de>, <linux-gpio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mips@vger.kernel.org>,
 "Gregory CLEMENT" <gregory.clement@bootlin.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Linus Walleij" <linus.walleij@linaro.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
 <20240214-mbly-gpio-v1-2-f88c0ccf372b@bootlin.com>
 <CACRpkdawXwae7GKf4zOfVUJPLgLOeEX-8w5fbnr8O6FXuZHuaw@mail.gmail.com>
In-Reply-To: <CACRpkdawXwae7GKf4zOfVUJPLgLOeEX-8w5fbnr8O6FXuZHuaw@mail.gmail.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Mon Feb 19, 2024 at 3:50 PM CET, Linus Walleij wrote:
> On Wed, Feb 14, 2024 at 5:24=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boo=
tlin.com> wrote:
>
> > This GPIO controller can support a lesser number of GPIOs than 32.
> > Express that in devicetree using an optional, generic property.
> >
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yam=
l b/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
> > index a999908173d2..bbd23daed229 100644
> > --- a/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
> > +++ b/Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
> > @@ -50,6 +50,10 @@ properties:
> >    gpio-ranges:
> >      maxItems: 1
> >
> > +  ngpios:
> > +    minimum: 0
> > +    maximum: 32
>
> I can't help but wonder what good is ngpios =3D <0>; but OK.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

A min value is required, else it is equal to the max. There was no
reason to pick anything bigger than zero.

I'll admit it is not a setup I have tested so the driver might have
issues with the ngpios=3D=3D0 edge-case. Of course I do not expect anyone
to care.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

