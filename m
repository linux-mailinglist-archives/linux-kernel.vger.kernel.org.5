Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125FB7907D9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 14:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352168AbjIBMks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 08:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352121AbjIBMkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 08:40:47 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFA010F0;
        Sat,  2 Sep 2023 05:40:43 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkzdf0gkyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4506:4f15::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4RdDyV3QGmzybw;
        Sat,  2 Sep 2023 15:40:33 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1693658437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YY5wTcddqfyox2ECkwFzF7cWlIJ2LZA/PTeCQ10CFUY=;
        b=ReHRi9GQ9YQD5reW7viAms/nZf8GeKeJBmL6PkHXCXl6ocGGg7SsVX8YubEeRgfE7cITfk
        TXOmUOoXk/RRBzXqQsSB97ERdkH7LtJgfRI6fqAOoCPA8N9BDKMVv8b2rqawOCcakb3Gci
        9zYaN264lxVI223oajJ6VhsnexGAbMw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1693658437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YY5wTcddqfyox2ECkwFzF7cWlIJ2LZA/PTeCQ10CFUY=;
        b=Jhn/NH8jB74Gg7maonb9QxlMWZ5Cu7OLJcMT++D+aRg+jURLu1jVHCJToWS/o36AecXbrS
        wogYTrnk5JRyKI3tqnUuOumJMVQwCZURhSjBbEjfwmhtgHt5fixwm3+KuEK+UH9GUKM5K2
        kF3ggytTZxlPnl+0BBOuuBKeaVPalQw=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1693658437; a=rsa-sha256; cv=none;
        b=A20WoSekUJrdw1LOw+eO8Vszh/SM28JcAzKrhvY61LVz1kVzo3v+ZlHmX+KlFDSgcxHq55
        l3XzbUkXmoflNpLoiCyQiYnqQpeS874ulABsZNaTC+9zh2Bf/kcaLc4qSfeUQHSlSXB4tv
        X+tR0huQZqTrWjVGvMe2tLVh81jY+Dg=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 77AAD634C95;
        Sat,  2 Sep 2023 15:40:33 +0300 (EEST)
Date:   Sat, 2 Sep 2023 12:40:33 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jackson <lee.jackson@arducam.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        kieran.bingham@ideasonboard.com,
        Marco Felsch <m.felsch@pengutronix.de>,
        jacopo.mondi@ideasonboard.com
Subject: Re: [PATCH 1/2] media: dt-bindings: imx519: Add IMX519 DT bindings
Message-ID: <ZPMtQYEJGHL9kp/k@valkosipuli.retiisi.eu>
References: <20230727154108.308320-1-umang.jain@ideasonboard.com>
 <20230727154108.308320-2-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727154108.308320-2-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

On Thu, Jul 27, 2023 at 09:11:07PM +0530, Umang Jain wrote:
> From: Lee Jackson <lee.jackson@arducam.com>
> 
> Add YAML device tree binding documentation for IMX519 CMOS
> image sensor.
> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  .../bindings/media/i2c/sony,imx519.yaml       | 113 ++++++++++++++++++
>  1 file changed, 113 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx519.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx519.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx519.yaml
> new file mode 100644
> index 000000000000..6f38b09890d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx519.yaml
> @@ -0,0 +1,113 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/imx519.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sony 1/2.5-Inch 16Mpixel CMOS Digital Image Sensor
> +
> +maintainers:
> +  - Lee Jackson <lee.jackson@arducam.com>
> +
> +description: |-
> +  The Sony IMX519 is a 1/2.5-inch CMOS active pixel digital image sensor
> +  with an active array size of 4656H x 3496V. It is programmable through
> +  I2C interface. The I2C address is fixed to 0x1A as per sensor data sheet.
> +  Image data is sent through MIPI CSI-2, which is configured as either 2 or
> +  4 data lanes.
> +
> +properties:
> +  compatible:
> +    const: sony,imx519
> +
> +  reg:
> +    description: I2C device address
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  VDIG-supply:
> +    description:
> +      Digital I/O voltage supply, 1.05 volts
> +
> +  VANA-supply:
> +    description:
> +      Analog voltage supply, 2.8 volts
> +
> +  VDDL-supply:
> +    description:
> +      Digital core voltage supply, 1.8 volts
> +
> +  reset-gpios:
> +    description: |-
> +      Reference to the GPIO connected to the xclr pin, if any.
> +      Must be released (set high) after all supplies and INCK are applied.
> +
> +  # See ../video-interfaces.txt for more details
> +  port:
> +    type: object
> +    properties:
> +      endpoint:
> +        type: object
> +        properties:

I think you should have, something alike (from mipi-ccs.yaml):

  port:
    $ref: /schemas/graph.yaml#/$defs/port-base
    additionalProperties: false

    properties:
      endpoint:
        $ref: /schemas/media/video-interfaces.yaml#
        unevaluatedProperties: false


See mipi-ccs.yaml on examples for some properties below. E.g.
link-frequencies is described in video-interfaces.yaml, no need to describe
it here.

> +          data-lanes:
> +            description: |-
> +              The sensor supports either two-lane, or four-lane operation.
> +              For two-lane operation the property must be set to <1 2>.
> +            items:
> +              - const: 1
> +              - const: 2

I guess the device also supports single lane operation?

In any case minItems/maxItems here should be enough.

> +
> +          clock-noncontinuous:
> +            type: boolean
> +            description: |-
> +              MIPI CSI-2 clock is non-continuous if this property is present,
> +              otherwise it's continuous.
> +
> +          link-frequencies:
> +            allOf:
> +              - $ref: /schemas/types.yaml#/definitions/uint64-array
> +            description:
> +              Allowed data bus frequencies.
> +
> +        required:
> +          - link-frequencies
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - VANA-supply
> +  - VDIG-supply
> +  - VDDL-supply
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        imx519: sensor@1a {
> +            compatible = "sony,imx519";
> +            reg = <0x1a>;
> +            clocks = <&imx519_clk>;
> +            VANA-supply = <&imx519_vana>;   /* 2.8v */
> +            VDIG-supply = <&imx519_vdig>;   /* 1.05v */
> +            VDDL-supply = <&imx519_vddl>;   /* 1.8v */
> +
> +            port {
> +                imx519_0: endpoint {
> +                    remote-endpoint = <&csi1_ep>;
> +                    data-lanes = <1 2>;
> +                    clock-noncontinuous;
> +                    link-frequencies = /bits/ 64 <408000000>;
> +                };
> +            };
> +        };
> +    };
> +
> +...

-- 
Kind regards,

Sakari Ailus
