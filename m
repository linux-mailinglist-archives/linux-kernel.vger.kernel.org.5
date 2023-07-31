Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED22769F04
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjGaRLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjGaRLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:11:22 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED8D35AD;
        Mon, 31 Jul 2023 10:07:45 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 46F38423EC;
        Mon, 31 Jul 2023 22:06:44 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1690823204; bh=SqI9LjfeszS9ddVacQJ7LtuNyQ3l163VDzjnQYL9Q40=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=g6zR/XVazhALC4nulmfaGhnwbyMy2/zChe8zRaYWc89r+NOxXf035dTWQ70FRfXSz
         3JblA6EWnKn0qEo8xU+T9iWAo59mwW7GsGS/6gmeL992Rik1PbVPVqcPx9O6Zqsg2l
         jEIYj0LfPUPUAYJLi/ThJvikSmoo6ZHeEUJi6MIoAMXwMlUjg5v16GJrL2kxXXtt2a
         6WVFg2puXisyARFeG/55gB13aGbK2BTa02bI99turBhjGqLATCKQQpHbnNQhyO4h3B
         VPKLykE2bvlx30H1HOO6alCuoLbrTBc2aEEQSI5yysUPcCFp1l9neOUuA6jYSzUi9R
         IEhWZjup1xpfA==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Mon, 31 Jul 2023 22:06:24 +0500
Subject: [PATCH v2 1/4] dt-bindings: power: supply: Add pm8916 VM-BMS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-pm8916-bms-lbc-v2-1-82a4ebb39c16@trvn.ru>
References: <20230731-pm8916-bms-lbc-v2-0-82a4ebb39c16@trvn.ru>
In-Reply-To: <20230731-pm8916-bms-lbc-v2-0-82a4ebb39c16@trvn.ru>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2880; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=SqI9LjfeszS9ddVacQJ7LtuNyQ3l163VDzjnQYL9Q40=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBkx+oiPbrolN3UUSZJIri35XiJtmfD8tp8lTac2
 X5NBdDqwEaJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZMfqIgAKCRBDHOzuKBm/
 dU80D/4vI6j6cEVM8l7Fac5uOv6qkfOXFlQHhT/pjzxvHQblu80F0I1vrtb1xy5Yjr3WZZr+pFW
 3vr69pO3Iipg3BQsufH8EtUkCsBInA+QGJhqB5ifb1+kFdg75KNye4AGUjD/3uN7fca/aBJGvVD
 Cfj1sWoEj3FOf8x4avsOMuSMZwfInZxKYb1tdfjZBYyz5R2kNxTq442Jo7l1vdiKBRU0hB286oe
 SKuNtXLOHRgExOkp6ESwh+Co+oaUcFGV+AVo46u97HcvJxz3A0lq/t+El9KeLYjm5GCpY+sEbL4
 EWO+yB5z6fpT0k22I9HDaisT+4MJ1iuSJq7YI9Nv+eXXqZE1vzWUIPiXK6CZuu/bOcWh9xBF5dj
 oqW3uJMV4WPVjzpQgGWOJSZDqXYWrG+kUA1AUa4OcrpHFFfCeoXr32Udw4C2OPnZc2j6bbTen+E
 rZ3V13QPzqc8CjsqhtFeDnk7adzpuIMV3Rt6z2WHb6XArDCKLl59V6RIkh3/HVUW5+PFYP3lF+0
 FUal/N+p1VJ8BTTmtyBvOYbjhI8LoH0R6vVE32g9aHZnCzh5lox1Q1Ksn/JSzQUiuyRuFRpFCCm
 qIscNERcs7fgcTEqeksDgSO+lsY/OTKW05/S7BquVyjWJw2H+ctVqizNE23p35m/JsoL/cPpPRG
 MHRFmMu7jSgR59g==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm Voltage Mode BMS is a battery monitoring block in PM8916 PMIC.
Document it's DT binding.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
v2: Describe all interrupts. (Conor)
---
 .../bindings/power/supply/qcom,pm8916-bms-vm.yaml  | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pm8916-bms-vm.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pm8916-bms-vm.yaml
new file mode 100644
index 000000000000..ad764e69ab57
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pm8916-bms-vm.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/qcom,pm8916-bms-vm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Voltage Mode BMS
+
+maintainers:
+  - Nikita Travkin <nikita@trvn.ru>
+
+description:
+  Voltage Mode BMS is a hardware block found in some Qualcomm PMICs
+  such as pm8916. This block performs battery voltage monitoring.
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: qcom,pm8916-bms-vm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: BMS FSM left S3 mode
+      - description: BMS FSM entered S2 mode
+      - description: OCV measured in S3 mode
+      - description: OCV below threshold
+      - description: FIFO update done
+      - description: BMS FSM switched state
+
+  interrupt-names:
+    items:
+      - const: cv_leave
+      - const: cv_enter
+      - const: ocv_good
+      - const: ocv_thr
+      - const: fifo
+      - const: state_chg
+
+  monitored-battery: true
+
+  power-supplies: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - monitored-battery
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pmic {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      battery@4000 {
+        compatible = "qcom,pm8916-bms-vm";
+        reg = <0x4000>;
+        interrupts = <0x0 0x40 0 IRQ_TYPE_EDGE_RISING>,
+                     <0x0 0x40 1 IRQ_TYPE_EDGE_RISING>,
+                     <0x0 0x40 2 IRQ_TYPE_EDGE_RISING>,
+                     <0x0 0x40 3 IRQ_TYPE_EDGE_RISING>,
+                     <0x0 0x40 4 IRQ_TYPE_EDGE_RISING>,
+                     <0x0 0x40 5 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "cv_leave",
+                          "cv_enter",
+                          "ocv_good",
+                          "ocv_thr",
+                          "fifo",
+                          "state_chg";
+
+        monitored-battery = <&battery>;
+        power-supplies = <&pm8916_charger>;
+      };
+    };

-- 
2.41.0

