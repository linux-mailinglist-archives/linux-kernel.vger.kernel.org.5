Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC867FD59F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjK2L1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjK2L1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:27:18 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4416ADA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:27:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnX0pHzyf66I1mwzZ/v8J/yB/2NypHCAFUI09TdYesI9CdkXTq70VRqA4V1949LOASHfGGB2lnEHsoe16ULsw9CJ9vNM+7x+xtOhPdBLtPmqUe5uDd3Hax6G75uvJi/Rmxqzrcdzj7KM8IStvfwr5c6ABk44pKC1JRn7MjXt0Ehlpb7kVuI1t0LuJabw0gZYYCkx7oraTj7NScZsb4zAkcToCVdY/ZdHKAHkPD6m/gz9AX3s0ke1qFOzwlgSoP6gi39E2E0nG3LMaGm+OmpQXHmKLLyVb1dOMwx37CcqSZSgwjG8BXI/yImjuCWOm7HOzeUTk9FdTUd46rMF6cTH+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3FO1up72xa+G2FhbYrJtp0cPWdT62dy6IXSXp63qn4=;
 b=fa0iOpBTxPSHgJQjy10WTev0KP0/T2cUGzH76Lt7t9aL8Hz39l/0dXl9iblwq97RlfKXImuk3q2DSkB8zwpmZBvpl52BmUiIqkYriYG2QcimFI+0RrlKBNcGxc3ny6gCDKqGvFXWHxcUHrUI2QLeIqs8ws250jMum+UyzocxUcIyIzkURKYHHmlaZOOJIFyTHiRr+HEg6KLmNAGaq5nAemJhWpunV/Wu5H357w9DAREZFMWzv2CvyqyZZe6Lds5maW9a9Gd4dH8k1cvWzfSpPPPycjqLtYQhZWEqaVIEprG4kCEpJUY0lFOS8dKqjKsrotqjKFnW666v5jr2vaehHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3FO1up72xa+G2FhbYrJtp0cPWdT62dy6IXSXp63qn4=;
 b=EWpYUtIV4SsU4wu6OYNkAaCwhLjhg0udEgW5RsneaiYnox1GJGfUxUa3LhzHprI45NyHNSJqF+EnWtmL6DyeEGJ0wdL7RD9/ca2GvQzrd98W457d8diyDdhtdiJeSa/ga2GMcc/P0nyU0JinUl73AQlCCbkzRePdqAWHQ16CEYQ=
Received: from BL0PR02CA0006.namprd02.prod.outlook.com (2603:10b6:207:3c::19)
 by DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 11:27:21 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::26) by BL0PR02CA0006.outlook.office365.com
 (2603:10b6:207:3c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Wed, 29 Nov 2023 11:27:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 11:27:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 05:27:21 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 05:27:20 -0600
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 29 Nov 2023 05:27:19 -0600
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
        <nava.kishore.manne@amd.com>, <sai.krishna.potthuri@amd.com>,
        <robh@kernel.org>, <marex@denx.de>, <arnd@arndb.de>,
        <izhar.ameer.shaikh@amd.com>, <ruanjinjie@huawei.com>,
        <linus.walleij@linaro.org>, <shubhrajyoti.datta@amd.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v5 4/5] drivers: soc: xilinx: Fix error message on SGI registration failure
Date:   Wed, 29 Nov 2023 03:27:12 -0800
Message-ID: <20231129112713.22718-5-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231129112713.22718-1-jay.buddhabhatti@amd.com>
References: <20231129112713.22718-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: 52da8844-cef4-4fb8-f637-08dbf0ce272f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mM9MiQ8tn7+eLc9pHbjP4yogG1ozKeXfAnvB9FgyEUSKXZhZ5I0LwZj1E69ajCrngCpSBGUHqKHVxG1/h4jx6+E01omRDOTIK0+CvegxJ77WCUGFUURR4hJfjuATVVA8b82XaDorff7Sx/uVZ+TzHOm+5mhoK+KMofUr8rY/CXCY/E4CQqwe4Q4IId7W9+YOdtcdpyHClppjN+ct5C1WFb1UcwE/u+ap/uGNjNUzojp0PcTNLm6J5e3SXV0qeodtytUvgbJUHpKe4YA7YUiUiYh91F1vsNqyDXFZntdFfWFsoKH1s/nenAiNtl2ZGVRcX6OS8TJsWXYYr1+rizKIYIuZuFJNd5EOIwzruly2/sutFI3OVD4d0o+uA/WoHE4CnziituPBuNj3+3oX0me5yWIsWNzwowOgN5lLmJ3SKZDKTCb5JgqdEXBtJaQfGO57I7lyMFylRXIBtSfe8KbZcdKDpYTaAiT7Gmou7oOHcEkxOb8r6DV0x+O/pB6TrIIOd/hS1CrjV6nLc6r7d12BQlZ9Sume5X1r8jPtHGJKK+pKIpHHpdwD1uiFawk7mz/Ovh/WkYhvpYp1F07jITgKVlA7dW03ab0QglVsYIhIXQOwNwGDKhCDLGfP6XwAJYRiy8eJ3rLnFALVmW91tNmYZt5GswvKEe60IPq2/o7ZfpT7K5S+8cFHtSSt2kMUI+H4Um+u4svH48pgfqntxycIz9sLZavfQziQt/MZu1gT4fj+auMO28nFKFlOtTLpYcvPre0Nm/KFw3uv89xzqiner4l3bTKBchx0OYUXv1y4N5g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(40470700004)(36840700001)(46966006)(5660300002)(15650500001)(40460700003)(478600001)(36756003)(26005)(336012)(921008)(2616005)(426003)(1076003)(81166007)(356005)(41300700001)(36860700001)(83380400001)(86362001)(82740400003)(47076005)(2906002)(6666004)(40480700001)(44832011)(110136005)(70586007)(70206006)(316002)(54906003)(6636002)(4326008)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 11:27:21.3972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52da8844-cef4-4fb8-f637-08dbf0ce272f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Failure to register SGI for firmware event notification is non-fatal error
when feature is not supported by other modules such as Xen and TF-A. Add
_info level log message for such special case.

Also add XST_PM_INVALID_VERSION error code and map it to -EOPNOSUPP Linux
kernel error code. If feature is not supported or EEMI API version is
mismatch, firmware can return XST_PM_INVALID_VERSION = 4 or
XST_PM_NO_FEATURE = 19 error code.

Co-developed-by: Tanmay Shah <tanmay.shah@amd.com>
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c        | 4 +++-
 drivers/soc/xilinx/xlnx_event_manager.c | 6 +++++-
 include/linux/firmware/xlnx-zynqmp.h    | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 5db8577711c6..84fdec772a46 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -92,6 +92,8 @@ static int zynqmp_pm_ret_code(u32 ret_status)
 		return 0;
 	case XST_PM_NO_FEATURE:
 		return -ENOTSUPP;
+	case XST_PM_INVALID_VERSION:
+		return -EOPNOTSUPP;
 	case XST_PM_NO_ACCESS:
 		return -EACCES;
 	case XST_PM_ABORT_SUSPEND:
@@ -396,7 +398,7 @@ int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
 	int ret;
 
 	ret = zynqmp_pm_invoke_fn(TF_A_PM_REGISTER_SGI, NULL, 2, sgi_num, reset);
-	if (!ret)
+	if (ret != -EOPNOTSUPP && !ret)
 		return ret;
 
 	/* try old implementation as fallback strategy if above fails */
diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index adb875f89829..27a8d89a0a09 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -653,7 +653,11 @@ static int xlnx_event_manager_probe(struct platform_device *pdev)
 
 	ret = zynqmp_pm_register_sgi(sgi_num, 0);
 	if (ret) {
-		dev_err(&pdev->dev, "SGI %d Registration over TF-A failed with %d\n", sgi_num, ret);
+		if (ret == -EOPNOTSUPP)
+			dev_err(&pdev->dev, "SGI registration not supported by TF-A or Xen\n");
+		else
+			dev_err(&pdev->dev, "SGI %d registration failed, err %d\n", sgi_num, ret);
+
 		xlnx_event_cleanup_sgi(pdev);
 		return ret;
 	}
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index ef8c3e252e2c..c28b1d69e6a3 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -172,6 +172,7 @@ enum pm_api_id {
 /* PMU-FW return status codes */
 enum pm_ret_status {
 	XST_PM_SUCCESS = 0,
+	XST_PM_INVALID_VERSION = 4,
 	XST_PM_NO_FEATURE = 19,
 	XST_PM_INTERNAL = 2000,
 	XST_PM_CONFLICT = 2001,
-- 
2.17.1

