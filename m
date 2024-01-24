Return-Path: <linux-kernel+bounces-37448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EF683B030
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0404B1C22332
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AFF81AC1;
	Wed, 24 Jan 2024 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZkDgfCqn"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB9577F0D;
	Wed, 24 Jan 2024 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118022; cv=none; b=axkTB19tHfVHxKhgXS+olZDEIyEN/1tBxJgdxJMM/GYUgomchA4zmf3jReGzeEl1fLk8hpqjCttmcUK4b9J4s218XXN3hBFrEFCHD1WgDx5xKqKV2y0xS4JPFMIibukI12U11QW/Cnpo46TvhWf/DaTr4tDt5GNgmgmL4WwnPxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118022; c=relaxed/simple;
	bh=tnMxDBDZrolLa61sNFNNRToA24Ly+A39bcNO7Dae1ws=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=PbwOcndO68gEzMx0iknKMuUAe2pTu3FO3OfQzshEN+Pj2evBQ23pPfMZkKarQiiYlJn/auiXwi0dipzMd7LtO184IxTbMgm3dJYD2eT/FF4L/8gGFtqvfU0PGLuFAB4Nytz1MFyaq4mV7jGtLA/DQdhD87SlPaiqremNdOBhjsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZkDgfCqn; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9092C20002;
	Wed, 24 Jan 2024 17:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706118018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3Maf03SY5zgyI6f7z0wgBmsqcEvFSZSxYtZdnKCqrQ=;
	b=ZkDgfCqngzaSe1DzUlJBp+qY2wjuDx6IIfwDqC4ukQHJKMGcvVAlWhnGBVPMaSh40HjVZY
	y071i5ML7p2Nt+h/tThD1U4PGdeQ8lXdF7CGCoPgRqZHeq2FTJbUnxJzBAukoF2VDfTYhE
	LnperkGBzo88kwYf/o+v2nDE2SSYtZvKtHYY37effFs4AmMygdJqlg0Pkm/Icq4PnuH7Iv
	cPlYvZpoZlFoH1WC21FzjQXLuvvArXas7Sy1YXw0rh1M5ZNjMWXOwJSJXHDxyXvQGnDukD
	xS72Cnu1xndbyl/fnwYLOg0tg6us8TUDndufL/oGii1y/M6SlHbXmGvsk1jhRA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jan 2024 18:40:17 +0100
Message-Id: <CYN4D0Z6600X.20W9VWX4BGNXX@bootlin.com>
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
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Rob Herring"
 <robh@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v3 04/17] dt-bindings: soc: mobileye: add EyeQ5 OLB
 system controller
X-Mailer: aerc 0.15.2
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
 <20240123-mbly-clk-v3-4-392b010b8281@bootlin.com>
 <20240124151405.GA930997-robh@kernel.org>
 <CYN43TSPPPZ5.1VUA1CH95D8KJ@bootlin.com>
In-Reply-To: <CYN43TSPPPZ5.1VUA1CH95D8KJ@bootlin.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Wed Jan 24, 2024 at 6:28 PM CET, Th=C3=A9o Lebrun wrote:
> Hello,
>
> On Wed Jan 24, 2024 at 4:14 PM CET, Rob Herring wrote:
> > On Tue, Jan 23, 2024 at 07:46:49PM +0100, Th=C3=A9o Lebrun wrote:
> > > Add documentation to describe the "Other Logic Block" syscon.
> > >=20
> > > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > > ---
> > >  .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  | 77 ++++++++++++=
++++++++++
> > >  MAINTAINERS                                        |  1 +
> > >  2 files changed, 78 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/soc/mobileye/mobileye,=
eyeq5-olb.yaml b/Documentation/devicetree/bindings/soc/mobileye/mobileye,ey=
eq5-olb.yaml
> > > new file mode 100644
> > > index 000000000000..031ef6a532c1
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-o=
lb.yaml
> > > @@ -0,0 +1,77 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb.y=
aml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Mobileye EyeQ5 SoC system controller
> > > +
> > > +maintainers:
> > > +  - Gr=C3=A9gory Clement <gregory.clement@bootlin.com>
> > > +  - Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > > +  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> > > +
> > > +description:
> > > +  OLB ("Other Logic Block") is a hardware block grouping smaller blo=
cks. Clocks,
> > > +  resets, pinctrl are being handled from here.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - const: mobileye,eyeq5-olb
> > > +      - const: syscon
> > > +      - const: simple-mfd
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clock-controller:
> > > +    $ref: /schemas/clock/mobileye,eyeq5-clk.yaml#
> > > +    type: object
> > > +
> > > +  reset-controller:
> > > +    $ref: /schemas/reset/mobileye,eyeq5-reset.yaml#
> > > +    type: object
> > > +
> > > +  pinctrl-a:
> > > +    $ref: /schemas/pinctrl/mobileye,eyeq5-pinctrl.yaml#
> > > +    type: object
> > > +
> > > +  pinctrl-b:
> > > +    $ref: /schemas/pinctrl/mobileye,eyeq5-pinctrl.yaml#
> > > +    type: object
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    system-controller@e00000 {
> > > +      compatible =3D "mobileye,eyeq5-olb", "syscon", "simple-mfd";
> > > +      reg =3D <0xe00000 0x400>;
> > > +
> > > +      clock-controller {
> > > +        compatible =3D "mobileye,eyeq5-clk";
> > > +        #clock-cells =3D <1>;
> > > +        clocks =3D <&xtal>;
> > > +        clock-names =3D "ref";
> > > +      };
> > > +
> > > +      reset-controller {
> > > +        compatible =3D "mobileye,eyeq5-reset";
> > > +        #reset-cells =3D <2>;
> > > +      };
> > > +
> > > +      pinctrl-a {
> > > +        compatible =3D "mobileye,eyeq5-a-pinctrl";
> > > +        #pinctrl-cells =3D <1>;
> >
> > Sure you need this? Generally only pinctrl-single uses this.
>
> You are completely right, it is useless. I naively expected it in the
> same vein as other subsystems.
>
> >
> > > +      };
> > > +
> > > +      pinctrl-b {
> > > +        compatible =3D "mobileye,eyeq5-b-pinctrl";
> > > +        #pinctrl-cells =3D <1>;
> > > +      };
> > > +    };
> >
> > This can all be simplified to:
> >
> > system-controller@e00000 {
> >     compatible =3D "mobileye,eyeq5-olb", "syscon";
> >     reg =3D <0xe00000 0x400>;
> >     #reset-cells =3D <2>;
> >     #clock-cells =3D <1>;
> >     clocks =3D <&xtal>;
> >     clock-names =3D "ref";
> >
> >     pins { ... };
> > };
> >
> > There is no need for sub nodes unless you have reusable blocks or each=
=20
> > block has its own resources in DT.
>
> That is right, and it does simplify the devicetree as you have shown.
> However, the split nodes gives the following advantages:
>
>  - Devicetree-wise, it allows for one alias per function.
>    `clocks =3D <&clocks EQ5C_PLL_CPU>` is surely more intuitive
>    than `clocks =3D <&olb EQ5C_PLL_CPU>;`. Same for reset.
>
>  - It means an MFD driver must be implemented, adding between 100 to 200
>    lines of boilerplate code to the kernel.
>
>  - It means one pinctrl device for the two banks. That addresses your
>    comment on [PATCH v3 10/17]. This is often done and would be doable
>    on this platform. However it means added logic to each individual
>    function of pinctrl-eyeq5.
>
>    Overall it makes for less readable code, for code that already looks
>    more complex than it really is.
>
>    My initial non-public version of pinctrl-eyeq5 was using this method
>    (a device handling both banks) and I've leaned away from it.

I had forgotten one other reason:

 - Reusability does count for something. Other Mobileye platforms exist,
   and the system controller stuff is more complex on those. Multiple
   different OLB blocks, etc. But my understanding is that
   per-peripheral logic is reused across versions.

>
> Those are all minor, but I don't have the feeling a few lines and nodes
> less in devicetree compensate for those.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


