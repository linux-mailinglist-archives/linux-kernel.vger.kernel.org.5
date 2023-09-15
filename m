Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3BE7A150B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 07:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjIOFCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 01:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjIOFCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 01:02:01 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD7C2710;
        Thu, 14 Sep 2023 22:01:54 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 6F70F424AE;
        Fri, 15 Sep 2023 10:01:50 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1694754110; bh=rGP+tXUnWOMGHdQJ8R0srdv2Kny66mnF5MC7ifV715k=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=lXRm7QUV1IYXq/QeuTPCugFytuP2FrCDCNtJ73bE2ayi/Gh7Q0pHZGmLjvcvuVTQD
         hBi2u3FTzNq5ZcLnvcFZCOzx9QbHPWDQNi16/CBWi9x+CwddhlkbaMX0odDAJE3TfS
         2RNYQmWc2WYkse6hbQd7gX6eWI2YbPeI2VZrWpmIyachwjf1L62YFslUJDbuN78itk
         KSPBmVJxuSzQp5sDZyFrV9GivFbP1L/g2ayUJ20iMSZXsn8RruAMLQf0s6vOqnb3dB
         uVlCFpdD9eKKebNgH8uDnFpv6ZKQTRc0wMXpQBrFbW6YR0nPAxhhaBADpccQ1jzN5t
         vYNcaAMUp4Rsg==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Fri, 15 Sep 2023 10:01:19 +0500
Subject: [PATCH v3 2/4] dt-bindings: power: supply: Add pm8916 LBC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230915-pm8916-bms-lbc-v3-2-f30881e951a0@trvn.ru>
References: <20230915-pm8916-bms-lbc-v3-0-f30881e951a0@trvn.ru>
In-Reply-To: <20230915-pm8916-bms-lbc-v3-0-f30881e951a0@trvn.ru>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>, Rob Herring <robh@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4501; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=rGP+tXUnWOMGHdQJ8R0srdv2Kny66mnF5MC7ifV715k=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlA+U78/A2JnnlDCpflyrOzd5BNNlzgR8hOvd4w
 CkCp1IC6BaJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZQPlOwAKCRBDHOzuKBm/
 dYGOD/9yiqmvm1IdeYt3zmmsn4Bos6U3t5HGejjkolM32oggULuD+g1Hum8m+vC++bdvPit5bhA
 lM1qH8FzdfDa8AXIe7LNqhKdb3Y+Kh/6d3DSZuZ53yet8Tqcn1RKe78d4lIzkAGbWhXq1VdgjOw
 DthtOHSMu4dyo9IYnGYprD//6ttuwM3y6vSpiguC1mHbq0104TtgGWHgPF0THFwO94qrnMx1YxT
 snKVkn9GUEomrGsb4e+c35J6tdjNspPSmHatQvmWwitixWdVUSJC3bAi3CuuH7f5oufUwVYPRiv
 9s4KUgdtXo7igFKucSmCtevBF99tUmNJzQR8ZKPrb0reCJjQ8PpduO2ASQxSPIz6AOkJHK527fo
 aEjCfotm/LHUS/L3DgirzQyMtr2qolBuO66yUmvn/vbxhVABk/p5/BIIxrBYT27/AuSTaZhECmV
 zqugOlM12NvePEOVhZ92GjxV3TmDa7dIm/jNZ/dV+Qh7nm8dzp2wNPU4y0MnEQ9WO5LCitruity
 HkVTv6NhRQAQTeVC/JKott/YKn+BN+irW9tD0Js3NswsO0BUhPvFbuDyWzU0bQgkKcI5vMfrrhd
 Mwzdk9pj/4Xm2w8pPxE7yjBRzFLrV9LXy+QDkEso9kYumX5zds+GrPyhG74ARiV0CO1arCHHCxQ
 Xzw1nk+mnQC3eCw==
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

Qualcomm Linear Battery Charger is a CC/CV charger block in PM8916 PMIC.
Document it's DT binding.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v2: List all interrupts (Conor)
---
 .../bindings/power/supply/qcom,pm8916-lbc.yaml     | 128 +++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pm8916-lbc.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pm8916-lbc.yaml
new file mode 100644
index 000000000000..cdf14e5ed119
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pm8916-lbc.yaml
@@ -0,0 +1,128 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/qcom,pm8916-lbc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Linear Battery Charger
+
+maintainers:
+  - Nikita Travkin <nikita@trvn.ru>
+
+description:
+  Linear Battery Charger hardware block, found in some Qualcomm PMICs
+  such as pm8916. Implements a simple, autonomous CC/CV charger.
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: qcom,pm8916-lbc
+
+  reg:
+    items:
+      - description: Charger
+      - description: Battery
+      - description: USB
+      - description: MISC
+
+  reg-names:
+    items:
+      - const: chgr
+      - const: bat_if
+      - const: usb
+      - const: misc
+
+  interrupts:
+    items:
+      - description: Battery detection
+      - description: Fast charging
+      - description: Charging failed
+      - description: Charging done
+      - description: Battery present
+      - description: Battery temperature OK
+      - description: USB coarse detection
+      - description: USB IN valid
+      - description: Charger gone
+      - description: Overtemperature
+
+  interrupt-names:
+    items:
+      - const: vbat_det
+      - const: fast_chg
+      - const: chg_fail
+      - const: chg_done
+      - const: bat_pres
+      - const: temp_ok
+      - const: coarse_det
+      - const: usb_vbus
+      - const: chg_gone
+      - const: overtemp
+
+  qcom,fast-charge-safe-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 4000000
+    maximum: 4775000
+    description:
+      Maximum safe battery voltage in uV; May be pre-set by bootloader,
+      in which case, setting this will harmlessly fail.
+
+  qcom,fast-charge-safe-current:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 90000
+    maximum: 1440000
+    description:
+      Maximum safe battery charge current in uA; May be pre-set by
+      bootloader, in which case setting this will harmlessly fail.
+
+  monitored-battery: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - qcom,fast-charge-safe-voltage
+  - qcom,fast-charge-safe-current
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
+      charger@1000 {
+        compatible = "qcom,pm8916-lbc";
+        reg = <0x1000>, <0x1200>, <0x1300>, <0x1600>;
+        reg-names = "chgr", "bat_if", "usb", "misc";
+
+        interrupts = <0x0 0x10 0 IRQ_TYPE_EDGE_BOTH>,
+                     <0x0 0x10 5 IRQ_TYPE_EDGE_BOTH>,
+                     <0x0 0x10 6 IRQ_TYPE_EDGE_BOTH>,
+                     <0x0 0x10 7 IRQ_TYPE_EDGE_BOTH>,
+                     <0x0 0x12 0 IRQ_TYPE_EDGE_BOTH>,
+                     <0x0 0x12 1 IRQ_TYPE_EDGE_BOTH>,
+                     <0x0 0x13 0 IRQ_TYPE_EDGE_BOTH>,
+                     <0x0 0x13 1 IRQ_TYPE_EDGE_BOTH>,
+                     <0x0 0x13 2 IRQ_TYPE_EDGE_BOTH>,
+                     <0x0 0x13 4 IRQ_TYPE_EDGE_BOTH>;
+        interrupt-names = "vbat_det",
+                          "fast_chg",
+                          "chg_fail",
+                          "chg_done",
+                          "bat_pres",
+                          "temp_ok",
+                          "coarse_det",
+                          "usb_vbus",
+                          "chg_gone",
+                          "overtemp";
+        monitored-battery = <&battery>;
+
+        qcom,fast-charge-safe-current = <900000>;
+        qcom,fast-charge-safe-voltage = <4300000>;
+      };
+    };

-- 
2.41.0

