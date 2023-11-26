Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EECC7F93A7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 17:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjKZQEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 11:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjKZQEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 11:04:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD100137
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 08:04:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FACEC433C7;
        Sun, 26 Nov 2023 16:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701014688;
        bh=juZpsIMH+zxndA5/oqXyf6KAF1d5Vbdex0YVpHNxFtg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MPCc7s3sMuYrw2qSU3ehirBXCceb+Zc90kY3gwhzjjR+P0ylUyt5udZAKW7GoOy9M
         wGtg5u2BuYdWwoHbXpTtF1Wu8E4O/Z9S72LP0R4Z0zmHYOSbAeCEpuPF8HSDtfYNZr
         YnPROqMvDbjjS4XIZmBohZBtm58uHVUfM1RCBjtkVCNTNJ8srAqkVFtDR45d6ErW/I
         Kz7fWIExR/f2eHHVsj7ts8L7x5Bepurm/ivk0hso233j7Y54y8r4CCpFSzRHpoNPW8
         Wv49cTpyWZsBGMoQhAqcNAPFnVG2SsxfSt8sahOiz8q3b4CcHVVKg2UPZzQtt+Kvfk
         /rxGOnAMw1U9w==
Date:   Sun, 26 Nov 2023 16:04:38 +0000
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
Message-ID: <20231126160438.01ff57d7@jic23-huawei>
In-Reply-To: <20231126-nineteen-clumsy-701ac4145ba8@spud>
References: <20231115134453.6656-1-marius.cristea@microchip.com>
        <20231115134453.6656-2-marius.cristea@microchip.com>
        <fedd4bcf-7892-4096-bcca-7ea72d39576f@linaro.org>
        <20231116-channel-variety-cc7c262924ad@squawk>
        <20231125194754.304523e6@jic23-huawei>
        <20231126-nineteen-clumsy-701ac4145ba8@spud>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2023 11:24:56 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Sat, Nov 25, 2023 at 07:47:54PM +0000, Jonathan Cameron wrote:
> > On Thu, 16 Nov 2023 18:21:33 +0000
> > Conor Dooley <conor@kernel.org> wrote:  
> > > On Thu, Nov 16, 2023 at 04:01:43PM +0100, Krzysztof Kozlowski wrote:  
> > > > On 15/11/2023 14:44, marius.cristea@microchip.com wrote:    
> > > > > From: Marius Cristea <marius.cristea@microchip.com>  
> 
> > > > > +patternProperties:
> > > > > +  "^channel@[1-4]+$":
> > > > > +    type: object
> > > > > +    $ref: adc.yaml
> > > > > +    description: Represents the external channels which are connected to the ADC.
> > > > > +
> > > > > +    properties:
> > > > > +      reg:
> > > > > +        items:
> > > > > +          minimum: 1
> > > > > +          maximum: 4
> > > > > +
> > > > > +      shunt-resistor-micro-ohms:
> > > > > +        description: |
> > > > > +          Value in micro Ohms of the shunt resistor connected between
> > > > > +          the SENSE+ and SENSE- inputs, across which the current is measured. Value
> > > > > +          is needed to compute the scaling of the measured current.
> > > > > +
> > > > > +    required:
> > > > > +      - reg
> > > > > +      - shunt-resistor-micro-ohms
> > > > > +
> > > > > +    unevaluatedProperties: false
> > > > > +
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - reg
> > > > > +  - "#address-cells"
> > > > > +  - "#size-cells"
> > > > > +
> > > > > +allOf:
> > > > > +  - if:
> > > > > +      properties:
> > > > > +        compatible:
> > > > > +          contains:
> > > > > +            const: interrupts    
> > > > 
> > > > 
> > > > I don't understand what do you want to say here. I am also 100% sure you
> > > > did not test it on a real case (maybe example passes but nothing more).    
> > > 
> > > As far as I understand, the same pin on the device is used for both an
> > > output or an input depending on the configuration. As an input, it is
> > > the "slow-io" control, and as an output it is an interrupt.
> > > I think Marius is trying to convey that either this pin can be in
> > > exclusively one state or another.
> > > 
> > > _However_ I am not sure that that is really the right thing to do - they
> > > might well be mutually exclusive modes, but I think the decision can be
> > > made at runtime, rather than at devicetree creation time. Say for
> > > example the GPIO controller this is connected to is capable of acting as
> > > an interrupt controller. Unless I am misunderstanding the runtime
> > > configurability of this hardware, I think it is possible to actually
> > > provide a "slow-io-gpios" and an interrupt property & let the operating
> > > system decide at runtime which mode it wants to work in.  
> > 
> > I'll admit I've long forgotten what was going on here, but based just on
> > this bit of text I agree. There is nothing 'stopping' us having a pin
> > uses as either / or / both interrupt and gpio.
> > 
> > It'll be a bit messy to support in the driver as IIRC there are some sanity
> > checks that limit combinations on IRQs and output GPIOS.  Can't remember
> > how bad the dance to navigate it safely is.
> > 
> > First version I'd just say pick one option if both are provided and
> > don't support configuring it at runtime.  
> 
> Just to be clear, you are suggesting having the
> "microchip,slow-io-gpios" and "interrupts" properties in the binding,
> but the driver will just (for example) put that pin into alert mode
> always & leave it there?

Yes.

> If that is what you are suggesting, that seems pragmatic to me.

If a use case to do something else comes along later, then we can
be smarter, but I'd like to keep it simple initially at least.

Jonathan

> 
> Cheers,
> Conor.
> 

