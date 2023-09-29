Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CB87B30F0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjI2K5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjI2K5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:57:36 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4871B199
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 03:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TP+H6CRLjotGVb0XKrXpbHQbrDyFZxNlKTfUjUEjUzsUp6veUExn7yjR4u+M/pPRSI8FyGLfvU5Cejh0bGoPeM0M0QmnTz8P8DB/0ds4c+K2ctfz+/pFA+u3MhcLtKZhQEKv+tJrfX122GXPKxFM8R4maM8YDrJu9Ww5LIMOcwm4dnrB+8MTBQ2r8rB3GSbaBJEMpwZSEJEs0aLZSHBMYmkU+itGX062W8jJA9LD3iBiYpZgetdeWKqZ6L4Jr1FCMkls8UP9/NKsuNuQ0ryJRWAboEIxftDgzEeErBvdylNQ+se8JNC/r9fbnnwxrc0eRX/lmx6fVCkKYaodZ5IRog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xtn0iEdqRcsSuVAqIoTm1ZWEuN9iklKCGyYbgtvOmEA=;
 b=dTDhBW9I2IReK71wTgusOHsHuWkDjPnUcCUxBswJMhZeTea4OkX2kDcV89Hxvc44CoaTDNbKb9OxsaOTDNqy49nKMmiUf5WjpbUhlyt/0oe6bySCSlzOCUoA20aynn6YsycvmU/KdYyYOwLpKM42EYtvrJEH80H7XuDttuOcbB3eJ6dWn8kO4rM2C5gLDwgDcmQ+ewZ/jyMbcfui6tKblsUH//NQlxwsgDjYs4REiGZKVwBhWArYTL5epO4gjk1xEHQ2YjWIZfYBKyadBOVJplse6zkf85qwlaJJWNNyTSEC1CabMG2Ovy7yz/7Ip4MaHpbnVsFOlkpPdPaKata8fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xtn0iEdqRcsSuVAqIoTm1ZWEuN9iklKCGyYbgtvOmEA=;
 b=sTRaTv4I8/z8smtZY8bYZ+uq3JeTz7tX+D0PvI5C1n5NzdnnnqV6gKmuh2/GcCQ21y5udqS2ILwYeZY8sgrY0/Ta2ztV/sqejVkGLBAPQkJADE+UmmguFz3dnNIlkbP+NhooaShy+aIh40DGVRBWc4h2Rn+2U+HkKTvfJ8DyMJM=
Received: from DM6PR11CA0042.namprd11.prod.outlook.com (2603:10b6:5:14c::19)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 10:57:29 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:14c:cafe::c7) by DM6PR11CA0042.outlook.office365.com
 (2603:10b6:5:14c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27 via Frontend
 Transport; Fri, 29 Sep 2023 10:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 10:57:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 05:57:28 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 29 Sep 2023 05:57:27 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
        <tanmay.shah@amd.com>, <sai.krishna.potthuri@amd.com>,
        <nava.kishore.manne@amd.com>, <ben.levinsky@amd.com>,
        <dhaval.r.shah@amd.com>, <marex@denx.de>, <robh@kernel.org>,
        <arnd@arndb.de>, <izhar.ameer.shaikh@amd.com>,
        <ruanjinjie@huawei.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH 5/7] drivers: soc: xilinx: Fix error message on SGI registration failure
Date:   Fri, 29 Sep 2023 03:55:56 -0700
Message-ID: <20230929105558.11893-6-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230929105558.11893-1-jay.buddhabhatti@amd.com>
References: <20230929105558.11893-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: e437002d-4ded-407a-41df-08dbc0dadfca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 57CY4hZYKBdmK3zIosRuMkdHbX0GeUIl47GdxyTa0amewtj2NCFsuOCPqxUtZM3BCiXRd67COvzbfF2kKi4ZZI0Z0dbzZIoSrIWxPLUt7IuHMM4GZsJD5WzDW4I0aV4MsDI782oYdhmthUgbZPDrmEmIGtHCycy+BnOeTvkr2hgxjQY3IimtsA1pf2XUvLfTXbZbb/0CwbLVPyJ1uhr2NsOVySsQlCIRcIRh2bAO9RyhO5LgPFV+BAlS2Dhwco6fl/nPQnoX1FtJ8o/HT2ztN7Gi9Rf95VZWdSc4IARZNTXO68s8l86CIOCyrUvzpdUBJu6BmjAK3CCcsAQka7Xq57eEwtYns0scsJC8CkYoEZJ/hVfABWzx64Ln5JsovoBKptWym07y4zZ2gf1AukbRKq3hrsgIE27T5CeWisHNwqQb2mQPLC9uvc/N/rpzzFEL8LyWiXpprkmpeqlccD4X2JLegKLRGyYDnsADtsuAlQ4jeG3osdfsExlrVp2rO7Ssz8YN7EtDOpcUjxjxvD4iNCtinb98O0i7V3DiPWtxwFyRZG9Zcjxm3fZAZmcWCfXdxht66fiTaxhrGiLqQFQYZnUWWn4n3lgLQ39XlnKQl0RdOqSXXBC8I5EOR5UzdE98a/gtoVKiJ5mJlKWOkngWmX1t0Nx7LryRpsZwgp8U9xz4ykWUmM10Q9u1/T7HaR5tc8U3sAjSrBvIi8J5dh5ArUhTauzI3CUQDzDs6f6bm0ghXUFd/ombrc1Q/G/+sHAY1zHtv1Divc4B+IPT1wNR1XpPk0SMTaHPQpBK8enehZQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(64100799003)(82310400011)(451199024)(1800799009)(186009)(40470700004)(36840700001)(46966006)(40460700003)(356005)(921005)(83380400001)(81166007)(2906002)(41300700001)(316002)(15650500001)(44832011)(40480700001)(36756003)(5660300002)(8676002)(8936002)(4326008)(70206006)(70586007)(54906003)(426003)(1076003)(86362001)(110136005)(6666004)(336012)(26005)(2616005)(82740400003)(478600001)(47076005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:57:29.2097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e437002d-4ded-407a-41df-08dbc0dadfca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/soc/xilinx/xlnx_event_manager.c | 7 ++++++-
 include/linux/firmware/xlnx-zynqmp.h    | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index c504702fe9c7..0316db03fa51 100644
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
@@ -379,7 +381,7 @@ int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
 
 	ret = zynqmp_pm_invoke_fn(TF_A_PM_REGISTER_SGI, sgi_num, reset, 0, 0,
 				  0, NULL);
-	if (!ret)
+	if (ret != -EOPNOTSUPP && !ret)
 		return ret;
 
 	/* try old implementation as fallback strategy if above fails */
diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index 8074ded7b39c..5b6fb336da29 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -666,7 +666,12 @@ static int xlnx_event_manager_probe(struct platform_device *pdev)
 
 	ret = zynqmp_pm_register_sgi(sgi_num, 0);
 	if (ret) {
-		dev_err(&pdev->dev, "SGI %d Registration over TF-A failed with %d\n", sgi_num, ret);
+		if (ret == -EOPNOTSUPP)
+			dev_info(&pdev->dev, "PM firmware event notification not supported\n");
+		else
+			dev_err(&pdev->dev, "SGI %d registration failed, err %d\n",
+				sgi_num, ret);
+
 		xlnx_event_cleanup_sgi(pdev);
 		return ret;
 	}
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 5d4c81790091..880c3b17571b 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -168,6 +168,7 @@ enum pm_api_id {
 /* PMU-FW return status codes */
 enum pm_ret_status {
 	XST_PM_SUCCESS = 0,
+	XST_PM_INVALID_VERSION = 4,
 	XST_PM_NO_FEATURE = 19,
 	XST_PM_INTERNAL = 2000,
 	XST_PM_CONFLICT = 2001,
-- 
2.17.1

