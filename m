Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BEE7E1C30
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjKFI3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjKFI3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:29:05 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BC91B2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:29:00 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32f737deedfso2543747f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 00:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699259339; x=1699864139; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71CxKbWqIB1thWUHFZAzLfbTO4lgIALsc6uKYJhAAGc=;
        b=qV2bNOtYWd+pfLGgMJYJMXghJL5zeQclW2Yqlf92SeemWkiRZECQ/Ukd6MsrSr1r9y
         i2Ob56G2vyK9HqrHMEOqSG8WiXe4vttj4g7MzjpNB3C6Kh/hTGdCmCKL6VvqU+sYBTfg
         grIFEAotoz4/s7bSGw2/M5I6u21B2HvvH1lggINVsfL5C7Q7YBGMdEucL1jbnjlDYBuG
         9hkDZqaU9+7VDmgRt0cS09rdlLWA81jbQRsqsKG9nfym4QZJjM+uJ1Qe0z78teejfXRR
         HfVNGRZy3IZDrsTsF0M9Trk3yll3CIZQDPwEdpFaiXScbdiN8TyxweIG18PsDCN1fCLJ
         GvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699259339; x=1699864139;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71CxKbWqIB1thWUHFZAzLfbTO4lgIALsc6uKYJhAAGc=;
        b=jAH/NXDBUtHefpcv8n1DqbJu/0wgrJf9EO6Cl1lpov/M2Uz+kLtMjDe+dAUOhrc47J
         LZFxsKdLiQGn3Nr5cVkZhWzYGw6l0bYvcFcPd8fD21OFDaump2Km5/KnjMB2eY01Y9Xl
         igY6mhFUxvfT4cbUDi1daCJfmyvKet5z59THdHIF4RWIsAKCT5KTdqqsFbqdNjis+Dno
         f6broqeatydP/dKDsENtTHIt0ctzefZd+2f35Ilt7TDaNJToFw40GW2FxG+pJFeQAjR5
         56LRB4jGdzmWeEARAI1u755i4hdz/NxJnw+ae4gxc3pY/SAFbuCDPCN38fBwIq7wEY8l
         EqrQ==
X-Gm-Message-State: AOJu0YyrUKrguNjj70w6P4Lv/F20F4A36pSpAbQeYaIjWhgQvQzM43T8
        UG2AECo7GEiMrDC1ibf01KwPlw==
X-Google-Smtp-Source: AGHT+IGL7/mxxsODCac2Iuesz8nOv2RLlMBNJ3e7Zxj0TaMRjwursFhG397QDqaoPo5GbJxQ93a4IA==
X-Received: by 2002:a5d:60d2:0:b0:32f:d88b:2242 with SMTP id x18-20020a5d60d2000000b0032fd88b2242mr538852wrt.7.1699259339013;
        Mon, 06 Nov 2023 00:28:59 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id p12-20020adfce0c000000b0032dc1fc84f2sm8796126wrn.46.2023.11.06.00.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 00:28:58 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 06 Nov 2023 09:28:52 +0100
Subject: [PATCH v3 1/3] dt-bindings: remoteproc: qcom,sm8550-pas: document
 the SM8650 PAS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-topic-sm8650-upstream-remoteproc-v3-1-dbd4cabaeb47@linaro.org>
References: <20231106-topic-sm8650-upstream-remoteproc-v3-0-dbd4cabaeb47@linaro.org>
In-Reply-To: <20231106-topic-sm8650-upstream-remoteproc-v3-0-dbd4cabaeb47@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlSKPHN2BrTwkoxLoI1slEW2seI7xkkYzDCmPvunTV
 t4lMVIyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZUijxwAKCRB33NvayMhJ0dv4D/
 9hRvNcQvHyzy6Pf4A1mjehaEpjro3EKdArWz5rgd/7cZrL1duYEveuBpH51J/goxI5lzTUbqdBNx00
 J6i6vJZTmYlChDDowOE8S/b/jJ1oDk8fiVaNxJ6x67Bkv1wdczZa75a98AGjOJ5cTdx049omSdOmDj
 hnlLNLzBpG7QQMGjIXQh+FgaMQyHiExQfGARvbcYUeetLsfctTWLmBAm6bRqG023VzQoDNSl6AhZW2
 GkdP28Rhsa9n+xSh4GouiNf2uykWy1VDzDsLHFixOH5PmJTKnmEsySHVYUVWoBqOYgSVila0kBx5+l
 ssr4irFpow4tlB40lZaSgI9DWvr2lDiEBWNtY+nHFc6AsJJMY1ibh4QPyPAvp5AMQuRg1n++g7rZov
 rxYvDy2EzqxbLm1S1rRe2v989mzw11ZY2Xgitp71wQD2FdxVU5PRArM/Sx/I47pUer+y78KJt2PPgO
 ZXk+agBAs3930nV8NN7GMrWK8LxCHdWGDv0Pz6RmN4QWETS9fqBay1Sifk6IZlRkyB8HJ24TEhmSwT
 VH8pgAoczGgjUbKlhcFZ0sJhLJdFAiXqmJu5wsAnUkW3PPsOzqwIJ6B54cwQTmV7Xb5l6kBuukgWJN
 vN4YNQnj/nSYmoLYE9z6AQce5fLzJkbzilTFmTc2XvfvyOmBq1epxdGl7Sfg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

