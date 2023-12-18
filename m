Return-Path: <linux-kernel+bounces-3333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D13D816B22
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A221C22883
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91049179BC;
	Mon, 18 Dec 2023 10:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BU17d7Xd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5677618033
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c48d7a7a7so27098735e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702895294; x=1703500094; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71CxKbWqIB1thWUHFZAzLfbTO4lgIALsc6uKYJhAAGc=;
        b=BU17d7Xd4azDuvLekGXnXqHMEq6jwEv04j7qbxwVjwAL6qX5hkJxeWvN3ldR4WK17D
         JAnfTuBbBjaPninVQLJPffuYXl51a53ItvJzVfx20exoMJewkkXngfD2k6X+Hu31HE46
         LTDAzG4FI4uVfS9VQ+EKx8g337HdHdQOVILI+RXKN4mAU6PNG3d679NTW1VneHsmGPdH
         vUQUzgJ97Y567GnRomWwaHJdyPnFHCB+zm1aJ1i45kx0bRxH8Dv32rFyRzbQTPO+Av6t
         Jp29AvBpJodcPvXnl6VKz1LWvf23OrdOowfFjzrrYNgHcUlnZIdOep58AidVEUM7JD0I
         tTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702895294; x=1703500094;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71CxKbWqIB1thWUHFZAzLfbTO4lgIALsc6uKYJhAAGc=;
        b=K4IR57gidixsU8NWbKB357LYvvHs9xXfubARfgziaTxrFGAyNvNYKskCAlhQzyVYvO
         DIuCoDyDQu8HuRiZgGAq+08z7TbdhhpTGXWmauTINMg6vOIkC0sdWxLdZX2VoOdOUBsy
         Z2XHXOUjSY+uIAP/07Fhx+j2cE9rlLTjk/iE0TUeAkpsZvZltMzQoFdFkLKw1uwFALfC
         D74obsN84ijCRxJ0xo+7GbGG/D8DA1pjd185rQDoyvGUS3CFthPerdz80q7c+7zQa/WE
         HTNBH/7RavxcW6XsQfV2u8RfMZwC/2HfWoX3vhrmJa6+Fn1iQoOg76yFTGVZPl8y21hz
         Q8Wg==
X-Gm-Message-State: AOJu0Yxe2nbJ/oQI/8sZdleywpVDGJNOzkEiP4O5jsVaIJDia0GousM7
	EsH12egJ42dCoUL2x1LCuAfRzw==
X-Google-Smtp-Source: AGHT+IEwLSOZuZSMI7u5hxH0v/pOD+2428m4bH3qY6/baCeQ1kphytNaOv4mdV+yWww/e5AqiYSXUA==
X-Received: by 2002:a05:600c:a08:b0:40d:1c4b:77a0 with SMTP id z8-20020a05600c0a0800b0040d1c4b77a0mr108345wmp.25.1702895294523;
        Mon, 18 Dec 2023 02:28:14 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ay35-20020a05600c1e2300b0040b2b38a1fasm41857967wmb.4.2023.12.18.02.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 02:28:13 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 18 Dec 2023 11:28:09 +0100
Subject: [PATCH v6 1/3] dt-bindings: remoteproc: qcom,sm8550-pas: document
 the SM8650 PAS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-topic-sm8650-upstream-remoteproc-v6-1-3d16b37f154b@linaro.org>
References: <20231218-topic-sm8650-upstream-remoteproc-v6-0-3d16b37f154b@linaro.org>
In-Reply-To: <20231218-topic-sm8650-upstream-remoteproc-v6-0-3d16b37f154b@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3084;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=gsIvwnD1pTzAEzxjRT3QO/jWU2a/vS/+hNR3Zbvsze0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlgB67P/uAtzUgRlywwZdgEhKq/F/myHYs24NH7z7w
 ziHnJZOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZYAeuwAKCRB33NvayMhJ0dphD/
 901Odi/wYrAY1+eFQqL6S15/Mg/vifv9Jal3WFBo64/Un5u2Ibse6RDCTotLpNRv6zzxGaeFNOwlzl
 LdXki0h8mywPZJy/6Ao0n8SrmhmbSlTa/FAxdXNUVmyMynLVqLAGcha6Tu/fnldzUhBUj8lxMB5Sv2
 /f+OjcEyxuLB1LI8lKrDQIKIs1B/oPx8CfHpIm3US1ZJLhi2QWx2UK0fUfnVYFzV2Vd9gHO6QTYTm/
 wNfUmifou+zhIEITdbcTH/cyf8RdSjD2im2rSKB/k/uFyMV2Iy/zk/A7D+CV8RyFqTLhX8ZST3fxqN
 mZDKJpzodzClECd4gTQq63ELa9kNyMF41uSLmE/T3tE1YvQ2TGcMBXj6AhPHORLs7/Ru1FOueaX7be
 o9veqnUvHcVqulotiynopSa5l5W/VDjo9eYS8LTxrD/zJI1Ru11bqlb9BwscMXxGqr35l1heVESxN6
 vI9r/XwYBtRVpkyhmQRkYM2rlHSHzC0MupoNtblZkUw5oL1y1ZDG3KGvAzLbdtRqN4bHazRno5fR6q
 /3h/LsST0SfcCL/9MbMVGhdNTSyCibu08e65b4BOIuCYBbMyO4A/iA/aJbAMQPzlj+Wi/7re7Xfw+n
 QrMiEVQIZGzfrDGCn86EOcZgs3nNrZuewPUENUPakMMHH0abkrNxMYtM/3CQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

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


