Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A3C759E66
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjGSTVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGSTVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:21:08 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91041BFC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:21:04 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so75973035e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689794463; x=1692386463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=61Vthzi+jTZc0OfRE0feJj3h8OeCFS14mJvBksaJnnI=;
        b=pzNtRS1B2p/uIypnjPAvtXVS4EPtglILWxAokj5oph/6BExIaa+o41LOomTOziP2nx
         7PgfS3bMXFrJ3mC2uCDTmPQ+wfUKZVJryCitgfd295rOinv3xtx+2ShzS/rVCgRbZWTR
         lUlv9WTsLyL6Y4Pr/5kTfHlTO/5dUsX8bd+SdKsWje43p4ciOfEh1Gw9/5gU5tgkikUc
         uz3hT0N+/4bxOW9zlKmF4jnL3k/IO/LmFG8ZjmQPLKizvkKVb5NwyN6JAoTL38EgruL9
         uFYvlVIhsOjgHSgpEjMzKq1o/kYkDqTlXVtxmJfS6cRUh2L+aH3g3RK2/m3GVdRcEglf
         IbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689794463; x=1692386463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61Vthzi+jTZc0OfRE0feJj3h8OeCFS14mJvBksaJnnI=;
        b=dzCs1XpIgYA+ZNZq7BSqnQgyn4iOQRvazvlRwd1tZwQalN/asVsfvE77smkNst6v3i
         zwcFU9YskFrSqa0hOGgt5xvtmDkZWddu4NNSqZfi5ZJcoXAilJVYWiogLthvrrvdWoUx
         ZlfL72juMoNpZm26O2P5OSrgkrxc4Gsh2603lMS/gsgndw1z22irAoQJLNP/WlQorTgC
         8jgZGcz97nseV+s5nU22sGRFC5Q1AgWOICOGDzvAA2NYxUktYQFk+UTE1Nl9ZlVodFQb
         YnhrkPPN6aM+NkWXjoWUF2roArWyUr7iOLvZ36wmMt7NmKqW2tsB0Y3VttoZ+y6ezRcs
         RBlA==
X-Gm-Message-State: ABy/qLa7YIFyYU7+hfOFWMNgkqYDKVPU+Op6b8TyTwQToVt6WvS+Pyrz
        5LKygHafM1+LPdK1nQz0OOlIXA==
X-Google-Smtp-Source: APBJJlFTo/F6vaMjqhpOxlJ7TqFQaLas56ehOzImE5APBRmfbUaci/1k29Wg5tu9Q96UE2KmSKH1hA==
X-Received: by 2002:a1c:7501:0:b0:3fc:10:b25f with SMTP id o1-20020a1c7501000000b003fc0010b25fmr5620160wmc.15.1689794463153;
        Wed, 19 Jul 2023 12:21:03 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id r17-20020adfe691000000b0031444673643sm5991086wrm.57.2023.07.19.12.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 12:21:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: pinctrl: qcom,sm8350-lpass-lpi: add SM8350 LPASS TLMM
Date:   Wed, 19 Jul 2023 21:20:56 +0200
Message-Id: <20230719192058.433517-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for pin controller in SM8350 Low Power Audio SubSystem
(LPASS).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes in v3:
1. Correct subject typo biding->bindings.
2. Add Rb tag.
3. Not dropping the label as Rob asked for, because it is actually used
   in the example.

Changes in v2:
1. None
---
 .../qcom,sm8350-lpass-lpi-pinctrl.yaml        | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml
new file mode 100644
index 000000000000..2e65ae08dd21
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml
@@ -0,0 +1,143 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM8350 SoC LPASS LPI TLMM
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description:
+  Top Level Mode Multiplexer pin controller in the Low Power Audio SubSystem
+  (LPASS) Low Power Island (LPI) of Qualcomm SM8350 SoC.
+
+properties:
+  compatible:
+    const: qcom,sm8350-lpass-lpi-pinctrl
+
+  reg:
+    items:
+      - description: LPASS LPI TLMM Control and Status registers
+      - description: LPASS LPI MCC registers
+
+  clocks:
+    items:
+      - description: LPASS Core voting clock
+      - description: LPASS Audio voting clock
+
+  clock-names:
+    items:
+      - const: core
+      - const: audio
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    description: Specifying the pin number and flags, as defined in
+      include/dt-bindings/gpio/gpio.h
+    const: 2
+
+  gpio-ranges:
+    maxItems: 1
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-sm8350-lpass-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-sm8350-lpass-state"
+        additionalProperties: false
+
+$defs:
+  qcom-sm8350-lpass-state:
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: /schemas/pinctrl/pincfg-node.yaml
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          pattern: "^gpio([0-9]|1[0-9]|2[0-2])$"
+
+      function:
+        enum: [ dmic1_clk, dmic1_data, dmic2_clk, dmic2_data, dmic3_clk,
+                dmic3_data, dmic4_clk, dmic4_data, ext_mclk1_a, ext_mclk1_b,
+                ext_mclk1_c, ext_mclk1_d, ext_mclk1_e, gpio, i2s0_clk,
+                i2s0_data, i2s0_ws, i2s1_clk, i2s1_data, i2s1_ws, i2s2_clk,
+                i2s2_data, i2s2_ws, i2s3_clk, i2s3_data, i2s3_ws, i2s4_clk,
+                i2s4_data, i2s4_ws, slimbus_clk, slimbus_data, swr_rx_clk,
+                swr_rx_data, swr_tx_clk, swr_tx_data, wsa_swr_clk,
+                wsa_swr_data, wsa2_swr_clk, wsa2_swr_data ]
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+      drive-strength:
+        enum: [2, 4, 6, 8, 10, 12, 14, 16]
+        default: 2
+        description:
+          Selects the drive strength for the specified pins, in mA.
+
+      slew-rate:
+        enum: [0, 1, 2, 3]
+        default: 0
+        description: |
+          0: No adjustments
+          1: Higher Slew rate (faster edges)
+          2: Lower Slew rate (slower edges)
+          3: Reserved (No adjustments)
+
+      bias-bus-hold: true
+      bias-pull-down: true
+      bias-pull-up: true
+      bias-disable: true
+      input-enable: true
+      output-high: true
+      output-low: true
+
+    required:
+      - pins
+      - function
+
+    additionalProperties: false
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - gpio-controller
+  - "#gpio-cells"
+  - gpio-ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/sound/qcom,q6afe.h>
+
+    lpass_tlmm: pinctrl@33c0000 {
+        compatible = "qcom,sm8350-lpass-lpi-pinctrl";
+        reg = <0x033c0000 0x20000>,
+              <0x03550000 0x10000>;
+
+        clocks = <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+                 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+        clock-names = "core", "audio";
+
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&lpass_tlmm 0 0 15>;
+    };
-- 
2.34.1

