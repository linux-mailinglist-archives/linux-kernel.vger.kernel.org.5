Return-Path: <linux-kernel+bounces-73971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8050185CE2E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8C21F2139F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46472BAE9;
	Wed, 21 Feb 2024 02:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Y5grKhT/"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF402B9C6;
	Wed, 21 Feb 2024 02:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483303; cv=none; b=kZNWUPPgymEYaIlarNhpKBy3RqyBeBscCmZKVOg8kYJE/mHZvpFhbVI898Hsnu95hTvNzkaOVYzqytEje0FcMpF/MkxvFC9E523JnxUvt8EbmmnI6jrqFD9UzANzNuGF8gCgiBOYaGLf6PMq0HJfZWR/nBeqFiJOs6FeZA2Jo54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483303; c=relaxed/simple;
	bh=uNsZHg2GHYvf4LqOn/3+x3c6GRm6+b8jtP7o1Z0qWsc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qf3fzbECRQRUGwqsmNZqdGbeSgyTxJSQR5IOmFVNCDYMOtyDIvrzJn1/JzCTUVGPU3F8TgLH7EPUz0ibcZNaJtE4DEx2LkM80E6LHGMbJDJ66Xec9sxvJ7V46LE66+s0altf5CzUKU6ANXCkT5HDwCL7T1SAUVfp12Ntm/bT10M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Y5grKhT/; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-85-8.adl-apt-pir-bras31.tpg.internode.on.net [14.2.85.8])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5459D20184;
	Wed, 21 Feb 2024 10:41:36 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708483298;
	bh=i30tH1Ja0ZXVCudrf3PesBOg0hw/OSVcL1FWavEO4jI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Y5grKhT/tF0diY/VUxBXx4FN3msX2l1/VU2VbGaHBcbd95wusYTx58qbginFcaWdC
	 G9cvzahU/eRJnSi6osDKRYFrAgAGnCqUHoCfoobsO+r84qs3yR5ae63XvzRafVmhpY
	 ic5NC87lLFT9fBZdfjBdlm5x17brSbH/nwTK6ru92fbsLItwtUNnFWbINuXBZdjZFK
	 NWIwXZ/u8LSYweLwt9pKUG4hss4zUQ5eRaeAmke/68G6g+ZY5kit/9AViBQpS4HEtX
	 d35pjRJ7BQNFDkkTxxOXI85htwDkNLsqVP1LTtfLjLSg+OD/BMLpjfzvmayjQs0rpb
	 9Pper7XHXuqZg==
Message-ID: <18dfd5f2eff5049fa5e3a098490dc601cf146f96.camel@codeconstruct.com.au>
Subject: Re: [PATCH] dt-bindings: gpio: Convert Aspeed binding to YAML schema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linus.walleij@linaro.org, brgl@bgdev.pl
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org,  joel@jms.id.au, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org,  linux-kernel@vger.kernel.org
Date: Wed, 21 Feb 2024 13:11:35 +1030
In-Reply-To: <0d1dd262-b6dd-4d71-9239-8b0aec8cceff@linaro.org>
References: <20240220052918.742793-1-andrew@codeconstruct.com.au>
	 <0d1dd262-b6dd-4d71-9239-8b0aec8cceff@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Krzysztof, thanks for the feedback.

On Tue, 2024-02-20 at 09:27 +0100, Krzysztof Kozlowski wrote:
> > On 20/02/2024 06:29, Andrew Jeffery wrote:
> > > > Squash warnings such as:
> > > >=20
> >=20
> > Missing subject prefix: aspeed,ast2400-gpio
> >=20
> >=20
> > > > ```
> > > > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/ap=
b@1e600000/gpio@1e780000: failed to match any schema with compatible: ['asp=
eed,ast2400-gpio']
> > > > ```
> > > >=20
> > > > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> >=20
> > Thank you for your patch. There is something to discuss/improve.
> >=20
> >=20
> > > > ---
> > > >  .../bindings/gpio/aspeed,ast2400-gpio.yaml    | 64 +++++++++++++++=
++++
> > > >  .../devicetree/bindings/gpio/gpio-aspeed.txt  | 39 -----------
> > > >  2 files changed, 64 insertions(+), 39 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/gpio/aspeed,a=
st2400-gpio.yaml
> > > >  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-asp=
eed.txt
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-=
gpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> > > > new file mode 100644
> > > > index 000000000000..353c7620013f
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.ya=
ml
> > > > @@ -0,0 +1,64 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Aspeed GPIO controller
> > > > +
> > > > +maintainers:
> > > > +  - Andrew Jeffery <andrew@codeconstruct.com.au>
> > > > +
> > > > +allOf:
> > > > +  - $ref: /schemas/gpio/gpio.yaml#
> >=20
> > From where did you take it? None of the bindings have such code. Start
> > from recent bindings in given category when writing new ones.

I didn't take it from anywhere so much as try to apply some reasoning
via the commentary in the example at [1]. Maybe I could have fought
that approach by contrasting what I wrote to a wider set of existing
binding documents (I did look at some and obviously didn't find
anything similar).

Anyway reflecting on the misunderstanding, is the ref unnecessary
because the gpio binding sets `select: true`[2] and so is applied to
the node regardless?

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/devicetree/bindings/example-schema.yaml?h=3Dv6.7#n238
[2]: https://github.com/devicetree-org/dt-schema/blob/v2023.11/dtschema/sch=
emas/gpio/gpio.yaml#L12

> >=20
> > Please drop it.

Ack.

> >=20
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            const: aspeed,ast2600-gpio
> > > > +    then:
> > > > +      required:
> > > > +        - ngpios
> >=20
> > Please put entire allOf: after required: block. That's the convention
> > when it has something more than $ref, because we still want the most
> > important parts at the top of the file.

Ack.

> >=20
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - aspeed,ast2400-gpio
> > > > +      - aspeed,ast2500-gpio
> > > > +      - aspeed,ast2600-gpio
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  clocks:
> > > > +    maxItems: 1
> > > > +    description: The clock to use for debounce timings
> > > > +
> > > > +  interrupts:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupt-controller: true
> > > > +
> > > > +  "#interrupt-cells":
> > > > +    const: 2
> > > > +
> >=20
> > ngpios with some constraints

Is this just with regard to the constraints I have under allOf above?
Or something further (constrain the values of ngpios for the various
controllers across the Aspeed SoCs)?

Maybe I'll look at some more of the existing bindings for this as
well...

> >=20
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - interrupts
> > > > +  - interrupt-controller
> > > > +  - "#gpio-cells"
> > > > +  - gpio-controller
> > > > +
> > > > +unevaluatedProperties: false
> >=20
> > Instead additionalProperties: false.

Ack - this is the same misunderstanding as the gpio schema ref
discussed above.

Andrew


