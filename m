Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF13C7D635F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbjJYHf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjJYHf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:35:28 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E0B1FC4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:33:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32d834ec222so3525572f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219236; x=1698824036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uwc9JCDL3rkkVFbk9N7iM2wJr0UcDwCxw/HwiGk2zO0=;
        b=p6azn/xWmkJVHgUM2UcObebM1KTbS0ogo9dT+TtjHawSQH3D2TwTg8xKBwgfN/RnE5
         lMsq5NTi/KkNki4wawLb/Du0Ax+5zIWh9i5sn30exE9xCm6ZykXT4+jIh7akjcbiTmDK
         mi1UfjFOaawrO7sT8uRua92eVxctOT7OQryTFzgUk8fIuB3Byj2TcBzCNl5+nPlwV8w9
         5wB9V3KdWHS1ck3zeBrgYoxYoqNNtGK13N38+YKse+OJhBR1be9sRluzcxTgTj1FdhZP
         XFKEnXWahIWKEj8KVjPppT67GQDlOJAyiD+Ay6U5shUwR0wChATc5KvhmZyPF6XCIdTr
         OyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219236; x=1698824036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uwc9JCDL3rkkVFbk9N7iM2wJr0UcDwCxw/HwiGk2zO0=;
        b=DvWFQ5jtSN3p/HLvqw6ScDeWCPj/wGuKbaXzbPfjdJmC/K9BoU9gNjML8y+UC18Wj8
         /TamxDV/d0eSDlMCMKfJUAhfGi8QQExgKbQHsNaU3mXmAYHW6S4dJeoxYPY+7H50VRsx
         SzosG2wbo12hQ8RzYZcnr26+3TKd1h6xVdNYFWPm0xRgKaKrEdkUQI0DsgCHsm+e7koa
         wbxYv7LYC4wyke/2dVwpMGPfUxd95cq/Ece5KTn5OYICejorEn68xmeBBOCaR3NT0Za0
         Ju3wOoBC5VAmUngdNMVjzx1NUohUfPlBbJ6xrgzCN0ifhJlmn1pYxbBqJPTs+B+YfCEO
         tIVw==
X-Gm-Message-State: AOJu0YwYwb0dm4k0aocHbYt2fBcV4Q9JN5rpi5QgDFbRrhqEV8UgmYRi
        q+POFt/VNA08onlhSE4hRMViFg==
X-Google-Smtp-Source: AGHT+IH8ONcCxuY+xA+lpNOVerJcMDw2u8B3Hpb7YvdmqaCq1t5yTMsAgsaHpK+xBwJQPw4PyJTXtg==
X-Received: by 2002:adf:ef8b:0:b0:32d:96a7:9551 with SMTP id d11-20020adfef8b000000b0032d96a79551mr9782838wro.36.1698219235741;
        Wed, 25 Oct 2023 00:33:55 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d66d1000000b00327cd5e5ac1sm11546605wrw.1.2023.10.25.00.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:33:55 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:33:51 +0200
Subject: [PATCH 1/3] dt-bindings: pinctrl: document the SM8650 Top Level
 Mode Multiplexer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-tlmm-v1-1-4e3d84a3a46b@linaro.org>
References: <20231025-topic-sm8650-upstream-tlmm-v1-0-4e3d84a3a46b@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-tlmm-v1-0-4e3d84a3a46b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5913;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=QzzXCNNyOz2j+y/lu1HZH90l6py5UFLw9bk1+DdA3Sc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMTg1XZIo6a7+noR7B4NYlhsF7Y3nNM2g/nX5HE1
 YC8uz8qJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjE4AAKCRB33NvayMhJ0e5DD/
 0XTAz+AzPSMC/6JaTcd/vUkYlPuUN8SPVXKCgv3DXOTXcv/CyagTC0Qux7NY9rDo+EF4YJ1Tlw7qdk
 SBlYKwVWQyav614e/qRFag9koO9HCYNFBIoxvPi6qmnsDlSVfFqBX7+O/sfiYM64M33xjf5bsRqVGS
 2bGZjIhVxtxoIpjbB6aQrzoNwG5uTOeZFjjzzjzAfHmM4gP8u649kEUfHNO9qnxAENHWfqxY4cBHWc
 NbLuRN2C4UjUmxVOBd+xj0l897avdrZObJ0nNNKmeQ8mXJuWrT0g2Tv+/zrOtUAZ1ypY9IvHq+km2k
 YO80jWQzQ9XWoFd8iPRn5Z/dySLEiKBP8jBMlk5gZsvbo+y+A1lguaQ9X4v+c6B1MHV1gGG5TGgceB
 ngDZLuUDt52JxJV2bzez9wUOMWOHodtzkHQEo4hH8NZbQtdIqS6+LMUJCdf3nH/Z8MqR94Bv07irN9
 7sRiOL+tyOX6hHSnzjfBXw7avWX4rs2he8rKm4JA+8ZR28gSoODQAPAlHJB3sf6bwYUzRTTxUyVBAR
 BAuvmPxHdE8syFF1q3+U+qohisbGzlVlNyYdjg3kEdR5OB923UENq0j7ck5OJBNQNmKlTOqWA2ab5f
 Kx4FG9ZyQZ2P3S2uveH3c9pFG5a6M/ir0M3cwWCbennjcReHP+9ReD2Waq8A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
 .../bindings/pinctrl/qcom,sm8650-tlmm.yaml         | 157 +++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-tlmm.yaml
new file mode 100644
index 000000000000..f387d249cbaa
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-tlmm.yaml
@@ -0,0 +1,157 @@
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
+      bias-disable: true
+      bias-pull-down: true
+      bias-pull-up: true
+      drive-strength: true
+      input-enable: true
+      output-disable: true
+      output-high: true
+      output-low: true
+
+    required:
+      - pins
+
+    additionalProperties: false
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

