Return-Path: <linux-kernel+bounces-20899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35D0828721
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E7E28315E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AFF38FA4;
	Tue,  9 Jan 2024 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5D7cA4GL"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3579739840;
	Tue,  9 Jan 2024 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOB/5JSUF0V7C5UrmrT48JWitdUVhsKLZ+jSvoWLTqNdYX4fGlHUUtBCO3IxyTQKKuObFtOeQ/4qkl7muSyfXXW90KV5IrEwVXaSCXH+nXFv4wyRC1aHiiPwjoxIqWhdvglnB2hVBXsyJBbJzmHHoBlKVQ8Nfz7cnJeaUtyYpMya9enDrE3v57v/ZgQZ3v/ym9suDuTwkA7viWzk6cDqXnN39O34JMY8kglWCSF4Z7KBDFiGFsVkdZQe95XzGKe14zJvNuiWFR8YFuexNNfm+6axNIH5ic+mAdyGF8hEGl2GJcksvJ6tmTAxrXUjQ/WMlJFuOLGhSK167kBNpsg06w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5JKYii1uf9xlhb2w33Cctrf3IIZ5BGWE2YXD+FPta8=;
 b=Z0O2ywPLB35L/WkBB8fniFA6D2OAgknfhZovQk7jOzK45YTAIWl7GOZKTDnDT1/B6AR4tEgHdN9WzbmBGyfRGdCrF13qtmMzrri2C7wVt3srgVTR882vr3suj9mbbMRkq/8nHumQnGDybm6stEOfE5HV2EPIYXjjTBNQ8Y1WxbKhzvEqPOlpfuVeNoDvz/dV+H83MZIXytNTfjad1fRyyTMJLfKFQazhcP1+WfkL2rtZy4ZfZ3Okx/sQGzt2nG2i+XCeknZpoFz/66t+c/4X81gPJ9y2wUZC6uQQvI5XUxnEh/s/8w/mVkm6yGRHKoSgJMkXalsO3asA7d2Q/BFGKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5JKYii1uf9xlhb2w33Cctrf3IIZ5BGWE2YXD+FPta8=;
 b=5D7cA4GLdyZszM79EkSYkOmvQJXBp8v38lX7srHjvUmU28RwGmzGFEEuRutL9EDfaT9GrQgHbsBWuVaMW33jVSmo15tw3ythQ5WEW7rQSED0CXccWVUQgRUx4P8E0cbhQAtmiu9q70+lZjRybBSpOHZNIwGANk+ZtvOpN3nA4a8=
Received: from CH5PR03CA0008.namprd03.prod.outlook.com (2603:10b6:610:1f1::26)
 by PH7PR12MB7455.namprd12.prod.outlook.com (2603:10b6:510:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 13:32:43 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::88) by CH5PR03CA0008.outlook.office365.com
 (2603:10b6:610:1f1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24 via Frontend
 Transport; Tue, 9 Jan 2024 13:32:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 13:32:43 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 9 Jan
 2024 07:32:41 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Xu Yilun <yilun.xu@intel.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Moritz Fischer
	<mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Tom Rix
	<trix@redhat.com>, Wu Hao <hao.wu@intel.com>, "open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, kishore Manne
	<nava.kishore.manne@amd.com>, "open list:FPGA MANAGER FRAMEWORK"
	<linux-fpga@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: fpga: Convert bridge binding to yaml
Date: Tue, 9 Jan 2024 14:32:38 +0100
Message-ID: <14558a4dcfab5255c1683015287e9c7f48b1afc2.1704807147.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3365; i=michal.simek@amd.com; h=from:subject:message-id; bh=fbDvCVZMcXbli+cahBo0JkyQwl0qjc4ji23GaPpIRqY=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtS5Xm9XvzpTWpDacyxs7ects6oeWxv/Wvjcyalr34/81 x2Tz9671hHLwiDIxCArpsgibXPlzN7KGVOELx6Wg5nDygQyhIGLUwAmIiDNsGDyVbEXnvM/eFbd kK+cyJfkMoGhOYlhfqW7+QKp3vXF6gzMm3YynDPidxD4AwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|PH7PR12MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: ff8ca087-1238-411c-87cf-08dc1117759d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	THMFov58dEaUNIIJ96EfKsmbOdFQnJXseqsdM5weJ3ybQ8bh7S8kvla4AFvCg0/DAG+TOb8Za3rjvtocj1naJBKIEUZTB2qRwK+LGes6H1h8csqsZNDFoRB8KwLqSwZGry0TyZSN+z+Lx1dlQpgK8+ZSRYq9ifFKoSgMWkYuMQtgROUGNlukQ1DM3wgmuWAkoqXGoesstZFfTpSGYfn/oIzNAJA8uWVH55TGszG6oYQev7QXz6yrZSU0gFRveO2iA/TGjkv9Lsl08ZD6ST1mILAR/E7Zw0UH32joZ/xdLqnm7NRWqheKYIMMN0/6yuxymb0PLYFKaKCgOS+saW9q1rPBZHf1wkURp611iPZcTh5RyYIPgzCKtRolXClt9kF/ZUR4+tCOHIMdf9qUs7rb5PTApH1Vf3+4ymAlX9TvHUymZnxUrKP0UIlCQkITkqckm40t6JI1Vl+iiGgYccIT934Pa3PyoKsbEhkJc2m/FyWf6CCMRBsUgyrFIyTvd3WFVc1HXqGzoLUsh5sQDT0qRVuD3NFLXLKRmuFER6wPaQj597aUnU4JUtGhtIhnYdbiprQVXMbllCKBIRE8gyEfcD1LAFvLwpbmpGbLIIECYROqqNSLOa4AVAqHZSOMz1Rf0t3o8uRI9RgQIaeaidsRAZXebJ8rzTzeq42Cpj/7OqNPD+/aoziqQAvHHebQc2SJChKPoOHvH+oKVhcLZttS6fbo/3s13sxZG7xWBowvq8OUP9pXRRL17bNAYlrccZynFMEVMSyghevy1af04mOD+R8a3WnUSqBovFBtREaNPwo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(2616005)(426003)(336012)(26005)(966005)(478600001)(6666004)(82740400003)(36860700001)(356005)(2906002)(36756003)(86362001)(81166007)(5660300002)(41300700001)(4326008)(83380400001)(47076005)(16526019)(7416002)(110136005)(70206006)(54906003)(70586007)(316002)(44832011)(8936002)(8676002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 13:32:43.4164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8ca087-1238-411c-87cf-08dc1117759d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7455

Convert the generic fpga bridge DT binding to json-schema.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v3:
- Improve regex to cover also nodes out of bus

Keeping Krzysztof's tag which I got in v1. Feel free to reject if you
see any issue there.

---
 .../devicetree/bindings/fpga/fpga-bridge.txt  | 13 --------
 .../devicetree/bindings/fpga/fpga-bridge.yaml | 30 +++++++++++++++++++
 .../bindings/fpga/xlnx,pr-decoupler.yaml      |  5 +++-
 3 files changed, 34 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/fpga/fpga-bridge.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/fpga-bridge.yaml

diff --git a/Documentation/devicetree/bindings/fpga/fpga-bridge.txt b/Documentation/devicetree/bindings/fpga/fpga-bridge.txt
deleted file mode 100644
index 72e06917288a..000000000000
--- a/Documentation/devicetree/bindings/fpga/fpga-bridge.txt
+++ /dev/null
@@ -1,13 +0,0 @@
-FPGA Bridge Device Tree Binding
-
-Optional properties:
-- bridge-enable		: 0 if driver should disable bridge at startup
-			  1 if driver should enable bridge at startup
-			  Default is to leave bridge in current state.
-
-Example:
-	fpga_bridge3: fpga-bridge@ffc25080 {
-		compatible = "altr,socfpga-fpga2sdram-bridge";
-		reg = <0xffc25080 0x4>;
-		bridge-enable = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/fpga/fpga-bridge.yaml b/Documentation/devicetree/bindings/fpga/fpga-bridge.yaml
new file mode 100644
index 000000000000..1ccb2aa18726
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/fpga-bridge.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/fpga-bridge.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: FPGA Bridge
+
+maintainers:
+  - Michal Simek <michal.simek@amd.com>
+
+properties:
+  $nodename:
+    pattern: "^fpga-bridge(@.*|-([0-9]|[1-9][0-9]+))?$"
+
+  bridge-enable:
+    description: |
+      0 if driver should disable bridge at startup
+      1 if driver should enable bridge at startup
+      Default is to leave bridge in current state.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1 ]
+
+additionalProperties: true
+
+examples:
+  - |
+    fpga-bridge {
+        bridge-enable = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/fpga/xlnx,pr-decoupler.yaml b/Documentation/devicetree/bindings/fpga/xlnx,pr-decoupler.yaml
index a7d4b8e59e19..5bf731f9d99a 100644
--- a/Documentation/devicetree/bindings/fpga/xlnx,pr-decoupler.yaml
+++ b/Documentation/devicetree/bindings/fpga/xlnx,pr-decoupler.yaml
@@ -9,6 +9,9 @@ title: Xilinx LogiCORE Partial Reconfig Decoupler/AXI shutdown manager Softcore
 maintainers:
   - Nava kishore Manne <nava.kishore.manne@amd.com>
 
+allOf:
+  - $ref: fpga-bridge.yaml#
+
 description: |
   The Xilinx LogiCORE Partial Reconfig(PR) Decoupler manages one or more
   decouplers/fpga bridges. The controller can decouple/disable the bridges
@@ -51,7 +54,7 @@ required:
   - clocks
   - clock-names
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.36.1


