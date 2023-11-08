Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0B77E51D4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbjKHIUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjKHIUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:20:35 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2459210DA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 00:20:33 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4083f613272so56152185e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 00:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699431631; x=1700036431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bnhlHTwiokHhmctr17r56Ro8xCuYEkb6KBSQHzT8NCQ=;
        b=CXv2WDUodNvdiKkfxhhKvEhZEvx/AAZTpt96POdGdrtM2acUQ+/lCS9c++bSHs3j1C
         oFporpoWuV1vQ9Z0rCd5nixYJTpnsmOrP397eTHNUKCpUUWymddrbuqfy5BtW/91aRxr
         ntsqFJNQQ5AtJXY+jYtn/cfLUFOg2KlUYepo8NK2RkVje7dnuoMXSXDPqBwtyRQBipN8
         Fhtl3s60UDLQC0EZy8y76hWcRFsKa0mAJMGEd8TmhxQftYCRQX2xMvqK6Aanludm4/2D
         hvTQ/K0UPqdD12SHs3mX699bHC0tDcKWaZvYrLrWNxaALQ+zahoSAm9AzDBmbVxurdmg
         3qYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699431631; x=1700036431;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bnhlHTwiokHhmctr17r56Ro8xCuYEkb6KBSQHzT8NCQ=;
        b=Hhg5NjjQXC0Vo6sFMu6nv/6fu7BZeHj40PPReg1vRttuL3YVwCVwK5x5JuaBHon/Fw
         Dpp1expJjRp+39v5BL6TWO0DwIR80ywTYS+UIyFv57XTASWmqMObIjzUTcRTTBiV5Yi2
         yr1YFw6O2y8zKk9nKxpwbpIJhcTaZCWCf8Tjujzbs51gS5a4v85qIWw1vSG6YKOIgNfu
         Nm4O2foQ8Pgs3xnQZySNUMRJ8Xs2zRL8EV6jNZG2Lh8b380/n189Cv5bg3j4kOmRmVDI
         go9/XogeMZm+M6wLLNrR8ZPSKDawdkk2CQBbpq1I6KCDmpfeyDPVi6Py6fQWkAikKkEe
         YuDQ==
X-Gm-Message-State: AOJu0Yy9bm2yKn3hyHKkQWtYz+HngJLYKam21AYHelmnladQyLVYGcRX
        uWi2zVV9xpB7VYVRW4iDPX0vxA==
X-Google-Smtp-Source: AGHT+IGdYI3YNDkHChjjpO/jsIFJQfwCYioERT64zHIkqUSPHOu6MXeIzlKufukgH3/HWJBCMrvD/Q==
X-Received: by 2002:a05:600c:3b8b:b0:409:5bd2:aa03 with SMTP id n11-20020a05600c3b8b00b004095bd2aa03mr1010197wms.9.1699431631507;
        Wed, 08 Nov 2023 00:20:31 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id x17-20020a05600c2d1100b004077219aed5sm17906388wmf.6.2023.11.08.00.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 00:20:31 -0800 (PST)
Message-ID: <e63fbf69-fe21-45cc-ae46-7b95dae9151e@linaro.org>
Date:   Wed, 8 Nov 2023 09:20:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: leds: add mps mp3326 LED
Content-Language: en-US
To:     Yuxi Wang <wyx137120466@gmail.com>, pavel@ucw.cz, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Yuxi.Wang@monolithicpower.com
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231108032921.3134115-1-wyx137120466@gmail.com>
 <20231108032921.3134115-2-wyx137120466@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231108032921.3134115-2-wyx137120466@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2023 04:29, Yuxi Wang wrote:
> Document mps mp3326 LED driver devicetree bindings.
> 
> Signed-off-by: Yuxi Wang <wyx137120466@gmail.com>
> ---
>  .../devicetree/bindings/leds/leds-mp3326.yaml | 184 ++++++++++++++++++
>  1 file changed, 184 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-mp3326.yaml

Except that this was not tested :(, few more comments.

Filename like compatible.

> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-mp3326.yaml b/Documentation/devicetree/bindings/leds/leds-mp3326.yaml
> new file mode 100644
> index 000000000000..899cf568f647
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-mp3326.yaml
> @@ -0,0 +1,184 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mps,mp3326.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MPS MP3326 RGB/White LED Driver
> +
> +maintainers:
> +  - Yuxi Wang <wyx137120466@gmail.com>
> +
> +description: |
> +  The MP3326 is a RGB/White LED driver with I2C interface.
> +
> +  For more product information please see the link below:
> +  https://www.monolithicpower.com/en/products/mp3326.html
> +
> +properties:
> +  compatible:
> +    - const: mps,mp3326
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  reg:
> +    maxItems: 1
> +
> +  mps,led-protect:
> +    description: |
> +      LED short protection threshold.

threshold? So in some units? What does it mean? What do the values mean?

> +    enum: [0, 1, 2, 3]
> +
> +  multi-led:
> +    type: object
> +
> +    properties:
> +      "#address-cells":
> +        const: 1
> +      "#size-cells":
> +        const: 0
> +
> +      color:
> +        description: RGB module
> +        const: LED_COLOR_ID_RGB
> +
> +      led_r:

Nope. First, no underscores in names. Second, please open existing
bindings and look how it is done there.

> +        type: object
> +
> +        properties:
> +          "#address-cells":
> +            const: 1
> +          "#size-cells":
> +            const: 0

Why do you have the,?

> +          reg:
> +            description: Index of the LED.
> +            minimum: 1
> +            maximum: 16

Please format it properly. You miss blank lines between each property
description.

> +          color:
> +            description: Red.
> +            const: LED_COLOR_ID_RED
> +          required:
> +            - reg
> +            - color
> +
> +      led_g:
> +        type: object
> +
> +        properties:
> +          "#address-cells":
> +            const: 1
> +          "#size-cells":
> +            const: 0
> +        reg:
> +          description: Index of the LED.
> +          minimum: 1
> +          maximum: 16
> +        color:
> +          description: Green.
> +          const: LED_COLOR_ID_GREEN
> +        required:
> +          - reg
> +          - color
> +
> +      led_b:
> +        type: object
> +
> +        properties:
> +          "#address-cells":
> +            const: 1
> +          "#size-cells":
> +            const: 0
> +        reg:
> +          description: Index of the LED.
> +          minimum: 1
> +          maximum: 16
> +        color:
> +          description: Blue.
> +          const: LED_COLOR_ID_BLUE
> +        required:
> +          - reg
> +          - color
> +
> +  patternProperties:
> +    "^led@[0-3]$":
> +      type: object
> +
> +      properties:
> +        reg:
> +          description: Index of the LED.
> +          minimum: 1
> +          maximum: 16
> +
> +        required:
> +          - reg
> +          - color

Missing required, additionalProperties.

Open existing binding and use it as example.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        mp3326@30 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +            compatible = "mps,mp3326";
> +            reg = <0x30>;
> +            led-protect =<3>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            multi-led {
> +              color = <LED_COLOR_ID_RGB>;
> +              #address-cells = <1>;
> +              #size-cells = <0>;
> +
> +              rgb_r@1 {
> +                  #address-cells = <1>;
> +                  #size-cells = <0>;
> +                  reg  = <1>;
> +                  color = <LED_COLOR_ID_RED>;
> +              };
> +              rgb_g@2 {
> +                  #address-cells = <1>;
> +                  #size-cells = <0>;
> +                  reg = <2>;
> +                  color = <LED_COLOR_ID_GREEN>;
> +              };
> +              rgb_b@3 {
> +                  #address-cells = <1>;
> +                  #size-cells = <0>;
> +                  reg = <3>;
> +                  color = <LED_COLOR_ID_BLUE>;
> +              };
> +            };
> +        };
> +    };
> +
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        mp3326@30 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +            compatible = "mps,mp3326";
> +            reg = <0x30>;
> +            led-protect =<3>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            led0@0 {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                reg= <5>;
> +                color = <LED_COLOR_ID_WHITE>;
> +            };
> +        };
> +    };
> +
> +...

Best regards,
Krzysztof

