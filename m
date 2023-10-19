Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903DB7CEFDE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344684AbjJSGHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjJSGHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:07:41 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7704512F;
        Wed, 18 Oct 2023 23:07:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9AJCQGB1KePpW/pjGve7F9P6HAEnjmr1Zt/efER19UCX1yvZ0EfVLjLFiO3rUC9GaqnkkvRRqy18JiL7PaAcX+JLj+qBuAest64KoY7hBbb5Vqsd30jWevyPhMc0NCXOcixk1iGCAF5VtgsOupaDt9UYs1YOd1WFi9qFUoPZqPRTGDtagk78TwyAuaFy7NJZx/VIpZmJ/B6PHk3maGqNfO0HybbpKfFDjzx7h3icS703EoIhVx92M3wF7VM8jHlJSMb79mGEyXXoOHelPbOq8cx1MZNVRkWgg2KmuvGK6a0paM27bYhUFFGz1mnFZRX9ZYRdo2XbALDuQdJTgbWFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ll4I81xW1/NJc4tfzPSMQL5Qj1sLQg8pyA7nRndIY7o=;
 b=DQTyu4fdvpp0UWYhUZqlijdAA1jHnZYWS1pBH/mlNApWNgGh3VXpPvlznp+mGuO6ailubj/vYnTRVoXqOTFdxgsYidy9Y9fXraPSQ1J6ANxNcBuIo85GVOwomE3QExMulDqNZeN29PhH5RS87zMGKqh26cNtmSslgE9i5s+m8Z8o0+l9Nr6r76rI7qeF7Oj99Anltr7sgosq3HINWf8xFf44IBsfGMpsEfSoWFdO+5USF7jLVyeROmTXtWjp6PNNW8VYdSlOPtcPFkdaozrrx1LZPPh1O1WHW7aVkzV2zjNlATSz9k8ZN4ifMzejQmROg/07hfDBiEkuc7Z1ExPrBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ll4I81xW1/NJc4tfzPSMQL5Qj1sLQg8pyA7nRndIY7o=;
 b=sJAFGLzl34K0+FegUjTHDXTMkOlazSYo4kP97lLaapFfEHocam1H5xpmMD5Uk4WgpN6a02sd2oc3Q9R0O9tvzGBbMbqHzxmrBz040M6eKAv+IlfmKt2Ve2tF3Q7YUieT5bYYzGkuiczTPN6r2PCDoUfqGG2EZb3xHXmrW+hQdl0=
Received: from DS7PR03CA0219.namprd03.prod.outlook.com (2603:10b6:5:3ba::14)
 by SA1PR12MB7197.namprd12.prod.outlook.com (2603:10b6:806:2bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 06:07:37 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::f3) by DS7PR03CA0219.outlook.office365.com
 (2603:10b6:5:3ba::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Thu, 19 Oct 2023 06:07:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 06:07:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 01:07:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 01:07:23 -0500
Received: from xhdharshah40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 01:07:21 -0500
From:   Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <praveent@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 2/5] dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to yaml
Date:   Thu, 19 Oct 2023 11:36:48 +0530
Message-ID: <20231019060651.23341-3-praveen.teja.kundanala@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231019060651.23341-1-praveen.teja.kundanala@amd.com>
References: <20231019060651.23341-1-praveen.teja.kundanala@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|SA1PR12MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f57b66c-e0d3-40dc-7a28-08dbd069b143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JLuvl3I09Jr3LQpbFR+m1Z9wRam7dfj/icxD6nBtrK/uj/7rDf8p3f9yjabkB0qMY/xczaKQxWHoL7MOfASU42oED/ti+vqOuqGguR+qd0JI4gOIsl+lA8Z3ci+0UGFvwDt79jxdEmSlmf8KUt6EMM8S9yzEFNeq7zO2Qp+S//qOZjGNxtGLhoTc3IFmxiI2CGzxJTddbMixaFlzJZQM0ul7w7HCAgz53SWz17gy7Pa/6QcS1TuceJIx/C5V6WeMN9qejfNaQfbMFRTnf+iSJe2Q+dvAGUhnlfjufmplKOdibulsbWCuX+9CB0kbAQa+as0IVcV75kfqLrit5eW9lObwoc4ZCxiP0uMSlFgz/xhDIo9rNJjxf7SMUi/6wdsiP8JgriZ7jOlI0JjyuMm37Cr8hircPA0c9ToayXowxnKuxbxe177Vix8Fcoj9qIxnZSknGPSb/PPGBV/BJTc1KJ8b91F6vDzwXvmdJIb/8TybmfawJ+dM8Due4gFsuI36sD2nhSR8XbyXabsdKX+/64UXzT+VFdrzdWqJvO4LMpynPZj4P2zIk2UjGPClDG6ZDUB4LI47/2fi6dNr1TOHkArjxsQwtN2weLOfZTZuLmHxFFJ+MaVDSuA1FmSK7S/WCXjLlT6+Hb3agT5/rGTKekegGrPNJJzidyGQ/WitICpMWXgpO+uN1hR4OJybQ/0h9GNMZcWQMIUbKoTATKQIVz8WeupaXTK05zTtS2/Qw1itW7A1xSQJGnEeuWBuLyCqfiNfhtM3jAF4CNrSnSiWFzhdtbPRY75Zg5DeWpvUqI0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(2906002)(40480700001)(36756003)(478600001)(110136005)(70206006)(70586007)(316002)(8936002)(6666004)(966005)(8676002)(41300700001)(103116003)(4326008)(86362001)(5660300002)(47076005)(36860700001)(2616005)(426003)(83380400001)(26005)(336012)(1076003)(356005)(81166007)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 06:07:36.6096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f57b66c-e0d3-40dc-7a28-08dbd069b143
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7197
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the xlnx,zynqmp-nvmem.txt to yaml.

Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
---
 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt      | 46 -------------------
 .../bindings/nvmem/xlnx,zynqmp-nvmem.yaml     | 40 ++++++++++++++++
 2 files changed, 40 insertions(+), 46 deletions(-)
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
index 000000000000..5d20362a0615
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
@@ -0,0 +1,40 @@
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
+    like SOC revision, IDCODE and specific purpose efuses.
+
+maintainers:
+  - Kalyani Akula <kalyani.akula@amd.com>
+  - Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    const: xlnx,zynqmp-nvmem-fw
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    nvmem-firmware {
+        compatible = "xlnx,zynqmp-nvmem-fw";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        /* Data cells */
+        soc_revision: soc-revision@0 {
+            reg = <0x0 0x4>;
+        };
+    };
-- 
2.36.1

