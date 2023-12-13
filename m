Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A879F811545
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441934AbjLMOxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbjLMOxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:53:47 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C92EDD;
        Wed, 13 Dec 2023 06:53:52 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6d7fa93afe9so5193932a34.2;
        Wed, 13 Dec 2023 06:53:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702479232; x=1703084032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7eF1sr6RjgS4rFcgIiGFaIc2GmVoQDjgQdR45bMb7w=;
        b=rrHgetc7PfISuyQitl4JMiEKbo9yYWv2TK6eO20Oy3HKedVedfO8cMRothvg/Pc/Zk
         b64hBHREnUh9GogGEiqXMCGtzGBD5RMUiT1uHaHrk+1Fyw3ITIVDgqNuEB8db3IsBQmW
         b2hjt4jw4TEr9AhrL0zpB5QQ+PAy8uM/BWnPq7ilWaC33aEFfdymCVJ6kxol9E0Oyv1J
         Qj6mfHeaFcDM/O3r4xIf0SPoiYBioswFf+xJWUocmQzcN2eMMSWhy7KPXCtMlns2tCmv
         Dv4yp0KYSvKi1qM+LJZ8b4cNMWgLM9WEN/ZIRYpXcQc01Y+Nsaw1b9AklL0UDRjr/2mE
         sk2Q==
X-Gm-Message-State: AOJu0Yz+FZlAvYdWD5E0PK8HbXl4ZSpdJU8rW6VG1yvR4UfsZUUEjgU3
        s6GxdI0uw/KFOe5qX/9AnzlW+fSpWg==
X-Google-Smtp-Source: AGHT+IHjJzuUOUOtUnsfLKwrky5w1ClJWBJ+R/A5M3/AIk8/vRzcUwGi1xuOCyrENkM3QBoI5z+p0Q==
X-Received: by 2002:a9d:6284:0:b0:6d9:e2ee:3d23 with SMTP id x4-20020a9d6284000000b006d9e2ee3d23mr7076020otk.36.1702479231786;
        Wed, 13 Dec 2023 06:53:51 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x6-20020a4aea06000000b0059030f95ebfsm2977608ood.41.2023.12.13.06.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:53:51 -0800 (PST)
Received: (nullmailer pid 1116961 invoked by uid 1000);
        Wed, 13 Dec 2023 14:53:50 -0000
Date:   Wed, 13 Dec 2023 08:53:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: spi-dac: Add driver for SPI shift
 register DACs
Message-ID: <20231213145350.GA1102482-robh@kernel.org>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.3aa8b2c3-ac7e-4139-afe5-048730c85889@emailsignatures365.codetwo.com>
 <20231213090910.25410-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213090910.25410-1-mike.looijmans@topic.nl>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 10:09:09AM +0100, Mike Looijmans wrote:
> Add a driver for generic serial shift register DACs like TI DAC714.

This is not a driver.

> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
>  .../devicetree/bindings/iio/dac/spidac.yaml   | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/spidac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/spidac.yaml b/Documentation/devicetree/bindings/iio/dac/spidac.yaml
> new file mode 100644
> index 000000000000..be98da728594
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/spidac.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/spidac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic "shift register" SPI DAC
> +
> +description:
> +  Supports simple SPI "shift register" DACs, like TI's DAC714. These DACs have
> +  no control registers or commands, they just use a clock and serial data to
> +  shift in a raw DAC value. Multiple DACs can be daisy-chained together.
> +
> +maintainers:
> +  - Mike Looijmans <mike.looijmans@topic.nl>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - spi-dac
> +      - ti,dac714

Why does TI chip need a specific compatible and others don't?

Are power supplies on these chips the same?

> +
> +  reg:
> +    maxItems: 1
> +
> +  ldac-gpios:
> +    description:
> +      LDAC pin to be used as a hardware trigger to update the DAC outputs. Not
> +      needed when the DACs use the chip select to update their output.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      Optional reset pin that resets all DACs.
> +    maxItems: 1
> +
> +  num-channels:
> +    description:
> +      Number of channels (usually the number of DAC chips in series)

usually? What other possible option is there? If something else, how is 
the driver going to distinguish that?

default: 1

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  bits-per-channel:

Perhaps 'channel-bits' as -bits is a standard unit suffix.

> +    description:
> +       Number of bits for each DAC output.
> +    $ref: /schemas/types.yaml#/definitions/uint32

Constraints? I assume all DACs are much less than 2^32 bits. default?

> +
> +required:
> +  - compatible
> +  - reg

Don't you always need to know how many bits?

> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dac@1 {
> +            compatible = "spidac";
> +            reg = <0x1>;
> +            ldac-gpios = <&gpio 42 GPIO_ACTIVE_LOW>;
> +        };
> +    };
> +...
> -- 
> 2.34.1
> 
> 
> Met vriendelijke groet / kind regards,
> 
> Mike Looijmans
> System Expert
> 
> 
> TOPIC Embedded Products B.V.
> Materiaalweg 4, 5681 RJ Best
> The Netherlands
> 
> T: +31 (0) 499 33 69 69
> E: mike.looijmans@topic.nl
> W: www.topic.nl
> 
> Please consider the environment before printing this e-mail
