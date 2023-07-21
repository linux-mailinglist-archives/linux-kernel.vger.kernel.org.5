Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7986275C686
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjGUMG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjGUMGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:06:24 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6039119B2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 05:06:03 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b701e1ca63so27726971fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 05:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689941160; x=1690545960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gXNmhvlAzapF/jclc5ASHewKjKna+w9gzTSm+2C+njA=;
        b=lqZYn2c5Cd29qzr+lTe7eemtmhmvja1dKOcI5+g2MVF+Oxejn+e1OvTdAlFKm7s17i
         dDGutM2JSeP/+gMYzGkZQWmwDeD+RPXx+oLLtYD7F7nw4KH3tis4/3T1lxuNzs/HvRCQ
         Uis2KQfgHGbJ3ZxP1BoCTJ/NXVRHuMlSXUk2GPIGyUP5xeqLQ4UmE0WHPP9XCz6CuCjq
         4Y1gT6Qvl52SNwxJ2o4N/nD8BEIW8XpMRtigmP4Jl1XeIKUNTBfa/GQ5B07QpmEDVPoP
         kOfipuZM/lyis2+TsQSyE+51mseCq0Bn8/LUh63fFHtajyYRPPK57iUtZEMkEB/zrhnb
         YrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689941160; x=1690545960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXNmhvlAzapF/jclc5ASHewKjKna+w9gzTSm+2C+njA=;
        b=kbSN+ZLVqJlRJ84nBveVOLfGovu4KVYVP2eMo1xhR2fc/dL/hx3RzlapB3ieTYFJTX
         RQAWGCyFlzz//yYoGHISL1pUSugqXIEf7OVeexzIxPfQSsaWPlb8pS+qc3HDO7l95tdR
         RhgWVPCE0NBOVfQ2iX4bnQPGObzrVMh2DDJ77/RUeXc6kLAUVEkDJOkK+aKF4GsAafg2
         WYmxUAaO915c7R1YAH0zuHRpE5d/R2q09o4OtaCychcSkaQAWXOXc6UwK1lUuHsj+htq
         yGPDlbkDkEpSz8YXkiRsPw7yX5/MJ0rgGJjoNLG9q9ss3/2U7ThA2yaLrLeV6+jP3iLw
         xeJQ==
X-Gm-Message-State: ABy/qLYEn2K5jvHmVNc63Si6spW3XIZH+qRnnwHFKjhL2yRIWJZar70r
        HWnng470fD1w/LH89RTGZRdiOw==
X-Google-Smtp-Source: APBJJlHzSxzuJSBOed6vpzVkOujCMxrEjq/i/cbAMm5PwD9x5v0HiDNCAh78DlHQKgcRMMS5MMr3lg==
X-Received: by 2002:a2e:8048:0:b0:2b9:3a2b:8b02 with SMTP id p8-20020a2e8048000000b002b93a2b8b02mr1473060ljg.8.1689941160006;
        Fri, 21 Jul 2023 05:06:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id qt10-20020a170906ecea00b00988e953a586sm2114366ejb.61.2023.07.21.05.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 05:05:59 -0700 (PDT)
Message-ID: <fed3bad5-9200-76b2-1d57-092de3ec0394@linaro.org>
Date:   Fri, 21 Jul 2023 14:05:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 1/3] dt-bindings: clock: fsl,imx8-acm: Add audio clock
 mux support
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
        peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        shengjiu.wang@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1689934137-21430-1-git-send-email-shengjiu.wang@nxp.com>
 <1689934137-21430-2-git-send-email-shengjiu.wang@nxp.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1689934137-21430-2-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2023 12:08, Shengjiu Wang wrote:
> Add the clock dt-binding file for audio clock mux. which
> is the IP for i.MX8QM, i.MX8QXP, i.MX8DXL.
> 
> The Audio clock mux is binded with all the audio IP and audio clocks
> in the subsystem, so need to list the power domain of related clocks
> and IPs. Each clock and IP has a power domain, so there are so many
> power domains.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> changes in v6:
> - add clocks and clock-names, for using .fw_name in driver, the clocks
>   need to be list in DT.

You did much more. You sneaked some changes and kept my tag.

> 
> changes in v5:
> - none
> 
> changes in v4:
> - add Reviewed-by tag
> 
> changes in v3:
> - change compatible string fron nxp to fsl, align with file name.
> - add commit message for power domains numbers.
> - remove description of power domain
> 
> changes in v2:
> - update the file name to fsl,imx8-acm.yaml
> - remove "binding" in title
> - add power domains list
> - change the node name in example
> - change to lower-case for hex
> 
>  .../bindings/clock/fsl,imx8-acm.yaml          | 329 ++++++++++++++++++
>  1 file changed, 329 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx8-acm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/fsl,imx8-acm.yaml b/Documentation/devicetree/bindings/clock/fsl,imx8-acm.yaml
> new file mode 100644
> index 000000000000..4274c5410c3a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/fsl,imx8-acm.yaml
> @@ -0,0 +1,329 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/fsl,imx8-acm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX8 Audio Clock Mux
> +
> +maintainers:
> +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> +
> +description: |
> +  NXP i.MX8 Audio Clock Mux is dedicated clock muxing IP
> +  used to control Audio related clock on the SoC.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8qm-acm
> +      - fsl,imx8qxp-acm
> +      - fsl,imx8dxl-acm

Keep alphabetical order.

> +
> +  reg:
> +    maxItems: 1
> +
> +  power-domains:
> +    minItems: 13
> +    maxItems: 21
> +
> +  '#clock-cells':
> +    const: 1
> +    description:
> +      The clock consumer should specify the desired clock by having the clock
> +      ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx8-clock.h
> +      for the full list of i.MX8 ACM clock IDs.
> +
> +  clocks:
> +    minItems: 13
> +    maxItems: 27
> +
> +  clock-names:
> +    minItems: 13
> +    maxItems: 27
> +
> +required:
> +  - compatible
> +  - reg
> +  - power-domains
> +  - '#clock-cells'
> +  - clocks
> +  - clock-names
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8qxp-acm
> +    then:
> +      properties:
> +        power-domains:
> +          items:
> +            - description: power domain of IMX_SC_R_AUDIO_CLK_0
> +            - description: power domain of IMX_SC_R_AUDIO_CLK_1
> +            - description: power domain of IMX_SC_R_MCLK_OUT_0
> +            - description: power domain of IMX_SC_R_MCLK_OUT_1
> +            - description: power domain of IMX_SC_R_AUDIO_PLL_0
> +            - description: power domain of IMX_SC_R_AUDIO_PLL_1
> +            - description: power domain of IMX_SC_R_ASRC_0
> +            - description: power domain of IMX_SC_R_ASRC_1
> +            - description: power domain of IMX_SC_R_ESAI_0
> +            - description: power domain of IMX_SC_R_SAI_0
> +            - description: power domain of IMX_SC_R_SAI_1
> +            - description: power domain of IMX_SC_R_SAI_2
> +            - description: power domain of IMX_SC_R_SAI_3
> +            - description: power domain of IMX_SC_R_SAI_4
> +            - description: power domain of IMX_SC_R_SAI_5
> +            - description: power domain of IMX_SC_R_SPDIF_0
> +            - description: power domain of IMX_SC_R_MQS_0
> +
> +        clocks:
> +          minItems: 18
> +          maxItems: 18
> +
> +        clock-names:
> +          items:
> +            - const: aud_rec_clk0_lpcg_clk
> +            - const: aud_rec_clk1_lpcg_clk
> +            - const: aud_pll_div_clk0_lpcg_clk
> +            - const: aud_pll_div_clk1_lpcg_clk
> +            - const: ext_aud_mclk0
> +            - const: ext_aud_mclk1
> +            - const: esai0_rx_clk
> +            - const: esai0_rx_hf_clk
> +            - const: esai0_tx_clk
> +            - const: esai0_tx_hf_clk
> +            - const: spdif0_rx
> +            - const: sai0_rx_bclk
> +            - const: sai0_tx_bclk
> +            - const: sai1_rx_bclk
> +            - const: sai1_tx_bclk
> +            - const: sai2_rx_bclk
> +            - const: sai3_rx_bclk
> +            - const: sai4_rx_bclk
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8qm-acm
> +    then:
> +      properties:
> +        power-domains:
> +          items:
> +            - description: power domain of IMX_SC_R_AUDIO_CLK_0
> +            - description: power domain of IMX_SC_R_AUDIO_CLK_1
> +            - description: power domain of IMX_SC_R_MCLK_OUT_0
> +            - description: power domain of IMX_SC_R_MCLK_OUT_1
> +            - description: power domain of IMX_SC_R_AUDIO_PLL_0
> +            - description: power domain of IMX_SC_R_AUDIO_PLL_1
> +            - description: power domain of IMX_SC_R_ASRC_0
> +            - description: power domain of IMX_SC_R_ASRC_1
> +            - description: power domain of IMX_SC_R_ESAI_0
> +            - description: power domain of IMX_SC_R_ESAI_1
> +            - description: power domain of IMX_SC_R_SAI_0
> +            - description: power domain of IMX_SC_R_SAI_1
> +            - description: power domain of IMX_SC_R_SAI_2
> +            - description: power domain of IMX_SC_R_SAI_3
> +            - description: power domain of IMX_SC_R_SAI_4
> +            - description: power domain of IMX_SC_R_SAI_5
> +            - description: power domain of IMX_SC_R_SAI_6
> +            - description: power domain of IMX_SC_R_SAI_7
> +            - description: power domain of IMX_SC_R_SPDIF_0
> +            - description: power domain of IMX_SC_R_SPDIF_1
> +            - description: power domain of IMX_SC_R_MQS_0
> +
> +        clocks:
> +          minItems: 27
> +          maxItems: 27
> +
> +        clock-names:
> +          items:
> +            - const: aud_rec_clk0_lpcg_clk
> +            - const: aud_rec_clk1_lpcg_clk
> +            - const: aud_pll_div_clk0_lpcg_clk
> +            - const: aud_pll_div_clk1_lpcg_clk
> +            - const: mlb_clk
> +            - const: hdmi_rx_mclk
> +            - const: ext_aud_mclk0
> +            - const: ext_aud_mclk1
> +            - const: esai0_rx_clk
> +            - const: esai0_rx_hf_clk
> +            - const: esai0_tx_clk
> +            - const: esai0_tx_hf_clk
> +            - const: esai1_rx_clk
> +            - const: esai1_rx_hf_clk
> +            - const: esai1_tx_clk
> +            - const: esai1_tx_hf_clk
> +            - const: spdif0_rx
> +            - const: spdif1_rx
> +            - const: sai0_rx_bclk
> +            - const: sai0_tx_bclk
> +            - const: sai1_rx_bclk
> +            - const: sai1_tx_bclk
> +            - const: sai2_rx_bclk
> +            - const: sai3_rx_bclk
> +            - const: sai4_rx_bclk
> +            - const: sai5_tx_bclk
> +            - const: sai6_rx_bclk
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8dxl-acm
> +    then:
> +      properties:
> +        power-domains:
> +          items:
> +            - description: power domain of IMX_SC_R_AUDIO_CLK_0
> +            - description: power domain of IMX_SC_R_AUDIO_CLK_1
> +            - description: power domain of IMX_SC_R_MCLK_OUT_0
> +            - description: power domain of IMX_SC_R_MCLK_OUT_1
> +            - description: power domain of IMX_SC_R_AUDIO_PLL_0
> +            - description: power domain of IMX_SC_R_AUDIO_PLL_1
> +            - description: power domain of IMX_SC_R_ASRC_0
> +            - description: power domain of IMX_SC_R_SAI_0
> +            - description: power domain of IMX_SC_R_SAI_1
> +            - description: power domain of IMX_SC_R_SAI_2
> +            - description: power domain of IMX_SC_R_SAI_3
> +            - description: power domain of IMX_SC_R_SPDIF_0
> +            - description: power domain of IMX_SC_R_MQS_0
> +
> +        clocks:
> +          minItems: 13
> +          maxItems: 13
> +
> +        clock-names:
> +          items:
> +            - const: aud_rec_clk0_lpcg_clk
> +            - const: aud_rec_clk1_lpcg_clk
> +            - const: aud_pll_div_clk0_lpcg_clk
> +            - const: aud_pll_div_clk1_lpcg_clk
> +            - const: ext_aud_mclk0
> +            - const: ext_aud_mclk1
> +            - const: spdif0_rx
> +            - const: sai0_rx_bclk
> +            - const: sai0_tx_bclk
> +            - const: sai1_rx_bclk
> +            - const: sai1_tx_bclk
> +            - const: sai2_rx_bclk
> +            - const: sai3_rx_bclk
> +
> +additionalProperties: false
> +
> +examples:
> +  # Clock Control Module node:
> +  - |
> +    #include <dt-bindings/clock/imx8-lpcg.h>
> +    #include <dt-bindings/firmware/imx/rsrc.h>
> +
> +    aud_rec0_lpcg: clock-controller@59d00000 {
> +        compatible = "fsl,imx8qxp-lpcg";

How is this related to the binding? How this did appear here?!?!

> +        reg = <0x59d00000 0x10000>;
> +        #clock-cells = <1>;
> +        clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>;
> +        clock-indices = <IMX_LPCG_CLK_0>;
> +        clock-output-names = "aud_rec_clk0_lpcg_clk";
> +        power-domains = <&pd IMX_SC_R_AUDIO_PLL_0>;
> +    };

You have way too many examples here. Keep only one relevant. So
definitely not this.

> +
> +    aud_rec1_lpcg: clock-controller@59d10000 {
> +        compatible = "fsl,imx8qxp-lpcg";
> +        reg = <0x59d10000 0x10000>;
> +        #clock-cells = <1>;
> +        clocks = <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BUS>;
> +        clock-indices = <IMX_LPCG_CLK_0>;
> +        clock-output-names = "aud_rec_clk1_lpcg_clk";
> +        power-domains = <&pd IMX_SC_R_AUDIO_PLL_1>;
> +    };

Not this.

> +
> +    aud_pll_div0_lpcg: clock-controller@59d20000 {
> +        compatible = "fsl,imx8qxp-lpcg";
> +        reg = <0x59d20000 0x10000>;
> +        #clock-cells = <1>;
> +        clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>;
> +        clock-indices = <IMX_LPCG_CLK_0>;
> +        clock-output-names = "aud_pll_div_clk0_lpcg_clk";
> +        power-domains = <&pd IMX_SC_R_AUDIO_PLL_0>;

Not this.

> +    };
> +
> +    aud_pll_div1_lpcg: clock-controller@59d30000 {
> +        compatible = "fsl,imx8qxp-lpcg";
> +        reg = <0x59d30000 0x10000>;
> +        #clock-cells = <1>;
> +        clocks = <&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BUS>;
> +        clock-indices = <IMX_LPCG_CLK_0>;
> +        clock-output-names = "aud_pll_div_clk1_lpcg_clk";
> +        power-domains = <&pd IMX_SC_R_AUDIO_PLL_1>;

Not this.

> +    };
> +
> +    clk_dummy: clock-dummy {
> +        compatible = "fixed-clock";
> +        #clock-cells = <0>;
> +        clock-frequency = <0>;
> +        clock-output-names = "clk_dummy";
> +    };

drop, not related.

> +
> +    clock-controller@59e00000 {
> +        compatible = "fsl,imx8qxp-acm";

Finally, this one looks relevant.


Best regards,
Krzysztof

