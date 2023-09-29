Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95ACA7B30F1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjI2K5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbjI2K5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:57:37 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661401AB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 03:57:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCNxJdS2zS4dPlvg6vT19DqponIXDTjRZZxGUNU6mWlxRfAnWHOWqt5ETg8ZGVCal5/1RVmjrIcnVH5l1ZHrLmigbXZX47GrF7y10wIiW0fAAWm5aawWHxUseNo4/Qz0SiPqHOH6ftDNL4K1atMbqC/ATp9fEb/nEFDLfSOCHSacwUH2+dZVEwRWDzS7v0KkfNTd80vvlBro1i7kdG0aqdt/DeGLoBAGGtQgr6UXaLHxEwm+VOswrgJfuksm0Gjb00KAbc2PQ0LXn5rLIVfvz2UY0q4bCmv62yKyjyfyNoSJbr1cD+PmZdt16oVFP1u6kbmnE09VUUV/cM+bExx+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9ijAXVR29mxT2R3fWiYdJrGfSARSmoF4NBa17I6rEQ=;
 b=ABKwB1ADUfc3KlzzBIS4DgWDToVeRtk2UeXF297VM+QKtlPvDwNZp3cgA+VhhTNKzcv6QomKdKRCZNp+VXdsYvCR+LFRetBd5uVwmdb9M+ssRaYiwPMzJyf8uOwHp8CbVI/c5xcryY+TBMjsuT1cuFfTR/d02t0SBmBVT0mip5m4Ff9YBKWDRMv98WE+/VYTGwSB3hTvKqKOvxc4GEm9fy0tvN28bTqMds+wF957kIPLPZwVoFMYCKWLIc1o1TxCwN3DFX9QSpQdsPCKCc3ZWXJhS5UrKKh0RQhZWN/tog6poJl7+JcLBvPBtoCjF4Fq4xnBXEWOfbKUwPafTtlZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9ijAXVR29mxT2R3fWiYdJrGfSARSmoF4NBa17I6rEQ=;
 b=0oBWxuq4DvFzT+d3UVUcYtUqnw/4oriHDJi4EaCMH/0Xbto0pKfo1i9LdhdTbe0zNYcYw9/AvDF4g6Is/rmVKv1klrxuMh9D5rTlHynrGnQGq36WK0DZZRsnCSx4Dxppx6DWM5sJVS+qMTOUR2u1NwdyNKdGglT6bAb2Ky+lBw8=
Received: from CH2PR05CA0031.namprd05.prod.outlook.com (2603:10b6:610::44) by
 MN0PR12MB6343.namprd12.prod.outlook.com (2603:10b6:208:3c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 29 Sep
 2023 10:57:27 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:610:0:cafe::ac) by CH2PR05CA0031.outlook.office365.com
 (2603:10b6:610::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.13 via Frontend
 Transport; Fri, 29 Sep 2023 10:57:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 10:57:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 05:57:25 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 29 Sep 2023 05:57:24 -0500
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
Subject: [PATCH 3/7] drivers: soc: xilinx: add check for platform
Date:   Fri, 29 Sep 2023 03:55:54 -0700
Message-ID: <20230929105558.11893-4-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230929105558.11893-1-jay.buddhabhatti@amd.com>
References: <20230929105558.11893-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|MN0PR12MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: 33242744-3415-421f-a8b0-08dbc0dade47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iTv+L4J0jcAGBd4VrJ2HZpMnl5dcFJjt7zWLnhlXb7SDreQclIJvuCuxsGKqYK6zHnuIk4f38ceNUt2QhadrpU5TQiH9aJk9SWdxk5GRkybdM4RjoOOud0VUpP9c8pShusigOMPvDUonV+2ZLAkFM6abRFbswch0S8sWeb+tMkv6Qsstzt3MqDZuEyKpZkg3UN/P74H+2EqzlhqzdcykiXYsPCFpmO/S2ZvAckDWMZSlXgec1QbWqAb+OgkIWa1KYFXvc+kpntLSHnQDZG0uPQFcL4IQwRhJ8d6jVh6lfP9jNnOeRghijA0fdAYi6M1zIfhW4wR7Tk3IZXy59V9+ZDgvh7l5xsqjwFjHzJF2CL4Jx8cL2cjUBGOvkxGxbeuj67ZI7K6cn2XIXNSCsIAHLGT+1UY6Iv9eVyaYJoXSk6IAVnb9+PkftObHj2y5E8HuicGmTCy0Zv5U8PLMc8fVh2gCSVoI3AzfXc+6kBsIVkZMtoc6j95TRpY8wQg0A3XcmNnO0yYWyz3DFoJ2H5cTn9yvvoUO8iIn6WhVDF3STh+3hfc6CrVli9LBFywFQcmwWvHLDmZtyanRsbFI6jkPWSHZrq1Nd8QRbU+8xxUJWHyEcHPzXgMCa80js+4ziRaQyjO8WlfRXHsH+nJsCgKmBcRLkH35M39BsLVoWWAqvi/DZI2oX/nFU3TRHjrABTRKwebAbgT16K6T9PLcmTWUbMERhOSim7QyLqjgRI8Qn3j6aIg+/X/kta6pUEIrBvM6AI2heC+M0jTgjDxDBXmPcTcuuMLwV6jmaVu0PkhvGoA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(44832011)(8936002)(8676002)(5660300002)(316002)(54906003)(70206006)(6666004)(478600001)(70586007)(2906002)(4326008)(110136005)(2616005)(426003)(336012)(26005)(47076005)(41300700001)(36860700001)(83380400001)(82740400003)(40480700001)(921005)(36756003)(1076003)(81166007)(356005)(86362001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:57:26.6605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33242744-3415-421f-a8b0-08dbc0dade47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6343
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some error event IDs for Versal and Versal NET are different.
Both the platforms should access their respective error event
IDs so use sub_family_code to check for platform and check
error IDs for respective platforms. The family code is passed
via platform data to avoid platform detection again.
Platform data is setup when even driver is registered.

Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c        |  2 +-
 drivers/soc/xilinx/xlnx_event_manager.c | 25 ++++++++++++++++++++-----
 include/linux/firmware/xlnx-zynqmp.h    | 16 ++++++++++++----
 3 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 5f40288f69a9..6583efa9ac48 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -2019,7 +2019,7 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 	np = of_find_compatible_node(NULL, NULL, "xlnx,versal");
 	if (np) {
 		em_dev = platform_device_register_data(&pdev->dev, "xlnx_event_manager",
-						       -1, NULL, 0);
+						       -1, &pm_sub_family_code, 4);
 		if (IS_ERR(em_dev))
 			dev_err_probe(&pdev->dev, PTR_ERR(em_dev), "EM register fail with error\n");
 	}
diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index 38cfc161a713..8074ded7b39c 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -23,6 +23,7 @@ static DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number1);
 
 static int virq_sgi;
 static int event_manager_availability = -EACCES;
+static u32 pm_sub_family_code;
 
 /* SGI number used for Event management driver */
 #define XLNX_EVENT_SGI_NUM	(15)
@@ -77,11 +78,22 @@ struct registered_event_data {
 
 static bool xlnx_is_error_event(const u32 node_id)
 {
-	if (node_id == EVENT_ERROR_PMC_ERR1 ||
-	    node_id == EVENT_ERROR_PMC_ERR2 ||
-	    node_id == EVENT_ERROR_PSM_ERR1 ||
-	    node_id == EVENT_ERROR_PSM_ERR2)
-		return true;
+	if (pm_sub_family_code == VERSAL_SUB_FAMILY_CODE) {
+		if (node_id == VERSAL_EVENT_ERROR_PMC_ERR1 ||
+		    node_id == VERSAL_EVENT_ERROR_PMC_ERR2 ||
+		    node_id == VERSAL_EVENT_ERROR_PSM_ERR1 ||
+		    node_id == VERSAL_EVENT_ERROR_PSM_ERR2)
+			return true;
+	} else {
+		if (node_id == VERSAL_NET_EVENT_ERROR_PMC_ERR1 ||
+		    node_id == VERSAL_NET_EVENT_ERROR_PMC_ERR2 ||
+		    node_id == VERSAL_NET_EVENT_ERROR_PMC_ERR3 ||
+		    node_id == VERSAL_NET_EVENT_ERROR_PSM_ERR1 ||
+		    node_id == VERSAL_NET_EVENT_ERROR_PSM_ERR2 ||
+		    node_id == VERSAL_NET_EVENT_ERROR_PSM_ERR3 ||
+		    node_id == VERSAL_NET_EVENT_ERROR_PSM_ERR4)
+			return true;
+	}
 
 	return false;
 }
@@ -625,6 +637,7 @@ static void xlnx_event_cleanup_sgi(struct platform_device *pdev)
 static int xlnx_event_manager_probe(struct platform_device *pdev)
 {
 	int ret;
+	u32 *platform_data;
 
 	ret = zynqmp_pm_feature(PM_REGISTER_NOTIFIER);
 	if (ret < 0) {
@@ -659,6 +672,8 @@ static int xlnx_event_manager_probe(struct platform_device *pdev)
 	}
 
 	event_manager_availability = 0;
+	platform_data = (u32 *)dev_get_platdata((const struct device *)&pdev->dev);
+	pm_sub_family_code = *platform_data;
 
 	dev_info(&pdev->dev, "SGI %d Registered over TF-A\n", sgi_num);
 	dev_info(&pdev->dev, "Xilinx Event Management driver probed\n");
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 86fb73269d95..5d4c81790091 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -95,10 +95,18 @@
 /*
  * Node IDs for the Error Events.
  */
-#define EVENT_ERROR_PMC_ERR1	(0x28100000U)
-#define EVENT_ERROR_PMC_ERR2	(0x28104000U)
-#define EVENT_ERROR_PSM_ERR1	(0x28108000U)
-#define EVENT_ERROR_PSM_ERR2	(0x2810C000U)
+#define VERSAL_EVENT_ERROR_PMC_ERR1	(0x28100000U)
+#define VERSAL_EVENT_ERROR_PMC_ERR2	(0x28104000U)
+#define VERSAL_EVENT_ERROR_PSM_ERR1	(0x28108000U)
+#define VERSAL_EVENT_ERROR_PSM_ERR2	(0x2810C000U)
+
+#define VERSAL_NET_EVENT_ERROR_PMC_ERR1	(0x28100000U)
+#define VERSAL_NET_EVENT_ERROR_PMC_ERR2	(0x28104000U)
+#define VERSAL_NET_EVENT_ERROR_PMC_ERR3	(0x28108000U)
+#define VERSAL_NET_EVENT_ERROR_PSM_ERR1	(0x2810C000U)
+#define VERSAL_NET_EVENT_ERROR_PSM_ERR2	(0x28110000U)
+#define VERSAL_NET_EVENT_ERROR_PSM_ERR3	(0x28114000U)
+#define VERSAL_NET_EVENT_ERROR_PSM_ERR4	(0x28118000U)
 
 /* ZynqMP SD tap delay tuning */
 #define SD_ITAPDLY	0xFF180314
-- 
2.17.1

