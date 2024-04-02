Return-Path: <linux-kernel+bounces-128839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E2089604E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD801F22CBB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAD358AAC;
	Tue,  2 Apr 2024 23:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ZXHLJUfK"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3FC2260B;
	Tue,  2 Apr 2024 23:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712101185; cv=none; b=rMM2mExWqF0IwlBXEKq+Ip5CNp73DdNwJRFhB9jaCkOTOA1yfd4kFU9J3EZ4qroBS586Pv6lKDxbXC/zgEdaWVR3QQkQXBWhWeKq87N26QYE4PR0YBo7XeRjq0Ilj2422vg//RgrMZICXbtcqqb1ciKzTpWteZllKZvHBpPo8lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712101185; c=relaxed/simple;
	bh=ac3kZ5j3Emu12FGS8I9RXckwDThegE5k/mdyDspS2CY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WL8wyUtL4Kd5/+GABsShYxAaBizFpGfgv98C1zOO4++GyXBmeWLmYvKYibI5oOWX7eg+Ia418mDhn9ZDb7rTtEO0fVYXBMjSq74D14bG1PCb72KFGbN8WLddFI8vRaNH2+RNCaaEsYFMLM3Qu4I4vz8nJOu3P5g7qLQUyPa7F4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ZXHLJUfK; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-182-70.adl-adc-lon-bras34.tpg.internode.on.net [118.210.182.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 806F420075;
	Wed,  3 Apr 2024 07:39:38 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1712101179;
	bh=TYTY5ED6B4EfxtLOSSjN5VvpvocVSJ4sFiS7mfpMhBs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZXHLJUfKEfTPo/L5jQPCZ2RoFiql/3S//f0byjixfY7jvhq3TUlwuUCEv504O1Pnz
	 GU3oWpyf9rtcRApqMsANR9qfcPAHakXe233AWncmTBYt1rCNzgBFw6jWlFf30CHwKI
	 U2HTxNYc9mVrs30mOx1fI9xcm/NAxlJ9+dXwTRr5/8mr5zliRxw6wp++iUTFwnuq06
	 Qi8Gc5XjjzBKjMeX+9iuE9Ozn/CoV1x1TXlFyowx6iJNby/0ng74NBlMkLQvyF9n0w
	 ZzWop2iZlpYwO4f8U2Vk1nnJr20/9DT03gq0hD0l2K++SexJY2T4jlocIiZwgUtYs8
	 P/ZJCSDEyICkA==
Message-ID: <99fa05be32787c88150c6df2f882e31582aebf90.camel@codeconstruct.com.au>
Subject: Re: [PATCH] dt-bindings: watchdog: Convert Aspeed binding to DT
 schema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Zev Weiss <zev@bewilderbeest.net>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, joel@jms.id.au, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 03 Apr 2024 10:09:37 +1030
In-Reply-To: <65722a59-2e94-4616-81e1-835615b0e600@hatter.bewilderbeest.net>
References: <20240402120118.282035-1-andrew@codeconstruct.com.au>
	 <65722a59-2e94-4616-81e1-835615b0e600@hatter.bewilderbeest.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-02 at 16:30 -0700, Zev Weiss wrote:
> On Tue, Apr 02, 2024 at 05:01:18AM PDT, Andrew Jeffery wrote:
> > Squash warnings such as:
> >=20
> > ```
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb@1e=
600000/watchdog@1e785000: failed to match any schema with compatible: ['asp=
eed,ast2400-wdt']
> > ```
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > ---
> > .../bindings/watchdog/aspeed,ast2400-wdt.yaml | 130 ++++++++++++++++++
> > .../bindings/watchdog/aspeed-wdt.txt          |  73 ----------
> > 2 files changed, 130 insertions(+), 73 deletions(-)
> > create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed,as=
t2400-wdt.yaml
> > delete mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wd=
t.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-=
wdt.yaml b/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.ya=
ml
> > new file mode 100644
> > index 000000000000..10fcb50c4051
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yam=
l
> > @@ -0,0 +1,130 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/watchdog/aspeed,ast2400-wdt.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Aspeed watchdog timer controllers
> > +
> > +maintainers:
> > +  - Andrew Jeffery <andrew@codeconstruct.com.au>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - aspeed,ast2400-wdt
> > +      - aspeed,ast2500-wdt
> > +      - aspeed,ast2600-wdt
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks: true
> > +
> > +  aspeed,reset-type:
> > +    enum:
> > +      - cpu
> > +      - soc
> > +      - system
> > +      - none
> > +    description: |
> > +      Reset behaviour - The watchdog can be programmed to generate one=
 of three
> > +      different types of reset when a timeout occcurs.
> > +
> > +      Specifying 'cpu' will only reset the processor on a timeout even=
t.
> > +
> > +      Specifying 'soc' will reset a configurable subset of the SoC's c=
ontrollers
>=20
> Might be worth clarifying that it's configurable only on ast2500 &=20
> ast2600, and which property (aspeed,reset-mask) configures it?

Good point, will do.

>=20
> > +      on a timeout event. Controllers critical to the SoC's operation =
may remain untouched.
> > +
> > +      Specifying 'system' will reset all controllers on a timeout even=
t, as if EXTRST had been asserted.
> > +      Specifying "none" will cause the timeout event to have no reset =
effect.
>=20
> Tiny nit: quoting (single vs. double) is slightly inconsistent between=
=20
> values here.

Ack.

>=20
> > +      Another watchdog engine on the chip must be used for chip reset =
operations.
> > +
> > +      The default reset type is "system"
> > +
> > +  aspeed,alt-boot:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: |
> > +      Direct the watchdog to configure the SoC to boot from the altern=
ative boot
> > +      region if a timeout occurs.
> > +
> > +  aspeed,external-signal:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: |
> > +      Assert the timeout event on an external signal pin associated wi=
th the
> > +      watchdog controller instance. The pin must be muxed appropriatel=
y.
> > +
> > +  aspeed,ext-pulse-duration:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      The duration, in microseconds, of the pulse emitted on the exter=
nal signal pin
> > +
> > +  aspeed,ext-push-pull:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: |
> > +      If aspeed,external-signal is specified in the node, set the exte=
rnal
> > +      signal pin's drive type to push-pull. If aspeed,ext-push-pull is=
 not
> > +      specified then the pin is configured as open-drain.
> > +
> > +  aspeed,ext-active-high:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: |
> > +      If both aspeed,external-signal and aspeed,ext-push-pull are spec=
ified in
> > +      the node, set the pulse polarity to active-high. If aspeed,ext-a=
ctive-high
> > +      is not specified then the pin is configured as active-low.
> > +
> > +  aspeed,reset-mask:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    minItems: 1
> > +    maxItems: 2
> > +    description: |
> > +      A bitmaks indicating which peripherals will be reset if the watc=
hdog
>=20
> Typo: "bitmask"

Good catch.

Thanks,

Andrew

