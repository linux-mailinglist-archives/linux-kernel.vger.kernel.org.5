Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768F0793617
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjIFHSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjIFHSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:18:44 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B55AE6E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:18:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99357737980so506925066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 00:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693984712; x=1694589512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oLm2367PlhquFXyjm9J/YZ+I5YhSOsfpDD/zxOTDh8g=;
        b=ao8XhLS3nUQD9s0CyP8+KvqoCXylpsv6MMBCvNXMBJqusNr/bgWA8e+DmuD6lnUXsc
         zjsDDpum9EWNUh075RgjDkfyNK5sQP/aHfqOtdM6jkY5CILrpmq+TrZ/KbILGE5QOzO0
         fI09NiLIco+sJ4lMfm+XdzB7h262ko71gc17iPAodF1IWUotsSzqzuZnNvh9Nz+S7iWA
         1GVq0LM1kAEYZEaIRhFs5bMBr3zNxCCv9tPgeMVleAKamhGL2vPKowaTfqeHmWp5kydZ
         HXh/5df36CxZiOnSGb1q1uKStQDx3EvG0OIYJ8AYKkKG0zydLX1HhGU0gaBAxGIloEkI
         77Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693984712; x=1694589512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLm2367PlhquFXyjm9J/YZ+I5YhSOsfpDD/zxOTDh8g=;
        b=TUXTebhXtBbHZ/jtG1TFXxQ0ViENbn0wwruDGvew6MVzRwmnugPg9aV38gjxdBsudV
         0oOdGK4czHH545lBp6pmPiPygGc4nS7KRvkgP1JiBhgArQ0GQpIXRV1J6Rp+3VA6fbHv
         7ung/Oi53BrOgmM5KY9iTFt2b6/Cs7aN7d9cJelg2RzL+d4SGrrgg719DrJUUNnR4iFL
         caLqPgv8qPQAa38MARPZu7D07q2AgD5PCV71juLmQxyG/bRsS7hlbe9ph1ZW+lvzudqc
         W9bBEtowAbgMTUMJDFCuopVDfdjs9sj6bT8IXtO1Ngr9z1XfFL1P8ZjiqF7mMvLMC0f9
         9EwQ==
X-Gm-Message-State: AOJu0Ywn8MHX8TsBmA8LiUgXZiFt2LzPhbb6S3ce2OuwP3PrWA7086zj
        8/au/Hg/p97yB1H2yhSK3WzXimEK1VZnxn0MLmE=
X-Google-Smtp-Source: AGHT+IEvxoAnhF13chZ5o/eiquJE4qnqbe1HVkX75JuWXAOxtXn742h0McKt1VlcDCa6KNR2xMRZOA==
X-Received: by 2002:a17:906:30c1:b0:99c:a2ca:4f54 with SMTP id b1-20020a17090630c100b0099ca2ca4f54mr1678013ejb.34.1693984711657;
        Wed, 06 Sep 2023 00:18:31 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id la20-20020a170906ad9400b0099caf5bed64sm8616547ejb.57.2023.09.06.00.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 00:18:31 -0700 (PDT)
Message-ID: <f023767c-aa74-87ca-d333-3dba8a481cb6@linaro.org>
Date:   Wed, 6 Sep 2023 09:18:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] dt-bindings: media: Add THine THP7312 ISP
To:     Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230905233118.183140-1-paul.elder@ideasonboard.com>
 <20230905233118.183140-2-paul.elder@ideasonboard.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230905233118.183140-2-paul.elder@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 01:31, Paul Elder wrote:
> Add bindings for the THine THP7312 ISP.
> 
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> ---
> Since the THP7312 supports multiple sensors, thine,rx-data-lanes alone
> might not be enough. I was consdering using sensor nodes like what the
> AP1302 does [1]. This way we can also move the power supplies that only
> concern the sensor in there as well. I was wondering what to do about
> the model name, though, as the thp7312 completely isolates that from the 
> rest of the system.
> 
> I'm planning to add sensor nodes in somehow in a v2.
> 
> [1] https://lore.kernel.org/linux-media/20211006113254.3470-2-anil.mamidala@xilinx.com/
> 
>  .../bindings/media/thine,thp7312.yaml         | 170 ++++++++++++++++++
>  1 file changed, 170 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/thine,thp7312.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/thine,thp7312.yaml b/Documentation/devicetree/bindings/media/thine,thp7312.yaml
> new file mode 100644
> index 000000000000..e8d203dcda81
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/thine,thp7312.yaml
> @@ -0,0 +1,170 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2023 Ideas on Board
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/thine,thp7312.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: THine THP7312
> +
> +maintainers:
> +  - Paul Elder <paul.elder@@ideasonboard.com>
> +
> +description:
> +  The THP7312 is a standalone ISP controlled over i2c, and is capable of
> +  various image processing and correction functions, including 3A control. It
> +  can be connected to CMOS image sensors from various vendors, supporting both
> +  MIPI CSI-2 and parallel interfaces. It can also output on either MIPI CSI-2
> +  or parallel. The hardware is capable of transmitting and receiving MIPI
> +  interlaved data strams with data types or multiple virtual channel
> +  identifiers.
> +
> +allOf:
> +  - $ref: ../video-interface-devices.yaml#
> +
> +properties:
> +  compatible:
> +    const: thine,thp7312
> +
> +  reg:
> +    description: I2C device address

You can skip description. It is obvious.

> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +      - description: CLKI clock input

This was absolutely never tested.

> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: |-
> +      Reference to the GPIO connected to the RESET_N pin, if any.
> +      Must be released (set high) after all supplies are applied.
> +
> +  vddcore-supply:
> +    description:
> +      1.2V supply for core, PLL, MIPI rx and MIPI tx.
> +
> +  vhtermnx-supply:
> +    description:
> +      Supply for input (rx). 1.8V for MIPI, or 1.8/2.8/3.3V for parallel.
> +
> +  vddtx-supply:
> +    description:
> +      Supply for output (tx). 1.8V for MIPI, or 1.8/2.8/3.3V for parallel.
> +
> +  vddhost-supply:
> +    description:
> +      Supply for host interface. 1.8V, 2.8V, or 3.3V.
> +
> +  vddcmos-supply:
> +    description:
> +      Supply for sensor interface. 1.8V, 2.8V, or 3.3V.
> +
> +  vddgpio_0-supply:

No, underscores are not allowed in names.

> +    description:
> +      Supply for GPIO_0. 1.8V, 2.8V, or 3.3V.
> +
> +  vddgpio_1-supply:
> +    description:
> +      Supply for GPIO_1. 1.8V, 2.8V, or 3.3V.
> +
> +  DOVDD-supply:

lowercase. Look at your other supplies. VDD is spelled there "vdd", so
do not introduce random style.


> +    description:
> +      Digital I/O (1.8V) supply for image sensor.
> +
> +  AVDD-supply:

lowercase

> +    description:
> +      Analog (2.8V) supply for image sensor.
> +
> +  DVDD-supply:

lowercase

> +    description:
> +      Digital Core (1.2V) supply for image sensor.
> +
> +  orientation: true
> +  rotation: true
> +
> +  thine,rx,data-lanes:

Why are you duplicating properties? With wrong name? No, that's not a
property of a device node, but endpoint.

> +    minItems: 4
> +    maxItems: 4
> +    $ref: /schemas/media/video-interfaces.yaml#data-lanes
> +    description: |-

Drop |- where not needed.

> +      This property is for lane reordering between the THP7312 and the imaging
> +      sensor that it is connected to.
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    additionalProperties: false
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          data-lanes:
> +            description: |-
> +              The sensor supports either two-lane, or four-lane operation.
> +              This property is for lane reordering between the THP7312 and
> +              the SoC. If this property is omitted four-lane operation is
> +              assumed. For two-lane operation the property must be set to <1 2>.
> +            minItems: 2
> +            maxItems: 4
> +            items:
> +              maximum: 4
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - clocks
> +  - vddcore-supply
> +  - vhtermrx-supply
> +  - vddtx-supply
> +  - vddhost-supply
> +  - vddcmos-supply
> +  - vddgpio_0-supply
> +  - vddgpio_1-supply
> +  - DOVDD-supply
> +  - AVDD-supply
> +  - DVDD-supply
> +  - thine,rx,data-lanes
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
> +        camera@61 {
> +            compatible = "thine,thp7312";
> +            reg = <0x61>;
> +
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&cam1_pins_default>;
> +
> +            reset-gpios = <&pio 119 GPIO_ACTIVE_LOW>;
> +            clocks = <&camera61_clk>;
> +
> +            vddcore-supply = <&vsys_v4p2>;
> +            AVDD-supply = <&vsys_v4p2>;
> +            DVDD-supply = <&vsys_v4p2>;

Srlsy, test it before sending. Look how many supplies you require and
what is provided here. How any of this could possibly work?



Best regards,
Krzysztof

