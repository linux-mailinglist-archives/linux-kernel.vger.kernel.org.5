Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BDC7B2C9B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 08:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjI2Gtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 02:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjI2Gt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 02:49:28 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A7F1A5;
        Thu, 28 Sep 2023 23:49:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSA5JjgPnsXIuyDUb3xMceYjKJvIhDBrkbZpPftqv+eijSIM4oZ6cBQBDcDPhkQmwrZtxRuAT98SmgqgMmLgkIL6PfeLO0xEulSTdTvDSnloqwYiAzX+2QuNnWXKafjzcDAWN1rFX9vTogiSJbs1PnphLHQla3DmZZsu6ubhRPcfK5LxAvMAOBYVCuruOYOsotTham2qThdBGHVEdl6c5PBKs8BN8A5d/EQ4eS03WSL4pL9AiC7njXuSYsU70i5BClrLiE5mHEaXSuValY1TA+gcx8aC3ZPJKc+gzMY7ATHMQQ6SBNP68D9X/yXcn2O12+4JCyroKCm7VSqOAaKibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GuzyvYJl8zZixe7gZKGlisuO8sM3pLIaX8weswjRDI=;
 b=bfmDmB3tbOuC79oKGWM3J/ifWF17lUKmnB9CmBkdIS6L40ukzXrKwkrI6NiTr3UgJ+taDXR2uEgMT2R+nGu2RGdwiNAtA+XEciSHdY0fbgUldsJF/Sg6nraf0ePAGuLhGfDY/FaTA02QbURthCajakETsSvgCpJOyR6JNE513Hv7rpor9PhbV/DEz0QY6xBv1UAMF7grGbY/SRiogztidbTCwWnmgSXeUm7+1kNypSFdONUO+1kOIA4PEep2nveRN+/PV1ezaUuRuIWKbgT/iVupNYlC66KMkinKaavVYFqQG6YvE83BHDtW1wsq1M9FGe7LA33JezmhExxK55pX2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GuzyvYJl8zZixe7gZKGlisuO8sM3pLIaX8weswjRDI=;
 b=j+HtQ6CndiD1VLv5+0kCUeCLqj5mGsw0ETKrtUC9BWDcP3T7j2tR+je5hV99ck/+L2s/XOyKA3A7bc4oE0nB/dO0ZHPhjTftxu8d89ft+teOB+4Q0kZOn1oBEUXRGtIy0dYIgY6wBnkqRcc47RlzSWoQFF5iH4OblyCoq86SZiU=
Received: from DM6PR08CA0048.namprd08.prod.outlook.com (2603:10b6:5:1e0::22)
 by SA3PR12MB8804.namprd12.prod.outlook.com (2603:10b6:806:31f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 06:49:22 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::f) by DM6PR08CA0048.outlook.office365.com
 (2603:10b6:5:1e0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Fri, 29 Sep 2023 06:49:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 06:49:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 01:49:21 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 01:49:21 -0500
Received: from xhdpiyushm40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 29 Sep 2023 01:49:17 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <michal.simek@amd.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <peter.chen@kernel.org>,
        <linus.walleij@linaro.org>, <paul@crapouillou.net>, <arnd@arndb.de>
CC:     <piyush.mehta@amd.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>
Subject: [RFC PATCH 1/3] dt-binding: usb: ulpi-phy: add ulpi-phy binding
Date:   Fri, 29 Sep 2023 12:18:50 +0530
Message-ID: <20230929064852.16642-2-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230929064852.16642-1-piyush.mehta@amd.com>
References: <20230929064852.16642-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|SA3PR12MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d887902-fef2-4602-c39d-08dbc0b8366c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PjFMMqHErR88yAV73rBrXV7QT7lLBXlP8F+H4vSWQo7yNh7iuKNppQ2ErX21dcW3a2Xv7Uno0FLdp/unc8TNmuINFXCnu/skkF96svBf6Gf4kXo37f7CUeSV7EgYmYl1PbMiFNIhFuzQVlxKwQDkef1F5MLgiq5a4uxPjc81xjO5bgQWb8vehVwRLBNXmTYXWJWQU1Dk3iBc4Sr8RyYQHOMNUyaedbWiVisjr2DqApI78h6XauyGazedBXLMrGznZyfPYnNmSN5Kw6Cr8J303y+LNPcwDGbly0gaLv0z4dSibi8UPGRBI7oeeQJhnWLNmA/8z+ZDIPhaj/EkwhT7BRd7r0sFhz7Z8P/xdchRZAC8M3tuRODgU4V5iljGrPtA1LK7wvBTSQWOdRh9IftIGSFa1eao12BlmqS5+jF0PAZna8OOnMK872uF/wQ5kf+uIl84bboCXzQv0QWyA0qaGFdtAUHuq0knIZ1P0jeutPCPReC5V7VhpVmycjRgDfGELE6VQlVKjX2op3ciHroMmTdjXjibNpmzLmfqfxb1hyuksjHT8r8CVm0LGsby+RZPGsVTxIcR/5jvzbPmyDT/e7HcLlQg0Fy/15k2VXVa/7dlnaMHgqLtwVWU2eaTloS+8EXMVQ2ccnFG9WHwuV4tU2P2tvRKgh74DZzI6/c5XhcPAw4FGNAEkMWOkZ54PCwuOsdwbxSWGQa3LSKdTZpok7x5Q/lQlF5hjxCLTIkEnYpO9AQB1QqYviVkRhkPgKUogi6dgy+RRDz5VzR6xJ1JFtdU1frbwz9ekPeJgLc8e4M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(7416002)(110136005)(2906002)(40480700001)(316002)(70586007)(54906003)(70206006)(41300700001)(8676002)(8936002)(44832011)(4326008)(36860700001)(40460700003)(26005)(1076003)(6666004)(478600001)(5660300002)(2616005)(356005)(336012)(426003)(47076005)(966005)(36756003)(86362001)(82740400003)(83380400001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 06:49:22.1888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d887902-fef2-4602-c39d-08dbc0b8366c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8804
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create an ulpi-phy binding to read and write PHY registers with explicit
control of the address and data using the usb.VIEWPORT register.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
This binding patch was created to support generic platforms. This binding
will be modified in accordance with patch [3/3] procedures. One of the
approch may be Create a zynq phy platform driver in "driver/usb/phy" with
driver source "phy-ulpi-zynq-usb.c" and then the binding will be particular
to the Xilinx/AMD zynq platform.

This binding was built with the Zynq hardware design example in consideration
of as a generic platform. The viewport provide access the Chipidea controller
to interface with the ULPI PHY.
---
 .../devicetree/bindings/usb/ulpi-phy.yaml     | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ulpi-phy.yaml

diff --git a/Documentation/devicetree/bindings/usb/ulpi-phy.yaml b/Documentation/devicetree/bindings/usb/ulpi-phy.yaml
new file mode 100644
index 000000000000..490b2f610129
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ulpi-phy.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ulpi-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ULPI PHY- Generic platform
+
+maintainers:
+  - Piyush Mehta <piyush.mehta@amd.com>
+
+properties:
+  compatible:
+    const: ulpi-phy
+
+  reg:
+    maxItems: 1
+
+  '#phy-cells':
+    const: 0
+
+  external-drv-vbus:
+    description:
+      If present, configure ulpi-phy external supply to drive 5V on VBus.
+    type: boolean
+
+  view-port:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Address to read and write PHY registers with explicit control of
+      the address and data using the usb.VIEWPORT register.
+
+required:
+  - compatible
+  - reg
+  - view-port
+
+additionalProperties: false
+
+examples:
+  - |
+    phy0@e0002000 {
+        compatible = "ulpi-phy";
+        #phy-cells = <0x00>;
+        reg = <0xe0002000 0x1000>;
+        view-port = <0x170>;
+        external-drv-vbus;
+    };
-- 
2.17.1

