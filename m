Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57847CEFDF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjJSGH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjJSGHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:07:53 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3C0199;
        Wed, 18 Oct 2023 23:07:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gz7hHIFSIDJFSLZPPyw10JCeqet3w5QcUt/xrAmdI51SlMbl6tmOeLab0a3z4q5oWJDYYn56gx6FsG3jDoxBJuPSPfesiXetumA0rOjyn6DfE8mm0FN043ATa5PXEJbW4+I7PuljA5Bf/XI1Xw7elcEbirHpuiUQ7ARHQSnlysu4+Sirt1GXX0YwL0Z0d+FMhO09fSZDU6zVh+3QQ0t8j7tHxxSuRgeOvFVEhRrwmxLSHuOKxzjP7EIaj7nmHXQ0B25FpGOMrJw7VjDvIp2+GQSvJDQ4DL0QYOQqnQ4zDAvmNWGt0EaZQzZ6GMw6vW3XUR7v+ou6p5bMsAX90PVUQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IB1hLuZ0KBt5oD3eyHQyYBt2H3Io8OVqckUg507Gr4Y=;
 b=BBYH0/cXUVQSlwRzVQeFGrfUwXy8A8ujb6b5DTfiY/xANz5LtounbSON6gZF2OcMlbmgllpg3ya4QeASGJ5e4FnZF7F4kHO4Bt7w2+MwVp/R0MVpZD2OXfcfofNGg+9BiYFETZda9VtB9UcJ/D+ar3lD3smW84qUyNDMnvqgtN01ahepprZWQjoVRiYHlnViPr+JN4WTEe8+LYtJMqRJ1+CkKC2xmaa//eSZIk+OBPZcwTPglEYgxhYKFMroLiKvhkBf3S9YYXytD3IM6UYWwLX3I5qZ8DmBsNvTeXxF4BfTEe2AKIcG5+5TFsdwQCSVsEWF5P4Qw48Rx0TsZBKjaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IB1hLuZ0KBt5oD3eyHQyYBt2H3Io8OVqckUg507Gr4Y=;
 b=sLHZrd48ATjQ/j4QDfZIHkNzzCBjGG7vFWmt9+4W2D7Q2dquf5DDgouO7bJUygeUaGM6lP2D1PAjj8i/CfGBwxpEObS/jH4CtiB1w930tcBOmhOZ1mHZGV8iurtx1BDKddpuQDrdbLMUxVrbDgZi4aAhHYDFNk0YbCafGcCDZ1Q=
Received: from DS7PR03CA0224.namprd03.prod.outlook.com (2603:10b6:5:3ba::19)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 19 Oct
 2023 06:07:39 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::cc) by DS7PR03CA0224.outlook.office365.com
 (2603:10b6:5:3ba::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Thu, 19 Oct 2023 06:07:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 06:07:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 01:07:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 01:07:26 -0500
Received: from xhdharshah40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 01:07:24 -0500
From:   Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <praveent@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 3/5] arm64: zynqmp: Add ZynqnMP nvmem nodes
Date:   Thu, 19 Oct 2023 11:36:49 +0530
Message-ID: <20231019060651.23341-4-praveen.teja.kundanala@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231019060651.23341-1-praveen.teja.kundanala@amd.com>
References: <20231019060651.23341-1-praveen.teja.kundanala@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|PH8PR12MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ac8ba2-80bf-4a2c-1cdf-08dbd069b28a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IWJRvW9I7jgE2tiW54GRJMAvrctM4a03nNb28Ug8gWWMMjM4zT5eYq4XMzHW9au7rvHenAKS+pbiUECqNwrXXmc9SeR26AHhbSZTlo/e9bokUH0155rz56NwVPoVYvtc8Z9Yq7TYcx7Sgu4iqttZAwFCUq3hTxmjMU1SGYvZqDXKl3BFbkMn8v0SfhRyh7/ta8ct1C0XabDuWlrSvQ31x7tAe4gpMpEyMXBvNaG9v/ioW1iTcL7h7QoxLKsPik7mVNP/asjBV1DfOy1YZQMYD0YIlQbR1kfGw+lkX7+/L5yq3SnxcxbMKMcopWYVquGFRyT2t/5TUurwL+/JobY40Ql8FOhqDQkZx/OMyzqoHclumh3O4qfgfUWueRlzPAZUpQ+8aXgS1DoG5N6veFhGKaDUHcFqNvHGLZZoYW4kqth/aqntS4pFniRU3xIQJbkE3YnvZf1xJgP6yxPetYXl/UdFiQDuSCxeCWnu0emCgHPOE75BmlXOBpsoUlEyYiE6gLAIpL/vnF6Ujx+nsLbZDunqh2gL4GKKJxUdT/Kcg5yZtl1CNaJBwJarj4HDC/WdNSzlvRLEXfIkbzZlHSWLqdFnd3LKzEN8VKdnx31mmEQHd+xb/ekQicbRv405fOFqrPSd+31heyx9A4eGvMqbQeGqad24UtOvdUhOYlx5xdKSDb3NPP7Ijguy5XcmGNrxQyIX3MKCXt/vwOTMebubTyX+Y2/FVcQTk0JujmbFG/POO2twPpvLkUuto3drNt/ZreSON/pslwS1ldGfK+v2mw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(103116003)(81166007)(47076005)(40460700003)(478600001)(356005)(5660300002)(70206006)(110136005)(70586007)(4326008)(36756003)(41300700001)(8936002)(40480700001)(6666004)(8676002)(316002)(36860700001)(83380400001)(26005)(1076003)(2906002)(2616005)(82740400003)(86362001)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 06:07:38.7658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ac8ba2-80bf-4a2c-1cdf-08dbd069b28a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nvmem DT nodes for ZynqMP SOC

Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 59 +++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index b61fc99cd911..b7433e6b9d6c 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -194,14 +194,69 @@ zynqmp_power: zynqmp-power {
 				mbox-names = "tx", "rx";
 			};
 
-			nvmem_firmware {
+			nvmem-firmware {
 				compatible = "xlnx,zynqmp-nvmem-fw";
 				#address-cells = <1>;
 				#size-cells = <1>;
 
-				soc_revision: soc_revision@0 {
+				soc_revision: soc-revision@0 {
 					reg = <0x0 0x4>;
 				};
+				/* efuse access */
+				efuse_dna: efuse-dna@c {
+					reg = <0xc 0xc>;
+				};
+				efuse_usr0: efuse-usr0@20 {
+					reg = <0x20 0x4>;
+				};
+				efuse_usr1: efuse-usr1@24 {
+					reg = <0x24 0x4>;
+				};
+				efuse_usr2: efuse-usr2@28 {
+					reg = <0x28 0x4>;
+				};
+				efuse_usr3: efuse-usr3@2c {
+					reg = <0x2c 0x4>;
+				};
+				efuse_usr4: efuse-usr4@30 {
+					reg = <0x30 0x4>;
+				};
+				efuse_usr5: efuse-usr5@34 {
+					reg = <0x34 0x4>;
+				};
+				efuse_usr6: efuse-usr6@38 {
+					reg = <0x38 0x4>;
+				};
+				efuse_usr7: efuse-usr7@3c {
+					reg = <0x3c 0x4>;
+				};
+				efuse_miscusr: efuse-miscusr@40 {
+					reg = <0x40 0x4>;
+				};
+				efuse_chash: efuse-chash@50 {
+					reg = <0x50 0x4>;
+				};
+				efuse_pufmisc: efuse-pufmisc@54 {
+					reg = <0x54 0x4>;
+				};
+				efuse_sec: efuse-sec@58 {
+					reg = <0x58 0x4>;
+				};
+				efuse_spkid: efuse-spkid@5c {
+					reg = <0x5c 0x4>;
+				};
+				efuse_aeskey: efuse-aeskey@60 {
+					reg = <0x60 0x20>;
+				};
+				efuse_ppk0hash: efuse-ppk0hash@a0 {
+					reg = <0xa0 0x30>;
+				};
+				efuse_ppk1hash: efuse-ppk1hash@d0 {
+					reg = <0xd0 0x30>;
+				};
+				efuse_pufuser: efuse-pufuser@100 {
+					reg = <0x100 0x7F>;
+				};
 			};
 
 			zynqmp_pcap: pcap {
-- 
2.36.1

