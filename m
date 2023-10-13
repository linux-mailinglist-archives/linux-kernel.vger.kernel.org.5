Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053DF7C82D5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjJMKPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjJMKPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:15:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256D0FC;
        Fri, 13 Oct 2023 03:15:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSIusACd67HhsCy7InlqxinhJuxWh3sAhIYOLXAZkRFcwxYdUBVcb5ohbvHjNJOrPMsmdp7R6RIz17nIcaaZEzZCLuhUjSKgl1vWMFlkA7fH0dMMy8BcgWkUOeUMsAU4MjBLnMHbKbhJTvIg5kh8zbJYc5kZ8bf/5Om+BceMjwyMFh6WYNEFqrnc28w7AySVgxLtb5A0/Hhge6lcPgL7N9ZSHnO4sV6TqcueU/Q/rUEDO0UuAqKQTKWVaiCMuQFrA6zrsarZLx8RFeKq00weUezuOT/a/BqVTqO3aJYBBCO3AeZVxuvamJI5AMky9nwuWMqAz1/BM4f11maJqmzvDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0j79BCH9vq4RGAV4Pitapaa36NIzmPJw6i6r15vYQw=;
 b=A5i0r48WrdscMe89ctoWRl8K5mGRvixtMRX8vU1QEPLgtALKKq0ciJhyd80fsnF169MI0p4SFtvIgY0ZSiJ3pSegan4pezf+tQadX1Kz8Q7N+NukWfnnMSDAU+3dAVS+UAs6KDKco3cNb7t7sc4D123HoeCvZgt1Zu5CkQrfzowXO6JZtvJz/RE5KFXo0rZkvHKm9bons5YqSKWmb6Dl89eJ1tjY00C9sbISBketZnmS77cqGw5U/3wcYs/PIstdYotfShGLB9llIMqX10axlQyjQgxbOFD/+tonsQccSNhV9VZGtZxYcUA7uAPhYCYzRpSG9Ep1AHyVaq33r9fKlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0j79BCH9vq4RGAV4Pitapaa36NIzmPJw6i6r15vYQw=;
 b=E/r6AXqPoPDG1kKe8W4PNjpKz/40PpKI1yFEH3sBXr8uxDtf6t115oqTsv2WHNKAMHGrRPUK4mlMHXTq0JCPYNGm6rGTBlfY4Encc5VCPt9Zq8eTCPs9Mh6H4uRKcWqeNa9yIFJug7xPhFiUCrL8aeKI7hSOOsKJcZVZLdcRX0U=
Received: from BL1PR13CA0298.namprd13.prod.outlook.com (2603:10b6:208:2bc::33)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 10:15:25 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2bc:cafe::ab) by BL1PR13CA0298.outlook.office365.com
 (2603:10b6:208:2bc::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.23 via Frontend
 Transport; Fri, 13 Oct 2023 10:15:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 10:15:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 05:15:24 -0500
Received: from xhdharshah40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 13 Oct 2023 05:15:21 -0500
From:   Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] arm64: zynqmp: Add ZynqnMP nvmem nodes
Date:   Fri, 13 Oct 2023 15:44:49 +0530
Message-ID: <20231013101450.573-5-praveen.teja.kundanala@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231013101450.573-1-praveen.teja.kundanala@amd.com>
References: <20231013101450.573-1-praveen.teja.kundanala@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 20de4fc1-d978-4cb9-c303-08dbcbd550f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDZn0tvjAjezBAlHJ1cNc1+Lqk7vzvtbz4HDM/tuSxoooTFGYBljFhOdHKZ05yjydXgkWEyHpWyz3Phlx+wNVz8Fdl0N8tJgeUCpAV6QVfiPTbpCY8JwqLzuTTK/BnlUDlYgDlpBm2g2rqANXy5u1Wt/fAijRAod9BcvVGEQv8FwdNBOZKbjI3JGDbtMiv0OvrFUSRIIAUTCAYZPVHTCsKlFiigq0ohkVoygL0NdFBhD3PSf1pAHLb0uFFtWX84xqZNS54akXYfAJKoMzSCPVhbuWR4vtnWPhuqUmDaOO/MibSTZpa7BWnZjIw18xP+sHkpqRlCalrewDbVE+MrkP5ZwKCJNawVZW1y/m/Vvduk3Ho21UgUe1np0EY00OVj5/M02c+nJxFySaI2TKu3lTw4j2nbWJoO1YUyr7notgq/dHy/qy5o9MHan3j0ojLSsGzIxefCipYemzgVVo4Prd/Eo35hC9rUVo5noV71b1JCAHu0zij8t+pEFQfyK4R1HsmAQy9N2ZeWDeYhqt3YS+Io3SBtWzinyxWjTslcN9w3OTuWxmfG8bF1kjQkIkapMITvJdEnuAXWwGvIbuZ1uzr3W8GDPLoptrUYZzyJZCCzi68POHGOiB3cenM3By2synAVn4gLZkNd/HdrUprftR/G47xF5FD7b1BxA4ZPP3UyMPwXg29oEBPgSFmXm5TDQXnXTKr8tw4hOcLwU6VUwbpA9C9NVhwT/O9okWGecDc0shGU82H3l3Iv4JZ52Kk73GpGbZu+4jb0KeToSOkZy5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(186009)(451199024)(1800799009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(47076005)(83380400001)(36860700001)(2616005)(26005)(81166007)(426003)(40460700003)(336012)(40480700001)(103116003)(2906002)(8676002)(5660300002)(8936002)(4326008)(6666004)(86362001)(110136005)(70586007)(70206006)(316002)(41300700001)(36756003)(82740400003)(1076003)(356005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 10:15:24.9016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20de4fc1-d978-4cb9-c303-08dbcbd550f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nvmem DT nodes for ZynqMP SOC

Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 55 ++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 02cfcc716936..b8807dcce442 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -190,6 +190,61 @@ nvmem_firmware {
 				soc_revision: soc_revision@0 {
 					reg = <0x0 0x4>;
 				};
+				/* efuse access */
+				efuse_dna: efuse_dna@c {
+					reg = <0xc 0xc>;
+				};
+				efuse_usr0: efuse_usr0@20 {
+					reg = <0x20 0x4>;
+				};
+				efuse_usr1: efuse_usr1@24 {
+					reg = <0x24 0x4>;
+				};
+				efuse_usr2: efuse_usr2@28 {
+					reg = <0x28 0x4>;
+				};
+				efuse_usr3: efuse_usr3@2c {
+					reg = <0x2c 0x4>;
+				};
+				efuse_usr4: efuse_usr4@30 {
+					reg = <0x30 0x4>;
+				};
+				efuse_usr5: efuse_usr5@34 {
+					reg = <0x34 0x4>;
+				};
+				efuse_usr6: efuse_usr6@38 {
+					reg = <0x38 0x4>;
+				};
+				efuse_usr7: efuse_usr7@3c {
+					reg = <0x3c 0x4>;
+				};
+				efuse_miscusr: efuse_miscusr@40 {
+					reg = <0x40 0x4>;
+				};
+				efuse_chash: efuse_chash@50 {
+					reg = <0x50 0x4>;
+				};
+				efuse_pufmisc: efuse_pufmisc@54 {
+					reg = <0x54 0x4>;
+				};
+				efuse_sec: efuse_sec@58 {
+					reg = <0x58 0x4>;
+				};
+				efuse_spkid: efuse_spkid@5c {
+					reg = <0x5c 0x4>;
+				};
+				efuse_aeskey: efuse_aeskey@60 {
+					reg = <0x60 0x20>;
+				};
+				efuse_ppk0hash: efuse_ppk0hash@a0 {
+					reg = <0xa0 0x30>;
+				};
+				efuse_ppk1hash: efuse_ppk1hash@d0 {
+					reg = <0xd0 0x30>;
+				};
+				efuse_pufuser: efuse_pufuser@100 {
+					reg = <0x100 0x7F>;
+				};
 			};
 
 			zynqmp_pcap: pcap {
-- 
2.36.1

