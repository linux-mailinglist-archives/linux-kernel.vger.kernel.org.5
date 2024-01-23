Return-Path: <linux-kernel+bounces-34946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D9F838999
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6EB31C21912
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E651B57322;
	Tue, 23 Jan 2024 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BDOGDZ3/"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC6F57316
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999874; cv=none; b=eiiT+KxJKCPaXZG9b06q96OvoD/MwWeXB1Ve41drfENUYgw6zQ0wiCfeM3CypyTcX/DLxbamKQq6gAUof+zxJs+MvtrApfAItnewUuDeXu4X0PGXjR95Nf+QNmpKAo75sWpnL80+niRHZQlsQLyKkpyiQQsOaW+x+n4uhRWLioM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999874; c=relaxed/simple;
	bh=6tP3GEq2Ve4cLs93me+k9WTbdX84fhRNdG/MoJ4h/4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lvj0LfUkQqQY03Vm1hHRqr5U7VldIjnsDg8aBNTAKdBeO2T/CgByDRwY6jAeyU9F317lMe1t65w4GgL3y473kg9/tSAL529At2apoyHaagOYFhNe7pOfBtNLCuhJy7lK17YqKxdwffzkPM6sn43ygnZ8wNy7ijGDSu5gP+w7k5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BDOGDZ3/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40eac352733so20950395e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705999870; x=1706604670; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JDxzhnSCzMAdjTp5nizeiwv0z0TnxWP23yye4+yaoRc=;
        b=BDOGDZ3/I/cicSBgdOiHeAxeCWDILGBEHX08I0ZgGINuFWBavg3pmE8mzgF+ll0EXy
         bQ/84WIfE4P4i5hU2Zk79Ex4NbZFFGBHZRkYZ8pUJ16nVnE/E700DcvIcgmYmUy2yF+o
         PSVinWYLs3jFnn0C0hRcJeWGRxzE75jzsMBi6FIgmaIFoIImcvaT8ngFhpDEzQVzO4qb
         2iyObp82CZpiur9Ih7Q3w67VlZhlIRTdv6I4YEWYWTIkaYS0Domq8vgHioRpeJN9Tb5b
         xGYyW0Qx8jow6O79bYbAwfPc+tnTnFMqAwFNHuYxD7mYnrkAvvmT77JVRM6gtLH6qqn/
         CY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705999870; x=1706604670;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDxzhnSCzMAdjTp5nizeiwv0z0TnxWP23yye4+yaoRc=;
        b=EUlRj0m206xzS41ScuF7L8aLJ3W+hl07yTCn749PVu6fzFBV6W2trmwB6mgHRlrJMw
         dT3PLVOptxtjkMDXhKPvoq3t740fVOAhBut2/MKBUr1z4s7HzkFfcqAwd9eHYSZLbOgo
         wr20SGMTCDPYvLvM0+4oINzqIYSn6V+ACKkgnaWdD4A+Y1ZPgP5+9BcXp76Cvj7w1R1O
         cljX+loBgaeQL6ZzrEaKaygN9yZshGkxLVNEEgilEYA9MDdRwrF+F3gjHZVtAmYdoOId
         95cKAR1Rluc3V6o4T6wPk5NGs5oPdYZqoaIAq052O29Xg81ttowG9UEKE+9OsjUv0S5T
         mz1g==
X-Gm-Message-State: AOJu0Yz7sxv2uxfEwg9RCgrBx2gcFCG5TTYN2TWgeN0aU8f0T9P7OcXG
	DKhg5UTOx+bgRAtuTdGG2NJtIG/DevLIMqUHOLuFA0UHHLmL72YrZH/856OiC0M=
X-Google-Smtp-Source: AGHT+IGK51WoVVF1wYW+09HTCHhVT/YnPIrkvj38To4fa8PmatYVnBZ3NKE5/aCXyGyOW7CN/ChLxA==
X-Received: by 2002:a05:600c:44e:b0:40e:5181:63e4 with SMTP id s14-20020a05600c044e00b0040e518163e4mr330570wmb.165.1705999870626;
        Tue, 23 Jan 2024 00:51:10 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id m35-20020a05600c3b2300b0040e541ddcb1sm41847342wms.33.2024.01.23.00.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 00:51:10 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 23 Jan 2024 09:51:02 +0100
Subject: [PATCH v7 1/4] dt-bindings: remoteproc: qcom,sm8550-pas: document
 the SM8650 PAS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-topic-sm8650-upstream-remoteproc-v7-1-61283f50162f@linaro.org>
References: <20240123-topic-sm8650-upstream-remoteproc-v7-0-61283f50162f@linaro.org>
In-Reply-To: <20240123-topic-sm8650-upstream-remoteproc-v7-0-61283f50162f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3139;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=6tP3GEq2Ve4cLs93me+k9WTbdX84fhRNdG/MoJ4h/4o=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlr336f5bZc2dau7P56UrMfZR9KZD4vnrOKYaDE5Vd
 wk/M4qSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZa99+gAKCRB33NvayMhJ0VGHEA
 CILpEecVo6t9e5XMcI16Rt2/JDQUrMFxteN3WaGg0gnIpBfrca4otpd+PtSzuNG8zCDWliGj+RnWPi
 Pkr/XgRHF8t/mMhv0u8ghCLjJmQ1vln2szFBqHbOK+Qt4sqdDZixaJ2QR1SlcKnNrv881Hm3a4XT1b
 R4rzMgY9hAEUJdTxfWlzhUK68/44P0Teb5RDZdF9xFhFc80YOrBrsLr8lXCigwrndoDIsUgFRR6wZ8
 RStbDAr3A9rwq1tpmoAv2p6vhIhGMawP4S/ok/0oSq0MCa4dXFT8VutUVRDXOF346krs7nCHSIMpfc
 LZRTBob6QCrb47AOCLZ0oWEOy1LcS7HaBn6LLj/xO0XBvtO/ErXVIKpjytUf9ye7KaYd4l5OhPZAfS
 dEqIt6lhmHjdwJLXjyMLdXOIb52+EenM/7q4XAsiXA6pjs+QLM/ciCWk0v1Z3NMGizmgBDySgg+ysw
 AL/JfYiUalPowRuG12cfvPSCuYMTIeFZNzw1yZgetAbJ2wNnVRQpwsM0SOtVVEspHbR/9QFgQXALwQ
 nTtdNzDTbW/c8rRUUfDTkJLZpijqXY0no4gdvUmoqdfMZZCwuB4YOT2M3GvDRp6s5uFR1Mjir4V3z1
 R0w87sGfytguoVZ3QaCSxrQlBY0j5rB5K4b7d9y2wAZ9JZ9Yw496C3uAFeVg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the DSP Peripheral Authentication Service on the SM8650 Platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/remoteproc/qcom,sm8550-pas.yaml       | 45 +++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
index 58120829fb06..5f63b6b9a8f5 100644
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
@@ -49,6 +52,8 @@ properties:
       - description: Memory region for main Firmware authentication
       - description: Memory region for Devicetree Firmware authentication
       - description: DSM Memory region
+      - description: DSM Memory region 2
+      - description: Memory region for Qlink Logging
 
 required:
   - compatible
@@ -63,6 +68,7 @@ allOf:
           enum:
             - qcom,sm8550-adsp-pas
             - qcom,sm8550-cdsp-pas
+            - qcom,sm8650-adsp-pas
     then:
       properties:
         interrupts:
@@ -71,7 +77,26 @@ allOf:
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
@@ -79,12 +104,28 @@ allOf:
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
+          minItems: 5
+          maxItems: 5
 
   - if:
       properties:
         compatible:
           enum:
             - qcom,sm8550-adsp-pas
+            - qcom,sm8650-adsp-pas
     then:
       properties:
         power-domains:
@@ -101,6 +142,7 @@ allOf:
         compatible:
           enum:
             - qcom,sm8550-mpss-pas
+            - qcom,sm8650-mpss-pas
     then:
       properties:
         power-domains:
@@ -116,6 +158,7 @@ allOf:
         compatible:
           enum:
             - qcom,sm8550-cdsp-pas
+            - qcom,sm8650-cdsp-pas
     then:
       properties:
         power-domains:

-- 
2.34.1


