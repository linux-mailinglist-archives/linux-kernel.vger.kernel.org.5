Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD05F81270E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 06:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443185AbjLNFnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 00:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443204AbjLNFnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 00:43:18 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6C4F4;
        Wed, 13 Dec 2023 21:43:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtGV59TqivlRGhgQ9ba9zjOxnwhGTZFmzMemH+RfFXIEDRlrQBNUTHKyfzvXsUBTsyBNnKxv7X6UwPYiA8q6J3r3LPCYWFd+xHwdZVWABnnLSbmSxSPducRzAApL8DLV2KJ5eovhRUUGOafNpAESGdasSGa8h1SJbVddH9EHsTKyaKWkOmi1KrCQ0ly5Euee5Rz7jtrKHQnPeLDMMSHCZkOwkoZjLm3wvShcoKLggOsyXYirDUhms209V551RmrEMplo9r+Kx72h4z6TiJKl8MeergPmmXjM6i4GTlLOmyY1lRYDLLjCDAtFT6ob691HguPMk7dyq9LAM/zUZgfWVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xe4Bzl92G8N1fReGiPBEmvCi4wMm92+2s+v4ekvvjRE=;
 b=O4a5opsrhRMLBKjn+IKQLokA9jU2epidFGjy/46XK0eD28x2ZlFe9qVO8DrHWp0LY809Tmgz2RWjcyV+i13ZHaZJ/Xx/MxFaWsT6XYajQW7D8jgKaMVSlTMqlLrUepdlWVDGiDvVi/iTF7XoQJ0SaJwOw+ntOX4WAY6BadChP/jqCUgaDCtv6tUexVREjqJ1RSt5iXYNtxPNi8g3c7OMP6PjBCZi9Vg8I+alKMCH9P5KStAAJnRONNY8lWvHMyghBLh7yaaKnqtoZUW9IdpVsZQrLRPMSnbvM1IynyPZ/DNvoqoLb/Wwv91iEUMcyGeUJmpQEdV3opL/NPSXYgIpfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xe4Bzl92G8N1fReGiPBEmvCi4wMm92+2s+v4ekvvjRE=;
 b=qCWsExiPVyKl/UbsKG2exbq4FxKrvim0UGl3SBRUjZqTWcZ3UWmX/p6pONsVqvEs6jQoLip6nOF4rhTur33Mye1yE3IqdxPK3XfOPyd77RHqSk77JMwJDPCh0J/KOXQcXzfkGt9BWddFjffmxuT6KP1wtsBwwKiZvRyu1qzAlt8=
Received: from MN2PR02CA0036.namprd02.prod.outlook.com (2603:10b6:208:fc::49)
 by BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 05:43:21 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:fc:cafe::e7) by MN2PR02CA0036.outlook.office365.com
 (2603:10b6:208:fc::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Thu, 14 Dec 2023 05:43:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 05:43:21 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 23:43:21 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 13 Dec
 2023 21:43:20 -0800
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 23:43:20 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <shubhrajyoti.datta@amd.com>,
        <shubhrajyoti.datta@xilinx.com>
CC:     <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <ben.levinsky@amd.com>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v3 2/2] dt-bindings: mailbox: add Versal IPI bindings
Date:   Wed, 13 Dec 2023 21:42:27 -0800
Message-ID: <20231214054224.957336-3-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214054224.957336-1-tanmay.shah@amd.com>
References: <20231214054224.957336-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|BL1PR12MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: c0dc9652-cf9c-496a-91f0-08dbfc67950b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IxJsUneLoYMEB/04A2AIuCAFq0ALGBakAjyvPv7WNwyZRIwtTcbq5ZDQiqPLh3pa/Teh2+DUAejtYWr6gp1qnWdR4YEiSOkjgBaZagQf4+1L3iD4t5+ULsyp8Wp6jCcsDE5LUxSiMII6OzE5geTjlazjXITWiwHnRddmXWMpGfP5v0rChjIM/3JncGmOk84conGMutAuSfSPF39qGuYTrFjkHzS0M8gf3Q3HiN+BNDdqvuGZtSpDlqfJZwotUX9HszSd//IlGfLgAOBUwx1sNTgiBnhQYAkO3XzWx2a+Uh0Xds03il70Rm1DeRLfkGVZ4wIymtKPR/MvGvKsuRF5crqwjphWu2Fk/0tHiosf0yYtk2pt+cQ09bC9vEAMJeFAkdlGxTcgT1rt61MD6rBe3wp0oc/vHpNJtFPlnoRhpSdcKY3nE2osfRnFm2Q+dFFKC6msd3AYw6xiJAhtlGKhTiilQoN1bPYXN1dCEXd90Cll/DkRCLDpMM6Pt8oXX9qZJHH9J9EiGxMVro2T3Pa/ar1r0dzx3dT5v1W4NQMxwQRK9PPXVa52/qCzOWB30plj9z28ke32fYy+IeW8ZPdpi1MzICpdCtGQtHSEI255daTAanHmjRx8BPIYSewiFFxQbw3eR+j9jpm0mVImMA+aH0dRC2OYPpFV5RHg4gkswHV/j/F6/fQCaupPft43BpluYmGfQvhhyoiNe3PS2CNATo1p6dQemcGsn7wLMMNcHoU+2lG11b3lKt+t89cSKVCC9dEIaaFb1BEP4XaGgJT7nHVM4lnfkYEDPi7F04klU/A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(478600001)(36860700001)(47076005)(83380400001)(336012)(26005)(426003)(1076003)(2616005)(2906002)(15650500001)(5660300002)(41300700001)(316002)(54906003)(70586007)(70206006)(110136005)(4326008)(44832011)(8936002)(8676002)(40460700003)(40480700001)(82740400003)(356005)(81166007)(86362001)(36756003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 05:43:21.4982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0dc9652-cf9c-496a-91f0-08dbfc67950b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
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

Changes in v3:
  - disallow parent node "reg" and "reg-names" properties for old device
  - remove cleanup changes for old device and only keep Versal related
    changes
  - replace zynqmp-mailbox node name with mailbox

Changes in v2:
  - Add versal bindings to existing bindings doc instead of separate
    file.
  - Sort required list same as properties list
  - Add minimum and maximum range for xlnx,ipi-id vendor property
  - Move vendor property last in the list
  - Fix description of child node reg property for versal bindings
  - Change commit text

 .../mailbox/xlnx,zynqmp-ipi-mailbox.yaml      | 131 ++++++++++++++++--
 1 file changed, 118 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
index 73c180871605..fe83b5cb1278 100644
--- a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
@@ -37,7 +37,9 @@ maintainers:
 
 properties:
   compatible:
-    const: xlnx,zynqmp-ipi-mailbox
+    enum:
+      - xlnx,zynqmp-ipi-mailbox
+      - xlnx,versal-ipi-mailbox
 
   method:
     description: |
@@ -58,6 +60,12 @@ properties:
   '#size-cells':
     const: 2
 
+  reg:
+    maxItems: 2
+
+  reg-names:
+    maxItems: 2
+
   xlnx,ipi-id:
     description: |
       Remote Xilinx IPI agent ID of which the mailbox is connected to.
@@ -76,7 +84,17 @@ patternProperties:
     properties:
 
       compatible:
-        const: xlnx,zynqmp-ipi-dest-mailbox
+        enum:
+          - xlnx,zynqmp-ipi-dest-mailbox
+          - xlnx,versal-ipi-dest-mailbox
+
+      reg:
+        minItems: 1
+        maxItems: 4
+
+      reg-names:
+        minItems: 1
+        maxItems: 4
 
       xlnx,ipi-id:
         description:
@@ -88,15 +106,37 @@ patternProperties:
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
+              maxItems: 4
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
+                - description: Remote IPI agent control register region
+                - description: Remote IPI agent optional message buffers
+
+            reg-names:
+              minItems: 1
+              items:
+                - const: ctrl
+                - const: msg
 
     required:
       - compatible
@@ -105,8 +145,6 @@ patternProperties:
       - "#mbox-cells"
       - xlnx,ipi-id
 
-additionalProperties: false
-
 required:
   - compatible
   - interrupts
@@ -114,6 +152,36 @@ required:
   - '#size-cells'
   - xlnx,ipi-id
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - xlnx,zynqmp-ipi-mailbox
+    then:
+      properties:
+        reg: false
+        reg-names: false
+
+    else:
+      properties:
+        reg:
+          items:
+            - description: Host IPI agent control register region
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
 examples:
   - |
     #include<dt-bindings/interrupt-controller/arm-gic.h>
@@ -145,4 +213,41 @@ examples:
       };
     };
 
+  - |
+    #include<dt-bindings/interrupt-controller/arm-gic.h>
+
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+      mailbox@ff300000 {
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
-- 
2.25.1

