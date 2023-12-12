Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809B680E68D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345971AbjLLIp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjLLIpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:45:20 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA05DB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:45:26 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54f49c10c37so8082003a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702370725; x=1702975525; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71CxKbWqIB1thWUHFZAzLfbTO4lgIALsc6uKYJhAAGc=;
        b=oQ31o2grkrzLwaLEZCRueIPwzQLh/wsL9+DrTuhuT/DgPDQgFl/xySvxrRl5XpbMrm
         YTZPOgig8UxJdgJEzZg4/rSF3Oh5IdJqSbT4KVNgU1NvatPhfqUAK7m4XCMyo4IyBIcW
         zOn+GmmIEXEKKczAe/iZrS8iSXss17sgBuli5GDzLTpEAJWVrhT4b1lxvxYiDTxJnHib
         mt1khBLFM0PHDv3CKOBiPlB/2/gNSgC7t+T2pQl8z34FRGmzGW9Jd+EYXIS3OjbTUHc7
         Ja8hvq3uvRDGIUU2/kpFP076ow0QwVXgvkTYy6MKFYTexnUAWrSWvoANTbmDxKqOqQrQ
         MuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702370725; x=1702975525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71CxKbWqIB1thWUHFZAzLfbTO4lgIALsc6uKYJhAAGc=;
        b=UCko3OJCltIpUa0Sdd7VsutSaPwM9fXGfK677NjtJgy3AQ9XsG8p16gkL2baAThlIV
         Ej68gqyWF3vUAPIfLC29wxbF5WDJo2lZssmsPO/chkVhVcbDJSm1GbT/IvLjh4+PKJlo
         jgAHoW070mFFLHRgQ4czmIr01u4d/Y1rADmdY6KX7jwGUT9r2uT0F9mw/OitWxRNH2jH
         8YKWExzyFEjVk7kfq2P+13RNneJZNaq9dTuVy4cScO4CUb0jcDuMkWY1v6NsJGTduoUf
         ER3EgFFqZYiEx8YrWXCImnEjIX6+vc5k105mdYaNqPDqiiISdNnT5RTHA4GLFdANpMCx
         b9IQ==
X-Gm-Message-State: AOJu0YwJeQnPtoCbdriZlOZIoDqawYBRGnxMQwQuimOsL0V2ox5wf05u
        TImYYSIpO1nVLGw5ihj3LnsiYw==
X-Google-Smtp-Source: AGHT+IEVhDvy1NYpksRyR/PMOo2dCFviVXzwGF8RwSoLXdfM+ECitOnjkPCEg96NVSzZ+4E0mzCaTQ==
X-Received: by 2002:a50:999b:0:b0:54c:48aa:cd0c with SMTP id m27-20020a50999b000000b0054c48aacd0cmr6316368edb.28.1702370724846;
        Tue, 12 Dec 2023 00:45:24 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id c27-20020a50d65b000000b0054c9bbd07e7sm4650471edj.54.2023.12.12.00.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 00:45:24 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 12 Dec 2023 09:45:17 +0100
Subject: [PATCH v5 1/3] dt-bindings: remoteproc: qcom,sm8550-pas: document
 the SM8650 PAS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-topic-sm8650-upstream-remoteproc-v5-1-e749a1a48268@linaro.org>
References: <20231212-topic-sm8650-upstream-remoteproc-v5-0-e749a1a48268@linaro.org>
In-Reply-To: <20231212-topic-sm8650-upstream-remoteproc-v5-0-e749a1a48268@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3084;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=gsIvwnD1pTzAEzxjRT3QO/jWU2a/vS/+hNR3Zbvsze0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBleB2hIsjZTYb7xa+HaZsQPZzAlmIuUHvgC21KHpeC
 HTyTEKWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZXgdoQAKCRB33NvayMhJ0V7gD/
 9QfMxySgrL15s7J2Rc5QeDhOC2S9uTT9f8Q2bv/Z5X9/OLJRtKnn64yhhXS/DDSOYRM6Wz3DnESbi0
 VdcFTVK7H+h7KPYUYkLoIi9IdJq30sHuVZmtOD03mKt/qDRa50BcjbQsZ9f9GUOa+w2s7PReLFtI5g
 lvb5T4p4DI78KPPY4Sqchai2KFNSNVKLeOOZxXCnPLVKP12RbjXiZpgJkL0SpVgQvIWkI/d5AOTRjL
 WZ+gcqPKYssojeJHsx1c+lSGNkHiR5m8+B+hL9qquQWMCkUqKw6sIMyAf9BvmnXWgjnJTQjKPO2Whb
 pZT1fg80LspmbJMWD3fcE9jY2eYkVqRnn/1GzkVr09pUscpT1cD0hUD1wEzwxyoyfBCwhWizT2ej0Z
 wCbHKmmCvnaVSEEPVRBRhSWZtLNn0Pb2fgOtGehoAIwhQnxUe1a20XoLHTUwrBaZyu08fKC1ybtQfP
 NeoF7KdOhh92o8lXtQka7OCSPEAgYeAVk1mfdr9hVfmMtrvGAWa540sBid5NTy59lxwa7KW1FWyuZu
 Z6eTGLLvXdWQqfZkAiyIYgXT2UPyWLBKU8C5DVrQxtoNIf8C2jtAe2y5bW4vkW/dg0p6/YYQUd8DbV
 hVop28b21MHPnQhk16euAqaVcxOjv74T74riNGBlcbwbMVQVp6q7dkJfqz+Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the DSP Peripheral Authentication Service on the SM8650 Platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/remoteproc/qcom,sm8550-pas.yaml       | 44 +++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
index 58120829fb06..4e8ce9e7e9fa 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
@@ -19,6 +19,9 @@ properties:
       - qcom,sm8550-adsp-pas
       - qcom,sm8550-cdsp-pas
       - qcom,sm8550-mpss-pas
+      - qcom,sm8650-adsp-pas
+      - qcom,sm8650-cdsp-pas
+      - qcom,sm8650-mpss-pas
 
   reg:
     maxItems: 1
@@ -49,6 +52,7 @@ properties:
       - description: Memory region for main Firmware authentication
       - description: Memory region for Devicetree Firmware authentication
       - description: DSM Memory region
+      - description: DSM Memory region 2
 
 required:
   - compatible
@@ -63,6 +67,7 @@ allOf:
           enum:
             - qcom,sm8550-adsp-pas
             - qcom,sm8550-cdsp-pas
+            - qcom,sm8650-adsp-pas
     then:
       properties:
         interrupts:
@@ -71,7 +76,26 @@ allOf:
           maxItems: 5
         memory-region:
           maxItems: 2
-    else:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm8650-cdsp-pas
+    then:
+      properties:
+        interrupts:
+          maxItems: 5
+        interrupt-names:
+          maxItems: 5
+        memory-region:
+          minItems: 3
+          maxItems: 3
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm8550-mpss-pas
+    then:
       properties:
         interrupts:
           minItems: 6
@@ -79,12 +103,28 @@ allOf:
           minItems: 6
         memory-region:
           minItems: 3
+          maxItems: 3
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm8650-mpss-pas
+    then:
+      properties:
+        interrupts:
+          minItems: 6
+        interrupt-names:
+          minItems: 6
+        memory-region:
+          minItems: 4
+          maxItems: 4
 
   - if:
       properties:
         compatible:
           enum:
             - qcom,sm8550-adsp-pas
+            - qcom,sm8650-adsp-pas
     then:
       properties:
         power-domains:
@@ -101,6 +141,7 @@ allOf:
         compatible:
           enum:
             - qcom,sm8550-mpss-pas
+            - qcom,sm8650-mpss-pas
     then:
       properties:
         power-domains:
@@ -116,6 +157,7 @@ allOf:
         compatible:
           enum:
             - qcom,sm8550-cdsp-pas
+            - qcom,sm8650-cdsp-pas
     then:
       properties:
         power-domains:

-- 
2.34.1

