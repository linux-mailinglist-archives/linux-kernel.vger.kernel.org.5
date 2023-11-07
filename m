Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A407E47D7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjKGSJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjKGSJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:09:14 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40208F;
        Tue,  7 Nov 2023 10:09:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANM4smoQxR44184kw7l02sf1O4XOR8S7LzK6oawCx8m8kaJa3r6S0kO+a+B5wCiccK+iJmQSI2sjp1uUYamubLG2a/FWI9UM3Dsa8qCTo7qKbZJBjBystgQ+34bNms60Ey5GsayurCZ8F6jxLIVViPIvNn1460VBj9GhLyEQaHTH+y16nv+1kWuEWZNQJMz5nM22f4dQbb+k3dJNdMEi2xapn+UCivukIr196dzF3HvYEoeFYjzRS1voEcZ6uZlwumQtjeC/BkvEyeiJ8PPhv2pEh44x89CMvzaz8U1LQDtQAURUKAP+WmiFlUX6AVFVp/IlvHaQkr5BTDW7OzDzXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOtOEFslqMslUsqX//Zs45ZZhaZRf6lub1dyrku5vXU=;
 b=Cmkvws8cinL4Vzz3X2/zOqYl1lK6AYdSJv9eXlvbjIUO3jdWMVj7kRhCmBYPCD6qa6om76cFJ/xu3qljLAQJLrn0NjA3cSaUCsm3zYzV2MygE3pch+zcPkuhWWnf8rBtv6U7jvLTKSEtFtU9hbeh6NxZQRtbFxuNd2RIMDkDFrbIVylAo1v6jhhnRkUOpk8Iuo4R3sMNrIojHQs5SytRq9n5Vsn5yL3NgouM4GHypNbNMpqBHM/itE7nmcsXX+vsOu28iYrw+b0mKIt8ydAMvq61cNPwZ0ap70rTqOEwrEGFlNDu+OBL7AYiO/TWCm/KdyvH6Zkd+7mUmKvrtNX3cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOtOEFslqMslUsqX//Zs45ZZhaZRf6lub1dyrku5vXU=;
 b=ZSgOgFHiult6bwsGmeVbzS5qUpXgfZBs9xfMZ8tH8ffTJR+28T2qjtdTzwIk96LlmZbyMv/VlIDH9G2y8054N6JKKh/1so3L1sH5wQyGIb2sPcrO8nLH6ZwSFqut0jEsmGt8feoZvV1mIVKQrGsuzWSUEYg2AJuxQva78SSuqfE=
Received: from BL0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:208:2d::37)
 by LV8PR12MB9263.namprd12.prod.outlook.com (2603:10b6:408:1e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 18:09:09 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2d:cafe::37) by BL0PR03CA0024.outlook.office365.com
 (2603:10b6:208:2d::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Tue, 7 Nov 2023 18:09:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 18:09:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 12:09:07 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 12:09:07 -0600
Received: from xsjapps58.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Tue, 7 Nov 2023 12:09:06 -0600
From:   Kris Chaplin <kris.chaplin@amd.com>
To:     <kris.chaplin@amd.com>, <thomas.delev@amd.com>,
        <michal.simek@amd.com>, <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/2] dt-bindings: w1: Add YAML DT schema for AMD AXI w1 host and MAINTAINERS entry
Date:   Tue, 7 Nov 2023 10:06:51 -0800
Message-ID: <20231107180814.615933-2-kris.chaplin@amd.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231107180814.615933-1-kris.chaplin@amd.com>
References: <20231107180814.615933-1-kris.chaplin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|LV8PR12MB9263:EE_
X-MS-Office365-Filtering-Correlation-Id: efe517ae-26e8-47d7-0eb9-08dbdfbca39b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8AzlrHpaXaHswXu+ywA/baLPUDBBmYn8ZXxEOT07r6+rloaXItFKeCUiO/tQ2pbMKnK3hSLeWyUCwmxJINDIH5gsEyX9uZVZDnRAqp9MX9R8gjfa89Hwq3z0Q78SR+unVP0zCoW1ybcny9aQrxNOoNmnk74OuCjyJBGD8SEiGpV1Wltjvpk2xHp+8IgZDU2EYftMPGS+/T49CzVu1o97z+c7tRiQI5OY08b+Jlt0UN6X2cQGtAKqucpwueMe+HQ/o8vbiu1lm5QCS0qJNHmVKcDgmj63Wl1AoeFcY400oBYdiuhn6ai5StlXnpJ9wDKcC1I3dFsPLmYSZgg6XMSZH1ROKctYWUwIzwV6cjMymzZrDlsxhe+O50/6E81cT5CIqUjL4uqAxr7OkGuaOj2t7SNdn9KhMHi23D7BgcJ9DAyBAkOUA4heb8v2CVwuiM7IghkNM8nzeAj3bIFgf1na47GovQXL/esS+mgq1Nd92IWhCVDsUArPtoI698qe+AovJ6H7dxWgTPUxZizQBjgYiAL3RW6Ox0n8ZmIP5yLyr1bVmXtc8vDL6N2twrSbiahzrg2S2fA02MJWwCsU6ghYPjksRmtwQrQ8lHzFZmi+yY84EDogyfvP7DJYYKGCZU1Cnbvu50uMbsL782G35Zsc4px8/pzwaqUdkRP+jPDFgKz4CzoWCP1kx4Fzd6+lAnvPotqUghzMX95+9J3dl3wlUQkfZRMDUKWyPhVsMc6Uzyqu01NwOhbnDQ5Z3eLv4iV99m2rOY8ooIzox37eb75v68OETE4NyNdf05pNeXN19oc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(186009)(451199024)(64100799003)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(966005)(478600001)(336012)(47076005)(36860700001)(82740400003)(36756003)(86362001)(356005)(83380400001)(81166007)(70206006)(426003)(316002)(2616005)(70586007)(54906003)(6666004)(26005)(1076003)(44832011)(2906002)(5660300002)(110136005)(8676002)(4326008)(8936002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 18:09:09.4125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efe517ae-26e8-47d7-0eb9-08dbdfbca39b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9263
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML DT schema for the AMD AXI w1 host IP.

This hardware guarantees protocol timing for driving off-board devices such
as thermal sensors, proms, etc using the 1wire protocol.  The IP has a register
to detect hardware version and so the binding does not have an explict version
number.

Add MAINTAINERS entry for DT schema.

Co-developed-by: Thomas Delev <thomas.delev@amd.com>
Signed-off-by: Thomas Delev <thomas.delev@amd.com>
Signed-off-by: Kris Chaplin <kris.chaplin@amd.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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
index 375b2c87d099..2b23febfaf72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -891,6 +891,13 @@ Q:	https://patchwork.kernel.org/project/linux-rdma/list/
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

