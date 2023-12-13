Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0108C810C26
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjLMIOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjLMIOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:14:49 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A77F9F;
        Wed, 13 Dec 2023 00:14:52 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 058AEC000A;
        Wed, 13 Dec 2023 08:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702455291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+1xZ55Re/XaWJu/6O/u6KwyAQvOMJC2685sQVInQ3lQ=;
        b=OgqMQ97sPZzaTEOdDy0/SufyB8Kvy1xDsLLNRmc+qGiR4GAB+7bcyXwjA/rksD9yxIQ4zB
        Z+1sTj34dmiAoByOZM5rhhqs0jL4TCZlNR7IZrqZchwgsZ20kj7N8T9S7GJW5bKzCs4gF0
        z8z0xstQ847nq5PmI3qzV7c/FwIeflf/gXJYO6ANAVtnr5euzAtD4iD3/iXL+iJ2wygk2t
        sSub8XlGrTxNtTxs3imQpjrjGAVOFFRBZvXv41cLZCDG6re82l7DSqKYXu+Ex0ZbR365uV
        Iwcz4rGfuomTdOX/7T/oLtNWvIJ3Tft11a4K05h5HKtGAQsEfcN0buVyKFatrg==
Date:   Wed, 13 Dec 2023 09:14:48 +0100
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Jeff LaBundy <jeff@labundy.com>,
        catalin.popescu@leica-geosystems.com,
        mark.satterthwaite@touchnetix.com, bartp@baasheep.co.uk,
        hannah.rossiter@touchnetix.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH v5 2/3] dt-bindings: input: Add TouchNetix axiom
 touchscreen
Message-ID: <20231213081448.GA2340704@kb-xps>
References: <20231211121430.1689139-1-kamel.bouhara@bootlin.com>
 <20231211121430.1689139-3-kamel.bouhara@bootlin.com>
 <20231212-rework-bounce-f4d9d12362a4@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231212-rework-bounce-f4d9d12362a4@spud>
X-GND-Sasl: kamel.bouhara@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le Tue, Dec 12, 2023 at 04:57:11PM +0000, Conor Dooley a écrit :
> On Mon, Dec 11, 2023 at 01:14:28PM +0100, Kamel Bouhara wrote:
> > Add the TouchNetix axiom I2C touchscreen device tree bindings
> > documentation.
> >
> > Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > ---
> >  .../input/touchscreen/touchnetix,ax54a.yaml   | 64 +++++++++++++++++++
> >  MAINTAINERS                                   |  6 ++
> >  2 files changed, 70 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml
> > new file mode 100644
> > index 000000000000..cbdf48fc538b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml
> > @@ -0,0 +1,64 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/input/touchscreen/touchnetix,ax54a.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TouchNetix Axiom series touchscreen controller
> > +
> > +maintainers:
> > +  - Kamel Bouhara <kamel.bouhara@bootlin.com>
> > +
> > +allOf:
> > +  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
>
> Weird, you add this ref here but do not actually allow any properties
> from it since you have "additionalProperties: false" below.
>
> What's the point of its inclusion?

Currently the driver doesn't use thoses properties but still some are
valid for this device.

Greetings,
Kamel

>
> Cheers,
> Conor.
>
> > +  - $ref: /schemas/input/input.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: touchnetix,ax54a
> > +
> > +  reg:
> > +    const: 0x66
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +
> > +  vdda-supply:
> > +    description: Analog power supply regulator on VDDA pin
> > +
> > +  vddi-supply:
> > +    description: I/O power supply regulator on VDDI pin
> > +
> > +  poll-interval: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vdda-supply
> > +  - vddi-supply
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    i2c {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      touchscreen@66 {
> > +        compatible = "touchnetix,ax54a";
> > +        reg = <0x66>;
> > +        interrupt-parent = <&gpio2>;
> > +        interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> > +        reset-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
> > +        vdda-supply = <&vdda_reg>;
> > +        vddi-supply = <&vddi_reg>;
> > +        poll-interval = <20>;
> > +      };
> > +    };
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7608b714653f..4752d8436dbb 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -21431,6 +21431,12 @@ S:	Maintained
> >  F:	Documentation/ABI/testing/sysfs-class-firmware-attributes
> >  F:	drivers/platform/x86/think-lmi.?
> >
> > +TOUCHNETIX AXIOM I2C TOUCHSCREEN DRIVER
> > +M:	Kamel Bouhara <kamel.bouhara@bootlin.com>
> > +L:	linux-input@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml
> > +
> >  THUNDERBOLT DMA TRAFFIC TEST DRIVER
> >  M:	Isaac Hazan <isaac.hazan@intel.com>
> >  L:	linux-usb@vger.kernel.org
> > --
> > 2.25.1
> >



--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
