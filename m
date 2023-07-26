Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2876C763153
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjGZJMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbjGZJLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:11:51 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E74C3A9B;
        Wed, 26 Jul 2023 02:08:01 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36Q967Ww8008092, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36Q967Ww8008092
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 26 Jul 2023 17:06:07 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 26 Jul 2023 17:06:19 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 26 Jul 2023 17:06:18 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Wed, 26 Jul 2023 17:06:18 +0800
From:   TY Chang <tychang@realtek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/7] dt-bindings: pinctrl: realtek: add RTD1319D pinctrl binding
Date:   Wed, 26 Jul 2023 17:04:08 +0800
Message-ID: <20230726090409.16606-7-tychang@realtek.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726090409.16606-1-tychang@realtek.com>
References: <20230726090409.16606-1-tychang@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for RTD1319D.

Signed-off-by: TY Chang <tychang@realtek.com>
---
 .../pinctrl/realtek,rtd1319d-pinctrl.yaml     | 163 ++++++++++++++++++
 1 file changed, 163 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/realtek,rtd1319d-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/realtek,rtd1319d-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/realtek,rtd1319d-pinctrl.yaml
new file mode 100644
index 000000000000..350faaed1836
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/realtek,rtd1319d-pinctrl.yaml
@@ -0,0 +1,163 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Realtek Semiconductor Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/realtek,rtd1319d-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek DHC RTD1319D Pin Controller
+
+maintainers:
+  - TY Chang <tychang@realtek.com>
+
+description: |
+  Binding for Realtek DHC RTD1319D SoC pin control.
+
+properties:
+  compatible:
+    const: realtek,rtd13xxd-pinctrl
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  '^.*$':
+    if:
+      type: object
+    then:
+      allOf:
+        - $ref: pincfg-node.yaml#
+        - $ref: pinmux-node.yaml#
+
+      properties:
+        pins:
+          items:
+            enum: [ gpio_0, gpio_1, gpio_2, gpio_3, gpio_4, gpio_5, gpio_6, gpio_7,
+                    gpio_8, gpio_9, gpio_10, gpio_11, gpio_12, gpio_13, gpio_14,
+                    gpio_15, gpio_16, gpio_17, gpio_18, gpio_19, gpio_20, gpio_21,
+                    gpio_22, gpio_23, usb_cc2, gpio_25, gpio_26, gpio_27, gpio_28,
+                    gpio_29, gpio_30, gpio_31, gpio_32, gpio_33, gpio_34, gpio_35,
+                    hif_data, hif_en, hif_rdy, hif_clk, gpio_40, gpio_41, gpio_42,
+                    gpio_43, gpio_44, gpio_45, gpio_46, gpio_47, gpio_48, gpio_49,
+                    gpio_50, usb_cc1, gpio_52, gpio_53, ir_rx, ur0_rx, ur0_tx,
+                    gpio_57, gpio_58, gpio_59, gpio_60, gpio_61, gpio_62, gpio_63,
+                    gpio_64, emmc_rst_n, emmc_dd_sb, emmc_clk, emmc_cmd, emmc_data_0,
+                    emmc_data_1, emmc_data_2, emmc_data_3, emmc_data_4, emmc_data_5,
+                    emmc_data_6, emmc_data_7, dummy, gpio_78, gpio_79, gpio_80,
+                    gpio_81, ur2_loc, gspi_loc, hi_width, sf_en, arm_trace_dbg_en,
+                    ejtag_aucpu_loc, ejtag_acpu_loc, ejtag_vcpu_loc, ejtag_scpu_loc,
+                    dmic_loc, ejtag_secpu_loc, vtc_dmic_loc, vtc_tdm_loc, vtc_i2si_loc,
+                    tdm_ai_loc, ai_loc, spdif_loc, hif_en_loc, sc0_loc, sc1_loc,
+                    scan_switch, wd_rset, boot_sel, reset_n, testmode ]
+
+        function:
+          enum: [ gpio, nf, emmc, tp0, tp1, sc0, sc0_data0, sc0_data1, sc0_data2,
+                  sc1, sc1_data0, sc1_data1, sc1_data2, ao, gspi_loc0, gspi_loc1,
+                  uart0, uart1, uart2_loc0, uart2_loc1, i2c0, i2c1, i2c3, i2c4,
+                  i2c5, pcie1, sdio, etn_led, etn_phy, spi, pwm0_loc0, pwm0_loc1,
+                  pwm1_loc0, pwm1_loc1, pwm2_loc0, pwm2_loc1, pwm3_loc0, pwm3_loc1,
+                  qam_agc_if0, qam_agc_if1, spdif_optical_loc0, spdif_optical_loc1,
+                  usb_cc1, usb_cc2, vfd, sd, dmic_loc0, dmic_loc1, ai_loc0, ai_loc1,
+                  tdm_ai_loc0, tdm_ai_loc1, hi_loc0, hi_m, vtc_i2so, vtc_i2si_loc0,
+                  vtc_i2si_loc1, vtc_dmic_loc0, vtc_dmic_loc1, vtc_tdm_loc0,
+                  vtc_tdm_loc1, dc_fan, pll_test_loc0, pll_test_loc1, ir_rx,
+                  uart2_disable, gspi_disable, hi_width_disable, hi_width_1bit,
+                  sf_disable, sf_enable, scpu_ejtag_loc0, scpu_ejtag_loc1,
+                  scpu_ejtag_loc2, acpu_ejtag_loc0, acpu_ejtag_loc1, acpu_ejtag_loc2,
+                  vcpu_ejtag_loc0, vcpu_ejtag_loc1, vcpu_ejtag_loc2, secpu_ejtag_loc0,
+                  secpu_ejtag_loc1, secpu_ejtag_loc2, aucpu_ejtag_loc0, aucpu_ejtag_loc1,
+                  aucpu_ejtag_loc2, iso_tristate, dbg_out0, dbg_out1, standby_dbg,
+                  spdif, arm_trace_debug_disable, arm_trace_debug_enable,
+                  aucpu_ejtag_disable, acpu_ejtag_disable, vcpu_ejtag_disable,
+                  scpu_ejtag_disable, secpu_ejtag_disable, vtc_dmic_loc_disable,
+                  vtc_tdm_disable, vtc_i2si_disable, tdm_ai_disable, ai_disable,
+                  spdif_disable, hif_disable, hif_enable, test_loop, pmic_pwrup ]
+
+        drive-strength:
+          enum: [4, 8]
+
+        bias-pull-down: true
+
+        bias-pull-up: true
+
+        bias-disable: true
+
+        input-schmitt-enable: true
+
+        input-schmitt-disable: true
+
+        drive-push-pull: true
+
+        power-source:
+          description: |
+            Valid arguments are described as below:
+            0: power supply of 1.8V
+            1: power supply of 3.3V
+          enum: [0, 1]
+
+        realtek,pdrive:
+          description: |
+            An integer describing the level to adjust PMOS output driving capability.
+          $ref: /schemas/types.yaml#/definitions/uint32
+          minimum: 0
+          maximum: 7
+
+        realtek,ndrive:
+          description: |
+            An integer describing the level to adjust NMOS output driving capability.
+          $ref: /schemas/types.yaml#/definitions/uint32
+          minimum: 0
+          maximum: 7
+
+        realtek,dcycle:
+          description: |
+            An integer describing the level to adjust output duty cycle.
+            Valid arguments are described as below:
+            0: 0ns
+            2: + 0.25ns
+            3: + 0.5ns
+            4: -0.25ns
+            5: -0.5ns
+          $ref: /schemas/types.yaml#/definitions/uint32
+          enum: [ 0, 2, 3, 4, 5 ]
+
+      required:
+        - pins
+
+      additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+     pinctrl@4e000 {
+         compatible = "realtek,rtd13xxd-pinctrl";
+         reg = <0x4e000 0x130>;
+
+         emmc_pins_hs200: emmc_pins_hs200 {
+             pins = "emmc_clk",
+                    "emmc_cmd",
+                    "emmc_data_0",
+                    "emmc_data_1",
+                    "emmc_data_2",
+                    "emmc_data_3",
+                    "emmc_data_4",
+                    "emmc_data_5",
+                    "emmc_data_6",
+                    "emmc_data_7";
+             function = "emmc";
+             realtek,pdrive = <0x2>;
+             realtek,ndrive = <0x2>;
+         };
+
+         i2c_pins_0: i2c_pins_0 {
+             pins = "gpio_12",
+                    "gpio_13";
+             function = "i2c0";
+             drive-strength = <4>;
+         };
+     };
-- 
2.41.0

