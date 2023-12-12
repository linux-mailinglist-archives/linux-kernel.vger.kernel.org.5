Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E3E80FB01
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378078AbjLLXFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbjLLXEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:04:43 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49227D5;
        Tue, 12 Dec 2023 15:04:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iX/cnt96mUGtB6J6oCZQxVFVJvCoy/N7odnljoLN/QDEMDKs9Rikr/tiEnG4GPXwsbqLqXwZcRhBFOQptLwtnySysBPO4R1rWsWafob7kh9pyNEN/rQu1YGLA90YTZjNtivS3oDmBGd6GtuVosYnks6eVorG4JMpEGsIGo945ezO8kVnilF1NRAGIAS9JSRjdNZE6pUoSb4UNXK757hZL28OiwCyW8EMLUfBD837JseUmEm7iTlr7O+3qIb4j4PjuMsCMD41v+ha0AC/9GWi08UzFhjHiwZvs7eJsrm3xyICE4Qfb1G14AT5H1KVYmeEZ2c8PQcgumpwOx9QyM1n5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCjSUP0kFmO8ijoS/cG9NVHgbKLNzd/6v6tGWWUpD58=;
 b=mQqdGqK2Dvl0Jb88dbK29AlLxoW3QW0G+vbBYSr3Yqn+DKjS5RiPJHLinqsAc8fOsNBXEejfpWU2lQI6sGc6qJD0v9anI45zqJNBDaVfAGLLNi/wzVQYopBgNCVUi+pPIZt+XC/E8xlR3od+uRITy1MJ9zGJYFYiWS31jxBQ8ld9SzR6asH0fpqhVE/GWzUuG8PZftvXDPeBYCVx1J4GGjonQf19E3pSwM8KMZ0Mvo6Jb5D4tsdgN7mJJRquRzOMgSDAvB+eAmHjZMCgHj+nfu9mYBw5f90KrmSvPZLF9nAM2LNdLFbIXfWF7Q7aDp3OZ9UtbPs7GcSRj0qM65MikA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCjSUP0kFmO8ijoS/cG9NVHgbKLNzd/6v6tGWWUpD58=;
 b=LTtkPwASz+ydsE8jj9FVo5lTzFaBxqhGkNuL9S98Sfs2WyzPDAyexUdxos3qeLMNA+PLRB/YTkOmEUjhp3XbRTmD4DnLQ8U1ohzrFeLD5rmEpf0DsTCiMO+gMdzu6FiN867+3DJKVcVtsSQXBzUMR0H+CcpvsutIxoSHQdrd88o=
Received: from CY8PR12CA0064.namprd12.prod.outlook.com (2603:10b6:930:4c::10)
 by DS0PR12MB7678.namprd12.prod.outlook.com (2603:10b6:8:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 23:04:18 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:4c:cafe::7a) by CY8PR12CA0064.outlook.office365.com
 (2603:10b6:930:4c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Tue, 12 Dec 2023 23:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 23:04:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 17:04:17 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 17:04:17 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 12 Dec 2023 17:04:16 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <shubhrajyoti.datta@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v2] dt-bindings: mailbox: add Versal IPI bindings
Date:   Tue, 12 Dec 2023 15:03:53 -0800
Message-ID: <20231212230353.888714-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|DS0PR12MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: a51a0163-f11a-4e2a-05cc-08dbfb66ab8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MgRcncq247eGxvwJuubNyW4L2lhf8bAgE3l518SwW5W0kw1SnaAJojQvIqz23D5SzmVXaaWrRcCArOHAFjGcmolyB/6vbr7r2hDhpX3iMVnqpmwPfgBpqwINomM16a6vp65vdnpxA+1iUxPqCbeU6nvAevzypXKkEnM7bzNsFHBW5VtE3VvLkKSUsfOPvv7bms0EaclNbd4Cuh6Vu4amG6HxT4lW6FglE64+XkUI0JBlDdCzWs0nX3Y5/b+NkBfN2Yu8U/35gYjrsPCUNEB/Sdjn54CxCFvATf7rE1qI4CP8fEq6S9ojBr7KOCv7o4mMjSOSIhrcnbOaqE4gZ0Cg05UOdZx/5v9E7ws8gVA1HW6+qLCNk44valM1vFSWhIjc1aqsDH5Z+yVxEgoxDM5TBsXiZo86xZSb6Ywnb7xbp4465kww5ii1Fi6BF/ZHWly7sMbFfojtCM995rlqajwagrsPGli7WcpViJcae4gOpH2KO3tTH4lWNswILp+cVA8I3JgcCJiHeML2I0Cj2o/lR8a9wIeddOjPxn9cCxIUpbhGL7pTbtingBD0a6zwNDSEDYsAvSsBZ25pVsuSfbrrdNcTKNeZelVpAXVZvG6R2j/8gxTrSSNcmYPVCnoGv36fsyLWk0bxINLL51Vni4tIVF4+x0OXfLwBx5/qR3bpPElEA8xBTQxX5BPyfDmitBsdQpn9Dj8X3rsLo4GWyDtQnP91ITptUC0GIeczSqKfTXlQZEy3d41OHcfNhSBU6Dtm
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(1800799012)(82310400011)(64100799003)(451199024)(186009)(40470700004)(46966006)(36840700001)(6666004)(2906002)(6636002)(70206006)(54906003)(44832011)(356005)(81166007)(36756003)(86362001)(8676002)(4326008)(15650500001)(8936002)(316002)(5660300002)(40480700001)(478600001)(966005)(70586007)(110136005)(40460700003)(1076003)(36860700001)(82740400003)(41300700001)(26005)(336012)(426003)(83380400001)(47076005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 23:04:18.5345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a51a0163-f11a-4e2a-05cc-08dbfb66ab8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7678
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for AMD-Xilinx Versal platform Inter Processor Interrupt
controller. Versal IPI controller contains buffer-less IPI which do not
have buffers for message passing. For such IPI channels message buffers
are not expected and only notification to/from remote agent is expected.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changes in v2:
  - Add versal bindings to existing bindings doc instead of separate
    file.
  - Sort required list same as properties list
  - Add minimum and maximum range for xlnx,ipi-id vendor property
  - Move vendor property last in the list
  - Fix description of child node reg property for versal bindings
  - Change commit text

depends on: https://lore.kernel.org/linux-arm-kernel/79f65b96-9015-41c4-b4ee-a82526c9eefc@linaro.org/T/#meeacc5c57a9610b19758d313e5b2d17ab470f646

 .../mailbox/xlnx,zynqmp-ipi-mailbox.yaml      | 172 ++++++++++++++----
 1 file changed, 138 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
index 8b15a0532120..95146adb9631 100644
--- a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
@@ -8,11 +8,11 @@ title: Xilinx IPI(Inter Processor Interrupt) mailbox controller
 
 description: |
   The Xilinx IPI(Inter Processor Interrupt) mailbox controller is to manage
-  messaging between two Xilinx Zynq UltraScale+ MPSoC IPI agents. Each IPI
-  agent owns registers used for notification and buffers for message.
+  messaging between two Xilinx Zynq UltraScale+ MPSoC and Versal IPI agents.
+  Each IPI agent owns registers used for notification and buffers for message.
 
                +-------------------------------------+
-               | Xilinx ZynqMP IPI Controller        |
+               | Xilinx IPI Controller               |
                +-------------------------------------+
     +--------------------------------------------------+
   TF-A                   |                     |
@@ -37,15 +37,13 @@ maintainers:
 
 properties:
   compatible:
-    const: xlnx,zynqmp-ipi-mailbox
+    enum:
+      - xlnx,zynqmp-ipi-mailbox
+      - xlnx,versal-ipi-mailbox
 
   method:
     description: |
       The method of calling the PM-API firmware layer.
-      Permitted values are.
-      - "smc" : SMC #0, following the SMCCC
-      - "hvc" : HVC #0, following the SMCCC
-
     $ref: /schemas/types.yaml#/definitions/string
     enum:
       - smc
@@ -58,16 +56,26 @@ properties:
   '#size-cells':
     const: 2
 
-  xlnx,ipi-id:
-    description: |
-      Remote Xilinx IPI agent ID of which the mailbox is connected to.
-    $ref: /schemas/types.yaml#/definitions/uint32
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  reg-names:
+    minItems: 1
+    maxItems: 2
 
   interrupts:
     maxItems: 1
 
   ranges: true
 
+  xlnx,ipi-id:
+    description: |
+      Remote Xilinx IPI agent ID of which the mailbox is connected to.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 64
+
 patternProperties:
   '^mailbox@[0-9a-f]+$':
     description: Internal ipi mailbox node
@@ -76,57 +84,116 @@ patternProperties:
     properties:
 
       compatible:
-        const: xlnx,zynqmp-ipi-dest-mailbox
+        enum:
+          - xlnx,zynqmp-ipi-dest-mailbox
+          - xlnx,versal-ipi-dest-mailbox
 
-      xlnx,ipi-id:
-        description:
-          Remote Xilinx IPI agent ID of which the mailbox is connected to.
-        $ref: /schemas/types.yaml#/definitions/uint32
+      reg:
+        minItems: 1
+        maxItems: 4
+
+      reg-names:
+        minItems: 1
+        maxItems: 4
 
       '#mbox-cells':
         const: 1
         description:
           It contains tx(0) or rx(1) channel IPI id number.
 
-      reg:
-        maxItems: 4
-
-      reg-names:
-        items:
-          - const: local_request_region
-          - const: local_response_region
-          - const: remote_request_region
-          - const: remote_response_region
+      xlnx,ipi-id:
+        description:
+          Remote Xilinx IPI agent ID of which the mailbox is connected to.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 64
 
     required:
       - compatible
       - reg
       - reg-names
       - "#mbox-cells"
-
-additionalProperties: false
-
+      - xlnx,ipi-id
+
+    allOf:
+      - if:
+          properties:
+            compatible:
+              contains:
+                enum:
+                  - xlnx,zynqmp-ipi-dest-mailbox
+        then:
+          properties:
+            reg:
+              items:
+                - description: Host agent request message buffer
+                - description: Host agent response message buffer
+                - description: Remote agent request message buffer
+                - description: Remote agent response message buffer
+
+            reg-names:
+              items:
+                - const: local_request_region
+                - const: local_response_region
+                - const: remote_request_region
+                - const: remote_response_region
+        else:
+          properties:
+            reg:
+              minItems: 1
+              items:
+                - description: Remote IPI agent control register
+                - description: Remote IPI agent optional message buffer
+
+            reg-names:
+              minItems: 1
+              items:
+                - const: ctrl
+                - const: msg
 required:
   - compatible
-  - interrupts
   - '#address-cells'
   - '#size-cells'
+  - interrupts
   - xlnx,ipi-id
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - xlnx,versal-ipi-mailbox
+    then:
+      properties:
+        reg:
+          items:
+            - description: Host IPI agent control registers
+            - description: Host IPI agent optional message buffers
+
+        reg-names:
+          items:
+            - const: ctrl
+            - const: msg
+
+      required:
+        - reg
+        - reg-names
+
+additionalProperties: false
+
+
 examples:
   - |
     #include<dt-bindings/interrupt-controller/arm-gic.h>
 
-    amba {
-      #address-cells = <0x2>;
-      #size-cells = <0x2>;
+    bus {
       zynqmp-mailbox {
         compatible = "xlnx,zynqmp-ipi-mailbox";
         interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
         xlnx,ipi-id = <0>;
         #address-cells = <2>;
         #size-cells = <2>;
-        ranges;
 
         mailbox: mailbox@ff9905c0 {
           compatible = "xlnx,zynqmp-ipi-dest-mailbox";
@@ -144,4 +211,41 @@ examples:
       };
     };
 
+  - |
+    #include<dt-bindings/interrupt-controller/arm-gic.h>
+
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+      zynqmp-mailbox@ff300000 {
+        compatible = "xlnx,versal-ipi-mailbox";
+        interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <2>;
+        #size-cells = <2>;
+        reg = <0x0 0xff300000 0x0 0x1000>,
+              <0x0 0xff990000 0x0 0x1ff>;
+        reg-names = "ctrl", "msg";
+        xlnx,ipi-id = <0>;
+        ranges;
+
+        /* buffered IPI */
+        mailbox@ff340000 {
+          compatible = "xlnx,versal-ipi-dest-mailbox";
+          reg = <0x0 0xff340000 0x0 0x1000>,
+                <0x0 0xff990400 0x0 0x1ff>;
+          reg-names = "ctrl", "msg";
+          #mbox-cells = <1>;
+          xlnx,ipi-id = <4>;
+        };
+
+        /* bufferless IPI */
+        mailbox@ff370000 {
+          compatible = "xlnx,versal-ipi-dest-mailbox";
+          reg = <0x0 0xff370000 0x0 0x1000>;
+          reg-names = "ctrl";
+          #mbox-cells = <1>;
+          xlnx,ipi-id = <7>;
+        };
+      };
+    };
 ...

base-commit: abb240f7a2bd14567ab53e602db562bb683391e6
prerequisite-patch-id: 70017c8eaded5fc85749995b9cf093c6c625fab3
-- 
2.25.1

