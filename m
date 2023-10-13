Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A397C7C7FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjJMIT7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Oct 2023 04:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJMIT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:19:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25255BF;
        Fri, 13 Oct 2023 01:19:56 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S6K992kNlz685Td;
        Fri, 13 Oct 2023 16:16:45 +0800 (CST)
Received: from localhost (10.126.172.163) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 13 Oct
 2023 09:19:53 +0100
Date:   Fri, 13 Oct 2023 09:19:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ivan Mikhaylov <fr0st61te@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: adc: provide max34408/9 device tree
 binding document
Message-ID: <20231013091952.00002573@Huawei.com>
In-Reply-To: <e7b74daa9d0131246fd10f47aa4128bc8f8f3177.camel@gmail.com>
References: <20231007234838.8748-1-fr0st61te@gmail.com>
        <20231007234838.8748-2-fr0st61te@gmail.com>
        <20231010154042.2ef667b2@jic23-huawei>
        <383064a5b0863a4a616cd60cff8d4bc18e397fd7.camel@gmail.com>
        <20231012084052.504ac930@jic23-huawei>
        <e7b74daa9d0131246fd10f47aa4128bc8f8f3177.camel@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.126.172.163]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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

On Thu, 12 Oct 2023 19:27:33 +0300
Ivan Mikhaylov <fr0st61te@gmail.com> wrote:

> On Thu, 2023-10-12 at 08:40 +0100, Jonathan Cameron wrote:
> > On Tue, 10 Oct 2023 23:22:48 +0300
> > Ivan Mikhaylov <fr0st61te@gmail.com> wrote:
> >   
> > > On Tue, 2023-10-10 at 15:40 +0100, Jonathan Cameron wrote:  
> > > > On Sun,  8 Oct 2023 02:48:37 +0300
> > > > Ivan Mikhaylov <fr0st61te@gmail.com> wrote:
> > > >     
> > > > > The hardware binding for i2c current monitoring device with
> > > > > overcurrent
> > > > > control.
> > > > > 
> > > > > Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> > > > > ---
> > > > >  .../bindings/iio/adc/maxim,max34408.yaml      | 141
> > > > > ++++++++++++++++++
> > > > >  1 file changed, 141 insertions(+)
> > > > >  create mode 100644
> > > > > Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > > > > 
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > > > > b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..9749f1fd1802
> > > > > --- /dev/null
> > > > > +++
> > > > > b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> > > > > @@ -0,0 +1,141 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id:
> > > > > http://devicetree.org/schemas/iio/adc/maxim,max34408.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Two- and four-channel current monitors with overcurrent
> > > > > control
> > > > > +
> > > > > +maintainers:
> > > > > +  - Ivan Mikhaylov <fr0st61te@gmail.com>
> > > > > +
> > > > > +description: |
> > > > > +  The MAX34408/MAX34409 are two- and four-channel current
> > > > > monitors
> > > > > that are
> > > > > +  configured and monitored with a standard I2C/SMBus serial
> > > > > interface. Each
> > > > > +  unidirectional current sensor offers precision high-side
> > > > > operation with a
> > > > > +  low full-scale sense voltage. The devices automatically
> > > > > sequence
> > > > > through
> > > > > +  two or four channels and collect the current-sense samples
> > > > > and
> > > > > average them
> > > > > +  to reduce the effect of impulse noise. The raw ADC samples
> > > > > are
> > > > > compared to
> > > > > +  user-programmable digital thresholds to indicate overcurrent
> > > > > conditions.
> > > > > +  Overcurrent conditions trigger a hardware output to provide
> > > > > an
> > > > > immediate
> > > > > +  indication to shut down any necessary external circuitry.
> > > > > +
> > > > > +  Specifications about the devices can be found at:
> > > > > + 
> > > > > https://www.analog.com/media/en/technical-documentation/data-sheets/MAX34408-MAX34409.pdf
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    enum:
> > > > > +      - maxim,max34408
> > > > > +      - maxim,max34409
> > > > > +
> > > > > +  "#address-cells":
> > > > > +    const: 1
> > > > > +
> > > > > +  "#size-cells":
> > > > > +    const: 0
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  interrupts:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  powerdown-gpios:
> > > > > +    description:
> > > > > +      Shutdown Output. Open-drain output. This output
> > > > > transitions
> > > > > to high impedance
> > > > > +      when any of the digital comparator thresholds are
> > > > > exceeded
> > > > > as long as the ENA
> > > > > +      pin is high.
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  shtdn-enable-gpios:    
> > > > 
> > > > I guess the review crossed with you sending v5.  There is some
> > > > feedback on v4 you need
> > > > to address here.    
> > > 
> > > Jonathan, I thought I did, I've changed ena to powerdown-gpios from
> > > Krzysztof's comments but about this one pin I'm still not sure, it
> > > looks like *-enable-gpios (like in *-enable-gpios pins in
> > > iio/frequency/adi,adf4377.yaml) pin or is it not? Or maybe any
> > > other
> > > suggestions about naming of this one?
> > > 
> > > Thanks.  
> > 
> > shutdown-gpios and make the sense (active high / low) such that
> > setting
> > it results in teh device being shut down.
> > Or treat it as an enable and enable-gpios
> > 
> > Something that indicates both shutdown and enable is confusing ;)
> > 
> > Jonathan  
> 
> 
> Jonathan, then I make these changes:
> 
> powerdown-gpios: -> output-enable:
Needs to retain the gpios bit as we want the standard gpio stuff to pick
them up. I'm not that keen on output-enable-gpios though.  The activity
here is very much 'shutdown because of error or not enabled' I think.
So perhaps we flip the sense and document that it needs to be active low?

> shtdn-enable-gpios: -> enable-gpios:
> 
> Is it ok?

Conor, Rob, Krzysztof - you probably have a better insight into this than
I do.

Thanks,

Jonathan

> 
> Thanks.
> 

