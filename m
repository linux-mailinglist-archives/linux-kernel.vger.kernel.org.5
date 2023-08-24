Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD1E786E3B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241134AbjHXLpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241111AbjHXLpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:45:33 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102711987;
        Thu, 24 Aug 2023 04:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RY1Xk2OgkgaOl91R80xbEQgMjlh6zAtcrgQ30EM3tgB7Szm422XobysRCvXnANiALTiUBEMS+UMw3RVEtrvngM3mqR+BziGP04cJVKHl02L6FINhMcOBM4dxpnyVWb6Wg5PB0e7316WmftS5DauwaZxizI1BSEI1bYj0BT3sIHGL+KDxfFUGS4R1bYvGM92B3f+yGqR9WXXKeiEY509IbGiIUirJp0JW1A+H2XXZQB/Qg9xHqiVz12O6bJdYtVzdk4zIsrKdXEpR4w4Fo8uu6kjwvyagmpAFIPzIWN0YQID5xaBLxxCH2Y3P6PHB/oCR1nj+3dUry+WGaSCp7CuQvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHur3tpdKg78gEuipzi5g0/0jtiaS2TqKgEqhCKKJ98=;
 b=NeRV1zgOC4GFn8xdIGp8pU4LKIXVgqbmZuZ2aOzFOL1K+Der6uxNSeft4LqeQuheWjo7dc5ATM6zZTG0tyInT3WDE/URbLYAxOOd257S3XPTKvHTuSmoAeIZaU0kyDQC2h7W4XnB2fFGIqxtMqRX5n2Nq2oERfXID7+4n8w3Cr++RewMYv2bUwWe9ZYZ7gUEgwRCRR8jnM1FCw5eJ9cxlsqqxlDZpAMYsMLeyt5TozcYRj8R+XCI3uwsyvNvPKjGKIZIzeT/sXQAOz/jKaCmeBtUMPR4q1epjzFcQmgrrlUpDOhwHxTOqaB5Yrm4lz522QZ24I7FUC+QgafxyuLT3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHur3tpdKg78gEuipzi5g0/0jtiaS2TqKgEqhCKKJ98=;
 b=roLV6W6bSnXm02KTmpa28zEj90JWN55uInn3EmNauPts0Sgia1W6Mj2pq2dyowZRNe1Qnzz0yUvg2Va0IvT7xV80+0lxiNxseuPIEiMruDnykZOdwM4nbPt4ycaHiCJKRLunAyZKlPOWaT+ZlgrfXWeUuICgLWzfW7gwgM6HHYk=
Received: from MW4PR04CA0293.namprd04.prod.outlook.com (2603:10b6:303:89::28)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 11:45:25 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:89:cafe::9) by MW4PR04CA0293.outlook.office365.com
 (2603:10b6:303:89::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Thu, 24 Aug 2023 11:45:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.2 via Frontend Transport; Thu, 24 Aug 2023 11:45:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 06:45:05 -0500
Received: from xhdharinik40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 24 Aug 2023 06:45:01 -0500
From:   Harini Katakam <harini.katakam@amd.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <harinikatakamlinux@gmail.com>,
        <michal.simek@amd.com>, <harini.katakam@amd.com>,
        <radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v3] dt-bindings: net: xilinx_gmii2rgmii: Convert to json schema
Date:   Thu, 24 Aug 2023 17:14:56 +0530
Message-ID: <20230824114456.12243-1-harini.katakam@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb370d7-4104-4752-3c9b-08dba4979aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aRTpJt9R/NPimveCgmiHXSPfQcDwR6JBeO2nwTBhyo8xCas64ZJtIsv2yuLrVOELzmYi7yiQMcAkCIQ213b3e1cYW/kGY+HVfbA83ATDA0jS+cRnqQIBynSveu9dKS6dX08e4FM4jH67uVwBkTSkgoaM7YHd4twnTBSAUWGj3iv/WFQq6y++Rf8aUoHDEcQanQNeU28BuZhVpcvE8tP5bgnmD1rxJwSwObe+gKPt6LcV1y/wbwpgnx9SbA+n4pOBVpC1ej4cD4hOP3My95qIZ4CjvYsDEaGVFxlzo7ytgoNN2LU0cGbLPyUB4CnY+/qjeExU1m/GYki3+g5FQtH8MyLEl3L0YA8xumH9zR8FRIqIH+g9TEDRHJ90tFEybZMbFTBZKlPT40lQZLs444xPlVUvQOkfLi8b5JW2yVj6XmcC33u8G56oWWTNGUadCEWiXkva0Kds1BzdUoE+8DXQjvA4Rx/08StRU5aCVkAMQfLbx2JvjEHeTQfAMPeG5eChSa+DWmXJ0mXSboP12oM8rIftQmEcFHWmwNlNbHdAmXjUYQy5DIVaeJ7fs6dUU8FH20wJj7Jhw7zwjU0BVBRa4lswvrNB7QtWpDmI8eyYSLjDOkv8An39XGKt6LhyKxvEhgiSdFJ2oe668Gt3E+IjQamIwMGFUdozK291AA3SLSwZpG3YXTbl7BZ03ggd7fAPPbRx9HsWAWwHZeSh+n7RXPl3NsZKADKkyEdYGk/+4OZp5pkS6trwandG6KnwC7B4PIil5bSrMsw+gKj/Y44JK9gAIB8IH4YW/JWEWbv4laI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199024)(186009)(82310400011)(1800799009)(40470700004)(36840700001)(46966006)(54906003)(70206006)(70586007)(316002)(81166007)(478600001)(110136005)(26005)(44832011)(36860700001)(356005)(6666004)(82740400003)(40480700001)(41300700001)(86362001)(2906002)(966005)(4326008)(8676002)(8936002)(1076003)(40460700003)(2616005)(5660300002)(7416002)(83380400001)(36756003)(336012)(47076005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 11:45:24.8037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb370d7-4104-4752-3c9b-08dba4979aef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pranavi Somisetty <pranavi.somisetty@amd.com>

Convert the Xilinx GMII to RGMII Converter device tree binding
documentation to json schema.
This converter is usually used as gem <---> gmii2rgmii <---> external phy
and, it's phy-handle should point to the phandle of the external phy.

Signed-off-by: Pranavi Somisetty <pranavi.somisetty@amd.com>
Signed-off-by: Harini Katakam <harini.katakam@amd.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
v3 changes:
- Add new line before child nodes in example.
- Add Conor's review tag

 .../bindings/net/xilinx_gmii2rgmii.txt        | 35 ------------
 .../bindings/net/xlnx,gmii-to-rgmii.yaml      | 55 +++++++++++++++++++
 2 files changed, 55 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt
 create mode 100644 Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml

diff --git a/Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt b/Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt
deleted file mode 100644
index 038dda48b8e6..000000000000
--- a/Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-XILINX GMIITORGMII Converter Driver Device Tree Bindings
---------------------------------------------------------
-
-The Gigabit Media Independent Interface (GMII) to Reduced Gigabit Media
-Independent Interface (RGMII) core provides the RGMII between RGMII-compliant
-Ethernet physical media devices (PHY) and the Gigabit Ethernet controller.
-This core can be used in all three modes of operation(10/100/1000 Mb/s).
-The Management Data Input/Output (MDIO) interface is used to configure the
-Speed of operation. This core can switch dynamically between the three
-Different speed modes by configuring the conveter register through mdio write.
-
-This converter sits between the ethernet MAC and the external phy.
-MAC <==> GMII2RGMII <==> RGMII_PHY
-
-For more details about mdio please refer phy.txt file in the same directory.
-
-Required properties:
-- compatible	: Should be "xlnx,gmii-to-rgmii-1.0"
-- reg		: The ID number for the phy, usually a small integer
-- phy-handle	: Should point to the external phy device.
-		  See ethernet.txt file in the same directory.
-
-Example:
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		phy: ethernet-phy@0 {
-			......
-		};
-		gmiitorgmii: gmiitorgmii@8 {
-			compatible = "xlnx,gmii-to-rgmii-1.0";
-			reg = <8>;
-			phy-handle = <&phy>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml b/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
new file mode 100644
index 000000000000..0f781dac6717
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/xlnx,gmii-to-rgmii.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx GMII to RGMII Converter
+
+maintainers:
+  - Harini Katakam <harini.katakam@amd.com>
+
+description:
+  The Gigabit Media Independent Interface (GMII) to Reduced Gigabit Media
+  Independent Interface (RGMII) core provides the RGMII between RGMII-compliant
+  ethernet physical media devices (PHY) and the Gigabit Ethernet controller.
+  This core can be used in all three modes of operation(10/100/1000 Mb/s).
+  The Management Data Input/Output (MDIO) interface is used to configure the
+  speed of operation. This core can switch dynamically between the three
+  different speed modes by configuring the converter register through mdio write.
+  The core cannot function without an external phy connected to it.
+
+properties:
+  compatible:
+    const: xlnx,gmii-to-rgmii-1.0
+
+  reg:
+    minimum: 0
+    maximum: 31
+    description: The ID number for the phy.
+
+  phy-handle:
+    $ref: ethernet-controller.yaml#/properties/phy-handle
+
+required:
+  - compatible
+  - reg
+  - phy-handle
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        phy: ethernet-phy@0 {
+            reg = <0>;
+        };
+        gmiitorgmii@8 {
+            compatible = "xlnx,gmii-to-rgmii-1.0";
+            reg = <8>;
+            phy-handle = <&phy>;
+        };
+    };
-- 
2.17.1

