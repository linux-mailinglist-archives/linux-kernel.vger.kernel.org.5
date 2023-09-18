Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03827A49F4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241867AbjIRMmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241490AbjIRMlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:41:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECC6C7;
        Mon, 18 Sep 2023 05:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3GLlz2d9o9XCLr7KFrFXq9cjfBbjfIvQsYAkpGBoMk2Kg6OtRInaGQpQqJYx6oAsAk0ETOLKH7lGj54TTx+zTzPDw8xLtghdu+KNLRTqn43xpVP2wjZ2oWB7AA1rOOmd01pzhMLtoHLByncZ2Bw4F7vvqKnnjZZaLyI8nln+BD0hapYXpTXZx75rjkmXrNTq1/TgsRRVjbF0kDLqfdT16MzOEuAY5DQkAKfbLTqGDUbSMLdK3RlGPY/SkgooBZF/vPmJFjODIcga37H8HIxrYHryv8WHtQfB1H9CFUg606iOjthxhDBrK1kKlH4Jb0JxiJxO2INHQXHmmppC6PAdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmJbAwbAIacIYlZaklNcvYgQMvO68GLuUb5mpGsGuIc=;
 b=kRueUQO0W/yFdMM4+iS+cpDIM96QF0KRHd9nZFZeDKkNg73K1I5LHJPRVSTXckPCLOL4sq2j3+H9wIZa5wVpPcWUvpH/gkoZcF0p41OGZe5Gaq6khbT05ukJBAWm6sAhhHooJhDciXokwE2tZrDLwipy4dE757NzVOV05G2RuTesShEM1gAqmHBun/s+Ie4V5aTMQUoO44jfbQe/PMsHznTEBmZ+Ky3iXMAht/rJ419xoewLkZANQpZRgg/6CoWAG26mP7knmvXSigWUo6TkQH9/KW5yvtWxsgf9ph4Iz2vCwhKd9wiFx4hOHYSroBwaGoBj/TJXtv+c6vXFo9I1GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmJbAwbAIacIYlZaklNcvYgQMvO68GLuUb5mpGsGuIc=;
 b=dY1TAlt+XHtVCafKOPt+Vje8tzA/46K+//W92fCvNXCybyn5YGjrLQZEjgVrivmM5ctyUDu7ZLeDK3IBSX9KZ7bKBJUAynCiv/1MKdA3nnaOlAzTyBeCgSJT+zkiS9eSIEn6enLD655cZ9/5WbF1ylfo8z4tb5yqAi8mNKBa4SQ=
Received: from CY5PR15CA0034.namprd15.prod.outlook.com (2603:10b6:930:1b::15)
 by CH2PR12MB4102.namprd12.prod.outlook.com (2603:10b6:610:a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 12:41:39 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:1b:cafe::d0) by CY5PR15CA0034.outlook.office365.com
 (2603:10b6:930:1b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 12:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 12:41:39 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 07:41:34 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 6/6] arm64: xilinx: Remove address/size-cells from gem nodes
Date:   Mon, 18 Sep 2023 14:41:17 +0200
Message-ID: <7252203d52af3ca8867764c8514affc4828e530d.1695040866.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695040866.git.michal.simek@amd.com>
References: <cover.1695040866.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2350; i=michal.simek@amd.com; h=from:subject:message-id; bh=VxjWBEG/PxOMI66ltpxdPq0p6b+3O7VYB+YnbxR7cnc=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlQO18zfM18mPdmVMefNHu+k7T9m97rM8EuTSm2cY9z/T 0z1bWttRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjIHROG+VmqeyXjme5oi2y8 Xdg0i6lGSVekkGFBI1vqH1ulX0sZm5aVr5/i+pBt0mFLAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|CH2PR12MB4102:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cc68610-d404-4854-dda6-08dbb8449a94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lybqzqikcWia4pD6//tX1FahWNoQgOwks3hDpkxJzGujGKiNretB/WhikGLFSEwAomUsVOiBgcP6cWMTPmvfA9QQq6YTJ5EjgkhuCzWSgb0aYOcS8mgg3DKvN75ZlcBtbpaipeVpb5frYJovYZ0u2LcWXoOeSq5+DmgBkdW+KJ1Uo2s5+u4uDGDUbZaZQMpqhQvyUJcLduc3NzhVzW9+EmbA8X8rIY7gKSlN67Xq/A2UVT7pa7hA+ZisFkLG81n8u037BFuWxMFkx+E09r5BiMOBpNWILOgigCKMNMaJ+nJLRg06zyJLLz6OVCDUj/1v3J2HOY4na0y6XYEHjFdlYhXWYwBDi8TzPetzN0xIDXhHVIO4yiFM4gTl9iJkDm16WH+/OjPARFUYmE4yhrZBMmr0VEJGIOvAegia6e3AWwlnTzlSxY4MPEbwmB+qVR8idQhQ6VRRHaoZ2TaWDba4cmRnkAdrzG3hCN9t7SSnLoy2IX007gu0+VbMkpdytRjr6DZYxSVHOI5RyF8Jht4QioB2qpdiIAJx2fA39L1sndVF/tDhYaZAwI4nHeAJx0444U/b86FVunOMTGKe49nV/SiwIbSRCmiq14u9b6m3UNo1lvQDkAsKxdOSnHr4edz/TBSaFmrCYnRCqGQpEPWfyMrq15nNzPTyUYOfQDZ3AuVmUKiSMyQ1nrCCYPxGn9jaBwy+8N8q2vxSonq6qIasnTA3fLsngiriR85Iilv2qIx8NjN3BE1n0yDA1jRLc/iQmE2IdjhL4D1nhhEn9Rvb3m7o9G04oFCtesypAGnjRnU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(1800799009)(186009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(6666004)(83380400001)(82740400003)(81166007)(356005)(86362001)(36860700001)(47076005)(36756003)(2616005)(426003)(336012)(40480700001)(16526019)(26005)(110136005)(70586007)(70206006)(54906003)(41300700001)(316002)(2906002)(5660300002)(44832011)(8676002)(4326008)(8936002)(478600001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 12:41:39.2853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc68610-d404-4854-dda6-08dbb8449a94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4102
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some boards are using one mdio bus which holds multiple phys and also
boards are using mdio node for bus description. That's why there are cases
where address/size-cells are unnecessary which is also reported by make W=1
dtbs. That's why remove them from zynqmp.dtsi and let board DTSes to handle
it based on used description.

Error log:
/axi/ethernet@ff0e0000: unnecessary #address-cells/#size-cells without
"ranges" or child "reg" property

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index e50e95cbe817..f5e1eb8cb3b7 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -584,8 +584,6 @@ gem0: ethernet@ff0b0000 {
 				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff0b0000 0x0 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			iommus = <&smmu 0x874>;
 			power-domains = <&zynqmp_firmware PD_ETH_0>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_GEM0>;
@@ -600,8 +598,6 @@ gem1: ethernet@ff0c0000 {
 				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff0c0000 0x0 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			iommus = <&smmu 0x875>;
 			power-domains = <&zynqmp_firmware PD_ETH_1>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_GEM1>;
@@ -616,8 +612,6 @@ gem2: ethernet@ff0d0000 {
 				     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff0d0000 0x0 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			iommus = <&smmu 0x876>;
 			power-domains = <&zynqmp_firmware PD_ETH_2>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_GEM2>;
@@ -632,8 +626,6 @@ gem3: ethernet@ff0e0000 {
 				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff0e0000 0x0 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			iommus = <&smmu 0x877>;
 			power-domains = <&zynqmp_firmware PD_ETH_3>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_GEM3>;
-- 
2.36.1

