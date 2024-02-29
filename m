Return-Path: <linux-kernel+bounces-86684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EFC86C8FE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FAA41C22B56
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC037D06A;
	Thu, 29 Feb 2024 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IH3OE8JS"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D197CF36;
	Thu, 29 Feb 2024 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709209102; cv=none; b=tBkGdz+23UYNkmnG1XCugqBW0GwbJd7/zjAjzZql39izeMApN2iyA0WmXuYhBAavGIRT+jHii94Nt5f4YgDEhdlx6FmRk+fATjwSECMSBKpmqYr7Y4Gy0lFRwQsv7TcX9zRpQl2s1KxbnjcCUHVlGRQDo+UQR5NdeHe+LkzMX74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709209102; c=relaxed/simple;
	bh=8Eelp2TJHh8fMmaYaoIG0d+mIvZQwLFJthLx9DhOBLg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=Ip0fJ9t44tOw2MzgmEqROg+gRRP2vS436OH4V3AtPLe7zuJFLywMEyTK9k9YWk6ZeiAONJxMZYx6gRYMOqOTSNYFDB0yZC+U3UwzPw2s9ga4UhDEf+rOjn4mk3b4NYn58QTQ0o+PDhIWRP3Zm0afdq4LI70zoSur3fe5nf2x1bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IH3OE8JS; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C64F31BF20A;
	Thu, 29 Feb 2024 12:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709209089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rivbcy22OyT/FZEzxvNP0xJkQRC61DIMcbwv6BnP3xA=;
	b=IH3OE8JSAMKn+Ls6dirQEB0XuO2Y6HcF9GIJPUJoHwnocUzLz7Ez1whX6c3fgNaTzwz6W4
	NSefEg/uekQgeRhfCZOQuVsTXCrbS7xgiAJOy+RYmvY7f6a9uIQEqInD1RHHK2nt9Xyt2p
	SsJSO4zrN3IwB38ObMZ5Ynu417CznPxN2vQKd12LMYDmAI8bA2laQiALFUAWDRJaS/BPHE
	Z/4VCACO8BMVmQZy0aJND/4zDvsgv43KhtR0EwjOo0tDwGEM0zmptCMTQsd8pCuT07bfxq
	MBzMHCxh6oJLiIaPh2Q4jxl9Hxlnd12EtMfGqhaT5GVGLJShK8gIFkdxHpgoEw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Feb 2024 13:18:08 +0100
Message-Id: <CZHK1ZCSROM5.X4WYN7SAZJTH@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v8 04/10] reset: eyeq5: add platform driver
Cc: "Gregory CLEMENT" <gregory.clement@bootlin.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, "Linus Walleij"
 <linus.walleij@linaro.org>, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?=
 <rafal@milecki.pl>, "Philipp Zabel" <p.zabel@pengutronix.de>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>,
 <linux-mips@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, <linux-gpio@vger.kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
X-Mailer: aerc 0.15.2
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
 <20240227-mbly-clk-v8-4-c57fbda7664a@bootlin.com>
 <Zd4bbCsY54XEnvJM@smile.fi.intel.com>
 <CZGVIWR4H4DE.3M5H3H99X0QPT@bootlin.com>
 <ZeBo4N204gLO0eUd@smile.fi.intel.com>
In-Reply-To: <ZeBo4N204gLO0eUd@smile.fi.intel.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Feb 29, 2024 at 12:22 PM CET, Andy Shevchenko wrote:
> On Wed, Feb 28, 2024 at 06:04:47PM +0100, Th=C3=A9o Lebrun wrote:
> > On Tue Feb 27, 2024 at 6:27 PM CET, Andy Shevchenko wrote:
> > > On Tue, Feb 27, 2024 at 03:55:25PM +0100, Th=C3=A9o Lebrun wrote:
>
> ...
>
> > > > +	u32 offset =3D id & GENMASK(7, 0);
> > > > +	u32 domain =3D id >> 8;
> > >
> > > Perhaps
> > >
> > > 	u32 offset =3D (id & GENMASK(7, 0)) >> 0;
> > > 	u32 domain =3D (id & GENMASK(31, 8)) >> 8;
> > >
> > > for better understanding the split?
> >=20
> > Do the additional zero-bit-shift and GENMASK() help understanding? My
> > brain needs time to parse them to then notice they do nothing and
> > simplify the code in my head, back to the original version.
>
> In my opinion yes, as you exactly showing the split.
> But. The better is to use FIELD_GET().

I'll go with the FIELD_GET() option!

[...]

>
> > > > +	priv->rcdev.of_node =3D np;
> > >
> > > It's better to use device_set_node().
> >=20
> > I don't see how device_set_node() can help? It works on struct device
> > pointers. Here priv->rcdev is a reset_controller_dev struct. There are
> > no users of device_set_node() in drivers/reset/.
>
> No users doesn't mean it's good. The API is relatively "new" and takes
> care of two things:
> 1) it uses agnostic interface;
> 2) it doesn't require any firmware node direct dereference.
>
> The 2) is most important here as allows us to refactor (firmware node) co=
de
> in the future.

I think I get the point of device_set_node(). I still do not understand
how it could help me fill the ->of_node field in a reset_controller_dev
structure?

Should I be using device_set_node() to fill the struct device pointer
and the reset subsystem, by some magic, will pick this up and use it
for its own of_node field? I've not seen any magic/code doing that.

[...]

> > > > +		priv->rcdev.nr_resets +=3D __builtin_popcount(eq5r_valid_masks[i=
]);
> > >
> > > Please, use corresponding hweightXX() API.
> >
> > Noted. I did not find this keyword even though I searched quite a bit
> > for it. "popcount" sounds more logical to me. :-)
>
> Hmm... But it's fundamental, it's called Hamming weight.
> https://en.wikipedia.org/wiki/Hamming_weight

Makes sense now. I've always called it population count following the
name of the matching instruction on x86 (and I believe other ISAs). TIL.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


