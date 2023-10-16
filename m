Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19B27CA661
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjJPLOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjJPLNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:13:50 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB89495
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AM0GAa4JQccHGV9I7jv9I9vBKn7RZyjPzco72g2X7q4oygcwfhi9fitoCByvH5y776xumAvj18aPhsEwGc/MrvRd8J72Yf6wbHHfMfNP24T0JXwLzFuSLZUMLVil1iAL3FpaEJ8+lHUBm3iKlXucRPaPbeFoRXP0ZLZN/8nWy2IfTYBWK5zK9PKDcpQuMZsFryjKNP6QVrbSxI0oL3tbrMjBwc/pQLVF5ADf92eFuIX1gC8cegSkJfEeHG/w6fLCCgXX+oAI/K+Zel3xZjq/4zxeGYfaZoDCVth8kOUnxo5nQJWxkWtP4Z77eXAVDZWvsXFgAIxiKZk2y6Cv/yKotw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qy854sDeDi7acYfgdIh0vhAfUC0IuZOuHnhoJtI/1Fs=;
 b=Zx5QXqihi0Jyt/gi7mx4BpJMB/0OKAcRIdZF19alp9HUw6++1sx4i7BwqLRyRWBrbom6wODULTSn8InDKzxj+6dMOBkfxUER5+KGR6JLbk+oHkMEVdEsQuBw1xnk7Ap8TnsAk3lO+VSEu0qLE3vywOapYGpzccIE+Wdb/WU5JUrCJ1t/8As1+J2nlxYyjUd3oJJc2nUHsvOzhE7MRtuDduyEWJ4IcaQS2Fd6Gt5Dp+izd64AlagsClnqMICMdEyGTJa4+oIAkV0TAU2lAqGJ97+aEyxv0xFGHV8sm5RgyNg0KCWP7OKG3/m9rBfrf8BrJkprokc/J7NmHaDzvG8r7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qy854sDeDi7acYfgdIh0vhAfUC0IuZOuHnhoJtI/1Fs=;
 b=DUCjCKUO9/xQtJ/AgURMUn6VGD2aZWtNEb1Xb1yCsNnznSbbeI5wU/GDWMi7t5YCzTAYycN6msS3ZJG2dlLD1le2Zg48UX2Q8cDjQ7DyMhYwIM/6tQaGqBoAbsQrVj3vZ9Z9rceyWeYtSZ4e7Kh/dSMTcVmS97w8AYLzozNCTrE=
Received: from MW4PR03CA0221.namprd03.prod.outlook.com (2603:10b6:303:b9::16)
 by SJ2PR12MB8954.namprd12.prod.outlook.com (2603:10b6:a03:541::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 11:13:39 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:b9:cafe::fc) by MW4PR03CA0221.outlook.office365.com
 (2603:10b6:303:b9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 11:13:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.10 via Frontend Transport; Mon, 16 Oct 2023 11:13:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 06:13:33 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 16 Oct 2023 06:13:32 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <tanmay.shah@amd.com>,
        <gregkh@linuxfoundation.org>, <mathieu.poirier@linaro.org>,
        <ben.levinsky@amd.com>, <nava.kishore.manne@amd.com>,
        <marex@denx.de>, <robh@kernel.org>, <arnd@arndb.de>,
        <ruanjinjie@huawei.com>, <sai.krishna.potthuri@amd.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH v3 4/5] drivers: soc: xilinx: Fix error message on SGI registration failure
Date:   Mon, 16 Oct 2023 04:13:00 -0700
Message-ID: <20231016111301.13369-5-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231016111301.13369-1-jay.buddhabhatti@amd.com>
References: <20231016111301.13369-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|SJ2PR12MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6d4e39-91a0-4288-ebe6-08dbce38f29d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zMpp3hLd73SEMMOYlaOkHgP2yX8uOZosWjuAiI2C0IEZZ6/dOQegnckPSEsdo7fNzntd/tlmzAQjI0aReie2/FT0pT0AO95HbeWwTHiOTXW40qbWaDYqEazX62nB00QTF4vGk0eSUyiZ9V4oI2Uq9zVyuiKy+lu/c9eJC4hPyquW4kVwftAn5H6B7GXmZ7tuQBf+mrNRMbcQV7L6AUGLR67tRUI3GOqb1sPIACpNBXvjhLPA5x3bCX5Fsh8gsVpfnLHfLt0zE2oFA+dX5CRgC6dP0wFpcenNJZSFFavaTpsTdL6bDNuLi5+v2YB0yil84NgqPL0XRynvUE3u5WDbueolpFuRbEcyO7lWfZqze0Ccm+ASutt4WSNrlYrtA4uzfQhyDhdRVjNiBKPYbz2/Lv7A9n2yPnNRvaEcJnM0Ww2qtDSSOY0cGHKYOKXsO/AZE9bIYOtlnbQhw7PSg/fkIPVbXafF+BQoepwQ2ClGAo49Air4fki+8qGGL6sP9jKAsaUQQTIbk2j1hWqhVV4vVjqr9IFqmY3Oq5pHhVTQMD0X+lZZs3yamn5Qc8G/OCbTJ1s5GxBaCl4NeJHD1+ZhT7WD3urvZynVQDfhYzazYrMNnt1p2Nor5slQTcfDbXgSRcFoAHMe63CzYKsFksGm/8HusNneHvD1D04WUigHi0A7/4EO0YruhRc8Ge453FaaNCqCtM3c61ONfpyLY7qlDPt9Ipmx7fBp9wLN8bQ1JP1UlnVIfH4osj0BngxvzBGrzeEylHCTE4Ar2VDLvMOoAcBWmTXUlyneTJtFXLtXNoA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(86362001)(40480700001)(36756003)(26005)(40460700003)(478600001)(2906002)(6666004)(41300700001)(5660300002)(44832011)(82740400003)(356005)(921005)(81166007)(36860700001)(2616005)(1076003)(336012)(426003)(110136005)(54906003)(70206006)(8676002)(316002)(6636002)(8936002)(70586007)(4326008)(83380400001)(47076005)(15650500001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 11:13:38.4952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6d4e39-91a0-4288-ebe6-08dbce38f29d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8954
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
index 83f3c60ee2f5..eebd47d482b1 100644
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
@@ -369,7 +371,7 @@ int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
 	int ret;
 
 	ret = zynqmp_pm_invoke_fn(TF_A_PM_REGISTER_SGI, sgi_num, reset, 0, 0, 0, NULL);
-	if (!ret)
+	if (ret != -EOPNOTSUPP && !ret)
 		return ret;
 
 	/* try old implementation as fallback strategy if above fails */
diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index 38cfc161a713..f80f4308a58a 100644
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
index 93a77874a50b..7abbb4ab4490 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -160,6 +160,7 @@ enum pm_api_id {
 /* PMU-FW return status codes */
 enum pm_ret_status {
 	XST_PM_SUCCESS = 0,
+	XST_PM_INVALID_VERSION = 4,
 	XST_PM_NO_FEATURE = 19,
 	XST_PM_INTERNAL = 2000,
 	XST_PM_CONFLICT = 2001,
-- 
2.17.1

