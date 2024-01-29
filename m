Return-Path: <linux-kernel+bounces-42593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B405784038D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B091C217CC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FC45FDB2;
	Mon, 29 Jan 2024 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xL8VnNzG"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED8B5B5C1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526642; cv=none; b=QblawBwq+OOofzwIhXugEtyud+m4XgJ1EI5u7Kcht4eMHG2/DEBMMtkfYRja0qqoWije6+Hkgf6t5h+sqSu0qVKJn2iUHaTsHwKmOO5CAKjTCyq9VFjqryJhjJPIYGQ8kOv9IT4j/c1ArCjHe9qrGazFcVYAHNJikt6lD0I8Z+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526642; c=relaxed/simple;
	bh=sa4E+CoKAN/LlXCOMcKVwg7cxW2KNFDdu3uPIropwl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VhT7X00Tw19g6NG9N8gAZIerypNNTr6/LXXFpsssp1ONGudCWgGab2vvlwoExI5SFp5XzVIxJeP+d9QotkV8040Zedd+pe87E1t5vFFeBlW2FH5Iejqht/4GBZv7PXeTa2nshF0FEaKp3lbnc6N5VxaboJ5g0qO56tp6GT0zco8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xL8VnNzG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a350bfcc621so253596766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 03:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706526638; x=1707131438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4SJ32iyQg/UWstplGgnSu+pyJqIEZM8JZ0B98PjYHE=;
        b=xL8VnNzGk8TyB6Iu1suJFHNJ7ewans2L1A/MfkKdxuW2HKlJ+kv2JqWCtRTV2le2Ie
         CfG+TUECGrAlkdmi1+jSeQm2VLKXdk/kAfBeshJVbUOs7SsJ57d1SWcCpGlUlYY1bh4d
         vtNhnZk79drqZDWe/KbpMmVoW0LGiZUa2+DjSC3S4G6cGXmexlz97U9fYZTj7Fwy3yAK
         VtkrMDLZ4GndLt+viWRgTnHflEJrd8+Jz3L5NJ2auQARD+r2vQ2+kjY1/l9XlLmUo2rW
         XfeoJ9yWYEUJrOtEKbZaoisHs6zMX7JrGox7kyDmE4JHdK8BJDFySuK5hP2RBQLRZ90o
         RwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706526638; x=1707131438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4SJ32iyQg/UWstplGgnSu+pyJqIEZM8JZ0B98PjYHE=;
        b=exbkVO41s9yMh7EBLbZ7Tndm+ay8YaeEtOl66hOt+QvXkbQiYe3rZ6vpcHg5s6oshM
         7glNqP0e08HUDLOnXRLxrvpJqTpbXHonFd/zYYxXQ/juyrQ29UY84kR5W8dv8d2onvjn
         bShlphD/YuJ+k7CswtZSCBDW6PCkiISJ2PYD4XI1we89zxyKRcQTiXMFYCCLzWGPNjTF
         HivjdnGssPupfgoCbK2F/IYB98fpTpUySnIrTRTqkNFZvWmI6glDrlVXTSIZS1/H82Er
         SEno9gSoQLQqB7mQTf+QN1rxx4RUy6ViyxbKboIIpVch2fDRDgxx+s2wWAGoLhdXaYng
         9WvA==
X-Gm-Message-State: AOJu0YyEH5Qwwh2BIsLRwLTzXj6X/hq8Y+VUHZkEiqMlMKRCBdCCkpJb
	aeK0Rx2TRpuDgvfdRe2OS/wDZ0bs8/ewDybl0RoqO7j5EKH4S6MVn08ZVv6L3z8=
X-Google-Smtp-Source: AGHT+IGdRIhytUQuCWuGECa23nBQpCFG0Gpy1ikLzNadB9MbtaYP9ACSUsjUGeNTkyw/dBcfPDt6nQ==
X-Received: by 2002:a17:906:494b:b0:a35:d914:c33e with SMTP id f11-20020a170906494b00b00a35d914c33emr783314ejt.52.1706526638475;
        Mon, 29 Jan 2024 03:10:38 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id tj4-20020a170907c24400b00a352f7a57a4sm2934620ejc.178.2024.01.29.03.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:10:38 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 29 Jan 2024 13:10:26 +0200
Subject: [PATCH v2 1/2] dt-bindings: PCI: qcom: Document the X1E80100 PCIe
 Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-x1e80100-pci-v2-1-a466d10685b6@linaro.org>
References: <20240129-x1e80100-pci-v2-0-a466d10685b6@linaro.org>
In-Reply-To: <20240129-x1e80100-pci-v2-0-a466d10685b6@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2268; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=sa4E+CoKAN/LlXCOMcKVwg7cxW2KNFDdu3uPIropwl8=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlt4epwCtmMzZ2Ir+cckMPH41sUypK/5mvakXj+
 I/pfUGdQqWJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbeHqQAKCRAbX0TJAJUV
 VqfdEADHyiQfS3v+gZkvdIdKUFS566uOhaOc9iT6Sip+116mVjNQYQhtg5Nxgvthyrm2B9LQs81
 v+Tw67Ef7RtrMxzLri7NRq34p9lpo6gqOGHU9mxA41jaFX1SJ5Ozt9eANkU05ZmHIr8wEkl9UoG
 HWpcqgnUMuBfFcnZKxIlulAnx0qlVogbdjjMShTiC6B+NNMoFbRBt3kwHE/QLwyj/YEsn+G1ml+
 qDRHFnWGhnG722nMcfJWqxGA5vIkOu2t4O+zTtlq0KRL4gmoA9asgqvioqmMipXgo+oWUsVG0t0
 2BWdMazV7RBtZaa6qWevnVQ83si/rCb3gPvRvfrnCo5Lbpe9/4foBcM2QxMfLedwysFlQeCkJJ/
 UA5FDSkPvfEGtSWu7hbK/uElxgajMnj0LXG0tn6FC5gspj51Vf/hXpi2YFIDZ+VzCnqn7FI/gBb
 ZLvOiWGlag7022AjJ6RSWg6DeFkBWmjptEByk7ScSFjCm/qaRRm4pZXv2wQHEtFpuD//LFby+9m
 pgaBdIe6z5dBOsJnIlnJ3ZPx3Wcf5qXr9e/I/d+xUJWPyshCT4RfDhZALk8FoMLKtvnVC/OKvxm
 c2ZxCDebwjKfEBXGD1yX7EKYLZPHb8p0PYLc6ajgM3UGP+Xud8MAUbuQTripPlOHUm+zqZM3Za9
 dfNl5idsFES4tkg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Document the PCIe Controllers on the X1E80100 platform. They are similar
to the ones found on SM8550, but they don't have SF QTB clock.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index a93ab3b54066..7381e38b7398 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -41,6 +41,7 @@ properties:
           - qcom,pcie-sm8450-pcie0
           - qcom,pcie-sm8450-pcie1
           - qcom,pcie-sm8550
+          - qcom,pcie-x1e80100
       - items:
           - enum:
               - qcom,pcie-sm8650
@@ -227,6 +228,7 @@ allOf:
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
               - qcom,pcie-sm8550
+              - qcom,pcie-x1e80100
     then:
       properties:
         reg:
@@ -826,6 +828,32 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-x1e80100
+    then:
+      properties:
+        clocks:
+          maxItems: 7
+        clock-names:
+          items:
+            - const: aux # Auxiliary clock
+            - const: cfg # Configuration clock
+            - const: bus_master # Master AXI clock
+            - const: bus_slave # Slave AXI clock
+            - const: slave_q2a # Slave Q2A clock
+            - const: noc_aggr # Aggre NoC PCIe AXI clock
+            - const: cnoc_sf_axi # Config NoC PCIe1 AXI clock
+        resets:
+          maxItems: 2
+        reset-names:
+          items:
+            - const: pci # PCIe core reset
+            - const: link_down # PCIe link down reset
+
   - if:
       properties:
         compatible:
@@ -884,6 +912,7 @@ allOf:
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
               - qcom,pcie-sm8550
+              - qcom,pcie-x1e80100
     then:
       oneOf:
         - properties:

-- 
2.34.1


