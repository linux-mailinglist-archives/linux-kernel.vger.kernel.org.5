Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B4875B07A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjGTNxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjGTNxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:53:24 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D989B2737;
        Thu, 20 Jul 2023 06:52:54 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C984D4000D;
        Thu, 20 Jul 2023 13:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689861161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aqgjGCqvaiSNlmDsRmBgwW6pMJtbiMAZmpY9wcvjHx8=;
        b=Q+VuocpWXVnPx1WTifgxymPhNNJ0KxzjDRTn/uTlgSnJQa8DltTxIsUVzHI+DJz8PUVpE8
        Hce1XkYFmfI4WQ7tmRnAblRvwb/ZgYMGFjxF/N0RNV7kGGlWBnulI3kB7Qfq43QzXsaZXI
        lScIHIIm0wrdphLQZoeU0ZJ0lmplkBs+/INiA8sQpsUDuK9QGQTLFMHO7zYZjbMDOa7E7m
        OsEcxMwax0gFuzTlzfoWHCsltwSEm44rvl3DWnf9Efb+t0LPhGVw0Su208bw0EYJ28cUTs
        z1zfaaX84kgrW5QOwHJ1FfoCYugcrbn7kvaZv+5nuxwZA4kCuzueYb3uaT4c3g==
Date:   Thu, 20 Jul 2023 15:52:38 +0200
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH 2/3] dt-bindings: display: panel: Add panels based on
 ILITEK ILI9806E
Message-ID: <20230720155238.6fb8ac8c@booty>
In-Reply-To: <20230719190254.GA578754-robh@kernel.org>
References: <20230719152147.355486-1-luca.ceresoli@bootlin.com>
        <20230719152147.355486-2-luca.ceresoli@bootlin.com>
        <20230719190254.GA578754-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

thanks for reviewing.

On Wed, 19 Jul 2023 13:02:54 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, Jul 19, 2023 at 05:21:46PM +0200, Luca Ceresoli wrote:
> > Add bindings for LCD panels based on the ILITEK ILI9806E RGB controller
> > connected over SPI and the "ShenZhen New Display Co NDS040480800-V3"
> > 480x800 panel based on it.
> > 
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > ---
> >  .../display/panel/ilitek,ili9806e.yaml        | 69 +++++++++++++++++++
> >  MAINTAINERS                                   |  6 ++
> >  2 files changed, 75 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
> > new file mode 100644
> > index 000000000000..42abc6923065
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
> > @@ -0,0 +1,69 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/panel/ilitek,ili9806e.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Ilitek ILI9806E display panels
> > +
> > +maintainers:
> > +  - Luca Ceresoli <luca.ceresoli@bootlin.com>
> > +
> > +description:
> > +  This binding is for display panels using an Ilitek ILI9806E controller in
> > +  SPI mode.
> > +
> > +allOf:
> > +  - $ref: panel-common.yaml#  
> 
> A SPI device should reference spi-peripheral-props.yaml as well.
> 
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          # ShenZhen New Display Co 3.97" 480x800 RGB a-SI TFT LCD
> > +          - newdisplay,nds040480800-v3
> > +      - const: ilitek,ili9806e
> > +
> > +  reg: true  
> 
> maxItems: 1
> 
> > +  spi-max-frequency: true
> > +  reset-gpios: true
> > +  backlight: true
> > +  port: true  
> 
> Drop all these and ...
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - port
> > +
> > +additionalProperties: false  
> 
> ... use "unevaluatedProperties" instead.
> 
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    backlight: backlight {
> > +        compatible = "gpio-backlight";
> > +        gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
> > +    };  
> 
> The exact backlight is outside the scope of this binding and should be 
> dropped from the example.

As this comes from copy-pasting from the bindings yaml for another
panel, would it be useful if I send a patch to remove it?

Requested changes queued for v2.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
