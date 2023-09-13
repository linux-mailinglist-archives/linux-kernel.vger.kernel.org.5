Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DF479F40C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjIMVud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjIMVub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:50:31 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82BE1739;
        Wed, 13 Sep 2023 14:50:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMKPOUHVyEo5+hwlCvrix6gMnvRVS3eDef+3xmtrkUt92mQkuwhwCDsi1OLs/OFR7dFtVIDXlCwWUDXiY+eJ3cakHALVlZdTvPmuPbSm5CPbFh/m23KH+MCPoD5iXwtAP/+cynkQkzkkPCXQWhUaBcacAIjMs5eglP4USyMklikn41V0UnI8W6nlRiozUOEZBSKyjd0391e3yRQZkLhKE5aVxrTOFbHyaOfOT0JIRIUEH07iyedwXTf4zNNo4dxZ5QThlOwPaE4yGZy896ER2QSm/DMVZP917+O9OvLjdujDJ9w/bU2lVST1D1MIOzcEHPpM8CxjJaOHWufOeanNgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIULXGIP/9zE9qKKh15P7DwPq8RDJ2/MG8LkZS1UI14=;
 b=DwoBz3UbxSlDwiHhtpZrF6c1DB5/UnCTPMrxeudok4QPUsnHcldZNcfHsHIPQQfTAgTVSpdwwX/Kr0rH3uJ2MA29XsEEBJdcKg0O+6I9r2KvERMmCPuDqF1fIkc9GJEo6IoqlJxrpZf74fDR8qDi0H+3lXJuYN+Nbggjm9IdUJoWCmXMHTUV2z9vLYzteIDny4B6uXOQ9uSwHrmu9h63LuALuhXHnoX1eHX6XhldB9m+6nJdcwNLaAfyDhZ58ZQQ8HAbyEFqDwHVqx+qk5+izO+uKRUc+4dZTAR6TJ+EQ8mS3Q5C8SZpWXeIpvYo1E/buX3N/30/Wart21RqPF+Tew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIULXGIP/9zE9qKKh15P7DwPq8RDJ2/MG8LkZS1UI14=;
 b=YZFRMUT6hDMRJmWoRacGQi+M77kk8cmy6yr4/8njEjebknfBr5pCavSEwpvwCkNyryIMoZlbVV6zilcNB5Wj2/h5fnVMUt8uNgiHec2Uc3uGHFERhgLAjI86DJ4qswd4NMSmFQ+RpwUbc6DjitpGrvQUqw9QqcDYWoWzjBonhvw=
Received: from DS7PR05CA0108.namprd05.prod.outlook.com (2603:10b6:8:56::27) by
 PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Wed, 13 Sep
 2023 21:50:23 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:8:56:cafe::57) by DS7PR05CA0108.outlook.office365.com
 (2603:10b6:8:56::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Wed, 13 Sep 2023 21:50:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Wed, 13 Sep 2023 21:50:23 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 13 Sep 2023 16:50:19 -0500
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <catalin.marinas@arm.com>,
        <conor+dt@kernel.org>, <davidgow@google.com>, <gsomlo@gmail.com>,
        <gerg@linux-m68k.org>, <hal.feng@starfivetech.com>,
        <hasegawa-hitomi@fujitsu.com>, <j.neuschaefer@gmx.net>,
        <joel@jms.id.au>, <kernel@esmil.dk>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <p.zabel@pengutronix.de>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <walker.chen@starfivetech.com>,
        <will@kernel.org>, <zhuyinbo@loongson.cn>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v16 2/6] dt-bindings: soc: amd: amd,pensando-elba-ctrl: Add Pensando SoC Controller
Date:   Wed, 13 Sep 2023 14:49:40 -0700
Message-ID: <20230913214944.59804-3-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230913214944.59804-1-blarson@amd.com>
References: <20230913214944.59804-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 326fcdd3-d01c-459a-b190-08dbb4a36eac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QvedGxVF5eoCdkctpZQjAqnlbCEjv1wYmB8O7bVBXGuDUOiai3qGlS2QaEq+gf7tU6elf0TMeLPBpIxyoMfExZFa/KamiLsD9DfTBYPllQE5Rb0dX86wBQP2xckOnaHXPkBck5piEuB3SvDHxwBaBEtl1FpFVX+1ea16stYp5uqe9jb7LfwIlAAC0v3trK/r1GshpZGPNCTvqt0NJUEVKccchzebyTK6r/BJ1IQ5k08kHuPOzRc04MGvZ/5OXFK6i+Ep+PpQNJ7V+0yr7h2vwxf7t+ob8czVAq3ykFN/0pp4ZTVlKAFFBAjU2Hr2SAZ/oqAGGei8nFLnVuG57SgaJl8SQwAVzrMxmOh1Y3L+XqVzjthaBbeaJ3V9ZNxWyBo5UhqNA8bqhP7Nzc9p81iT5MiSUC3XMMQPnDaiBVeC85SYsxFsDsw7fO7AyRZEXE3VILxnqmOKV/1X1IAl2lEgOIpSoYdx2DSyr8+g6WeVOBvBg9mcVxG4MyHb2YKRrKTtfbrmRgya2I0yFIikDhfjQWkSo4/6hF3IgXgTIW2Qe2+YK/N0p7gYsCMLpcqD194kwkW5/bKNUtJ4QdPqSj3HP/E/LCrOtksz9faxsC4ryqQ1r4JyFJ6+MET0y7XJELeWdHUDhcOdt6E3zO/8OZRJb6vV5Vql9SEkQrYWa+4G7EGhZ6GL0mpTG6QqOft9KP1OCO0e3jMyF/Dnbw6Gw9/21W7ndGIVxjwttOlBpJJIEia6ecOa92j85gBC30pmSV8q7KIv6f//JZWhu13Q7Gg2wRTXW9rIkCGqmMRfByqE0hc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(1800799009)(82310400011)(451199024)(186009)(36840700001)(46966006)(40470700004)(316002)(966005)(6666004)(54906003)(426003)(26005)(83380400001)(7406005)(70206006)(6916009)(16526019)(2616005)(8936002)(4326008)(70586007)(2906002)(41300700001)(5660300002)(8676002)(1076003)(7416002)(36756003)(336012)(40460700003)(478600001)(40480700001)(36860700001)(82740400003)(47076005)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 21:50:23.1756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 326fcdd3-d01c-459a-b190-08dbb4a36eac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support the AMD Pensando Elba SoC Controller which is a SPI connected
device providing a miscellaneous set of essential board control/status
registers.  This device is present in all Pensando SoC based designs.

Signed-off-by: Brad Larson <blarson@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

v14 changes:
- Change GPL-2.0-only or BSD-2-Clause to GPL-2.0-only OR BSD-2-Clause

v11 changes:
- Fixed the compatible which should have stayed as 'amd,pensando-elba-ctrl',
  the commit message, and the filename
- Reference spi-peripheral-props
- Delete spi-max-frequency
- Remove num-cs from example

v10 changes:
- Property renamed to amd,pensando-ctrl
- Driver is renamed and moved to soc/drivers/amd affecting binding
- Delete cs property, driver handles device node creation from parent num-cs
  fixing schema reg error in a different way

v9 changes:
- Instead of four nodes, one per chip-select, a single
  node is used with reset-cells in the parent.
- No MFD API is used anymore in the driver so it made
  sense to move this to drivers/spi.
- This driver is common for all Pensando SoC based designs
  so changed the name to pensando-sr.c to not make it Elba
  SoC specific.
- Added property cs for the chip-select number which is used
  by the driver to create /dev/pensr0.<cs>

---
 .../soc/amd/amd,pensando-elba-ctrl.yaml       | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amd/amd,pensando-elba-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/soc/amd/amd,pensando-elba-ctrl.yaml b/Documentation/devicetree/bindings/soc/amd/amd,pensando-elba-ctrl.yaml
new file mode 100644
index 000000000000..e96978ad1e37
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/amd/amd,pensando-elba-ctrl.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/amd/amd,pensando-elba-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Pensando Elba SoC Controller
+
+description:
+  The AMD Pensando Elba SoC Controller is a SPI connected device with essential
+  control/status registers accessed on chip select 0.  This device is present
+  in all Pensando SoC based designs.
+
+maintainers:
+  - Brad Larson <blarson@amd.com>
+
+properties:
+  compatible:
+    enum:
+      - amd,pensando-elba-ctrl
+
+  reg:
+    maxItems: 1
+
+  '#reset-cells':
+    const: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#reset-cells'
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        system-controller@0 {
+            compatible = "amd,pensando-elba-ctrl";
+            reg = <0>;
+            spi-max-frequency = <12000000>;
+            interrupt-parent = <&porta>;
+            interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+            #reset-cells = <1>;
+        };
+    };
+
+...
-- 
2.17.1

