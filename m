Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3557F8E2D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 20:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjKYTsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 14:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKYTr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 14:47:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469DFA3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 11:48:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155F0C433C9;
        Sat, 25 Nov 2023 19:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700941684;
        bh=TG3FLWwBucstw2055o8skcJRkN+mDQJa4/2yE8D+7pI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MjBlglmbDTlUKLPBziVsBLkzEJNbJzuhJ1wrX3RYGh6wTdeJTRcHcVpRgYubQ3WAF
         XiP/hy8hpRrLGaP7beX7+JtQUDv/5ZfMdSUykTFq20iGV0jLr1ZSSGf4XEnlX70dys
         HhhzJBTL8fzxHSWnd8KMohWIUPIpmScAoZoUMI2bvAhCBV/OZHRpyT9nE5YVetM/5Y
         6NzOaXNhWmBtxtDZDrxviwLtJklzcPyiDlmXZblZUq1xubFo5wEbitln4yhNr/d6E7
         GI8O7xQU/D+5+fBcgv1uAR48U+gIaIhI8LsW53Ib98pIurc7DG+vvt+vgERTzazZdX
         qixJDWTnwbgYQ==
Date:   Sat, 25 Nov 2023 19:47:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        marius.cristea@microchip.com, lars@metafoo.de, robh+dt@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: adding support for
 PAC193X
Message-ID: <20231125194754.304523e6@jic23-huawei>
In-Reply-To: <20231116-channel-variety-cc7c262924ad@squawk>
References: <20231115134453.6656-1-marius.cristea@microchip.com>
        <20231115134453.6656-2-marius.cristea@microchip.com>
        <fedd4bcf-7892-4096-bcca-7ea72d39576f@linaro.org>
        <20231116-channel-variety-cc7c262924ad@squawk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 18:21:33 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Thu, Nov 16, 2023 at 04:01:43PM +0100, Krzysztof Kozlowski wrote:
> > On 15/11/2023 14:44, marius.cristea@microchip.com wrote:  
> > > From: Marius Cristea <marius.cristea@microchip.com>
> > > 
> > > This is the device tree schema for iio driver for
> > > Microchip PAC193X series of Power Monitors with Accumulator.
> > > 
> > > Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> > > ---
> > >  .../bindings/iio/adc/microchip,pac1934.yaml   | 137 ++++++++++++++++++
> > >  1 file changed, 137 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
> > > new file mode 100644
> > > index 000000000000..2609cb19c377
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
> > > @@ -0,0 +1,137 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/microchip,pac1934.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Microchip PAC1934 Power Monitors with Accumulator
> > > +
> > > +maintainers:
> > > +  - Marius Cristea <marius.cristea@microchip.com>
> > > +
> > > +description: |
> > > +  This device is part of the Microchip family of Power Monitors with Accumulator.
> > > +  The datasheet for PAC1931, PAC1932, PAC1933 and PAC1934 can be found here:
> > > +    https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/PAC1931-Family-Data-Sheet-DS20005850E.pdf
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - microchip,pac1931
> > > +      - microchip,pac1932
> > > +      - microchip,pac1933
> > > +      - microchip,pac1934
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  "#address-cells":
> > > +    const: 1
> > > +
> > > +  "#size-cells":
> > > +    const: 0
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  microchip,slow-io:
> > > +    type: boolean
> > > +    description: |
> > > +      A GPIO used to trigger a change is sampling rate (lowering the chip power consumption).  
> > 
> > Use Linux coding style wrapping (as described in Linux Coding style). I
> > am not going to tell you numbers because I want you to read the document
> > first.
> > 
> > This is boolean, not GPIO. I don't understand. "A GPIO", so any GPIO or
> > some specific? How is this property related to GPIO?
> > 
> >   
> > > +      If configured in SLOW mode, if this pin is forced high, sampling rate is forced to eight  
> > 
> > This pin? This is boolean, not a GPIO. GPIOs are phandles.  
> 
> I said it on the previous version, but this really seems like it should
> be something like "slow-io-gpios". I know Jonathan expressed some
> concerns about having to deal with it on the operating system side (as
> the pin is either an input & used for this slow-io control, or an output
> and used as an interrupt) but that is, in my opinion, a problem for the
> operating system & the binding should describe how the hardware works,
> even if that is not convenient. With this sort of property, a GPIO hog
> would be required to be set up (and the driver for that gpio controller
> bound etc before the pac driver loads) for correction functionality if
> this property was in the non-default state.

I'd forgotten the discussion completely ;)
My main question was why bother with slow?  You can do it without the GPIO
anyway as there is a register bit for it.

I can conceive of various possible reasons, the evil one being that it's
actually out of the host processors control. Is that what we care about here?
If so it's nothing to do with a GPIO in the Linux sense at all and we can
assume that it's not connected to an interrupt at the same time.

We 'might' need a control for that case that says configure the device for
an external entity to use the slow pin.

It wouldn't be the first device to have that sort of thing, but normally they
are sequencing pins that are wired up to some mechanical device or similar.


> 
> > > +      samples/second. When it is forced low, the sampling rate is 1024 samples/second unless
> > > +      a different sample rate has been programmed.
> > > +
> > > +patternProperties:
> > > +  "^channel@[1-4]+$":
> > > +    type: object
> > > +    $ref: adc.yaml
> > > +    description: Represents the external channels which are connected to the ADC.
> > > +
> > > +    properties:
> > > +      reg:
> > > +        items:
> > > +          minimum: 1
> > > +          maximum: 4
> > > +
> > > +      shunt-resistor-micro-ohms:
> > > +        description: |
> > > +          Value in micro Ohms of the shunt resistor connected between
> > > +          the SENSE+ and SENSE- inputs, across which the current is measured. Value
> > > +          is needed to compute the scaling of the measured current.
> > > +
> > > +    required:
> > > +      - reg
> > > +      - shunt-resistor-micro-ohms
> > > +
> > > +    unevaluatedProperties: false
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - "#address-cells"
> > > +  - "#size-cells"
> > > +
> > > +allOf:
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: interrupts  
> > 
> > 
> > I don't understand what do you want to say here. I am also 100% sure you
> > did not test it on a real case (maybe example passes but nothing more).  
> 
> As far as I understand, the same pin on the device is used for both an
> output or an input depending on the configuration. As an input, it is
> the "slow-io" control, and as an output it is an interrupt.
> I think Marius is trying to convey that either this pin can be in
> exclusively one state or another.
> 
> _However_ I am not sure that that is really the right thing to do - they
> might well be mutually exclusive modes, but I think the decision can be
> made at runtime, rather than at devicetree creation time. Say for
> example the GPIO controller this is connected to is capable of acting as
> an interrupt controller. Unless I am misunderstanding the runtime
> configurability of this hardware, I think it is possible to actually
> provide a "slow-io-gpios" and an interrupt property & let the operating
> system decide at runtime which mode it wants to work in.

I'll admit I've long forgotten what was going on here, but based just on
this bit of text I agree. There is nothing 'stopping' us having a pin
uses as either / or / both interrupt and gpio.

It'll be a bit messy to support in the driver as IIRC there are some sanity
checks that limit combinations on IRQs and output GPIOS.  Can't remember
how bad the dance to navigate it safely is.

First version I'd just say pick one option if both are provided and
don't support configuring it at runtime.

Jonathan
 


> 
> I'm off travelling at the moment Marius, but I should be back in work on
> Monday if you want to have a chat about it & explain a bit more to me?
> 
> Cheers,
> Conor.
> 
> >   
> > > +    then:
> > > +      properties:
> > > +        microchip,slow-io: false
> > > +    else:
> > > +      if:
> > > +        properties:
> > > +          compatible:
> > > +            contains:
> > > +              const: microchip,slow-io
> > > +      then:
> > > +        properties:
> > > +          interrupts: false  
> > 
> > Best regards,
> > Krzysztof
> >   

