Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C302077E775
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345167AbjHPRTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345181AbjHPRTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:19:06 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE7698;
        Wed, 16 Aug 2023 10:19:03 -0700 (PDT)
Received: from i53875bbf.versanet.de ([83.135.91.191] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qWKAT-0006YA-LC; Wed, 16 Aug 2023 19:18:49 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Andreas Kemnade <andreas@kemnade.info>,
        Conor Dooley <conor@kernel.org>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, rydberg@bitmath.org,
        u.kleine-koenig@pengutronix.de, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: touchscreen: convert neonode,zforce to
 json-schema
Date:   Wed, 16 Aug 2023 19:18:48 +0200
Message-ID: <113333811.nniJfEyVGO@diego>
In-Reply-To: <20230816-customary-service-8d9c5e5dbf1b@spud>
References: <20230815182948.212575-1-andreas@kemnade.info>
 <20230815182948.212575-2-andreas@kemnade.info>
 <20230816-customary-service-8d9c5e5dbf1b@spud>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mittwoch, 16. August 2023, 16:52:16 CEST schrieb Conor Dooley:
> On Tue, Aug 15, 2023 at 08:29:45PM +0200, Andreas Kemnade wrote:
> > Convert Neonode infrared touchscreen controller binding to DT schema.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  .../input/touchscreen/neonode,zforce.yaml     | 67 +++++++++++++++++++
> >  .../bindings/input/touchscreen/zforce_ts.txt  | 34 ----------
> >  2 files changed, 67 insertions(+), 34 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/neonode,zforce.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/neonode,zforce.yaml b/Documentation/devicetree/bindings/input/touchscreen/neonode,zforce.yaml
> > new file mode 100644
> > index 000000000000..1c45adb2407a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/neonode,zforce.yaml
> > @@ -0,0 +1,67 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/input/touchscreen/neonode,zforce.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Neonode infrared touchscreen controller
> > +
> > +maintainers:
> > +  - Heiko Stuebner <heiko.stuebner@bqreaders.com>
> 
> It;d be good to CC the person you're volunteering! I've done so.

BQ the company is no more. So I have no issue with me being in there,
afterall I did that driver back then, but I guess my main and permanent
address of heiko@sntech.de might be more appropriate :-)

Heiko


> > +
> > +properties:
> > +  compatible:
> > +    const: neonode,zforce
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +
> > +  irq-gpios:
> > +    maxItems: 1
> > +
> > +  x-size:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  y-size:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  vdd-supply: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - reset-gpios
> > +  - x-size
> > +  - y-size
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        touchscreen@50 {
> > +            compatible = "neonode,zforce";
> > +            reg = <0x50>;
> > +            interrupts = <2 0>;
> > +            vdd-supply = <&reg_zforce_vdd>;
> > +
> > +            reset-gpios = <&gpio5 9 0>; /* RST */
> > +            irq-gpios = <&gpio5 6 0>; /* IRQ, optional */
> > +
> > +            x-size = <800>;
> > +            y-size = <600>;
> > +        };
> > +    };
> > +...
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
> > deleted file mode 100644
> > index e3c27c4fd9c8..000000000000
> > --- a/Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
> > +++ /dev/null
> > @@ -1,34 +0,0 @@
> > -* Neonode infrared touchscreen controller
> > -
> > -Required properties:
> > -- compatible: must be "neonode,zforce"
> > -- reg: I2C address of the chip
> > -- interrupts: interrupt to which the chip is connected
> > -- reset-gpios: reset gpio the chip is connected to
> > -- x-size: horizontal resolution of touchscreen
> > -- y-size: vertical resolution of touchscreen
> > -
> > -Optional properties:
> > -- irq-gpios : interrupt gpio the chip is connected to
> > -- vdd-supply: Regulator controlling the controller supply
> > -
> > -Example:
> > -
> > -	i2c@00000000 {
> > -		/* ... */
> > -
> > -		zforce_ts@50 {
> > -			compatible = "neonode,zforce";
> > -			reg = <0x50>;
> > -			interrupts = <2 0>;
> > -			vdd-supply = <&reg_zforce_vdd>;
> > -
> > -			reset-gpios = <&gpio5 9 0>; /* RST */
> > -			irq-gpios = <&gpio5 6 0>; /* IRQ, optional */
> > -
> > -			x-size = <800>;
> > -			y-size = <600>;
> > -		};
> > -
> > -		/* ... */
> > -	};
> 




