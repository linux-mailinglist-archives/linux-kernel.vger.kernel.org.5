Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D0A7694D7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjGaL3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjGaL3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:29:38 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFD410D8;
        Mon, 31 Jul 2023 04:29:31 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RDwxj0bJ2z49Pyr;
        Mon, 31 Jul 2023 14:29:28 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1690802969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mx3rPlJKDFP2Fxu+9vXW7le8qWgIOGuOrFkJ0k6c1A0=;
        b=ZUmBpj9NgHNJL3F8TJfRogLL72/5Chl5UDqZ7sNjh2Yf17BloZYQskYB3utZDliiDeu3M4
        PzBtS+MG0WGD3xZp3OEjUZarP+dS6vBxQ99fpyRXh/z6OJI9BaICvA+ZpfTbqupwSZ5kLm
        ENoz+BCMvSgZj6fwKiTnUFZ9Tnsaaath0fpG08s+kSSl9OR0vYKoX+j1R+khqwn2KCrVWu
        kzQVJPgzEAFYNtUI6xBo0pjmukC3DPsZm/CON4pWeAGFOAu24+rKlS2H1DWWpxOFbUS3Rf
        CO3lOEnmzUaaSC7G3hR6uKLol6isgXYFhAJxpC24bmPuLltfp9kfbL8qNWvyOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1690802969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mx3rPlJKDFP2Fxu+9vXW7le8qWgIOGuOrFkJ0k6c1A0=;
        b=DobNKNkm7RYiXefm7CtVFtGfEikG1hjJJ6X0S9oDruKiPhaVSU7X1+DAEotyPkwjnlWqZD
        yAXsuzfqvmcKhTQqMSP6IwrovlhxIa0QYGaMGf5NjBo1hwgk5pySHfKMLvW+U8+YDfchd7
        Q8623IQ90e8fXuugkNvFEVA24SWPydBTQR9cr4BANu57j0DImsk2CiSdnsWgG0KpyQk3ID
        cCevILZahAq+UXICHqmo0Wb4k6fKH4ZcFZv5wOtHLdNFsKkKJYjqIt36B/Unw2WxirhSaU
        CVwliaB01CUh5NIWSmkGO0O+ZqPu9m4xFvSg8i7hlWRUzMgWOgJn4ItHhCrC1g==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1690802969; a=rsa-sha256;
        cv=none;
        b=AV2VfgDYcZrmWcdZXKmT47XwkFOUIDQx03FGkKWHv1YdftK033tMWOvNWah7J04egAMfVa
        ti5ASP/eDM+VRfV4+XSP3QPEGmuRdDLiXrhcv/ApY+hmnz0Fa2FBaLkFs1T+AUU3rAaiAZ
        +VXDw+718RapQSUzO1O60Ip55LU5R7+O0MpdIsMUb/GGXSfdiMiBp8lk011FbdCnB6G0eq
        daE4QJjQkxiG65mWX6lykKaaj/lP37svG0N+Ur3Dk9YHOKrGf4NaS8HNCAstVZLsKeQehl
        7IcdXjwlu5eFxjAhv0sG5DDtPEu6WNlQxGbZQKymJnXVl27NPAZm+QBJ10+V9A==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 7DEE5634C95;
        Mon, 31 Jul 2023 14:29:28 +0300 (EEST)
Date:   Mon, 31 Jul 2023 11:29:28 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Rob Herring <robh@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dt-bindings: Convert Omnivision OV7251 to DT
 schema
Message-ID: <ZMebGFUTubMDvVDs@valkosipuli.retiisi.eu>
References: <20230707210646.868758-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707210646.868758-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Jul 07, 2023 at 03:06:46PM -0600, Rob Herring wrote:
> Convert the OmniVision OV7251 Image Sensor binding to DT schema format.
> 
> vddd-supply was listed as required, but the example and actual user
> don't have it. Also, the data brief says it has an internal regulator,
> so perhaps it is truly optional.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Same comment on this than the ov5693/5 bindings: we should have
link-frequency here. Although I guess it could be added by a separate
patch (I can write one if you like).

The driver already checks for this.

> ---
>  .../devicetree/bindings/media/i2c/ov7251.txt  |  52 ---------
>  .../bindings/media/i2c/ovti,ov7251.yaml       | 105 ++++++++++++++++++
>  2 files changed, 105 insertions(+), 52 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/i2c/ov7251.txt
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov7251.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ov7251.txt b/Documentation/devicetree/bindings/media/i2c/ov7251.txt
> deleted file mode 100644
> index 8281151f7493..000000000000
> --- a/Documentation/devicetree/bindings/media/i2c/ov7251.txt
> +++ /dev/null
> @@ -1,52 +0,0 @@
> -* Omnivision 1/7.5-Inch B&W VGA CMOS Digital Image Sensor
> -
> -The Omnivision OV7251 is a 1/7.5-Inch CMOS active pixel digital image sensor
> -with an active array size of 640H x 480V. It is programmable through a serial
> -I2C interface.
> -
> -Required Properties:
> -- compatible: Value should be "ovti,ov7251".
> -- clocks: Reference to the xclk clock.
> -- clock-names: Should be "xclk".
> -- clock-frequency: Frequency of the xclk clock.
> -- enable-gpios: Chip enable GPIO. Polarity is GPIO_ACTIVE_HIGH. This corresponds
> -  to the hardware pin XSHUTDOWN which is physically active low.
> -- vdddo-supply: Chip digital IO regulator.
> -- vdda-supply: Chip analog regulator.
> -- vddd-supply: Chip digital core regulator.
> -
> -The device node shall contain one 'port' child node with a single 'endpoint'
> -subnode for its digital output video port, in accordance with the video
> -interface bindings defined in
> -Documentation/devicetree/bindings/media/video-interfaces.txt.
> -
> -Example:
> -
> -	&i2c1 {
> -		...
> -
> -		ov7251: camera-sensor@60 {
> -			compatible = "ovti,ov7251";
> -			reg = <0x60>;
> -
> -			enable-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&camera_bw_default>;
> -
> -			clocks = <&clks 200>;
> -			clock-names = "xclk";
> -			clock-frequency = <24000000>;
> -
> -			vdddo-supply = <&camera_dovdd_1v8>;
> -			vdda-supply = <&camera_avdd_2v8>;
> -			vddd-supply = <&camera_dvdd_1v2>;
> -
> -			port {
> -				ov7251_ep: endpoint {
> -					clock-lanes = <1>;
> -					data-lanes = <0>;
> -					remote-endpoint = <&csi0_ep>;
> -				};
> -			};
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov7251.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov7251.yaml
> new file mode 100644
> index 000000000000..8d939858d950
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov7251.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/ovti,ov7251.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OmniVision OV7251 Image Sensor
> +
> +description:
> +  The Omnivision OV7251 is a 1/7.5-Inch CMOS active pixel digital image sensor
> +  with an active array size of 640H x 480V. It is programmable through a serial
> +  I2C interface.
> +
> +maintainers:
> +  - Todor Tomov <todor.too@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: ovti,ov7251
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
> +  clock-frequency:
> +    description: Frequency of the xclk clock in Hz.
> +
> +  vdda-supply:
> +    description: Analog voltage supply, 2.8 volts
> +
> +  vddd-supply:
> +    description: Digital core voltage supply, 1.2 volts
> +
> +  vdddo-supply:
> +    description: Digital I/O voltage supply, 1.8 volts
> +
> +  enable-gpios:
> +    maxItems: 1
> +    description:
> +      Reference to the GPIO connected to the XSHUTDOWN pin, if any. Polarity
> +      is GPIO_ACTIVE_HIGH.
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
> +            maximum: 1
> +
> +          data-lanes:
> +            maxItems: 1
> +
> +        required:
> +          - data-lanes
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - vdddo-supply
> +  - vdda-supply
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
> +            compatible = "ovti,ov7251";
> +            reg = <0x3c>;
> +            clocks = <&clks 1>;
> +            clock-frequency = <24000000>;
> +            vdddo-supply = <&ov7251_vdddo_1v8>;
> +            vdda-supply = <&ov7251_vdda_2v8>;
> +            vddd-supply = <&ov7251_vddd_1v5>;
> +            enable-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
> +
> +            port {
> +                ov7251_ep: endpoint {
> +                    remote-endpoint = <&csi0_ep>;
> +                    clock-lanes = <1>;
> +                    data-lanes = <0>;
> +                };
> +            };
> +        };
> +    };
> +...
> -- 
> 2.40.1
> 

-- 
Kind regards,

Sakari Ailus
