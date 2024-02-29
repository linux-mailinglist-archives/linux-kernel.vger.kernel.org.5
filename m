Return-Path: <linux-kernel+bounces-87043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C46B86CE96
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C374AB29F2D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DAE7826C;
	Thu, 29 Feb 2024 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V+FmJchc"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307D675804;
	Thu, 29 Feb 2024 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222255; cv=none; b=PIlZLxL7YvwHcGE7XKJ8Ht6sXefjuozFFg+qM9BcjER0wCUuANufYVxXjH4SUTiSp4Ph6tnx18VGKcCbTPauSvKMivZdL0shH/hwgOWa65JC1X8TMyyfE8EmWY6OFTcwqbKM6rKwXQCi9FXo4J/2/4D5NwTLM+ezifnv9RUqeSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222255; c=relaxed/simple;
	bh=sFsNQxS7brdxwEsklayRsbufGneKwtsUTYwjiHMc954=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=ufD/p4fxF4uf1FU5E8MbxXtqXWHhWnO2sII0bhL51+JUrfOs0xdRjU1u3ayHhE4s+cHXyWIkdWuOn/m09c76C0iiGIvRDDNNg32xF6PoygjQZBnFd95kYPkMmg0yTveLJUJHU1hdPWUgicapD1vdJADyLz0ao+jPs6G8umRAmiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V+FmJchc; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A4972E000B;
	Thu, 29 Feb 2024 15:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709222249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WY80iH9fh79QQiobQmVPwLIwtM3+k6Frks10vv068uo=;
	b=V+FmJchcpAF5sSRylTCJK8wTE8z/XZBs15KZpFk7BIav4fWPIVumCP4FjKFWsv0OPi0TXc
	wfGdEvMXbUZjPMXXy9sQwMfLykQU/AkzyKyF76+n6lsI7lC3DubaHVTKZ2fhekMCGgI+Fj
	IGuZIXOfpXKDEKN/8hZ9uwDSPMtaotTlXj1hzQz2ygNp5/TkgKkd/NOjBb3TBQEZ8iWgBj
	EWfqKfc7ZsLruaaPMryNf9ON1wmZjijDm5vXv03TqAmPLGO/b4x57smhxx+lIeZjnlmTHz
	wnIIUl4uxWcwg8JjXLt+b+9f1NQiSf+quBMRKQc3wkDo12g2L7MC5mt31eWU+g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Feb 2024 16:57:28 +0100
Message-Id: <CZHOPWYS6IBQ.RFB7JANYC769@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v8 03/10] clk: eyeq5: add platform driver, and init
 routine at of_clk_init()
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
 <20240227-mbly-clk-v8-3-c57fbda7664a@bootlin.com>
 <Zd4X3NnBoEl0wu2H@smile.fi.intel.com>
 <CZGSB2O8P572.28HK6WFT43N6S@bootlin.com>
 <ZeBnX2upNRN0xXH4@smile.fi.intel.com>
 <CZHMSNWMH4KJ.2J6ZMWKMSZYH2@bootlin.com>
 <ZeCbvgWY6x1o17Kq@smile.fi.intel.com>
 <CZHOCV35A23S.14HL07U73EH6X@bootlin.com>
 <ZeCnZ0Py62EyKI9Z@smile.fi.intel.com>
In-Reply-To: <ZeCnZ0Py62EyKI9Z@smile.fi.intel.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Feb 29, 2024 at 4:48 PM CET, Andy Shevchenko wrote:
> On Thu, Feb 29, 2024 at 04:40:25PM +0100, Th=C3=A9o Lebrun wrote:
> > On Thu Feb 29, 2024 at 3:59 PM CET, Andy Shevchenko wrote:
> > > On Thu, Feb 29, 2024 at 03:27:01PM +0100, Th=C3=A9o Lebrun wrote:
> > > > On Wed, Feb 28, 2024 at 03:33:29PM +0100, Th=C3=A9o Lebrun wrote:
> > > > > On Tue Feb 27, 2024 at 6:11 PM CET, Andy Shevchenko wrote:
> > > > > > On Tue, Feb 27, 2024 at 03:55:24PM +0100, Th=C3=A9o Lebrun wrot=
e:
>
> [...]
>
> > > > > > > > +	u32		reg;	/* next 8 bytes are r0 and r1 */
> > > > > > >
> > > > > > > Not sure this comments gives any clarification to a mere read=
er of the code.
> > > > > > > Perhaps you want to name this as reg64 (at least it will show=
 that you have
> > > > > > > 8 bytes, but I have no clue what is the semantic relationship=
 between r0 and
> > > > > > > r1, it's quite cryptic to me). Or maybe it should be reg_0_1?
> > > > > >=20
> > > > > > Clocks are defined by two 32-bit registers. We only store the f=
irst
> > > > > > register offset because they always follow each other.
> > > > >
> > > > > > I like the reg64 name and will remove the comment. This straigh=
t forward
> > > > > > code is found in the rest of the code, I don't think it is anyt=
hing
> > > > > > hard to understand (ie does not need a comment):
> > > > > >=20
> > > > > > 	u32 r0 =3D readl(base_plls + pll->reg);
> > > > > > 	u32 r1 =3D readl(base_plls + pll->reg + sizeof(r0));
> > > > >
> > > > > Btw, why readq()/writeq() (with probably the inclusion of io-64-n=
onatomic-lo-hi.h)
> > > > > can be used in this case? It will be much better overall and be a=
ligned with
> > > > > reg64 name.
> > > >=20
> > > > The doc talks in terms of 32-bit registers. I do not see a reason t=
o
> > > > work in 64-bit. If we get a 64-bit value that we need to split we n=
eed
> > > > to think about the endianness of our platform, which makes things m=
ore
> > > > complex than just reading both values independently.
> > >
> > > 1) Would be nice to test on the real HW to confirm it doesn't accept =
64-bit IO.
> >=20
> > Just tested, it works. No error on the memory bus. And checked assembly
> > generated was a single 64-bit instructions.
> >=20
> > It might not work on other hardware revisions though. I can't remember
> > if memory bus is changing across them.
> >=20
> > > 2) Still I see a benefit from using lo_hi_readq() and friends directl=
y.
> >=20
> > So it is:
> >=20
> > 	u32 r0 =3D readl(base_plls + pll->reg64);
> > 	u32 r1 =3D readl(base_plls + pll->reg64 + sizeof(r0));
> >=20
> > vs:
> >=20
> > 	u64 r =3D lo_hi_readq(base_plls + pll->regs64);
>
> > 	u32 r0 =3D r;
> > 	u32 r1 =3D r >> 32;
>
> It depends to the semantics of these two. How hard do they coupled to eac=
h
> other semantically? I.o.w. can they always be considered as 64-bit regist=
er
> with the respective bitfields? (And note FIELD_GET() here is your friend.=
)

OLB (the memory region) has always been described as a list of 32-bit
registers. The semantics lean in the camp of two readl().

> > One is straight forward, the other uses an obscure helper that code
> > readers must understand and follows that with bit manipulation.
>
> [...]
>
> > There are two errors to handle, that makes a mess out of the code.
> > Having a little bit of repetition but straight forward code is nicer in
> > my opinion. At least we tried!
>
> Yes! Perhaps you can add a couple of words into commit message to explain
> this detail of implementation (that code in two parts is not so identical
> to be easily deduplicated).

Yes, will do. I get why from a reader's point-of-view it looks like
duplicate code.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


