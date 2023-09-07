Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BD1797AC8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237749AbjIGRsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245662AbjIGRsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:48:00 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CBE1FCD;
        Thu,  7 Sep 2023 10:47:40 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id D924541787;
        Thu,  7 Sep 2023 15:03:05 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1694080986; bh=pm8ZM7bBeQBKsa4OPWQEylcBIFC5Xf4nYLFzqlL388I=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=s0gM2fxjGfV+St9BdOloZLMaExEG3oFKdIQPxV3SDoIF/xO2VkKGVz7xXeABJA95Q
         eQkgyYYAoKrtI7DS828LCItiiz/Mmj8wlMZnwQe7i+geaEoTHpcsV2Z3bgtot2u7Jy
         bkxBTZjYn5/0JysIV1s23iS7TPVZZvQ3F96piotFPgEUFQyEQXlR9bKEprZg2aYAD/
         6pDyScLpfWt4xkrK0/VyaRWg+ZLEIw0Fa03LzGKta4YfMGgsWt2jnJOqtJJ1zRMn1U
         SZYe9iAS/bVOzMBYatPPdJhbXtDMGotXzagY9Y5CGoQPWWp3ue0fhUh0OKL2E+7J0y
         jD784KC7lmqEw==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Thu, 07 Sep 2023 15:02:34 +0500
Subject: [PATCH v3 1/4] dt-bindings: remoteproc: qcom: sc7180-pas: Add ADSP
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230907-sc7180-adsp-rproc-v3-1-6515c3fbe0a3@trvn.ru>
References: <20230907-sc7180-adsp-rproc-v3-0-6515c3fbe0a3@trvn.ru>
In-Reply-To: <20230907-sc7180-adsp-rproc-v3-0-6515c3fbe0a3@trvn.ru>
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
        Nikita Travkin <nikita@trvn.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3285; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=pm8ZM7bBeQBKsa4OPWQEylcBIFC5Xf4nYLFzqlL388I=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBk+Z/XJ/vTxCamBOQhP7BjTybQrgkfYGsTLkJ7D
 mpFwKj0olmJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZPmf1wAKCRBDHOzuKBm/
 dQnID/9Ah/OuJD2tpbhNR6p0WjG2sRU9vxP7wYChZDk6ASgsLgUfl7W21G3nGa3R/aIg76tz/49
 1MUNTeI/MBvj56B1npedqFiKNvzPBBseMc2u9Hcgn0N8mD5zVhf9tgybKmqBQygKHyC+384x3JA
 FTQJ9cDonOjqL8fUpK01Cl1c9nskRvavBwb5AuVUWwzPL/IoIDY3ekNsv0AiJchpsHPIMO973ZZ
 qKGNLnUP3khjyh3AYi8254uQs5SH5ea3hiriraxQUqnPnPSS5vuClH1Oz40SJnU5vDJd8+nlScS
 Xw3v+3VJqMW576TCf5t0ASy2e/Mr+sgzZXNBN/jG8FZEAsR5uZ86I3r182IUw/f5rwI6nhHAbc2
 kpIscD7YXb9BjfxURulmGauBw9KUoctpcoDrcgauaLdd/d8G/1w8ZSBnPv5hF6tMznWRFR54ykm
 5DXSVyrP4ibNyrHbt6ALodDwXTfUjsH2mAjdcnbR1tJ2OORJS9gbWWXUTzg/R36PV1NibNlupFf
 U38BJDjI3BUXeURP0zmTTDHas893POMv+za/kf7Wu2iyb6yLG2H9fRf0dyz82Kf4ARDUK9EXFhe
 Xfd743tL3ZueWfFYL6mg2M+q7mp6FSUW+nkqGSb4Sv9Xp6s/rIKqxktIZSRo6CtKHzqoyW1X/da
 Qy4G534+Rsu6Zag==
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

