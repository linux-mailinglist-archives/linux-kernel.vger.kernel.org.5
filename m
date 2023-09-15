Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7531A7A150D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 07:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjIOFCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 01:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjIOFCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 01:02:01 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4C52718;
        Thu, 14 Sep 2023 22:01:55 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 8A9CC42264;
        Fri, 15 Sep 2023 10:01:49 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1694754109; bh=Gl5DvmVj086xnyzDaqlZ88oRMAhoEK8Os/bTYN02ZMI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=1C8JozA3QaTBXohhDDVDkzC5EyVkH43YxO0Em8b9bfk+kXf2t4yG1Vj5t3xesrpbc
         p7ToOAjIjOexG+8qSrD1zudsK+kQdmcKq5lYeFx16oYRXMG2x2bNr4Budna7MjYzYT
         hLMQ9LY5E25dk9ALkIWglfpmtmuYAcIzzg+tNsT9TSpJZ8jcU8nuk5AxDwWey5B8p5
         TUOJDUasywhCbNB6n7HbyFP5jDI8LOYH0UVKd6cBCgg0EZer0UQwzet9gMcUyB24NE
         vsZpvIsT2bMbULZjvup3OvvaptSHUmVN3pxZCBTIrElWkRMnqSO4GKVT8gjIujglIu
         Oo/vmpuylqgkA==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Fri, 15 Sep 2023 10:01:18 +0500
Subject: [PATCH v3 1/4] dt-bindings: power: supply: Add pm8916 VM-BMS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230915-pm8916-bms-lbc-v3-1-f30881e951a0@trvn.ru>
References: <20230915-pm8916-bms-lbc-v3-0-f30881e951a0@trvn.ru>
In-Reply-To: <20230915-pm8916-bms-lbc-v3-0-f30881e951a0@trvn.ru>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>, Rob Herring <robh@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2924; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=Gl5DvmVj086xnyzDaqlZ88oRMAhoEK8Os/bTYN02ZMI=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlA+U7tGo/Utzh6z/qN1R/oNKh0bnlFd4/O5ele
 zb6mZY4m4qJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZQPlOwAKCRBDHOzuKBm/
 dUyzD/9LWazefx635QmVxNQPwp7s/tG+BSHoNbrm8rR538owfXzkFj8WVpRz8COset9KWtvmX68
 bPcgNTbe9KoDXijWR3bYdU3wl1g8RI+1fN3ukypkAZLgtG0ooE85s2CSDwi6SeEJ9b/1fybW3Lo
 ggB9rbGkgH6ixTNuJgoBkgQFtS+hyIfFjEGDyvKJ6eXDAPFtMbJIYaoTh7iDFy4MWXmhxu3oger
 /1GkaQrJgbNx6AJkW5qHOUXT7fUa69WZ0m90W5ghJsH6M5utmQZ1ANbsdW5mOy06Zr582h4P1Hy
 1PzWzmwM9zb2y+ZfhGwVcpZNrKu0FKR2U9UiZSnlYu/bnjcbhxpmKT0rUVADLTN2Vci/Pmj7JM1
 e2esONMHuavgB8n5WuUjw0sxO9fIe8zQSYK9vEsEdvUkcHj/5JUx2XuyVRRpih6WoyQTGJ1b9RT
 WCcrdxq6xijEmRk/CmsOgaCvC64WLfBZexyrjOHfNwpT3Qc3prbQrvpaQ6III46ur8vJjCuqo99
 3tpcAQFswDcLX5OV6UMvuPEso+rS0Sy6fmsbE1AWAWCBKBhUbf+guktNQG65hSNuT1b9w4o2/ym
 uKrwgBpb28KBcPq0DEdjx/HFxew8jvjQZkmrptxNCKh+2xj/6wkGJVkldWZPm7h1r/vhhXwZXq/
 ZsA0eIqQ5z4nVWQ==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm Voltage Mode BMS is a battery monitoring block in PM8916 PMIC.
Document it's DT binding.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
Reviewed-by: Rob Herring <robh@kernel.org>
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

