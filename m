Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A508B7B4EF4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbjJBJWE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Oct 2023 05:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236063AbjJBJWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:22:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CF699;
        Mon,  2 Oct 2023 02:21:58 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rzb7K3QN6z6K6dl;
        Mon,  2 Oct 2023 17:21:49 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 10:21:56 +0100
Date:   Mon, 2 Oct 2023 10:21:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ivan Mikhaylov <fr0st61te@gmail.com>
CC:     Conor Dooley <conor@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: adc: provide max34408/9 device tree
 binding document
Message-ID: <20231002102155.000030bb@Huawei.com>
In-Reply-To: <591e8c9a4018938df17cdfb55306813858904d9d.camel@gmail.com>
References: <20230929200844.23316-1-fr0st61te@gmail.com>
        <20230929200844.23316-2-fr0st61te@gmail.com>
        <20230930-lusty-antihero-f381434ab682@spud>
        <591e8c9a4018938df17cdfb55306813858904d9d.camel@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2023 22:38:58 +0300
Ivan Mikhaylov <fr0st61te@gmail.com> wrote:

> On Sat, 2023-09-30 at 10:37 +0100, Conor Dooley wrote:
> > Hey,
> > 
> > On Fri, Sep 29, 2023 at 11:08:43PM +0300, Ivan Mikhaylov wrote:  
> > > The hardware binding for i2c current monitoring device with
> > > overcurrent
> > > control.
> > > 
> > > Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> > > ---
> > >  .../bindings/iio/adc/maxim,max34408.yaml      | 101
> > > ++++++++++++++++++
> > >  1 file changed, 101 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > > b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > > new file mode 100644
> > > index 000000000000..cdf89fa4c80e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > > @@ -0,0 +1,101 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/maxim,max34408.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Two- and four-channel current monitors with overcurrent
> > > control
> > > +
> > > +maintainers:
> > > +  - Ivan Mikhaylov <fr0st61te@gmail.com>
> > > +
> > > +description: |
> > > +  The MAX34408/MAX34409 are two- and four-channel current monitors
> > > that are
> > > +  configured and monitored with a standard I2C/SMBus serial
> > > interface. Each
> > > +  unidirectional current sensor offers precision high-side
> > > operation with a
> > > +  low full-scale sense voltage. The devices automatically sequence
> > > through
> > > +  two or four channels and collect the current-sense samples and
> > > average them
> > > +  to reduce the effect of impulse noise. The raw ADC samples are
> > > compared to
> > > +  user-programmable digital thresholds to indicate overcurrent
> > > conditions.
> > > +  Overcurrent conditions trigger a hardware output to provide an
> > > immediate
> > > +  indication to shut down any necessary external circuitry.
> > > +
> > > +  Specifications about the devices can be found at:
> > > + 
> > > https://www.analog.com/media/en/technical-documentation/data-sheets/MAX34408-MAX34409.pdf
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - maxim,max34408
> > > +      - maxim,max34409
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  maxim,input1-rsense-val-micro-ohms:
> > > +    description:
> > > +      Adjust the Rsense value to monitor higher or lower current
> > > levels for
> > > +      input 1.
> > > +    enum: [250, 500, 1000, 5000, 10000, 50000, 100000, 200000,
> > > 500000]
> > > +    default: 1000
> > > +
> > > +  maxim,input2-rsense-val-micro-ohms:
> > > +    description:
> > > +      Adjust the Rsense value to monitor higher or lower current
> > > levels for
> > > +      input 2.
> > > +    enum: [250, 500, 1000, 5000, 10000, 50000, 100000, 200000,
> > > 500000]
> > > +    default: 1000
> > > +
> > > +  maxim,input3-rsense-val-micro-ohms:
> > > +    description:
> > > +      Adjust the Rsense value to monitor higher or lower current
> > > levels for
> > > +      input 3.
> > > +    enum: [250, 500, 1000, 5000, 10000, 50000, 100000, 200000,
> > > 500000]
> > > +    default: 1000
> > > +
> > > +  maxim,input4-rsense-val-micro-ohms:
> > > +    description:
> > > +      Adjust the Rsense value to monitor higher or lower current
> > > levels for
> > > +      input 4.
> > > +    enum: [250, 500, 1000, 5000, 10000, 50000, 100000, 200000,
> > > 500000]
> > > +    default: 1000  
> > 
> > Having 4 almost identical properties makes it seem like this should
> > have
> > some channel nodes, each containing an rsense-micro-ohms type
> > property.  
> 
> Conor, I'll look through.
> 
> >   
> > > +
> > > +  maxim,shtdn:
> > > +    description:
> > > +      Shutdown Output. Open-drain output. This output transitions
> > > to high impedance
> > > +      when any of the digital comparator thresholds are exceeded
> > > as long as the ENA
> > > +      pin is high.
> > > +    type: boolean  
> > 
> > I don't understand what this property is used for. The description
> > here,
> > and below for "ena", read like they are the descriptions in the
> > datasheet for the pin, rather than how to use the property.
> > 
> > The drivers don't appear to contain users either - what is the point
> > of
> > these properties?  
> 
> ena and shtdn physical pins of hardware, in the previous version
> Jonathan asked about adding them into yaml even if it's not used in
> code. should I do it in some other way?

Yes, use the gpio bindings.

enable-gpios, isshutdown-gpios 
perhaps - though try and find a similar example for the naming.

The shutdown one is a bit unusual in that it indicates the device
has shutdown for one of several possible reasons (IIRC)

Jonathan

> 
> >   
> > > +
> > > +  maxim,ena:
> > > +    description:
> > > +      SHTDN Enable Input. CMOS digital input. Connect to GND to
> > > clear the latch and
> > > +      unconditionally deassert (force low) the SHTDN output and
> > > reset the shutdown
> > > +      delay. Connect to VDD to enable normal latch operation of
> > > the SHTDN output.
> > > +    type: boolean
> > > +
> > > +  supply-vdd: true  
> > 
> > As pointed out by the bot, this is not correct. You need to use a
> > -supply affix, not a supply-prefix.  
> 
> Oops.
> 
> Thanks.
> 
> 

