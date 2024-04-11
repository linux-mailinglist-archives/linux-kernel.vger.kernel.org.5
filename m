Return-Path: <linux-kernel+bounces-140567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C37E8A1648
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3253328706D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62307335BC;
	Thu, 11 Apr 2024 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EizjFafu"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D5E147C9D;
	Thu, 11 Apr 2024 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712843386; cv=none; b=fv4S1gMD3bBNXv7EorAQTfc6A+kDAjds40V7XeRJuqCwVQKtbXZHxipFkzXIfyfVeElF8FiSacpDgtCt8uQoXuwTjLB6r7F1Lw5POcvaAoJTzTgx9/o00Xk6C8QINkYChBS7OVfYHawoF4ESiR7jZatwKSyuUfMs2kSP9cunP6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712843386; c=relaxed/simple;
	bh=gmld257+GG6WGIrfxRjRkWvqnB1xsmhIW/xZjCHCGSs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=PNFuh1jo5O7VWWt2z0KE051Dr4gjF0QUh64Si7ehM0xsU3aqCr7IDXwMBveY146SET12YCVEv2JxYN6ocxvFszPNgsBCtyrUv8sF92niZzTDDugnbRgiR7gRAGmXhSZSia0VhtBmgOjGuV7Jf8wbvP7zd8ccyNo2H6EZLIzfSH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EizjFafu; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5317FE0002;
	Thu, 11 Apr 2024 13:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712843375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LiWlRAVSR0J/gKNCGbaKB/gU7+67qgp/9tQ2GW51RFg=;
	b=EizjFafu2wVellm9z3fq9e6dRFMrKjVuDPuEA1bw5u5vNk6VBC0vRcw+BeMrH6oCoLXcIi
	Qxt76lhOLB4npENtewa0dPrw1lvXzL6WSZRZWfqQ135hC8PBFSvtc+ag2mXuZTRYXTbDq6
	EkWX6/K53V4hpwwN9FTWp5gT9g3HlKj5EYLoG5UFzSJ2a5zzezO9RnlKuqm230fN/xeyDC
	4xsZzVJCXzvPfr1fPHL9/tJprb9trw9zAVVRz+c63mutYJl4+jhQRECYBiyk8rP1z11agX
	mnL7ztnQ03MD84uBDEak2FDgNNupMAHtz12zls0OA16jGk7gaIzv2zcvqKVP9A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 15:49:34 +0200
Message-Id: <D0HCAV6APTSD.WKGPESJ29D8A@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 02/11] dt-bindings: clock: mobileye,eyeq5-clk: add
 EyeQ6L and EyeQ6H
Cc: <linux-mips@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Michael Turquette" <mturquette@baylibre.com>, "Stephen Boyd"
 <sboyd@kernel.org>, "Philipp Zabel" <p.zabel@pengutronix.de>, "Linus
 Walleij" <linus.walleij@linaro.org>
X-Mailer: aerc 0.15.2
References: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com>
 <20240410-mbly-olb-v1-2-335e496d7be3@bootlin.com>
 <29ece6c8-ddf4-4dcd-b5b4-1cad8bc858d3@linaro.org>
In-Reply-To: <29ece6c8-ddf4-4dcd-b5b4-1cad8bc858d3@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Krzysztof,

On Thu Apr 11, 2024 at 8:14 AM CEST, Krzysztof Kozlowski wrote:
> On 10/04/2024 19:12, Th=C3=A9o Lebrun wrote:
> > Add bindings describing EyeQ6L and EyeQ6H clock controllers.
> > Add constants to index clocks.
> >=20
> > Bindings are conditional for two reasons:
> >  - Some compatibles expose a single clock; they do not take clock cells=
.
> >  - All compatibles take a PLLs resource, not all take others (aimed at
> >    divider clocks). Those that only take a resource for PLLs do not
> >    require named resources.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  .../bindings/clock/mobileye,eyeq5-clk.yaml         | 103 +++++++++++++=
+++++---
> >  MAINTAINERS                                        |   2 +
> >  include/dt-bindings/clock/mobileye,eyeq5-clk.h     |  21 +++++
> >  3 files changed, 113 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk=
yaml b/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml

[...]

> >  properties:
> >    compatible:
> > -    const: mobileye,eyeq5-clk
> > +    enum:
> > +      - mobileye,eyeq5-clk
> > +      - mobileye,eyeq6l-clk
> > +      - mobileye,eyeq6h-central-clk
> > +      - mobileye,eyeq6h-west-clk
> > +      - mobileye,eyeq6h-east-clk
> > +      - mobileye,eyeq6h-south-clk
> > +      - mobileye,eyeq6h-ddr0-clk
> > +      - mobileye,eyeq6h-ddr1-clk
> > +      - mobileye,eyeq6h-acc-clk
> > =20
> > -  reg:
> > -    maxItems: 2
> > +  reg: true
>
> No, you must leave widest constraints here.

Noted, will do.

> > -  reg-names:
> > -    items:
> > -      - const: plls
> > -      - const: ospi
> > +  reg-names: true
>
> No, you must leave widest constraints here.

Noted, will do.

> >    "#clock-cells":
> > -    const: 1
> > +    enum: [0, 1]
>
> Looks like you squash here quite different devices...

They are the same controllers but some only expose a single clock. It is
EyeQ6H that has 7 OLB instances, so some don't deal with many clocks.

I started with a more generic approach of #clock-cells =3D <1> and only
have index zero available for those that have a single clock.
I am not a fan of this however.

> >    clocks:
> >      maxItems: 1
> > @@ -43,9 +49,80 @@ properties:
> >  required:
> >    - compatible
> >    - reg
> > -  - reg-names
> >    - "#clock-cells"
> >    - clocks
> >    - clock-names
> > =20
> > +allOf:
> > +  # "mobileye,eyeq5-clk" provides:
> > +  #  - PLLs and,
> > +  #  - One divider clock related to ospi.
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          const: mobileye,eyeq5-clk
> > +    then:
> > +      properties:
> > +        reg:
> > +          minItems: 2
> > +          maxItems: 2
> > +        reg-names:
> > +          minItems: 2
> > +          maxItems: 2
>
> So any name is now valid? Like "yellow-pony"?

I do not understand what implies this. Below "items: enum: [...]"
ensures only two allowed values. dtbs_check agrees:

=E2=9F=A9 git diff
diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
           b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
index 8d4f65ec912d..5031eb8b4270 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -126,7 +126,7 @@ reset: reset-controller@e00000 {
                        clocks: clock-controller@e0002c {
                                compatible =3D "mobileye,eyeq5-clk";
                                reg =3D <0x02c 0x50>, <0x11c 0x04>;
-                               reg-names =3D "plls", "ospi";
+                               reg-names =3D "plls", "yellow-pony";
                                #clock-cells =3D <1>;
                                clocks =3D <&xtal>;
                                clock-names =3D "ref";

=E2=9F=A9 make dtbs_check DT_SCHEMA_FILES=3Dmobileye DT_CHECKER_FLAGS=3D-m
  UPD     include/config/kernel.release
  DTC_CHK arch/mips/boot/dts/mobileye/eyeq5-epm5.dtb
arch/mips/boot/dts/mobileye/eyeq5-epm5.dtb: system-controller@e00000:
  clock-controller@e0002c:reg-names:1:
  'yellow-pony' is not one of ['plls', 'ospi']
  from schema $id:
    http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb.yaml#

> > +          items:
> > +            enum: [ plls, ospi ]
> > +      required:
> > +        - reg-names
> > +
> > +  # "mobileye,eyeq6h-south-clk" provides:
> > +  #  - PLLs and,
> > +  #  - Four divider clocks related to emmc, ospi and tsu.
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          const: mobileye,eyeq6h-south-clk
> > +    then:
> > +      properties:
> > +        reg:
> > +          minItems: 4
> > +          maxItems: 4
> > +        reg-names:
> > +          minItems: 4
> > +          maxItems: 4
> > +          items:
> > +            enum: [ plls, emmc, ospi, tsu ]
> > +      required:
> > +        - reg-names
> > +
> > +  # Other compatibles only provide PLLs. Do not ask for named resource=
s.
> > +  - if:
> > +      not:
> > +        required:
> > +          - reg-names
> > +    then:
> > +      properties:
> > +        reg:
> > +          minItems: 1
> > +          maxItems: 1
>
> No, just restrict properly reg per variant.

Noted, will do.

> > +        reg-names: false
>
> That's redundant. Drop entire if.

Ah, yes. Will fix that.

> > +
> > +  # Some compatibles provide a single clock; they do not take a clock =
cell.
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - mobileye,eyeq6h-central-clk
> > +            - mobileye,eyeq6h-west-clk
> > +            - mobileye,eyeq6h-east-clk
> > +            - mobileye,eyeq6h-ddr0-clk
> > +            - mobileye,eyeq6h-ddr1-clk
> > +    then:
> > +      properties:
> > +        "#clock-cells":
> > +          const: 0
>
> Wait, so you define device-per-clock? That's a terrible idea. We also
> discussed it many times and it was rejected many times.
>
> You have one device, not 5.

Each region must be a syscon to make its various registers accessible to
drivers that'll need it. Following that, I have a hard time seeing what
would be the DT structure of 7 OLB system-controllers but a single
clock node?

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


