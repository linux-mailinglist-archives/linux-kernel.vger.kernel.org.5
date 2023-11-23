Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5787F57D4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 06:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344697AbjKWFrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 00:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjKWFrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 00:47:17 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A5611F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 21:47:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbollVL2HIJsRkqSUcXtJ0pITFSAwb0l1yE1Bo1OIx5P4OH9J8jbaMVFTuJxdSTO1waEuZFTnAKWN3RNW1tc+Cd38r9F7IdAEy10C54t3V5hcI4Yky4ZDFTObpfgrXfL98TXNDXBaGzitHQAToq4m6MCYoY988O+RpwlDdrbPg0salsxIAtSiKqaxPycz09XDqyiM23ip83qcqtptJEZzIJmfPcno9KWGm0OJiEU37yLMiBvQrfnMsWpcOJi/tlxpCG7AJxBK5YZFbGSGtMnEl28mNqwdGmL8q8I5UX5sskY82KvzI+QI1Ze4aWI0fnsu9CT6fUwKhL+xyzkVHA64A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vHx19q+lNz/N56Mp5DQQhar9EClXjS2M1nbIUI5Wew=;
 b=Pq4e3uQJttr5c9CnqO041BHFRR7eHbn5vSDl2Rq072eG2fcUFTt+rymd2KGlYXsRxBGYb9H9q2dIIc9XtI7X/PbsEICPeGzVNIsXx356pTsyYLi4KNEh5tbf1kKwWz1GmpjZqoGxw4KEu6t+nvZgqRe/71X8EczYARV2cCq2VyCGg7K/jiSrCw1zhk/G6oZObNRz2ulk+wcpktHQsb+UD09xtM0s6e591HKPF0sC/zPIankXxhkS1ipkcca5fuQiiu8L60ipAtFkcz3PT8RSOzwFImL8zHvpM1ApqsenE+uucrYgKAjW8xFS3KOrmM9FAmA+/TCASi4mQRV6fvbvAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vHx19q+lNz/N56Mp5DQQhar9EClXjS2M1nbIUI5Wew=;
 b=0zpWShs1PX5HMjoI9cx9mrvyR8Oo6zAYSEOxjITuj6f1nBIe6k2L+uFxUOHjeAR0HavT91fEiIsmDHj2iA5HIXv4jEd4It93SV3In6aaeyqg24CZZTIEz7Tb5P/cDNSaVDUCskgPLVG8cvCoEuWzVp57awTSrZIC/25vGf1MBZU=
Received: from SA0PR11CA0023.namprd11.prod.outlook.com (2603:10b6:806:d3::28)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 05:47:21 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:d3:cafe::94) by SA0PR11CA0023.outlook.office365.com
 (2603:10b6:806:d3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19 via Frontend
 Transport; Thu, 23 Nov 2023 05:47:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Thu, 23 Nov 2023 05:47:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 23:47:20 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 22 Nov 2023 23:47:17 -0600
From:   Srikanth Boyapally <srikanth.boyapally@amd.com>
To:     <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
        <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, Srikanth Boyapally <srikanth.boyapally@amd.com>
Subject: [PATCH] mtd: spi-nor: issi: Add support for is25lp02g
Date:   Thu, 23 Nov 2023 11:17:13 +0530
Message-ID: <20231123054713.361101-1-srikanth.boyapally@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CY5PR12MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bcf368c-e96f-451a-fa9e-08dbebe7a95b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mfm6ZewH3FLnyghqH4kg1kcV0T1hxgajRjpR774D0IdDStV5o/44CqJ+Ld3JW8RLYWfUuioqY/JO3TZq4m4Px9OmpS5xqdHylMlVwq+BoLuebxewg9ZMW0BVy18Nxe43mR4nLx81TA4fWByrbASWBHLBJRY3B2ip+pgq834EeBiswTufLZAjcxE91pkHeTKc7J53HxjTsZroEUKstS5iQDwM4Fls4cujgeMO/u6Q8Xn88qhp5UPOWS/xidKLOmDUj/qVXdoYxDnqtTrZsBH2KHEfkolRSV8g3UHDoJ4m5iMVNjKZNSSPywt/T4lwAoHPF3S8yISRIvk3pBrJDkL7QfrFByHHh9O5J5H8ApttexoKQG1RgDEYUCdJCc9gViV5Mf5fB5FedVLTp2fRyflpI8g++cRT67tYFQPEl4b4eSpksdsuF0BKwnCRdHXeFGiHjREBF1Rf4gF38N0FpwwKrGoPoFl7JCBQM55ob2J2E42eTdmboQD5iIBrFoZSlDWUdXvVOXyplRIbhDg0YVh8IXmrKryKLHHE7A97hRS0wl/HvGnR1HhZC6Hg6AUnQ6LxifmU7gLaSk1M4xKSxFNeiiKZcE2ajcIqPGCyJrcMO0E2vAJVV4Ljnvjj6uVpnAlCsK6dynaKiZNL4npbbPhLEy56wi7ypwQ5jlJPwHoInX25sTI2qIE/JqYssOav7KEZsRtqqbfQqCbTnzrX6/gYNXZO4owXZuH5wwuaVxsqSvigiYGy7YSD6g3OEXZmC1/+kTh1n0oFXFGmhnO7lpe525zBMhaLrwQe4oDHUchm5Qvf5aB6mAoBv7ZXtbtG/3zNXszQZ7JzwRUyagamwqU0QA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(1800799012)(82310400011)(64100799003)(451199024)(186009)(36840700001)(40470700004)(46966006)(426003)(336012)(40480700001)(36860700001)(41300700001)(86362001)(6666004)(47076005)(2616005)(83380400001)(26005)(1076003)(478600001)(36756003)(4744005)(5660300002)(110136005)(70206006)(70586007)(54906003)(316002)(2906002)(40460700003)(82740400003)(44832011)(81166007)(8936002)(8676002)(4326008)(356005)(138113003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 05:47:21.3626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcf368c-e96f-451a-fa9e-08dbebe7a95b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for issi is25lp02g.

Verified on AMD-Xilinx versal platform and executed
mtd_debug read/write test.

Signed-off-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
---
BRANCH: spi-nor/next
--- 
 drivers/mtd/spi-nor/issi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 18d9a00aa22e..98df64caf436 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -126,6 +126,12 @@ static const struct flash_info issi_nor_parts[] = {
 		.flags = SPI_NOR_QUAD_PP,
 		.fixups = &is25lp256_fixups,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
+	}, {
+		.id = SNOR_ID(0x9d, 0x60, 0x22),
+		.name = "is25lp02",
+		.size = SZ_2G,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 	}
 };
 
-- 
2.25.1

