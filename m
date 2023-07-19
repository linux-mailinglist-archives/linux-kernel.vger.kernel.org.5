Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2255758D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjGSGSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjGSGST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:18:19 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA381BFC;
        Tue, 18 Jul 2023 23:18:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knYYnScYRJ4BAUL4hRMBQOQXqg0OXpi5XGRMSKb0r+tUhdQ+IrAe7ryIa5XWsrOr2IXa3Jle06ehzKm/rBD/h86ZoZ+yzR7jVDCrAqNIMp52eNmYbdTtAhgeYtj898Q2OB2J5qzqM3vvQFesuzBum1npjRu/4X/afU3GN3t2aY1Syrvv1ebuQuxmfYUJVsxwYtOx2qzP2L1hWSVDvsT7RtxYZcxOKEJfQ5SDZ3/ajc7NiZ+vd0XShXskbw2CH+ssDtmMYxBVMdAaLFugCuaU9bGUEOlb00wWDleguHGrM4AaStZVS6+QThuEDpszscDAzai0tVfbMbmO4d+TBmTBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQr7yKxa5KQsSQ4v1lrv/GpxXDKOX3PE7ssJpVYGODI=;
 b=C0zatDWlh3Kt8XPm5L8v97nENYlDXt8JBRaL/ZArlBJEYVExc9zNNcmo+N8Kl8Qh1Sxlia2No77vNIsIaLnweBcTRx2ievCc1BHUqf8pWp6R+xmSl9v3Yy3Jk8GANM6UW3aR4IfJAlGPgh2fgnLc12l3+dLhJ44ZkvyG/KqD5CfJ2z6AUh3bQZvaPiBNHp85Slt51nx/yjUDMaDd5BkW2UTrWCt1qEGtUdA0rWURYGIpR/9PSy4nmTN8dvEDFcf2BTzszRNB/FrocJfgfRTbWUvpgwVZa9K1nLD7XHb6ly0Te+90A4gFu8Stey+6X2A25NNy1ZD7OT2I5kp9wlxRdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQr7yKxa5KQsSQ4v1lrv/GpxXDKOX3PE7ssJpVYGODI=;
 b=SMtpeIpQIrV+dsYW0Jm8bj9O7kgBaKaTJXwHGkaMWr1VLZTkebafY1ZDJx6v65Yct7Wt3qKbFGutm5Bt3CWQJ8JO8RvnKzOFnZkFZ5JZYqyslCL3MVvcTpFllMOuMz6WDhNxKznGigfMmcQ7eS2rc9ct4eY0Fx/GJCqZ5AK+mOo=
Received: from SJ0PR05CA0045.namprd05.prod.outlook.com (2603:10b6:a03:33f::20)
 by SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 06:18:15 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33f:cafe::5e) by SJ0PR05CA0045.outlook.office365.com
 (2603:10b6:a03:33f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23 via Frontend
 Transport; Wed, 19 Jul 2023 06:18:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Wed, 19 Jul 2023 06:18:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 01:18:13 -0500
Received: from xhdpranavis40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 19 Jul 2023 01:18:09 -0500
From:   Pranavi Somisetty <pranavi.somisetty@amd.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <harini.katakam@amd.com>
CC:     <git@amd.com>, <radhey.shyam.pandey@amd.com>,
        <pranavi.somisetty@amd.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] dt-bindings: net: xilinx_gmii2rgmii: Convert to json schema
Date:   Wed, 19 Jul 2023 00:18:08 -0600
Message-ID: <20230719061808.30967-1-pranavi.somisetty@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT008:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e9258b-33b6-4106-8dda-08db881fef83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uEL+yK9OIy23sUqlvYMqwMuhTn482qXSvVTGAr1LUeXBBbOkwctnNjDCniw3yp3+F+YEOr5mguSeq5x6xklv9SP2xFS99oXHy1Wz1fJTgFuMBmnbR/h3OVjgjWnVuGBcUs6kPaNZzldIG7cLm0UOk8szvicIBvGxTV1JMv9qEGGgI4TSwKQ4SVWutXJXl8VwmGExLJIXdKhsFrgwaRo0DsDpsfbz8darI/uwW8BeWJI4JJZeuQPTtDXvwzrdUNOPOw1dOQU4l6SgW7WNbQIPwAdFJWEkJuwZBe84BxmtSH6nQi4PGkBUcYJlZvishu5wqeg+CJLCbncYjZ5o0Oo5LMFKXZT+WRCDON4i10yEWX0vnX7pj+FhuIOXg59e0xxlY7HYZ0grub3mcQrIRLEPGrO4SrIazp4o8cj0lx9ApBf/ueC7LpzNldN2k+Zf/CeBOTgWWVn0RqRvnfOLjPjJ+X0BaCibt48tLO54tmzPFGo6XgbhXVmXCLiXXhlxXP27juP7n7IdlnZ4siJQ6/ldzlAXckkSu5WwUtJI9i5tO6v4fGo04H7axH2Vf7ReyP4wqEYiiy9hAK2DeQm13ioKT2Ho9Vx8ei1ORhRCBNT4ofObFkogQ9bYIJnXkYXwjlzZbpQ7u25sKhbXB5eX7TOY99/MBIJNbHpgXuYmRGUsF85KTJXtpkeS6/h6BbSV91oGfzIuCowFZgj/ZZ8i+Z5gn6S7F8LPJzyx1qgu9XDvAvVbf7IGNETXK2qsaXotLBoWHHCB5KCatJ6zg0K8IuvOBt+BKp64B/cKTdgVFcARLMY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(110136005)(54906003)(478600001)(36860700001)(426003)(2616005)(83380400001)(36756003)(40460700003)(47076005)(40480700001)(26005)(2906002)(966005)(186003)(336012)(1076003)(41300700001)(316002)(8936002)(70586007)(82740400003)(81166007)(44832011)(4326008)(356005)(6636002)(5660300002)(7416002)(70206006)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 06:18:14.6015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e9258b-33b6-4106-8dda-08db881fef83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
Changes v2:
1. Changed description for the property "reg".
2. Added a reference to the description of "phy-handle" property.
---
 .../bindings/net/xilinx_gmii2rgmii.txt        | 35 ------------
 .../bindings/net/xlnx,gmii-to-rgmii.yaml      | 54 +++++++++++++++++++
 2 files changed, 54 insertions(+), 35 deletions(-)
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
index 000000000000..9d22382a64ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
@@ -0,0 +1,54 @@
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

