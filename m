Return-Path: <linux-kernel+bounces-40093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5722083DA2E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F641C22E29
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7B31A29C;
	Fri, 26 Jan 2024 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h8HtAbQy"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307B119470;
	Fri, 26 Jan 2024 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706272123; cv=none; b=b6Ru7UBa+pmmw1E2rJV7bGyxnW80fr2+mIQG/pIVQ0FImSPQ+Sfjj6emfV42M4vshS6WLyjd6/bk7mKlby+cQ7+8ecOBuEPeOu4o2uCuPneAgbVjCw/2ypfaEc8swtgAvs6S3BN0/yIXZwrbHADTBVQKWN0b3KnznnZfIEJ0NwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706272123; c=relaxed/simple;
	bh=Vj6ORDePH3R/SCmy1j34iKAMXNxYlW+3uZo0XKEH6zw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=X4HeJIntarT5VGT8sVcH0QPtHNEc5OUWwdb73mhbVv7XezHaauAXrIyn7VwO/R5I0OsYG2stUFWylttCdBdqygT73IiD80KeihGXveyrJ1ztlKuR5fVmGvFZ02fWkznuriwrLCxpbICcfUGk7En0q/EymviaMmB50oIzYxRBbPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h8HtAbQy; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5BA21240005;
	Fri, 26 Jan 2024 12:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706272111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1sT5spjLeLixo4sBJ2a2pVOX888Y+rV9WQeRdJoVXTc=;
	b=h8HtAbQyNTlxFbbz/RYzo39FybIHEds28Y39Hr7ZKTDH9cwjRUA9zG5aVdjXzFOek7LtUj
	J3PRKO/21ruNpjj3y8SJGloMCY89cQcVd8qYYh6j6NWeXiC9kQa4gq4KjYzXDsepXLBPR4
	D2xpjRYw1HEmIVCXD21F4azYovgAMa28k3grOxIKHeLj+QIDqZ9IZy1mZ56yz6JHNcTxI8
	fx0xlaWMXwRB94ZxfFVX0oZBdkOwiwP5QOwqR1Bz7ENobrRpzxBYXo4otuRWjoo7acks1a
	nmPvAHTU7XQM1l2Kwa1HgEkEkg7iX0RDwHIoaUdoOGF+rSMcmeJ0PwxYwf1hGw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Jan 2024 13:28:29 +0100
Message-Id: <CYOMZE0XIEIR.7Q1BDZCKX1E@bootlin.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Rob Herring"
 <robh@kernel.org>
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
 <CYNRCGYA1PJ2.FYENLB4SRJWH@bootlin.com>
 <8054e01d-0a1e-45b6-b62a-25303e8f4593@linaro.org>
In-Reply-To: <8054e01d-0a1e-45b6-b62a-25303e8f4593@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Fri Jan 26, 2024 at 12:52 PM CET, Krzysztof Kozlowski wrote:
> On 25/01/2024 12:40, Th=C3=A9o Lebrun wrote:
> > Hello,
> >=20
> > On Wed Jan 24, 2024 at 8:22 PM CET, Rob Herring wrote:
> >> On Wed, Jan 24, 2024 at 11:40=E2=80=AFAM Th=C3=A9o Lebrun <theo.lebrun=
@bootlin.com> wrote:
> >>> On Wed Jan 24, 2024 at 6:28 PM CET, Th=C3=A9o Lebrun wrote:
> >>>> On Wed Jan 24, 2024 at 4:14 PM CET, Rob Herring wrote:
> >>>>> On Tue, Jan 23, 2024 at 07:46:49PM +0100, Th=C3=A9o Lebrun wrote:
> >=20
> > [...]
> >=20
> >>>>>> +      };
> >>>>>> +
> >>>>>> +      pinctrl-b {
> >>>>>> +        compatible =3D "mobileye,eyeq5-b-pinctrl";
> >>>>>> +        #pinctrl-cells =3D <1>;
> >>>>>> +      };
> >>>>>> +    };
> >>>>>
> >>>>> This can all be simplified to:
> >>>>>
> >>>>> system-controller@e00000 {
> >>>>>     compatible =3D "mobileye,eyeq5-olb", "syscon";
> >>>>>     reg =3D <0xe00000 0x400>;
> >>>>>     #reset-cells =3D <2>;
> >>>>>     #clock-cells =3D <1>;
> >>>>>     clocks =3D <&xtal>;
> >>>>>     clock-names =3D "ref";
> >>>>>
> >>>>>     pins { ... };
> >>>>> };
> >>>>>
> >>>>> There is no need for sub nodes unless you have reusable blocks or e=
ach
> >>>>> block has its own resources in DT.
> >>>>
> >>>> That is right, and it does simplify the devicetree as you have shown=
.
> >>>> However, the split nodes gives the following advantages:
> >>>>
> >>>>  - Devicetree-wise, it allows for one alias per function.
> >>>>    `clocks =3D <&clocks EQ5C_PLL_CPU>` is surely more intuitive
> >>>>    than `clocks =3D <&olb EQ5C_PLL_CPU>;`. Same for reset.
> >>
> >> clocks: resets: pinctrl: system-controller@e00000 {
> >>
> >>>>
> >>>>  - It means an MFD driver must be implemented, adding between 100 to=
 200
> >>>>    lines of boilerplate code to the kernel.
> >>
> >> From a binding perspective, not my problem... That's Linux details
> >> defining the binding. What about u-boot, BSD, future versions of Linux
> >> with different structure?
> >>
> >> I don't think an MFD is required here. A driver should be able to be
> >> both clock and reset provider. That's pretty common. pinctrl less so.
> >=20
> > @Rob & @Krzysztof: following Krzysztof's question about the memory map
> > and adding ressources to the system-controller, I was wondering if the
> > following approach would be more suitable:
>
> More or less (missing ranges, unit addresses, lower-case hex etc).

Yeah the details are not really on point, it was only a proposal
highlighting a different way of dealing with the current situation.
Looks like it is suitable to you.

> > 	olb: system-controller@e00000 {
> > 		compatible =3D "mobileye,eyeq5-olb", "syscon", "simple-mfd";
> > 		reg =3D <0 0xe00000 0x0 0x400>;
> > 		#address-cells =3D <1>;
> > 		#size-cells =3D <1>;
> >=20
> > 		clocks: clock-controller {
> > 			compatible =3D "mobileye,eyeq5-clk";
> > 			reg =3D <0x02c 0x7C>;
> > 			#clock-cells =3D <1>;
> > 			clocks =3D <&xtal>;
> > 			clock-names =3D "ref";
> > 		};
> >=20
> > 		reset: reset-controller {
> > 			compatible =3D "mobileye,eyeq5-reset";
> > 			reg =3D <0x004 0x08>, <0x120 0x04>, <0x200 0x34>;
> > 			reg-names =3D "d0", "d2", "d1";
> > 			#reset-cells =3D <2>;
> > 		};
> >=20
> > 		pinctrl0: pinctrl-a {
> > 			compatible =3D "mobileye,eyeq5-a-pinctrl";
> > 			reg =3D <0x0B0 0x30>;
> > 		};
> >=20
> > 		pinctrl1: pinctrl-b {
> > 			compatible =3D "mobileye,eyeq5-b-pinctrl";
> > 			reg =3D <0x0B0 0x30>;
>
> Duplicate reg?

Yes, the mapping is intertwined. Else it could be three ressources per
pinctrl. Just really small ones.

 - 0xB0 mapping   A
 - 0xB4 mapping   B
 - 0xB8
 - 0xBC
 - 0xC0 pull-down A
 - 0xC4 pull-up   A
 - 0xC8 pull-down B
 - 0xCC pull-up   B
 - 0xD0 drive-strength lo A
 - 0xD4 drive-strength hi A
 - 0xD8 drive-strength lo B
 - 0xDC drive-strength hi B

0xB8 is unrelated (I2C speed & SPI CS). 0xBC is a hole.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

