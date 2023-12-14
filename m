Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A91812CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443601AbjLNKWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443555AbjLNKWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:22:42 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324A7AF;
        Thu, 14 Dec 2023 02:22:48 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SrT1X1Xwyz6K6JQ;
        Thu, 14 Dec 2023 18:22:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
        by mail.maildlp.com (Postfix) with ESMTPS id 7623B14058E;
        Thu, 14 Dec 2023 18:22:46 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Dec
 2023 10:22:46 +0000
Date:   Thu, 14 Dec 2023 10:22:44 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Jonathan Cameron" <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ti-ads1298: Add driver
Message-ID: <20231214102244.000052a3@Huawei.com>
In-Reply-To: <20231213-diffuser-disposal-ea21bbce8b64@spud>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.618139b3-8cb2-4e4c-9283-9e3787c70105@emailsignatures365.codetwo.com>
        <20231213094722.31547-1-mike.looijmans@topic.nl>
        <20231213-diffuser-disposal-ea21bbce8b64@spud>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 16:23:43 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Dec 13, 2023 at 10:47:21AM +0100, Mike Looijmans wrote:
> > Skeleton driver for the TI ADS1298 medical ADC. This device is
> > typically used for ECG and similar measurements. Supports data
> > acquisition at configurable scale and sampling frequency.  
> 
> I think the commit subject and body here were accidentally copy-pasted
> from the driver patch. Patches for bindings should avoid talking about
> drivers and focus on the harware (unless we are talking about LEDs or
> motors etc)
> 
> > 
> > Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> > 
> > ---
> > 
> >  .../bindings/iio/adc/ti,ads1298.yaml          | 80 +++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> > new file mode 100644
> > index 000000000000..7a160ba721eb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> > @@ -0,0 +1,80 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/ti,ads1298.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Texas Instruments' ads1298 medical ADC chips
> > +
> > +maintainers:
> > +  - Mike Looijmans <mike.looijmans@topic.nl>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ti,ads1298
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-cpha: true
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +
> > +  avdd-supply:
> > +    description:
> > +      Analog power supply, voltage between AVDD and AVSS. When providing a
> > +      symmetric +/- 2.5V, the regulator should report 5V.

Any precedence in tree for doing this?  I thought we had bindings that required negative
supplies to be specified separately if present - so this would need to be 2 
supplies. e.g.
https://elixir.bootlin.com/linux/v6.7-rc5/source/Documentation/devicetree/bindings/iio/adc/ti,adc12138.yaml#L37


> > +
> > +  vref-supply:
> > +    description:
> > +      Optional reference voltage. If omitted, internal reference is used,
> > +      depending on analog supply this is 2.4 or 4V.  
> 
> It may be worth mentioning here what the conditions for the internal
> reference being 2.4 or 4 volts actually are.
> 
> > +
> > +  clocks:
> > +    description: Optional 2.048 MHz external source clock on CLK pin
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    const: clk  
> 
> Since you have only one clock, having clock-names (especially with a
> name like "clk") is pointless IMO.
> 
> Generally though, this patch looks good to me.
> 
> Cheers,
> Conor.
> 
> > +  interrupts:
> > +    description: Interrupt on DRDY pin, triggers on falling edge
> > +    maxItems: 1
> > +
> > +  label: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - avdd-supply
> > +  - interrupts
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        adc@1 {
> > +          reg = <1>;
> > +          compatible = "ti,ads1298";
> > +          label = "ads1298-1-ecg";
> > +          avdd-supply = <&reg_iso_5v_a>;
> > +          clock-names = "clk";
> > +          clocks = <&clk_ads1298>;
> > +          interrupt-parent = <&gpio0>;
> > +          interrupts = <78 IRQ_TYPE_EDGE_FALLING>;
> > +          spi-max-frequency = <20000000>;
> > +          spi-cpha;
> > +        };
> > +    };
> > +...
> > -- 
> > 2.34.1
> > 
> > 
> > Met vriendelijke groet / kind regards,
> > 
> > Mike Looijmans
> > System Expert
> > 
> > 
> > TOPIC Embedded Products B.V.
> > Materiaalweg 4, 5681 RJ Best
> > The Netherlands
> > 
> > T: +31 (0) 499 33 69 69
> > E: mike.looijmans@topic.nl
> > W: www.topic.nl
> > 
> > Please consider the environment before printing this e-mail  
> 

