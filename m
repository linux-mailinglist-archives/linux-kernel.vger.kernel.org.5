Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A507F7DB798
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjJ3KPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjJ3KOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:14:33 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF6F5B86
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:03:38 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40850b244beso33307025e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698660217; x=1699265017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBEjkFtEoDLXP4jW5j4UkikPWGjNO3wSnuP7dLnI0Wc=;
        b=JBy4utfi+lkuFj+ksC37VXlNa1hVpO5QBnXPCE6MD4+SSh6KkV4Kl7UiNXQUQm5xoo
         xeKkAiMegEru36HgY0jrakg54WV3x6RnCwsGvHXN7AotPiX9HEH5u+hrFMEvYuVbVpyM
         OnCbkLb9bg1Mb2kbX5jLXjex56zBieffQ0NBlpS3yyROxOAdOaghvdUMftd6rEYQma1K
         P5k4dzbi/z6yPyv8UHuHLXmHaCDCAg+fdnIBAj3ZJW9FDmRxIcWn/+38cEv5go0sMM6e
         gSJsz3nr7JjLcHVPizNtLkpAxNNv/pvcAt18kb2FHgMC3FcvkT1LS6GgyUVZ+jLwd/YL
         pCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698660217; x=1699265017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBEjkFtEoDLXP4jW5j4UkikPWGjNO3wSnuP7dLnI0Wc=;
        b=DmlCLe322xaolL2NsVs1DUenLBnekYns4rRyZyGSzN/y9rWW+UGL96VslXLo9N7Fhx
         MK38QhtZvJjmTgOFFgyq5BwcOlALf47AXDdRK2epjAFEwbnOfpJ8uOXj7c1B9hMDu9po
         SL1Xqnlj+FKtB3604+jP8eO3Idw4fvN4JQMNrDuCrnYRTFKeW62k/qRaA+ROZ67x1toD
         U8R4J7wgTRGrUr17A7bIp6aNIdsvP1MQH1Qb+mKrxXZb6sc//zrerxJfjd2/qJX4Z4sZ
         NU4Vd8lV6tEgC2BFzzL40dt2eWDzN9h+paFdUntaYKbFfyYaPAukb3eeOKdRHGNGnBEi
         oeXA==
X-Gm-Message-State: AOJu0YypchRqk3gKVKooonLVTTnyyuvKZwnG70pn4xiLtWdSk1J59OS8
        HhSceX8hVEQWQOY1bvNhDE3/EQ==
X-Google-Smtp-Source: AGHT+IHy64T+PoGYYQlUsuvXeeiAf0tknKiASshoaLlDzGF9PnlqZwUBFzxBXt/ytSsEzYhHCfpvCg==
X-Received: by 2002:a05:600c:5489:b0:402:f5c4:2e5a with SMTP id iv9-20020a05600c548900b00402f5c42e5amr8417691wmb.37.1698660216615;
        Mon, 30 Oct 2023 03:03:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b0040472ad9a3dsm8776700wmq.14.2023.10.30.03.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 03:03:36 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 30 Oct 2023 11:03:13 +0100
Subject: [PATCH v2 1/3] dt-bindings: remoteproc: qcom,sm8550-pas: document
 the SM8650 PAS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-topic-sm8650-upstream-remoteproc-v2-1-609ee572e0a2@linaro.org>
References: <20231030-topic-sm8650-upstream-remoteproc-v2-0-609ee572e0a2@linaro.org>
In-Reply-To: <20231030-topic-sm8650-upstream-remoteproc-v2-0-609ee572e0a2@linaro.org>
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
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3017;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=reEmefJKZGV+uJvNoYw60U/aLAM89Ky7sJqGT1KB8qg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlP391nsS+vxxMb7MKYMWPKKtkj7UT7Xjmy1yBa4X+
 fS1m4SmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZT9/dQAKCRB33NvayMhJ0QJLEA
 COC/azx2ass0U5ckn4Hi6Y475flR7DQHXwyAzdgCQOVyqqt+/3hnTJGCuDiDINzb7wYmN/a31yLK61
 xo3nA5NRYFWLYKrN/Nvb4hhEvb1i89NvArqFRclVOEZYogl2kVK93MwI09orGpmVcEdAW/phYUsKp6
 hKG6DW4B3Qu/8lWT7CRL3L+K+RFRv8VZe3SnmIAeK4S5RCmnwqKXeoTgm4luj9cHh+ArHhh0iWxE4K
 y6IYHRx+uAix+IXY9kU+JbyWXbahHNNb/5yFnUKQqdWkmcQ+0V7Xvq9AP3451Rs3mAEg1KcMHytigW
 8cp+naclHK4mqBQpVQ6mhY6jiFf3GRcv8f/iR1+B2PXZQzsADTuBjEU4NL8/T/4tWgzYrJh69rGd4L
 BcLyP5FcdnkxGzISo+YTZKUziVQHZvky9ejdjVA+SrMJVQPTS9MM5+VuMRtFvgcbeop4qr2ITck5L6
 UDv3zWKgVWGej13QYnSfEXZDFeJ7QVGzSP/TzUysbJXuQYBjiPMLj/QCxAcrvMMiKXYFxt2AE+fbVC
 y1yqv96YNXxG0Re+vfSlqUUyA/eEbXJg1roigRbBkaeF5mB8DChUMht3UfX8YDaDNE28Lcv+o8xkJT
 C1FeUGuN5oULxEIOt9zQLsArizPARi0yPVnKTFdnKXfeiyanNTjcWdfPQ9tg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the DSP Peripheral Authentication Service on the SM8650 Platform.

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

