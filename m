Return-Path: <linux-kernel+bounces-10251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E7681D1C6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D441F1C22799
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82FB15D1;
	Sat, 23 Dec 2023 03:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzmgH3n4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B85A6117;
	Sat, 23 Dec 2023 03:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B1DC433C7;
	Sat, 23 Dec 2023 03:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703300768;
	bh=feauVRkn1GyCCgLiGGwukw53SZb2tkOcoRSRGRxpTRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PzmgH3n45hCMxxGD5DB5WOPPyusXj6GPPiKP4IrMRQgZJ3K0FDr7XMoz17MJINoJ4
	 Gu1Y+N1noPiZ2ON5V3EWPPil+AlxyywElrnrR+tsPR9w2I2BQBSHceDTTf7AoExiCX
	 sdnn/SWmrkArK0KoeO3UOFgKFUykaAW0IIpF6mXDZtIh5hj9gIYcEZ9VDuoPgeWQV7
	 vO0qs39ivGUr+5H5IOa45TjbnP5QY+gsp1DmQhOlWYARCGynMQUHZLc8HykJeY1VEF
	 8oDdOAp9giVEIORScWf6QMNGwC0h2kEkY6mSvdO0FlrcscesBZyqoLXRyYeKWCK0vc
	 XZdZTEtk97Zug==
Date: Fri, 22 Dec 2023 21:06:03 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: agross@kernel.org, konrad.dybcio@linaro.org, linus.walleij@linaro.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: pinctrl: qcom: Add SM4450 pinctrl
Message-ID: <suy4rrpplvhsg2pfblg5amkvy7mrrkzsd3vzizhhpfj5xlog3q@i2n5wvsxb5wa>
References: <20231206020840.33228-1-quic_tengfan@quicinc.com>
 <20231206020840.33228-2-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206020840.33228-2-quic_tengfan@quicinc.com>

On Wed, Dec 06, 2023 at 10:08:39AM +0800, Tengfei Fan wrote:
> Add device tree binding Documentation details for Qualcomm SM4450
> TLMM device.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  .../bindings/pinctrl/qcom,sm4450-tlmm.yaml    | 151 ++++++++++++++++++
>  1 file changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
> new file mode 100644
> index 000000000000..bb08ca5a1509
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
> @@ -0,0 +1,151 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/qcom,sm4450-tlmm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. SM4450 TLMM block
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

This should be qcom,sm4450-tlmm

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
> +    maxItems: 68
> +
> +  gpio-line-names:
> +    maxItems: 136
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
> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-2][0-9]|13[0-5])$"
> +            - enum: [ sdc2_clk, sdc2_cmd, sdc2_data, ufs_reset ]
> +          minItems: 1
> +          maxItems: 36
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

You consolidated the functions in the driver, but you forgot to update
this list accordingly.

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
> +        compatible = "qcom,sm4450-tlmm";

Please feel free to ping me if you're having issues running
dt_binding_check and dtb_check. I believe the prior should complain
about this compatible being unknown.

Regards,
Bjorn

> +        reg = <0x0f100000 0x300000>;
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        gpio-ranges = <&tlmm 0 0 137>;
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +
> +        gpio-wo-state {
> +            pins = "gpio1";
> +            function = "gpio";
> +        };
> +
> +        uart-w-state {
> +            rx-pins {
> +                pins = "gpio23";
> +                function = "qup1_se2";
> +                bias-pull-up;
> +            };
> +
> +            tx-pins {
> +                pins = "gpio22";
> +                function = "qup1_se2";
> +                bias-disable;
> +            };
> +        };
> +    };
> +...
> -- 
> 2.17.1
> 

