Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D8F7FD599
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjK2L1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjK2L1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:27:16 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299FF95
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:27:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D81rn62ANQQ+r1MUDgrXX5wty0HZpH3yQGRZe/UcgTstxJOcjnTl7nua/PWnAEk97GathmEcV3tWLhOapjkc1Rcrr8O3gxcJu0Y3i5OW+rRjisIHXbqpCoxm3OSOf3LlOzYvuG8WSbpqmnyCF6ZkjJMCqlW7Wz/lqIvTpARV87yGkQ9gYhuPjW7Xm94FZX3P7gImB3Vtx3qBFNPzp7UOF8ISYhUwmlhy9KpK8X18QDnh58nmclC+wO0b3f47HTaFC9Wu9KQob146zXKSyoS4vzgF1EQ+oZ40JS9SSTEH7I/+T8N6Wx202Md5cWIcn5icUiFAmos8JqdSbfIRuRSW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bc/ZwLGt2sX/0w0Lr0AjfOzv7mEqnbtBciUTaogBoQY=;
 b=LdTE0LS7PIA7T8qhWG7Fz135jI4lgkX4aBNkCaZ2eFYSdwAYOTwc9gjftfafsTqT/3r9DgqO77ZkmQxOmpzo6rkYK0Zti8B5cfWl6WEV0zo04QckaEeapJJXBqnon12mIka6domVD0J5scADAdbr4aJ1G7bPYRvD5wPROzIlus4/MPPQie/cytmFyMVZv6SdFqCEyKD9hl8gBOeeTEb9jOK2uSWg56fPBd8LL0jDi9VVsHs8VuWpObvLAxYz6+xewnsls0ZJETsPSclA+ppLBkCNE1JpMoXhcMAv4mZNIgQxjKN2Earv+E2fGWFmpS7V2fOA2ILs/dTDWN/pb3DWaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bc/ZwLGt2sX/0w0Lr0AjfOzv7mEqnbtBciUTaogBoQY=;
 b=SAUFS6j5sTo+kj8gkmTMtWovpiqz+1M9FbdqHIjyw2q1A25dqMK6PRDAH6NqeMm5S8Nlv8xdvhOPZm7TOw6+xi/Wypb1fRTnuU5WcQqXdexOWmfCpFIngQBA8AgW2ZLDGrCkRpbjOBva61iPVokSkUhHhjX3oXlTu9oZmhzpdrI=
Received: from MN2PR01CA0018.prod.exchangelabs.com (2603:10b6:208:10c::31) by
 MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.23; Wed, 29 Nov 2023 11:27:20 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:10c:cafe::c8) by MN2PR01CA0018.outlook.office365.com
 (2603:10b6:208:10c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Wed, 29 Nov 2023 11:27:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 11:27:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 05:27:19 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 05:27:19 -0600
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 29 Nov 2023 05:27:18 -0600
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
        <nava.kishore.manne@amd.com>, <sai.krishna.potthuri@amd.com>,
        <robh@kernel.org>, <marex@denx.de>, <arnd@arndb.de>,
        <izhar.ameer.shaikh@amd.com>, <ruanjinjie@huawei.com>,
        <linus.walleij@linaro.org>, <shubhrajyoti.datta@amd.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH v5 3/5] firmware: xilinx: Register event manager driver
Date:   Wed, 29 Nov 2023 03:27:11 -0800
Message-ID: <20231129112713.22718-4-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231129112713.22718-1-jay.buddhabhatti@amd.com>
References: <20231129112713.22718-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f73b0fb-4b7d-41c0-b6f0-08dbf0ce2677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hMAS8Pdo+hjzWgUp7u+DHb6u+OY1YToqCiPaK5h50WdzAGUYrILdvDEkvznGdDCDUAeP3jf7bD1aRlYQlsS1lHn8mDuk/hTYtkxz9VgFSGQaBETYS+kKLC032r9nvdoEF2Ym3j3WABQ1lWQv91O78GYQQJGGspY8smSni/upGeL8cOO56KS/hoER4VFCbjeD2z2L6Y/nhVXSrfjsyLFjngDhdBNiEFABPaHQWQKX0HWDrtw4vd/00+/iy+R7/d9+IqBii/ripRmDszBYy9jF7Gb8ia8RBH2BnFXFkexU69yh8rmQVP+/mDH0K4k6O86iLMD66orOlNrvpFIbjW2bpwyp70x4c9QduU93kYFLR+GWXO1ZHTsYfRMLExJ7TqdcGdTQGMGpxYvCZFU5nf3+ZkjwRVIW+lXHDLG991gNX2HUrNA5YBHvAtocS759CF4B0K6gbKOERX297pjDLsqPXaq6et+BKaAU7lPHmU7cJiHUMKLNcr1Ehz3vqNMSvJf9HMwGxWPOfFiG+y9T//z2KeKSh1mDENuYDQsfpofyagMSdNjS2h9tHyHqxCyH4NKkwsww3wtGBuYZO2f/V5lsQWFncO83dg9/1cmVSgQM/c8P/ARQwwHPDL7GGS539U/60Kf7bDgRbxEYKeIs6z+4lBrUKHYjNcovo20w4UkwLzX4BLqXvcpY63CcfMrEg4LrZ+fDmmeRrEprMjA2oQ4RTfKLBEXH2a4TK3jI5d+VnvkIkWsiElEOJNU0bEwWPTtGd27qWCek8bFYOacua7zyzJ0j/os8QK8tzIrwjL32CLM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(40470700004)(46966006)(36840700001)(83380400001)(356005)(47076005)(81166007)(40460700003)(26005)(1076003)(2616005)(921008)(54906003)(70206006)(70586007)(316002)(6636002)(110136005)(2906002)(4326008)(8676002)(8936002)(5660300002)(44832011)(86362001)(41300700001)(6666004)(36756003)(478600001)(82740400003)(426003)(336012)(40480700001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 11:27:20.1897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f73b0fb-4b7d-41c0-b6f0-08dbf0ce2677
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use family code in order to register event manager
driver for Versal and Versal NET platforms, instead
of using compatible string.

Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 3bd03ea0d5b9..5db8577711c6 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1916,7 +1916,6 @@ ATTRIBUTE_GROUPS(zynqmp_firmware);
 static int zynqmp_firmware_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np;
 	struct zynqmp_devinfo *devinfo;
 	int ret;
 
@@ -1979,14 +1978,12 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 
 	zynqmp_pm_api_debugfs_init();
 
-	np = of_find_compatible_node(NULL, NULL, "xlnx,versal");
-	if (np) {
+	if (pm_family_code == VERSAL_FAMILY_CODE) {
 		em_dev = platform_device_register_data(&pdev->dev, "xlnx_event_manager",
 						       -1, NULL, 0);
 		if (IS_ERR(em_dev))
 			dev_err_probe(&pdev->dev, PTR_ERR(em_dev), "EM register fail with error\n");
 	}
-	of_node_put(np);
 
 	return of_platform_populate(dev->of_node, NULL, NULL, dev);
 }
-- 
2.17.1

