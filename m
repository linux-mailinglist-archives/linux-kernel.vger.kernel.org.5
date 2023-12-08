Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217B780A679
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574103AbjLHPEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574051AbjLHPEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:04:38 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E375F1996
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:04:43 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c19f5f822so12575665e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702047882; x=1702652682; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71CxKbWqIB1thWUHFZAzLfbTO4lgIALsc6uKYJhAAGc=;
        b=shhcAVCEl76UvbS8vrxQrCqlKXUvX9HbGRNEpIEJ4Ir/VfNXyXdR5/sZ6QTOBdiEGV
         xQdW7YOC9GJNtN8I32g4wmiNOn5pmFpN/2hRz+1B8ZTg7/mxLUPboihXhWPZHXVAsoL2
         typBHuEm6tmIEDv8K2/pK6UqFmipUfKOlSFjEajSJR92cVafVz38l5S9slbkWfADFLkk
         hTmlZVlpvhMBHWGiN6F7+GWlGIKzojsZqvA5GP9580Erdf/c+WZS/9tXXjBbv8ZyMuM3
         M2ZBbgOLqh/c3kvws69eUzW5drlvSzTtQbUNW215dn2H6Kr143ra6DRCjgH0heJFCUrq
         hXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702047882; x=1702652682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71CxKbWqIB1thWUHFZAzLfbTO4lgIALsc6uKYJhAAGc=;
        b=XClsAYrrf4DotF9Oq3n0t1RhSfj0Bv1QxQc8WeW1iXst9Y6gCiGC+KUzsZ46x2xSWI
         LKRUUgCHtXL8gsx7aEYIav0LHamTREdnY2YnD1oTf2xZik2IKp0/edZENfV21u8p4Q+R
         /U5LJ5Si1a+AfbQci4+shdRwedF7mBbFtCHcQnUVqAOHhKUuKMvVwCtcUiIGCeJPgRYk
         vpW8uSefx9LeO2bd61xq9CSh4ywNdX0ajFQUFEdbumRtk5+wwTMox71uK92hbVP1sVwv
         Pqq+g64Md0t8OfsZFTOFwPz5e0zOufaS/cZxxGQWyYNPKXWdZ6yYcrnJ/xiqML2ZYz2t
         FYUw==
X-Gm-Message-State: AOJu0YzzRRyHDnQS9zEK5Yio/HHYLWH1cJmHo1jCLFgYhQAwG/XwIKAU
        /cmsvWENgZoYIIjKK9Av3PHrvA==
X-Google-Smtp-Source: AGHT+IH1daTgQjHpJQimj0+aXAZhe+a6pkiEbbNbSG7KVUdT6oXN7ibghEwHNjYrCwM2w7PceyFXWQ==
X-Received: by 2002:a05:600c:2489:b0:40b:5e56:7b70 with SMTP id 9-20020a05600c248900b0040b5e567b70mr147004wms.185.1702047882295;
        Fri, 08 Dec 2023 07:04:42 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id v12-20020a05600c470c00b0040b37f107c4sm2000403wmo.16.2023.12.08.07.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:04:40 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 08 Dec 2023 16:04:33 +0100
Subject: [PATCH v4 1/3] dt-bindings: remoteproc: qcom,sm8550-pas: document
 the SM8650 PAS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231208-topic-sm8650-upstream-remoteproc-v4-1-a96c3e5f0913@linaro.org>
References: <20231208-topic-sm8650-upstream-remoteproc-v4-0-a96c3e5f0913@linaro.org>
In-Reply-To: <20231208-topic-sm8650-upstream-remoteproc-v4-0-a96c3e5f0913@linaro.org>
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
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3084;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=gsIvwnD1pTzAEzxjRT3QO/jWU2a/vS/+hNR3Zbvsze0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlczCDONJoFqaR7iNWI12OHcYaTEI9wCiFw7heVmgk
 kSDmQdOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZXMwgwAKCRB33NvayMhJ0V09D/
 9/x3J8FIkKuNQi3JAgnVlRwNEG9qgR9gcW7y5JVNe6TgTR0BqDlfYG1/6oB8fqFEvW0OR/2Nzx+rws
 DMcFdll3RsRbqvd8++CK0JS6aotME0kbCEaoEsbj0rzFlmm3MtmDHHP75aQoR21OM0+InU8N6lfrfG
 DvQ91X9fOGq/P/khpac0S9j3BUCATaC8UGWAADsl6iiiU6ibyHZzK/ObAWwCpYFD/0D6FSjGWf3jQq
 n8cCzxb3Z5bITChsgwM4xU0vsdRwxjBgjlUAAHY28RFfewdv+rqLkMWbiDvBVMLgs2+F0S0RTN8qgi
 43rHIoFSvZv6lhjrykVP2wrlSpmc5TlkTx1P6gtfcWzYQ+rYdKHhnLwYDDgR/5YmxCexVJAo03ovQt
 NyK8vANVdlkm04KiLaT3DDRlaNpjed0RkHfl4UTIfn/brthOblTUEAOfz2NICxRzRN0fCUJmn75Dkz
 xv9F8+yaYAaSBfjIOOkznVIZJmN4YhoeOZx9hpXcqXx6lapa4b7zF0xlCSFiWnVPpo3jS1Bg3UyE+6
 p7BH/gEUBXAvKEuA1NWQHWLfHdwW4cEKw5faEJ+oy1D/miI0KmIvVr4fqaWOlyiNdrZ427VaiZ+VvS
 jqWEXsIZ3m9bnZYZcAqo+7ksu+o+xMhJNTMt4TYquXOvbLJmxG38+Dzm5C5A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

