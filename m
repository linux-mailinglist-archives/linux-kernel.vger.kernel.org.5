Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10AB7DC621
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbjJaFwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjJaFwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:52:36 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F82DE
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:52:33 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53e04b17132so8585796a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698731552; x=1699336352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1HL2/AT7/PZUXkao0bY/DaiTw9iiwVQwGoOkH/xt9cM=;
        b=XRVKIXwbkK5LVV4DB8wokdzyfzhipHowkoNNJ9jtcEJ0dO/zEUFXpReRQyqbvcdz9Z
         9hsMMM5lsyVRnFED98zp07Ej9pifH6rJ4z+04eNpHxjbiJ0QGCoM0hp+1UnmeEojdvpq
         Nkd+WgP5zHsMOAzI7J1T17qrm6T5coW/C6oecNwmjsaC2vqVTXD9q3BOZYpSdSqnz88B
         fdJV2IPOYOC9rPsbeQY+cZDIPQRtANr8l3EE9z3ntSVdYj8As4GrQlLghHWRgcmyrens
         ZTqVnTe+lemfQW5CKAZFQRMZCXKX4kWFgcxT3lYYGc5+WhoJYZ5OKhviHXTrm0z4TT+C
         H5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698731552; x=1699336352;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HL2/AT7/PZUXkao0bY/DaiTw9iiwVQwGoOkH/xt9cM=;
        b=u56INwa7r9pRJx9o/QBz4NX3cA0Ccb0gxkIJZSnvWaCzWR62OVRFYzIu7HKepZ+T6e
         WDqodDkwx4yZP1rpa27cGtUqTXIzA3NqAHlXKWilMJL4oascSQVEseJRE9NTr1oNIRrC
         plsoAvt8sLrMn1qAn0cxsYJ+VEHESQeRxcUwJo7yDDJrL1iiMQ1tisrwrQI61LAjfH2N
         iELu2B7u5aAIqhtNW25npP+92Fk+g96f2vJbs5dVSmD/Sbm2SJQN12lF3luinGqeAuGS
         cB30U8tUT01nuz0VSgfJokwZBe2Y9DN6TuyiGtrgDIw4cBkqqbRWGK8CUXEaQLF6bvXE
         D2NQ==
X-Gm-Message-State: AOJu0YxDBJ6XXVaPAI9XLHWBsCsad217Ij0+T6qku3qMmb0t3Wvq7C2f
        8lySQyBNIHhyuY3potHK1lBirA==
X-Google-Smtp-Source: AGHT+IGXy/fC3RO6Rnklq5Wq9aOUTYe1O9YovjUTxvkol+Hq6ailcSu3RYdF84LIZs1799FWxWulWA==
X-Received: by 2002:a50:aad8:0:b0:543:6444:ef2a with SMTP id r24-20020a50aad8000000b005436444ef2amr815817edc.32.1698731551517;
        Mon, 30 Oct 2023 22:52:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id q19-20020a056402033300b0054354da96e5sm497333edw.55.2023.10.30.22.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 22:52:31 -0700 (PDT)
Message-ID: <5a906074-5c1e-4c1c-8023-5346e7fe9738@linaro.org>
Date:   Tue, 31 Oct 2023 06:52:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: mfd: brcm,bcm59056: Convert to YAML
Content-Language: en-US
To:     Artur Weber <aweber.kernel@gmail.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20231030-bcm59054-v1-0-3517f980c1e3@gmail.com>
 <20231030-bcm59054-v1-1-3517f980c1e3@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231030-bcm59054-v1-1-3517f980c1e3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2023 20:36, Artur Weber wrote:
> Convert devicetree bindings for the Broadcom BCM59056 PMU MFD from
> TXT to YAML format. This patch does not change any functionality;
> the bindings remain the same.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
>  .../devicetree/bindings/mfd/brcm,bcm59056.txt      | 39 ----------
>  .../devicetree/bindings/mfd/brcm,bcm59056.yaml     | 91 ++++++++++++++++++++++
>  2 files changed, 91 insertions(+), 39 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm59056.txt b/Documentation/devicetree/bindings/mfd/brcm,bcm59056.txt
> deleted file mode 100644
> index be51a15e05f9..000000000000
> --- a/Documentation/devicetree/bindings/mfd/brcm,bcm59056.txt
> +++ /dev/null
> @@ -1,39 +0,0 @@
> --------------------------------
> -BCM590xx Power Management Units
> --------------------------------
> -
> -Required properties:
> -- compatible: "brcm,bcm59056"
> -- reg: I2C slave address
> -- interrupts: interrupt for the PMU. Generic interrupt client node bindings
> -  are described in interrupt-controller/interrupts.txt
> -
> -------------------
> -Voltage Regulators
> -------------------
> -
> -Optional child nodes:
> -- regulators: container node for regulators following the generic
> -  regulator binding in regulator/regulator.txt
> -
> -  The valid regulator node names for BCM59056 are:
> -  	rfldo, camldo1, camldo2, simldo1, simldo2, sdldo, sdxldo,
> -	mmcldo1, mmcldo2, audldo, micldo, usbldo, vibldo,
> -	csr, iosr1, iosr2, msr, sdsr1, sdsr2, vsr,
> -	gpldo1, gpldo2, gpldo3, gpldo4, gpldo5, gpldo6,
> -	vbus
> -
> -Example:
> -	pmu: bcm59056@8 {
> -		compatible = "brcm,bcm59056";
> -		reg = <0x08>;
> -		interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
> -		regulators {
> -			rfldo_reg: rfldo {
> -				regulator-min-microvolt = <1200000>;
> -				regulator-max-microvolt = <3300000>;
> -			};
> -
> -			...
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml
> new file mode 100644
> index 000000000000..6d6acc9fd312
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/brcm,bcm59056.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: BCM590xx Power Management Unit MFD

Drop "MFD". That's Linux term.

> +
> +maintainers:
> +  - Artur Weber <aweber.kernel@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - "brcm,bcm59056"

No quotes. Please copy some existing DT schema as your template. None of
them use such syntax.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +

There is no other feature here, so this should go to regulators directory.

> +  regulators:
> +    type: object
> +    description: Container node for regulators.
> +
> +    # The valid regulator node names for BCM59056 are:
> +    #   rfldo, camldo1, camldo2, simldo1, simldo2, sdldo, sdxldo,
> +    #   mmcldo1, mmcldo2, audldo, micldo, usbldo, vibldo,
> +    #   csr, iosr1, iosr2, msr, sdsr1, sdsr2, vsr,
> +    #   gpldo1, gpldo2, gpldo3, gpldo4, gpldo5, gpldo6,
> +    #   vbus
> +    patternProperties:
> +      "^(cam|sim|mmc)ldo[1-2]$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +      "^(rf|sd|sdx|aud|mic|usb|vib)ldo$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +      "^(c|m|v)sr$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +      "^(io|sd)sr[1-2]$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +      "^gpldo[1-6]$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +    properties:
> +      "vbus":

Drop quotes

> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmu: bcm59056@8 {

Generic node names, so "pmic". You can also drop unused label.


> +            compatible = "brcm,bcm59056";
> +            reg = <0x08>;
> +            interrupts = <0 215 IRQ_TYPE_LEVEL_HIGH>;

Does 0 stand for some GIC flag?

> +            regulators {
> +                rfldo_reg: rfldo {
> +                    regulator-min-microvolt = <1200000>;
> +                    regulator-max-microvolt = <3300000>;
> +                };
> +            };
> +        };
> +    };
> 

Best regards,
Krzysztof

