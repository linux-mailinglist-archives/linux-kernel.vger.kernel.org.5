Return-Path: <linux-kernel+bounces-20509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1491827FF5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F7F6B257B4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9152511CAF;
	Tue,  9 Jan 2024 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rXdZ45by"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3B1B671;
	Tue,  9 Jan 2024 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SY/UIv32jMDPVAldUh44gwM7f1ZIvkrLA55lQvUfex4fvtDBEQTKk0VzLrmrf1dP8xD6QqJN70K8w4ONp5QWbw65OXdh+EdijoINgrVloUd2L2FnGfaeH0q6BpoAIoCS2wlKTzlLOsvAe9O9JJS58kAGxgfvrDgS/h/xoTO4Wlct8xi18CjsGU4/b7b1in+T0RqIRmHkVlZhLvlB7mE3k1Nb22wax53416mOJpm98IMdi/S9VOnLW7V+SUvCvKQuxciD6quU0IRPA5Cn9xReqYMdvdCMmaaOnTVvxh5TzphotKMwFS2y4IXdfO380LU5C0Pg23ZOZTYUsXQ00fxbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=No8xZSXNf7q+H/H6+wrUIpgop+QcIZ4y1csZnRTe1Yk=;
 b=Vk8aGAJFdgNalXh3RVdbrDdbQbeyWxShOLnwAfmGJJ8JJOd6H0MEn/FkjbN2tf1B3OeLalLNQPoV5dQ6laHnVY2MKU5qfPkCwu87THtwzMDF0q4xo1XIc2CvagMnhl063+DoUR1ZkI741uqXOucvLAHNCJqypLwVb70Es00FN/jiG+6f6psjTJB6Eda4tou0Gpb7sde2aMIQOYlqvZgyMh9r3+tu1+yr++6xvRWAyfA/vpcfHuH5QTl8zudWvoUqTXfChm3wcbdPAdrGV/B353PvflJymW6jjrEE7HfTwjbypYRIEVvhHHTXC/wB4YR//x9z05yyJ+zjAGmAAFXxNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=No8xZSXNf7q+H/H6+wrUIpgop+QcIZ4y1csZnRTe1Yk=;
 b=rXdZ45by3rHMmQiZOVjKFdQ6GfyEDEUy7q4tKdgYzf1K78O8EdPcAUH/1ZTzjfGeLla2ACn/X+WffqFIuvptBPbU6XLtN9LpzI56jrGJPPyfaRLpUry0OOtVqrYsHO3zgmmi3nGb1C3i46p3Yceiehtt/JHUP5wH9goffBi0LXk=
Received: from SJ0PR13CA0012.namprd13.prod.outlook.com (2603:10b6:a03:2c0::17)
 by DM6PR12MB4958.namprd12.prod.outlook.com (2603:10b6:5:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 07:59:20 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::28) by SJ0PR13CA0012.outlook.office365.com
 (2603:10b6:a03:2c0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.16 via Frontend
 Transport; Tue, 9 Jan 2024 07:59:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Tue, 9 Jan 2024 07:59:19 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 9 Jan
 2024 01:59:11 -0600
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
Subject: [PATCH v2 1/2] dt-bindings: fpga: Convert bridge binding to yaml
Date: Tue, 9 Jan 2024 08:58:46 +0100
Message-ID: <5740b48543a94b7e2cde04acfca06f4e5eb5d981.1704787119.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3203; i=michal.simek@amd.com; h=from:subject:message-id; bh=sgsQVsMYHGsdTbWNLKcM3aBLMFTsG9CaWeKD2lYN6vM=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQ5fzbuT7y6Ul8ljsXgqdfSR/uOTzgloF3waz0rz5EDh 3jVOrJOdcSyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJdHUxzJV+vYtnel1ObFmP 8YULjywTtkfz32eYH+mS8+SgqeV2s+26p2VbPC7e2/12CQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|DM6PR12MB4958:EE_
X-MS-Office365-Filtering-Correlation-Id: eb60997f-6d5d-4e13-9d80-08dc10e8e285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XCJzfoTLTDhAFoODa2+x7DYPZ4Z0siTqkcCOJz8xPP+bY2U1FFn5QJmIIdeFlw2ipJCeBwBo5w05lTfiZp88V9jFXSqKP8vp0UURYhXLLrKbe0Eq5RJvqPVjZYdxS4PebpYRHGmMLD+3dthMD7X03Hnqs1tZA8o8U3BkofB8f1pWS45K4K8bgypKhbxEE708ZqB5LBVy35mwrfqOoZr/q2qJfWTr/XP/b7kCKOCaZ6nwtQkvDmHnIOhHyRd06ciNgW7BumyL4BtRSyA+oiGC+Nrm9Vlg8NWAtPr98Gj2OTu1h0mtIXGbiD2DGbQlE1LGANPrkMrP6TnHcxoRS7I0/Mk+IDbxsewxLcI11qG+JjjoA5m0zLSmd/tqunDDgyvNwaTzFxAM9Yf18UnVsY74g1u2p3fSjvZ6fJt0Lt+KLtHsL7gA5B00+R3gPpxOEn9/Sk9UtjyxnIU8gQ7HuR4TaU7TitF8ypwCnx84WxOtNVoayouajN84afay4S50K/sryV7qmkFrA1QJVqtCDJuNZnMKNn/ADnVZ4e7nNIyBZpjVhBIxxX8Fx0H/kq7UOQd8TjmyPP7Up1PA6kZHIAEgNq5JqxM8ja9neNpMib1iDBoDNcSVAalzJP+AjNrlyWv7Pei5uF8rxSFNmuZa3oGxWGl5uSGPOL6SAN6fcom5V2rXWX/c+adwcZUKdYIkYIvoRIXpDnUfGcdDL/UaO/mzw5Ff8J9t/fPnoy5yfgzsOXg7EZ60ukiWQ7S3QuWDSrBDsjyYsUYDOXJPPiS8hMIyR52Ht0F14K2BRqVcByoMoTqcPxrN+kJE3e19iM5lghaf
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(451199024)(82310400011)(186009)(1800799012)(64100799003)(36840700001)(46966006)(40470700004)(16526019)(426003)(83380400001)(336012)(47076005)(40480700001)(26005)(2616005)(36860700001)(4326008)(44832011)(6666004)(40460700003)(478600001)(966005)(82740400003)(356005)(316002)(54906003)(70586007)(70206006)(110136005)(8936002)(8676002)(81166007)(36756003)(2906002)(86362001)(41300700001)(5660300002)(7416002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 07:59:19.7382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb60997f-6d5d-4e13-9d80-08dc10e8e285
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4958

Convert the generic fpga bridge DT binding to json-schema.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

(no changes since v1)

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


