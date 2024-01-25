Return-Path: <linux-kernel+bounces-38535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D730183C12A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3331F25DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2CB2DF87;
	Thu, 25 Jan 2024 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o5XXlMOw"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6089A1BDCA;
	Thu, 25 Jan 2024 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182870; cv=none; b=jPvCmJ+c2Xo2A3xDnM2NFZ1O4EgSTaAuWe21+xDEVZi2XJ3J3iDHpI/8B00GRKrJIFGGEENDiZ0nxnWn0/A+I6tQnNQc3z+vI5CDqN5WbRwexN6q/5nU64iobJHFxdwFm+HtEIrJIhYRs1lLPabjFYAL/CLAf+l/9KxO/ewPvhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182870; c=relaxed/simple;
	bh=qLBQpBKYCY+6mFC4CYuqbvZDM5MbkQCq7bgpDopi+xQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=WYKP6Y/WYDqBniaX5fDI+9KWTbPAoU+asdhqxcqMf+aBHm8/a7Egt4NMvNiC61LBvFikXeXTVGDkAgnaI4tNqawsh13F9z5UYE7MBUbKS+Y0LLHEs1AR4w/7Eij0RdQawI1raqXyc1NXnYa0qLmAxy+iMSek73PmRhhYlLDXeMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o5XXlMOw; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B64A1C0004;
	Thu, 25 Jan 2024 11:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706182861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVHbx5eUyj3Z29xXIxhFLS0ktredXkAOwoPPqAsQxm0=;
	b=o5XXlMOwTbcNwFB+isuoTQ4GH4wwq1BsvXaDsNGLXe8qJ2Bg+zSsF2VfWreyFAgPS6NBHX
	gwiI0RlTAbhcZ4H0ajg5P5RUUG6JqEfvcubIm9WMlcy0mYLHG8FYK61VaBQYhd2Ykl/Ld6
	xJ2FKy6dfB5PT/rZhrt8vPmxHSVxrrVmXQUt1QhQAOxikMxgxK3tcwoWVa2/OJHCNz8LB+
	ZLsowgvZ5HuINLNQObMSCimgMQU41VSTQ2R87Z4xgX/7FE9cshNKN3Ni5DpBXvABp6W25E
	AX1xZKWnk9okUyNvHTwc9xS7VgOBcUeMqlxNcLi7UVixXFWkOlCsvALOJOhe/Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jan 2024 12:40:59 +0100
Message-Id: <CYNRCGYA1PJ2.FYENLB4SRJWH@bootlin.com>
To: "Rob Herring" <robh@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v3 04/17] dt-bindings: soc: mobileye: add EyeQ5 OLB
 system controller
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
X-Mailer: aerc 0.15.2
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
 <20240123-mbly-clk-v3-4-392b010b8281@bootlin.com>
 <20240124151405.GA930997-robh@kernel.org>
 <CYN43TSPPPZ5.1VUA1CH95D8KJ@bootlin.com>
 <CYN4D0Z6600X.20W9VWX4BGNXX@bootlin.com>
 <CAL_JsqKHPdmafDvKCHZTNNzRAzq2Y34b2dqUXQD6WpE7z2k-jA@mail.gmail.com>
In-Reply-To: <CAL_JsqKHPdmafDvKCHZTNNzRAzq2Y34b2dqUXQD6WpE7z2k-jA@mail.gmail.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Wed Jan 24, 2024 at 8:22 PM CET, Rob Herring wrote:
> On Wed, Jan 24, 2024 at 11:40=E2=80=AFAM Th=C3=A9o Lebrun <theo.lebrun@bo=
otlin.com> wrote:
> > On Wed Jan 24, 2024 at 6:28 PM CET, Th=C3=A9o Lebrun wrote:
> > > On Wed Jan 24, 2024 at 4:14 PM CET, Rob Herring wrote:
> > > > On Tue, Jan 23, 2024 at 07:46:49PM +0100, Th=C3=A9o Lebrun wrote:

[...]

> > > > > +      };
> > > > > +
> > > > > +      pinctrl-b {
> > > > > +        compatible =3D "mobileye,eyeq5-b-pinctrl";
> > > > > +        #pinctrl-cells =3D <1>;
> > > > > +      };
> > > > > +    };
> > > >
> > > > This can all be simplified to:
> > > >
> > > > system-controller@e00000 {
> > > >     compatible =3D "mobileye,eyeq5-olb", "syscon";
> > > >     reg =3D <0xe00000 0x400>;
> > > >     #reset-cells =3D <2>;
> > > >     #clock-cells =3D <1>;
> > > >     clocks =3D <&xtal>;
> > > >     clock-names =3D "ref";
> > > >
> > > >     pins { ... };
> > > > };
> > > >
> > > > There is no need for sub nodes unless you have reusable blocks or e=
ach
> > > > block has its own resources in DT.
> > >
> > > That is right, and it does simplify the devicetree as you have shown.
> > > However, the split nodes gives the following advantages:
> > >
> > >  - Devicetree-wise, it allows for one alias per function.
> > >    `clocks =3D <&clocks EQ5C_PLL_CPU>` is surely more intuitive
> > >    than `clocks =3D <&olb EQ5C_PLL_CPU>;`. Same for reset.
>
> clocks: resets: pinctrl: system-controller@e00000 {
>
> > >
> > >  - It means an MFD driver must be implemented, adding between 100 to =
200
> > >    lines of boilerplate code to the kernel.
>
> From a binding perspective, not my problem... That's Linux details
> defining the binding. What about u-boot, BSD, future versions of Linux
> with different structure?
>
> I don't think an MFD is required here. A driver should be able to be
> both clock and reset provider. That's pretty common. pinctrl less so.

@Rob & @Krzysztof: following Krzysztof's question about the memory map
and adding ressources to the system-controller, I was wondering if the
following approach would be more suitable:

	olb: system-controller@e00000 {
		compatible =3D "mobileye,eyeq5-olb", "syscon", "simple-mfd";
		reg =3D <0 0xe00000 0x0 0x400>;
		#address-cells =3D <1>;
		#size-cells =3D <1>;

		clocks: clock-controller {
			compatible =3D "mobileye,eyeq5-clk";
			reg =3D <0x02c 0x7C>;
			#clock-cells =3D <1>;
			clocks =3D <&xtal>;
			clock-names =3D "ref";
		};

		reset: reset-controller {
			compatible =3D "mobileye,eyeq5-reset";
			reg =3D <0x004 0x08>, <0x120 0x04>, <0x200 0x34>;
			reg-names =3D "d0", "d2", "d1";
			#reset-cells =3D <2>;
		};

		pinctrl0: pinctrl-a {
			compatible =3D "mobileye,eyeq5-a-pinctrl";
			reg =3D <0x0B0 0x30>;
		};

		pinctrl1: pinctrl-b {
			compatible =3D "mobileye,eyeq5-b-pinctrl";
			reg =3D <0x0B0 0x30>;
		};
	};

It highlights that they are in fact separate controllers and not one
device. The common thing between them is that they were
custom-implemented by Mobileye and therefore all registers were put in
a single block.

Else we'll go with the driver that implements both the clock & reset
providers. It'd live in drivers/clk/ I believe, as this is where other
drivers of the sort live.

> > >  - It means one pinctrl device for the two banks. That addresses your
> > >    comment on [PATCH v3 10/17]. This is often done and would be doabl=
e
> > >    on this platform. However it means added logic to each individual
> > >    function of pinctrl-eyeq5.
>
> If it makes things easier, 2 'pins' sub-nodes is fine. That's just
> container nodes.
>
> > >    Overall it makes for less readable code, for code that already loo=
ks
> > >    more complex than it really is.
> > >
> > >    My initial non-public version of pinctrl-eyeq5 was using this meth=
od
> > >    (a device handling both banks) and I've leaned away from it.
> >
> > I had forgotten one other reason:
> >
> >  - Reusability does count for something. Other Mobileye platforms exist=
,
> >    and the system controller stuff is more complex on those. Multiple
> >    different OLB blocks, etc. But my understanding is that
> >    per-peripheral logic is reused across versions.
>
> IME, this stuff never stays exactly the same from chip to chip.

If it helps, I have access to the downstream vendor kernel to see how
things work there. It supports the next generation of Mobileye
hardware.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

