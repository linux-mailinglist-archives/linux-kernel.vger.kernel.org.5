Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB224759E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjGSTDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGSTDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:03:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B623F1BFC;
        Wed, 19 Jul 2023 12:02:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B7DF617C7;
        Wed, 19 Jul 2023 19:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB9BC433C8;
        Wed, 19 Jul 2023 19:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689793376;
        bh=u9hjwJitkzPQZ4YGpEFJThuMQKEBsoFdZK3Z8XQdi7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UfVv4zXoX/HoGwQFixyFKcBw1epZ6EU9rga+LvEFoVoQT+rA85w6wzkTQBKwcSGqk
         quaVfJHjbgopC3TNKpOwL0+mN9Xya+ZEFnn78gF7zbhbdWcBOB7Ad7Jbcb1WqGFu91
         LJxc2t+aX2IcIiujW1q9MX0cONET1JV34eoaGduMbVhwISNBKiBltHaNmbPXAXgU5/
         qtE5qqT/B8b0nNhG7Kum7xrbPH4S7wpxC23q8zpsfdcLijX84dKuXLQjheSPJgCYT4
         ZPQFe2BIkckANWq9ZjgzaAALCvpUxxSZwfy+n8hA8aUCcV8JFjkgRQ+u0jm8Ps/17w
         5qXUc1WE/fD6w==
Received: (nullmailer pid 589925 invoked by uid 1000);
        Wed, 19 Jul 2023 19:02:54 -0000
Date:   Wed, 19 Jul 2023 13:02:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
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
Message-ID: <20230719190254.GA578754-robh@kernel.org>
References: <20230719152147.355486-1-luca.ceresoli@bootlin.com>
 <20230719152147.355486-2-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719152147.355486-2-luca.ceresoli@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 05:21:46PM +0200, Luca Ceresoli wrote:
> Add bindings for LCD panels based on the ILITEK ILI9806E RGB controller
> connected over SPI and the "ShenZhen New Display Co NDS040480800-V3"
> 480x800 panel based on it.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  .../display/panel/ilitek,ili9806e.yaml        | 69 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
> new file mode 100644
> index 000000000000..42abc6923065
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/ilitek,ili9806e.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ilitek ILI9806E display panels
> +
> +maintainers:
> +  - Luca Ceresoli <luca.ceresoli@bootlin.com>
> +
> +description:
> +  This binding is for display panels using an Ilitek ILI9806E controller in
> +  SPI mode.
> +
> +allOf:
> +  - $ref: panel-common.yaml#

A SPI device should reference spi-peripheral-props.yaml as well.

> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          # ShenZhen New Display Co 3.97" 480x800 RGB a-SI TFT LCD
> +          - newdisplay,nds040480800-v3
> +      - const: ilitek,ili9806e
> +
> +  reg: true

maxItems: 1

> +  spi-max-frequency: true
> +  reset-gpios: true
> +  backlight: true
> +  port: true

Drop all these and ...

> +
> +required:
> +  - compatible
> +  - reg
> +  - port
> +
> +additionalProperties: false

... use "unevaluatedProperties" instead.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    backlight: backlight {
> +        compatible = "gpio-backlight";
> +        gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
> +    };

The exact backlight is outside the scope of this binding and should be 
dropped from the example.

> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        display@0 {
> +            compatible = "newdisplay,nds040480800-v3", "ilitek,ili9806e";
> +            reg = <0>;
> +            spi-max-frequency = <1000000>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&pinctrl_lcdgpios>;
> +            reset-gpios = <&gpio 26 GPIO_ACTIVE_LOW>;
> +            backlight = <&backlight>;
> +
> +            port {
> +                ili9806e_in: endpoint {
> +                    remote-endpoint = <&lcdif_out>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
