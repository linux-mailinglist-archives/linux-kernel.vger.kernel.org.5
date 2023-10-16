Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9523A7CA65E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjJPLNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjJPLNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:13:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E400DC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:13:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i60mIQrwK35qrVpqRHkPxdGh0koFL7Gj9MKAjVEm3jHk4kcfryefXug79WP/wETZvmtd1dgCulhyYnS+KU5oe939k/UIlzJnU/lAJ235jzJoC6OK/mpV0YH5FH0vzJIj2KYKt5+x3YW6a9/Kbg4sbYYRVLZJNi8Z1dULHGhtvQgeNt0Nl3tuwkkpu9phPSqJxNbWXYx7omX0/VVqsWs5M9XzLq/vJA6mzD6m3AmTMGTICnppPLFkDg7YVjirNgZXpUcwNusNg4ucVl6M06MhPGYeIUiQ06obF3P0Q5O02kWRZVxl40Ph7VJUl08h0YJpKREfopVQ60q7Q6ZpTyWemA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/s8s0Y80gUYEO5j/O3lnjzAxZJcWz3OmTye41Q3uGbI=;
 b=dVSCj0X/giKSDTduZn57Df1bsEy/WrKeSU+jowytlYoH+r2TBiHsxysWbEskj1lIW1K818SKZusO/5DR7WTxRJMRGahPTfgcbgSri3KFLf0shNtedFoQyJOcE1IH3c2jKfKfAnSSb86sF6SXvM/P8H1R6e/YiQq7gB1fGTOG8E/ZzzBasFcG0Os+NIg84gSwUdso7QQNaFKLk3hEc51OkLHe1oXNTvXPZqyBXotxHm4a7EZKsN7RtNHn/+IvAd8pt+4ZBMluKTIWS7v2xnv+yPU4Ef/pluaB3WOQyTJUh3OON/P0bYXSu3gs/O7sxLS7XIvNorbAYI2Xip9rVKUWgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/s8s0Y80gUYEO5j/O3lnjzAxZJcWz3OmTye41Q3uGbI=;
 b=zEJQuWaGLVVgUAUCiloqi4UUxFCQPwfn3e6C+5D4jwfwPSnlsD/9FFIF9phIZn/C4W8ppiFxgrE7LOuipAl8+2YieDAU7UmPtswB9pe/98Nzh5gAXqKwoRm6IHvtMsY6mKcFmZvkCfbscTOBdJe59uFhNzD62vdEMMPoP02PjNw=
Received: from MW4PR04CA0348.namprd04.prod.outlook.com (2603:10b6:303:8a::23)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 11:13:37 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:8a:cafe::aa) by MW4PR04CA0348.outlook.office365.com
 (2603:10b6:303:8a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 11:13:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.6 via Frontend Transport; Mon, 16 Oct 2023 11:13:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 06:13:32 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 16 Oct 2023 06:13:31 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <tanmay.shah@amd.com>,
        <gregkh@linuxfoundation.org>, <mathieu.poirier@linaro.org>,
        <ben.levinsky@amd.com>, <nava.kishore.manne@amd.com>,
        <marex@denx.de>, <robh@kernel.org>, <arnd@arndb.de>,
        <ruanjinjie@huawei.com>, <sai.krishna.potthuri@amd.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH v3 3/5] firmware: xilinx: Register event manager driver
Date:   Mon, 16 Oct 2023 04:12:59 -0700
Message-ID: <20231016111301.13369-4-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231016111301.13369-1-jay.buddhabhatti@amd.com>
References: <20231016111301.13369-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|SA0PR12MB4592:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc61656-7109-4db7-fb0e-08dbce38f1b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P7VxFwG5Vo35/gcNQf0NSGfru3FWbfMm4mNQGcdPmIEnYaB0Wmh7JEvlvLIlrJgFWKyuNu7HpH6H1nN9uXn1KFipqOi5PkcyLAJ9CalmsUx312PKSBD4jk1G+JXU+7cDHu+Q7IDcnjRssEsD4MVyOI/QdU74mjeMEUZvoP1lQl+ADxffdQM4iIfKfQWAvKN+DHWRypWKEp7flffUCAHL54J65N8YpoKkYWmfI1YsM129lrgHyrVtuSnCgPcyEXN22/GZxSPFVyINVrzUrj2vnZKgMF4pqH0LO7HTGMqFEytyTTG17VSLg8vMhn4zC7KCpu6ILXyzitSy6IJhIOU6z9WQf2GoXMCIp30VTwBYnJoAEr8O0IyDvS9mnAjXKHB4OoNemr7jKNRVd3qF1hNq+G1gQChG2+WGh4RG2BERqOutosF1/vF4M6J+VqPmkMIZilHQt8/JD4soIJXdiW96OHb3X8V+GQUs+7ox/XnTVSsEIVyMCSPvekjaJzRk7odL/0lBSWCbhhZwSBuXEJpjowfLbeuevIIFgx4IhIuSa9mNt3CKJr2Ng+Ep5xxGqpybXJKHopHounyhAzzhDpeX7FOZFiInyyi+QmT8YvGhu/0nHcG8fCiKJx9L4N8BjAu+cuxKu1y8HB3R33H9HwuCPDJ3I1ZEBNR3hBTi9qwhtglkhpYMcrudWS6B6cjG58QuS3SCD7G8keQ8LTvj450RiGmQs7BLSYHdoEPcfS0DHSJK0F5AdhnzOEl58d2Gr7+OrrrcuHEtNQ2zHzDPsozw61AyScBZdXZi/dOAYxQVmQc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(2906002)(5660300002)(44832011)(41300700001)(8936002)(4326008)(8676002)(40460700003)(6636002)(316002)(70586007)(70206006)(110136005)(478600001)(6666004)(36756003)(83380400001)(426003)(54906003)(336012)(26005)(1076003)(86362001)(36860700001)(40480700001)(356005)(81166007)(2616005)(921005)(82740400003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 11:13:37.0220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc61656-7109-4db7-fb0e-08dbce38f1b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
index 353c74aa244b..83f3c60ee2f5 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1889,7 +1889,6 @@ ATTRIBUTE_GROUPS(zynqmp_firmware);
 static int zynqmp_firmware_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np;
 	struct zynqmp_devinfo *devinfo;
 	int ret;
 
@@ -1952,14 +1951,12 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 
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

