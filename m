Return-Path: <linux-kernel+bounces-12718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4323C81F943
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244341C21E97
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2963D514;
	Thu, 28 Dec 2023 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P6dIJJIT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5719C8E2;
	Thu, 28 Dec 2023 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A91A4C0004;
	Thu, 28 Dec 2023 14:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703775476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKJ5CNCkGEhT8rzWQFp0fG5E3RHlKoOVSwbE7uYwM9Y=;
	b=P6dIJJITjtdYd4B/+r9+gvaFznjHLsB22inTw9/vkIQt0fNJsadUhijB0bNtWH2ULDCS4L
	SnfMN04hpKhPmWUxj68j7NWPpbNe8eDETd0n8c1qTFBq84s30LylDgE/4uyS85W0EgtPTz
	cvMEXWlHbcgpIHtPRM3DsEzG2H6quNoIagCc0ja8xPx4FFWxyph8ku6fL3QD4uYibj05hK
	4zw6isFtrE4OwmuflfFbEJYtm7dJvWtoAaR64olSafsvpvd2aPEHhQOLikraiy0UqYXn+Z
	7Jr03XvUV/Gj6le5tyVdvWkVJPTAvxAEvL7LPYjE6NP6KID6wpqbdlrr6JJ6gg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Dec 2023 15:57:55 +0100
Message-Id: <CY02002PZ08V.368NYASI51S@bootlin.com>
Subject: Re: [PATCH v2 3/6] dt-bindings: soc: mobileye: add EyeQ5 OLB system
 controller
Cc: "Gregory CLEMENT" <gregory.clement@bootlin.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
 <linux-mips@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Rob Herring" <robh+dt@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20231227-mbly-clk-v2-0-a05db63c380f@bootlin.com>
 <20231227-mbly-clk-v2-3-a05db63c380f@bootlin.com>
 <CAL_JsqJD4ZeR+n09gC2fXnk1MFuqO0c0zADSg_-MiY65pck1Yw@mail.gmail.com>
In-Reply-To: <CAL_JsqJD4ZeR+n09gC2fXnk1MFuqO0c0zADSg_-MiY65pck1Yw@mail.gmail.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Wed Dec 27, 2023 at 7:27 PM CET, Rob Herring wrote:
> On Wed, Dec 27, 2023 at 10:24=E2=80=AFAM Th=C3=A9o Lebrun <theo.lebrun@bo=
otlin.com> wrote:
> >
> > Add documentation to describe the "Other Logic Block" syscon.
> >
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  | 44 ++++++++++++++=
++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 45 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/soc/mobileye/mobileye,ey=
eq5-olb.yaml b/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq=
5-olb.yaml
> > new file mode 100644
> > index 000000000000..b148a49b08f1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb=
.yaml
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb.yam=
l#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Mobileye EyeQ5 SoC system controller
> > +
> > +maintainers:
> > +  - Gr=C3=A9gory Clement <gregory.clement@bootlin.com>
> > +  - Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > +  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> > +
> > +description:
> > +  OLB ("Other Logic Block") is a hardware block grouping smaller block=
s. Clocks,
> > +  resets, pinctrl are being handled from here.
>
> I don't see resets or pinctrl in the binding. Please make it complete
> whether you have the driver or not.
>
> As-is, you don't need clocks to be a child node.

Will do. Would it make sense to have the three drivers be a single
series? Else we could have the dt-bindings be part of the base platform
support series[1].

[1]: https://lore.kernel.org/lkml/20231212163459.1923041-1-gregory.clement@=
bootlin.com/

> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: mobileye,eyeq5-olb
> > +      - const: syscon
> > +      - const: simple-mfd
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  reg-io-width:
> > +    const: 4
>
> Why do you need this? It is not a generic block and can only ever be 1
> value.

This block is still a syscon in the end. I wanted to explicit that
access width must be 4 bytes and nothing else.

Does you question mean you think I should be removing it?

> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-io-width
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    olb@e00000 {
> > +      compatible =3D "mobileye,eyeq5-olb", "syscon", "simple-mfd";
> > +      reg =3D <0xe00000 0x400>;
> > +      reg-io-width =3D <4>;
>
> Make this example complete and drop the child node example.

I hesitated inbetween the two options, I'll fix that on the next
revision. Thanks!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

