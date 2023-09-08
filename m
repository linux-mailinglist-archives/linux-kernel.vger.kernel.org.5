Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3CD798396
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238788AbjIHHyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 03:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjIHHyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:54:07 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032A119A6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 00:54:03 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401d80f4ef8so19053895e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 00:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694159641; x=1694764441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2w7vJeDcbfS6PHlauzsswGt613jFjllSe3mwn1fU2S4=;
        b=DC1Hab4vltr+z8XWeB02C9X+dT7rG8t8XL/VhexpugwbYgShkhZnWxofzVRzoy3jKc
         0Pnqbddr0rRFrT9r1e6QZ5maSeYuaj8qxqCnBEwFJ5hs0iahOhA98oIk5Qh/7koOuO08
         5fd0dFe5gKdiosFCIuDes1T8TcnRs5km//5dFg7I39WEJ8DSKclDHlXL8vaH9yE5MLHZ
         on7U985XJ23I2BIVtB3w7oWfhxSPoqaZHwEELvl3NNCx0oQyLA/axT5HOoADWvmTHaBH
         kekf6thTkHoyZqncwPrPY2FMm9Q/kkmQY9pg4Bx7a+WP1KJGP/82YhUQMeYbIHTu3zhX
         IHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694159641; x=1694764441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2w7vJeDcbfS6PHlauzsswGt613jFjllSe3mwn1fU2S4=;
        b=QBg1A/QQy/74skNB+RQ1XMX9ZtlX5uCvhjeBZn94eUuBW6otNocPUe+0sYIWfRlPNp
         ldK/rsCg3/JYy48ar92jw6GEK0lEKb64PRxGsA13VbYA9EcT/huRtKTPYlK9JNvEAW17
         +UKV8FGYWpm40hhmbVu2t0ccxiVF9MKSmMIW+cmQI4O9QUOqyxi1pJvy0+k1PaUuSiso
         0xs1EP0MOybGXMHxGgRxYSV+WJ+UHxGDRai0BVYSCw71HKmjCj3wyXWJBLUPUvWoWp3r
         dQleRYy4aT8zeQeYu+Kcy/Njg4/J+7U1v1xygvC1IbjAPFDQRCDxXPlChxI4t3AiBosT
         nLMA==
X-Gm-Message-State: AOJu0YxBniibyiizH0SwHkFZxfKF195h25x19PxM1UjJVyWL/auk3wdJ
        eG9OaKaPiY7D0b935AB5kG7imQ==
X-Google-Smtp-Source: AGHT+IGGQ98JgfJ2pX31T2twnRbY9gwgje1NTu8GKzbn2/L4bczGE0uA6C6kI/YdjmvgOiAjVYjdvQ==
X-Received: by 2002:a05:600c:b58:b0:401:b2c7:349d with SMTP id k24-20020a05600c0b5800b00401b2c7349dmr1493646wmr.29.1694159641350;
        Fri, 08 Sep 2023 00:54:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id p11-20020a1c740b000000b003ff013a4fd9sm1295984wmc.7.2023.09.08.00.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 00:54:00 -0700 (PDT)
Message-ID: <709fac9a-e153-d495-c421-f556fab30dde@linaro.org>
Date:   Fri, 8 Sep 2023 09:53:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: qcom: Add SM4450 pinctrl
To:     Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org
Cc:     arnd@arndb.de, geert+renesas@glider.be, nfraprado@collabora.com,
        rafal@milecki.pl, peng.fan@nxp.com, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        kernel@quicinc.com
References: <20230908063843.26835-1-quic_tengfan@quicinc.com>
 <20230908063843.26835-2-quic_tengfan@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230908063843.26835-2-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2023 08:38, Tengfei Fan wrote:
> Add device tree binding Documentation details for Qualcomm SM4450
> TLMM device.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  .../bindings/pinctrl/qcom,sm4450-tlmm.yaml    | 129 ++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
> new file mode 100644
> index 000000000000..51735604b3c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/pinctrl/qcom,sm4450-tlmm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. RAVELIN TLMM block

SM4450, not ravelin

> +
> +maintainers:
> +  - Tengfei Fan <quic_tengfan@quicinc.com>
> +
> +description:
> +  Top Level Mode Multiplexer pin controller in Qualcomm SM4450 SoC.
> +
> +allOf:
> +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,sm4450-pinctrl
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts: true
> +  interrupt-controller: true
> +  "#interrupt-cells": true
> +  gpio-controller: true
> +
> +  gpio-reserved-ranges:
> +    minItems: 1
> +    maxItems: 105

That's not true, you cannot have 105 ranges.

> +
> +  gpio-line-names:
> +    maxItems: 210

No, your driver tells something entirely different.

> +
> +  "#gpio-cells": true
> +  gpio-ranges: true
> +  wakeup-parent: true
> +
> +patternProperties:
> +  "-state$":
> +    oneOf:
> +      - $ref: "#/$defs/qcom-sm4450-tlmm-state"
> +      - patternProperties:
> +          "-pins$":
> +            $ref: "#/$defs/qcom-sm4450-tlmm-state"
> +        additionalProperties: false
> +
> +$defs:
> +  qcom-sm4450-tlmm-state:
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
> +    unevaluatedProperties: false
> +
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in this
> +          subnode.
> +        items:
> +          oneOf:
> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|20[0-9])$"

You do not have 210 GPIOs. Narrow it to real values.

> +            - enum: [ sdc2_clk, sdc2_cmd, sdc2_data, ufs_reset ]

Not tested. Missing min/maxItems.

> +
> +      function:
> +        description:
> +          Specify the alternative function to be configured for the specified
> +          pins.
> +        enum: [ gpio, atest_char, atest_char0, atest_char1, atest_char2,
> +                atest_char3, atest_usb0, atest_usb00, atest_usb01, atest_usb02,
> +                atest_usb03, audio_ref, cam_mclk, cci_async, cci_i2c,
> +                cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4,
> +                cmu_rng0, cmu_rng1, cmu_rng2, cmu_rng3, coex_uart1, cri_trng,
> +                cri_trng0, cri_trng1, dbg_out, ddr_bist, ddr_pxi0, ddr_pxi1,
> +                dp0_hot, gcc_gp1, gcc_gp2, gcc_gp3, host2wlan_sol, ibi_i3c,
> +                jitter_bist, mdp_vsync, mdp_vsync0, mdp_vsync1, mdp_vsync2,
> +                mdp_vsync3, mi2s0_data0, mi2s0_data1, mi2s0_sck, mi2s0_ws,
> +                mi2s2_data0, mi2s2_data1, mi2s2_sck, mi2s2_ws, mi2s_mclk0,
> +                mi2s_mclk1, nav_gpio0, nav_gpio1, nav_gpio2, pcie0_clk,
> +                phase_flag0, phase_flag1, phase_flag10, phase_flag11,
> +                phase_flag12, phase_flag13, phase_flag14, phase_flag15,
> +                phase_flag16, phase_flag17, phase_flag18, phase_flag19,
> +                phase_flag2, phase_flag20, phase_flag21, phase_flag22,
> +                phase_flag23, phase_flag24, phase_flag25, phase_flag26,
> +                phase_flag27, phase_flag28, phase_flag29, phase_flag3,
> +                phase_flag30, phase_flag31, phase_flag4, phase_flag5,
> +                phase_flag6, phase_flag7, phase_flag8, phase_flag9,
> +                pll_bist, pll_clk, prng_rosc0, prng_rosc1, prng_rosc2,
> +                prng_rosc3, qdss_cti, qdss_gpio, qdss_gpio0, qdss_gpio1,
> +                qdss_gpio10, qdss_gpio11, qdss_gpio12, qdss_gpio13, qdss_gpio14,
> +                qdss_gpio15, qdss_gpio2, qdss_gpio3, qdss_gpio4, qdss_gpio5,
> +                qdss_gpio6, qdss_gpio7, qdss_gpio8, qdss_gpio9, qlink0_enable,
> +                qlink0_request, qlink0_wmss, qlink1_enable, qlink1_request,
> +                qlink1_wmss, qlink2_enable, qlink2_request, qlink2_wmss,
> +                qup0_se0, qup0_se1, qup0_se2, qup0_se3, qup0_se4, qup0_se5,
> +                qup0_se6, qup0_se7, qup1_se0, qup1_se1, qup1_se2, qup1_se3,
> +                qup1_se4, qup1_se5, qup1_se6, sd_write, tb_trig, tgu_ch0,
> +                tgu_ch1, tgu_ch2, tgu_ch3, tmess_prng0, tmess_prng1,
> +                tmess_prng2, tmess_prng3, tsense_pwm1, tsense_pwm2, uim0_clk,
> +                uim0_data, uim0_present, uim0_reset, uim1_clk, uim1_data,
> +                uim1_present, uim1_reset, usb0_hs, usb0_phy, vfr_0, vfr_1,
> +                vsense_trigger ]
> +
> +        required:
> +          - pins
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    tlmm: pinctrl@f100000 {
> +      compatible = "qcom,sm4450-tlmm";
> +      reg = <0x0f100000 0x300000>;
> +      gpio-controller;
> +      #gpio-cells = <2>;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +      interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;

Example pin config, gpio-ranges.

> +    };
> +...

Best regards,
Krzysztof

