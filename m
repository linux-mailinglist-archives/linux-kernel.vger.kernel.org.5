Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8BE751EE7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbjGMKfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjGMKfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:35:04 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D851720;
        Thu, 13 Jul 2023 03:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myD9z1vUutNcJKunCoEjJbQM2JoVPdWs26MW63VoeC/LquEI9a6uocKCmP3nsSlHoAEuI8wR2h5uClH8BPnrMnW2WNm8bxFKl54pTtRHH0VsHWnPvB0nWUa02OiNh0t3DOjN/WTOg6blXcnq5tOC20AYa1tcIAXiDIP2JrsidUEce06fTdzdx+lsZscZEziShrF+NOPe9THucY5hLmqqhs8kDuammOtgmjrXP8MMztGy87VevUfHEJ059Fisty5DFBlnLruug86NU2P4OM2iXtA4mYuInd3WQZf0lUOVsnzqW4EJ6qAdwBxiSO4yo96DTE7oqkswlD6gBh+8Fk2nxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBxI4RThnKa5YQqbxjsvpaY2Bvd3kMAkjmDdJeWZ2Xk=;
 b=F0ACz29iipNi/dQikFyBVOuyaxbq0VeRgCEoYAxWq8tDhHGBuFQQ05L8i0zjAceFTFLuFQjVoUy/c2kcRrYAlNaLfZP9aC94Y9L2ARy6+uqKkaphBZb5cwP4FqS7zms0DHSGUAVY4TiwyeoHpYIGgFRwOn5bBSXmhIM/xdlEU3VNYIyu2Qv+rHYldsaEeSZbw8RxrVPl36VxnXlE1VpbV/p+AflgiNMfotGSV2dphaVwQxJiOhjJQhO6LN5xqw1KzSdAThRC/uu0Nty+ohJht2gqhRurjxxy732tRxsZFocU/Bwdz5N/ECRFkP19OyGxWwVkRDGWaNUPBlk2d/a6Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBxI4RThnKa5YQqbxjsvpaY2Bvd3kMAkjmDdJeWZ2Xk=;
 b=rfvwm/cJN7h9K+wWNj9fw357+B3RfdsAUNU1X6T1VKl+h1NRpkUaoNNpes4hrbI6f9s+A+aP0378guW+tZ5grunFa25KBumXrJGuDx2bY5KwMG3iwfPgTG3tjafCUyVyaoHnq8lz8B1TkCLRAGQfGRRFZpHTMBLx7pPGHaguidk=
Received: from BN8PR12CA0036.namprd12.prod.outlook.com (2603:10b6:408:60::49)
 by MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 10:35:00 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::74) by BN8PR12CA0036.outlook.office365.com
 (2603:10b6:408:60::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24 via Frontend
 Transport; Thu, 13 Jul 2023 10:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 10:34:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Jul
 2023 05:34:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Jul
 2023 05:34:58 -0500
Received: from xhdpranavis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 13 Jul 2023 05:34:54 -0500
From:   Pranavi Somisetty <pranavi.somisetty@amd.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <harini.katakam@amd.com>
CC:     <git@amd.com>, <radhey.shyam.pandey@amd.com>,
        <pranavi.somisetty@amd.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] dt-bindings: net: xilinx_gmii2rgmii: Convert to json schema
Date:   Thu, 13 Jul 2023 04:34:53 -0600
Message-ID: <20230713103453.24018-1-pranavi.somisetty@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|MN2PR12MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: bea9c579-dd7d-471a-3924-08db838ccf29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0xHam2gnvpiumXWKTAR3VjF5kRzFXevW82iB4iSUMz2IUArZWGscLKIu1pDE8JvAe9hAz+Vo9PfBhJM3PjLsnyZ+5XF9O+oZ0gP4zHWYGaTDwvvxo3jSGTgIS70jpIocStjSK3Z4TZJ39smir/unNfgKSIQ6vgEctMkDMv+al+ebIMaOBJESqEFPeT+DQvvOBvjK+Xz2uX7m0Js9c/q7yW5QFiIfwYK3me0uDWFiYGsIgrclN/sLBpEGpDE7h7qk2vc/C7N5CfeG30U6J7whdNcJsuHKB2tCCaFvcZM7XB75HpzX90w67Rm/PgquYSeBgQoXQUWcfjv1NO/HaHts5bYqGkKDvMoQoYzN3H26sSiPolpBlxB8VeGsv2++kU6Ko8hrwnZGB6h8c5Gq6zF8L+K0meHpu5ZchEbQAZI0MX5YNn4xLp+WR+Zl7D46va61cvufiBDq1oNHLKZCpRJNi98+xDhyGudv1Cjt74esXoyGpfjJ7QBoc3qCUxZ9zQgk/UjfVDvkHxpX30gvF1x76cXAODS+27irTY0fXvh79CtKGTOMQCAGeBnH60HGDCh0tuEK4/6XTUnOvIe2kaqvzyDwxyefToflwEX048cuKF/Of+2vUZff80hMO0PJ/rwY1KIrfx6SSurDznfTRaTo8Y+o/1LDr74nGLvOR9+/P3uY8xGTiysQ1VMe5KNC9ppgPH4HBmR37LWbd+WVglqUb34l5Bh3BNKjBXweWpeRU133OEUqrOYmsjJlfoFgTDKUqt+dXHeHk5f7oR+LhQyHquyKXLHNk1ywOzjNvz80p9A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(41300700001)(336012)(82310400005)(47076005)(356005)(81166007)(426003)(83380400001)(2616005)(82740400003)(186003)(1076003)(26005)(36860700001)(40480700001)(966005)(110136005)(54906003)(478600001)(2906002)(316002)(70586007)(36756003)(70206006)(6636002)(4326008)(5660300002)(44832011)(7416002)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 10:34:59.6833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bea9c579-dd7d-471a-3924-08db838ccf29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4453
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Xilinx GMII to RGMII Converter device tree binding
documentation to json schema.
This converter is usually used as gem <---> gmii2rgmii <---> external phy
and, it's phy-handle should point to the phandle of the external phy.

Signed-off-by: Pranavi Somisetty <pranavi.somisetty@amd.com>
---
 .../bindings/net/xilinx_gmii2rgmii.txt        | 35 ------------
 .../bindings/net/xlnx,gmii-to-rgmii.yaml      | 53 +++++++++++++++++++
 2 files changed, 53 insertions(+), 35 deletions(-)
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
index 000000000000..8990054f9d53
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
@@ -0,0 +1,53 @@
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
+    description: The ID number for the phy, usually a small integer.
+
+  phy-handle: true
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
2.36.1

