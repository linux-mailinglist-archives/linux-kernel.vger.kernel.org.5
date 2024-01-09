Return-Path: <linux-kernel+bounces-20900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A107E828723
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D861C20441
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E21E39857;
	Tue,  9 Jan 2024 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Eh4mc+bJ"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF1638FBB;
	Tue,  9 Jan 2024 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEwYks3GRg5Yh7Hy5n1XwV6CDASNEEGhFY2tj7dlFWRz1YKqbz1IpSKEhN8PjJaBCvr0+K4Sc2S10LIynX0ixfGyOLFrH6M/YsjM2hVAXUveIHo+f4uOQJ/V2vZm3THxHgHXwB23w/3je4MUCk4VRTj+aEStAWWv64X8Ev/+vBstJqNHiWJtQt8aOSSeSm63E0W60YQKyFxsw/dXW0LG8WyU+ep+kSkypkHDO0PEXXdn7NxJUO8Xj9OrNnu1+/RnRdLrrmih+Wuidk0XUKrGvmHznFPj8l7/c7hOaMpTv25BSUuZFAAoHgtq7aIFxfGIVqnYOh406/b34xUugTMrnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnEcVmriSGuQHBmau/rPih3sMg89hxnAVhOiMbDYxiI=;
 b=a1qQsF4juVUOIbk7W1HOx8GT7EKQVjoOTGKimp/VxNK9QyRqs/46plHVmysYrAfi0yY+M1SJROisOXk/ymukt7uLjO0taKzygO4TZ7EA/O3tox42APthEUr8PTTccqIMy2u4bcXY9Uc7jFBE4pUcUq3m63WRTai6fybBDRh+7NP25GfhONiKv/l/dJV0KOv7sqKU6dPO3ruQixRV140uHIbHCUv0gbE81505YJrqbmzjKFD1DEaJ+WE5FIZ9TCJeQg7nwqF6ip2ZXH4gOo40fauqi/0R1fxGIQuKQuqj8j+fCrdErWT0EgYD50/UcaMGhuwrxLq5kJD5BqdzJ5wmJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnEcVmriSGuQHBmau/rPih3sMg89hxnAVhOiMbDYxiI=;
 b=Eh4mc+bJDwSWUmDLSoBkAsxsPEKPAerlFMzjzHnH7yG4yYmVVvktFzHGCnyRrAt1nDTy/EsTbChOLB8FutHKpcW1UIYojhCiJGbwcCNWG/EpT+41uqQzWHV6Iyxy44lp9xtmPiylAP33eFgzJK4E+D5xeQMCpGqtUTRV5z5ealY=
Received: from DS7PR03CA0334.namprd03.prod.outlook.com (2603:10b6:8:55::11) by
 CY5PR12MB6430.namprd12.prod.outlook.com (2603:10b6:930:3a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.23; Tue, 9 Jan 2024 13:32:47 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::a2) by DS7PR03CA0334.outlook.office365.com
 (2603:10b6:8:55::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 13:32:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 13:32:47 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 9 Jan
 2024 07:32:45 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Xu Yilun <yilun.xu@intel.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Moritz Fischer
	<mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Tom Rix
	<trix@redhat.com>, Wu Hao <hao.wu@intel.com>, "open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open list:FPGA
 MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
Subject: [PATCH v3 2/2] dt-bindings: fpga: altera: Convert bridge bindings to yaml
Date: Tue, 9 Jan 2024 14:32:39 +0100
Message-ID: <07d646a6d82cc21b100e45ced7cae3ef05faa2cc.1704807147.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <14558a4dcfab5255c1683015287e9c7f48b1afc2.1704807147.git.michal.simek@amd.com>
References: <14558a4dcfab5255c1683015287e9c7f48b1afc2.1704807147.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8549; i=michal.simek@amd.com; h=from:subject:message-id; bh=Zh457ExO4W1e9RdE7pk9jyeTRiItySpPt+pwOyYMlF0=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtS5Xh+tyn6GC3c/zL7pX+qZlLDHlKM9h7teoaH1L0vVv XmZfjs7YlkYBJkYZMUUWaRtrpzZWzljivDFw3Iwc1iZQIYwcHEKwET++TPMlddiiviq8P6U8761 DxbMs3bufzrxAMM8U934++tNJRXEYl7/yGrqzTs/c2oyAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|CY5PR12MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: c63392e5-9f4e-4716-ef58-08dc111777d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eYFQJgHOljr8Jn5ZAAYtxodDvgWcP+lbULvvNRLLr5TETxxS351G0CCtTWXvddSW6apyYEsre/iBIhgvSGmeEpDXHN+hTqmT1tCQ6zk1M0emhBWD91gxN8rlqDCnMva64hkAvDyQwtyhLUjUseTKdmG40gqxz/w28qZXq9fu78p7lypIONq3Pioi5Vx49k4uIvEkcX4chrf2Y0gqOKJrRlg/jzzh3T+H2b4i/eSQUZFK1gxhQkYpDlhxl53WLeSnG9dwkzkpHCqE155yaC0V+Zlo1Q2v/2/1WOEkrHGOdEYg3BBIZfvXM/SYJQsU9O8yaEaojp3yi43dBAi0ytotkLmgTihohWNj68wdlBJrsHQafiiVQwItdZQSn3lPDCpZRvkAkFnszkIWJvYw+scZvHoFoEYagY//Ce7Gt3P0vjeUCmpv0m6TBrzvMR27C0HrIBEg6IfJxUnYhqoG71QxkxUgqDZ0iol8WT6ZKRWNQu7RqUu9T2bovD0Ey/xxTGRuys2827Dyf7G1zzcJ8MudpziSzYlR0q1x+56zQER4Sr1KkXUPggc/uj0DqQUzx//KnjFJje+VKGOdZlql+al2PhPeEI2FOKcGRdZPWwQuNqNm7sK8bV7ryEOMUZDphRibW6ZDfzJJKqh8x8VlGWb+lIBgCcSP9vKmYgGcod4kv2TOgu4NiP4w3sJzWhUBP68rgO8dXU8G5jfViAc3a39mPxHx6xbH6aaEqQrK5moeB3Hq5B05OvquTROY4upHdGHDa49WVlyn7qpsljy6I7T2XaKlJ1nl62BSFb3DsoI+y3U=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(82310400011)(64100799003)(186009)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(316002)(8936002)(70206006)(70586007)(110136005)(54906003)(8676002)(966005)(6666004)(478600001)(86362001)(2906002)(7416002)(44832011)(36756003)(41300700001)(4326008)(5660300002)(426003)(40460700003)(83380400001)(36860700001)(40480700001)(47076005)(26005)(16526019)(336012)(81166007)(356005)(82740400003)(2616005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 13:32:47.1677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c63392e5-9f4e-4716-ef58-08dc111777d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6430

Convert Altera's bridges to yaml with using fpga-bridge.yaml.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

(no changes since v2)

Changes in v2:
- Add Yilun tag
- Add missing license to altera-hps2fpga-bridge.yaml
- Drop reg as required property from altera-fpga2sdram-bridge.yaml
- Align file names with compatible string
- Drop | from description entry because no need to preserve formatting
- Keep only one example in altr,socfpga-hps2fpga-bridge.yaml

 .../fpga/altera-fpga2sdram-bridge.txt         | 13 -----
 .../bindings/fpga/altera-freeze-bridge.txt    | 20 --------
 .../bindings/fpga/altera-hps2fpga-bridge.txt  | 36 --------------
 .../fpga/altr,freeze-bridge-controller.yaml   | 41 ++++++++++++++++
 .../fpga/altr,socfpga-fpga2sdram-bridge.yaml  | 33 +++++++++++++
 .../fpga/altr,socfpga-hps2fpga-bridge.yaml    | 49 +++++++++++++++++++
 6 files changed, 123 insertions(+), 69 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
 delete mode 100644 Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
 delete mode 100644 Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/altr,freeze-bridge-controller.yaml
 create mode 100644 Documentation/devicetree/bindings/fpga/altr,socfpga-fpga2sdram-bridge.yaml
 create mode 100644 Documentation/devicetree/bindings/fpga/altr,socfpga-hps2fpga-bridge.yaml

diff --git a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
deleted file mode 100644
index 5dd0ff0f7b4e..000000000000
--- a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
+++ /dev/null
@@ -1,13 +0,0 @@
-Altera FPGA To SDRAM Bridge Driver
-
-Required properties:
-- compatible		: Should contain "altr,socfpga-fpga2sdram-bridge"
-
-See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
-
-Example:
-	fpga_bridge3: fpga-bridge@ffc25080 {
-		compatible = "altr,socfpga-fpga2sdram-bridge";
-		reg = <0xffc25080 0x4>;
-		bridge-enable = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
deleted file mode 100644
index 8b26fbcff3c6..000000000000
--- a/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Altera Freeze Bridge Controller Driver
-
-The Altera Freeze Bridge Controller manages one or more freeze bridges.
-The controller can freeze/disable the bridges which prevents signal
-changes from passing through the bridge.  The controller can also
-unfreeze/enable the bridges which allows traffic to pass through the
-bridge normally.
-
-Required properties:
-- compatible		: Should contain "altr,freeze-bridge-controller"
-- regs			: base address and size for freeze bridge module
-
-See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
-
-Example:
-	freeze-controller@100000450 {
-		compatible = "altr,freeze-bridge-controller";
-		regs = <0x1000 0x10>;
-		bridge-enable = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
deleted file mode 100644
index 68cce3945b10..000000000000
--- a/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-Altera FPGA/HPS Bridge Driver
-
-Required properties:
-- regs		: base address and size for AXI bridge module
-- compatible	: Should contain one of:
-		  "altr,socfpga-lwhps2fpga-bridge",
-		  "altr,socfpga-hps2fpga-bridge", or
-		  "altr,socfpga-fpga2hps-bridge"
-- resets	: Phandle and reset specifier for this bridge's reset
-- clocks	: Clocks used by this module.
-
-See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
-
-Example:
-	fpga_bridge0: fpga-bridge@ff400000 {
-		compatible = "altr,socfpga-lwhps2fpga-bridge";
-		reg = <0xff400000 0x100000>;
-		resets = <&rst LWHPS2FPGA_RESET>;
-		clocks = <&l4_main_clk>;
-		bridge-enable = <0>;
-	};
-
-	fpga_bridge1: fpga-bridge@ff500000 {
-		compatible = "altr,socfpga-hps2fpga-bridge";
-		reg = <0xff500000 0x10000>;
-		resets = <&rst HPS2FPGA_RESET>;
-		clocks = <&l4_main_clk>;
-		bridge-enable = <1>;
-	};
-
-	fpga_bridge2: fpga-bridge@ff600000 {
-		compatible = "altr,socfpga-fpga2hps-bridge";
-		reg = <0xff600000 0x100000>;
-		resets = <&rst FPGA2HPS_RESET>;
-		clocks = <&l4_main_clk>;
-	};
diff --git a/Documentation/devicetree/bindings/fpga/altr,freeze-bridge-controller.yaml b/Documentation/devicetree/bindings/fpga/altr,freeze-bridge-controller.yaml
new file mode 100644
index 000000000000..fccffeebb256
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/altr,freeze-bridge-controller.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/altr,freeze-bridge-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera Freeze Bridge Controller
+
+description:
+  The Altera Freeze Bridge Controller manages one or more freeze bridges.
+  The controller can freeze/disable the bridges which prevents signal
+  changes from passing through the bridge. The controller can also
+  unfreeze/enable the bridges which allows traffic to pass through the bridge
+  normally.
+
+maintainers:
+  - Xu Yilun <yilun.xu@intel.com>
+
+allOf:
+  - $ref: fpga-bridge.yaml#
+
+properties:
+  compatible:
+    const: altr,freeze-bridge-controller
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    fpga-bridge@100000450 {
+        compatible = "altr,freeze-bridge-controller";
+        reg = <0x1000 0x10>;
+        bridge-enable = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/fpga/altr,socfpga-fpga2sdram-bridge.yaml b/Documentation/devicetree/bindings/fpga/altr,socfpga-fpga2sdram-bridge.yaml
new file mode 100644
index 000000000000..22b58453c5ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/altr,socfpga-fpga2sdram-bridge.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/altr,socfpga-fpga2sdram-bridge.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera FPGA To SDRAM Bridge
+
+maintainers:
+  - Xu Yilun <yilun.xu@intel.com>
+
+allOf:
+  - $ref: fpga-bridge.yaml#
+
+properties:
+  compatible:
+    const: altr,socfpga-fpga2sdram-bridge
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    fpga-bridge@ffc25080 {
+        compatible = "altr,socfpga-fpga2sdram-bridge";
+        reg = <0xffc25080 0x4>;
+        bridge-enable = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/fpga/altr,socfpga-hps2fpga-bridge.yaml b/Documentation/devicetree/bindings/fpga/altr,socfpga-hps2fpga-bridge.yaml
new file mode 100644
index 000000000000..d19c6660d6c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/altr,socfpga-hps2fpga-bridge.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/altr,socfpga-hps2fpga-bridge.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera FPGA/HPS Bridge
+
+maintainers:
+  - Xu Yilun <yilun.xu@intel.com>
+
+allOf:
+  - $ref: fpga-bridge.yaml#
+
+properties:
+  compatible:
+    enum:
+      - altr,socfpga-lwhps2fpga-bridge
+      - altr,socfpga-hps2fpga-bridge
+      - altr,socfpga-fpga2hps-bridge
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/altr,rst-mgr.h>
+
+    fpga-bridge@ff400000 {
+      compatible = "altr,socfpga-lwhps2fpga-bridge";
+      reg = <0xff400000 0x100000>;
+      bridge-enable = <0>;
+      clocks = <&l4_main_clk>;
+      resets = <&rst LWHPS2FPGA_RESET>;
+    };
-- 
2.36.1


