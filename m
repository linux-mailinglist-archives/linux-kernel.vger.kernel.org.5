Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F9F7E641B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjKIHBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjKIHA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:00:56 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86DB2D51
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 23:00:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERWMM7IhMzcytIgAZfvJIuKlYHyyRQ+QgNfEQlQSTMFDzvQ9j7hXshIYgNVSoz1Lr60a5OghX6JtQuKFCyxC6YeXwdOlfeiIFt7pfVAQYfieIR6OvQb/hxvYbkVM0yG20LfZyExrpLuVGlaaQsQLCeVLWfqQ6cBjlVIxu65rYCEZneFIRgl6N6vlme8SMs7izUm3OsvF2e1VqnIcXJxBKWgh3cVSBco7eyajYf3S2ZJAbZ8oYyyhDJWzqiQA9CooMzMDV9YMmq/ozJn3bYHX0loT/z61KsHEF0cMM4L3FawSb+n29nO+6WjhWE62/5hYfN4RQZirGj65t7K1j+6rPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57H4E/1nShYJF3zSB+xtsx3ivtwtysaVDIn145Z+luw=;
 b=WChGQZ6M7Z5yW4aoAXI47fWCbuFZlAV4kmfU/FaEV1/4Thjbcyt2/IYTOjKq6WqjEDiQwFgvo7W5VhnTIjcPI6+V1iQt0/uD5jB9GmhQeeCS4NBUahuAbHYylItrOJqc3TdOJVPP9NHI/LcbO3R7yMXrxUX1zusf0jYX9YQYPPa4buaCwcSX99+Ac+b3tkwj07wQGCClYkcnKNkNUP+Ue/FShhORkxpJsLsOFllCH5z/ceOhCgbc4W8d7UcrLqkMIa0NaujucXafRWuI0okuzoA43ICHKvAPTHJYFXfOtzOT9JfoYDyzct7dKH2XEOog07h4cbMG3pHPT6f43i2fhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57H4E/1nShYJF3zSB+xtsx3ivtwtysaVDIn145Z+luw=;
 b=z39KscQsh3Jxsm0Avj432ssDqK9eo9gBAqklmLmLlcnGrTR1yM4bP8lBAdrudivsOdIMzJoDE4biLHZ2tX58a/oaMH3di40lug9dMFRreYzSABocMeTRcuVic2Vt9wPdKPSoFOSubHHmiVr2fnHixGCZ6dA4jOOcu0zvtabJayo=
Received: from MW4PR03CA0074.namprd03.prod.outlook.com (2603:10b6:303:b6::19)
 by MN0PR12MB6320.namprd12.prod.outlook.com (2603:10b6:208:3d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 07:00:51 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:b6:cafe::1b) by MW4PR03CA0074.outlook.office365.com
 (2603:10b6:303:b6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 07:00:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 07:00:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 01:00:48 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 01:00:48 -0600
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 9 Nov 2023 01:00:47 -0600
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
        <tanmay.shah@amd.com>, <mathieu.poirier@linaro.org>,
        <nava.kishore.manne@amd.com>, <ben.levinsky@amd.com>,
        <sai.krishna.potthuri@amd.com>, <marex@denx.de>, <robh@kernel.org>,
        <ruanjinjie@huawei.com>, <arnd@arndb.de>,
        <shubhrajyoti.datta@amd.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH v4 3/5] firmware: xilinx: Register event manager driver
Date:   Wed, 8 Nov 2023 23:00:19 -0800
Message-ID: <20231109070021.16291-4-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231109070021.16291-1-jay.buddhabhatti@amd.com>
References: <20231109070021.16291-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|MN0PR12MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 249a7e4c-e456-4096-af5d-08dbe0f19bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UzCGSgrDPhVC0w5O/NvH+PK2RSdOEYD4Zlf19xkJyxdf4WpTUHaks6LAn/dQN+rJQjsPGGbxJke7DwyY44W+6BAkJXg/vqAYXI2nSTtv+tAjLb4fO7B4IQeqA6LGqK20IF2HwNIB0wQXrt/d4mVnaUTG5e3q2u4v/f8KPu4u5kSPqJurUHts5KbQRimvhxkXS7nW8egrk+h1077Kxu6BC72kxcq0OMi0cD2xYFg27z3rtacLkuHiwUazmHYItS2HugWM1ytmjO0/fxVx6Jmn7xcSsz6E4Ad+RshTx0hWbEM7A3iXt/mYZXOgEog+j6tfNvQJ8ruiEAxfaUXnzPbhtdlTS4hok6P2oZ5PTZKV/EoaaW+Ik3kdwhjEabVwmWtjmFfgllqA1YP1b6r1jPyHx9cp3QMPmbOAUKDof/YI37XC7x/98tlxrleUls9Sy5gSCyOyRS+tQfx8hO7XjV9gDpCI1Bsypeso4fsSrFNpOtBvp9w3DBjFdFDWEdvYpBDIy/nwnH1/dJVn0WeCwr9+GoGrPIkoVLvVZwPomjybSt+qsQhx4bVEd67j+xjXxWnqk5/O+5ZYixUx66MjwhzsHirwELb37W6DOISNMcqNVqS9rFxMEk40WjPkeOlSaDVr4JRsSrwRzxaj1yTylbrhPhnc/cMegwDmtqxnKQVdYEFjqNPPR3bXlFUhPNMQCExyP52FE6+XqFBPtGTeuiO26XIfo1l7NWQru1kF2ihXn4Ga3p/O7XBT5SSDKTxqN4ny3Mr0IuE8C7+0LEDXdI+uqr8ToRoQmlE8+ZPuaabGO/jQPmAGuynqqECZwOxD+LyxhdUNw9A4FWduV0NldySCIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(82310400011)(1800799009)(451199024)(64100799003)(186009)(46966006)(36840700001)(40470700004)(110136005)(1076003)(70586007)(70206006)(2616005)(26005)(83380400001)(336012)(426003)(478600001)(40480700001)(8936002)(4326008)(8676002)(316002)(54906003)(6636002)(47076005)(6666004)(44832011)(5660300002)(36860700001)(40460700003)(41300700001)(86362001)(82740400003)(81166007)(356005)(2906002)(36756003)(921008)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 07:00:50.5085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 249a7e4c-e456-4096-af5d-08dbe0f19bad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6320
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
index c1c1abe9c4e5..125bf6ad28bf 100644
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

