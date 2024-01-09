Return-Path: <linux-kernel+bounces-20510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56072827FF4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB06D288345
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E06125A1;
	Tue,  9 Jan 2024 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZxnQsPcj"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78AEB670;
	Tue,  9 Jan 2024 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcZ743Jyb29JjLihugg9ySiZ8FR4vjWNF55YWPxv8g1IxM/v49jXQfZPKl5MYlbTT8cAZOUSNC/oLfDdmzhJB3x2DON1LV7Y+T2sA8149mXzxWY3CjoqwXaQghd1T02YUBmgGgKz3ISWeOX5yy3eeSdxR99AM4O3+0VuRLhUt0GXJhn5/TmL8iEjXbsxMKsT79YtL0HgMmMAZdTpCXqaPI/T2Zia7GuEqaTATqGmCM1V8ufWam383+MXBQ3+2Nrlo6KtrA4q6R0z21WmHjgIPWC4IOy/fHOxS87R8iM2npQO9Uz66NXPwfku9/yra9GHONXZjV4Db1tkxiOHToQ03w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lx4ikxSbLVZvncCIZpoN8Qy36C+CokJHabBSgYfi9h8=;
 b=Fr+lRh2ePpUjFGHASu+dmjRkPrxVGP/HZr+Hq6421ZPAtgMyVWIRK2qDz7PIuGHGR8v7fMLivdDQqx4iNQD89p8mviiQsjtFc2uG8EA31ImiOjWrvn+aH6f7UrknjxohoJbaP+SLNVjIMKKuOqfJKW+4FBjR2Wf10w54J3uHCLTOgp+/EZNg+65CjxrEAyk13MziOTYtLKPtoy8Hsefjhe9nG7yZP3yOkN62XsYRViMQ1fybFhFCM+KXviwtJzzYSvjx/Cg+qUUg2WdRLlxky7hwlWzCB0cTcI0LGyW7mpL9ZYLWNGv1HSLlf/8T13eOMc/Dz5LBWaOfLwpAbWmMOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lx4ikxSbLVZvncCIZpoN8Qy36C+CokJHabBSgYfi9h8=;
 b=ZxnQsPcjr9W1ISTI3i16NhtemP2wdEYJZSjeJpVNgRSGKOHrHVjo1xCP4flAEZAX+ZfsCytsByrcJp3aQiWnwz8k2y5hO0/c0XZESujMiS91A4QYLHVV6+XFvMMIoDHcGNoNGuRqbViXrSp2f5zbqSa1aXIYCXKcG6jxjpPauqw=
Received: from SJ0PR05CA0172.namprd05.prod.outlook.com (2603:10b6:a03:339::27)
 by DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 07:59:21 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::d6) by SJ0PR05CA0172.outlook.office365.com
 (2603:10b6:a03:339::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.14 via Frontend
 Transport; Tue, 9 Jan 2024 07:59:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 07:59:20 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 9 Jan
 2024 01:59:15 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Xu Yilun <yilun.xu@intel.com>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Moritz Fischer
	<mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Tom Rix
	<trix@redhat.com>, Wu Hao <hao.wu@intel.com>, "open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open list:FPGA
 MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
Subject: [PATCH v2 2/2] dt-bindings: fpga: altera: Convert bridge bindings to yaml
Date: Tue, 9 Jan 2024 08:58:47 +0100
Message-ID: <a9497e5e3e2cc683a1673b64a8c06d692e9dfa86.1704787119.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <5740b48543a94b7e2cde04acfca06f4e5eb5d981.1704787119.git.michal.simek@amd.com>
References: <5740b48543a94b7e2cde04acfca06f4e5eb5d981.1704787119.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8457; i=michal.simek@amd.com; h=from:subject:message-id; bh=BIxPpMVQhF824wIIDNBxBG+p/34BPYo9Ol+TcIWYqsM=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQ5f7buDjv/yaZj9S2X8wpnKsK/Bf71+rJ3//YJzeznZ l64LGF6viOWhUGQiUFWTJFF2ubKmb2VM6YIXzwsBzOHlQlkCAMXpwBM5Es8w/xqZxtlk5Nxix7u /uTxVGHTsuA01xiGubIMD6/8CD21USOJ40vS6RsOzzfe/goA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DS0PR12MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: db89fd13-2242-483e-998c-08dc10e8e2f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/K3oaFVUB21hm2V3mOmtjba7LYyoqn74Q3Zthaool8zu95zoZPnX1iN6CIti+MHr3Iup5puJn7SjuzAxMAvZG6e5eoDiqjQwimozkj5EJAqw6rb63JfUbYPbc4yebJ5J4hOe2yHSPFql7DSs1wOJpGPOUGDQ0UGyxXYRPnH0zzVydeKYCwMYf308yHA5m+KoWRPbR2fr0TzD15IR4NMkd88jqitHf8DP8P9Ai/Kka0QJ0bPGn25DY9kstaknMq4FqWjYso3k1ePUGenU39ROgbvMjKUjioVPWjaVLWB79zTh8ZIL3aUZ30thGmS9HorN3iH3JRvQ/1aXzpOHldV6NTbx5dIEz7HkswIWIr24bvp11dqOa5AULhbM4bVShpQ8UNx/b1q0mlYv18cpir1K2juJ+alOABX71chyTl9zqmxFxDebS412pnulxE3+6zmhx+qTcHS9v74svjPZtLaNucfUWnSanN/+0qoVe86yI9muwS6Yp2FMkFnyJ3cbrmMnqPG0XD8z1ygDRpd43Df5qQqrRhIuraPgXKTp2vis7+nRoT3kNdtNtror2j2Xj/R9PBGEyksDpvmpyyb2CmlSo+9hwVW/S4hPcEc6tnOLVBOaFsR4yON5ovsBBNTK/hFBmClEFRVP7A0/QzBNKBCdTVYaMPuLspdNBafeZrjcPENY/oqAtZUdlJZ7G8XuNpW5wMmEI5MVYaCetY1OGURxka5J7S3TcptSSCxsoIKz7vtYEOcD2W3FLssbmzSjJxE+zQHdrvQBWWEt+DpRSYScb9fsqMKWv7GiTA9Blqgyhx0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(36756003)(54906003)(44832011)(8936002)(4326008)(8676002)(356005)(70206006)(70586007)(316002)(81166007)(41300700001)(110136005)(2906002)(7416002)(5660300002)(86362001)(336012)(82740400003)(16526019)(426003)(36860700001)(26005)(2616005)(83380400001)(47076005)(478600001)(966005)(6666004)(40460700003)(40480700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 07:59:20.4499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db89fd13-2242-483e-998c-08dc10e8e2f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219

Convert Altera's bridges to yaml with using fpga-bridge.yaml.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
---

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


