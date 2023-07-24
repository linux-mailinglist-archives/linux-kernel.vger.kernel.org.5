Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7632475F549
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjGXLkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjGXLkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:40:03 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA46E5D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 04:40:01 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so6353033e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 04:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690198799; x=1690803599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/+BbWhjCVQXjo6X+9ZHCaLgHibuwpDeaBnLdGZ6KM0=;
        b=sqfd66HtLt9buSOpsu7l1ht77NZWK8VFa5uAv/YiEUDcMF1yZDd84kbLUu1LAZpsqF
         2kVQqEvhDWWakizlpcNjYV24p4EyauIQjP4P8AZife3BH4uDgYjoxP33E0FdmqmxJkgM
         JuK5BDgbCR7ve/xx7dFi8V5j+/judw4Fwh4i/FUBwDW9Zt9t443fy7HoZDu3tQUgx/qW
         F/hwxxw5z8/iVs95OT0XvjIYXbuEqxMRNm/6x3oe83HLVlGgtA2ScuQfDzrUWVQAn1Xx
         d+ZuVu6+zsdBk2mR/II9SO1b8411hj5a4Et1U7EaqervaW1TsKxnQCcMZL8L1b4cYRSG
         6wqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690198799; x=1690803599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/+BbWhjCVQXjo6X+9ZHCaLgHibuwpDeaBnLdGZ6KM0=;
        b=Q/r30DwphfJYzUEQMaIruKN2WsdMIlvj4uBad5Ef93h/p7MOi7ZkhkfWIr0++Da+Ai
         lEL9AwikWgNPaEXTmnOsB4NsvFX4WWhMXwC68Jx2S0n00FuS57w8K7UO3w7/vuH+taZl
         ZyfzFMH843bfI15zHaM/NwySe04sqCF1hoJZKfZ3opm0V9790YHsCfPhMeaxNr3xSfAs
         djpPsCtO45ubvtqO45LtdvNLC+voHWuXZY+SbtL9+9thSpqqVBrJOT40s4G7e4p9Hh3E
         VhrHAec63bopWhWnDyrJDhHHan14ajZ/O1PBi8rRQsR9rMWmhqtGSFMFkhXsVAUvjZNX
         1v5Q==
X-Gm-Message-State: ABy/qLajHsVuQ2FeK99KTZfdxgS5UawHqsafzB+0mT7Me7HKTiacfMRO
        yoWbLKEOqM/SK+bTQQMrKPOJNw==
X-Google-Smtp-Source: APBJJlHmaMUu7I0y3nbcG5Zms/0Eyb9967pAyXFvIm8URnj7ca4W7kEnl3evXtrWbCy4k+TdLw8ZHQ==
X-Received: by 2002:a05:6512:208b:b0:4f8:5f32:b1da with SMTP id t11-20020a056512208b00b004f85f32b1damr4710879lfr.24.1690198799393;
        Mon, 24 Jul 2023 04:39:59 -0700 (PDT)
Received: from [192.168.1.101] (abyl203.neoplus.adsl.tpnet.pl. [83.9.31.203])
        by smtp.gmail.com with ESMTPSA id u1-20020ac24c21000000b004fb881e5c23sm2168977lfq.47.2023.07.24.04.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 04:39:59 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 24 Jul 2023 13:39:56 +0200
Subject: [PATCH v2 1/3] dt-bindings: pinctrl: qcom,sm6115-lpass-lpi: add
 SM6115 LPASS TLMM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230722-topic-6115_lpasstlmm-v2-1-d4883831a858@linaro.org>
References: <20230722-topic-6115_lpasstlmm-v2-0-d4883831a858@linaro.org>
In-Reply-To: <20230722-topic-6115_lpasstlmm-v2-0-d4883831a858@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690198796; l=4319;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=iSpAVJW61WozVsLfgRyhK8cD7nEZll1HIje49PhmNYw=;
 b=cqah+p04AMVUNtYoGxaCQ3qEmqoBw2FHImoGiweiLZHttXrAUXBIjLYHdiwlBpjCDLIgh+V0W
 U8mms27sDgkC8rZL6fvmYg6zxbSvr5ocFv5HqUNCnlsj4qNRfvMwtGn
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 000000000000..abac3311fc55
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
+          pattern: "^gpio([0-9]|1[0-8])$"
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
+        gpio-ranges = <&lpass_tlmm 0 0 19>;
+    };

-- 
2.41.0

