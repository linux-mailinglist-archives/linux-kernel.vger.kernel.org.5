Return-Path: <linux-kernel+bounces-37591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB39683B23B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A651CB210AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B1B132C17;
	Wed, 24 Jan 2024 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fy35ADhL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAD612DDA3;
	Wed, 24 Jan 2024 19:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706124136; cv=none; b=N+ypgQhNUku38D4ETIk7aidlJMVuqktNWDsSNGZiCd3nzLqEk/OHz1iVFV2Wgwp5ba7kXHXztgBRI8SyxNh3nC24UvQptQ3oz07c9dnR9NcizTdGyl8MZdtIapy5a6hxYcTNChz9ZsrsEOBGqvanFaOXSJb9UMlQ09u3W2RCImU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706124136; c=relaxed/simple;
	bh=uH+CUA/u3AiE/fk+eEUo0I3JlkRu1EljnKxjL+zf/0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVJgt0BsarN+jf0pjy/VMPVNJrheqtl7WiCgCkizjvF7gnB7/NhPXH4B8ZVs/nIX7Dy1vpbro0A/PIfMxfRhdLPBYUor4LyRZHxMlgOzG++rkJuSyR9ZFbJfTDPertBK9szXpNNlaWxgo5NLVxiGPtGrU3zv5mqUpnyzxaBwR5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fy35ADhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82172C433F1;
	Wed, 24 Jan 2024 19:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706124135;
	bh=uH+CUA/u3AiE/fk+eEUo0I3JlkRu1EljnKxjL+zf/0g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fy35ADhLnBzLwKoxfCU12gYtO9Tys2fMGphCl7k31W3VozdzgRWh0sy9n1+JkvlGP
	 MSs5GssIsPUJvM6AQy+SKld24GkD+eOfg1/E6z9Z1jgDjsEKxmH29QljL2Eq/L0t97
	 ByAL9SsrilIqg/tSc/6FRoEpmP7+LiGjcF5L6SbiEW5Xf63d/7CMMjJkKG6xId4+NB
	 X26wE5hthok9JYLr/tb4dfI+GnU2Fm/kz1rfGMW+8gAH8J5CX+OpMHNrcMX00mtaDE
	 iR+z2KzHpYPDZCNL4lizVOllEqtZOuKTgAZkduWpr2xc/w3wphigPJa/3K6Ek2CvSh
	 us1Qm2vzBMg7Q==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5101055a16fso1397381e87.2;
        Wed, 24 Jan 2024 11:22:15 -0800 (PST)
X-Gm-Message-State: AOJu0YyMwUwnxuvY2lUt8/zDrZDhjKMCHhQP+QpxsEx5nr7Q+tlZNOMY
	xpB1Mw/X+rsIfMbCB7AGaE4tTSNqJcW3I06LQw0F+h0gKm6hphok9phuPvIPhKQtouBZNaAfJF7
	tfyhG3cWTHvPq2wb2w7NAeyx8ww==
X-Google-Smtp-Source: AGHT+IGISGd0GQ2utGwepbZzCZhxVRdvSqdyfgwaWIf1k4UFEOeSMyMK+4bettb6sRfMDYkloV5B4K94Fc0vs4zl3D0=
X-Received: by 2002:a05:6512:3a8a:b0:50e:6beb:7b15 with SMTP id
 q10-20020a0565123a8a00b0050e6beb7b15mr4359787lfu.1.1706124133659; Wed, 24 Jan
 2024 11:22:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
 <20240123-mbly-clk-v3-4-392b010b8281@bootlin.com> <20240124151405.GA930997-robh@kernel.org>
 <CYN43TSPPPZ5.1VUA1CH95D8KJ@bootlin.com> <CYN4D0Z6600X.20W9VWX4BGNXX@bootlin.com>
In-Reply-To: <CYN4D0Z6600X.20W9VWX4BGNXX@bootlin.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 24 Jan 2024 13:22:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKHPdmafDvKCHZTNNzRAzq2Y34b2dqUXQD6WpE7z2k-jA@mail.gmail.com>
Message-ID: <CAL_JsqKHPdmafDvKCHZTNNzRAzq2Y34b2dqUXQD6WpE7z2k-jA@mail.gmail.com>
Subject: Re: [PATCH v3 04/17] dt-bindings: soc: mobileye: add EyeQ5 OLB system controller
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Linus Walleij <linus.walleij@linaro.org>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, linux-mips@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 11:40=E2=80=AFAM Th=C3=A9o Lebrun <theo.lebrun@boot=
lin.com> wrote:
>
> Hello,
>
> On Wed Jan 24, 2024 at 6:28 PM CET, Th=C3=A9o Lebrun wrote:
> > Hello,
> >
> > On Wed Jan 24, 2024 at 4:14 PM CET, Rob Herring wrote:
> > > On Tue, Jan 23, 2024 at 07:46:49PM +0100, Th=C3=A9o Lebrun wrote:
> > > > Add documentation to describe the "Other Logic Block" syscon.
> > > >
> > > > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > > > ---
> > > >  .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  | 77 ++++++++++=
++++++++++++
> > > >  MAINTAINERS                                        |  1 +
> > > >  2 files changed, 78 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/soc/mobileye/mobiley=
e,eyeq5-olb.yaml b/Documentation/devicetree/bindings/soc/mobileye/mobileye,=
eyeq5-olb.yaml
> > > > new file mode 100644
> > > > index 000000000000..031ef6a532c1
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5=
-olb.yaml
> > > > @@ -0,0 +1,77 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb=
yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Mobileye EyeQ5 SoC system controller
> > > > +
> > > > +maintainers:
> > > > +  - Gr=C3=A9gory Clement <gregory.clement@bootlin.com>
> > > > +  - Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > > > +  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> > > > +
> > > > +description:
> > > > +  OLB ("Other Logic Block") is a hardware block grouping smaller b=
locks. Clocks,
> > > > +  resets, pinctrl are being handled from here.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    items:
> > > > +      - const: mobileye,eyeq5-olb
> > > > +      - const: syscon
> > > > +      - const: simple-mfd
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  clock-controller:
> > > > +    $ref: /schemas/clock/mobileye,eyeq5-clk.yaml#
> > > > +    type: object
> > > > +
> > > > +  reset-controller:
> > > > +    $ref: /schemas/reset/mobileye,eyeq5-reset.yaml#
> > > > +    type: object
> > > > +
> > > > +  pinctrl-a:
> > > > +    $ref: /schemas/pinctrl/mobileye,eyeq5-pinctrl.yaml#
> > > > +    type: object
> > > > +
> > > > +  pinctrl-b:
> > > > +    $ref: /schemas/pinctrl/mobileye,eyeq5-pinctrl.yaml#
> > > > +    type: object
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    system-controller@e00000 {
> > > > +      compatible =3D "mobileye,eyeq5-olb", "syscon", "simple-mfd";
> > > > +      reg =3D <0xe00000 0x400>;
> > > > +
> > > > +      clock-controller {
> > > > +        compatible =3D "mobileye,eyeq5-clk";
> > > > +        #clock-cells =3D <1>;
> > > > +        clocks =3D <&xtal>;
> > > > +        clock-names =3D "ref";
> > > > +      };
> > > > +
> > > > +      reset-controller {
> > > > +        compatible =3D "mobileye,eyeq5-reset";
> > > > +        #reset-cells =3D <2>;
> > > > +      };
> > > > +
> > > > +      pinctrl-a {
> > > > +        compatible =3D "mobileye,eyeq5-a-pinctrl";
> > > > +        #pinctrl-cells =3D <1>;
> > >
> > > Sure you need this? Generally only pinctrl-single uses this.
> >
> > You are completely right, it is useless. I naively expected it in the
> > same vein as other subsystems.
> >
> > >
> > > > +      };
> > > > +
> > > > +      pinctrl-b {
> > > > +        compatible =3D "mobileye,eyeq5-b-pinctrl";
> > > > +        #pinctrl-cells =3D <1>;
> > > > +      };
> > > > +    };
> > >
> > > This can all be simplified to:
> > >
> > > system-controller@e00000 {
> > >     compatible =3D "mobileye,eyeq5-olb", "syscon";
> > >     reg =3D <0xe00000 0x400>;
> > >     #reset-cells =3D <2>;
> > >     #clock-cells =3D <1>;
> > >     clocks =3D <&xtal>;
> > >     clock-names =3D "ref";
> > >
> > >     pins { ... };
> > > };
> > >
> > > There is no need for sub nodes unless you have reusable blocks or eac=
h
> > > block has its own resources in DT.
> >
> > That is right, and it does simplify the devicetree as you have shown.
> > However, the split nodes gives the following advantages:
> >
> >  - Devicetree-wise, it allows for one alias per function.
> >    `clocks =3D <&clocks EQ5C_PLL_CPU>` is surely more intuitive
> >    than `clocks =3D <&olb EQ5C_PLL_CPU>;`. Same for reset.

clocks: resets: pinctrl: system-controller@e00000 {

> >
> >  - It means an MFD driver must be implemented, adding between 100 to 20=
0
> >    lines of boilerplate code to the kernel.

From a binding perspective, not my problem... That's Linux details
defining the binding. What about u-boot, BSD, future versions of Linux
with different structure?

I don't think an MFD is required here. A driver should be able to be
both clock and reset provider. That's pretty common. pinctrl less so.

> >  - It means one pinctrl device for the two banks. That addresses your
> >    comment on [PATCH v3 10/17]. This is often done and would be doable
> >    on this platform. However it means added logic to each individual
> >    function of pinctrl-eyeq5.

If it makes things easier, 2 'pins' sub-nodes is fine. That's just
container nodes.

> >    Overall it makes for less readable code, for code that already looks
> >    more complex than it really is.
> >
> >    My initial non-public version of pinctrl-eyeq5 was using this method
> >    (a device handling both banks) and I've leaned away from it.
>
> I had forgotten one other reason:
>
>  - Reusability does count for something. Other Mobileye platforms exist,
>    and the system controller stuff is more complex on those. Multiple
>    different OLB blocks, etc. But my understanding is that
>    per-peripheral logic is reused across versions.

IME, this stuff never stays exactly the same from chip to chip.

Rob

