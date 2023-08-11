Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09187796AE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 20:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbjHKSFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 14:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236829AbjHKSFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:05:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055E130DD;
        Fri, 11 Aug 2023 11:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtI2vx6uOhSL5tBlWrZoyBCRC29jdr/e/AMQJH4y8/3erYgqZCFcaxYHl51+a9CtgO8PL/T6IrSeNav+dM9wzu9QE0OupAri4aQcwQcXyJ7KTcdHU0nKoWogbHENtwIP4KVFDiKAS4D6v5Efk/SvuCmQKsucOR4N8YQBeScUDYf6WlTQrlEir2aOEsgs94RlBY+9pHkQ/b0ey9/ipvAonFOvAH+8Scje1C9cJB+MbF5rETPmn9rYUtdOCoCOwrpzdD6qThSQRON5BdMRyzqnlh0QkYxbUSGqT7xk+yZqA9LqXPZVy8HM9EPgRAvlk3VEryPIjWkNVeV9IQbILKiDUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIULXGIP/9zE9qKKh15P7DwPq8RDJ2/MG8LkZS1UI14=;
 b=PMWGJ4d1TlOdB8WVVFRYZNqSA29Gg6FHxL9kexLwe0kmBqzqhVBZwZCtOEj01bR5LECkLcry/2+tRwLIv4ewPfkqBBnvMQ9URc3m4bRERjlNk+65k9Ej7ocubFwHaEhSkFH4ZMdmZ7QFK8Qa0uCVzPorjKQIYhNBGXYXb5eFIkuTHxjlNIDatOvic2Zg+TQjNV4TEDIxM1cE/x9B8u6yB0utRXpTZ/qZXI/LFHappwnn8NDcayGsTMGyupZSCt/PsLAUvVMdosa6SR2DkNmX+E+gIj2lwObVMHQfXx+kBmJuyLZJdBTSZThnyYuxNtXIyH0D/w7amU0YZJcYp0V/Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIULXGIP/9zE9qKKh15P7DwPq8RDJ2/MG8LkZS1UI14=;
 b=RnCu5giy1JVqVOil9hv0qX9sW2QZBLcTm7Cncnppva98bVs0MuIWqmm5Q28W1foC3748NSiS5Y8Gzv7CIAxuIwwQRJuar231y5IyY6eYkYpMBTcqx9PqjrQhcyvMi+EcPAgiKu8CkT5F1gT9He9Ir9byjFk0Xh5uZgHnu/e3GH0=
Received: from SN4PR0501CA0117.namprd05.prod.outlook.com
 (2603:10b6:803:42::34) by DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 18:05:42 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:803:42:cafe::5) by SN4PR0501CA0117.outlook.office365.com
 (2603:10b6:803:42::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.7 via Frontend
 Transport; Fri, 11 Aug 2023 18:05:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 18:05:41 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 13:05:38 -0500
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
Subject: [PATCH v15 2/6] dt-bindings: soc: amd: amd,pensando-elba-ctrl: Add Pensando SoC Controller
Date:   Fri, 11 Aug 2023 11:05:15 -0700
Message-ID: <20230811180519.29644-3-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230811180519.29644-1-blarson@amd.com>
References: <20230811180519.29644-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|DS7PR12MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b84adeb-b16b-436e-0132-08db9a9593a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: reO3HrYB58wnW8ZaTjJZHePmvZDhDZInC3Y7Pxas9PUyg3qiZDIhsGW2xKQKBN0FTpJGRyHeyryzrzzc/3jwGZoKlWVzsX10mPdeKpFD6UlqvtdDp5D5SG1q8vl1iXtfQZ4zN3h/JZaWfJeywlTl6+T6QiKJsLJWNddcjYzx6/2eKfK8zRCjfN/Vm6bV/kUMbqMo384HeqIZ3k8lnpFW8yNk7drGWSI1IjEU2We5d9FewJKEnDpOMR6p4Eusw4mhBNi7EEYr43hkzuxKzlJM0Bhhjtw6/r5nf97A54NzAxAHE/Mk5hHETVRX5E3enyIlvoJ6Z5GkRX4KOgcq8EcKGLOZpklk2R9FsSCSFHSV/slbmBj5nHsJCXxG3GRJR/g4GE0E4j9UVnQfiU68Sx+21+EytBbKZstx2RhdRKb+gyMeeNRtupWjF2sicocoerx5/mfUfLvgSOrsoQYFKfqbHvPjB4BZmk309CbioYVOd4zHkDrJjcvtYcbUGPxdOx43PnoalDQuHYkgCiv6SUWH8DsMukXblKFARKD4ZVvFwkfFqrkt7Ol4embc2vZSOAzw2moMb8xCYZKK+yzCymiKRnkb0MUIYXBUrypPidSCal7JkRAAkhpTrQ+nWyC8RuWMaWjMTftJI3oo/q8MgC+HTFC/92yszouA3OsswLYjlNR8zHJPmRaJYeieYLw0+KwfC1s/HPuBEtocImPAogaz92QA2p5FOK5eJ6fXR/fivgSTfGyBeRmoGM/cYfn/buqUM69xps8BycL4B7gKO0Hs9GbSuhKbvjOnUSAoHhOJyt4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(186006)(82310400008)(1800799006)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(2616005)(47076005)(8676002)(316002)(426003)(4326008)(8936002)(7406005)(7416002)(70586007)(5660300002)(36860700001)(36756003)(356005)(41300700001)(82740400003)(40480700001)(70206006)(6916009)(478600001)(83380400001)(54906003)(81166007)(966005)(16526019)(2906002)(6666004)(26005)(336012)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 18:05:41.9973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b84adeb-b16b-436e-0132-08db9a9593a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

