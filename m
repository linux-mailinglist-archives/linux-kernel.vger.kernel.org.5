Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249847C03BE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343547AbjJJSw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjJJSw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:52:57 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7F8BA;
        Tue, 10 Oct 2023 11:52:53 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F41BB1C0003;
        Tue, 10 Oct 2023 18:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696963971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G6TyWPGOTCQei3+6/j4JAVG4rhVxNVZHdqlVHTMwl4k=;
        b=L9D9lnWR1IbyPM0Hgupj4h3W6Tgv/Zy2hAn3OiZdEPbp0tCff7ANt2b9Q3HOTR80WB7K6D
        Vd7CcAwRONMbr1TBu7DMpqM6tx35wBc0flR9mZiPs5juY5qi18bZWe5eh91FwduGsDqEUh
        a+bXuifqWYv2Do+8o/1PA+9ZVugzwFYjZi4TTvEwj6FJxYEX+R5hBFOtfKTbOpWeuCSx5G
        jN2Mx1/N6OhL7XRYLdZDNQaUVpPQhJuTIzyaYOmICIvV5EWzHdlmgLyLu5zOypgq/lGoHH
        ANa8wrm4fseDAl9jLtpAEEMMAP3Owr88cH/xJXu9K6JxVLY/EmU17lPgpDn0fw==
Date:   Tue, 10 Oct 2023 20:52:48 +0200
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, paul.kocialkowski@bootlin.com
Subject: Re: [PATCH v6 2/3] media: dt-bindings: media: i2c: Add bindings for
 TW9900
Message-ID: <ZSWdgMZGW0MlLqW5@Host-002>
References: <cover.1696608809.git.mehdi.djait@bootlin.com>
 <6ad44a04366e65d5baec08dd966f5c81995d626d.1696608809.git.mehdi.djait@bootlin.com>
 <20231009021838.GG5121@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009021838.GG5121@pendragon.ideasonboard.com>
X-GND-Sasl: mehdi.djait@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi laurent,

Thank you for the review.

On Mon, Oct 09, 2023 at 05:18:38AM +0300, Laurent Pinchart wrote:
> Hi Mehdi,
> 
> Thank you for the patch.
> 
> On Fri, Oct 06, 2023 at 06:25:29PM +0200, Mehdi Djait wrote:
> > The Techwell TW9900 is a video decoder supporting multiple input
> > standards, such as PAL and NTSC, and outputs a BT.656 video
> > signal.
> > 
> > It's designed to be low-power, posesses some features such as a
> > programmable comb-filter, and automatic input standard detection
> > 
> > Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> > ---
> > V5->V6: 
> > - This commit had a "Reviewed-by: Rob Herring <robh@kernel.org>" Tag but
> >   decided not to collect it because the last Iteration was more than 2
> >   years ago
> > - removed SECAM from the mentioned standards
> > - changed maintainer
> > 
> > V4->V5: 
> > - renamed the file to match the compatible string, and referenced
> >   the graph.yaml schema
> > 
> > V3->V4: 
> > - add the missing reset-gpios node to the binding
> > 
> > V2->V3: 
> > - fix the example not compiling due to a typo in the reset-gpios
> >   node.
> > 
> >  .../bindings/media/i2c/techwell,tw9900.yaml   | 61 +++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml b/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
> > new file mode 100644
> > index 000000000000..24bbbff5cc01
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
> > @@ -0,0 +1,61 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/i2c/techwell,tw9900.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Techwell TW9900 NTSC/PAL video decoder
> > +
> > +maintainers:
> > +  - Mehdi Djait <mehdi.djait@bootlin.com>
> > +
> > +description:
> > +  The tw9900 is a multi-standard video decoder, supporting NTSC, PAL standards
> > +  with auto-detection features.
> > +
> > +properties:
> > +  compatible:
> > +    const: techwell,tw9900
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vdd-supply:
> > +    description: VDD power supply
> > +
> > +  reset-gpios:
> > +    description: GPIO descriptor for the RESET input pin
> > +    maxItems: 1
> 
> How about the power down GPIO ?

I will add the power-down GPIO.

> 
> The chip requires a clock, which is provided by a crystal oscillator in
> the block diagram I found. Does it also support an external clock ? If
> so the bindings should support it, although this could be added later.
> 
> > +
> > +  port:
> > +    $ref: /schemas/graph.yaml#/properties/port
> > +    description:
> > +      Video port for the decoder output.
> 
> How about input ports, connected to nodes that model the connector(s) ?
>  

Could this be added later. Tbh I am not familiar with this. 
But if it must be added now: Would this be a correct binding: 

  ports:
    $ref: /schemas/graph.yaml#/properties/ports

    patternProperties:
      "^port@[0-1]$":
        $ref: /schemas/graph.yaml#/properties/port
        description: Input port nodes for analog inputs.

    properties:
      port@2:
        $ref: /schemas/graph.yaml#/properties/port
        description: Video port for the decoder output.

and in the example:
...
            ports {
                #address-cells = <1>;
                #size-cells = <0>;

                port@2 {
                    reg = <2>;

                    endpoint {
                        remote-endpoint = <&vip_in>;
                    };
                };
            };
...

--
Kind Regards
Mehdi Djait
