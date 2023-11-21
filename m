Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D5E7F35D9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjKUSVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKUSVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:21:35 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE6A9A;
        Tue, 21 Nov 2023 10:21:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQR/mUF6zey9lUBLBa594nGjttrQHL/24x67XGqykP+A6w9DojX2GC2LqJH+0sxs1236EIt1LQEzd6BFZulxnR7197EZw0I9itOOvSeT+BpziG+hys8JddWC6XZ2MQufxlnOKonCwcKVfVf//Ue1iNhWpXfxMFomlgIgHISElQxu52sPs+7Qjb00OAUVu9ywuFHokSz7eg24QSg7WKNgHT0mXCXbTpf8mbDcXSrFKYBYmD83UUymHY/P3QUFb86UB86JhLhXPHsqasnNM+fAMiCZAwjwt4xcXg3xZbUJUKk2latvxI5btp71uYw+O2kQ5/17n9ih3CPtyedAWfgzdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iP0bt97eaOILFMSS2XOKS+XoGvGd9J/aozCsIw+dng=;
 b=BcE7OswSsRpJgdQx8TlGNJ7R9m01hKYXwGjeg2ga/XUua7ZSz7jHuRki/rAQNPDl9SLGpIL/Yqmzr4H2oyx0QgcLmjbFbhOOJzMygkD0J2G7SwqySnza57Nd8fU/6HK9Hj7iQpC8g2LNvmWUhL2x/iD/GJaeByWkQXbJ+8hipU12O0ZcD86mL7IL+SstmTAtf4eccWnXMFqlpmpjQYxgnUC4roZwdXNI1QOXBoA9Va8bIa8nMxMoClcQOnHQq8VHvJVQfV7x6BUW4p+7rHT4h+47rLEiKagpLpaiIxmr4zAUYyZn9VR4FlSiBr4rIAWs0Y8HN4QHC+tRYOUjTdTL/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=synopsys.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iP0bt97eaOILFMSS2XOKS+XoGvGd9J/aozCsIw+dng=;
 b=wtI1vq13fQlRX5dPqR/Ox/OwUaPNrC3xMFkrkheqYZhs5lA9P8XWEwKp0lPaUYLAuIPvbsTWCfAqo4nUl68BvIHaTnp/Zo6gpAnlGos2AZGg7X6HgSPkQxCjTAAthe3E6nlDoCdIug6l4mAEcv312htMwkzP9QC5hmkRPSZeRR0=
Received: from BL1PR13CA0192.namprd13.prod.outlook.com (2603:10b6:208:2be::17)
 by DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Tue, 21 Nov
 2023 18:21:30 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::1) by BL1PR13CA0192.outlook.office365.com
 (2603:10b6:208:2be::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16 via Frontend
 Transport; Tue, 21 Nov 2023 18:21:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 18:21:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 12:21:28 -0600
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 21 Nov 2023 12:21:26 -0600
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>,
        <michal.simek@amd.com>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v2] usb: dwc3: xilinx: improve error handling for PM APIs
Date:   Tue, 21 Nov 2023 23:51:18 +0530
Message-ID: <1700590878-124335-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|DM6PR12MB4108:EE_
X-MS-Office365-Filtering-Correlation-Id: 988f77f0-bec4-4a6d-ddf5-08dbeabeae8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QcMYnkrroMA/FlW//r1EeJjTpcvgEBPYwfkuruj0k6twWlXjPSG9i2WnqT93eLTjCZK3uvTu8dNRJaRUz5t4wU6NJBa49BrFYxbDBZbFOOA4QDeoDBRSzVYRj7dh8Rsyz+IISpBDoeSyui/97iUEn3689A9qpJ6LZ3EUkJXR7H2pi65x8J6Plnrijv43YeMhR3o9gFwM/3j1eTi2tqZTV1oiSqkee+ZS9Tbl8sGsmmv/kYpPcSLPWw6ekC0dR4iQSgUqD643ZENTbP9U/n7efcSQMPXp9u3a1OtuyBCDdWzwFufpUNhNMm3hyXS15WjnlGLWG56zyfDvC5cYKdNw64mrLJ7VVa7O8slMeXaU2etecv2aGK3hXkdRjAa4bDp8tiyhcLNDYg6UHmK9kWHoUUAMSRm8YTtYOaLcsoOc6dvZGDcUMpNUrnqap0WjfkpoeH7LPrPLwzGgznQCD5khU+GR48tnnm4LyHGimvw/0lvkTh6F5AAbmbJ71uyHfMSXtxB+Vech9i2eVcp5EBItFe8IMYe+RrCGt83FHf0AHX6XOf1kvjWtc7+kOXurTwJAVMawEGYaOnOSk2NEAoqP8XO73PwzcF0MPEQGITtF/aCC8YyZEEPHa6wUNYlJ+xpau3LeePiIQ8aXWF0Vq/IQghdqgXPFVwP8OQS1knHqMiLbLKZ9PT7dZDm/NldggHEZRMKuyZ6/tAgtngyfC2/ABQE1CpYSVkCMZU4XFCMocE10uy3+wraaj8C3vYKTJokMexRn1pEaKPIAu5JuVGJrUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(82310400011)(1800799012)(64100799003)(186009)(451199024)(36840700001)(46966006)(40470700004)(5660300002)(40480700001)(8676002)(4326008)(41300700001)(8936002)(2906002)(70586007)(70206006)(316002)(54906003)(110136005)(6636002)(40460700003)(86362001)(47076005)(26005)(478600001)(6666004)(36756003)(2616005)(336012)(426003)(356005)(81166007)(36860700001)(83380400001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 18:21:29.5807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 988f77f0-bec4-4a6d-ddf5-08dbeabeae8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4108
X-Spam-Status: No, score=1.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Piyush Mehta <piyush.mehta@amd.com>

Improve error handling for PM APIs in the dwc3_xlnx_probe function by
introducing devm_pm_runtime_enable and error label. Removed unnecessary
API pm_runtime_disable call in dwc3_xlnx_remove.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v2:
- Remove pm_runtime_enable() call.
---
 drivers/usb/dwc3/dwc3-xilinx.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index 5b7e92f476de..6095f4dee6ce 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -293,11 +293,15 @@ static int dwc3_xlnx_probe(struct platform_device *pdev)
 		goto err_clk_put;
 
 	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret < 0)
+		goto err_pm_set_suspended;
+
 	pm_suspend_ignore_children(dev, false);
-	pm_runtime_get_sync(dev);
+	return pm_runtime_resume_and_get(dev);
 
-	return 0;
+err_pm_set_suspended:
+	pm_runtime_set_suspended(dev);
 
 err_clk_put:
 	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
@@ -315,7 +319,6 @@ static void dwc3_xlnx_remove(struct platform_device *pdev)
 	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
 	priv_data->num_clocks = 0;
 
-	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_set_suspended(dev);
 }
-- 
2.34.1

