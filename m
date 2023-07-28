Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9A8767361
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjG1R3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjG1R3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:29:31 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F3C35BF;
        Fri, 28 Jul 2023 10:29:29 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 9431A423EE;
        Fri, 28 Jul 2023 22:20:26 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1690564826; bh=s4ixMcdZJsN0/3Reb+BBUuoWu+guNJbfDt3OOtbMHBM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=uvxAYqYyEKfq4MGSr8DGFiP8Xdvw5m20nct6RePfOaXJIrzOsYQ5FofF6TADXRBLD
         s5K/q0qDtozf6SxJ61CeijzB45xPi1r+I54LSQN3AipDTIv6j04EE5YBhD4jqwWPOm
         Dep6X+nxIwjF0PcZ2ikrJBBvqzudFEyJ+dpwpxnUuvcKMJMIIGaYYGighGnsT1G713
         a2kduGuYkuRGsprDYP48/H3LaeN6sK3JX0ju5VwMB3Rsj7w4z/4tJUqJ+v/osmBE9l
         7MpoI8ANkdJm5bDjP3v7uNDIZKZ7eP34GOjvwKh9ygHTe0QqTpEVMHQEUYAdODi5oU
         pTSNrICUaljNQ==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Fri, 28 Jul 2023 22:19:31 +0500
Subject: [PATCH 2/4] dt-bindings: power: supply: Add pm8916 LBC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230728-pm8916-bms-lbc-v1-2-56da32467487@trvn.ru>
References: <20230728-pm8916-bms-lbc-v1-0-56da32467487@trvn.ru>
In-Reply-To: <20230728-pm8916-bms-lbc-v1-0-56da32467487@trvn.ru>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2962; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=s4ixMcdZJsN0/3Reb+BBUuoWu+guNJbfDt3OOtbMHBM=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBkw/jQ7P3tIhWXpdsvQk1Zy9Bh5v2KLmRccz6u6
 au35+aMde6JAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZMP40AAKCRBDHOzuKBm/
 dZbQD/4jWSHCwfnAzhRr2WSfVinIjYjJYchxM02soLIcJ96riDT9MMKMbgey0126+IHmVCpUBZ1
 qBWJfXRU2fg9Ows6e5FM6RCNE7O+0Kvof65t6g3Dqz5AckrG/h/3pvHRsd9oSlhl3cZZ2+Q/H1h
 N52VoF/JMP9gPzlTksozrCLWG39GgK8QoOHibc6CxNNu5TSi4RiEMVerueJvs9UvIWsxR1DEiET
 VnidsdVRuoHO7r+6OFKc5XYt/yqC9z8rQRnkg2QaiZCiHuxGVgRnxSlKmrSoh31Z3zFAD8hbV3b
 qK095mTyZoMza3HcNIg7178YQf+wDXfhOu9IRQzD7Euf3q89ZuASEcP3GcB4umb+xyWCb67FRlm
 qVf0peiJ9uPCEFm8WXKJLvqaPBf/dXtOivAbCYqRMJH0H60/X6cR3UL9X38e7ARULf1olGGSbwh
 9q8nBCo8Sud/2epeQzRW0+40qfX2G1jM6LpZ4MeTzlaTfB3X6m7hkYUuep8w9If0P/RnCGYTQlF
 yLyoXP7LIuj3vlB9OcVNAgq2CZwxH+fCM3inQhOmmp4JmMIHhfWMsVAffI762iksT32dnEpwRhb
 oY7oCF/8drrqbytKFyXjIGj8+5D8GtxOrCTdbIu5w423AoXhoJ295si9lZSQjB47LsWoUCpBgC+
 HW4/4VW13TqZ5OQ==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm Linear Battery Charger is a CC/CV charger block in PM8916 PMIC.
Document it's DT binding.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 .../bindings/power/supply/qcom,pm8916-lbc.yaml     | 93 ++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pm8916-lbc.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pm8916-lbc.yaml
new file mode 100644
index 000000000000..baf232b61e02
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pm8916-lbc.yaml
@@ -0,0 +1,93 @@
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
+      - description: USB IN valid
+
+  interrupt-names:
+    items:
+      - const: usb_vbus
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
+        interrupts = <0x0 0x13 1 IRQ_TYPE_EDGE_BOTH>;
+        interrupt-names = "usb_vbus";
+
+        monitored-battery = <&battery>;
+
+        qcom,fast-charge-safe-current = <900000>;
+        qcom,fast-charge-safe-voltage = <4300000>;
+      };
+    };

-- 
2.41.0

