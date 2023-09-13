Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D9279ED7B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjIMPll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjIMPlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:41:18 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067D52696;
        Wed, 13 Sep 2023 08:40:54 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Rm4RS1gprz49Q8K;
        Wed, 13 Sep 2023 18:40:52 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1694619652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3PxqXy1uEoE/I7MNGiTPJMLnRS1V7BcFjruxaq9ULFA=;
        b=hi8STi2PX5RSxWXYf53WlSw/RjFtaKpYpbW9OpGQ3ToZOL7Ed2O9GX8AgNOi+Agw2YW27/
        7fIG4gLdiYSuXmLzPAfHCSl3yGTXRDe/d6XyZLLXZEjP0MS3WhySLjdywnAkLlzRh4R4nb
        O8iRXTHDJRBQ6H4otf2BI7Yk5eNikEqKD6GHixHDaXLUeP3GYuxAqZMIRQqIwYvxe7mCzE
        itUQ6vSVMhSYSYZsnRjdqFAL7btTj52LXC4s6COHr1y68pmqy37BGn9EZSoO1JSDE7V3jR
        fEixfEW2IHFuoTLaBVR15AE4y3y6IqttEcq0zC6OMiOKZurjfLCNpeJnX2rJZg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1694619652; a=rsa-sha256;
        cv=none;
        b=YjkRjWLsUrAmqUnySig9pWMIwdIv4vsJC02uljNnOfkgU1hLJtyLqWGpNqMpKXE1XfBSLL
        CRrUZIQbZI87GsniXgRq3SX46Dy+P4V76gJ675/43gKw8pCTpG5RVS3McbGnrkmoun8uYG
        n0P1KN0rwHE9bdhfSFuUxpsnVeMs5DFpELygSAW5K6ytiWrILj+A4RCxBzhIaOJxCLjzCl
        7TTP1UQoICJEtTgBK5twxXhJMwwtJCf2EI7KcALeBG1IO8QpcP6SmnhAINiaP65qKidoEx
        GA93YB1aZL6mwkbDSY8pA5NbjK7P7TLVuOAPJZU94qHavSfCDmu1qI86vKKxkw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1694619652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3PxqXy1uEoE/I7MNGiTPJMLnRS1V7BcFjruxaq9ULFA=;
        b=i5b7OWGnTkhOn31ZjdrotdGaqRwM6h3+kN+Z6ghYKyA1vyNYL5h10+Db6u3GwmSipZHkAH
        vqzpLB8tU9cPzi9ga408D3cUXbyhUpTXLsukn2BM8n5s++Qf33gvzW6/HJudV/emZrsbrI
        oH8qA6qAZ91DsWpqYksqX5x7bE6FyMGOnzJRFdOkmISFPs48HCC/Cm+cWXIY/ccRcP9cN1
        b6edEZHJpxtrZ3loG1N2vrVCRfPhYXY/zDTBKJIUMHbvOyq2F5mIvEEVQvWW64xzQm+C9M
        LEgboxmTdfHulhn4iVXz0aZ/ky0qNtaJQAVaUtfxQ/QWDjCXjXYaYUMaSk7JUA==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 9DD5D634C93;
        Wed, 13 Sep 2023 18:40:51 +0300 (EEST)
Date:   Wed, 13 Sep 2023 15:40:51 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Fabio Estevam <festevam@denx.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        linux-media@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3] dt-bindings: media: Add OV5642
Message-ID: <ZQHYAxAZxD1JMRHr@valkosipuli.retiisi.eu>
References: <20230802160326.293420-1-festevam@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802160326.293420-1-festevam@denx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On Wed, Aug 02, 2023 at 01:03:26PM -0300, Fabio Estevam wrote:
> As explained in the description text from trivial-devices.yaml:
> 
> "This is a list of trivial I2C and SPI devices that have simple device tree
> bindings, consisting only of a compatible field, an address and possibly an
> interrupt line."
> 
> A camera device does not fall into this category as it needs other
> properties such as regulators, reset and powerdown GPIOs, clocks,
> media endpoint.
> 
> Remove the OV5642 entry from trivial-devices.yaml and add its own
> ovti,ov5642.yaml.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes since v2:
> - Made ovti,ov5642.yaml dual-licensed (Conor)
> - Fixed whitespace warning (Conor)
> - Squased both patches (Conor)
> - Added Conor's Reviewed-by tag.
> - Added linux-media on Cc.
> 
>  .../bindings/media/i2c/ovti,ov5642.yaml       | 118 ++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |   2 -
>  2 files changed, 118 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5642.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5642.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5642.yaml
> new file mode 100644
> index 000000000000..b48f1bc6aca4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5642.yaml
> @@ -0,0 +1,118 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/ovti,ov5642.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OmniVision OV5642 Image Sensor
> +
> +maintainers:
> +  - Fabio Estevam <festevam@gmail.com>
> +
> +allOf:
> +  - $ref: /schemas/media/video-interface-devices.yaml#
> +
> +properties:
> +  compatible:
> +    const: ovti,ov5642
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description: XCLK Input Clock
> +
> +  clock-names:
> +    const: xclk
> +
> +  AVDD-supply:
> +    description: Analog voltage supply, 2.8V.
> +
> +  DVDD-supply:
> +    description: Digital core voltage supply, 1.5V.
> +
> +  DOVDD-supply:
> +    description: Digital I/O voltage supply, 1.8V.
> +
> +  powerdown-gpios:
> +    maxItems: 1
> +    description: Reference to the GPIO connected to the powerdown pin, if any.
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: Reference to the GPIO connected to the reset pin, if any.
> +
> +  rotation:
> +    enum:
> +      - 0
> +      - 180
> +
> +  port:
> +    description: Digital Output Port
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    additionalProperties: false
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          clock-lanes:
> +            const: 0
> +
> +          data-lanes:
> +            minItems: 1
> +            maxItems: 2
> +            items:
> +              enum: [1, 2]
> +
> +          bus-width:
> +            enum: [8, 10]
> +
> +          data-shift:
> +            enum: [0, 2]

You seem to have properties here that are specific to both parallel and
CSI-2 buses. Which one does the sensor use?

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +      #include <dt-bindings/gpio/gpio.h>
> +
> +      i2c {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          camera@3c {
> +              compatible = "ovti,ov5642";
> +              pinctrl-names = "default";
> +              pinctrl-0 = <&pinctrl_ov5642>;
> +              reg = <0x3c>;
> +              clocks = <&clk_ext_camera>;
> +              clock-names = "xclk";
> +              DOVDD-supply = <&vgen4_reg>;
> +              AVDD-supply = <&vgen3_reg>;
> +              DVDD-supply = <&vgen2_reg>;
> +              powerdown-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
> +              reset-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
> +
> +              port {
> +                  /* Parallel bus endpoint */
> +                  ov5642_to_parallel: endpoint {
> +                      remote-endpoint = <&parallel_from_ov5642>;
> +                      bus-width = <8>;
> +                      data-shift = <2>; /* lines 9:2 are used */
> +                      hsync-active = <0>;
> +                      vsync-active = <0>;
> +                      pclk-sample = <1>;
> +                  };
> +              };
> +          };
> +      };
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 40bc475ee7e1..ab1423a4aa7f 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -313,8 +313,6 @@ properties:
>            - nuvoton,w83773g
>              # OKI ML86V7667 video decoder
>            - oki,ml86v7667
> -            # OV5642: Color CMOS QSXGA (5-megapixel) Image Sensor with OmniBSI and Embedded TrueFocus
> -          - ovti,ov5642
>              # 48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
>            - plx,pex8648
>              # Pulsedlight LIDAR range-finding sensor

-- 
Regards,

Sakari Ailus
