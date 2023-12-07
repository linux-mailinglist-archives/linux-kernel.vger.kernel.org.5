Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72E48085F6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjLGKY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjLGKY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:24:56 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C53713D;
        Thu,  7 Dec 2023 02:25:01 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E6DC2669;
        Thu,  7 Dec 2023 11:24:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701944658;
        bh=oGMWlxxRV6p3mFDaJ3TGXPEn3FbTBvg3/evgd3+y/Ko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vWpXT8UsiteCEzkEtzoX10adYyeEX6urlEu+KOlHBcjaDk5VGq8rGJ8BqOCE/3GBR
         A8ORGLRJ/bnMcvNEsZdXBOoYvMgtiooFJn7bMpCObyZkhv/ebpeCSvmxaifFjDBH3O
         ksV/e2TPK5L34V/sT/OPysbbUrbkgsDWyMhAGZVk=
Date:   Thu, 7 Dec 2023 12:25:05 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Zhi Mao <zhi.mao@mediatek.com>, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shengnan.wang@mediatek.com, yaya.chang@mediatek.com,
        10572168@qq.com, Project_Global_Chrome_Upstream_Group@mediatek.com,
        yunkec@chromium.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        jacopo.mondi@ideasonboard.com, sakari.ailus@linux.intel.com,
        hverkuil-cisco@xs4all.nl, heiko@sntech.de,
        jernej.skrabec@gmail.com, macromorgan@hotmail.com,
        linus.walleij@linaro.org, hdegoede@redhat.com,
        tomi.valkeinen@ideasonboard.com, gerald.loacker@wolfvision.net,
        andy.shevchenko@gmail.com, bingbu.cao@intel.com,
        dan.scally@ideasonboard.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] media: dt-bindings: media: i2c: Document GC08A3
 bindings
Message-ID: <20231207102505.GI29417@pendragon.ideasonboard.com>
References: <20231123115104.32094-1-zhi.mao@mediatek.com>
 <20231123115104.32094-2-zhi.mao@mediatek.com>
 <20231123-magical-rupture-83251807e995@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231123-magical-rupture-83251807e995@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 05:31:35PM +0000, Conor Dooley wrote:
> On Thu, Nov 23, 2023 at 07:51:03PM +0800, Zhi Mao wrote:
> > Add YAML device tree binding for GC08A3 CMOS image sensor, 
> > and the relevant MAINTAINERS entries.
> > 
> > Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> 
> Please test your bindings.
> 
> > ---
> >  .../bindings/media/i2c/galaxycore,gc08a3.yaml | 128 ++++++++++++++++++
> >  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
> >  2 files changed, 130 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
> > new file mode 100644
> > index 000000000000..089ea321da91
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
> > @@ -0,0 +1,128 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/i2c/galaxycore,gc08a3.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: GalaxyCore gc08a3 1/4" 8M Pixel MIPI CSI-2 sensor
> > +
> > +maintainers:
> > +  - Zhi Mao <zhi.mao@mediatek.com>
> > +
> > +description: |-
> 
> The |- is not needed, you have no formatting to preserve.
> 
> > +  The gc08a3 is a raw image sensor with an MIPI CSI-2 image data
> > +  interface and CCI (I2C compatible) control bus. The output format
> > +  is raw Bayer.
> > +
> > +properties:
> > +  compatible:
> > +    const: GalaxyCore,gc08a3
> 
> Please remove the capitals.
> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Reference to the mclk clock.
> 
> Pointless, just use maxItems: 1.
> 
> > +
> > +  assigned-clocks:
> > +    maxItems: 1
> > +
> > +  assigned-clock-rates:
> > +    maxItems: 1
> > +
> > +  enable-gpios:
> > +    description: Reference to the GPIO connected to the RESETB pin. Active low.
> > +    maxItems: 1
> > +

If that's the RESETB pin, it should be reset-gpios.

> > +  vddio-supply:
> > +    description: Definition of the regulator used for the VDDIO power supply.
> > +
> > +  vdda-supply:
> > +    description: Definition of the regulator used for the VDDA power supply.
> > +
> > +  vddd-supply:
> > +    description: Definition of the regulator used for the VDDD power supply.
> 
> These descriptions can all be replaced with "foo-supply: true" IMO.
> 
> > +  port:
> > +    $ref: /schemas/graph.yaml#/$defs/port-base
> > +    unevaluatedProperties: false
> > +
> > +    properties:
> > +      endpoint:
> > +        $ref: /schemas/media/video-interfaces.yaml#
> > +        unevaluatedProperties: false
> > +
> > +        properties:
> > +          data-lanes:
> > +            oneOf:
> > +              - items:
> > +                  - const: 1
> > +                  - const: 2
> > +                  - const: 3
> > +                  - const: 4
> > +              - items:
> > +                  - const: 1
> > +                  - const: 2
> > +
> > +          link-frequencies: true
> > +
> > +        required:
> > +          - data-lanes
> > +          - link-frequencies
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> 
> > +  - assigned-clocks
> > +  - assigned-clock-rates
> 
> Why are these required?
> 
> > +  - vddio-supply
> > +  - vdda-supply
> > +  - vddd-supply
> > +  - port
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        sensor0@2 {
> > +            status = "okay";
> > +            compatible = "GalaxyCore,gc08a3";
> > +            reg = <0x31>;
> > +
> > +            clocks = <&topckgen CLK_TOP_CAMTG>,
> > +                <&topckgen CLK_TOP_UNIVPLL_192M_D8>;
> > +            clock-names = "xvclk", "freq_mux";
> > +            clock-frequency = <24000000>;
> > +
> > +            assigned-clocks = <&topckgen CLK_TOP_CAMTG>,
> > +                    <&topckgen CLK_TOP_UNIVPLL_192M_D8>;
> > +            assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_192M_D8>;
> > +            assigned-clock-rates = <0>, <24000000>;
> > +
> > +            enable-gpios = <&pio 19 GPIO_ACTIVE_HIGH>;
> > +
> > +            pinctrl-names = "default";
> > +            pinctrl-0 = <&camera_pins_cam0>;
> > +
> > +            avdd-supply = <&mt6359_vfe28_ldo_reg>;
> > +
> > +            port {
> > +                sensor0_out_2: endpoint {
> > +                    data-lanes = <1 2 3 4>;
> > +                    link-frequencies = /bits/ 64 <336000000 207000000>;
> > +                    remote-endpoint = <&seninf_csi_port_0_in_2>;
> > +                };
> > +            };
> > +        };
> > +
> > +    };
> > +
> > +...
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > index 309b94c328c8..a0bbec0bfee2 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -502,6 +502,8 @@ patternProperties:
> >      description: Fujitsu Ltd.
> >    "^fxtec,.*":
> >      description: FX Technology Ltd.
> > +  "^GalaxyCore,.*":
> > +    description: GalaxyCore Inc.
> >    "^gardena,.*":
> >      description: GARDENA GmbH
> >    "^gateway,.*":

-- 
Regards,

Laurent Pinchart
