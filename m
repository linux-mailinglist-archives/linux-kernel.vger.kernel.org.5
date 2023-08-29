Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234AC78CBF7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237160AbjH2SUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbjH2STg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:19:36 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED7610E;
        Tue, 29 Aug 2023 11:19:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EARdRv12NTXkRP2T++vHIy0l1mbAkHa8Yg9vmE7dDnYs1CxpWTNAkvGL+1FfTB9eNp/NfNWZgRMQ9IGuqzWYBM0ugHFpGOveEv5OxZZif7TJlL2bD75K0WIJ5pMv3X4mrgWGijcEHc52owMzh9rFxVmVolRPEPt6j9cMjFRjkQMpb7OZ3AHOxAlYPyrmnd3j7ssCfgYWkrR2SFpaY69wOI0UdtN/29k3foPlW3hWJv8+qFLJIT/EejNfYEh0FfLcmYtCjYAO6GEemirwHSHuLl4iN0IeZRzg9UKYXYzWg3jtz582lsf24M/NIuxevCF+H/zF/0MMReykWd6ho1B20A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jw2l1rmpGUOUnfzW6VuBknEAU8lwZEnwz3yhJLEMEw=;
 b=Vhngk7NWD5a4it8Iif+NaIAtEWdCCceCibFEZIz2tgeEWOTYJQ4Y1NNMq8POElaTpskdguwOsd2EV/6zpU8/2OIUVKevS0zi0esZfwvcSPP0lDspYrdS11D+SXmCnOGK8hRb4uD3kRwWS+iOt1DYgX1LN7l+O3vzyhzqQ5EhTLEIFKL/geQ4t9cGrjR1+G27/gFP7Z2LMlGD3R+mlZMYWLbtPgoAKkMF8rbCzaFpXLyxCD/Sd/2cBKfuEDa+wIx2YTibQB87OIsxT2n1gcxassa03CMz3wiKjmyQg230UiHwhj3VDMc8IyPeXavCg0Q9kCc+XRvPftKop+l+JtIZ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jw2l1rmpGUOUnfzW6VuBknEAU8lwZEnwz3yhJLEMEw=;
 b=5VJVevkSBe6W6mg3qrpV3jK1GfiPbB4MyBCj2KXcxCE3VpfJ2pVmv/t0bEf5nv0saQNbl1Ovi4SJ43SF7JWntf9Zp760WySQAVaRBRZ9I5cGlX4kz1rL3c/8XhsE8cPF1D4+c8qBd80VK6FE2T6aB2clt9V63Eu16WvEQtz6bNI=
Received: from BY5PR20CA0009.namprd20.prod.outlook.com (2603:10b6:a03:1f4::22)
 by PH7PR12MB9067.namprd12.prod.outlook.com (2603:10b6:510:1f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 18:19:29 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::8d) by BY5PR20CA0009.outlook.office365.com
 (2603:10b6:a03:1f4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Tue, 29 Aug 2023 18:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Tue, 29 Aug 2023 18:19:29 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 13:19:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 11:19:11 -0700
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 29 Aug 2023 13:19:10 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@amd.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Ben Levinsky <ben.levinsky@amd.com>,
        "Tanmay Shah" <tanmay.shah@amd.com>
Subject: [PATCH v4 1/3] dt-bindings: remoteproc: add Tightly Coupled Memory (TCM) bindings
Date:   Tue, 29 Aug 2023 11:18:58 -0700
Message-ID: <20230829181900.2561194-2-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230829181900.2561194-1-tanmay.shah@amd.com>
References: <20230829181900.2561194-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|PH7PR12MB9067:EE_
X-MS-Office365-Filtering-Correlation-Id: 96cbccf7-c807-46b5-3044-08dba8bc7c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d0AZFjJoxA1as1+jCG5K0PMcJewwDmbx84gt6HFCCsgt2CRlcIvhS5xz59B0lEuegoybJv1fMWFg/9WZF6/ottAkDwQA1vqh+S6odnZGgjT80j1N2d7qzIFHAhZy01L8+1VRZIHZHPvPiZKjB8DjQSRdALre7Pn/7i8MVwMiIZMj+OOFPZ75oTIbqLtyR6IcaEc3328bzjeh4UO1/vEL6uiMbwG+6gNsnJWRSL7eOXdZB9irVBE6UYcS/fgXhT2IlqGRQRuqjD1mdQ2R5+X6uXpfj9HzbR1OFXLrRYWejqJo1vNWR2+DMvcDJucf3bmVjQxamwPf3jM40je3pbKzKa6LUhpyROpeqxutRadOqLXwb8dGNZHypAKXjmGYOIJKU2BAgdrx73SnA+wdH4wav5ZRYYyk/gBDMMAXPUtT74vrP3XyTGBGk9B4GV2+MalqbvJ5s2tQ95LcloDmJalhkcOrM//+n3o3UMVgIo1uGFvgYdtkdsMwpaZIynOp9jCgz2A3/cxn0iGyNeR67affArfwp+7O0SrCT8lJRgErAlAvLNxviklLTO1wgULWGHcV5s6NEY7gBNTvpEri2YJP52NyQWmubpc2+EuEhARTKTAOBbSpUMA31L6F5piHY5F/FAp7+/xKXdGZAmRLTiOQV4gxuX7M7y8Oqco7Yn48dgBIbMXQXXyDlClXLY1kiCQDPwvDKsrrWtpKL3BBu5TBZ7P2xMPCFmg9eU5u0mcroG4PikueAY8DXWrEo1RqmYB9rYSY7U22ged8mQqHCX+ULPagKYUbyyzsmAyPMDdqV98=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199024)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(40460700003)(316002)(6636002)(41300700001)(4326008)(336012)(426003)(47076005)(83380400001)(2906002)(2616005)(86362001)(26005)(36756003)(44832011)(1076003)(5660300002)(8676002)(36860700001)(40480700001)(8936002)(6666004)(81166007)(356005)(82740400003)(54906003)(70586007)(70206006)(110136005)(478600001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 18:19:29.4049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cbccf7-c807-46b5-3044-08dba8bc7c4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9067
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

Changes in v4:
  - Use address-cells and size-cells value 2
  - Modify ranges property as per new value of address-cells
    and size-cells
  - Modify child node "reg" property accordingly 
  - Remove previous ack for further review


 .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 131 +++++++++++++++---
 1 file changed, 113 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
index 9f677367dd9f..5622767305fa 100644
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

