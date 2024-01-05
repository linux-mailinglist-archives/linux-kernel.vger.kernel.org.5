Return-Path: <linux-kernel+bounces-18039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 442308257A0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CFC81C230A4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9340F2E832;
	Fri,  5 Jan 2024 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U/kQjokS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C3D2E830;
	Fri,  5 Jan 2024 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLfWjdoqIkw6j+4AlgcsXk9k1GS1Ut3gRDRN+erMZtCuFyWWbjyWdZ9gYwIVGUcfkWpEk14AnD5oMbfkcZFQ2A3K/jov/lRSEzY67i7Ibw93yqfsk+5G7loaa0ro6ot4j8UeXJcTNrTE83V18PT52JVy/iw3jV5Dj8ReH09sZl/xqTfovTHAsUNG6vdm6KlpATs8Kp6yReCUCyVqnP+EyzO3u9/VfGlMEDOa7ZoZwP/jfHyas7OHAUVAs9DXFCrG7INCaw3actBPgU/vYk+gttNyBRu0q1dZUS8sqylElcMYmuMhT9cHv0LRibdJ14t8N2uW8v7yLGlhanvhBALbFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtuRjlzYwEIpxgAr3PIHK2oW+P5Ti6saz5aE2rN+rT0=;
 b=EBstcYbw02ICJR2p5UDL000nALixIt6LsKat2fT5CRMBHhfpabLdRywoAGVPJAbY/ouGbqav0Qpj4HzVKmWtVmy3HgbjG8GPdS/F6VwljWxLfSKJmN2zoVGPn0O9WbS+z2r+VW4oLqdYbE6JXV5PV6Q+n2at58GwyURgUGtz+JaioLsiGjejicuS/jJofMfhuP3B+S4s+1xMOjwhqXF3MnCCvefsK+pQX5Y7qoPHsaNEJp/YzijuTxP2TXTlKk1zzpLwl0AoKwFCdwT8ybGwoQeqBDieLuH9rcpHEw6WiU8qvUD36O61mOyPwmEa7PPMaUl0YQqU3JT9NhQ6yB8VvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtuRjlzYwEIpxgAr3PIHK2oW+P5Ti6saz5aE2rN+rT0=;
 b=U/kQjokSMKfx8n4+85isDQMvW3socXPnAdLCIYAE3A/E+5c958kMSIQtm/Bn+7tJW3aqTFFsoJK853qjoCcvrVbl/VLGsnxjphJOwJRQcw4c2ZCOxwdNzd1fq07B96XVXhRhc9pVbxOTiMdLr2y50ZDw3rTUftDtL0ru1PZIp7U=
Received: from SJ0PR13CA0090.namprd13.prod.outlook.com (2603:10b6:a03:2c4::35)
 by DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Fri, 5 Jan
 2024 16:04:36 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::2) by SJ0PR13CA0090.outlook.office365.com
 (2603:10b6:a03:2c4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16 via Frontend
 Transport; Fri, 5 Jan 2024 16:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Fri, 5 Jan 2024 16:04:36 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 5 Jan
 2024 10:04:34 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Moritz Fischer <mdf@kernel.org>, "Rob
 Herring" <robh+dt@kernel.org>, Tom Rix <trix@redhat.com>, Wu Hao
	<hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "kishore
 Manne" <nava.kishore.manne@amd.com>, "open list:FPGA MANAGER FRAMEWORK"
	<linux-fpga@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: fpga: Convert bridge binding to yaml
Date: Fri, 5 Jan 2024 17:04:30 +0100
Message-ID: <3100bbc4723643ec1ec7d4548e9ab353c856b564.1704470663.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3067; i=michal.simek@amd.com; h=from:subject:message-id; bh=1+pja7gve2RD/A25TFvY3eQ+jegU0ltRdf+bA2DYUuY=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQZGp07P5ysWRzK7Xv1+Rmb960v7aWjgj7Fu/huTX/UN 2GN/IVpHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAi8/4zzJWezlTuPcV3wj+u mmiD9wIvmXnSwhjmV1e++698o2ZVvKeNW/Ty/xOO9UQ/AwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|DS0PR12MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c3a84a-072a-4260-5573-08dc0e0803b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rldPkZw0YVFbUXu20G9x3vnlkofGR5xblvPa3mwbtbnET2iJ8sbhESEEZuzTkTcO3nLx2q4GY/6EkfLPkEePNN/ah3xCtS1xnEYOMnOVLQrOnkTJa9AgcxW66cWJ9jT934/X/PygvhgPK1h/uJKE7sAjruskzEaj51oimB5sn9peyBwh1kZgRd3DdqcltEPcDeYLLqXNy/+QWXefKERLvb8IGUTi/xpsH4xMiPjpVD4Pix0n0e3O5ylVGjkM6brlV1ZRMy+4x0O+Ct/3uF/3eGRL44ZwZwQ5Fi63GVacx0n0++B3ogvv/I6EqZSUWRSV/R7RS5QhuHZ8CATyEFx4511j+jqMsQJDbG6xkmhi0mp90Ak/3USUZJ0WHyRy61HwulaUEwrLmPy0XG0BkW/P2qH2s3+hpHLdjmUzC8dueQOP3NqQW6oBTHajYYTLrM/kCHDn+YFc0LjhBjOOz5jha3SDgPhraG/Z5+3cJcSjJFwzt6nY7AYhYYBOTSFInxqvKMWUy7bl5Ov03+A7p3wf304HI/AN4Pnf5uEkQAX2U6hw0vw89HGIDUk1V+aYBmXDh2nGrHTlIyr7OZefunjw0wcVZdeqHFy9TdKvL2VdAcuIY8Y+ENRphdn+VIaYJDE8Y4qKmXSg2OdhsGpZGxnnRVTmuQteLH0qyh4dQYkAcreUWiOsbzziw/PjONCeaLVBD07kfgzm2x698uf2I7AF8aSGlTWQe2LeVL4TBKkryyKEjGMvpfkzx9F0f+x2jRhIgyfn4Eg9aCXsOhgoXrLfAlYD7/XDnDosRIKf50LAwZg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(426003)(16526019)(336012)(83380400001)(40460700003)(26005)(2616005)(6666004)(47076005)(40480700001)(81166007)(966005)(356005)(86362001)(478600001)(70206006)(316002)(54906003)(82740400003)(110136005)(70586007)(36860700001)(44832011)(5660300002)(8676002)(4326008)(8936002)(36756003)(2906002)(41300700001)(7416002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 16:04:36.2973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c3a84a-072a-4260-5573-08dc0e0803b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341

Convert the generic fpga bridge DT binding to json-schema.

Signed-off-by: Michal Simek <michal.simek@amd.com>
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
index 000000000000..248639c6b560
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
+    pattern: "^fpga-bridge(@.*)?$"
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


