Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAB87DB7DF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjJ3KWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjJ3KWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:22:05 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7D32D47
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:50:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32dbbf3c782so3134135f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698659418; x=1699264218; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ik/2UbtoZBni7af8VTjTVFA/brqfFdFX2keRMOmRfNI=;
        b=tZ6QjKoTLmEIYT5EvT50q9lFETIaTDRIytMWH16whpVqX4J83f7cMb0N7mOh34Lw5g
         tYmUFy/wwQmvYwh1+h0VoiYJFrMLRnJ00g4Rjefn5PVAHhqK/Xq/4x8wGgntkyVq9BwU
         ZBpUKPZ9GiVvzU5LgwY8HJ/uge6Hj0zEiSoUGb4+1LQnYzM1XlkBUPtzZaO9jhI5xn6D
         jZJaQTF0yUhIHjGycmUeE2z29hcq9nlpo+cfIM7sxXrKKyYp3VDs7h0s/ogLaEi7o4E2
         /7YsaYfkBmDBqsj+vWzIyasEe37NdFDh9Uz6l/BchfUt1ApXauKbV2Chk8CBP4Z3XTre
         u3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698659418; x=1699264218;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ik/2UbtoZBni7af8VTjTVFA/brqfFdFX2keRMOmRfNI=;
        b=gDrKHAc4FlvSXOHDbC5+0nj7LLMrpKhUSbV+CS64RpXLN4WT1S3YwpjGL6Fe4LiRvC
         YVf7XmuCXZfKDf+sgkbG5KC10Yov83PtZ8nqbOhGpLYWnKJ4ZWCQuNojTR3n2qbykNJG
         +ny2M5X/ZQFcXpGzOzjoUG5FluLre1+4QNv+6XpCWH5SsBe67emobtmiRQ5wHeXYe0Dy
         TDbjQmwQnWTrlUj8tfFtwX5Pr8rKoLDYPDZTDynSPHELrQTYmg2TJ1C1RfgJwpVnT0r3
         jDjtMscfglUq1EuFnM5UO0yRZnF15D9s2Q7z8bgG6VuRmJZBrpcXy6EooxdiI3L94otB
         uTQw==
X-Gm-Message-State: AOJu0YyGM5sd/dPGBqys/dq/Uy2ZpDQwMrVlFUmanoYSJRq/csg5t8ig
        QDX5rSdg33PAYACyV6NzPSFNIg==
X-Google-Smtp-Source: AGHT+IH9gqEL0SI0sZp8nVpU9z5pJrWgdCmgB8ugJn62wDOnbXFjB5yg5zC0WxNhqekp0GBdVWwugw==
X-Received: by 2002:a05:6000:118b:b0:32d:a431:9045 with SMTP id g11-20020a056000118b00b0032da4319045mr10615423wrx.30.1698659418324;
        Mon, 30 Oct 2023 02:50:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id hj19-20020a05600c529300b0040841e79715sm8625242wmb.27.2023.10.30.02.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 02:50:17 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 30 Oct 2023 10:50:13 +0100
Subject: [PATCH v2 1/4] dt-bindings: pinctrl: document the SM8650 Top Level
 Mode Multiplexer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-topic-sm8650-upstream-tlmm-v2-1-9d4d4386452d@linaro.org>
References: <20231030-topic-sm8650-upstream-tlmm-v2-0-9d4d4386452d@linaro.org>
In-Reply-To: <20231030-topic-sm8650-upstream-tlmm-v2-0-9d4d4386452d@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5689;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=nggOMr8ECAEgR0LBB0FF7GgnRM9LDATVWfgH2ohdmoc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlP3xWzkMDw7s54pV6Yw0I1GJCa5XHuJQlb3Jswo+d
 SOoJnTSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZT98VgAKCRB33NvayMhJ0Wv9EA
 C/vR8iN8ZZCgwPT/ck0tAKhxKbtRCzEX+PUMmic2+X0Hh49tAX0DVvx5PW2DX8BzxlmaSjSqMQzCzq
 +EOl64VJwO+HBn2NQ1oUZ2Y460HAJBeK/Wcgxzhz3BGWA3xc7QMjGoHdH7HWwNzDlE1Vnn6r48n4S8
 G4SVH42L6EiF3zDdsoYu7/jc7ERKVEtSV1IGeWTO3+ksqao1pQu55aJf4xxnZGJ/aPno6VsiMGGMYd
 fdFRhGyhy3ozZQPnslbFhxgNQBuDJUKtqZrMb/auNekPsyRIFwXqLYvVTTYfdXuDxx+0pE4afE0KZ2
 UNQrDWfVZ+6bQIQGiAeSn7he5MD2ky9cUIvk7DCv3QsBtElZGRaEzPrj5SMch99AtLq7LbJMhHrWeL
 LCNNHFImH842BXaeyoWa9SXE2/Pztb23/DkvhgouUQlCzvoocW8alkmaFwZNTVUMV8jb9/Sy9uoir4
 n6NXs9Rjq66qzZD69GsVCAjVdeU3zRl4UQxGKwNq5tuykUKInZrP78xm3RJuW/rebAuGOrvVn572/E
 qZTjzc1UR23Krm14vV0AhuHxIYHg7XzIPEkHoeGFJqnGv2bzPJC/48MBarx242f8IZk0kpfuBx2a8y
 SHARoR09ZHNROyOSwyIlmVFSqkx8ZN6Xkz1VQR5kgS5uKE4rPE2UIAv7W8SQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Top Level Mode Multiplexer on the SM8650 Platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/pinctrl/qcom,sm8650-tlmm.yaml         | 147 +++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-tlmm.yaml
new file mode 100644
index 000000000000..30432be8fb07
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-tlmm.yaml
@@ -0,0 +1,147 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,sm8650-tlmm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. SM8650 TLMM block
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm SM8650 SoC.
+
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,sm8650-tlmm
+
+  reg:
+    maxItems: 1
+
+  interrupts: true
+  interrupt-controller: true
+  "#interrupt-cells": true
+  gpio-controller: true
+
+  gpio-reserved-ranges:
+    minItems: 1
+    maxItems: 105
+
+  gpio-line-names:
+    maxItems: 210
+
+  "#gpio-cells": true
+  gpio-ranges: true
+  wakeup-parent: true
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-sm8650-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-sm8650-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-sm8650-tlmm-state:
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
+    unevaluatedProperties: false
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          oneOf:
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|20[0-9])$"
+            - enum: [ ufs_reset, sdc2_clk, sdc2_cmd, sdc2_data ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+        enum: [ gpio, aoss_cti, atest_char, atest_usb, audio_ext_mclk0,
+                audio_ext_mclk1, audio_ref_clk, cam_aon_mclk2, cam_aon_mclk4,
+                cam_mclk, cci_async_in, cci_i2c_scl, cci_i2c_sda, cci_timer,
+                cmu_rng, coex_uart1_rx, coex_uart1_tx, coex_uart2_rx,
+                coex_uart2_tx, cri_trng, dbg_out_clk, ddr_bist_complete,
+                ddr_bist_fail, ddr_bist_start, ddr_bist_stop, ddr_pxi0,
+                ddr_pxi1, ddr_pxi2, ddr_pxi3, do_not, dp_hot, gcc_gp1,
+                gcc_gp2, gcc_gp3, gnss_adc0, gnss_adc1, i2chub0_se0,
+                i2chub0_se1, i2chub0_se2, i2chub0_se3, i2chub0_se4,
+                i2chub0_se5, i2chub0_se6, i2chub0_se7, i2chub0_se8,
+                i2chub0_se9, i2s0_data0, i2s0_data1, i2s0_sck, i2s0_ws,
+                i2s1_data0, i2s1_data1, i2s1_sck, i2s1_ws, ibi_i3c,
+                jitter_bist, mdp_vsync, mdp_vsync0_out, mdp_vsync1_out,
+                mdp_vsync2_out, mdp_vsync3_out, mdp_vsync_e, nav_gpio0,
+                nav_gpio1, nav_gpio2, nav_gpio3, pcie0_clk_req_n,
+                pcie1_clk_req_n, phase_flag, pll_bist_sync, pll_clk_aux,
+                prng_rosc0, prng_rosc1, prng_rosc2, prng_rosc3, qdss_cti,
+                qdss_gpio, qlink_big_enable, qlink_big_request,
+                qlink_little_enable, qlink_little_request, qlink_wmss,
+                qspi0, qspi1, qspi2, qspi3, qspi_clk, qspi_cs, qup1_se0,
+                qup1_se1, qup1_se2, qup1_se3, qup1_se4, qup1_se5, qup1_se6,
+                qup1_se7, qup2_se0, qup2_se1, qup2_se2, qup2_se3, qup2_se4,
+                qup2_se5, qup2_se6, qup2_se7, sd_write_protect, sdc40, sdc41,
+                sdc42, sdc43, sdc4_clk, sdc4_cmd, tb_trig_sdc2, tb_trig_sdc4,
+                tgu_ch0_trigout, tgu_ch1_trigout, tgu_ch2_trigout,
+                tgu_ch3_trigout, tmess_prng0, tmess_prng1, tmess_prng2,
+                tmess_prng3, tsense_pwm1, tsense_pwm2, tsense_pwm3, uim0_clk,
+                uim0_data, uim0_present, uim0_reset, uim1_clk, uim1_data,
+                uim1_present, uim1_reset, usb1_hs, usb_phy, vfr_0, vfr_1,
+                vsense_trigger_mirnat ]
+
+    required:
+      - pins
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    tlmm: pinctrl@f100000 {
+        compatible = "qcom,sm8650-tlmm";
+        reg = <0x0f100000 0x300000>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 211>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+
+        gpio-wo-state {
+            pins = "gpio1";
+            function = "gpio";
+        };
+
+        uart-w-state {
+            rx-pins {
+                pins = "gpio60";
+                function = "qup1_se7";
+                bias-pull-up;
+            };
+
+            tx-pins {
+                pins = "gpio61";
+                function = "qup1_se7";
+                bias-disable;
+            };
+        };
+    };
+...

-- 
2.34.1

