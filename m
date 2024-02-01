Return-Path: <linux-kernel+bounces-48499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A85AE845D18
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15CC8B23A81
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D9D626B3;
	Thu,  1 Feb 2024 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Y5mFFj3t"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653A477A1A;
	Thu,  1 Feb 2024 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804148; cv=none; b=hkDCI4S/LDqzGVWJYPHjBGEJIUdD+LR+oYek2t/wB2/Hx1tJZO1SIptQMjzMp2Ecg4X8g00nhkoBLz6qLC8qpKHSgtpGSHBPbWapZgKYhYmvbLzU+c7/d6DUFOZ6xXEJza5xYdletj5cFLfrwrWbZLV8KMWOhLgwP/UguSj9CFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804148; c=relaxed/simple;
	bh=hVjpHu3koi7L18tSbg4AlwiC4Eb+ehCY0Dv0iXrqIZM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KaDPwuSOa+9Rx8Xj/d+iORmrJy41PsUtTjVHRmbrHVBuSMOxOv+ZB4rOCPoGGrahSvBMe8qa8MCNJbju7GOaNRmsCNjcNjvNvSmSNgYNKs/QHaf9pMK5LN7OOudTXk3nsQ/K+IDMrTGZzhrM4aW9tyKL0K4cm0wcd6mKFnN6Neg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Y5mFFj3t; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706804146; x=1738340146;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hVjpHu3koi7L18tSbg4AlwiC4Eb+ehCY0Dv0iXrqIZM=;
  b=Y5mFFj3toIo2/HEW3zARcsneJNgjEBsCQ107ET81FPSljYZ//2WynPgo
   tevSycd7Z9UrRQFwvDpZzFAd3qSLckKCzy5xT+MsjRoVCY+41u4YWjgkL
   r49BpqQdznkC4ipkT6XnmIuHZm2IuQByTSXZR7JgKxt8NnPl7+O7TERy4
   jBZJG67VWE8hkb+qL0MFNq73q6/Uku9xaF8cSpfIxo1nkc+8Oj/lxe0Xt
   x6OYxvlR6Ae5QyQymi0mrAKhTe/5sphJO53wk6/s57HKtXVWRBsS7hj9b
   Ji+fTQir23yRcTEk3rkaMJBFxb6AwwTs9pCUa3LtoZHJoRVinJSUv/tUK
   Q==;
X-CSE-ConnectionGUID: 26EjCA2CRoKBu/UhJ2xKOQ==
X-CSE-MsgGUID: OCIm0yzETY2xVuzY8QOhyw==
X-IronPort-AV: E=Sophos;i="6.05,234,1701154800"; 
   d="scan'208";a="16960332"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Feb 2024 09:15:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 09:15:27 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 09:15:24 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<claudiu.beznea@tuxon.dev>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4] regulator: dt-bindings: microchip,mcp16502: convert to YAML
Date: Thu, 1 Feb 2024 18:15:17 +0200
Message-ID: <20240201161517.492162-1-andrei.simion@microchip.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes v3 -> v4:
- "additionalProperties: false" placed just after the required list

Changes v2 -> v3:
- keep one line of regulators description
- add additionalProperties: false for regulators
- "description:" at the end for each properties

Changes v1 -> v2:
- reverse subject prefixes
- line break after file "description:"
- drop description for reg
- drop regulator-name
- add regulator-initial-mode
- unevaluatedProperties just after $ref: regulator.yaml#
- additionalProperties  just before "required"
- node names generic in example
- drop reg property from i2c
- use 4 spaces for example indentation
---
 .../bindings/regulator/mcp16502-regulator.txt | 144 --------------
 .../regulator/microchip,mcp16502.yaml         | 180 ++++++++++++++++++
 2 files changed, 180 insertions(+), 144 deletions(-)
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
index 000000000000..1aca3646789e
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml
@@ -0,0 +1,180 @@
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
+description:
+  The MCP16502 is an optimally integrated PMIC compatible
+  with Microchip's eMPUs(Embedded Microprocessor Units),
+  requiring Dynamic Voltage Scaling (DVS) with the use
+  of High-Performance mode (HPM).
+
+properties:
+  compatible:
+    const: microchip,mcp16502
+
+  lpm-gpios:
+    maxItems: 1
+    description: GPIO for LPM pin.
+      Note that this GPIO must remain high during
+      suspend-to-ram, keeping the PMIC into HIBERNATE mode.
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    additionalProperties: false
+    description: List of regulators and its properties.
+
+    patternProperties:
+      "^(VDD_(IO|CORE|DDR|OTHER)|LDO[1-2])$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          regulator-initial-mode:
+            enum: [2, 4]
+            default: 2
+            description: Initial operating mode
+
+          regulator-allowed-modes:
+            items:
+              enum: [2, 4]
+            description: Supported modes
+              2 - FPWM higher precision, higher consumption
+              4 - AutoPFM lower precision, lower consumption
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@5b {
+            compatible = "microchip,mcp16502";
+            reg = <0x5b>;
+
+            regulators {
+                VDD_IO {
+                    regulator-name = "VDD_IO";
+                    regulator-min-microvolt = <3300000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-initial-mode = <2>;
+                    regulator-allowed-modes = <2>, <4>;
+                    regulator-always-on;
+
+                    regulator-state-standby {
+                        regulator-on-in-suspend;
+                        regulator-mode = <4>;
+                    };
+
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                        regulator-mode = <4>;
+                    };
+                };
+
+                VDD_DDR {
+                    regulator-name = "VDD_DDR";
+                    regulator-min-microvolt = <1350000>;
+                    regulator-max-microvolt = <1350000>;
+                    regulator-initial-mode = <2>;
+                    regulator-allowed-modes = <2>, <4>;
+                    regulator-always-on;
+
+                    regulator-state-standby {
+                        regulator-on-in-suspend;
+                        regulator-mode = <4>;
+                    };
+
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-mode = <4>;
+                    };
+                };
+
+                VDD_CORE {
+                    regulator-name = "VDD_CORE";
+                    regulator-min-microvolt = <1150000>;
+                    regulator-max-microvolt = <1150000>;
+                    regulator-initial-mode = <2>;
+                    regulator-allowed-modes = <2>, <4>;
+                    regulator-always-on;
+
+                    regulator-state-standby {
+                        regulator-on-in-suspend;
+                        regulator-mode = <4>;
+                    };
+
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                        regulator-mode = <4>;
+                    };
+                };
+
+                VDD_OTHER {
+                    regulator-name = "VDD_OTHER";
+                    regulator-min-microvolt = <1050000>;
+                    regulator-max-microvolt = <1250000>;
+                    regulator-initial-mode = <2>;
+                    regulator-allowed-modes = <2>, <4>;
+                    regulator-always-on;
+
+                    regulator-state-standby {
+                        regulator-on-in-suspend;
+                        regulator-mode = <4>;
+                    };
+
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                        regulator-mode = <4>;
+                    };
+                };
+
+                LDO1 {
+                    regulator-name = "LDO1";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-always-on;
+
+                    regulator-state-standby {
+                        regulator-on-in-suspend;
+                    };
+
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                LDO2 {
+                    regulator-name = "LDO2";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <3700000>;
+                    regulator-always-on;
+
+                    regulator-state-standby {
+                        regulator-on-in-suspend;
+                    };
+
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+            };
+        };
+    };
-- 
2.34.1


