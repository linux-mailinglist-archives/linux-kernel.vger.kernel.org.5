Return-Path: <linux-kernel+bounces-14029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5266E821725
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBBEE1F21A7C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B0A4431;
	Tue,  2 Jan 2024 05:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YNpYQWr7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AB723C3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 05:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e4e3323a6so9507423e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 21:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704172649; x=1704777449; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPwf5mMASUhFtnDK4+mUIJwZeVNmPGTZR6zF8QblZ8o=;
        b=YNpYQWr7IL4hOaU5yxVIdTPptESp3yMTxaK1uYWg1wJSu5BEE1mJtZsd6lXDa+iv2v
         IKQHp0HCfXeQUlJhYnM50nTrCcFT38EzFI/brB9yF+O4qOZXNSIVatlePpf7J0FC2OD2
         s/01+OVVyFxmX2pA7P66A3i/wAQ9VbHKhd0AbwoHccFKr+z0HxypFi4BktPVd11jvv6t
         aIPwG3ebXiUup//ETMRwN6w8jtPUPWl/wvoZij/W0ZCquk1dmWjE2MydfDoJZI5isBRd
         BqxlZ8hSnsDypNZ6RZiDX7K4/E6zBLBw7H3ES952yPgAa50Qk4me77PHrnAF7WIOSPQw
         JDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704172649; x=1704777449;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPwf5mMASUhFtnDK4+mUIJwZeVNmPGTZR6zF8QblZ8o=;
        b=MnOevVgtvLM4rRGVJYxvUR3HRcydVMrXRpa9w6BVYB5GvibJtZIn4g4dRgkOGc3LbL
         JAXBbvVTeVASpPU/jAnBnBMPRMAuWCDUU68xY3tOEYO5J7VbstqpuPpsJ/d64oQJzJOM
         Q0J9lEz8UkpPqRSCdq/nsv1w6oKRdKn4YPvBCFvYHpiYPYRPLBBMlFNPhOYoBXIgQlam
         2iu92/BO/s4bZQcVQkY8RFooxCL7BU1ZybrmDgw2CD7win/FX8LhAF5w9SCfJMt2Sczi
         RX+nbAoZdtTO3aWa4bVleVctWeagjBDv7cAJRC+QjOmkcF2i3pl1EXtnyXBJyKPD+bFj
         q6hw==
X-Gm-Message-State: AOJu0Yx6TU5+s6x9c0zUGcoIr03DsNPbPSD6YylH5dWbw2NdM0kjLkXG
	UN/kMcSlRHywlemOufOy7RXWSlploJC9aw==
X-Google-Smtp-Source: AGHT+IGP2a3jv25ft1O7cKwbk2WYAreFkcKjV4s03h932dx8uphgz5a1GimK4cicrDURdjPTCu0j4g==
X-Received: by 2002:a05:6512:10ca:b0:50e:6a65:fa97 with SMTP id k10-20020a05651210ca00b0050e6a65fa97mr11257535lfg.33.1704172648329;
        Mon, 01 Jan 2024 21:17:28 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id r25-20020ac252b9000000b0050e810689e5sm2081827lfm.33.2024.01.01.21.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 21:17:27 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 02 Jan 2024 07:17:21 +0200
Subject: [PATCH v7 01/22] dt-bindings: soc: qcom: merge qcom,saw2.txt into
 qcom,spm.yaml
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-saw2-spm-regulator-v7-1-0472ec237f49@linaro.org>
References: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
In-Reply-To: <20240102-saw2-spm-regulator-v7-0-0472ec237f49@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5475;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Rrl8DtWc9AmZbJUOzG7UFbQ4ctK1eNIS/E5EO9aSnJA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBlk5xjUAq+5V4Wav7GyfrgtpfPAnAoRabcrZfXm
 1D3yp5HU/mJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZZOcYwAKCRCLPIo+Aiko
 1a3kB/9eOTG4L/XtFSEHGCYu7J6fxIb05v6BMr0xre4ItctmDeO9R1WBnT9F7qvXCpIGwCc2z1S
 IJGstmETrCzba+dbZMYXpnmaX5xlfapylIGM7jGVtxWCcAKIGDezf7nBE20vGQS0P+aTOqyzfsr
 SQTbJIj+1wixzh3rjKiIbSH8xQ+B2uoQxJVkiYsYJZ5lBxyjTr/VfqEBnWW99PIs3efwMlJhnDt
 ASOJCYhgftnzq3vZvDVHI5JvhGNEdNIBwgknSRX3oVqVHTK+DNfgcFMs3bj2wPQ0wWC31KGAqP/
 mqpkCs0j4aL0s+/HVgf8Nxh5ZG6tHkvOFUk9B6+ElqfgamZ/
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The Qualcomm SPM / SAW2 device is described in two bindigns files:
arm/msm/qcom,saw2.txt and soc/qcom/qcom,spm.yaml. Merge the former into
the latter, adding detailed device node description. While we are at it,
also rename qcom,spm.yaml to qcom,saw2.yaml to follow the actual
compatible used for these devices.

The regulator property is retained as is. It will be changed in the
later patches.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/arm/msm/qcom,saw2.txt      | 58 ----------------------
 .../soc/qcom/{qcom,spm.yaml => qcom,saw2.yaml}     | 26 +++++++---
 2 files changed, 20 insertions(+), 64 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
deleted file mode 100644
index c0e3c3a42bea..000000000000
--- a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-SPM AVS Wrapper 2 (SAW2)
-
-The SAW2 is a wrapper around the Subsystem Power Manager (SPM) and the
-Adaptive Voltage Scaling (AVS) hardware. The SPM is a programmable
-power-controller that transitions a piece of hardware (like a processor or
-subsystem) into and out of low power modes via a direct connection to
-the PMIC. It can also be wired up to interact with other processors in the
-system, notifying them when a low power state is entered or exited.
-
-Multiple revisions of the SAW hardware are supported using these Device Nodes.
-SAW2 revisions differ in the register offset and configuration data. Also, the
-same revision of the SAW in different SoCs may have different configuration
-data due the differences in hardware capabilities. Hence the SoC name, the
-version of the SAW hardware in that SoC and the distinction between cpu (big
-or Little) or cache, may be needed to uniquely identify the SAW register
-configuration and initialization data. The compatible string is used to
-indicate this parameter.
-
-PROPERTIES
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: Must have
-			"qcom,saw2"
-		    A more specific value could be one of:
-			"qcom,apq8064-saw2-v1.1-cpu"
-			"qcom,msm8226-saw2-v2.1-cpu"
-			"qcom,msm8974-saw2-v2.1-cpu"
-			"qcom,apq8084-saw2-v2.1-cpu"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: the first element specifies the base address and size of
-		    the register region. An optional second element specifies
-		    the base address and size of the alias register region.
-
-- regulator:
-	Usage: optional
-	Value type: boolean
-	Definition: Indicates that this SPM device acts as a regulator device
-			device for the core (CPU or Cache) the SPM is attached
-			to.
-
-Example 1:
-
-	power-controller@2099000 {
-		compatible = "qcom,saw2";
-		reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
-		regulator;
-	};
-
-Example 2:
-	saw0: power-controller@f9089000 {
-		compatible = "qcom,apq8084-saw2-v2.1-cpu", "qcom,saw2";
-		reg = <0xf9089000 0x1000>, <0xf9009000 0x1000>;
-	};
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml
similarity index 64%
rename from Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
rename to Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml
index 20c8cd38ff0d..84b3f01d590c 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml
@@ -1,18 +1,25 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/soc/qcom/qcom,spm.yaml#
+$id: http://devicetree.org/schemas/soc/qcom/qcom,saw2.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Subsystem Power Manager
+title: Qualcomm Subsystem Power Manager / SPM AVS Wrapper 2 (SAW2)
 
 maintainers:
   - Andy Gross <agross@kernel.org>
   - Bjorn Andersson <bjorn.andersson@linaro.org>
 
 description: |
-  This binding describes the Qualcomm Subsystem Power Manager, used to control
-  the peripheral logic surrounding the application cores in Qualcomm platforms.
+  The Qualcomm Subsystem Power Manager is used to control the peripheral logic
+  surrounding the application cores in Qualcomm platforms.
+
+  The SAW2 is a wrapper around the Subsystem Power Manager (SPM) and the
+  Adaptive Voltage Scaling (AVS) hardware. The SPM is a programmable
+  power-controller that transitions a piece of hardware (like a processor or
+  subsystem) into and out of low power modes via a direct connection to
+  the PMIC. It can also be wired up to interact with other processors in the
+  system, notifying them when a low power state is entered or exited.
 
 properties:
   compatible:
@@ -34,8 +41,15 @@ properties:
       - const: qcom,saw2
 
   reg:
-    description: Base address and size of the SPM register region
-    maxItems: 1
+    items:
+      - description: Base address and size of the SPM register region
+      - description: Base address and size of the alias register region
+    minItems: 1
+
+  regulator:
+    type: boolean
+    description: Indicates that this SPM device acts as a regulator device
+      device for the core (CPU or Cache) the SPM is attached to.
 
 required:
   - compatible

-- 
2.39.2


