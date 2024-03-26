Return-Path: <linux-kernel+bounces-119978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D8C88CFA3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921401C31C09
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201B813D602;
	Tue, 26 Mar 2024 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wb6USPRv"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C2813D529
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711487319; cv=none; b=rppQ9vBCxX98oajNt5Dn/bUOTwju8fQPipbJAxhPAH7oUMAsH6m+5nckk7w2Vmynqma59QsXAnK4kRJWP2W7mTd2ZAQBvPW2z1tCFoVDV4Po7GIcTbW5QgKxmZl/lG7mlVMhBWoThfu2MnMQSgVzWtTm1ZRJOnZzs7tcHcKDBtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711487319; c=relaxed/simple;
	bh=xDRhU9fuss958Jnn/T9060yzGlfRWLXT4S0FXGgRw2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hvNjzf61+/J0PLPcMVhbfbdRY5pJrN3t47JU3Dv1mlXb9UqOuOM7CP46PqS3DljLjmWl+E+4fgvgukNl+wmqoGhoH5LbtKOkt1tHIDLZ5ur9VgsNSYWDywPuCev/sVmSjiwMfbfA1J9Nhl2+ODUmNYZZLEK10Df7rhGuHVrjcAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wb6USPRv; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a470d7f77eeso764457466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711487315; x=1712092115; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03If1nnZ10DuCwAdzvBn1Iv3LsS/vvMwgwg5YaM+2MQ=;
        b=wb6USPRvFQovYuCFiljYaRf12cs3iwM2D9ibQr5gk4hjYNz9QGmcGQQqSieH/FDy9V
         IA0zHgasXnDzDIYV9//tYZ36s98o2RaNvLS93KIi3iedwXqzZR/mNk4Bx6W1/n3OJ72R
         AwOfKLoAqpxSr2ArzYMs2FrIikfC7KZJ1hIr496gsNxpgAMfSMi8TfXxMPmQZAL7soui
         2QDfJsqUJO/9SSRHmDwEAUf1HfxmhGj83G1Nlg/IEDBC/pNR1g68qAlrYFNVtDeBULwW
         IijNWDck/GzYqT1yFYTv4eqgA/S+xM7xsOrQB4svt+YPZZjG481McTaiqQ/On90Ak06v
         1RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711487315; x=1712092115;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03If1nnZ10DuCwAdzvBn1Iv3LsS/vvMwgwg5YaM+2MQ=;
        b=u9PjVBKLeB4fYicyJhb2nJL/EExJ3QBwEEfqB6q1A5mAeL65SVwgCpf8qxEwsgeXuD
         M8W5rhmsmTvMDFQWW5OL3wbOteGFY8euYG3JaUQvYK+ZmTabLnbXb/DuWjgXcRyHPeka
         Q4Orp8ZLkiFvIJfeqf2zfhdNTfrgVZDvW8zSTTnxqnbkOuhyCCQ7wnu92afkE1dlP7YY
         JmCrc03DcX+nIKIhEY9kQc0RmKZ4PnhmAc6EJU6KcSznz578BO4MYbO7pYPvpJL05xT+
         CF3KXwkvx0A5q9ocrdsGiQVtFw6pFUdPlqbo0s/RUfFRyrwil4HrWNucf8wFqs4IwsuX
         a83w==
X-Forwarded-Encrypted: i=1; AJvYcCUKoJAcHZF8H0jqDPnIhEfq0u3hH0Q92ffdCQGJ6JTx8gZS0WEodLzNtm29TJA0o4hc9DrqFI7iJ9nomMrC1dBqFSNw3VJR75vDX9Ll
X-Gm-Message-State: AOJu0Yx+mttWmD/gOef0byyeIAic7t6dGwhyXP3h3eGgSJl++L8cez7n
	6T5wDePz6mhmzT9tkkX3aaDKxLUd2NmrNmhDwvwWIFe2KNkunFxVY3ikOVtpqrQ=
X-Google-Smtp-Source: AGHT+IEWO4nVt+sBd1nsVyvUtrbxYtn1jmF7LPWJPETS4cp6HDjdc0ruarlVH71jWLfbBj2hy70asA==
X-Received: by 2002:a17:906:2ac5:b0:a47:76c:e363 with SMTP id m5-20020a1709062ac500b00a47076ce363mr8023214eje.25.1711487315599;
        Tue, 26 Mar 2024 14:08:35 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id l19-20020a17090612d300b00a46cffe6d06sm4621697ejb.42.2024.03.26.14.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 14:08:35 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 26 Mar 2024 22:08:23 +0100
Subject: [PATCH v3 1/5] dt-bindings: clock: Add Qcom QCM2290 GPUCC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-topic-rb1_gpu-v3-1-86f67786539a@linaro.org>
References: <20240219-topic-rb1_gpu-v3-0-86f67786539a@linaro.org>
In-Reply-To: <20240219-topic-rb1_gpu-v3-0-86f67786539a@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711487311; l=3930;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=xDRhU9fuss958Jnn/T9060yzGlfRWLXT4S0FXGgRw2Y=;
 b=q5jW9Tv0TNb4Y7shQot4k4DcuEi9aEvkTvEeMawzjiz0//RXDW5AbX1r8e4yIj/d7mc3J6Xhm
 eD9ORkNgDRUD54IqAJnJL3o9d8u/GGcAv00p5D70CqT9D3Yp9I2Webw
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add device tree bindings for graphics clock controller for Qualcomm
Technology Inc's QCM2290 SoCs.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/clock/qcom,qcm2290-gpucc.yaml         | 77 ++++++++++++++++++++++
 include/dt-bindings/clock/qcom,qcm2290-gpucc.h     | 32 +++++++++
 2 files changed, 109 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,qcm2290-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,qcm2290-gpucc.yaml
new file mode 100644
index 000000000000..734880805c1b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,qcm2290-gpucc.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,qcm2290-gpucc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Graphics Clock & Reset Controller on QCM2290
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+description: |
+  Qualcomm graphics clock control module provides the clocks, resets and power
+  domains on Qualcomm SoCs.
+
+  See also::
+    include/dt-bindings/clock/qcom,qcm2290-gpucc.h
+
+properties:
+  compatible:
+    const: qcom,qcm2290-gpucc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: AHB interface clock,
+      - description: SoC CXO clock
+      - description: GPLL0 main branch source
+      - description: GPLL0 div branch source
+
+  power-domains:
+    description:
+      A phandle and PM domain specifier for the CX power domain.
+    maxItems: 1
+
+  required-opps:
+    description:
+      A phandle to an OPP node describing required CX performance point.
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - power-domains
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-qcm2290.h>
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clock-controller@5990000 {
+            compatible = "qcom,qcm2290-gpucc";
+            reg = <0x0 0x05990000 0x0 0x9000>;
+            clocks = <&gcc GCC_GPU_CFG_AHB_CLK>,
+                     <&rpmcc RPM_SMD_XO_CLK_SRC>,
+                     <&gcc GCC_GPU_GPLL0_CLK_SRC>,
+                     <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+            power-domains = <&rpmpd QCM2290_VDDCX>;
+            required-opps = <&rpmpd_opp_low_svs>;
+            #clock-cells = <1>;
+            #reset-cells = <1>;
+            #power-domain-cells = <1>;
+        };
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,qcm2290-gpucc.h b/include/dt-bindings/clock/qcom,qcm2290-gpucc.h
new file mode 100644
index 000000000000..7c76dd05278f
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,qcm2290-gpucc.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024, Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GPU_CC_QCM2290_H
+#define _DT_BINDINGS_CLK_QCOM_GPU_CC_QCM2290_H
+
+/* GPU_CC clocks */
+#define GPU_CC_AHB_CLK			0
+#define GPU_CC_CRC_AHB_CLK		1
+#define GPU_CC_CX_GFX3D_CLK		2
+#define GPU_CC_CX_GMU_CLK		3
+#define GPU_CC_CX_SNOC_DVM_CLK		4
+#define GPU_CC_CXO_AON_CLK		5
+#define GPU_CC_CXO_CLK			6
+#define GPU_CC_GMU_CLK_SRC		7
+#define GPU_CC_GX_GFX3D_CLK		8
+#define GPU_CC_GX_GFX3D_CLK_SRC		9
+#define GPU_CC_PLL0			10
+#define GPU_CC_SLEEP_CLK		11
+#define GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK	12
+
+/* Resets */
+#define GPU_GX_BCR			0
+
+/* GDSCs */
+#define GPU_CX_GDSC			0
+#define GPU_GX_GDSC			1
+
+#endif

-- 
2.44.0


