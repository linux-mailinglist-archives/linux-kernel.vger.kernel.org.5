Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487EC76735C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjG1R3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjG1R3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:29:31 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9162D64;
        Fri, 28 Jul 2023 10:29:29 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id DDB78423EC;
        Fri, 28 Jul 2023 22:20:25 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1690564826; bh=BTHA7BOdnoILhyKJmbmntYs8hUmm5xyCV/Oj9i4ZnIU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=5FIPblknc31XzZdfMdV3Va13opX+qyIlbQq0hbjbrBsAQmGOHOFQ9XUEUqq8eXVWC
         Tmj4hERjnG/0K4rQwqXkFOolRCxMRS5VQAgURYNFo0hZQmnzfQzqUbW8uXgVnf/MlP
         M/zfSG5qIQsocXRlidm+ZpEzsMD5ptYsUK/wgjPb4CNZB77IYjvGPbqkGEf4Xp9IvM
         xMDaGjDSJ7RptiomelZzvOarjFcbCvv5LD9Nn2Ei2UZKK9AFKQhtYs/4mMPY6YBu2H
         qHcEpyNcXJnKQBy/K+IQKE+Y5UGpbEYhws/QbPa/ltXxsWctRpOsTvFDoWmj/xxBBj
         iNP25yosR28Pg==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Fri, 28 Jul 2023 22:19:30 +0500
Subject: [PATCH 1/4] dt-bindings: power: supply: Add pm8916 VM-BMS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230728-pm8916-bms-lbc-v1-1-56da32467487@trvn.ru>
References: <20230728-pm8916-bms-lbc-v1-0-56da32467487@trvn.ru>
In-Reply-To: <20230728-pm8916-bms-lbc-v1-0-56da32467487@trvn.ru>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1993; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=BTHA7BOdnoILhyKJmbmntYs8hUmm5xyCV/Oj9i4ZnIU=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBkw/jPMOUsqaC4ObMgf6S0TqkPHcUNiFvR8xQav
 AGDHO8BFviJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZMP4zwAKCRBDHOzuKBm/
 dZg5D/4xlV1nucyc5nXkoL3EYNs4yha/xnMJWNd9KhG0CRPivb9r9JZthm8HmHOvIJXUc8FkkjI
 psMB9qA2DZqNB4WRN5ASjYRN5DAOrD1q7pMyv68GDV6/uYczFs5hsEiiNHKNyMadftRs9KVSNlF
 NzWRrWMtTf1u8ileHNrK06prL2f4mstfRWg373VlxpsIPALNUEZ0Rsu7MQxHfWmfhvq1i90Suza
 SIPRl29cUi7fgw6aeXmb+JG27SDd/PfRa5A3L7dKenhqK8c8/qqdDyMhG/clsTg6E1d2b/iHoFU
 Uclr5jf9tMu+7K/h0j0ib9eEu8JL1yJ15i4fojch81GuCWO85ivtN6YaMyp46gyB5ORbUFhWTa9
 NZI1nOzPfC3fpCWbIDKVWLWHSfJkYN5XhYtbJLE9a22ptMykvvXoc0Sm3TmMewFCGMNYC5KkgTH
 pZ3PhIvle9aOIBMO8Sk1jDpaKbydykv1WPUSf8UbdYLKetj6hfLXEkVXRpr+wZ7xiYJOeU8TOLp
 DJZyD5WhS3NFZbqtz+2KZf/T3omD0Zt+vYU6zRi/wMB8xqLNO/X2riM9UyO1aJncIYJtxqQB89s
 tM1n0lIdQTOsMvH3Rn+3RYlXgy3XIoLUCcLBUE1wh8aL2iRGp2z5u9hitzmYwVsxNfV71UKhW0W
 dIbvZG+5HkigkFA==
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

Qualcomm Voltage Mode BMS is a battery monitoring block in PM8916 PMIC.
Document it's DT binding.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 .../bindings/power/supply/qcom,pm8916-bms-vm.yaml  | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pm8916-bms-vm.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pm8916-bms-vm.yaml
new file mode 100644
index 000000000000..455973d46862
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pm8916-bms-vm.yaml
@@ -0,0 +1,64 @@
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
+      - description: FIFO update done
+
+  interrupt-names:
+    items:
+      - const: fifo
+
+  monitored-battery: true
+
+  power-supplies: true
+
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
+        interrupts = <0x0 0x40 4 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "fifo";
+
+        monitored-battery = <&battery>;
+        power-supplies = <&pm8916_charger>;
+      };
+    };

-- 
2.41.0

