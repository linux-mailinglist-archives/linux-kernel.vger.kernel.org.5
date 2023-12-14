Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B1E812E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443940AbjLNLLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443808AbjLNLLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:11:05 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E168E;
        Thu, 14 Dec 2023 03:11:11 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SrV4b1xwtz6J9y3;
        Thu, 14 Dec 2023 19:10:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
        by mail.maildlp.com (Postfix) with ESMTPS id 81C4A1400CA;
        Thu, 14 Dec 2023 19:11:09 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Dec
 2023 11:11:09 +0000
Date:   Thu, 14 Dec 2023 11:11:07 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
CC:     <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ti-ads1298: Add driver
Message-ID: <20231214111107.00002fd8@Huawei.com>
In-Reply-To: <20231213094722.31547-1-mike.looijmans@topic.nl>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.618139b3-8cb2-4e4c-9283-9e3787c70105@emailsignatures365.codetwo.com>
        <20231213094722.31547-1-mike.looijmans@topic.nl>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 10:47:21 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> Skeleton driver for the TI ADS1298 medical ADC. This device is
> typically used for ECG and similar measurements. Supports data
> acquisition at configurable scale and sampling frequency.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
>  .../bindings/iio/adc/ti,ads1298.yaml          | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> new file mode 100644
> index 000000000000..7a160ba721eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1298.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments' ads1298 medical ADC chips
> +
> +maintainers:
> +  - Mike Looijmans <mike.looijmans@topic.nl>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads1298
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description:
> +      Analog power supply, voltage between AVDD and AVSS. When providing a
> +      symmetric +/- 2.5V, the regulator should report 5V.
Commented on in other thread.
> +
> +  vref-supply:
> +    description:
> +      Optional reference voltage. If omitted, internal reference is used,
> +      depending on analog supply this is 2.4 or 4V.
> +
There is a dvdd-supply as well.  Might be others. Makes sure to document them all.

Should probably also document the gpios as the binding should attempt to be as complete
as possible independent of what the driver currently supports.

Lots of complex options for this device and the use of those pins, so maybe something
that can be left for now - but the patch description should then mention that is intentional.

Jonathan

> +  clocks:
> +    description: Optional 2.048 MHz external source clock on CLK pin
> +    maxItems: 1
> +
> +  clock-names:
> +    const: clk
> +
> +  interrupts:
> +    description: Interrupt on DRDY pin, triggers on falling edge
> +    maxItems: 1
> +
> +  label: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - interrupts
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@1 {
> +          reg = <1>;
> +          compatible = "ti,ads1298";
> +          label = "ads1298-1-ecg";
> +          avdd-supply = <&reg_iso_5v_a>;
> +          clock-names = "clk";
> +          clocks = <&clk_ads1298>;
> +          interrupt-parent = <&gpio0>;
> +          interrupts = <78 IRQ_TYPE_EDGE_FALLING>;
> +          spi-max-frequency = <20000000>;
> +          spi-cpha;
> +        };
> +    };
> +...

