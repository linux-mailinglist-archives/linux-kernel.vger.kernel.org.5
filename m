Return-Path: <linux-kernel+bounces-1845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C178154BD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542631C240F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2726A4B126;
	Fri, 15 Dec 2023 23:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="klU/fb/F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC65F487AB;
	Fri, 15 Dec 2023 23:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkZtXONloI+5blOFep4FqVDYBwi60vCjBHFvqpeFu/ifWtjx3mgzugJrW+W/QurejxSebbpureARA7BaLsQ6CKcICSalhvWsSI3I0JyuUP0MMS5uoQnhbBcanZjocjP+KGZ6GJxuM+6EOef10rDS1SMp/atmh5oY0lyTNLF/FDnKn0Uu/kMv5dINVpHGIyGqI3q5Ip6hwGqtmVaxQww33H6/Byvms9l6rnIZI4Ckmg57eLqjEgpV7Usx3uhlQQXwgBjz4RranO/LNf10Gk+6HeaM330gjLdwbBlNBgM8fLrhqINt6Q6Y6TsElm+RZ+vcqXbJVw344EQ5zBJu5WofRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iq269o5QOQbJhUiqAzKMEPjpeVXDjObs0TmQ+z0/BiA=;
 b=N0kZ7T/xK6vIYIgX7KEnJz51ol1IsVBQnNhUI5uMnlwJxy1KTP+4e0u0/sb5CZW/Fuj5McsVmKUvKD9/skIDMnHU76QnvWGiNztq7WzajhtirL4x0Iuyc1JJmPqxTOp9r1dT8ygGziCviUQAtgg2E9KB7BN3mRfflyz9pQGA2sqXLa9+PZBU4Z73hhH044qUShqs0tsT4geGDj18seK6GeIok9bkec5sR8Ds9CBnJAgiYYDDqrsSfYyPqwl/MtP6v+0rhKHmxIzZBZ1B7C9oyr+SbsIRSzgGUH6utUnkxw24mnHqVv4EECV7Hy6ZvdYxRQgRGWiL+ldQ2Uko+lPLbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iq269o5QOQbJhUiqAzKMEPjpeVXDjObs0TmQ+z0/BiA=;
 b=klU/fb/FoEgxYhafDWrP9KBYMnX2vXXF9JvTyKyiKQMgxai0RchW9RWxaivWvUNTUrw3Pnlp67ZF5oXjoN0UTuJ/vITxM+MEA+OiyAcFY8rXT41v0L6M4Ze0U7Do6o57wLlvfjRgYMYCJyfDMrVU3RpNFwpGnwIH3M8xgwrrjNg=
Received: from MN2PR05CA0041.namprd05.prod.outlook.com (2603:10b6:208:236::10)
 by SJ2PR12MB8134.namprd12.prod.outlook.com (2603:10b6:a03:4fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 23:58:32 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::3f) by MN2PR05CA0041.outlook.office365.com
 (2603:10b6:208:236::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.13 via Frontend
 Transport; Fri, 15 Dec 2023 23:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 23:58:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 17:58:21 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 17:58:21 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 15 Dec 2023 17:58:20 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Rob Herring
	<robh@kernel.org>
Subject: [PATCH v8 1/3] dt-bindings: remoteproc: add Tightly Coupled Memory (TCM) bindings
Date: Fri, 15 Dec 2023 15:57:23 -0800
Message-ID: <20231215235725.1247350-2-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215235725.1247350-1-tanmay.shah@amd.com>
References: <20231215235725.1247350-1-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SJ2PR12MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e1894a-e354-4e25-1e31-08dbfdc9bdd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ccOuA/YWF+N4wOfffE3x55apNe9sXMjbN25TaZ2qzagyv5kWNe/2+wnE1gMhz27m/wDLbTicRBkC36AX6R+u4WqiUQel40OCxMdN+qM+W3lX6zI+8HipA7neg8rguq2Eq3IYt7cImHjzwbNCKMnf68tSrq7qyj9CqB7X5T9yftvxAh+9i6LAb/yoUk8c8GyKh7wbqZ5N4Nq/ggpkEoJXQV106GpLFVLtKXmW+qiAJDEO5JZFzku9AHu10WVKc7g+hmyRhCRnWFjWtW+Vs1mYy8BPih69jlcQTxx8H/Yc3s161b5e0zDY4pj2ne4N8XT2gH9vRgXbATTbTUeTB56rkvBkyAyW6FbDhzw+Hb7IVckHUwvhY2PEGT+AuPPbs3vpIvRAl1UVrIGb41oijDgK9bQYXrorNUt2/J/6fHwFc/l6r+v+al+is+B485V0aFNpDr7kWtnWysKk+WgoRKTH8GWAjNTvcV7qGk0xfQj0Y8nW5cbbf2kR52fYa8iC3vGzPuy+Og0/0fDQAqQLtAPmpe2gcn6hd6IZLuRkQ1l5QiDkb4eFBi5RkiG7PRIdgOuUVHIJgNiSIjq/arF3TDtcgorPddX9edOkihC6Q5R8Nc7qlN8DSpm0ra5TDypQh7SNeoYxhL1WB+CNc/ZETNBONCc/ma3/ljBMKycjJmvCMxogrVuauW9SlCfXK+e6FQNqwv+b6omnC8REv6eaPqFd79K8PeTiwCCuB0n7dDUXJFoswtQLHbcGtJCwgyzbvU18XIiKKnssLIle3TLG0wsuUg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(7049001)(40460700003)(36860700001)(47076005)(81166007)(356005)(82740400003)(2906002)(7416002)(36756003)(5660300002)(83380400001)(336012)(426003)(1076003)(26005)(2616005)(478600001)(54906003)(70206006)(70586007)(41300700001)(86362001)(110136005)(4326008)(8676002)(8936002)(316002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 23:58:31.7571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e1894a-e354-4e25-1e31-08dbfdc9bdd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8134

From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Introduce bindings for TCM memory address space on AMD-xilinx Zynq
UltraScale+ platform. It will help in defining TCM in device-tree
and make it's access platform agnostic and data-driven.

Tightly-coupled memories(TCMs) are low-latency memory that provides
predictable instruction execution and predictable data load/store
timing. Each Cortex-R5F processor contains two 64-bit wide 64 KB memory
banks on the ATCM and BTCM ports, for a total of 128 KB of memory.

The TCM resources(reg, reg-names and power-domain) are documented for
each TCM in the R5 node. The reg and reg-names are made as required
properties as we don't want to hardcode TCM addresses for future
platforms and for zu+ legacy implementation will ensure that the
old dts w/o reg/reg-names works and stable ABI is maintained.

It also extends the examples for TCM split and lockstep modes.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 131 +++++++++++++++---
 1 file changed, 113 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
index 78aac69f1060..9ecd63ea1b38 100644
--- a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
@@ -20,6 +20,17 @@ properties:
   compatible:
     const: xlnx,zynqmp-r5fss
 
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  ranges:
+    description: |
+      Standard ranges definition providing address translations for
+      local R5F TCM address spaces to bus addresses.
+
   xlnx,cluster-mode:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1, 2]
@@ -37,7 +48,7 @@ properties:
       2: single cpu mode
 
 patternProperties:
-  "^r5f-[a-f0-9]+$":
+  "^r5f@[0-9a-f]+$":
     type: object
     description: |
       The RPU is located in the Low Power Domain of the Processor Subsystem.
@@ -54,8 +65,19 @@ patternProperties:
       compatible:
         const: xlnx,zynqmp-r5f
 
+      reg:
+        items:
+          - description: ATCM internal memory region
+          - description: BTCM internal memory region
+
+      reg-names:
+        items:
+          - const: atcm
+          - const: btcm
+
       power-domains:
-        maxItems: 1
+        minItems: 1
+        maxItems: 3
 
       mboxes:
         minItems: 1
@@ -102,34 +124,107 @@ patternProperties:
     required:
       - compatible
       - power-domains
+      - reg
+      - reg-names
 
     unevaluatedProperties: false
 
 required:
   - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
 
 additionalProperties: false
 
 examples:
   - |
-    remoteproc {
-        compatible = "xlnx,zynqmp-r5fss";
-        xlnx,cluster-mode = <1>;
-
-        r5f-0 {
-            compatible = "xlnx,zynqmp-r5f";
-            power-domains = <&zynqmp_firmware 0x7>;
-            memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>, <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
-            mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
-            mbox-names = "tx", "rx";
+    #include <dt-bindings/power/xlnx-zynqmp-power.h>
+
+    //Split mode configuration
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        remoteproc@ffe00000 {
+            compatible = "xlnx,zynqmp-r5fss";
+            xlnx,cluster-mode = <0>;
+
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
+                     <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
+                     <0x1 0x0 0x0 0xffe90000 0x0 0x10000>,
+                     <0x1 0x20000 0x0 0xffeb0000 0x0 0x10000>;
+
+            r5f@0 {
+                compatible = "xlnx,zynqmp-r5f";
+                reg = <0x0 0x0 0x0 0x10000>, <0x0 0x20000 0x0 0x10000>;
+                reg-names = "atcm", "btcm";
+                power-domains = <&zynqmp_firmware PD_RPU_0>,
+                                <&zynqmp_firmware PD_R5_0_ATCM>,
+                                <&zynqmp_firmware PD_R5_0_BTCM>;
+                memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>,
+                                <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
+                mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
+                mbox-names = "tx", "rx";
+            };
+
+            r5f@1 {
+                compatible = "xlnx,zynqmp-r5f";
+                reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
+                reg-names = "atcm", "btcm";
+                power-domains = <&zynqmp_firmware PD_RPU_1>,
+                                <&zynqmp_firmware PD_R5_1_ATCM>,
+                                <&zynqmp_firmware PD_R5_1_BTCM>;
+                memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>,
+                                <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
+                mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
+                mbox-names = "tx", "rx";
+            };
         };
+    };
 
-        r5f-1 {
-            compatible = "xlnx,zynqmp-r5f";
-            power-domains = <&zynqmp_firmware 0x8>;
-            memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>, <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
-            mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
-            mbox-names = "tx", "rx";
+  - |
+    //Lockstep configuration
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        remoteproc@ffe00000 {
+            compatible = "xlnx,zynqmp-r5fss";
+            xlnx,cluster-mode = <1>;
+
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x20000>,
+                     <0x0 0x20000 0x0 0xffe20000 0x0 0x20000>;
+
+            r5f@0 {
+                compatible = "xlnx,zynqmp-r5f";
+                reg = <0x0 0x0 0x0 0x20000>, <0x0 0x20000 0x0 0x20000>;
+                reg-names = "atcm", "btcm";
+                power-domains = <&zynqmp_firmware PD_RPU_0>,
+                                <&zynqmp_firmware PD_R5_0_ATCM>,
+                                <&zynqmp_firmware PD_R5_0_BTCM>;
+                memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>,
+                                <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
+                mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
+                mbox-names = "tx", "rx";
+            };
+
+            r5f@1 {
+                compatible = "xlnx,zynqmp-r5f";
+                reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
+                reg-names = "atcm", "btcm";
+                power-domains = <&zynqmp_firmware PD_RPU_1>,
+                                <&zynqmp_firmware PD_R5_1_ATCM>,
+                                <&zynqmp_firmware PD_R5_1_BTCM>;
+                memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>,
+                                <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
+                mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
+                mbox-names = "tx", "rx";
+            };
         };
     };
 ...
-- 
2.25.1


