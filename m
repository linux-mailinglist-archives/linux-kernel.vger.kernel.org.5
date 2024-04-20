Return-Path: <linux-kernel+bounces-152231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03C88ABB16
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 12:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3BF51C20C3A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 10:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9458C20312;
	Sat, 20 Apr 2024 10:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYMtS4vJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CD71079D;
	Sat, 20 Apr 2024 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713610337; cv=none; b=T/qnMP3sNptCYFyYYZfsGedjT2qksc7c1SXHTidSXXB2UsU+IGccYeessy+QRVe7dl6MwNUT8LUC0nFGCjmOXApUXnB8URVx1IkajHPRbPTRWQiwkoa6lTH0h0QeXjDm67gL1d384phHwpO9uBOXi+aZPIzlT2++qew8JwlCods=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713610337; c=relaxed/simple;
	bh=GC4toVFbU8lLyEILIZUyjFxJf+X6KRHI50LZBP7/52U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5Wx3FbuTgLPVCG/s6S3E1cDc33X6NQbrq8d4E+kKRR6Hzh3tGTmA9XS/Q4mm8VFUTsk4yeWve+xdvavY09C4Isxqp2NmKlTHTv7ToFvM/CBeMQPwQDWau2PWD+EvthOfr7s/s25VAgfv/9ys+bHKZtQbstYcup5B0JPEHBdX6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYMtS4vJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FA8C072AA;
	Sat, 20 Apr 2024 10:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713610337;
	bh=GC4toVFbU8lLyEILIZUyjFxJf+X6KRHI50LZBP7/52U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tYMtS4vJ2sJbdHdMFP+Nir3s+gtKR80hX+a5NY5FU2Pym/VPMtRRiEPwKBpRsYMiH
	 J0l+hNeVCRQ6twcx82ogKvghGs0v2eaeCOqG/4NBovQBk0h17Wc2G1ye71kdjzmjFF
	 MRfayqvmduhT2scH7WrhgwRoAbSh3F6a2VuQ5YYK4X+e8DXhfYGaVWIER/Ks4i4Or9
	 52qlWCGlVRvKkceTRrQOqfTLPbjJG/CAvG0DvcODS+X8/itMc3n12jOIpBQSf6GhaA
	 ib85OkJCsh4Lfzso1++PxMp/0RAuIyCFLEt1jyp79Fl+grHQyCGIAM3sYijNGef3mW
	 hTaqs3ibVs/XA==
Date: Sat, 20 Apr 2024 11:52:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>,
 michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alexandru.tachici@analog.com, lars@metafoo.de,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt@analog.com, bigunclemax@gmail.com,
 dlechner@baylibre.com, okan.sahin@analog.com, fr0st61te@gmail.com,
 alisa.roman@analog.com, marcus.folkesson@gmail.com, schnelle@linux.ibm.com,
 liambeguin@gmail.com
Subject: Re: [PATCH v6 4/5] dt-bindings: iio: adc: ad7192: Add AD7194
 support
Message-ID: <20240420115203.1a5783b3@jic23-huawei>
In-Reply-To: <20240418144019.GA1581398-robh@kernel.org>
References: <20240417170054.140587-1-alisa.roman@analog.com>
	<20240417170054.140587-5-alisa.roman@analog.com>
	<20240418144019.GA1581398-robh@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 09:40:19 -0500
Rob Herring <robh@kernel.org> wrote:

> On Wed, Apr 17, 2024 at 08:00:53PM +0300, Alisa-Dariana Roman wrote:
> > Unlike the other AD719Xs, AD7194 has configurable differential
> > channels. The user can dynamically configure them in the devicetree.
> > 
> > Also add an example for AD7194 devicetree.
> > 
> > Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>

More general follow up comment inline.


> > ---
> >  .../bindings/iio/adc/adi,ad7192.yaml          | 77 +++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> > index cf5c568f140a..7e4e15e4e648 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> > @@ -21,8 +21,15 @@ properties:
> >        - adi,ad7190
> >        - adi,ad7192
> >        - adi,ad7193
> > +      - adi,ad7194
> >        - adi,ad7195
> >  
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> >    reg:
> >      maxItems: 1
> >  
> > @@ -89,6 +96,30 @@ properties:
> >      description: see Documentation/devicetree/bindings/iio/adc/adc.yaml
> >      type: boolean
> >  
> > +patternProperties:
> > +  "^channel@[0-9a-z]+$":  
> 
> Unit-addresses are hex (typically). So something like:
> 
> '^channel@(100|[0-9a-f]{1,2})$'
> 
> > +    type: object
> > +    $ref: adc.yaml
> > +    unevaluatedProperties: false
> > +
> > +    properties:
> > +      reg:
> > +        description: The channel index.
> > +        minimum: 1
> > +        maximum: 256  
> 
> Why not 0 based?
> 
> 
> > +
> > +      diff-channels:
> > +        description: |  
> 
> Don't need '|' if no formatting.
> 
> > +          Both inputs can be connected to pins AIN1 to AIN16 by choosing the
> > +          appropriate value from 1 to 16.
> > +        items:
> > +          minimum: 1
> > +          maximum: 16
> > +
> > +    required:
> > +      - reg
> > +      - diff-channels  
> 
> Single ended modes aren't supported?
To follow up on this. 

For single ended only devices we just let reg reference the the channel.
For differential channels that never worked (because there was a pair).
So for mixed devices it's a bit of a mess.

I'd be happy if we cleaned that up by adding a binding alongside
diff-channels that was simply channel.

For single ended only devices it would be optional but it would make
this device and similar easier to describe.

We can wrap it up in a helper function that queries channel first
and falls back to reg if it isn't there.

Maybe could call it single-channel to make it obvious it's an either
or with diff-channels.

With hindsight we could have just made that take 1 or 2 elements and
given it a generic name from the start.   Ah the wonder if retro designing
interfaces... :(

New element in adc.yaml would looks something like.
  single-channel:
    $ref: /schemas/types.yaml#/definitions/uint32
    description:
      When devices combine single and differential channels, allow
      the channel for a single element to be specified, independent
      of reg (as for differentila channels). If this and
      diff-channels are not present reg shall be used instead.

Jonathan

> 
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -103,6 +134,17 @@ required:
> >  
> >  allOf:
> >    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - adi,ad7190
> > +            - adi,ad7192
> > +            - adi,ad7193
> > +            - adi,ad7195
> > +    then:
> > +      patternProperties:
> > +        "^channel@[0-9a-z]+$": false
> >  
> >  unevaluatedProperties: false
> >  
> > @@ -133,3 +175,38 @@ examples:
> >              adi,burnout-currents-enable;
> >          };
> >      };
> > +  - |
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        adc@0 {
> > +            compatible = "adi,ad7194";
> > +            reg = <0>;
> > +
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +
> > +            spi-max-frequency = <1000000>;
> > +            spi-cpol;
> > +            spi-cpha;
> > +            clocks = <&ad7192_mclk>;
> > +            clock-names = "mclk";
> > +            interrupts = <25 0x2>;
> > +            interrupt-parent = <&gpio>;
> > +            aincom-supply = <&aincom>;
> > +            dvdd-supply = <&dvdd>;
> > +            avdd-supply = <&avdd>;
> > +            vref-supply = <&vref>;
> > +
> > +            channel@1 {
> > +                reg = <1>;
> > +                diff-channels = <1 6>;
> > +            };
> > +
> > +            channel@2 {
> > +                reg = <2>;
> > +                diff-channels = <16 5>;
> > +            };
> > +        };
> > +    };
> > -- 
> > 2.34.1
> >   


