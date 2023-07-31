Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4133769F33
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbjGaRQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjGaRPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:15:33 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAF43C06;
        Mon, 31 Jul 2023 10:13:17 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id BB66742448;
        Mon, 31 Jul 2023 22:06:44 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1690823205; bh=HLdHaCzNIuTqc3Vf74S9Nlpt5i1D7838FDtfMaKxzCI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=PxiqGKe8XQyLiXt4t3zbAw2ROQgzDZXdx0Pvsvd3a8TNoVJtq0AJcYne8h4kSlE1K
         ye2H1rV+UmjebJtbWZF0BROdGGpB+8LnUXwRdX662gPZPf1KV+5OtJpDa5ypfnpsDo
         prFMmftTH5Ax1hQeeODAP4jlWX7h3cZqu3G7H/nXolL1Ifu9BIkQpbXkkEiQHL4wHF
         c3DzOAtExO+8L2o66kzybJmEYPuOBNPBVnOC6EtQ8iyypTMluwOkqFrr1+VWAnTcoI
         YKFU8TUkc755UrvkybA0GFPEWBs3+bhjhrdItChwINuT2YXeQWgqECLcYdl0/A/Vyn
         uQpeDnRNvS17w==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Mon, 31 Jul 2023 22:06:25 +0500
Subject: [PATCH v2 2/4] dt-bindings: power: supply: Add pm8916 LBC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-pm8916-bms-lbc-v2-2-82a4ebb39c16@trvn.ru>
References: <20230731-pm8916-bms-lbc-v2-0-82a4ebb39c16@trvn.ru>
In-Reply-To: <20230731-pm8916-bms-lbc-v2-0-82a4ebb39c16@trvn.ru>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4457; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=HLdHaCzNIuTqc3Vf74S9Nlpt5i1D7838FDtfMaKxzCI=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBkx+oiPNHbV3Ry0e5+TA2hM+W09MNJ4w/zpmF8m
 ITChVEKV4iJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZMfqIgAKCRBDHOzuKBm/
 dYXWD/9X0rvSde5YKjw7JouJWAQayzXhYs1gYGPo/qWBkHwAiC++dC7nEPMeN5YMRoeyWgpIhAF
 I0lndxy6V7vNmZHHyn6GxSUsUE6+LW6OcC+y94lUYPpG/h8HDc163JF/Pm2/GLmgXIJ0FsDNY2m
 hLn7PjpAmB1LDRNmWsZ/IgTVFpSs9ymZiU1CCRNq81UXVT781yYi0GOMo5UG36FjMJN1CJo/E7a
 eDzyIDZ9opmxO1k7y6bC9TpqBsJASSvlNhb7dY70FnWgTJkfnhNSDK4U8zkPjRGJ4uo37nIV5AF
 +X3HQhrnPhovnEXp+/1Kho4DxXRVfWxjubW1deidvqIvR9e8kwU4EUAaDN0iaICeIJ+ufjva0t7
 SlKDUfg0LTRqYoPf3szE/Rmfc6oJFtEE+y3XQcznDdV5WHps8qDlWitfzRCp7yzuEvXvFHFwax5
 KVQz6antCsDoEeIYNYTOOfUeq+q/wg0tGe1KAp6djM1Qem42UiD/9U7ZnZXOrqhlejg0WYes3Xu
 PY6T+4IgcJMO7K/ulKPX1oAth/s8r6pVYWixdhVDTdWglc9ECaV82S3vQszUZsGEOrTNUYkCB9G
 hkRgvV4gUaA4ZjhD3d+BEWlruID6GmlZ63gniBXdidBN420xu9zYTcF3DWlken4hfsmy0fmukrA
 gRyDexEkJSYCLWQ==
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

Qualcomm Linear Battery Charger is a CC/CV charger block in PM8916 PMIC.
Document it's DT binding.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
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

