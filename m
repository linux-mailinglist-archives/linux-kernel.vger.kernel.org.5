Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA1E7E6417
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjKIHBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjKIHA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:00:56 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206982D53
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 23:00:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8NI5sLgwMo36UmVQTmdyF1p1wSa3ULWCRXZos8k4EI4imb/NPh/t3XtkcSM2gu6awhsqpk1ettMDKto5BhRsGnApb2HzFjSHMPrG4O6aWja62TQsU6jWg4ytZuS4Ri4bEhj0rgg8Dz1Cu49JA1s0szxRC1uaWvO5mIJ0lhjyazklfvklxXAwHwdKIwK+BvFYqMeuiz5mv5Rjk9UN6YKp8fpcs9l2Si67zCeNROJG7dN2XjZDmqqXl5M5O9kS2qyYwpvzPWI770cqOt+xFREt08mcy8ik+w1mEZjBU/VVp/21Oyi+k7Rrk512U5QZkWcIRDAYBSZvwMH13zKOYkOqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxkqeFYWT+9d00OQhGiCkRybMEENtDhaa69IFLGHMa4=;
 b=JqVire9Vt29dJVCXeKCEuQE0AWdHLw6hWnm1lQkgNiMDx+rigaMgwIWHwniQK634o982VGKm+GbRtZ5TYW7rsvnIbeh9NYwCJ+fKIvgG2JP3nUXJ/P5ntO8GRlONZTCvRHMYhmO3Z3c6atJ5eAfhvc4IafbQQIXrvwii/aH4rEbO5/YdumPMrGWUViPNGcxJP+1RSZgcAGF8aVczv9Z3KGwYs8hRe8YWOg77x/KUFBS/tsqJ7RCVNwFMZf0FAcoWOsWZKI7ljkNYrHn0rGzRa7O1NFdgE97RTZVbQnNEEANUoei7FR4aUhbJNo7yxbYNTs7hJ+kXx8/Hbe1Y2w/w1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxkqeFYWT+9d00OQhGiCkRybMEENtDhaa69IFLGHMa4=;
 b=ygXHksL4RHm6M3RJaQe/tLYwj5oqb57525DBPs/2gaZi9Rg4QK/mxH8L6Ognrsjhq+1Ddvk4p2fZFfLtgfnUjpLKSIOMjqGaPHElUb/Zh6mX94ovNNKx4B+MBwZpWfgcuo3pnB3Edf58WR57aTtwx5hGl0rylb3mJ46o1lahe3Y=
Received: from MW4PR03CA0067.namprd03.prod.outlook.com (2603:10b6:303:b6::12)
 by PH0PR12MB5436.namprd12.prod.outlook.com (2603:10b6:510:eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 07:00:49 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:b6:cafe::c9) by MW4PR03CA0067.outlook.office365.com
 (2603:10b6:303:b6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Thu, 9 Nov 2023 07:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 07:00:48 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 01:00:47 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 23:00:47 -0800
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Thu, 9 Nov 2023 01:00:46 -0600
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
        <tanmay.shah@amd.com>, <mathieu.poirier@linaro.org>,
        <nava.kishore.manne@amd.com>, <ben.levinsky@amd.com>,
        <sai.krishna.potthuri@amd.com>, <marex@denx.de>, <robh@kernel.org>,
        <ruanjinjie@huawei.com>, <arnd@arndb.de>,
        <shubhrajyoti.datta@amd.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
        Saeed Nowshadi <saeed.nowshadi@amd.com>
Subject: [PATCH v4 2/5] firmware: xilinx: Expand feature check to support all PLM modules
Date:   Wed, 8 Nov 2023 23:00:18 -0800
Message-ID: <20231109070021.16291-3-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231109070021.16291-1-jay.buddhabhatti@amd.com>
References: <20231109070021.16291-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|PH0PR12MB5436:EE_
X-MS-Office365-Filtering-Correlation-Id: 009b6875-6960-4bc9-1c66-08dbe0f19ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sdOG5YaQvaqcyQxgLyk0a8W4bDroT6Qk+EA/TIqTR+uBumf7UdFxGP3YxS9Ym13lDpUkaZkigYmRSWMsscEcCmeDcHkT73MsOZ5SPGnREnvaaspdKV08I3Jb6qRAb9G3aR4nJ03ngU4AOgDDZyk9mcZj6od1UFQgZFa7Xbbqqf3d0PAHNDChWSNFjXuya3faSPSyg4Q906HNRbCg+19kCMTcRlTkNrEGfEqjSxDSkfN8oK9QI9PFEe9b/MPtXlBRGIp2hAbaCDRjDmEV3jQanOS+DZSShra7XDU12iZyztaUB+NFZTnx93m36qPre+bF+GvqOVcIG+/5n+pQ3lCQmFSyyD88mfiZalWR1EhwjM/w+WqBeUHlT4OCqXFCGKibsSTut9x4xrQrQW4h1ACeVIjSgFVr6U+3Oqqbnxnyy6FjmOU1ccfDbUf4J99BNU55NDzaXNcdeAiqDzqspw3ZHxlNZOP7BCw4B9l3jPLtau1R8yJpdV1dJdJZKY8kX7d4ZSHVQ/oQnKUROxJwZOh8wwewajO4flUWqgJuoIrV7AZ0Dx8dTJbKFBBCqghyGYgkKf1kv45UO8HaKm9+30JxhbVCSP91AGcrq2CRVtmQQS/kYzTLnsXETuED9orBEsOyjlqxlwixo6t/tT8L9R9BtJ6FIggZH37R/9e9nHM/peXB4j+9FMcgvlzK6PddqMIuWLUcDmGmFfoipmgerzOZfyB0U4RQo4hSzYml7W72FkaK93z1/zrcfky8PPaVdMryLYMvpNw2zAROg03tOoKOt3W7ao2K8zUu1+qGM4auAPGxWYQ+hp/HmozRBjqtUAPKpggxN1lItuo1KZr9zGY4HA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(451199024)(1800799009)(82310400011)(186009)(64100799003)(36840700001)(40470700004)(46966006)(2906002)(44832011)(41300700001)(8676002)(8936002)(4326008)(40480700001)(5660300002)(316002)(6636002)(70586007)(54906003)(70206006)(110136005)(40460700003)(47076005)(36860700001)(36756003)(26005)(478600001)(2616005)(1076003)(426003)(336012)(356005)(81166007)(83380400001)(86362001)(6666004)(82740400003)(921008)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 07:00:48.8991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 009b6875-6960-4bc9-1c66-08dbe0f19ab8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5436
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support feature check for all modules, append the module id of the API
that is being checked to the feature check API so it could be routed to
the target module for processing.

There is no need to check compatible string because the board information
is taken via firmware interface.

Co-developed-by: Saeed Nowshadi <saeed.nowshadi@amd.com>
Signed-off-by: Saeed Nowshadi <saeed.nowshadi@amd.com>
Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 41 ++++++++++++++++------------
 include/linux/firmware/xlnx-zynqmp.h | 11 ++++++++
 2 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 7cf056451a26..c1c1abe9c4e5 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -199,9 +199,29 @@ static int __do_feature_check_call(const u32 api_id, u32 *ret_payload)
 {
 	int ret;
 	u64 smc_arg[2];
+	u32 module_id;
+	u32 feature_check_api_id;
 
-	smc_arg[0] = PM_SIP_SVC | PM_FEATURE_CHECK;
-	smc_arg[1] = api_id;
+	module_id = FIELD_GET(MODULE_ID_MASK, api_id);
+
+	/*
+	 * Feature check of APIs belonging to PM, XSEM, and TF-A are handled by calling
+	 * PM_FEATURE_CHECK API. For other modules, call PM_API_FEATURES API.
+	 */
+	if (module_id == PM_MODULE_ID || module_id == XSEM_MODULE_ID || module_id == TF_A_MODULE_ID)
+		feature_check_api_id = PM_FEATURE_CHECK;
+	else
+		feature_check_api_id = PM_API_FEATURES;
+
+	/*
+	 * Feature check of TF-A APIs is done in the TF-A layer and it expects for
+	 * MODULE_ID_MASK bits of SMC's arg[0] to be the same as PM_MODULE_ID.
+	 */
+	if (module_id == TF_A_MODULE_ID)
+		module_id = PM_MODULE_ID;
+
+	smc_arg[0] = PM_SIP_SVC | FIELD_PREP(MODULE_ID_MASK, module_id) | feature_check_api_id;
+	smc_arg[1] = (api_id & API_ID_MASK);
 
 	ret = do_fw_call(ret_payload, 2, smc_arg[0], smc_arg[1]);
 	if (ret)
@@ -1904,22 +1924,9 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
-	if (!np) {
-		np = of_find_compatible_node(NULL, NULL, "xlnx,versal");
-		if (!np)
-			return 0;
-
+	ret = do_feature_check_call(PM_FEATURE_CHECK);
+	if (ret >= 0 && ((ret & FIRMWARE_VERSION_MASK) >= PM_API_VERSION_1))
 		feature_check_enabled = true;
-	}
-
-	if (!feature_check_enabled) {
-		ret = do_feature_check_call(PM_FEATURE_CHECK);
-		if (ret >= 0)
-			feature_check_enabled = true;
-	}
-
-	of_node_put(np);
 
 	devinfo = devm_kzalloc(dev, sizeof(*devinfo), GFP_KERNEL);
 	if (!devinfo)
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 9e923e55f5d1..96f3d949afd8 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -32,6 +32,7 @@
 #define PM_SIP_SVC			0xC2000000
 
 /* PM API versions */
+#define PM_API_VERSION_1	1
 #define PM_API_VERSION_2	2
 
 #define PM_PINCTRL_PARAM_SET_VERSION	2
@@ -47,6 +48,9 @@
 #define FAMILY_CODE_MASK	GENMASK(27, 21)
 #define SUB_FAMILY_CODE_MASK	GENMASK(20, 19)
 
+#define API_ID_MASK		GENMASK(7, 0)
+#define MODULE_ID_MASK		GENMASK(11, 8)
+
 /* ATF only commands */
 #define TF_A_PM_REGISTER_SGI		0xa04
 #define PM_GET_TRUSTZONE_VERSION	0xa03
@@ -112,6 +116,12 @@
 #define XPM_EVENT_ERROR_MASK_NOC_NCR		BIT(13)
 #define XPM_EVENT_ERROR_MASK_NOC_CR		BIT(12)
 
+enum pm_module_id {
+	PM_MODULE_ID = 0x0,
+	XSEM_MODULE_ID = 0x3,
+	TF_A_MODULE_ID = 0xa,
+};
+
 enum pm_api_cb_id {
 	PM_INIT_SUSPEND_CB = 30,
 	PM_ACKNOWLEDGE_CB = 31,
@@ -119,6 +129,7 @@ enum pm_api_cb_id {
 };
 
 enum pm_api_id {
+	PM_API_FEATURES = 0,
 	PM_GET_API_VERSION = 1,
 	PM_REGISTER_NOTIFIER = 5,
 	PM_FORCE_POWERDOWN = 8,
-- 
2.17.1

