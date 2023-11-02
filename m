Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359347DEE68
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbjKBIxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbjKBIxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:53:53 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB17131
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 01:53:43 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso994248a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 01:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698915222; x=1699520022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+J+xZD33uLXPXgHMU9DaEPidqrZfl8SUOphvs3WIQE0=;
        b=t0tI8mnLwDdU+KeJ21MXgtYO5GNVNNdTOjVkN0xE/ICS+OVNgF9V+jr5uBHToxv27k
         5cEcuZP4DIW6eY6u4N8nuT+bVUX8F9L8nP7rf0EHFfGzaosjkCt0sCvop36mSkte62yd
         1F5TxNTQQ4+mImhkQRkqOTvr1F7hTWgoeDzLypW/DRipXXLYHb4gxqqAw4egEsprk2Ln
         Nl5TFQud5qd1Vm0BakkXPLwZUUUGQabskV2Mf+E0WFhXdn7nGf4ndtzMAucsIDELeno9
         1dCpVb8GrQ17ZgZzLjt+YMUPVmQ1AxpRo2OvAJtkw2lsxzfpddHtwF2YI0L2Zg/D/2Lp
         OU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698915222; x=1699520022;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+J+xZD33uLXPXgHMU9DaEPidqrZfl8SUOphvs3WIQE0=;
        b=Kb8f/T/mka8q91XS/4sFZaQdPPwedJQDqW1nHxdLqXOb4eM7dDGEzmr6jF0ZzAomDp
         ZgJasHtrluHEl1tmMP5/RnrN9BlJbfk30+XrVePRG+Go6YM2iJbhs34xuHqM2lEWnz4G
         fmAqBKeKYVGb8wDEZb9/fFgd+Z8ejEAO/NMbWkDbknN61Vk24IG6IhlMlDL9uX0LCFfE
         PceUlF/69EIxeYD79EIbZNJ40VlziO40NSBOo8wnNWZ4HCaIJOfjc/dcley6Y/ph7aN7
         a3LNP3kp7E7YPiPpKVsHBR830SL7z+R5U5jkuoswD9i4NaDcHFkfYX9due+U5C46rHVJ
         jtjA==
X-Gm-Message-State: AOJu0YzhxaxNZacjH/dQ7pnwzm6AO21pcqbmF5b45nexOuoET4ZYyMcm
        LGVQs67tls9UIAeP4z8222o1xQ==
X-Google-Smtp-Source: AGHT+IEC9fc/gHghN/hQiAxaLiphCB5bOoRmxNCQG0s7cG9hghWU4Ad9qsGNWAsWsikIWYUKQn90JQ==
X-Received: by 2002:a05:6402:8ce:b0:53e:72be:2b31 with SMTP id d14-20020a05640208ce00b0053e72be2b31mr11611390edz.42.1698915221812;
        Thu, 02 Nov 2023 01:53:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id cy24-20020a0564021c9800b005432f45bee9sm2018883edb.19.2023.11.02.01.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 01:53:40 -0700 (PDT)
Message-ID: <6de77300-fbbf-43ed-b24b-304e27d4c662@linaro.org>
Date:   Thu, 2 Nov 2023 09:53:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5][4/4] dt-bindings: mmc: Add dt-bindings for realtek mmc
 driver
Content-Language: en-US
To:     Jyan Chou <jyanchou@realtek.com>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, jh80.chung@samsung.com,
        riteshh@codeaurora.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        asutoshd@codeaurora.org
Cc:     p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, briannorris@chromium.org, doug@schmorgal.com,
        tonyhuang.sunplus@gmail.com, abel.vesa@linaro.org,
        william.qiu@starfivetech.com
References: <20231102081514.22945-1-jyanchou@realtek.com>
 <20231102081514.22945-5-jyanchou@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231102081514.22945-5-jyanchou@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2023 09:15, Jyan Chou wrote:
> Document the device-tree bindings for Realtek SoCs mmc driver.
> 
> Signed-off-by: Jyan Chou <jyanchou@realtek.com>
> 
> ---
> v4 -> v5:
> - Fix compatible to match filename.

That's not what I said. Filename must match compatible, not the other
way around.

> - Remove unused property, e.g.,cqe, resets, clock-freq-min-max.
> - Fix indentation.
> 
> v3 -> v4:
> - Describe the items to make properties and item easy to understand.
> - Fix examples' indentation and compiling error.
> - Drop useless properties.
> 
> v2 -> v3:
> - Modify dt-bindings' content and description.
> - Fix coding style.
> - Update the list of maintainers.
> 
> v1 -> v2:
> - Add dt-bindings.
> ---
>  .../bindings/mmc/realtek,rtd-dw-cqe-emmc.yaml | 157 ++++++++++++++++++
>  1 file changed, 157 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/realtek,rtd-dw-cqe-emmc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mmc/realtek,rtd-dw-cqe-emmc.yaml b/Documentation/devicetree/bindings/mmc/realtek,rtd-dw-cqe-emmc.yaml
> new file mode 100644
> index 000000000000..f422a216ff93
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/realtek,rtd-dw-cqe-emmc.yaml
> @@ -0,0 +1,157 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/realtek,rtd-dw-cqe-emmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek DesignWare mobile storage host controller
> +
> +description:
> +  Realtek uses the Synopsys DesignWare mobile storage host controller
> +  to interface a SoC with storage medium. This file documents the Realtek
> +  specific extensions.
> +
> +maintainers:
> +  - Jyan Chou <jyanchou@realtek.com>
> +
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - realtek,rtd-dw-cqe-emmc

I don't understand what happened here. I asked you to drop the
incorrect, generic compatible. Instead you dropped specific compatibles
and left generic. Nope, this does not work like it.

You *must* use specific compatibles.

> +
> +  reg:
> +    items:
> +      - description: emmc base address
> +      - description: cqhci base address
> +
> +  reg-names:
> +    items:
> +      - const: emmc
> +      - const: cqhci
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description: Handles to input clocks

Instead: maxItems: 4

> +
> +  clock-names:
> +    items:
> +      - const: biu
> +      - const: ciu
> +      - const: vp0
> +      - const: vp1
> +
> +  clock-frequency:
> +    description:
> +      Operating frequency of realtek emmc controller clock

Drop entire property. There is already max-frequency.

> +    minimum: 300000
> +    maximum: 400000000
> +
> +  vmmc-supply:
> +    description:
> +      Handle to fixed-voltage supply for the card power.

Drop entire property. Not needed.

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
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - clock-frequency
> +  - vmmc-supply
> +  - pinctrl-names
> +  - pinctrl-0
> +  - pinctrl-1
> +  - pinctrl-3
> +  - pinctrl-4
> +  - pinctrl-5
> +  - pinctrl-6
> +  - pinctrl-7
> +  - pinctrl-8
> +  - pinctrl-9
> +
> +additionalProperties: false

unevaluatedProperties: false

> +
> +examples:
> +  - |
> +    emmc: mmc@12000 {
> +      compatible = "realtek,rtd-dw-cqe-emmc";
> +      reg = <0x00012000 0x00600>,
> +            <0x00012180 0x00060>;
> +      reg-names = "emmc", "cqhci";
> +      interrupts = <0 42 4>;
> +      clocks = <&cc 22>, <&cc 26>, <&cc 121>, <&cc 122>;
> +      clock-names = "biu", "ciu", "vp0", "vp1";

I asked you to test the bindings. This also means that you must test
your DTS against bindings. Your bindings, DTS and driver do not match,
therefore let's be a bit more clear:

NAK, till you upstream your DTS.

Best regards,
Krzysztof

