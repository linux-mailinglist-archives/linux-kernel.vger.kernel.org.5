Return-Path: <linux-kernel+bounces-37437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0038783B098
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42DF2B2BD25
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ECF1292D5;
	Wed, 24 Jan 2024 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Uhh3Cyxd"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12AA128395;
	Wed, 24 Jan 2024 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117505; cv=none; b=amH58QwokYuoIOcvHZnbH6jVb3NRFGKsDr0jDdrKQ3IdNSLHuE0szdh947d02h43Zr6+cywK3+FjNHd47KYCah3jWMG+7Za5VhbU+026DT2s/VEq4nEoUhFioxgndflG8G3CdkLPJcDwctPovXc6/QGjq+gsNeuJ93PI131vUd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117505; c=relaxed/simple;
	bh=LyF+uGG8rthtsLAGU6JwLDXQ2xY38jRfZIJ/nE/+i4U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=TLuypNU1rl9PKEDR2UPCVFSvic62fUgJcfk0aDwH1+Hdfvvm6WEq/cLCiUV0DQsJbDQbHw/tjN0YE1xiMy/WQjca2bVpInQsjOYyp7aON+Ebgh1GYwXzzSfkoQgnqpj2FhUuh/XBsNpYmRXvvTpK6HQcRxoTBXZvXxkqvKqjbhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Uhh3Cyxd; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AC82B240005;
	Wed, 24 Jan 2024 17:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706117500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAy7AHDWICCoITFYxoF5yUyISVpdkZcGB4MmMxueyRw=;
	b=Uhh3CyxddNadp3bKW19Bu/aCIlFIQepSAUY9rIKbk4eMy3+Hsd6tC2BF0Ckv+XHavn6JXm
	fRDgh7zMogbFUGlEnTsJaCM1frdY/nxfTYmpI88kf8dAvxgG8qmJkn294h+KYxlHXcpYzG
	9bYIDnIzycyT/FUtIJkoXPFXXJgk5KuPSXKJOybcNST3/sp5MOkX3S8LFqpkKIbfRTeuoP
	P5NkAOHxlPlC+d2kMsmmx6Bm+HRdQzaojyr4FGCEXjre6A77llIpsjUO8DnbeXnsd5damr
	VkrM0a0f+mzrn2F1tzM/bX95x99sl13FNSWD3aSaHsmy0PHd4yC5orLxj9ES6w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jan 2024 18:31:39 +0100
Message-Id: <CYN46F005M23.1Z11SN0VZF777@bootlin.com>
Cc: "Gregory CLEMENT" <gregory.clement@bootlin.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, "Philipp Zabel"
 <p.zabel@pengutronix.de>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, <linux-mips@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, <linux-gpio@vger.kernel.org>
To: "Rob Herring" <robh@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v3 10/17] pinctrl: eyeq5: add platform driver
X-Mailer: aerc 0.15.2
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
 <20240123-mbly-clk-v3-10-392b010b8281@bootlin.com>
 <20240124151949.GB930997-robh@kernel.org>
In-Reply-To: <20240124151949.GB930997-robh@kernel.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Wed Jan 24, 2024 at 4:19 PM CET, Rob Herring wrote:
> On Tue, Jan 23, 2024 at 07:46:55PM +0100, Th=C3=A9o Lebrun wrote:
> > Add the Mobileye EyeQ5 pin controller driver. It might grow to add late=
r
> > support of other platforms from Mobileye. It belongs to a syscon region
> > called OLB.
> >=20
> > Existing pins and their function live statically in the driver code
> > rather than in the devicetree, see compatible match data.
> >
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---

[...]

> > diff --git a/drivers/pinctrl/pinctrl-eyeq5.c b/drivers/pinctrl/pinctrl-=
eyeq5.c

[...]

> > +static const struct eq5p_match eq5p_match_a =3D {
> > +	.regs =3D {
> > +		[EQ5P_PD] =3D 0x0C0,
> > +		[EQ5P_PU] =3D 0x0C4,
> > +		[EQ5P_DS_LOW] =3D 0x0D0,
> > +		[EQ5P_DS_HIGH] =3D 0x0D4,
> > +		[EQ5P_IOCR] =3D 0x0B0,
> > +	},
> > +	.pins =3D eq5p_pins_a,
> > +	.npins =3D ARRAY_SIZE(eq5p_pins_a),
> > +	.funcs =3D eq5p_functions_a,
> > +	.nfuncs =3D ARRAY_SIZE(eq5p_functions_a),
> > +};
> > +
> > +static const struct eq5p_match eq5p_match_b =3D {
> > +	.regs =3D {
> > +		[EQ5P_PD] =3D 0x0C8,
> > +		[EQ5P_PU] =3D 0x0CC,
> > +		[EQ5P_DS_LOW] =3D 0x0D8,
> > +		[EQ5P_DS_HIGH] =3D 0x0DC,
> > +		[EQ5P_IOCR] =3D 0x0B4,
> > +	},
>
> These are all the same relative offsets, so you really only need to=20
> store the base offset.

Indeed, and I don't think I had even noticed. Thanks.

> The use of 2 compatibles is a bit questionable as the programming model=
=20
> appears to be the same and only which pins differ. Surely there are=20
> some other pinctrl drivers handling mutiple instances.

I can confirm the programming model is the same across both banks. I've
addressed your comment in my answer to yours on [PATCH v3 04/17].


Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

