Return-Path: <linux-kernel+bounces-35591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B078393C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B361C257D8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8866460DD1;
	Tue, 23 Jan 2024 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="m65fAOIO"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE3A60243;
	Tue, 23 Jan 2024 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024839; cv=none; b=nOUXul3FxLaFP/D48y/HGsB5TvN2SBNA/7LUSlj5+2kFulx5Z8XRlquV7VEJWzbdxgR5GNmVSFj/vOf3QwOdeeqUlOtvRkFGdAnlA3ugPTsMM/U7cHxCM9zUcnkZLVpfHonVHCRe2ZVq+88Q4uK4OSxSHy1hVzU7cK9aOkXnqvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024839; c=relaxed/simple;
	bh=91oeKKxHbhbyRcQw6MYpCH6wNS8RWmaWPd1EESRYLUE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DxHtjGhTRQsrO8IPz+H6Nl3zTgBypaCjBwU27O7n7AJJtH13i6nAfUgpl67U9HwZl9sXH+PH6+VebFjCGElFvwhCh5I/+itLQqa8cDP+R67WfeDhyT9Gg2xdjJOQZAJzngTh2Fxl/XQ5VnCzs1JVW5LYcaxKnNlANlJZaEuUXJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=m65fAOIO; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706024837; x=1737560837;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=91oeKKxHbhbyRcQw6MYpCH6wNS8RWmaWPd1EESRYLUE=;
  b=m65fAOIOGML9nwyAo/EEhzE5ohbLb3ZXo7627LPgTXGdDhLLlJl59edk
   unFjBC8MQyb2atgAL8cmL853XPvaYDce2NFjAPxSpcZFnx3/teU4Z29Zh
   gD4erRjJ07naminzc3vPS/Eq+cc855+cEVJhT83P+B/PJK1Nk8bmR5e3F
   qnFfBTCSuhAO5JTy2exYmnvCthrzrGEys0/z5BFN/r+hKdmkflsCuw0ei
   hqmNKb8vvha7+fkqsfovij8CZvOOUS74GuD9Cz7nNVNFh9qi6kiOqx6AH
   0f58crXViJLYlspdnQYL9bg5ss2/v0vvC9cVY2XX8dK73n8Y2qhZq3eP9
   Q==;
X-CSE-ConnectionGUID: RQnQrX+dS7qJcQ63qv9bpg==
X-CSE-MsgGUID: XJN7E3QCSZ21bEdCicAh7w==
X-IronPort-AV: E=Sophos;i="6.05,214,1701154800"; 
   d="scan'208";a="16414313"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2024 08:47:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 08:46:59 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 08:46:57 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>,
	<broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Andrei Simion
	<andrei.simion@microchip.com>
Subject: [PATCH] dt-bindings: regulator: microchip,mcp16502: convert to YAML
Date: Tue, 23 Jan 2024 17:45:25 +0200
Message-ID: <20240123154525.157448-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Convert devicetree binding mcp16502-regulator.txt to YAML format.

Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
 .../bindings/regulator/mcp16502-regulator.txt | 144 --------------
 .../regulator/microchip,mcp16502.yaml         | 182 ++++++++++++++++++
 2 files changed, 182 insertions(+), 144 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt b/Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
deleted file mode 100644
index 451cc4e86b01..000000000000
--- a/Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
+++ /dev/null
@@ -1,144 +0,0 @@
-MCP16502 PMIC
-
-Required properties:
-- compatible: "microchip,mcp16502"
-- reg: I2C slave address
-- lpm-gpios: GPIO for LPM pin. Note that this GPIO *must* remain high during
-	     suspend-to-ram, keeping the PMIC into HIBERNATE mode; this
-	     property is optional;
-- regulators: A node that houses a sub-node for each regulator within
-              the device. Each sub-node is identified using the node's
-              name. The content of each sub-node is defined by the
-              standard binding for regulators; see regulator.txt.
-
-Regulators of MCP16502 PMIC:
-1) VDD_IO	- Buck (1.2 - 3.7 V)
-2) VDD_DDR	- Buck (0.6 - 1.85 V)
-3) VDD_CORE	- Buck (0.6 - 1.85 V)
-4) VDD_OTHER	- BUCK (0.6 - 1.85 V)
-5) LDO1		- LDO  (1.2 - 3.7 V)
-6) LDO2		- LDO  (1.2 - 3.7 V)
-
-Regulator modes:
-2 - FPWM: higher precision, higher consumption
-4 - AutoPFM: lower precision, lower consumption
-
-Each regulator is defined using the standard binding for regulators.
-
-Example:
-
-mcp16502@5b {
-	compatible = "microchip,mcp16502";
-	reg = <0x5b>;
-	status = "okay";
-	lpm-gpios = <&pioBU 7 GPIO_ACTIVE_HIGH>;
-
-	regulators {
-		VDD_IO {
-			regulator-name = "VDD_IO";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <3700000>;
-			regulator-initial-mode = <2>;
-			regulator-allowed-modes = <2>, <4>;
-			regulator-always-on;
-
-			regulator-state-standby {
-				regulator-on-in-suspend;
-				regulator-mode = <4>;
-			};
-
-			regulator-state-mem {
-				regulator-off-in-suspend;
-				regulator-mode = <4>;
-			};
-		};
-
-		VDD_DDR {
-			regulator-name = "VDD_DDR";
-			regulator-min-microvolt = <600000>;
-			regulator-max-microvolt = <1850000>;
-			regulator-initial-mode = <2>;
-			regulator-allowed-modes = <2>, <4>;
-			regulator-always-on;
-
-			regulator-state-standby {
-				regulator-on-in-suspend;
-				regulator-mode = <4>;
-			};
-
-			regulator-state-mem {
-				regulator-on-in-suspend;
-				regulator-mode = <4>;
-			};
-		};
-
-		VDD_CORE {
-			regulator-name = "VDD_CORE";
-			regulator-min-microvolt = <600000>;
-			regulator-max-microvolt = <1850000>;
-			regulator-initial-mode = <2>;
-			regulator-allowed-modes = <2>, <4>;
-			regulator-always-on;
-
-			regulator-state-standby {
-				regulator-on-in-suspend;
-				regulator-mode = <4>;
-			};
-
-			regulator-state-mem {
-				regulator-off-in-suspend;
-				regulator-mode = <4>;
-			};
-		};
-
-		VDD_OTHER {
-			regulator-name = "VDD_OTHER";
-			regulator-min-microvolt = <600000>;
-			regulator-max-microvolt = <1850000>;
-			regulator-initial-mode = <2>;
-			regulator-allowed-modes = <2>, <4>;
-			regulator-always-on;
-
-			regulator-state-standby {
-				regulator-on-in-suspend;
-				regulator-mode = <4>;
-			};
-
-			regulator-state-mem {
-				regulator-off-in-suspend;
-				regulator-mode = <4>;
-			};
-		};
-
-		LDO1 {
-			regulator-name = "LDO1";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <3700000>;
-			regulator-always-on;
-
-			regulator-state-standby {
-				regulator-on-in-suspend;
-			};
-
-			regulator-state-mem {
-				regulator-off-in-suspend;
-			};
-		};
-
-		LDO2 {
-			regulator-name = "LDO2";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <3700000>;
-			regulator-always-on;
-
-			regulator-state-standby {
-				regulator-on-in-suspend;
-			};
-
-			regulator-state-mem {
-				regulator-off-in-suspend;
-			};
-		};
-
-	};
-};
diff --git a/Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml b/Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml
new file mode 100644
index 000000000000..13a6806b4604
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml
@@ -0,0 +1,182 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/microchip,mcp16502.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MCP16502 - High-Performance PMIC
+
+maintainers:
+  - Andrei Simion <andrei.simion@microchip.com>
+
+description: The MCP16502 is an optimally integrated PMIC compatible
+  with Microchip's eMPUs(Embedded Microprocessor Units), requiring
+  Dynamic Voltage Scaling (DVS) with the use of High-Performance mode (HPM).
+
+properties:
+  compatible:
+    const: microchip,mcp16502
+
+  lpm-gpios:
+    description: GPIO for LPM pin.
+      Note that this GPIO must remain high during
+      suspend-to-ram, keeping the PMIC into HIBERNATE mode;
+    maxItems: 1
+
+  reg:
+    description: I2C slave address
+    maxItems: 1
+
+  regulators:
+    type: object
+    description: List of regulators and its properties.
+      A node that houses a sub-node for each regulator within
+      the device. Each sub-node is identified using the node's
+      name. The content of each sub-node is defined by the
+      standard binding for regulators;
+
+    patternProperties:
+      "^(VDD_(IO|CORE|DDR|OTHER)|LDO[1-2])$":
+        type: object
+        $ref: regulator.yaml#
+
+        properties:
+          regulator-name:
+            pattern: "^(VDD_(IO|CORE|DDR|OTHER)|LDO[1-2])$"
+
+          regulator-allowed-modes:
+            description: Supported modes
+              2 - FPWM higher precision, higher consumption
+              4 - AutoPFM lower precision, lower consumption
+            items:
+              enum: [2, 4]
+
+        unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c@600 {
+      reg = <0x600 0x100>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      mcp16502@5b {
+          compatible = "microchip,mcp16502";
+          reg = <0x5b>;
+
+          regulators {
+                  VDD_IO {
+                          regulator-name = "VDD_IO";
+                          regulator-min-microvolt = <3300000>;
+                          regulator-max-microvolt = <3300000>;
+                          regulator-initial-mode = <2>;
+                          regulator-allowed-modes = <2>, <4>;
+                          regulator-always-on;
+
+                          regulator-state-standby {
+                                  regulator-on-in-suspend;
+                                  regulator-mode = <4>;
+                          };
+
+                          regulator-state-mem {
+                                  regulator-off-in-suspend;
+                                  regulator-mode = <4>;
+                          };
+                  };
+
+                  VDD_DDR {
+                          regulator-name = "VDD_DDR";
+                          regulator-min-microvolt = <1350000>;
+                          regulator-max-microvolt = <1350000>;
+                          regulator-initial-mode = <2>;
+                          regulator-allowed-modes = <2>, <4>;
+                          regulator-always-on;
+
+                          regulator-state-standby {
+                                  regulator-on-in-suspend;
+                                  regulator-mode = <4>;
+                          };
+
+                          regulator-state-mem {
+                                  regulator-on-in-suspend;
+                                  regulator-mode = <4>;
+                          };
+                  };
+
+                  VDD_CORE {
+                           regulator-name = "VDD_CORE";
+                           regulator-min-microvolt = <1150000>;
+                           regulator-max-microvolt = <1150000>;
+                           regulator-initial-mode = <2>;
+                           regulator-allowed-modes = <2>, <4>;
+                           regulator-always-on;
+
+                           regulator-state-standby {
+                                    regulator-on-in-suspend;
+                                    regulator-mode = <4>;
+                           };
+
+                           regulator-state-mem {
+                                    regulator-off-in-suspend;
+                                    regulator-mode = <4>;
+                           };
+                  };
+
+                  VDD_OTHER {
+                           regulator-name = "VDD_OTHER";
+                           regulator-min-microvolt = <1050000>;
+                           regulator-max-microvolt = <1250000>;
+                           regulator-initial-mode = <2>;
+                           regulator-allowed-modes = <2>, <4>;
+                           regulator-always-on;
+
+                           regulator-state-standby {
+                                    regulator-on-in-suspend;
+                                    regulator-mode = <4>;
+                           };
+
+                           regulator-state-mem {
+                                    regulator-off-in-suspend;
+                                    regulator-mode = <4>;
+                           };
+                  };
+
+                  LDO1 {
+                           regulator-name = "LDO1";
+                           regulator-min-microvolt = <1800000>;
+                           regulator-max-microvolt = <1800000>;
+                           regulator-always-on;
+
+                           regulator-state-standby {
+                                    regulator-on-in-suspend;
+                           };
+
+                           regulator-state-mem {
+                                    regulator-off-in-suspend;
+                           };
+                 };
+
+                 LDO2 {
+                           regulator-name = "LDO2";
+                           regulator-min-microvolt = <1200000>;
+                           regulator-max-microvolt = <3700000>;
+                           regulator-always-on;
+
+                           regulator-state-standby {
+                                    regulator-on-in-suspend;
+                           };
+
+                           regulator-state-mem {
+                                    regulator-off-in-suspend;
+                           };
+                  };
+             };
+        };
+    };
-- 
2.34.1


