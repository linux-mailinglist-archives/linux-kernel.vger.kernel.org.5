Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D6B78DF11
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244800AbjH3TP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243243AbjH3K2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:28:37 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FEFC0;
        Wed, 30 Aug 2023 03:28:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgYGVYGm1eVlJ8818+uOYkowMyRbXjmG2PHLgMjM6OxUuJgCqf1LoBzeOQIyCkBTJ05C3+LkIleWPjJM0cZQpHCgJjuHdI+sbs45OHHO2qTeDb47IgmNK9w0zPZLl0kDVQ9VjcBGo2/PcapaBTLdEo990nYtVFTX1sh0MhAOdxNjN4vGStxHxaP7B4b0gWYV/b3CNKzuSwWpMrliZpQo8jo+Og4HafrJTMfx9kHQXqb8ymSmjn/p7AnOccV9Y0snY29qt7+AXB6Co/LbbU2O/YYQqBf3Uf18uaVEw50yMWXS0N4zP2PEm2KcDOcQblt3LI/NmgWP/mm48+8jHqxZdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4F7kxonofKg3ZOSMP4L376m1hEgIF0ujxX+WxtRmZG4=;
 b=g0ZlnB+74u+RVD8Btv8o73sOrR8rV9+ns3dpmHOTdEje9VlgQBRSRodZN8Xc6eys7GSUG5ocb7MdoXg+Q2VBesiepdQ7saQq8ir8CeQjTjMd46yd9amLHXTppcrzzF/NRRtUTEbznEfCXi3dv2PzoY9RalUccDeJoy1b40xiZ02+r/TAszqW/tWLuynICxVx2AnivBWwuLBDtuque0cKux/5i9l7lXkeUB59bl3XWvI47UzCGa6tAnZEcPHAihhsai/JZrgm+Tu78soCgO6qQBgQFdsxU37WcPvGwt3qSeiTWmKLYIWz93VnUbKi8e+MxmJFT4LrPGR9Wv7khR+VJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-watchdog.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4F7kxonofKg3ZOSMP4L376m1hEgIF0ujxX+WxtRmZG4=;
 b=NQff9iTM7ZDj5LB+GnMP+ctygkzEiZkGXlTyfrDm5Qz9lKMM3n+/1VQ8BjwA3YnLgij4RYYdltNP92+bN1IspRQ1JgbC8xuX+fCdI/3oSmnnYvctR6ClWgdEeQ2uoBhxNbqt5VxdMijLh30XCMzyyu3+VZU75dtOY3grp9JNIlg=
Received: from MW4PR03CA0079.namprd03.prod.outlook.com (2603:10b6:303:b6::24)
 by CY8PR12MB7172.namprd12.prod.outlook.com (2603:10b6:930:5b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 10:28:32 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:b6:cafe::5d) by MW4PR03CA0079.outlook.office365.com
 (2603:10b6:303:b6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36 via Frontend
 Transport; Wed, 30 Aug 2023 10:28:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Wed, 30 Aug 2023 10:28:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 05:28:30 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 30 Aug 2023 05:28:27 -0500
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <shubhrajyoti.datta@amd.com>, <michal.simek@amd.com>,
        <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <christophe.jaillet@wanadoo.fr>
CC:     <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>,
        <neelisrinivas18@gmail.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>
Subject: [PATCH V4] watchdog: of_xilinx_wdt: Remove unnecessary clock disable call in the remove path
Date:   Wed, 30 Aug 2023 15:58:25 +0530
Message-ID: <20230830102825.3743755-1-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|CY8PR12MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca74ca3-f082-4720-0c1d-08dba943db7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iYB04P2fu1sN9LbZXLX5dA1yau9ui1wh5Q/I0Jg4ADBX2MhM/aRypYYeR4zn+9Euu90O4DRqJCBn0sinX/em3//t3IOAc5SAXF4848a0WJdo5p5VoaVZv1GyAJZaZJThnUi5MmEWMHqQ69PIC4AeuejP++dyl41pgIKatcLLdGNeCPjRTs1jskm63Cpx8WozPJplVQOXzDNgNirIVB4Ih3pDzV98A754y57wkW0UjpP/uhzbURj+reT+fbxBrgKiyVGsUIXXNfNe5xmJl5uzN0vcGiDn1sBOZtFjz5+0c7dbRZTehd/wntX0Pxa8ww6fxNUt0wnCikeQlRDQt3SarV/oHlPYXIu2oNtrnoggTDUBhCouswlTjbk01SmEm1TXIhlEMjV1ynt/auPn4LxY2gn1HWYEt0UqsIMg7Lyteb+RrwdUu0Hpry7uob9JJmuqbJPSrY2mpLxKBsXXzPQ9UsHari037/AipuXSAiTvHAZKGpRwD4UH9WSEei5P1bxN8ure8Y/J5CK4QcoueOIwe1fxHtlRbR6fqpQ0X9JdlhggSAgTlKL/w7ah9a+8Q9kTMHOxJoO2XIML3OeCBPaoxhQEgMqJLXZCplNFkgbn3JJ2CUwV2VwaQ0gVp9iV4IspGsUcA4XiXsImPAc/2z3ncVyhecLgh/t7CwYnqaESl5Db7I4AQ8a2xblk29trgfTK7/ojL+K0VKd4OoRM7ga/UV6PbZCfkD/GzZBLcTyAeK1HHiGDv7HvqceDqge7qLTJpuL9Ms/W1c5QwXZ/lXXZJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199024)(82310400011)(186009)(1800799009)(40470700004)(46966006)(36840700001)(82740400003)(86362001)(40460700003)(40480700001)(36756003)(356005)(47076005)(36860700001)(81166007)(426003)(478600001)(336012)(26005)(83380400001)(2906002)(70206006)(1076003)(41300700001)(8676002)(4326008)(44832011)(110136005)(70586007)(5660300002)(2616005)(316002)(54906003)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 10:28:31.1556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca74ca3-f082-4720-0c1d-08dba943db7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7172
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a mismatch in axi clock enable and disable calls.
The axi clock is enabled and disabled by the probe function,
then it is again disabled in the remove path.
So observed the call trace while removing the module.
Use the clk_enable() and devm_clk_get_prepared() functions
instead of devm_clk_get_enable() to avoid an extra clock disable
call from the remove path.

 Call trace:
  clk_core_disable+0xb0/0xc0
  clk_disable+0x30/0x4c
  clk_disable_unprepare+0x18/0x30
  devm_clk_release+0x24/0x40
  devres_release_all+0xc8/0x190
  device_unbind_cleanup+0x18/0x6c
  device_release_driver_internal+0x20c/0x250
  device_release_driver+0x18/0x24
  bus_remove_device+0x124/0x130
  device_del+0x174/0x440

Fixes: b6bc41645547 ("watchdog: of_xilinx_wdt: Add support for reading freq via CCF")
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Changes in V4:
-> Corrected fixes tag Id.
Changes in V3:
-> Added "clk_disable() in xwdt_selftest() error path.
Changes in V2:
-> Fixed typo in "To" list(linux@roeck-us.net).
---
 drivers/watchdog/of_xilinx_wdt.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 05657dc1d36a..352853e6fe71 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -187,7 +187,7 @@ static int xwdt_probe(struct platform_device *pdev)
 
 	watchdog_set_nowayout(xilinx_wdt_wdd, enable_once);
 
-	xdev->clk = devm_clk_get_enabled(dev, NULL);
+	xdev->clk = devm_clk_get_prepared(dev, NULL);
 	if (IS_ERR(xdev->clk)) {
 		if (PTR_ERR(xdev->clk) != -ENOENT)
 			return PTR_ERR(xdev->clk);
@@ -218,18 +218,25 @@ static int xwdt_probe(struct platform_device *pdev)
 	spin_lock_init(&xdev->spinlock);
 	watchdog_set_drvdata(xilinx_wdt_wdd, xdev);
 
+	rc = clk_enable(xdev->clk);
+	if (rc) {
+		dev_err(dev, "unable to enable clock\n");
+		return rc;
+	}
+
 	rc = xwdt_selftest(xdev);
 	if (rc == XWT_TIMER_FAILED) {
 		dev_err(dev, "SelfTest routine error\n");
+		clk_disable(xdev->clk);
 		return rc;
 	}
 
+	clk_disable(xdev->clk);
+
 	rc = devm_watchdog_register_device(dev, xilinx_wdt_wdd);
 	if (rc)
 		return rc;
 
-	clk_disable(xdev->clk);
-
 	dev_info(dev, "Xilinx Watchdog Timer with timeout %ds\n",
 		 xilinx_wdt_wdd->timeout);
 
-- 
2.25.1

