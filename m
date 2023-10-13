Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6287C82D6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjJMKPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjJMKPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:15:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A7BC0;
        Fri, 13 Oct 2023 03:15:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpNwkYR073DgP3ioCPzFYzwZzrCvW2TS+4vTVbRkztyKzRDkxhzOOCm5Jfrj3Y8wsfs7K8/6bB3IxoyzkcX//OXFcgrL54NhNP46uArtuiq+q7ohliaWvR6RAOSblbL4+TKGWRXXCQQFDNYLtxTxf8AcMlmA/7x5tjT6H5miU/na2NZPHh3U2t2UWCD3al65XLx3q1vmNveBWM8CR4J93nkjeVSySwSUTz3ZzJ38JBnojmNnYpPouup2vtJqbc1deT0yWP6+S24xzt2eK5UCHXZJH3IJq6AIKLNnUn5Tt0DBDay6q2erKMXvojXiuu1/19YAP314R+fZqsq/o2mZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=METhKhQvMOTZF6vjMillbwIoUKU267ppH0f9uY07vdc=;
 b=iZnJTUE0UchQer3w9LFBBWo/ZETD/R/c6Pi0J2b0NHBcvxg992AEtQGxK1vg/fiSylb0rM7Qy8TLRKBR/0erN7aKRiJph1z1UtHNTB0Z7BfOKPZF5gXmYFf1fYfmRmFaUohl9h0o7Ky1qN2Gnpb6gcUmZdM5CXpRYkXrzYkujPQoN2yQ660Wb0+rF555G/4GGMDuG8j3U5XliF5pcBYC4uETWIj/zMcZo82lxatbNf14RYVUVPoxhbarck6UEVEeocKS8kO0d9eU07hyjdm+Iy6kJtq8cbVREEhDvIk49VlA9GB8U5GRAGyFkxjMy7ao5DLfEwpWoG/GT9W+ELkHnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=METhKhQvMOTZF6vjMillbwIoUKU267ppH0f9uY07vdc=;
 b=oVqaZ12LtUmqi6sYyKa1OfjoY4fDGbR4i/qi6zLSH0FGSEIc5AtpGc7uoPuGbo9E+htt5irpDwBFf/SZGLZI3cRp6psQ7TAPpb9KDbz0hA19nng2SIEjHA1eOQpjlyQ66wNAw1kxpDILBtY/vKSMHPjaI7sjtAyCVvKMx3AnYuc=
Received: from BL0PR02CA0137.namprd02.prod.outlook.com (2603:10b6:208:35::42)
 by PH7PR12MB9175.namprd12.prod.outlook.com (2603:10b6:510:2e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Fri, 13 Oct
 2023 10:15:19 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:35:cafe::db) by BL0PR02CA0137.outlook.office365.com
 (2603:10b6:208:35::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 10:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 13 Oct 2023 10:15:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 05:15:18 -0500
Received: from xhdharshah40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 13 Oct 2023 05:15:16 -0500
From:   Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to yaml
Date:   Fri, 13 Oct 2023 15:44:47 +0530
Message-ID: <20231013101450.573-3-praveen.teja.kundanala@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231013101450.573-1-praveen.teja.kundanala@amd.com>
References: <20231013101450.573-1-praveen.teja.kundanala@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|PH7PR12MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 863e3791-be11-4309-98f6-08dbcbd54d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZayeKAlUw3bQ6Di/DS6EpvX+3DBNOHHbToi9ryc+qLfy00Lons9VqYeD3vh6xarm9jw4RVZSkyMqAfXbgX5c4OFtFHt7Z2dTqfjknjSwe0v8E/QpOQ3iWhIvZDZSPZ9a9zbFzZFZtVtferUEnBQB8X8WeYAS/cSu4xjJDku61IglKPLnfhrtq/DEAZ1fzw178lhSVbZDyFeypiw4AyMkkvdfOK/0svxCy1rnbHhrpt3mk291witFeTvbKj/XsPAhwbt7boGBql9vY+aM1VsRtRZqW36q0mI5NWugZjeW7T4FChdrxAHmDedO9+dBXbZ3ff+0ki+dNRBYscvG4gPOB87kMz/p0c1Knv9ftEklOdCC/q6eMU/3PWJf6YYGAZFXQep5Ay0psJyyBRE5PzqC2AVNkTbZ628sUJuSvSiVk2Q3qq34KRfR4C6XiOXsWK/LAf/rb3KUM/d1dXbsy+0nX1CV9EFYSkde8pKvUaPOJ777XcZN+jvV0w9OZuXwbqNMjw92aJSfANcTOu7E53ah2sv8VErry+9W6GlHIlSuMxNqViduyVSv6FeqsPPMUt/amWOS8H0U83p6G/ELxZKATdP1KDX/HcoN6f88j8S2mzj5Xy9vMXF/kh0RHufj+hPyFZVyb49XQQPQTFxvINekvEYdo8MXLfm4sVodNZuk4voBBW9BM/nbid9qiy3QwTWbK9o9Vyh9xsQ7ctwt37ACnmutOdZEtwZSbmwV27Gd2N1OXdn7reGSoLx/ijoSbtnL5WU0NHD50nn+lW0f8A3m65vkMGASiVktrkbM1qonf+4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(82310400011)(40470700004)(36840700001)(46966006)(336012)(26005)(41300700001)(40480700001)(110136005)(40460700003)(426003)(36860700001)(478600001)(86362001)(36756003)(47076005)(6666004)(1076003)(5660300002)(356005)(70586007)(70206006)(316002)(82740400003)(966005)(103116003)(8676002)(2906002)(4326008)(8936002)(81166007)(2616005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 10:15:19.2251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 863e3791-be11-4309-98f6-08dbcbd54d8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9175
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the xlnx,zynqmp-nvmem.txt to yaml.

Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
---
 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt      | 46 ---------------
 .../bindings/nvmem/xlnx,zynqmp-nvmem.yaml     | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 46 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
deleted file mode 100644
index 4881561b3a02..000000000000
--- a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
+++ /dev/null
@@ -1,46 +0,0 @@
---------------------------------------------------------------------------
-=  Zynq UltraScale+ MPSoC nvmem firmware driver binding =
---------------------------------------------------------------------------
-The nvmem_firmware node provides access to the hardware related data
-like soc revision, IDCODE... etc, By using the firmware interface.
-
-Required properties:
-- compatible: should be "xlnx,zynqmp-nvmem-fw"
-
-= Data cells =
-Are child nodes of silicon id, bindings of which as described in
-bindings/nvmem/nvmem.txt
-
--------
- Example
--------
-firmware {
-	zynqmp_firmware: zynqmp-firmware {
-		compatible = "xlnx,zynqmp-firmware";
-		method = "smc";
-
-		nvmem_firmware {
-			compatible = "xlnx,zynqmp-nvmem-fw";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			/* Data cells */
-			soc_revision: soc_revision {
-				reg = <0x0 0x4>;
-			};
-		};
-	};
-};
-
-= Data consumers =
-Are device nodes which consume nvmem data cells.
-
-For example:
-	pcap {
-		...
-
-		nvmem-cells = <&soc_revision>;
-		nvmem-cell-names = "soc_revision";
-
-		...
-	};
diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
new file mode 100644
index 000000000000..e03ed8c32537
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/xlnx,zynqmp-nvmem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Zynq UltraScale+ MPSoC Non Volatile Memory interface
+
+description: |
+    The ZynqMP MPSoC provides access to the hardware related data
+    like SOC revision, IDCODE.
+
+maintainers:
+  - Kalyani Akula <kalyani.akula@amd.com>
+  - Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    const: xlnx,zynqmp-nvmem-fw
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+required:
+  - compatible
+
+patternProperties:
+  "^soc_revision@0$":
+    type: object
+    description:
+      This node is used to read SOC version and IDCODE of ZynqMP. Read-only.
+
+    properties:
+      reg:
+        maxItems: 1
+
+    required:
+      - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    nvmem_firmware {
+        compatible = "xlnx,zynqmp-nvmem-fw";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        /* Data cells */
+        soc_revision: soc_revision@0 {
+            reg = <0x0 0x4>;
+        };
+    };
-- 
2.36.1

