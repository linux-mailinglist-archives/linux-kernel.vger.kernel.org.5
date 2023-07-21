Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6CA75D179
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 20:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjGUSm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 14:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGUSm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 14:42:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC642E62;
        Fri, 21 Jul 2023 11:42:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTyU7cM88aLBKdjdjIurhsHyG0YzZruKPSSxsQIXTMM0TW+CpT1xjlq46W95jwF4UaeLFwm8kaRs1QC+HIrHuxhL3BfxzrxhQykUHNCf3rewYBddC+HlYbGO+iUhugZ67YEijVVti/0t2PltBg+Ctzw7MoFUyXeDE0u5U3Ped5yI7q6kNHTV8NBdmr82orVdbufeikp7IEvP3P484J7g0vbZN3GERqO56w/4u/nc1+8xbRqYm3PKuZyOmG1eh3K/+iXOtpruPcgvxPwXunrpo3UgnJARoZsNvdTBXkjA2512zfiuXtwvW5jJmckryxI13SQ60lYZ/QqrnavjYHuRpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAgQYY2VEylhe9xhcUyMUSvejM0M1Eu1N/oiTcfctyQ=;
 b=VZ30933kcbDVV9ZAclt6Dro2CTjFZOW9grQd/BzPEunzveXhcbVJF56HtIN4LTmRUfP/uhZtAMC4HCDSMTjw6VoHZqceG+Ns6jBDv6ekQTpT6H8bxCH53vzADKGIUfev1Dcd45b8bLP3v8BYSFwLVOfY5vQXrk1/ZTsVBR7AuwHBqcueW0j/mY4To4wGYL+SdOz+Ix1umcA+4s9IMD+2+oDycLQUb64xVyI06w5PzxcrM0TG/Z7ntqsq8coYkh6PNypnrL/Z9qcD3miDcnwziPE835fB32rHq8RyF6sivDfxODvFfDdTBuwSPsbop8XDXRg9xNdZbPsVahuiROlP3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAgQYY2VEylhe9xhcUyMUSvejM0M1Eu1N/oiTcfctyQ=;
 b=aSU0ZHVCvt5e4niMefzkKxZFcg4ioiAkxzBb88uLqGVzFUptJg+rFFe3jsnAzTs2hqvsC67JBM+vZke2GqYoN0J0DL42Re/jiMROd+6CfBXL1EPXuG6TPKT1VY14/kgD0sQJi1vHmnYNgrKStAWz4Dli3ETKSIi8TkEevMWKIBI=
Received: from DS7PR03CA0175.namprd03.prod.outlook.com (2603:10b6:5:3b2::30)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Fri, 21 Jul
 2023 18:42:23 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::9) by DS7PR03CA0175.outlook.office365.com
 (2603:10b6:5:3b2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Fri, 21 Jul 2023 18:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.25 via Frontend Transport; Fri, 21 Jul 2023 18:42:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 21 Jul
 2023 13:42:21 -0500
Received: from xhdvnc102.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 21 Jul 2023 13:42:18 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <ben.levinsky@amd.com>, <tanmay.shah@amd.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v3] dt-bindings: remoteproc: add Tightly Coupled Memory (TCM) bindings
Date:   Sat, 22 Jul 2023 00:11:48 +0530
Message-ID: <1689964908-22371-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: c8619fad-913c-4c5a-1791-08db8a1a38dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0djd558Vcx17PbL8/OdXGV4+O/7/GaYuTbqjntx2ZPkn6Ly/ZAKMq5x1/V3NbmYSHdZ9g5U2s1KEKw/hcFwdFXU1EKO81Dsh8/Ue2TWff/Fzr10XMLn9hZtxeAX6TLmqn4tD4LqxEvPuRXVslKNgw3lhL1DbkzAk5qeY1vs/4gl/sTjLSTOcaMVIgmZgbFmTzfUEKntn/pqdf/wn44j0vNEGoISFjUyt5frO7KuKz2mIeyEfK7nHlKokiHTdwcbCN5Y6pP5h+4Wln9vhbVkKqdB9nz0JDutQphJ2HA6CYw11r9LmDwuAGouP1CZO8CrKc4Uz3GwqAQDJ5MErjZTXTjof0udYPdwBgr8zuao032n92BMcJsh+n2awIp1bTcpFNN1yUp5rUBSLSnJSDRqUwZ2GvaZjva7CBvrvWwTvznKaBOminUSWsHej+Dl5xa5Y3ofvuuwxBmNaBBT8cdWNBv7wEqH0T/tkwxxS/+F9NiEXzXuQ1xeppBgheafggjxgISA1jcqtPT0SCivN++buqLH1/ZXuglzLwOdZ+cUulughtYKDqK969OHof+byLDvS6KbKQDbmds/dQ5PrtPeiwv4ZIyhOgAb6yZDVJIWG4AHCz5aQ11D0EdyyRPXTKmF9aep61Ok1PnklUrAe/6vZOH7/fmnzRDBT/8XXNGP9520flTKLobBucSGWCU1gpAyHym2dR96r036U/T9f3WX5GrufJBpo1w9m6Yt9j42r1SoBpoyi4xZFipJ0gQ0r57LdlAvoh9J19MLBT8m1riJGuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(8676002)(81166007)(40460700003)(356005)(2616005)(47076005)(426003)(186003)(26005)(70586007)(4326008)(6636002)(41300700001)(316002)(6666004)(2906002)(70206006)(5660300002)(36756003)(110136005)(8936002)(54906003)(40480700001)(478600001)(36860700001)(83380400001)(82740400003)(336012)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 18:42:22.9134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8619fad-913c-4c5a-1791-08db8a1a38dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
X-Spam-Status: No, score=1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
Changes for v3:
- Modified commit description to document that reg/reg-names are
  made as required properties and add justification for it.
- Drop 'Address and Size of' in reg items description.
- Modified commit description to remove driver reference.

Changes for v2:
- Add ranges property to r5fss cluster node.
- Use regex "^r5f(@[0-9a-f]+|-[a-f0-9]+)$".
- Drop address/size-cells and ranges from r5f core node.
- Mention "reg" and "reg names" as r5f core node required properties.
- Mention address/size-cells and ranges as r5fss required node
  properties.
- Modify commit description to remove ranges from R5 node.
- Rename r5f node labels(r5f_0 -> r5f_0_split/lockstep and
  r5f_1->r5f_1_split/lockstep)

The inspiration for integrating TCM nodes in R5 nodes is taken from
"5ee79c2ed5bd dt-bindings: remoteproc: Add bindings for R5F subsystem
on TI K3 SoCs".Once the binding is reviewed/accepted will send out
driver changes in follow-up series.
---
 .../bindings/remoteproc/xlnx,zynqmp-r5fss.yaml     | 90 ++++++++++++++++++++--
 1 file changed, 83 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
index 9f677367dd9f..43089b0e8a39 100644
--- a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
@@ -20,6 +20,17 @@ properties:
   compatible:
     const: xlnx,zynqmp-r5fss
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
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
@@ -102,31 +124,85 @@ patternProperties:
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
+    #include <dt-bindings/power/xlnx-zynqmp-power.h>
+
+    //Split mode configuration
+    remoteproc@ffe00000 {
+        compatible = "xlnx,zynqmp-r5fss";
+        xlnx,cluster-mode = <0>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0xffe00000 0x10000>, <0x20000 0xffe20000 0x10000>,
+                 <0x0 0xffe90000 0x10000>, <0x20000 0xffeb0000 0x10000>;
+
+        r5f_0_split: r5f@ffe00000 {
+            compatible = "xlnx,zynqmp-r5f";
+            reg = <0xffe00000 0x10000>, <0xffe20000 0x10000>;
+            reg-names = "atcm", "btcm";
+            power-domains = <&zynqmp_firmware PD_RPU_0>,
+                            <&zynqmp_firmware PD_R5_0_ATCM>,
+                            <&zynqmp_firmware PD_R5_0_BTCM>;
+            memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>, <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
+            mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
+            mbox-names = "tx", "rx";
+        };
+
+        r5f_1_split: r5f@ffe90000 {
+            compatible = "xlnx,zynqmp-r5f";
+            reg = <0xffe90000 0x10000>, <0xffeb0000 0x10000>;
+            reg-names = "atcm", "btcm";
+            power-domains = <&zynqmp_firmware PD_RPU_1>,
+                            <&zynqmp_firmware PD_R5_1_ATCM>,
+                            <&zynqmp_firmware PD_R5_1_BTCM>;
+            memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>, <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
+            mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
+            mbox-names = "tx", "rx";
+        };
+    };
+
+  - |
+    //Lockstep configuration
+    remoteproc@ffe00000 {
         compatible = "xlnx,zynqmp-r5fss";
         xlnx,cluster-mode = <1>;
 
-        r5f-0 {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0xffe00000 0x20000>, <0x20000 0xffe20000 0x20000>;
+
+        r5f_0_lockstep: r5f@ffe00000 {
             compatible = "xlnx,zynqmp-r5f";
-            power-domains = <&zynqmp_firmware 0x7>;
+            reg = <0xffe00000 0x20000>, <0xffe20000 0x20000>;
+            reg-names = "atcm", "btcm";
+            power-domains = <&zynqmp_firmware PD_RPU_0>,
+                            <&zynqmp_firmware PD_R5_0_ATCM>,
+                            <&zynqmp_firmware PD_R5_0_BTCM>;
             memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>, <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
             mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
             mbox-names = "tx", "rx";
         };
 
-        r5f-1 {
+        r5f_1_lockstep: r5f@ffe90000 {
             compatible = "xlnx,zynqmp-r5f";
-            power-domains = <&zynqmp_firmware 0x8>;
+            reg = <0xffe90000 0x10000>, <0xffeb0000 0x10000>;
+            reg-names = "atcm", "btcm";
+            power-domains = <&zynqmp_firmware PD_RPU_1>;
             memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>, <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
             mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
             mbox-names = "tx", "rx";
-- 
2.1.1

