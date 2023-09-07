Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14670797474
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241142AbjIGPik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345343AbjIGPf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:35:29 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C80E1BF5;
        Thu,  7 Sep 2023 08:35:06 -0700 (PDT)
Received: from pendragon.ideasonboard.com (ftip006315900.acc1.colindale.21cn-nte.bt.net [81.134.214.249])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B230E2CDC;
        Thu,  7 Sep 2023 16:55:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694098517;
        bh=6wGdBLHewcxLSxjS+2ckckVOBx3i38sHwk9eRFrOQ9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ttPd7fNzJp6UpNfAw+LywZJVYetaXUaqLzLpU4Q9+tbRkk2SirpnWPx0CbQ6c9Jx2
         TAE9krKhEscjisAnnLtapScRFrk0bCBP+fKxXC/tUze9YHk/RtWaTB+mFT7ZBW8y0c
         XTLDvNenU6EnkT2sI9n59QZrOYDXPkW/wQ1Q7t4c=
Date:   Thu, 7 Sep 2023 17:56:58 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: media: Add THine THP7312 ISP
Message-ID: <20230907145658.GB17610@pendragon.ideasonboard.com>
References: <20230905233118.183140-1-paul.elder@ideasonboard.com>
 <20230905233118.183140-2-paul.elder@ideasonboard.com>
 <f023767c-aa74-87ca-d333-3dba8a481cb6@linaro.org>
 <20230906081513.GK7971@pendragon.ideasonboard.com>
 <ZPnjFf4f1yX8ZZ/s@pyrite.rasen.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZPnjFf4f1yX8ZZ/s@pyrite.rasen.tech>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 11:49:57PM +0900, Paul Elder wrote:
> On Wed, Sep 06, 2023 at 11:15:13AM +0300, Laurent Pinchart wrote:
> > On Wed, Sep 06, 2023 at 09:18:30AM +0200, Krzysztof Kozlowski wrote:
> > > On 06/09/2023 01:31, Paul Elder wrote:
> > > > Add bindings for the THine THP7312 ISP.
> > > > 
> > > > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > > > ---
> > > > Since the THP7312 supports multiple sensors, thine,rx-data-lanes alone
> > > > might not be enough. I was consdering using sensor nodes like what the
> > > > AP1302 does [1]. This way we can also move the power supplies that only
> > > > concern the sensor in there as well. I was wondering what to do about
> > > > the model name, though, as the thp7312 completely isolates that from the 
> > > > rest of the system.
> > > > 
> > > > I'm planning to add sensor nodes in somehow in a v2.
> > > > 
> > > > [1] https://lore.kernel.org/linux-media/20211006113254.3470-2-anil.mamidala@xilinx.com/
> > > > 
> > > >  .../bindings/media/thine,thp7312.yaml         | 170 ++++++++++++++++++
> > > >  1 file changed, 170 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/media/thine,thp7312.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/media/thine,thp7312.yaml b/Documentation/devicetree/bindings/media/thine,thp7312.yaml
> > > > new file mode 100644
> > > > index 000000000000..e8d203dcda81
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/media/thine,thp7312.yaml
> > > > @@ -0,0 +1,170 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +# Copyright (c) 2023 Ideas on Board
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/media/thine,thp7312.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: THine THP7312
> > > > +
> > > > +maintainers:
> > > > +  - Paul Elder <paul.elder@@ideasonboard.com>
> > > > +
> > > > +description:
> > > > +  The THP7312 is a standalone ISP controlled over i2c, and is capable of
> > > > +  various image processing and correction functions, including 3A control. It
> > > > +  can be connected to CMOS image sensors from various vendors, supporting both
> > > > +  MIPI CSI-2 and parallel interfaces. It can also output on either MIPI CSI-2
> > > > +  or parallel. The hardware is capable of transmitting and receiving MIPI
> > > > +  interlaved data strams with data types or multiple virtual channel
> > > > +  identifiers.
> > > > +
> > > > +allOf:
> > > > +  - $ref: ../video-interface-devices.yaml#
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: thine,thp7312
> > > > +
> > > > +  reg:
> > > > +    description: I2C device address
> > > 
> > > You can skip description. It is obvious.
> > > 
> > > > +    maxItems: 1
> > > > +
> > > > +  clocks:
> > > > +    maxItems: 1
> > > > +      - description: CLKI clock input
> > > 
> > > This was absolutely never tested.
> > 
> > Paul, before sending DT bindings, please test them. The procedure
> > involves running `make dt_binding_check` as described towards the end of
> > Documentation/devicetree/bindings/writing-schema.rst. There's an
> > environment variable that you can use to restrict the test to a
> > particular binding file.
> 
> ack
> 
> > > > +
> > > > +  reset-gpios:
> > > > +    maxItems: 1
> > > > +    description: |-
> > > > +      Reference to the GPIO connected to the RESET_N pin, if any.
> > > > +      Must be released (set high) after all supplies are applied.
> > > > +
> > > > +  vddcore-supply:
> > > > +    description:
> > > > +      1.2V supply for core, PLL, MIPI rx and MIPI tx.
> > > > +
> > > > +  vhtermnx-supply:
> > > > +    description:
> > > > +      Supply for input (rx). 1.8V for MIPI, or 1.8/2.8/3.3V for parallel.
> > > > +
> > > > +  vddtx-supply:
> > > > +    description:
> > > > +      Supply for output (tx). 1.8V for MIPI, or 1.8/2.8/3.3V for parallel.
> > > > +
> > > > +  vddhost-supply:
> > > > +    description:
> > > > +      Supply for host interface. 1.8V, 2.8V, or 3.3V.
> > > > +
> > > > +  vddcmos-supply:
> > > > +    description:
> > > > +      Supply for sensor interface. 1.8V, 2.8V, or 3.3V.
> > > > +
> > > > +  vddgpio_0-supply:
> > > 
> > > No, underscores are not allowed in names.
> > > 
> > > > +    description:
> > > > +      Supply for GPIO_0. 1.8V, 2.8V, or 3.3V.
> > > > +
> > > > +  vddgpio_1-supply:
> > > > +    description:
> > > > +      Supply for GPIO_1. 1.8V, 2.8V, or 3.3V.
> > > > +
> > > > +  DOVDD-supply:
> > > 
> > > lowercase. Look at your other supplies. VDD is spelled there "vdd", so
> > > do not introduce random style.
> > > 
> > > > +    description:
> > > > +      Digital I/O (1.8V) supply for image sensor.
> > > > +
> > > > +  AVDD-supply:
> > > 
> > > lowercase
> > > 
> > > > +    description:
> > > > +      Analog (2.8V) supply for image sensor.
> > > > +
> > > > +  DVDD-supply:
> > > 
> > > lowercase
> > > 
> > > > +    description:
> > > > +      Digital Core (1.2V) supply for image sensor.
> > 
> > Are those three supplies required ? It looks like the vdd* supplies are
> > all you need.
> 
> The THSCG101 camera module has these connected to the connector
> connected to the sensor. Which don't even match with the supplies that
> are in the imx258 bindings, so I'm not sure how to express these;
> they're not part of the thp7312 but they're technically necessary for
> the camera module, but they're also not part of the sensor that the ISP
> is connected to.

This is the DT binding for the THP7312, not the THSCG101 camera module
(for readers who are not familiar with this, the THSCG101 is a module
that integrates the THP7312 ISP, a sensor module, and glue such as level
shifters or regulators). From the point of view of the THP7312 DT
binding, the THSCG101 is irrelevant. The binding need to expose the
supplies needed by the THP7312 (and, possibly, by the sensor module).

> > > > +
> > > > +  orientation: true
> > > > +  rotation: true
> > > > +
> > > > +  thine,rx,data-lanes:
> > > 
> > > Why are you duplicating properties? With wrong name? No, that's not a
> > > property of a device node, but endpoint.
> > > 
> > > > +    minItems: 4
> > > > +    maxItems: 4
> > > > +    $ref: /schemas/media/video-interfaces.yaml#data-lanes
> > > > +    description: |-
> > > 
> > > Drop |- where not needed.
> > > 
> > > > +      This property is for lane reordering between the THP7312 and the imaging
> > > > +      sensor that it is connected to.
> > > > +
> > > > +  port:
> > > > +    $ref: /schemas/graph.yaml#/$defs/port-base
> > > > +    additionalProperties: false
> > > > +
> > > > +    properties:
> > > > +      endpoint:
> > > > +        $ref: /schemas/media/video-interfaces.yaml#
> > > > +        unevaluatedProperties: false
> > > > +
> > > > +        properties:
> > > > +          data-lanes:
> > > > +            description: |-
> > > > +              The sensor supports either two-lane, or four-lane operation.
> > > > +              This property is for lane reordering between the THP7312 and
> > > > +              the SoC. If this property is omitted four-lane operation is
> > > > +              assumed. For two-lane operation the property must be set to <1 2>.
> > > > +            minItems: 2
> > > > +            maxItems: 4
> > > > +            items:
> > > > +              maximum: 4
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - reset-gpios
> > > > +  - clocks
> > > > +  - vddcore-supply
> > > > +  - vhtermrx-supply
> > > > +  - vddtx-supply
> > > > +  - vddhost-supply
> > > > +  - vddcmos-supply
> > > > +  - vddgpio_0-supply
> > > > +  - vddgpio_1-supply
> > > > +  - DOVDD-supply
> > > > +  - AVDD-supply
> > > > +  - DVDD-supply
> > > > +  - thine,rx,data-lanes
> > > > +  - port
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/gpio/gpio.h>
> > > > +
> > > > +    i2c {
> > > > +        #address-cells = <1>;
> > > > +        #size-cells = <0>;
> > > > +
> > > > +        camera@61 {
> > > > +            compatible = "thine,thp7312";
> > > > +            reg = <0x61>;
> > > > +
> > > > +            pinctrl-names = "default";
> > > > +            pinctrl-0 = <&cam1_pins_default>;
> > > > +
> > > > +            reset-gpios = <&pio 119 GPIO_ACTIVE_LOW>;
> > > > +            clocks = <&camera61_clk>;
> > > > +
> > > > +            vddcore-supply = <&vsys_v4p2>;
> > > > +            AVDD-supply = <&vsys_v4p2>;
> > > > +            DVDD-supply = <&vsys_v4p2>;
> > > 
> > > Srlsy, test it before sending. Look how many supplies you require and
> > > what is provided here. How any of this could possibly work?

-- 
Regards,

Laurent Pinchart
