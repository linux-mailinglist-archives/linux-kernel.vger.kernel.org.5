Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42BE7E7EB5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbjKJRrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345973AbjKJRpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:45:54 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B41A8A60;
        Fri, 10 Nov 2023 00:11:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxmYd6/1ReUkiumevzPuLPyHdAPcCSQXrN6elUx4ecMsDkgOIowm4zIUa+ZK4WhUGB0OwCj3k283vPibuGhLRLKbx+U/qUNBVS8up4RqZZYDqHmEOaJFZibciJxa8Kb6WQkAc3nSZM/JhXU7J17SvSVrwEvBChZn8n+V2OTfqDi2jTDAz7mn3ozc1anxEtQ/ZJtXGlBWVrdQpRJJcI1xKpc/vuu4Nv1YLfNAsPpoNbozmqH5xVeFJzWBbmTBTx1e/FVcYy2PKWsECB1tDE55PxvvKWXGnQKhDMPg9CAOLDPnEO/HZZ/RsyWgivQhgQ0KskrDKM5JtvpgS+/GigKgDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZTvxu960/Ln9l61K/o9qHg7+qN+xzlDiSKWIPukt2o=;
 b=XFUFdTnRkjjurLUvSloMHGWugwqlVXe6d9QS/HG5xe1zuboZWDTBgCkY09b230KbNo6mv7d5Ohy6JoVD9VwYZ5i1qSdNO5xCxVvb+Img9MgSMteVaQqFm3lKqFQV7RX7MhAVjabkFAVHNiVtCi93K1LiLEF7n06mZPWC63we4fyfPRfyL/R1OWVnIOBtG1AhbqUvWSPVbJaecIjcG/9f2d+z29FzacExgOP/7Wo/iXH0ld8apsDMi+845Ov9W3dndcA4JMQDARw57Y3xU4uscc65Qh6vGhd92r2HeWR5wg7jKZsTDS/hdowPWOJKJ9IAnvJGH4YLDCEimdq//CcoNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZTvxu960/Ln9l61K/o9qHg7+qN+xzlDiSKWIPukt2o=;
 b=fDUmST/WddUnMUKAjSJq/Wq17DnHOC2PSLRA8rstlBI7ItWyL0RzC3M1uu7F26aXD6pN0FR2Y4K4mh7wS6/nndSSUaHllLvIr3tgRycRU1zSJP1bhCsBnyyUynKq3w68fExsJY1F5S1lF0kcwGsfOVY1kQrXy9+sq+41BxGyBnM=
Received: from CH0PR03CA0449.namprd03.prod.outlook.com (2603:10b6:610:10e::25)
 by DS0PR12MB7583.namprd12.prod.outlook.com (2603:10b6:8:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 08:11:10 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::81) by CH0PR03CA0449.outlook.office365.com
 (2603:10b6:610:10e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Fri, 10 Nov 2023 08:11:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Fri, 10 Nov 2023 08:11:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 02:11:08 -0600
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Fri, 10 Nov 2023 02:11:06 -0600
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
Subject: [PATCH] dt bindings: mmc: arasan,sdci: Add gate property for Xilinx platforms
Date:   Fri, 10 Nov 2023 13:41:05 +0530
Message-ID: <20231110081105.3295037-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|DS0PR12MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e9f3157-0a03-444a-842b-08dbe1c498fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MZcibu/kNGTH+PVBI4btOVP4Q/rsm4mCUOMUyGBGrFJyUaPhI3G910UeUR7d9yBtqgKJ42E4ONt7/5hOx+S9IHSoXQXBIaEgSrLZTby4WB1H87OxzLRK9ljtLVfJInRe3Q+VdM+VOzRe8AtL0YZ0MaLjWg8u0TncushRD9baOhyZvUJbOT7Bo1DpvxJbow52XA0HqV6dRDfXmPc93xMyGjyL+yfFu5sXMI9gVg6bK6zmHQPvWUj04mrAC1bZxMNjjH8yZfB2LbuoSr9K7l8Gtj7dTMMkr0dyiwk1iGj5PdV3EZyYGyzMwKsje6j0H9hF1oKrNXFVCqeu07mJ5g03MlHX0A73qzOQNECG1Fi2q7Ch11Dd9sMKXe3EMqonIh4BZe8Ey5Js+11CN/p1myTQCHMyyrmRc9KgD9BxSn4kyIqjvhBJEixWq5fB3TEhCGeDJMLFJAyerxpjVocXS9kmdGLQDpIbXBVCwYoMaaRFSnwLVaTxUQJvMd7dzsRtgacksbtQA22TwJcRT1sgN6s2a0M9WQAyP6o6sH5Kldm2J3hJ3yYFrqk5UA9e2C6+gX8q31Jx/VQopxt2odqGa08nyMIKy5cK3jiGKEPjuiogE5ZP8n3DM8iS26tk9h4dUsT6CXQYYLRL3txqkl6adXwyOEStfZNTVA7ZTlHVwfI/W//U5Fo+52uY6+hVIhnMBVPug544ZW8Cbu+KQumbjvmfwKb4IYuNDvLrEuL13QmrbT175PrN4U2hFzp4DKfJru1N/5Ao3n73MVTgK7fydWRRnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(82310400011)(64100799003)(451199024)(1800799009)(186009)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(47076005)(36860700001)(41300700001)(36756003)(4326008)(8936002)(8676002)(86362001)(103116003)(356005)(478600001)(2906002)(5660300002)(316002)(83380400001)(110136005)(82740400003)(81166007)(70586007)(426003)(70206006)(54906003)(26005)(2616005)(7416002)(336012)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 08:11:09.8866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9f3157-0a03-444a-842b-08dbe1c498fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7583
X-Spam-Status: No, score=-0.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
---
Note: This patch only updates the example nodes with the gate property for
Xilinx platforms.

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

