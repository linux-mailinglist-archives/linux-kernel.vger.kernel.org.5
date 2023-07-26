Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E99A7638E0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjGZOR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbjGZORM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:17:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A4844A0;
        Wed, 26 Jul 2023 07:16:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D1BC61AF3;
        Wed, 26 Jul 2023 14:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13437C43391;
        Wed, 26 Jul 2023 14:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690380937;
        bh=ipv18QFNNUrxqsl0lsMwZSVvGm+N6/LfyCWeq4hqFVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lk32612FqdEvy2OeXWzjqarlPqFN8JP6g4D2Js6HIif4ov1h0tA0TNz+q48AhPYLP
         frbHskHa0M+tEKR/bInyHMmBWn1o8LCAM0wVg0rXhnCRZbQPHN8JPcV7VcZxitnyZY
         w2I9tMB9f35meu6kzJRU/rCXCUrWTO5pD47/cmRrP8Db67bDJjq2na29KkgFXFDAkj
         Bvf48DJzIhHLho/9hkUI4vupuUcN/YQlw3TH5DGrctDkqrCXUIUdjTrlZMpg6imAEl
         GDk9KanVMy23lLgWUS1L5f3WgP42MNA0L4+IRPU0LLJ4751i1ewYfmAXlx7MmLhszs
         vr0L9yASoyfdw==
Received: (nullmailer pid 1383747 invoked by uid 1000);
        Wed, 26 Jul 2023 14:15:35 -0000
Date:   Wed, 26 Jul 2023 08:15:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     TY Chang <tychang@realtek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] dt-bindings: pinctrl: realtek: add RTD1619B pinctrl
 binding
Message-ID: <20230726141535.GA1378938-robh@kernel.org>
References: <20230726090409.16606-1-tychang@realtek.com>
 <20230726090409.16606-8-tychang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726090409.16606-8-tychang@realtek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 05:04:09PM +0800, TY Chang wrote:
> Add device tree bindings for RTD1619B.
> 
> Signed-off-by: TY Chang <tychang@realtek.com>
> ---
>  .../pinctrl/realtek,rtd1619b-pinctrl.yaml     | 162 ++++++++++++++++++
>  1 file changed, 162 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/realtek,rtd1619b-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/realtek,rtd1619b-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/realtek,rtd1619b-pinctrl.yaml
> new file mode 100644
> index 000000000000..8efd33c59ed8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/realtek,rtd1619b-pinctrl.yaml
> @@ -0,0 +1,162 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Realtek Semiconductor Corporation
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/realtek,rtd1619b-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek DHC RTD1619B Pin Controller
> +
> +maintainers:
> +  - TY Chang <tychang@realtek.com>
> +
> +description: |

Don't need '|' if no formatting to preserve.

> +  Binding for Realtek DHC RTD1619B SoC pin control.

Drop 'Binding for'. Every schema is.

> +
> +properties:
> +  compatible:
> +    const: realtek,rtd1619b-pinctrl
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  '^.*$':

For new bindings, define a node name pattern you can match on. '-pins$' 
is commmon.

> +    if:
> +      type: object
> +    then:
> +      allOf:
> +        - $ref: pincfg-node.yaml#
> +        - $ref: pinmux-node.yaml#
> +
> +      properties:
> +        pins:
> +          items:
> +            enum: [ gpio_0, gpio_1, gpio_2, gpio_3, gpio_4, gpio_5, gpio_6, gpio_7,
> +                    gpio_8, gpio_9, gpio_10, gpio_11, gpio_12, gpio_13, gpio_14,
> +                    gpio_15, gpio_16, gpio_17, gpio_18, gpio_19, gpio_20, gpio_21,
> +                    gpio_22, gpio_23, usb_cc2, gpio_25, gpio_26, gpio_27, gpio_28,
> +                    gpio_29, gpio_30, gpio_31, gpio_32, gpio_33, gpio_34, gpio_35,
> +                    hif_data, hif_en, hif_rdy, hif_clk, gpio_40, gpio_41, gpio_42,
> +                    gpio_43, gpio_44, gpio_45, gpio_46, gpio_47, gpio_48, gpio_49,
> +                    gpio_50, usb_cc1, gpio_52, gpio_53, ir_rx, ur0_rx, ur0_tx,
> +                    gpio_57, gpio_58, gpio_59, gpio_60, gpio_61, gpio_62, gpio_63,
> +                    gpio_64, gpio_65, gpio_66, gpio_67, gpio_68, gpio_69, gpio_70,
> +                    gpio_71, gpio_72, gpio_73, gpio_74, gpio_75, gpio_76, emmc_cmd,
> +                    spi_ce_n, spi_sck, spi_so, spi_si, emmc_rst_n, emmc_dd_sb,
> +                    emmc_clk, emmc_data_0, emmc_data_1, emmc_data_2, emmc_data_3,
> +                    emmc_data_4, emmc_data_5, emmc_data_6, emmc_data_7, ur2_loc,
> +                    gspi_loc, sdio_loc, hi_loc, hi_width, sf_en, arm_trace_dbg_en,
> +                    pwm_01_open_drain_en_loc0, pwm_23_open_drain_en_loc0,
> +                    pwm_01_open_drain_en_loc1, pwm_23_open_drain_en_loc1,
> +                    ejtag_acpu_loc, ejtag_vcpu_loc, ejtag_scpu_loc, dmic_loc,
> +                    iso_gspi_loc, ejtag_ve3_loc, ejtag_aucpu0_loc, ejtag_aucpu1_loc ]
> +
> +        function:
> +          enum: [ gpio, nf, nf_spi, spi, pmic, spdif, spdif_coaxial, spdif_optical_loc0,
> +                  spdif_optical_loc1, emmc_spi, emmc, sc1, uart0, uart1, uart2_loc0, uart2_loc1,
> +                  gspi_loc1, iso_gspi_loc1, i2c0, i2c1, i2c3, i2c4, i2c5, pwm0, pwm1, pwm2,
> +                  pwm3, etn_led, etn_phy, etn_clk, sc0, vfd, gspi_loc0, iso_gspi_loc0, pcie1,
> +                  pcie2, sd, sdio_loc0, sdio_loc1, hi, hi_m, dc_fan, pll_test_loc0, pll_test_loc1,
> +                  usb_cc1, usb_cc2, ir_rx, tdm_ai_loc0, tdm_ai_loc1, dmic_loc0, dmic_loc1,
> +                  ai_loc0, ai_loc1, tp0, tp1, ao, uart2_disable, gspi_disable, sdio_disable,
> +                  hi_loc_disable, hi_loc0, hi_width_disable, hi_width_1bit, vtc_i2si_loc0,
> +                  vtc_tdm_loc0, vtc_dmic_loc0, vtc_i2si_loc1, vtc_tdm_loc1, vtc_dmic_loc1,
> +                  vtc_i2so, ve3_ejtag_loc0, aucpu0_ejtag_loc0, aucpu1_ejtag_loc0, ve3_ejtag_loc1,
> +                  aucpu0_ejtag_loc1, aucpu1_ejtag_loc1, ve3_ejtag_loc2, aucpu0_ejtag_loc2,
> +                  aucpu1_ejtag_loc2, scpu_ejtag_loc0, acpu_ejtag_loc0, vcpu_ejtag_loc0,
> +                  scpu_ejtag_loc1, acpu_ejtag_loc1, vcpu_ejtag_loc1, scpu_ejtag_loc2,
> +                  acpu_ejtag_loc2, vcpu_ejtag_loc2, ve3_ejtag_disable, aucpu0_ejtag_disable,
> +                  aucpu1_ejtag_disable, acpu_ejtag_disable, vcpu_ejtag_disable,
> +                  scpu_ejtag_disable, iso_gspi_disable, sf_disable, sf_enable,
> +                  arm_trace_debug_disable, arm_trace_debug_enable, pwm_normal, pwm_open_drain,
> +                  standby_dbg, test_loop_dis ]
> +
> +        drive-strength:
> +          enum: [4, 8]
> +
> +        bias-pull-down: true
> +
> +        bias-pull-up: true
> +
> +        bias-disable: true
> +
> +        input-schmitt-enable: true
> +
> +        input-schmitt-disable: true
> +
> +        drive-push-pull: true
> +
> +        power-source:
> +          description: |
> +            Valid arguments are described as below:
> +            0: power supply of 1.8V
> +            1: power supply of 3.3V
> +          enum: [0, 1]
> +
> +        realtek,pdrive:
> +          description: |
> +            An integer describing the level to adjust PMOS output driving capability.
> +          $ref: /schemas/types.yaml#/definitions/uint32
> +          minimum: 0
> +          maximum: 7
> +
> +        realtek,ndrive:
> +          description: |
> +            An integer describing the level to adjust NMOS output driving capability.
> +          $ref: /schemas/types.yaml#/definitions/uint32
> +          minimum: 0
> +          maximum: 7
> +
> +        realtek,dcycle:
> +          description: |
> +            An integer describing the level to adjust output duty cycle.
> +            Valid arguments are described as below:
> +            0: 0ns
> +            2: + 0.25ns
> +            3: + 0.5ns
> +            4: -0.25ns
> +            5: -0.5ns
> +          $ref: /schemas/types.yaml#/definitions/uint32
> +          enum: [ 0, 2, 3, 4, 5 ]
> +
> +      required:
> +        - pins
> +
> +      additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +     pinctrl@4e000 {
> +         compatible = "realtek,rtd16xxb-pinctrl";
> +         reg = <0x4e000 0x130>;
> +
> +         emmc_pins_hs200: emmc_pins_hs200 {
> +             pins = "emmc_clk",
> +                    "emmc_cmd",
> +                    "emmc_data_0",
> +                    "emmc_data_1",
> +                    "emmc_data_2",
> +                    "emmc_data_3",
> +                    "emmc_data_4",
> +                    "emmc_data_5",
> +                    "emmc_data_6",
> +                    "emmc_data_7";
> +             function = "emmc";
> +             realtek,pdrive = <0x2>;
> +             realtek,ndrive = <0x2>;
> +         };
> +
> +         i2c_pins_0: i2c_pins_0 {
> +             pins = "gpio_12",
> +                    "gpio_13";
> +             function = "i2c0";
> +             drive-strength = <4>;
> +         };
> +     };
> -- 
> 2.41.0
>
