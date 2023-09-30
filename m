Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41DF7B40B8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 16:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbjI3OJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 10:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjI3OJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 10:09:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A18AB3;
        Sat, 30 Sep 2023 07:09:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C917C433C8;
        Sat, 30 Sep 2023 14:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696082966;
        bh=hk3AhPgtuY5Ipeir8PTEBRwQE9bjMtb3/FCCgihi7II=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K7pxfGkEQh8MeyGFqQ5h986qm2vtG+qycbl0qGkwQGD/FWzMKhwvb44aNA4PEITUH
         7McwyDKHNOhCR4Rdwf9NwglznPkAa+wsNMbuFkyOjjpd7Np2vBcBc58VWY4Aeqi6Kn
         as3m9ez6hT9Bg6YfAOdq0AwjKrLPoCRPB8RsYtpiXh/qKLK4nfU2orKyHvEi5qnm4R
         L3fWk+rb6MvPYiOzg58QQNYyDbaeHspe8MJb3//YwOjbL/icDBjOdrirG9a/UD3bG4
         /ovHG48XpnXf4Qsi6rgwedgX0FRDfS1n81tT6gssIgxmLnYTE/TE9Sibn+n5Vdw+E5
         VUqQY/m8JBCYQ==
Date:   Sat, 30 Sep 2023 15:09:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Ivan Mikhaylov <fr0st61te@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: adc: provide max34408/9 device tree
 binding document
Message-ID: <20230930150926.47c1e6eb@jic23-huawei>
In-Reply-To: <20230930-lusty-antihero-f381434ab682@spud>
References: <20230929200844.23316-1-fr0st61te@gmail.com>
        <20230929200844.23316-2-fr0st61te@gmail.com>
        <20230930-lusty-antihero-f381434ab682@spud>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2023 10:37:09 +0100
Conor Dooley <conor@kernel.org> wrote:

> Hey,
> 
> On Fri, Sep 29, 2023 at 11:08:43PM +0300, Ivan Mikhaylov wrote:
> > The hardware binding for i2c current monitoring device with overcurrent
> > control.
> > 
> > Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> > ---
> >  .../bindings/iio/adc/maxim,max34408.yaml      | 101 ++++++++++++++++++
> >  1 file changed, 101 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > new file mode 100644
> > index 000000000000..cdf89fa4c80e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > @@ -0,0 +1,101 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/maxim,max34408.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Two- and four-channel current monitors with overcurrent control
> > +
> > +maintainers:
> > +  - Ivan Mikhaylov <fr0st61te@gmail.com>
> > +
> > +description: |
> > +  The MAX34408/MAX34409 are two- and four-channel current monitors that are
> > +  configured and monitored with a standard I2C/SMBus serial interface. Each
> > +  unidirectional current sensor offers precision high-side operation with a
> > +  low full-scale sense voltage. The devices automatically sequence through
> > +  two or four channels and collect the current-sense samples and average them
> > +  to reduce the effect of impulse noise. The raw ADC samples are compared to
> > +  user-programmable digital thresholds to indicate overcurrent conditions.
> > +  Overcurrent conditions trigger a hardware output to provide an immediate
> > +  indication to shut down any necessary external circuitry.
> > +
> > +  Specifications about the devices can be found at:
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX34408-MAX34409.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - maxim,max34408
> > +      - maxim,max34409
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  maxim,input1-rsense-val-micro-ohms:
> > +    description:
> > +      Adjust the Rsense value to monitor higher or lower current levels for
> > +      input 1.
> > +    enum: [250, 500, 1000, 5000, 10000, 50000, 100000, 200000, 500000]
> > +    default: 1000
> > +
> > +  maxim,input2-rsense-val-micro-ohms:
> > +    description:
> > +      Adjust the Rsense value to monitor higher or lower current levels for
> > +      input 2.
> > +    enum: [250, 500, 1000, 5000, 10000, 50000, 100000, 200000, 500000]
> > +    default: 1000
> > +
> > +  maxim,input3-rsense-val-micro-ohms:
> > +    description:
> > +      Adjust the Rsense value to monitor higher or lower current levels for
> > +      input 3.
> > +    enum: [250, 500, 1000, 5000, 10000, 50000, 100000, 200000, 500000]
> > +    default: 1000
> > +
> > +  maxim,input4-rsense-val-micro-ohms:
> > +    description:
> > +      Adjust the Rsense value to monitor higher or lower current levels for
> > +      input 4.
> > +    enum: [250, 500, 1000, 5000, 10000, 50000, 100000, 200000, 500000]
> > +    default: 1000  
> 
> Having 4 almost identical properties makes it seem like this should have
> some channel nodes, each containing an rsense-micro-ohms type property.
Agreed.  That is most flexible route if there is any chance of ending up
with more channel specific stuff in future.

There should also be some magic in here to rule out the input3 and input4
for the devices with only two channels. (lots of examples in tree)

Otherwise, in theory this could be an array I guess, but I'd also prefer
channel nodes.

> 
> > +
> > +  maxim,shtdn:
> > +    description:
> > +      Shutdown Output. Open-drain output. This output transitions to high impedance
> > +      when any of the digital comparator thresholds are exceeded as long as the ENA
> > +      pin is high.
> > +    type: boolean  
> 
> I don't understand what this property is used for. The description here,
> and below for "ena", read like they are the descriptions in the
> datasheet for the pin, rather than how to use the property.
> 
> The drivers don't appear to contain users either - what is the point of
> these properties?
> 
> > +
> > +  maxim,ena:
> > +    description:
> > +      SHTDN Enable Input. CMOS digital input. Connect to GND to clear the latch and
> > +      unconditionally deassert (force low) the SHTDN output and reset the shutdown
> > +      delay. Connect to VDD to enable normal latch operation of the SHTDN output.
> > +    type: boolean
> > +
> > +  supply-vdd: true  
> 
> As pointed out by the bot, this is not correct. You need to use a
> -supply affix, not a supply-prefix.
My error in earlier review (not enough coffee that day I guess :)

Anyhow it does show that the tests weren't run which isn't a good thing to see.

Jonathan

> 
> Thanks,
> Conor.
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        adc@1e {
> > +              compatible = "maxim,max34409";
> > +              reg = <0x1e>;
> > +              maxim,input1-rsense-val-micro-ohms = <5000>;
> > +              maxim,input2-rsense-val-micro-ohms = <10000>;
> > +        };
> > +    };
> > -- 
> > 2.42.0
> >  

