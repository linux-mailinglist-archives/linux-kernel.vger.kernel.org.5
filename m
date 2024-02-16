Return-Path: <linux-kernel+bounces-68464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B101C857A89
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5237B1F248AF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4288C524B8;
	Fri, 16 Feb 2024 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Doj1wFhy"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF4A535BE;
	Fri, 16 Feb 2024 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708080192; cv=none; b=o6DoIXdIBKugqLeMLBTapIJZzNDA21477NQJYQvdO5f2QIxX9dOmHyCWlt8ZpulSsub0mHNAtQ/FHwmdHq5Ej7uElLds9yg6iYor/jFNUS36TjwRY/Xs7Ar1dTH/XsBUjM2mn/g0Fmd7KS+qzdGhoMw7auGY3jwZzFuyu0Jw2MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708080192; c=relaxed/simple;
	bh=NDGRynr8itqPzytqBynygn6jKjpyhOuuhynu6UE3ZMA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=MYDuu4q7g9YGfKhSeQYlYyn20v/3C4WllPoj648gICr9+HvW5vvodHMRDG2ub+pBBxXxDBpJCUgTVDflNdWSX6QGBn7D0HvrDYq2NtWAlTd3lZllK+OSV1WAYYmRWf6cV5QCEtfpKzntUcz1YGgRRTRH0yyiq9LQUGvGbsoNN/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Doj1wFhy; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 39E471BF203;
	Fri, 16 Feb 2024 10:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708080182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hB/XHwobNHN18Xz1hYNZwwfr1UUQv4BZ9ABlvaG/lLY=;
	b=Doj1wFhyFBqmQV6VY50wGFAmDMdOhlEgNW7YwVrTfkUkB/ojt2RPOLJQoIMSaKGUR+1/Xa
	SIkHMZsP+S8Nz033lwoSrILNsK94pjdrlI07PVpbrJr45fcr7bLGlXOFEeW3LmnlBqCsms
	bFjjzpf4NN3YqVv1zRJklEU5I0U9/EedlFOs5FFHerMCFMKYh3edjLeZ0hBp1RBdChk66a
	t9PeKza2wyGyIFruGiO4lsXC41KrR0E0bX8HlclSzm3UiwAryDEKSugiOnyLioLluZVq+9
	cOkCTybu6D6IAlH6hhGLxPlF+Bcdl7C6U2iKVpD9NdND5cZyKwGN3Fij38gc8g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Feb 2024 11:43:00 +0100
Message-Id: <CZ6FW2H4BPEL.D5W7U5H7THDH@bootlin.com>
Subject: Re: [PATCH 05/23] gpio: nomadik: extract GPIO platform driver from
 drivers/pinctrl/nomadik/
Cc: <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mips@vger.kernel.org>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Philipp Zabel" <p.zabel@pengutronix.de>, "Linus Walleij"
 <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>, "Rob
 Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
 <20240214-mbly-gpio-v1-5-f88c0ccf372b@bootlin.com>
 <e031566a85ae0da0ee71dffba5d87c6414ef83e1.camel@pengutronix.de>
In-Reply-To: <e031566a85ae0da0ee71dffba5d87c6414ef83e1.camel@pengutronix.de>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Feb 15, 2024 at 11:03 AM CET, Philipp Zabel wrote:
> On Mi, 2024-02-14 at 17:23 +0100, Th=C3=A9o Lebrun wrote:
> [...]
> > diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
> > new file mode 100644
> > index 000000000000..e39477e1a58f
> > --- /dev/null
> > +++ b/drivers/gpio/gpio-nomadik.c
> > @@ -0,0 +1,660 @@
> [...]
> > +static int nmk_gpio_probe(struct platform_device *dev)
> > +{
> [...]
> > +	ret =3D gpiochip_add_data(chip, nmk_chip);
>
> Use devm_gpiochip_add_data() to cleanup on unbind, before nmk_chip goes
> away. Or make the driver un-unbindable via suppress_bind_attrs. In that
> case you could drop devm_ prefixes everywhere for consistency.

Disabling unbind sounds like the best option. Will do so in next
revision, in a separate patch to keep this one as close of a copy-paste
as possible.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

