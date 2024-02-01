Return-Path: <linux-kernel+bounces-47958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A16F184553B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68B31C22F22
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9776915CD48;
	Thu,  1 Feb 2024 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dNc3bIKO"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB0A15B989;
	Thu,  1 Feb 2024 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783046; cv=none; b=qa2b3zTochAmLGD8ENXCvrZAVqdK9FtRJv+90aQOCNNwQkcaAoHJWbjde6FmocZsC365rHwS2lBVgxgnZq9gRiS9GROPx8WUz7S24zObDsmGXbiEvhZG/ApRzWUBsiLcFFAP1AVuVJysubCLdUOgcwvUS3BXt9frZC4Wcp9X42s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783046; c=relaxed/simple;
	bh=0Q6Xto1WiMvLE/VQuYpSOMFy+OwWNRLXtUxjsUiPS20=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=fXdctvp0eP9jMiFwBSDoEMzj4ru0UvslnxxULaUArCn+tnUg6RvCYOYncKPB9vVvnkXkkLME2abCize56BHxnbo2nI0LajNJlShKL9zJ50JLgJ9z91QVRCwc8Cc6e7lwQPnSLBVwT3G519rJveHRH7zieUC9PLtsfxbkLn+Tyts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dNc3bIKO; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0DE9520002;
	Thu,  1 Feb 2024 10:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706783041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FewLjWlZG58wHVzMJTz9qAeznTJTLigBtSdDwMBeolo=;
	b=dNc3bIKOu/9LYn5OEE+Y+Wlb/Ixwon+TlSy1c2m5HjDJDOe79K5kDFwpT1L9LZ2gsVTD70
	24u5pWgkrBfhBSyzColLqs7a+rRdsp9L9+LOGrU25akeoEidWLY9WKd7xtHAuMrvmF7jzw
	ion6JiBfPo7T5IBb7uN9sEsGzQqY0p8LA/bU/A56V++CkRzUa0wNn+3WJe3IO3uDtRA4z5
	3TGpQZNhRuJazkrQkouTGaedoc2UXKD3Bk11EYh8DDdlZUYTJs8YCWfbPjDwDOEuSoyBCu
	BMgM2OxPWame5nmmJKzr+veHIWcBIkc4eLLBHODbAvQo/PIqsBPwM/vSHzeP5g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Feb 2024 11:23:59 +0100
Message-Id: <CYTO3C0G7083.1TVFK6PN35G1B@bootlin.com>
Cc: "Gregory CLEMENT" <gregory.clement@bootlin.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, "Philipp Zabel"
 <p.zabel@pengutronix.de>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, <linux-mips@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, <linux-gpio@vger.kernel.org>
To: "Linus Walleij" <linus.walleij@linaro.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v4 10/18] pinctrl: eyeq5: add platform driver
X-Mailer: aerc 0.15.2
References: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
 <20240131-mbly-clk-v4-10-bcd00510d6a0@bootlin.com>
 <CACRpkdZvj2E1zfSU1RGY2+_6sCCYxu=pbQ0yv+-bmTLGzEyFwg@mail.gmail.com>
In-Reply-To: <CACRpkdZvj2E1zfSU1RGY2+_6sCCYxu=pbQ0yv+-bmTLGzEyFwg@mail.gmail.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hi Linus,

On Wed Jan 31, 2024 at 9:55 PM CET, Linus Walleij wrote:
> Hi Theo,
>
> thanks for your patch!
>
> On Wed, Jan 31, 2024 at 5:27=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boo=
tlin.com> wrote:
>
> > Add the Mobileye EyeQ5 pin controller driver. It might grow to add late=
r
> > support of other platforms from Mobileye. It belongs to a syscon region
> > called OLB.
> >
> > Existing pins and their function live statically in the driver code
> > rather than in the devicetree, see compatible match data.
> >
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> The driver looks very nice and is using all standard features, I'm pretty=
 sure
> we can merge this soon.

It is useful to get some feedback that tells me your state of mind as
one involved maintainer. Thanks.

>
> > +static void eq5p_update_bits(const struct eq5p_pinctrl *pctrl,
> > +                            enum eq5p_bank bank, enum eq5p_regs reg,
> > +                            u32 mask, u32 val)
> > +{
> > +       void __iomem *ptr =3D pctrl->base + eq5p_regs[bank][reg];
> > +
> > +       writel((readl(ptr) & ~mask) | (val & mask), ptr);
> > +}
>
> This is in practice a reimplementation of regmap MMIO.
>
> Can't you just use regmap MMIO to access the banks then...?
>
> Maybe it doesn't add much here. I'm not sure.

Indeed, I went the minimalist route. You tell me if you'd prefer an MMIO
regmap.

I've not seen any helper to get a regmap based on a resource, targeting
by name. Is the expected procedure to acquire the resource then create
a regmap config then call devm_regmap_init_mmio()?

>
> > +static bool eq5p_readl_bit(const struct eq5p_pinctrl *pctrl,
>
> eq5p_test_bit() maybe? that describes better what the
> function does.

Good idea, thanks.

>
> > +                          enum eq5p_bank bank, enum eq5p_regs reg, int=
 bit)
> > +{
> > +       u32 val =3D readl(pctrl->base + eq5p_regs[bank][reg]);
> > +
> > +       return (val & BIT(bit)) !=3D 0;
> > +}
>
> Maybe add a check for bit > 31?

Will do. I like that sort of defensive programming. What behavior would
you expect?
 - WARN_ON(bit > 31) and return false?
 - Just return false?
 - Something else?

Actually looking at uses of eq5p_readl_bit() I'm thinking about a bug
that might be occuring wrt the second bank and that offset. I'll make
sure to fix it for next revision.

> > +static int eq5p_pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
> > +                                      unsigned int selector,
> > +                                      const unsigned int **pins,
> > +                                      unsigned int *num_pins)
> > +{
> > +       *pins =3D &pctldev->desc->pins[selector].number;
> > +       *num_pins =3D 1;
> > +       return 0;
> > +}
>
> One pin per group, also known as the "qualcomm trick".
>
> (It's fine.)

:-)

Thanks!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

