Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3011B7CFC6F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346078AbjJSO0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345795AbjJSO0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:26:14 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF62412A;
        Thu, 19 Oct 2023 07:26:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCWIHqRhygwhfi1a2fnRlKr8DN5mtx1FRoHTh/saO5iikyqHDUY0me5uHe1A1b+u7bcWgX+1SDRFJLHNkskdseXYaYADveKcb0RwMdhEoLffMYN91dECra8urKt0+aSN4XHyAfYVyiTJ4ZxPpabw2SG60rnWand4UGkXf6Eg8+QmH/1Ua6KEwav+Lf2Ww1pz3yHD5SGZJVU9WoDV+X8wWWpm0jpzF0qRuwNRbEHgefGA5mGA/cTyBsXlN1n7+M+6h9jVstJlKlkeQpoCaXEfCPVEIxmwOjrTWk+7vGlO37lmQgEiUxK0t2fQd3qqabkBNPBaosLFT4cL4C5BlLcifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eqy1+QTZyYLaaDxLaviw8xElaRM4FXdntpt34FsfIy0=;
 b=NPpw+LEs51ICWMTtnXjl9N82zyUsGLgDVRd/NBPYf9jylDzYZn+0zTBhDqpMmaeWWyIEpxnK/Ikj1I6RGaZRZhlmsCvxCnU+OLkEBsut2VEOSdJAjGXXgNJ8bGGv5vJziEVaYAbwf94mI+4NP9zj/d8vlgNXtqWTctYQc6a7vSR1qKvTyVFGaOXDc8BQaP8k+Dks6ffRW9T+2X4w3UPtXG4roFCAvBOR2Gp85C8hVl2l3ygGXvWd6Soxb7BEWPz3BwrnTcgM2ZnFA+4AMp7IJWZEEUFBzVIw5OgPxjQMywK9k/EyTCDjG/IpVZek97rjJ6Ec+nunT/IvfNJ7JjOVDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eqy1+QTZyYLaaDxLaviw8xElaRM4FXdntpt34FsfIy0=;
 b=W4Mnk6z5GX6tXhuqkxnL/6sz4q+ff4lHI2CU2AcRVdB7a6HalpYJD7Fcaz8uYFI+zcKKml2sVz4SUitZ9SaqrxOVXuZtiMtYIx8j3Dx4FuSpm/5dhhCJN3n38fosWF3UtcgURxs/gUriv3+04h994B4+GHM9R2Hi20BcVm05jNw=
Received: from SA1P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::33)
 by MW4PR12MB7465.namprd12.prod.outlook.com (2603:10b6:303:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Thu, 19 Oct
 2023 14:26:09 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:22c:cafe::15) by SA1P222CA0015.outlook.office365.com
 (2603:10b6:806:22c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Thu, 19 Oct 2023 14:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Thu, 19 Oct 2023 14:26:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 09:26:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 09:26:06 -0500
Received: from xsjapps55.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 09:25:50 -0500
From:   Kris Chaplin <kris.chaplin@amd.com>
To:     <kris.chaplin@amd.com>, <thomas.delev@amd.com>,
        <michal.simek@amd.com>, <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>
Subject: [PATCH v2 1/2] dt-bindings: w1: Add YAML DT schema for AMD AXI w1 host and MAINTAINERS entry
Date:   Thu, 19 Oct 2023 07:24:17 -0700
Message-ID: <20231019142526.10592-2-kris.chaplin@amd.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231019142526.10592-1-kris.chaplin@amd.com>
References: <20231013093109.37165-1-kris.chaplin@amd.com>
 <20231019142526.10592-1-kris.chaplin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|MW4PR12MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d64f289-ca3f-4c26-7d8c-08dbd0af5695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vc7fZVRvZ/1sQR6+ux1Qd6atf4W9bwaFcrf5YE5CvnDfltuMxQTgenDYFMYMWdLm7Sbe4VeIFUfPACFLpObO3PCzCgzM9RTDqhr/IH+W66tPiOAHE4MPHY9v9wtLwkE9NVYAErsXrTlO4LbvE1IUBs7DSMkyd7AA4dfF2dIycxUbosCkbmIe/XMvu0Plj4yaq3QXDJVUejqzz5j7EymKnse7pFlNeCAqp2+Jh43YHU0aDLmN48g2CXsGMuHMZo/iXoTV4kEJLbNtssc/bo6o59MpMTxxyhyG9zViimWzTY00d4DY+9zgpP6ljpGW2od1jDcfA+u5rWB08aibWMvbr12sYI+vpMWCxexD3FvPpTJFGpmJsY4hRVc4b2JrJeY+kPPa8tjZhk5HYCHaPfu+5dwiDeU0cxoPovm3cB/fivh6iFo5QIi3B8BafecyaPrLtXib0aYDjt74nHeTZD1OcSSZjKebTmPz2OGst3d74ytQcRzNw0fN78viyx1+MAag2g5W66Rs/nq+C5zWzOgqtwAS+A+TEcl66dz1iA3zOys8IeRNdLVvDjOg4vrVeT8KWe74sLAYNXRU4OJVeUpgbH1KMQVUfCIL6G8dnICpQzQoUaRRTy66ja4VL9rmdvya0fG7JW/Wisx1AW84Vpl4Yi3Mrb0jccqjJzsub8AVXvz1iPTzPzy3u93x2udRHae/gjPS3/Pdy9KDrt5OhVCM+TOEhMz6kMyJkd9VjQeJP4828NbYDDhj0ZH1urT6DST2fea4j6nuhXwRjZuGqob0S8KP9/5H7dAS8PoWf6ykmwE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(54906003)(40460700003)(356005)(6666004)(36860700001)(40480700001)(336012)(426003)(44832011)(316002)(966005)(2906002)(36756003)(41300700001)(5660300002)(86362001)(4326008)(70206006)(110136005)(8936002)(83380400001)(70586007)(1076003)(81166007)(47076005)(8676002)(478600001)(26005)(2616005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 14:26:09.2923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d64f289-ca3f-4c26-7d8c-08dbd0af5695
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7465
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML DT schema for the AMD AXI w1 host IP.

This hardware guarantees protocol timing for driving off-board devices such
as thermal sensors, proms, etc using the 1wire protocol.

Add MAINTAINERS entry for DT schema.

Co-developed-by: Thomas Delev <thomas.delev@amd.com>
Signed-off-by: Thomas Delev <thomas.delev@amd.com>
Signed-off-by: Kris Chaplin <kris.chaplin@amd.com>
---
 .../bindings/w1/amd,axi-1wire-host.yaml       | 44 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/w1/amd,axi-1wire-host.yaml

diff --git a/Documentation/devicetree/bindings/w1/amd,axi-1wire-host.yaml b/Documentation/devicetree/bindings/w1/amd,axi-1wire-host.yaml
new file mode 100644
index 000000000000..ef70fa2c0c5d
--- /dev/null
+++ b/Documentation/devicetree/bindings/w1/amd,axi-1wire-host.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/w1/amd,axi-1wire-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD AXI 1-wire bus host for programmable logic
+
+maintainers:
+  - Kris Chaplin <kris.chaplin@amd.com>
+
+properties:
+  compatible:
+    const: amd,axi-1wire-host
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    onewire@a0000000 {
+        compatible = "amd,axi-1wire-host";
+        reg = <0xa0000000 0x10000>;
+        clocks = <&zynqmp_clk 0x47>;
+        interrupts = <GIC_SPI 0x59 IRQ_TYPE_LEVEL_HIGH>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 7a7bd8bd80e9..3dacb7ed6e3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -890,6 +890,13 @@ Q:	https://patchwork.kernel.org/project/linux-rdma/list/
 F:	drivers/infiniband/hw/efa/
 F:	include/uapi/rdma/efa-abi.h
 
+AMD AXI W1 DRIVER
+M:	Kris Chaplin <kris.chaplin@amd.com>
+R:	Thomas Delev <thomas.delev@amd.com>
+R:	Michal Simek <michal.simek@amd.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/w1/amd,axi-1wire-host.yaml
+
 AMD CDX BUS DRIVER
 M:	Nipun Gupta <nipun.gupta@amd.com>
 M:	Nikhil Agarwal <nikhil.agarwal@amd.com>
-- 
2.42.GIT

