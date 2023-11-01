Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396DE7DE1A4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 14:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344212AbjKANYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344071AbjKANYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:24:10 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FE4FD;
        Wed,  1 Nov 2023 06:24:04 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163c.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4SL74w2bJqzyTs;
        Wed,  1 Nov 2023 15:23:57 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1698845040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EP5r+hILe5kaHwjZhyYeIl9Iu1hNzRM/jIu83owL1QU=;
        b=NHG/Gc+c3+TTxoKK99j1b05rmnYHK91oWkCfim/CpdMr0WoJ7yvatxlml+boqKPqa7W+Lf
        /xNUAQDXU09D7zzSSybyUNzOw4EwHFbXES31xUp773LZcQX27P7/4qiFS6LF62hZgQUhmM
        Fde9L0f5mERqdF4eRpMitwaTz5s8oTM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1698845040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EP5r+hILe5kaHwjZhyYeIl9Iu1hNzRM/jIu83owL1QU=;
        b=frS6vWBbymtxPwuul59DMvBaUoxetrMaVtz0F0jsDZAVPKNBG+gmXQtrCOzaR8ezOta+rP
        /0+KiujzanusNYb4AvvD3lZ/1rE90i7DBoIy4GVAo8JtmMd+GgMkSZRz2ZuCHlCfEvEHoe
        JQDYSleQsS4DdPitvyC8OFmMpbfFXns=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1698845040; a=rsa-sha256; cv=none;
        b=L+v71/cZaztjBioQR4YKO0jia+TcVrQ+BFRPygBM40d1lfGQHvLQwMHGjx3AMuC1o/kvsI
        qkgI8/jZOaM2j0Z3DBUcNCxnNAEw/99KDTqdRVhoSf6sdrp8EZrir0W+NFcmaWyHxN0Ase
        bjiJnEVNqCYzwzvaO4deSIuxIJPiK0Y=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 8B036634C93;
        Wed,  1 Nov 2023 15:23:56 +0200 (EET)
Date:   Wed, 1 Nov 2023 13:23:56 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Rob Herring <robh@kernel.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: media: i2c: add galaxycore,gc2145
 dt-bindings
Message-ID: <ZUJRbI9ff83gH6Ng@valkosipuli.retiisi.eu>
References: <20231011175735.1824782-1-alain.volmat@foss.st.com>
 <20231011175735.1824782-3-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011175735.1824782-3-alain.volmat@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain,

On Wed, Oct 11, 2023 at 07:57:29PM +0200, Alain Volmat wrote:
> Introduction of the Galaxy Core GC2145 XVGA CMOS camera sensor.
> 
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> ---
>  .../bindings/media/i2c/galaxycore,gc2145.yaml | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> new file mode 100644
> index 000000000000..94d194cf5452
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/galaxycore,gc2145.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Galaxy Core 1/5'' UXGA CMOS Image Sensor
> +
> +maintainers:
> +  - Alain Volmat <alain.volmat@foss.st.com>
> +
> +description:
> +  The Galaxy Core GC2145 is a high quality 2 Mega CMOS image sensor, for mobile
> +  phone camera applications and digital camera products. GC2145 incorporates a
> +  1616V x 1232H active pixel array, on-chip 10-bit ADC, and image signal
> +  processor. It is programmable through an I2C interface. Image data is sent
> +  either through a parallel interface or through MIPI CSI-2.
> +
> +allOf:
> +  - $ref: ../video-interface-devices.yaml#
> +
> +properties:
> +  compatible:
> +    const: galaxycore,gc2145
> +
> +  reg:
> +    const: 0x3c
> +
> +  clocks:
> +    maxItems: 1
> +
> +  powerdown-gpios:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  iovdd-supply:
> +    description: Power Supply for I/O circuits (1.7 - 3V).
> +
> +  avdd-supply:
> +    description: Power for analog circuit/sensor array (2.7 - 3V).
> +
> +  dvdd-supply:
> +    description: Power for digital core (1.7 - 1.9V).
> +
> +  orientation: true
> +
> +  rotation: true
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +    required:
> +      - endpoint

Could you add link-frequencies here, too?

> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - powerdown-gpios
> +  - reset-gpios
> +  - iovdd-supply
> +  - avdd-supply
> +  - dvdd-supply
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        camera@3c {
> +            compatible = "galaxycore,gc2145";
> +            reg = <0x3c>;
> +            clocks = <&clk_ext_camera>;
> +            iovdd-supply = <&scmi_v3v3_sw>;
> +            avdd-supply = <&scmi_v3v3_sw>;
> +            dvdd-supply = <&scmi_v3v3_sw>;
> +            powerdown-gpios = <&mcp23017 3 (GPIO_ACTIVE_LOW | GPIO_PUSH_PULL)>;
> +            reset-gpios = <&mcp23017 4 (GPIO_ACTIVE_LOW | GPIO_PUSH_PULL)>;
> +
> +            port {
> +                endpoint {
> +                    remote-endpoint = <&mipid02_0>;
> +                    data-lanes = <1 2>;
> +                };
> +            };
> +        };
> +    };
> +
> +...

-- 
Kind regards,

Sakari Ailus
