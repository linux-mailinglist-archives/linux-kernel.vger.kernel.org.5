Return-Path: <linux-kernel+bounces-128818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BC3895FEF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6471F22F86
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81453E487;
	Tue,  2 Apr 2024 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="FrXBUrga"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A7A2260B;
	Tue,  2 Apr 2024 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712099467; cv=none; b=c2kNgKwWcjwLuvZKeoRJtMdC/Tu+C7BnF4NhRj3M6rSCt8QbgZXuXlg3eqmGfQg+WiHGF1/IhGpwbiZppJ6AYnQxv1L6rDD9A1r53aafrKPRu7OC1Iw1QFUpkQoY0lJan30D6EiZ980VTKZFxJNSIkiaaSysHUJZx5xYgtNhJVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712099467; c=relaxed/simple;
	bh=iQbFPcT5bkTvOiaw3Ar/bC14ESOW5Lt2GUZ6v5VV1JU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MzmKIr9UMh0vpFdieelafSTBHAsZIXe92ioPpVJYxm+Uh9Vvy1rqXTsMtamEHd2qaYW96umjv1njomN5nGePFJNOLe3/dGEZmlof/deKmY/P4UYl5Htg0lFCCJIaEf0SuC0gf5hjIqjfYKBjHnzEvD5ZNT/G0IxQFo86djK/pr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=FrXBUrga; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-182-70.adl-adc-lon-bras34.tpg.internode.on.net [118.210.182.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 63CEE20075;
	Wed,  3 Apr 2024 07:10:55 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1712099458;
	bh=iuif0x0Ofo31gqORgNXcOWh8jcQ5qL5zLNFZaEZcCdA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FrXBUrgaQtHbvcweWF1VlRsmsh73gLQR6AFdBBQ3+/OiLS99ACu3Wj168ZYdQybWT
	 kQYb/CzlAfThARZupumQ241w5uK9vS1dKRQVFPUEjZwNZnGNvnGhH00lfrGGyknXgs
	 JhUZjADkr9Oil7R3kbLh5PwvY07AVibaunk6wsBMJiZ5MLYD4XVhFY03iib9BZ9U3p
	 3B87bBrATIe8zuzC+Q2bvFQL9fgUun3wL4Kw2j8dzk7eGyR5eSoXFV4sNi4F1DIhYs
	 wkaNqqYy+RvYqxSGnexrLNlXrOXheFrRuBHb5IAnJIoINAD25yFY+5QnbAnA5cY0zr
	 5e1o39nMutU7Q==
Message-ID: <37d2cc0d19cc4ace869eace13c8452525bad8609.camel@codeconstruct.com.au>
Subject: Re: [PATCH] dt-bindings: watchdog: Convert Aspeed binding to DT
 schema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, joel@jms.id.au, 
	zev@bewilderbeest.net, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 03 Apr 2024 09:40:51 +1030
In-Reply-To: <20240402180718.GA358505-robh@kernel.org>
References: <20240402120118.282035-1-andrew@codeconstruct.com.au>
	 <20240402180718.GA358505-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-02 at 13:07 -0500, Rob Herring wrote:
> On Tue, Apr 02, 2024 at 10:31:18PM +1030, Andrew Jeffery wrote:
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
> >  .../bindings/watchdog/aspeed,ast2400-wdt.yaml | 130 ++++++++++++++++++
> >  .../bindings/watchdog/aspeed-wdt.txt          |  73 ----------
> >  2 files changed, 130 insertions(+), 73 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed,a=
st2400-wdt.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-w=
dt.txt
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
>=20
> # and order/function if more than 1 must be defined.

Ack.

>=20
> Please note it was missing from the original binding in the commit=20
> message.

Ack.

>=20
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
> > +      on a timeout event. Controllers critical to the SoC's operation =
may remain untouched.
> > +
> > +      Specifying 'system' will reset all controllers on a timeout even=
t, as if EXTRST had been asserted.
> > +      Specifying "none" will cause the timeout event to have no reset =
effect.
> > +      Another watchdog engine on the chip must be used for chip reset =
operations.
> > +
> > +      The default reset type is "system"
>=20
> Express as schema:
>=20
> default: system

Ack.

>=20
> > +
> > +  aspeed,alt-boot:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: |
>=20
> Don't need '|' if no formatting to preserve.

Ack.

>=20
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
>=20
> Wrap at <80. Period at end needed.

Ack for both.

>=20
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
> > +      timer expires. On AST2500 SoCs this should be a single word defi=
ned using
> > +      the AST2500_WDT_RESET_* macros; on AST2600 SoCs this should be a=
 two-word
> > +      array with the first word defined using the AST2600_WDT_RESET1_*=
 macros,
> > +      and the second word defined using the AST2600_WDT_RESET2_* macro=
s.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +allOf:
> > +  - if:
> > +      anyOf:
> > +        - required:
> > +            - aspeed,ext-push-pull
> > +        - required:
> > +            - aspeed,ext-active-high
> > +        - required:
> > +            - aspeed,reset-mask
> > +    then:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - aspeed,ast2500-wdt
> > +            - aspeed,ast2600-wdt
> > +  - if:
> > +      required:
> > +        - aspeed,ext-active-high
> > +    then:
> > +      required:
> > +        - aspeed,ext-push-pull
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    wdt1: watchdog@1e785000 {
>=20
> Drop unused labels.

Ack.

Thanks for the feedback.

Andrew

