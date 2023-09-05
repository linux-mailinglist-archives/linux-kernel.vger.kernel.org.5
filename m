Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA884792A67
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbjIEQgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354315AbjIEKle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:41:34 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AB219B;
        Tue,  5 Sep 2023 03:41:29 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id C7B8B40901;
        Tue,  5 Sep 2023 15:41:24 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1693910485; bh=5X6bS83dR5lb+qK0sMD+3oG1cICPkLl1zwdMx6oXekY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=QWCSGcKum8S1MQh/1yjncjlJMRDvr5yCtUESE5uP6hr32+dhow5Qh0KOUG2uZ93tM
         77vHFsn62BbnLYzX4Y1G9Wkvzd/n8syp6f2k7RNlU9uxSxSmx77VlYuBMe8sswK6v8
         miCHLMEWQ4yyDuhUi4PXPWLVXqoDsGxz30Bl+aqPEv3bYBxQLOc2VzzEM9Nli1yCUD
         ay6j7DGeXru2x/quCeKv06GTJ6Jveeb+Xm63B5S8e71fMuFS21psLIwGWIrB5Lc/zQ
         KqEwpKJSxKI5+j5/vWLACj23A6a8FTLXoDTpckEjfOGgF/YCVVNJrdhpsg2PnwCbrv
         G+U5tosQdCzSA==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Tue, 05 Sep 2023 15:41:04 +0500
Subject: [PATCH v2 1/4] dt-bindings: remoteproc: qcom: sc7180-pas: Add ADSP
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230905-sc7180-adsp-rproc-v2-1-8ab7f299600a@trvn.ru>
References: <20230905-sc7180-adsp-rproc-v2-0-8ab7f299600a@trvn.ru>
In-Reply-To: <20230905-sc7180-adsp-rproc-v2-0-8ab7f299600a@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     David Wronek <davidwronek@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3218; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=5X6bS83dR5lb+qK0sMD+3oG1cICPkLl1zwdMx6oXekY=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBk9wXS9a4u1GPmPNECBLFyPNyHqh0AKohOSUsl2
 zXxfcghlJiJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZPcF0gAKCRBDHOzuKBm/
 da8BD/wJEL+X116C8CeY1MXML5i47+rfkWYLhk/GHMTpv6zXdITpB0YWX/7tiZH1BW15tnBQhjB
 6hezr5uvN9Ez5P3B0dJZ4nbXpRK/78aL45YVFAME8VQ4t/V34IqnQRGz7UqzjrQBc1YQFmIeCGy
 +vZPOHwKkK99DVKhvcjYnLjOu8sKPRZEJbPvIotRi3L686GhQAT+cOfKsYA6W7Ls0T5n6YYkPjG
 ndFkT2rT9JPVJTuY0zGWBCeOO1PNO2hovdaAEu60GUGmNZS4CEe7PMmtpLNbjCXm4l1bdRwEm6Z
 1vFytGhsH7SHF4zrj5MDmHK6JQucoAcjVsF9WAtdhd3ie3wwuyoL/hta5AFuMoDED86kEA2e6hG
 Z9t25ACZTPACvtpWHF2EkKcP5YzvhuT4wkYF0JXbm9yKRKKHSQcVnlzz1I6ojFh/n+n4dpTQfgv
 Dl9Zqnfx4IZHsxj/iDv6G7IBJqTpIutbR3Y3+8F0E9sSnl188aEUxUe4FiTVPBsZLZ/SbfPRWCC
 vmkC0LCeU84D5IdCB3mG4Pl+nsEuaMTYaCSHi3JgpO2jod7T/gDLe4a9qtA71NLqLRRDR/HnYbe
 SB4pVWTjjbdNxPEH2d4c6acULENypzdOOBLPD7tOhdpNRWSvDOQ1SnQVhcnJSYU8fmc9ecRy6Ht
 aMMYX+XqSCfflug==
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

SC7180 has an ADSP remoteproc. Add it's compatible to the bindings and
refactor the schema conditionals to fit the ADSP.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
v2: Refactor similar to qcom,sm8150-pas.yaml
---
 .../bindings/remoteproc/qcom,sc7180-pas.yaml       | 81 +++++++++++++++-------
 1 file changed, 56 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
index 689d5d535331..f10f329677d8 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,sc7180-adsp-pas
       - qcom,sc7180-mpss-pas
       - qcom,sc7280-mpss-pas
 
@@ -30,26 +31,6 @@ properties:
     items:
       - const: xo
 
-  interrupts:
-    minItems: 6
-
-  interrupt-names:
-    minItems: 6
-
-  power-domains:
-    minItems: 2
-    items:
-      - description: CX power domain
-      - description: MX power domain
-      - description: MSS power domain
-
-  power-domain-names:
-    minItems: 2
-    items:
-      - const: cx
-      - const: mx
-      - const: mss
-
   memory-region:
     maxItems: 1
     description: Reference to the reserved-memory for the Hexagon core
@@ -71,6 +52,40 @@ required:
 
 allOf:
   - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sc7180-adsp-pas
+    then:
+      properties:
+        interrupts:
+          maxItems: 5
+        interrupt-names:
+          maxItems: 5
+    else:
+      properties:
+        interrupts:
+          minItems: 6
+        interrupt-names:
+          minItems: 6
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sc7180-adsp-pas
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: LCX power domain
+            - description: LMX power domain
+        power-domain-names:
+          items:
+            - const: lcx
+            - const: lmx
+
   - if:
       properties:
         compatible:
@@ -79,15 +94,31 @@ allOf:
     then:
       properties:
         power-domains:
-          minItems: 3
+          items:
+            - description: CX power domain
+            - description: MX power domain
+            - description: MSS power domain
         power-domain-names:
-          minItems: 3
-    else:
+          items:
+            - const: cx
+            - const: mx
+            - const: mss
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sc7280-mpss-pas
+    then:
       properties:
         power-domains:
-          maxItems: 2
+          items:
+            - description: CX power domain
+            - description: MX power domain
         power-domain-names:
-          maxItems: 2
+          items:
+            - const: cx
+            - const: mx
 
 unevaluatedProperties: false
 

-- 
2.41.0

