Return-Path: <linux-kernel+bounces-1901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB49815581
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3AE1F2588F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29792539E;
	Sat, 16 Dec 2023 00:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="XEbW7uO6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A1437D38;
	Sat, 16 Dec 2023 00:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Received: from newone.lan (unknown [10.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id D0826162D80;
	Sat, 16 Dec 2023 01:23:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1702686181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e6wK2Gy5xRfcIkaY0Z8w6TvocRTnKcFd48PjUsahsFo=;
	b=XEbW7uO6h3iO0Dbgn3YLXiajVR2XgK1T2ISDwMEL19GdrGmWraGMhe93l+NzL4jo9Zx/kr
	TUvWAp22MPBnx9QlvpzCt9lqF2pGMGqpwHwCQSrgIU1wEZCmIfYGU9M/jBvO8MYljDg4fe
	1G+bPymljJIVcP38vThlRsRbCHUWm4w=
From: David Heidelberg <david@ixit.cz>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: David Heidelberg <david@ixit.cz>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v5] dt-bindings: iommu: Convert msm,iommu-v0 to yaml
Date: Sat, 16 Dec 2023 01:22:38 +0100
Message-ID: <20231216002242.112310-2-david@ixit.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert Qualcomm IOMMU v0 implementation to yaml format.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
v5:
 - updated example (thx @Konrad)
 - ordering of requirements + dropped > and | and reformatted (thx @Konrad)
v4:
 - renamed to qcom,apq8064-iommu as Rob requested
 - changed title to Qualcomm APQ8064 IOMMU
 - dropped quotes around URLs
 - dropped mdp node
 - dropped unused mdp_port0 label

v3:
 - I kept the name as -v0, since we have other binding -v1 and it look
   good, I can change thou in v4 if requested.
 - dropped non-existent smmu_clk part (and adjusted example, which was
   using it)
 - dropped iommu description
 - moved iommu-cells description to the property #iommu-cells

v2:
 - fix wrong path in binding $id
 - comment qcom,mdp4 node example (we don't want to validate it yet)

 .../bindings/iommu/msm,iommu-v0.txt           | 64 ---------------
 .../bindings/iommu/qcom,apq8064-iommu.yaml    | 82 +++++++++++++++++++
 2 files changed, 82 insertions(+), 64 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,apq8064-iommu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt b/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
deleted file mode 100644
index 20236385f26e..000000000000
--- a/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
+++ /dev/null
@@ -1,64 +0,0 @@
-* QCOM IOMMU
-
-The MSM IOMMU is an implementation compatible with the ARM VMSA short
-descriptor page tables. It provides address translation for bus masters outside
-of the CPU, each connected to the IOMMU through a port called micro-TLB.
-
-Required Properties:
-
-  - compatible: Must contain "qcom,apq8064-iommu".
-  - reg: Base address and size of the IOMMU registers.
-  - interrupts: Specifiers for the MMU fault interrupts. For instances that
-    support secure mode two interrupts must be specified, for non-secure and
-    secure mode, in that order. For instances that don't support secure mode a
-    single interrupt must be specified.
-  - #iommu-cells: The number of cells needed to specify the stream id. This
-		  is always 1.
-  - qcom,ncb:	  The total number of context banks in the IOMMU.
-  - clocks	: List of clocks to be used during SMMU register access. See
-		  Documentation/devicetree/bindings/clock/clock-bindings.txt
-		  for information about the format. For each clock specified
-		  here, there must be a corresponding entry in clock-names
-		  (see below).
-
-  - clock-names	: List of clock names corresponding to the clocks specified in
-		  the "clocks" property (above).
-		  Should be "smmu_pclk" for specifying the interface clock
-		  required for iommu's register accesses.
-		  Should be "smmu_clk" for specifying the functional clock
-		  required by iommu for bus accesses.
-
-Each bus master connected to an IOMMU must reference the IOMMU in its device
-node with the following property:
-
-  - iommus: A reference to the IOMMU in multiple cells. The first cell is a
-	    phandle to the IOMMU and the second cell is the stream id.
-	    A single master device can be connected to more than one iommu
-	    and multiple contexts in each of the iommu. So multiple entries
-	    are required to list all the iommus and the stream ids that the
-	    master is connected to.
-
-Example: mdp iommu and its bus master
-
-                mdp_port0: iommu@7500000 {
-			compatible = "qcom,apq8064-iommu";
-			#iommu-cells = <1>;
-			clock-names =
-			    "smmu_pclk",
-			    "smmu_clk";
-			clocks =
-			    <&mmcc SMMU_AHB_CLK>,
-			    <&mmcc MDP_AXI_CLK>;
-			reg = <0x07500000 0x100000>;
-			interrupts =
-			    <GIC_SPI 63 0>,
-			    <GIC_SPI 64 0>;
-			qcom,ncb = <2>;
-		};
-
-		mdp: qcom,mdp@5100000 {
-			compatible = "qcom,mdp";
-			...
-			iommus = <&mdp_port0 0
-				  &mdp_port0 2>;
-		};
diff --git a/Documentation/devicetree/bindings/iommu/qcom,apq8064-iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,apq8064-iommu.yaml
new file mode 100644
index 000000000000..5af59305d277
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/qcom,apq8064-iommu.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/iommu/qcom,apq8064-iommu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm APQ8064 IOMMU
+
+maintainers:
+  - Will Deacon <will@kernel.org>
+
+description:
+  The MSM IOMMU is an implementation compatible with the ARM VMSA short
+  descriptor page tables. It provides address translation for bus masters
+  outside of the CPU, each connected to the IOMMU through a port called micro-TLB.
+
+properties:
+  compatible:
+    const: qcom,apq8064-iommu
+
+  clocks:
+    items:
+      - description: interface clock for register accesses
+      - description: functional clock for bus accesses
+
+  clock-names:
+    items:
+      - const: smmu_pclk
+      - const: iommu_clk
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: Specifiers for the MMU fault interrupts.
+    minItems: 1
+    items:
+      - description: non-secure mode interrupt
+      - description: secure mode interrupt (for instances which supports it)
+
+  "#iommu-cells":
+    const: 1
+    description:
+      The first cell is a phandle to the IOMMU and the second cell
+      is the stream id.
+      A single master device can be connected to more than one iommu
+      and multiple contexts in each of the iommu.
+      So multiple entries are required to list all the iommus and
+      the stream ids that the master is connected to.
+
+  qcom,ncb:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The total number of context banks in the IOMMU.
+
+required:
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - qcom,ncb
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,mmcc-msm8960.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    iommu@7500000 {
+            compatible = "qcom,apq8064-iommu";
+            reg = <0x07500000 0x100000>;
+            interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clk SMMU_AHB_CLK>,
+                     <&clk MDP_AXI_CLK>;
+            clock-names = "smmu_pclk",
+                          "iommu_clk";
+            #iommu-cells = <1>;
+            qcom,ncb = <2>;
+    };
-- 
2.43.0


