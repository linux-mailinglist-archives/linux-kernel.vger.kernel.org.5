Return-Path: <linux-kernel+bounces-36555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE0C83A305
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06681C236AA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2B917566;
	Wed, 24 Jan 2024 07:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xw7XR1sz"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C195C171B6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706081810; cv=none; b=OVz7Cmbmp13kROluevGVSvmvrC2GN3DDs4DWMPPu+n1l8mesqHoSfgkjAefHpLv+extXwYvjnbAuwKykTH8TGXGxyvlsFxC2l1y5RJXR0nUi9sAH82XTtp1jdjaJC5x/1Af69tPLG4000F8pPjjbabh047cbewD89AabntYOfVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706081810; c=relaxed/simple;
	bh=/R7t+UW6ZmKuKk7MIzT+d0YPo+66e3175rDe543o5Ic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=otK9XPV6ArTjniCgoKEjiYYIh7NQf1qum6igYMWftELKOcn8EjRMR+1ITYN/4/cHQmB3AbOeiu7EsDRXozp2LkiKprbR4wBoSGoVR/0stR8lMk/3s8uSCMNb9YTPCbKW+DzjKqlgMeW/7aOJOuET7W2b+BkeX5uKXC80DSJqZFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xw7XR1sz; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5c65ca2e1eeso2604237a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706081808; x=1706686608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=acrJlYqUICjl/fNKMSHxOuQG7AfEPQFGVB71vx3dR1c=;
        b=xw7XR1sziAZ9Fekybmr6IJJmuasmXwcJaqZq7Y/6G34PwyVCTEBRE6U0PA84yEyUS2
         fc+9IUxX/312U7dKSdaD9Tv209aho6w2SuXYM9WSFTzGv8lgyV9dG8YzItvKFsmtfLwo
         /yut60Qs+SYf6ovj67P1iEBX4dNBtQ3vDEMsETSqphZdycWJAR9s6Lhm7a8QeemqBb9T
         ISLEqMkenTpk41zjccCXaqXjAQ2Zd6WIN0bTNxMoJybvdl/Xzyk/zC/7K/szpk4tuCdv
         yB7l0LL35hx7pHiAxEsqy78kM+v4B3DYMuQKlEedF1Aj1OJTiru0VAMEuaEWSkdEDdtW
         63Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706081808; x=1706686608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acrJlYqUICjl/fNKMSHxOuQG7AfEPQFGVB71vx3dR1c=;
        b=bTcqTIRiX3IaIZzLftO5IutWwOaex+4QfiST3H5L9z6y8gX5S5zd5i1WXqZejoYBJz
         hEJeHi7oiik646e4XjQdzG6aenq/HOTysWRYt6dEM/iYuh6+nbKRj6vxp6rbyjhNyPSj
         R4djhloQKv8MTmECfCS7IZXuD2eD8xlweIL0P4y7b+N8y/VuRIme4QsCWqWZJ1S5lIaL
         uXYHJFsedaCtnRnUd7TeAaMQCfPQxHO9pISAou/WADTcXZLrcOH+hUr1hmApZh6Q3Usu
         8+S1pNi2KxzsbOGbckXTpSeMB+m0BwRxKR1//7YpgqCTi6f7lJZz6g7t9CEdvUHoNIcK
         DfKQ==
X-Gm-Message-State: AOJu0YyVnMgzt14P0nNp5R90ux8HuzOazWVgY0cIz3uV0IwxwiG1VeGy
	P/D4mC9Az2e0CFOLEn1tMm6GGgTznlSH4W3RlkF1yNDZZbZz3+2uCHrab+qfFw==
X-Google-Smtp-Source: AGHT+IHMZADYbjyE70v0RtIuM4joKlEWmfgzB62tpW1UDbeUqXCniEdLIob+5sbOtqxUtYoqeFybMg==
X-Received: by 2002:a05:6a20:bf03:b0:199:aeaf:cd3b with SMTP id gc3-20020a056a20bf0300b00199aeafcd3bmr270676pzb.42.1706081808139;
        Tue, 23 Jan 2024 23:36:48 -0800 (PST)
Received: from [127.0.1.1] ([117.217.189.109])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902b20300b001d726d9f591sm7386982plr.196.2024.01.23.23.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 23:36:47 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 24 Jan 2024 13:06:29 +0530
Subject: [PATCH 01/14] dt-bindings: phy: qcom,ipq8074-qmp-pcie: Drop
 PCIE_AUX_CLK from pcie_phy node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-pcie-aux-clk-fix-v1-1-d8a4852b6ba6@linaro.org>
References: <20240124-pcie-aux-clk-fix-v1-0-d8a4852b6ba6@linaro.org>
In-Reply-To: <20240124-pcie-aux-clk-fix-v1-0-d8a4852b6ba6@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1433;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=/R7t+UW6ZmKuKk7MIzT+d0YPo+66e3175rDe543o5Ic=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlsL4CiEXvEQ+narxvebS5XjcYmsO6QpgRHqHvp
 rAqTcXLWsyJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZbC+AgAKCRBVnxHm/pHO
 9eoUB/9jif/45s9Im3bQE1b5z3netk6pqcfdn67RHHTYUyCIixCOxMKgvmqEN9n48XIP/d9RFRt
 R7IlQxs2liAg57al7DMCRjYQUeAkMXAu+cF43aY+PxK+xXa/QBy1Tb1KT08qC5AhLmaGDjYLlmL
 EwnWwzX43aet5J+7NxdvgbtPxlVkGGDAKrroJeWin7T02c47+/915MJ+mjIFnWdHUX2b+NfFjm/
 bnSiNEf73NJRZjPFsug7zRq63JB5dG2dONZPsogzL6Plym+hinqwcGQnzOTpSJBU8QFy9SUJRAy
 SDiAHnJUf63xHOazM9doqVZJe5OXjdAJoRCwSitEo6Dr2A1I
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

PCIe PHY hw doesn't require PCIE_AUX_CLK for functioning. This clock is
only required by the PCIe controller. Hence drop it from the binding.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml       | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
index 634cec5d57ea..a953ac197dfd 100644
--- a/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
@@ -25,11 +25,10 @@ properties:
       - description: serdes
 
   clocks:
-    maxItems: 3
+    maxItems: 2
 
   clock-names:
     items:
-      - const: aux
       - const: cfg_ahb
       - const: pipe
 
@@ -72,11 +71,9 @@ examples:
         compatible = "qcom,ipq6018-qmp-pcie-phy";
         reg = <0x00084000 0x1000>;
 
-        clocks = <&gcc GCC_PCIE0_AUX_CLK>,
-                 <&gcc GCC_PCIE0_AHB_CLK>,
+        clocks = <&gcc GCC_PCIE0_AHB_CLK>,
                  <&gcc GCC_PCIE0_PIPE_CLK>;
-        clock-names = "aux",
-                      "cfg_ahb",
+        clock-names = "cfg_ahb",
                       "pipe";
 
         clock-output-names = "gcc_pcie0_pipe_clk_src";

-- 
2.25.1


