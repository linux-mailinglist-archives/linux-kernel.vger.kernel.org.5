Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686B975DB2D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 10:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGVIxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 04:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjGVIw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 04:52:57 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0134E26B0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:52:55 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b6f97c7115so39430971fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690015974; x=1690620774;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLi0ZxQW1HPTfc+V8jkz5vcYl8Z+aYUPawOmFoE8J38=;
        b=X58oriPd1dkJhPP8sly94KSAJqrO2uFkX8CLOO5gEUpSYgCZQgKClTjMqKHGxGg+SQ
         tuQ+cGocCdhnZcAsSOPseGsoHA8N+Yw92oGriX/kUPGBcSUJf6O8Vin1rkxB/NnowuoG
         X94GoHQ2f+mQ4pqSrH1Gcz6VsH6Cfd+WWoS3X7WbEdV9V1meXHd67fIjuFTcBV94fxmS
         cW3rVxdVuw/FrfqelPaYWypeLsCMeJ6I/12brYeoP+L3lG+cvV/5o7CDM82SisV9gCy7
         X3bIjAJT3QGThNcC5WbHLYxLdpWRl1E7q4oiLCdVtC7g/ee86Gg98mmHhjwhS4hTU/1m
         TEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690015974; x=1690620774;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLi0ZxQW1HPTfc+V8jkz5vcYl8Z+aYUPawOmFoE8J38=;
        b=kNfDqT0AUKZeTWgfyiiMaZSzu+SgKr+QvaQJWoJyIvH6AcJaYoylH6RepFnSO4tF0z
         bfrJrVaCy/8xP6Ti0pmDHe+2Mh1CDm5Klt2EyZwy49WG7CxOSB7mPv2r8tR/Lo1Lhdn+
         ax151xMJNpO6y0rMhzRgPt9UM3Oc3QqPDMhqowvsEFoxJAn1FkMfJaSudEVrVnNYFOx+
         31+7mFjqHxDiePQnOuSPUX5KB3hLFISkD5piVPBq+KrlzR8jILk+CzG9JMNZSgnIPfl9
         ABfkl5IbldxXLMHqL3HlJMgIL+Yo76yNWrfpWyGkb8sPmqi1vI37aYozfHpN+ctH7You
         XsvQ==
X-Gm-Message-State: ABy/qLbNhFLyJP5PiBOIkq96arz+3yWleOj9YYae2/FPB/bVGLJt/2Oc
        lBisUzbnuWUakB7Esn7Kx/pcJw==
X-Google-Smtp-Source: APBJJlHGQI8qaUrOKPg6gnzzv8f+08Icu/BhHhKInUry0hT/Y1cw/896sWky5wPZg8NhbfGl7kokjA==
X-Received: by 2002:a19:6d16:0:b0:4f8:4177:e087 with SMTP id i22-20020a196d16000000b004f84177e087mr2437113lfc.47.1690015974292;
        Sat, 22 Jul 2023 01:52:54 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id x9-20020ac259c9000000b004fbf5242e8bsm1107034lfn.231.2023.07.22.01.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 01:52:53 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 22 Jul 2023 10:52:45 +0200
Subject: [PATCH 1/3] dt-bindings: pinctrl: qcom,sm6115-lpass-lpi: add
 SM6115 LPASS TLMM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230722-topic-6115_lpasstlmm-v1-1-32d1643d8774@linaro.org>
References: <20230722-topic-6115_lpasstlmm-v1-0-32d1643d8774@linaro.org>
In-Reply-To: <20230722-topic-6115_lpasstlmm-v1-0-32d1643d8774@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690015971; l=4326;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=c43yKRy0X3J5bR0oJzd2QzC0RF8oja+5GuFLw0rnLyM=;
 b=iVWBp23i34c79z8+M30T/6QTmi7ZvcvfJOz4DOcbFsetM4DlLtYcHMx7GHiGwEO/BEDqUfTHf
 da1bCH1Q/V+D3poxjeyBpMA0fOkaE/ObabBdbVr0EHNNcQ1T3CliTtQ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for pin controller in SM6115 Low Power Audio SubSystem
LPASS).

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml     | 135 +++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml
new file mode 100644
index 000000000000..1fe876e6bd66
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml
@@ -0,0 +1,135 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM6115 SoC LPASS LPI TLMM
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description:
+  Top Level Mode Multiplexer pin controller in the Low Power Audio SubSystem
+  (LPASS) Low Power Island (LPI) of Qualcomm SM6115 SoC.
+
+properties:
+  compatible:
+    const: qcom,sm6115-lpass-lpi-pinctrl
+
+  reg:
+    items:
+      - description: LPASS LPI TLMM Control and Status registers
+      - description: LPASS LPI MCC registers
+
+  clocks:
+    items:
+      - description: LPASS Audio voting clock
+
+  clock-names:
+    items:
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
+      - $ref: "#/$defs/qcom-sm6115-lpass-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-sm6115-lpass-state"
+        additionalProperties: false
+
+$defs:
+  qcom-sm6115-lpass-state:
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
+        enum: [ dmic01_clk, dmic01_data, dmic23_clk, dmic23_data, gpio, i2s1_clk,
+                i2s1_data, i2s1_ws, i2s2_clk, i2s2_data, i2s2_ws, i2s3_clk,
+                i2s3_data, i2s3_ws, qua_mi2s_data, qua_mi2s_sclk, qua_mi2s_ws,
+                swr_rx_clk, swr_rx_data, swr_tx_clk, swr_tx_data, wsa_mclk ]
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
+    lpass_tlmm: pinctrl@a7c0000 {
+        compatible = "qcom,sm6115-lpass-lpi-pinctrl";
+        reg = <0x0a7c0000 0x20000>,
+              <0x0a950000 0x10000>;
+        clocks = <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+        clock-names = "audio";
+
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&lpass_tlmm 0 0 15>;
+    };

-- 
2.41.0

