Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D277FE5ED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343940AbjK3BTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3BTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:19:52 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3B310A;
        Wed, 29 Nov 2023 17:19:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSowehGXcEMEOrt0tlCYmaz4Q6XCtkEzzmKrteyWEvVvMl80DMzCEiZAr69OAdHUeqjmvExKlO3h87B5CFebHH5OM06YYpqdT/CPQXNUIz6BfL09qjMfVlEJ+FTtAR3WUG3X7IPyGwaO5PY/N46l1eGhu/4XRiDXzYtpRLDP/ywQ+fJEGzdmkS6IeGLjKKj6Mehz4rhwPU8zWERXSR5fLB9NZIzxzKOnseP2uTLx8vlEJUrNIZfx8zHxUEnPvFcqj2QYCllYqE4T1ofAT/84ftGb4mU+/P7jpP9/e7wzh90i5SOjFgemGjOMXG9gGdWji8d2cdAOLflUuLQ4gqJGhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9l7NVwE22OIQhX9zuHnvf4jXsUaT8lpqJkvGpSCoDGA=;
 b=N7BcXRa0UQb5PFNrLDOVUeW7d2RmeomIjv0HZ2h7GqTBTcWpAZW4Lv4PYPJz5hsYsMEwBp6VPakK5+EeW7ZfG13om9qamNn4B8rh83XcosYD3+Ho0Lvh9G6JyqeSTbEYxwTgZz1nrjLs+xU1g+yVkthjNh8+vGuYHSkfgKV8yLw9LzXuNSrvCbAM5PCUJL9ZUuOQORiSkE1k6s/5gEoyC144e7Nx2abAE1rJ62Tuoib4XygHfZVq8tuXY7XCaq9zIp/UrRocSLnr7Yx98hnfRHAIKIyeGRadP862DEPQbO0f2JYL8QKBu17vGjGV9cpsxl9h5IQ1yTRSlce87AIVfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9l7NVwE22OIQhX9zuHnvf4jXsUaT8lpqJkvGpSCoDGA=;
 b=BKEKh3gpBFntFTc5Hq0utgXhyGhyTXedWY4tjxvRjzU2mpx3tFqUA03mT6oHWIl6D+J6sVLQmGfWKpRzTrx+sOKTjp0Y00VVWC9r6PV0z7IFmM3afFjcs7dNWkD4oEDtSfznmqeN8ZBkicJBK8jc4hjU3HEanrs/oATQ8Jln+UM=
Received: from CH0PR03CA0430.namprd03.prod.outlook.com (2603:10b6:610:10e::15)
 by SA1PR12MB8744.namprd12.prod.outlook.com (2603:10b6:806:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Thu, 30 Nov
 2023 01:19:55 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:610:10e:cafe::3a) by CH0PR03CA0430.outlook.office365.com
 (2603:10b6:610:10e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27 via Frontend
 Transport; Thu, 30 Nov 2023 01:19:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 01:19:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 19:19:52 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 29 Nov 2023 19:19:51 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <shubhrajyoti.datta@amd.com>, <michal.simek@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <ben.levinsky@amd.com>, Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH] dt-bindings: mailbox: add Versal IPI bindings
Date:   Wed, 29 Nov 2023 17:19:36 -0800
Message-ID: <20231130011936.3753814-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SA1PR12MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 69140516-8159-4494-1464-08dbf14275b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KOZYde6CHDvj+uC6jtDeonOzF79KTOKKU7xC4YgNudh6ufxGg1HSepw1nDqZFPsam7QbZuA7hcC8XcNF1FFPv980ijNtRQ/dIE0zF6tNdOmzsVYtuKgzWWvbhzHMyGmSi7kkT5GdleJ4dNV2jfwN6e4ZM7ni41eFSGJroucIG4F5gtjmhIaYWrxK2OjWCxA3MwzfHsL2G5p20ZAn7/pXdqvTeR3hbR1ND2faFsTmvjVyWHSgT1Onbi2jX5j15DVE1Qz+5M5SM4wK5hd13pXVDPwy6VLgxE9fW8+v4dN+weatwH6lVxsHJTlAKbPq6ul6+gE4K0u4rcZGcS+j7fhr+326330JkPgx4qGraSTrAWJD5vMm2/s/NNSDDkgzqgpsLrrSurInNdJ9hdRn6SOj3ov4eGjXWPP9ozEwfJvx5hTz9/OH7A1/jj26E8hmIMx9Ef3Y1EcuecDEgDC1/8z8Jzm193kX/ZRZYgjyGtoXBDAghp/cQvJ31CEw12IbUh9xS3F3QVW8TR7H5Tvf2ZURYnLegQiXdBXsN+ZJq8bI4rir/vnZIjNxE1E2fgSV67Y2UBzwFjDVdYdwZkfWARFgh/JdscftR6I8Bk2H9cVNnRrCMNWcmB+V/L7j1ciZxrx/cVarcw5cdKM0F7cJQfniq3CmLrTuXEYjhAWd3UkP/cRnWxc9IndVsa8qqy7NPhK4wwKr+juYBKEEBhDhDgvX0bzIxjSC+9mkn9EZrHLsbnRebgi6tSZEaMUcojn4oYd+i6XADVQRSdJpsUPj7Uznv7f4kz2YAGFIKS3XASqToUi4KOaYTTb6uayDy1VcTgKsI5TT13gRSkuNzC+jgc68Ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(40460700003)(316002)(6636002)(82740400003)(40480700001)(15650500001)(202311291699003)(36756003)(356005)(81166007)(86362001)(966005)(426003)(44832011)(8676002)(8936002)(26005)(4326008)(110136005)(5660300002)(83380400001)(54906003)(70206006)(6666004)(1076003)(2616005)(478600001)(336012)(70586007)(36860700001)(2906002)(41300700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:19:54.4919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69140516-8159-4494-1464-08dbf14275b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8744
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for AMD-Xilinx Versal platform Inter Processor Interrupt
controller. These bindings are different from previous
xlnx,zynqmp-ipi-mailbox bindings and hence introduced in separate file.
However, same existing driver will be extended for devices that are based
on Versal bindings.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 .../mailbox/xlnx,versal-ipi-mailbox.yaml      | 174 ++++++++++++++++++
 1 file changed, 174 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,versal-ipi-mailbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,versal-ipi-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/xlnx,versal-ipi-mailbox.yaml
new file mode 100644
index 000000000000..4408b59d392d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/xlnx,versal-ipi-mailbox.yaml
@@ -0,0 +1,174 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/xlnx,versal-ipi-mailbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx IPI(Inter Processor Interrupt) mailbox controller
+
+description: |
+  The Xilinx IPI(Inter Processor Interrupt) mailbox controller is to manage
+  messaging between two IPI agents. Each IPI agent owns registers used for
+  notification and buffers for message.
+
+               +-------------------------------------+
+               | Xilinx IPI Controller               |
+               +-------------------------------------+
+    +--------------------------------------------------+
+  TF-A                   |                     |
+                         |                     |
+                         |                     |
+    +--------------------------+               |
+                         |                     |
+                         |                     |
+    +--------------------------------------------------+
+              +------------------------------------------+
+              |  +----------------+   +----------------+ |
+  Hardware    |  |  IPI Agent     |   |  IPI Buffers   | |
+              |  |  Registers     |   |  (optional)    | |
+              |  |                |   |                | |
+              |  +----------------+   +----------------+ |
+              |                                          |
+              | Xilinx IPI Agent Block                   |
+              +------------------------------------------+
+
+maintainers:
+  - Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
+
+properties:
+  compatible:
+    const: xlnx,versal-ipi-mailbox
+
+  method:
+    description: |
+      The method of calling the PM-API firmware layer.
+      Permitted values are.
+      - "smc" : SMC
+      - "hvc" : HVC
+
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - smc
+      - hvc
+    default: smc
+
+  '#address-cells':
+    const: 2
+
+  '#size-cells':
+    const: 2
+
+  reg:
+    minItems: 1
+    items:
+      - description: Host IPI agent control registers
+      - description: Host IPI agent optional message buffers
+
+  reg-names:
+    minItems: 1
+    items:
+      - const: ctrl
+      - const: msg
+
+  xlnx,ipi-id:
+    description: |
+      Remote Xilinx IPI agent ID of which the mailbox is connected to.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  interrupts:
+    maxItems: 1
+
+  ranges: true
+
+patternProperties:
+  '^mailbox@[0-9a-f]+$':
+    description: Internal ipi mailbox node
+    type: object
+
+    properties:
+
+      compatible:
+        const: xlnx,versal-ipi-dest-mailbox
+
+      xlnx,ipi-id:
+        description:
+          Remote Xilinx IPI agent ID of which the mailbox is connected to.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      '#mbox-cells':
+        const: 1
+        description:
+          It contains tx(0) or rx(1) channel IPI id number.
+
+      reg:
+        minItems: 1
+        items:
+          - description: Host IPI agent control registers
+          - description: Host IPI agent optional message buffers
+
+      reg-names:
+        minItems: 1
+        items:
+          - const: ctrl
+          - const: msg
+
+    additionalProperties: false
+
+    required:
+      - compatible
+      - reg
+      - reg-names
+      - xlnx,ipi-id
+      - "#mbox-cells"
+
+additionalProperties: false
+
+required:
+  - compatible
+  - interrupts
+  - '#address-cells'
+  - '#size-cells'
+  - reg
+  - reg-names
+  - xlnx,ipi-id
+
+examples:
+  - |
+    #include<dt-bindings/interrupt-controller/arm-gic.h>
+
+    amba {
+      #address-cells = <0x2>;
+      #size-cells = <0x2>;
+      zynqmp-mailbox@ff300000 {
+        compatible = "xlnx,versal-ipi-mailbox";
+        interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+        xlnx,ipi-id = <0>;
+        #address-cells = <2>;
+        #size-cells = <2>;
+        reg = <0x0 0xff300000 0x0 0x1000>,
+              <0x0 0xff990000 0x0 0x1ff>;
+        reg-names = "ctrl", "msg";
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
+
+...

base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
-- 
2.25.1

