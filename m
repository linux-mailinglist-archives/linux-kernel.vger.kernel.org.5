Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF027CCC8E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344407AbjJQTs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344418AbjJQTsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:48:54 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157E493;
        Tue, 17 Oct 2023 12:48:53 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3af65455e7cso4031817b6e.1;
        Tue, 17 Oct 2023 12:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697572132; x=1698176932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OFfScDbSNQGFHtsnm2elv68+EUkC5AazfQeYRwzttU=;
        b=Fi8KIIQCDxo1M9r9tupwIM0tCoZnTXxQcnHzJK6LBna6hXwT2SsjTuYjZD9E4jO5OO
         zCn3HYniy33YR1k+UWvOzoXH1ZvgsSLsxpWCAF45f9knWwDdSLwHvQ1tbax6UKtiv0sy
         Tu9RH/TANEshwbzdU8MzMB18u9XHoh1RNHfHHssc6N75LwGOqPRX5Wrr2ks4IxPdwX4X
         sPKe1Nq4vREj67uKCjhMtCM58ebVjUeaO6+gO+8os8PEYyDXU1DOGZGBXRk+p/IvCocO
         27/wQopg9O5/lpwNfX50eslpthkqlGV06NC81T6MdI3cbBREaLIvGFHwdO+2JB/dOVQ0
         38/Q==
X-Gm-Message-State: AOJu0YyKYIMi4KZHTIi38FWTMPl15H5riUcc/z9PF6lv8OAIEMiTBXDE
        awxZRpkvGKQgjmpLAoZtFQ==
X-Google-Smtp-Source: AGHT+IEsb/OGbaJmy2ZQDNz9KFR5sNPCXNONhQzp69qEAF5KfVi63SR6pfGyNkdxV1M1obkTXoCJ6Q==
X-Received: by 2002:a05:6808:1694:b0:3ae:1351:d0f with SMTP id bb20-20020a056808169400b003ae13510d0fmr4060402oib.22.1697572132344;
        Tue, 17 Oct 2023 12:48:52 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bh25-20020a056808181900b003b274008e46sm373254oib.0.2023.10.17.12.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:48:51 -0700 (PDT)
Received: (nullmailer pid 2570287 invoked by uid 1000);
        Tue, 17 Oct 2023 19:48:50 -0000
Date:   Tue, 17 Oct 2023 14:48:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mehdi Djait <mehdi.djait@bootlin.com>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, paul.kocialkowski@bootlin.com
Subject: Re: [PATCH v7 2/3] media: dt-bindings: media: i2c: Add bindings for
 TW9900
Message-ID: <20231017194850.GA2565799-robh@kernel.org>
References: <cover.1697463708.git.mehdi.djait@bootlin.com>
 <d5b2b2584fd471a037e574086bfd193b22fb9587.1697463708.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5b2b2584fd471a037e574086bfd193b22fb9587.1697463708.git.mehdi.djait@bootlin.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 03:58:32PM +0200, Mehdi Djait wrote:
> The Techwell TW9900 is a video decoder supporting multiple input
> standards, such as PAL and NTSC, and outputs a BT.656 video
> signal.
> 
> It's designed to be low-power, posesses some features such as a
> programmable comb-filter, and automatic input standard detection
> 
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> ---
> V6->V7: 
> - added powerdown-gpios and input ports
> - used 4 spaces for example identation
> 
> V5->V6: 
> - This commit had a "Reviewed-by: Rob Herring <robh@kernel.org>" Tag but
>   decided not to collect it because the last Iteration was more than 2
>   years ago
> - removed SECAM from the mentioned standards
> - changed maintainer
> 
> V4->V5: 
> - renamed the file to match the compatible string, and referenced
>   the graph.yaml schema
> 
> V3->V4: 
> - add the missing reset-gpios node to the binding
> 
> V2->V3: 
> - fix the example not compiling due to a typo in the reset-gpios
>   node.
> 
>  .../bindings/media/i2c/techwell,tw9900.yaml   | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml b/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
> new file mode 100644
> index 000000000000..244289a9a3e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/techwell,tw9900.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Techwell TW9900 NTSC/PAL video decoder
> +
> +maintainers:
> +  - Mehdi Djait <mehdi.djait@bootlin.com>
> +
> +description:
> +  The tw9900 is a multi-standard video decoder, supporting NTSC, PAL standards
> +  with auto-detection features.
> +
> +properties:
> +  compatible:
> +    const: techwell,tw9900
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: VDD power supply
> +
> +  reset-gpios:
> +    description: GPIO descriptor for the RESET input pin
> +    maxItems: 1
> +
> +  powerdown-gpios:
> +    description: GPIO descriptor for the POWERDOWN input pin
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    properties:
> +      port@3:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Video port for the decoder output.
> +
> +    patternProperties:
> +      "^port@[0-2]$":
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Analog video input port.

You need to define each port (0, 1, 2). Are those each component or 
composite, s-video, and component? The latter would make more sense as I 
don't think there would be a need to route each component to different 
place. It's logically just 1 stream.

> +
> +    required:
> +      - port@3
> +
> +required:
> +  - compatible
> +  - ports
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        video-decoder@44 {
> +            compatible = "techwell,tw9900";
> +            reg = <0x44>;
> +
> +            vdd-supply = <&tw9900_supply>;
> +            reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@3 {
> +                    reg = <3>;
> +                    endpoint {
> +                        remote-endpoint = <&vip_in>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.41.0
> 
