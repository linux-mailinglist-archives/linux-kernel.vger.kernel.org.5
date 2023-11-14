Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2A07EADE9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjKNKXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNKXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:23:36 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853F083;
        Tue, 14 Nov 2023 02:23:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYOaxv73hiVMFJARDvhwo7eYcJWbUB/iSz10iNBLEm9wYhj0gBPS9B5oSshwnhCec1biGn8RmM0UJumtu9m9JeEv0Q3UuEMhhryqE6eYnihhqmJxB0nXSHjlfOmUgrJ+TrKrKv0u5sqQ4cuSPHqury78HcBI36HuPJYdomuRTv9Rk/hIxpqjdaRHMZJXXJw6q/BNtnqA4JmtVA2wvddLCjX6OKkrnAK1htGo4dO7XXEF4WjIFkzsXF9qVF3dQniW69AMGQK0A7bJz/welSx95L1/IxnKZNc3hAqr7r75ThXiiPU8uILoLokscsQZytjCqJErkN7S3JvVxN+L8fIEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ubI5IiEL99rDFZ3f2L/n5Q1zVEJfO7x5Uk3ivXQMAY=;
 b=GkhyRW1vBIkWt+qSE0u1ArpkfQl1oVJwm7uB3THO9xFSrHJ4h1ne0QZB+6tlRWll6z0Yi/eUmC3qO2qFKlJQc3j7LhpPGLz97U4QmZ2Qxiaz0n+inTrL3EOvto5th+9k4sLpvajH8hcW6jmIyC5DHKHgk6r/R/Nrd/TO0OjD/6ZZakPxKzEV5xSGi/4bytcX0eTXfPdjC+NE9qB+/ZVCpimEUBgyr4fVIHpwEp1wmgXFYF3FYm8cW1HCd8ed8315BpQ147L/gQGcfRxOVDw4/m/G+lZenn9mz/zdX2KWnzopf88gxxygMlhFgHLGNs3WBD6s+JlmqzbooXS11X+tPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ubI5IiEL99rDFZ3f2L/n5Q1zVEJfO7x5Uk3ivXQMAY=;
 b=j7PaDjLHCMwneaLYDEjvu7Zts7uoM36TUGehH0ahunn42TZvfGv8BXR5b55abTN+nzBJ06+yWNPQ4OVBDZ7HUdehtfgOmGTBvY+6Ne2guFI5lJ9NznsAg0aQ2wFDS7PSZnDqxEFanSCZJYHIMrmPWvdm7DYgIqNaz2ZLtL/sUcI=
Received: from CH0PR13CA0022.namprd13.prod.outlook.com (2603:10b6:610:b1::27)
 by CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 10:23:30 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::82) by CH0PR13CA0022.outlook.office365.com
 (2603:10b6:610:b1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Tue, 14 Nov 2023 10:23:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.17 via Frontend Transport; Tue, 14 Nov 2023 10:23:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 04:23:29 -0600
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Tue, 14 Nov 2023 04:23:26 -0600
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <git@amd.com>,
        <saikrishna12468@gmail.com>
Subject: [PATCH v2] dt-bindings: mmc: arasan,sdci: Add gate property for Xilinx platforms
Date:   Tue, 14 Nov 2023 15:53:21 +0530
Message-ID: <20231114102321.1147951-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|CYYPR12MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: 3275a7cb-f149-442e-beee-08dbe4fbbf82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XMQsZqWJS/b6i9azFvwev7ky+Xo2xjzmjdgGPIw8ChbQAlf9YmnhwCuS4NFeHMYftg4fH6NRRfSHgQ0Ip4Zm6W0mISkzF7ZlueHwc+kkFLAYeGeLzP13Syziupfrp2HkieBXEQMFHsnH75+fkKue3YGeEIPX4DdU+tvp1HOD+8BgbQUDnROgNUmnim37vGhk1oZzGJZ1sJuWzdpqoXoeGaxg0fwLYykunRF5/ZkoCvp5C8CJ0tc1KX5R835vYOKtMG2MOyMq5L6e3n10zh0qmI7wWT+Edfm76+W6wyKAPNyO3MF2pbOJ1vju/RiM516Fn2VMGsTg5F1ODXHTal0JTpVzG1/xnsp8QSP27t21BVT3VddXIH/nRUjYSLrpsPkBOCiu6Zrm9QK92s833iTws2l8JPghdJ7a+5KKCv8T3BSijf9LfEzI5+Gnlr+RxYl4wmlb3Hy4TZLKH47nJbHMJKUlRALKzFZ70yz2Z4R+2AqiKdjJZbaqyLo2ZIaYzrU40YD+/t3mRjPxqjh68LQSkTZwBcKCZgpvKoEc7gGeRczB8AEUPHWLmowlFaYun5P0512NXUbBXjWMiVDxW7BbICGDIbCt8ofRJGMLSYhtspm3QJxoBasJHoRInC8uC0rG4SDsEsOgOFZ+vIqufE+tgGx5RHwE8kh4wTOtb2AJIBTOnrb48F9CGFQ/whPpOAuKAW3KP23RGKdspMi8gT9w9DI0T7G8gQvxhFv3KPD/7Fy484fYIF+zv2+5krJwIERi73P8jTp2/T6XZs1w5H8HtQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(64100799003)(82310400011)(1800799009)(186009)(451199024)(46966006)(40470700004)(36840700001)(2906002)(36860700001)(5660300002)(7416002)(86362001)(40460700003)(83380400001)(356005)(81166007)(103116003)(6666004)(478600001)(41300700001)(47076005)(316002)(70206006)(426003)(336012)(4326008)(2616005)(8676002)(8936002)(70586007)(1076003)(82740400003)(36756003)(54906003)(26005)(110136005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:23:30.3216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3275a7cb-f149-442e-beee-08dbe4fbbf82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750
X-Spam-Status: No, score=1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Swati Agarwal <swati.agarwal@amd.com>

Add gate property in example node for Xilinx platforms which will be used
to ungate the DLL clock. DLL clock is required for higher frequencies like
50MHz, 100MHz and 200MHz.
DLL clock is automatically selected by the SD controller when the SD
output clock frequency is more than 25 MHz.

Signed-off-by: Swati Agarwal <swati.agarwal@amd.com>
Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Note: This patch only updates the example nodes with the gate property for
Xilinx platforms.

Changes in v2:
- Updated subject prefix to match with the subsystem.

 Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
index 3e99801f77d2..9075add020bf 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
@@ -226,8 +226,8 @@ examples:
           interrupt-parent = <&gic>;
           interrupts = <0 48 4>;
           reg = <0xff160000 0x1000>;
-          clocks = <&clk200>, <&clk200>;
-          clock-names = "clk_xin", "clk_ahb";
+          clocks = <&clk200>, <&clk200>, <&clk1200>;
+          clock-names = "clk_xin", "clk_ahb", "gate";
           clock-output-names = "clk_out_sd0", "clk_in_sd0";
           #clock-cells = <1>;
           clk-phase-sd-hs = <63>, <72>;
@@ -239,8 +239,8 @@ examples:
           interrupt-parent = <&gic>;
           interrupts = <0 126 4>;
           reg = <0xf1040000 0x10000>;
-          clocks = <&clk200>, <&clk200>;
-          clock-names = "clk_xin", "clk_ahb";
+          clocks = <&clk200>, <&clk200>, <&clk1200>;
+          clock-names = "clk_xin", "clk_ahb", "gate";
           clock-output-names = "clk_out_sd0", "clk_in_sd0";
           #clock-cells = <1>;
           clk-phase-sd-hs = <132>, <60>;
-- 
2.25.1

