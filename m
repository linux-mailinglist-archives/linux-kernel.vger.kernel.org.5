Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D854F7DB492
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjJ3HrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJ3HrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:47:22 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEB3B7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:47:19 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-542d3e47fd5so2727867a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698652038; x=1699256838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9PfgkgvvABG15UH16Td4Dt2qOGQzNMfh+o+HMOp78Ug=;
        b=i9mpLsM4fiR5MaT99MZyBGvrjbPpmapvsYHXgywzdYoFqV5pwW0Jx+G0pMHptzudhN
         YbutxAcyRFCjpYWWGbXPl66gdfh2rpk+hILMwA7Al4jCJWreA/RT1AjuBJktKBXXeIbr
         J6ji+pDHKEKf8kIyQNWvKIrfDRmH1dSxi3vCUpSI8cuJlIpaqyXCsbiEY5X7//FvryYl
         y2GAW7sP1IgeQerSUHZ2pY2QhRHRGSTjYoVf6YWS3sX2I4lsPktYFG/bUvc6kiMKAbiO
         hhQFf1yrREA30nqJu4FWm/ogs/5yB4+ACUdbwVqMhjSfWGlaRGgmgijn7lo4mVBcT1E+
         qxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698652038; x=1699256838;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9PfgkgvvABG15UH16Td4Dt2qOGQzNMfh+o+HMOp78Ug=;
        b=jBJVroM8UtOXjmj5hEQOgmJpfU9rfhA8pTHMKTdXZbc4aInOI24vty+6tkOPWECERU
         Q8iVMw3SJQA+BcyOJtTACKsWpdUysTaUbpxPWONEmN9Ib8aGJVP72q95++E8V7+V1aaT
         d57n/5mCz0pEthykXg3DQVODdzrcELHue8cA7KYIrJlnm2/IeeYcZb3ioMRi6VI9I+6d
         ucQN7T9x4eTviZwflSUm+LHluzqZwymXK243omJkPsRx6430iWQBpjjxnZuzooIVfNmf
         hD76vfTjsDeXKowmOgJf/qeA3U+h8YD6tiemER6C/4B28U6Jj/5YzGRbZ8LsqdAHkGN4
         GGLw==
X-Gm-Message-State: AOJu0YzZWpr8uttpf3FpK08fp/CKnNJZAoEqSCU9wNc14oEgFYMpX4Id
        b/TFgM3Xx1d0GNOd5IfUZj0xOg==
X-Google-Smtp-Source: AGHT+IG/GBvva3wFMTWJDHpXAEIg1yU5curoLnX+rzC0pehpxnQOwiWxjneh4SYHE3V6fbJ8HLqZAg==
X-Received: by 2002:aa7:c494:0:b0:540:f0d8:d748 with SMTP id m20-20020aa7c494000000b00540f0d8d748mr7880706edq.23.1698652038194;
        Mon, 30 Oct 2023 00:47:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id 16-20020a508750000000b00534e791296bsm5798173edv.37.2023.10.30.00.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 00:47:17 -0700 (PDT)
Message-ID: <b116d46f-f28b-4b7c-afd2-0061b523b00d@linaro.org>
Date:   Mon, 30 Oct 2023 08:47:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4][4/4] dt-bindings: mmc: Add dt-bindings for realtek mmc
 driver
Content-Language: en-US
To:     Jyan Chou <jyanchou@realtek.com>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, jh80.chung@samsung.com,
        riteshh@codeaurora.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        asutoshd@codeaurora.org, p.zabel@pengutronix.de
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        briannorris@chromium.org, doug@schmorgal.com,
        tonyhuang.sunplus@gmail.com, abel.vesa@linaro.org,
        william.qiu@starfivetech.com
References: <20231030062749.2840-1-jyanchou@realtek.com>
 <20231030062749.2840-5-jyanchou@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231030062749.2840-5-jyanchou@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2023 07:27, Jyan Chou wrote:
> Document the device-tree bindings for Realtek SoCs mmc driver.
> 
> Signed-off-by: Jyan Chou <jyanchou@realtek.com>
> 
> ---
> v3 -> v4:
> - Rename compatible(add SoC-specific part) to be different from filename.

What? I asked to be the same.

> - Describe the items to make properties and item easy to understand.
> - Fix examples' indentation and compiling error.
> - Drop useless properties.
> 
> v2 -> v3:
> - Modify dt-bindings' content and description.
> - Fix coding style.
> - Update the list of maintainers.
> 
> v0 -> v2:
> - Add dt-bindings.
> ---
> ---
>  .../bindings/mmc/realtek-dw-mshc.yaml         | 161 ++++++++++++++++++
>  1 file changed, 161 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/realtek-dw-mshc.yaml

Compatible should match filename.

This is a friendly reminder during the review process.

It seems my or other reviewer's previous comments were not fully
addressed. Maybe the feedback got lost between the quotes, maybe you
just forgot to apply it. Please go back to the previous discussion and
either implement all requested changes or keep discussing them.

Thank you.


> 
> diff --git a/Documentation/devicetree/bindings/mmc/realtek-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/realtek-dw-mshc.yaml
> new file mode 100644
> index 000000000000..d238cf3b8b47
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/realtek-dw-mshc.yaml
> @@ -0,0 +1,161 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/realtek-dw-mshc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek DesignWare mobile storage host controller
> +
> +description:
> +  Realtek uses the Synopsys DesignWare mobile storage host controller
> +  to interface a SoC with storage medium. This file documents the Realtek
> +  specific extensions.
> +
> +allOf:
> +  - $ref: synopsys-dw-mshc-common.yaml#
> +
> +maintainers:
> +  - Jyan Chou <jyanchou@realtek.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - realtek,rtd1325-dw-cqe-emmc
> +
> +  reg:
> +    maxItems: 2
> +    description:
> +      Two regs are required, first reg specifies emmc base address, second reg
> +      specifies cqhci base register address.
> +
> +  reg-names:
> +    maxItems: 2
> +    items:
> +      - const: emmc
> +      - const: cqhci
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  cqe:
> +    maxItems: 1
> +    description:
> +      Cqe should set to 1 while using command queue feature, and set to 0 while
> +      in legacy mode.

Did you just ignore Rob's comment?

Please point me where and how did you address it?

> +
> +  clocks:
> +    minItems: 2

No, why?

> +    items:
> +      - description: bus interface unit clock
> +      - description: card interface unit clock
> +      - description: select the phase for vpclk0 in realtek chip specified
> +      - description: select the phase for vpclk1 in realtek chip specified
> +
> +  clock-names:
> +    minItems: 2

No, why?

> +    items:
> +      - const: biu
> +      - const: ciu
> +      - const: vp0
> +      - const: vp1
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: reset

You ignored my feedback. NAK.

> +
> +  pinctrl-0:
> +    description:
> +      should contain default/high speed pin ctrl.
> +    maxItems: 1
> +
> +  pinctrl-1:
> +    description:
> +      should contain sdr50 mode pin ctrl.
> +    maxItems: 1
> +
> +  pinctrl-2:
> +    description:
> +      should contain ddr50 mode pin ctrl.
> +    maxItems: 1
> +
> +  pinctrl-3:
> +    description:
> +      should contain hs200 speed pin ctrl.
> +    maxItems: 1
> +
> +  pinctrl-4:
> +    description:
> +      should contain hs400 speed pin ctrl.
> +    maxItems: 1
> +
> +  pinctrl-5:
> +    description:
> +      should contain tune0 pin ctrl.
> +    maxItems: 1
> +
> +  pinctrl-6:
> +    description:
> +      should contain tune1 pin ctrl.
> +    maxItems: 1
> +
> +  pinctrl-7:
> +    description:
> +      should contain tune2 pin ctrl.
> +    maxItems: 1
> +
> +  pinctrl-8:
> +    description:
> +      should contain tune3 pin ctrl.
> +    maxItems: 1
> +
> +  pinctrl-9:
> +    description:
> +      should contain tune4 pin ctrl.
> +    maxItems: 1
> +
> +  pinctrl-names:
> +    maxItems: 10
> +
> +  required:

This wasn't even tested.

Do not send untested, broken code. Please run `make dt_binding_check`
(see Documentation/devicetree/bindings/writing-schema.rst for
instructions). Maybe you need to update your dtschema and yamllint.

> +    - compatible
> +    - reg
> +    - reg-names
> +    - interrupts
> +    - clocks
> +    - clock-names
> +    - pinctrl-names
> +
> +  unevaluatedProperties: false
> +
> +  examples:


> +    - |
> +      emmc: mmc@12000 {
> +        compatible = "realtek,rtd1325-dw-cqe-emmc";
> +        reg = <0x00012000 0x00600>,
> +              <0x00012180 0x00060>;
> +        reg-names = "emmc", "cqhci";
> +        interrupts = <0 42 4>;
> +        clocks = <&cc 22>, <&cc 26>, <&cc 121>, <&cc 122>;
> +        clock-names = "biu", "ciu", "vp0", "vp1";
> +        clock-freq-min-max = <300000 400000000>;
> +        clock-frequency = <400000>;
> +        vmmc-supply = <&reg_vcc1v8>;
> +        resets = <&rst 20>;
> +        reset-names = "reset";
> +        speed-step = <3>;
> +        cqe = <1>;
> +        pinctrl-names = "default", "sdr50", "ddr50", "hs200", "hs400",
> +                        "tune0","tune1", "tune2","tune3", "tune4";
> +        pinctrl-0 = <&emmc_pins_sdr50>;
> +        pinctrl-1 = <&emmc_pins_sdr50>;
> +        pinctrl-2 = <&emmc_pins_ddr50>;
> +        pinctrl-3 = <&emmc_pins_hs200>;
> +        pinctrl-4 = <&emmc_pins_hs400>;
> +        pinctrl-5 = <&emmc_pins_tune0>;
> +        pinctrl-6 = <&emmc_pins_tune1>;
> +        pinctrl-7 = <&emmc_pins_tune2>;
> +        pinctrl-8 = <&emmc_pins_tune3>;
> +        pinctrl-9 = <&emmc_pins_tune4>;
> +        };

Broken indentation.

Best regards,
Krzysztof

