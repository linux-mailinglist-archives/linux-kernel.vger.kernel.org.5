Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619317A98BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjIURv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjIURv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:51:28 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1901C585FC;
        Thu, 21 Sep 2023 10:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=+1FtBudE1t2AIFo9XZGtwN+rqnrYV1AoU/UkJZpAeEg=; b=lEEA3teq+EzGXLB9n74autwhf/
        TH3GpF4VYY476EPxPcGKfvLptpOe8+97XsqtOuXkIpfRnuKdde56P/y1XSfq2ZGHxFpecCBAiKgm1
        rOmoLGAIvpmsytgLCyPcagB4IQc7+2TL0B7STBPV/LV7OQTEWa7muWfCL7lU3vzVQlvQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:37928 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qjLdZ-0008R2-7p; Thu, 21 Sep 2023 11:30:42 -0400
Date:   Thu, 21 Sep 2023 11:30:40 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hvilleneuve@dimonoff.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Message-Id: <20230921113040.2dafb3d50cfdd8727de42356@hugovil.com>
In-Reply-To: <20230921-decorated-patronize-45285045adbf@spud>
References: <20230920152015.1376838-1-hugo@hugovil.com>
        <20230920152015.1376838-5-hugo@hugovil.com>
        <20230921-decorated-patronize-45285045adbf@spud>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 4/4] dt-bindings: sc16is7xx: convert to YAML
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023 14:45:06 +0100
Conor Dooley <conor@kernel.org> wrote:

> Hey,
> 
> On Wed, Sep 20, 2023 at 11:20:15AM -0400, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Convert binding from text format to YAML.
> > 
> > Additions to original text binding:
> >   - add rs485 reference.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  .../bindings/serial/nxp,sc16is7xx.txt         | 118 ----------------
> >  .../bindings/serial/nxp,sc16is7xx.yaml        | 126 ++++++++++++++++++
> >  2 files changed, 126 insertions(+), 118 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> >  create mode 100644 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> 
> > diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> > new file mode 100644
> > index 000000000000..508639e09e06
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> > @@ -0,0 +1,126 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/serial/nxp,sc16is7xx.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP SC16IS7xx advanced Universal Asynchronous Receiver-Transmitter (UART)
> 
> nit, but my OCD was triggered - capitalise the a in "advanced"?

Hi Conor,
no problem, I like that :)
Will fix it for V2.

 
> > +
> > +maintainers:
> > +  - Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nxp,sc16is740
> > +      - nxp,sc16is741
> > +      - nxp,sc16is750
> > +      - nxp,sc16is752
> > +      - nxp,sc16is760
> > +      - nxp,sc16is762
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +    description: Reference to the IC source clock.
> 
> You could probably drop this, if it only has one clock it's a bit
> redundant.

I don't understand, because there is already a 'clocks' property in
the examples (and also in my real board DTS file) and if I remove it
here it will cause a warning:

serial@51: Unevaluated properties are not allowed ('clocks' was
unexpected)

 
> > +  clock-frequency:
> > +    description: |
> 
> This | should not be needed here, there's no formatting to preserve.

Done.


> 
> > +      When there is no clock provider visible to the platform, this
> > +      is the source crystal or external clock frequency for the IC in Hz.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 1
> > +    maximum: 80000000
> > +
> > +  gpio-controller:
> > +    description: Marks the device node as a GPIO controller.
> > +    type: boolean
> > +
> > +  "#gpio-cells":
> > +    const: 2
> > +
> > +  gpio-line-names:
> > +    minItems: 1
> > +    maxItems: 8
> > +
> > +  nxp,irda-mode-ports:
> > +    description: |
> > +      An array that lists the indices of the port that should operate in IrDA
> > +      mode:
> > +      0: port A
> > +      1: port B
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    minItems: 1
> > +    maxItems: 2
> > +    items:
> > +      minimum: 0
> > +      maximum: 1
> > +
> > +  nxp,modem-control-line-ports:
> > +    description: |
> > +      An array that lists the indices of the port that should have shared GPIO
> > +      lines configured as modem control lines:
> > +      0: port A
> > +      1: port B
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    minItems: 1
> > +    maxItems: 2
> > +    items:
> > +      minimum: 0
> > +      maximum: 1
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +  - $ref: /schemas/serial/serial.yaml#
> > +  - $ref: /schemas/serial/rs485.yaml#
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +oneOf:
> > +  - required:
> > +      - clocks
> > +  - required:
> > +      - clock-frequency
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    serial0: serial@51 {
> 
> These labels are not used and should be removed.

Done.

Thank you,
Hugo.



> Otherwise, conversion looks aight to me.
> 
> Thanks,
> Conor.
> 
> > +        compatible = "nxp,sc16is750";
> > +        reg = <0x51>;
> > +        clocks = <&clk20m>;
> > +        interrupt-parent = <&gpio3>;
> > +        interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> > +        gpio-controller;
> > +        #gpio-cells = <2>;
> > +    };
> > +
> > +    serial1: serial@53 {
> > +        compatible = "nxp,sc16is752";
> > +        reg = <0x53>;
> > +        clocks = <&clk20m>;
> > +        interrupt-parent = <&gpio3>;
> > +        interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> > +        nxp,modem-control-line-ports = <1>; /* Port 1 as modem control lines */
> > +        gpio-controller; /* Port 0 as GPIOs */
> > +        #gpio-cells = <2>;
> > +    };
> > +
> > +    serial2: serial@54 {
> > +        compatible = "nxp,sc16is752";
> > +        reg = <0x54>;
> > +        clocks = <&clk20m>;
> > +        interrupt-parent = <&gpio3>;
> > +        interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> > +        nxp,modem-control-line-ports = <0 1>; /* Ports 0 and 1 as modem control lines */
> > +    };
> > -- 
> > 2.30.2
> > 
