Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31767B30EC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjI2K5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjI2K5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:57:31 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBBF11F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 03:57:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5W1XgdpN9oW/+Ka1+kvivshiz3Bc8QLU53jmdBqNfZo0M2NaJJeIAWE6/z7TZpHbwc1lVN+srGuW0jt3/4ZgFiKLvkCt1rh5xNIvQESTuUyzkh7lFjNWZhouTql2onNCyJLY2xOXO34vYhUg1aj35jXmA9EDHCPg+YdPXzXSlyEnH42qkwxSJBE4z/J/6ENSQKwA+lUZVoCXggerlHujKTOZzBBJYNru0cEagcZkkjwvWsx83DxXbo2qXG0RNQusFg2+omQIY1O4fBc4vkSWfTVDyqOAz/6XswfvwUthWtZM0BB2lHohBZpEf68XHJ7e02DhZ3/ELn51HN59O2XVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZ+nKCvyVY7tKeWXWJhK2q/pWrNOjkCfmk181Kc4az8=;
 b=Owf0rY7vCMXPXjnl8Y67BAeIcbe5DS/v69NVWEtINJWge9xSMFiwnLkUEbIr0HmRowZ4Ah1bPydO8JGrSWtN4V2Z7juD+N3eM4g1izq5zZw7KDM3+cAlXRSYtZ09kOIDwXMpHg4AWWRuUTOVElT5sqXp2z1jE2tq4wkUucSD+MbSkLbZ72mFduGPwZrkMxQOjM1shkbkXeZm6D2DN2NLdD3g1ZTByxe+eHM62jwUFJpgGU0YjU9//fWLSLHJvOhInhaMjNS5oqkCdj9SCLAbZJIYeHJCg9IAUOGIxdinDCc3XEl+9+pMj3AyK0R6DaxcGCsL4P3N1mzV7/A7uz3QAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZ+nKCvyVY7tKeWXWJhK2q/pWrNOjkCfmk181Kc4az8=;
 b=kqmonqG8JJOLST2oTMLbAV+v9lH22BDWFPA/T7u6K1VxGlNWAFX5iPuhR/GuQJQ2A6mXsBbPOD7MRjUeaGfZlhUlKuxv/jz+TKDQ0DrLRLkMuNKhwn9GM72RJ7XUJD5ewro4Sw+XnHeSqSdS80sJ6N3UZyOXZWS7aNo4rdyN8vQ=
Received: from CH2PR05CA0002.namprd05.prod.outlook.com (2603:10b6:610::15) by
 IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Fri, 29 Sep
 2023 10:57:25 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:610:0:cafe::2b) by CH2PR05CA0002.outlook.office365.com
 (2603:10b6:610::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.13 via Frontend
 Transport; Fri, 29 Sep 2023 10:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 10:57:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 05:57:24 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 29 Sep 2023 05:57:23 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
        <tanmay.shah@amd.com>, <sai.krishna.potthuri@amd.com>,
        <nava.kishore.manne@amd.com>, <ben.levinsky@amd.com>,
        <dhaval.r.shah@amd.com>, <marex@denx.de>, <robh@kernel.org>,
        <arnd@arndb.de>, <izhar.ameer.shaikh@amd.com>,
        <ruanjinjie@huawei.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
        Saeed Nowshadi <saeed.nowshadi@amd.com>
Subject: [PATCH 2/7] firmware: xilinx: Expand feature check to support all PLM modules
Date:   Fri, 29 Sep 2023 03:55:53 -0700
Message-ID: <20230929105558.11893-3-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230929105558.11893-1-jay.buddhabhatti@amd.com>
References: <20230929105558.11893-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: e6511b4c-1adf-401c-a130-08dbc0dadd3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VOjYrKuZvbzimiL6gmQICdmWM8Js/edNDpvCVSbdiVoeJHT06pUAjYr7AEjtPOnrXm57vhjKkskJsTyegmKA/SeCqjJvnZWLtfFEREMdCWtDsXNeDBAPGwo9WNdMrkusj1oODy7yRthADBdykcRAy2GTxHkQ/ia4CRlJpoT9pftWMGEkuCpdxgbpAFxqtq6kudZ/66HeMJfcBqnRLluIOFAhbgrostZDKqr7b0mLAStfdG3aNx4WxnDZtuHUpXu/mPSxx+cD7c34CJdSrjR0CI1mAk/GIn7Z9OA+n/cSXDWxMqxHNPLFx48XTv9VXxyOvw4Hb98d9YYNet2VSpUFNv1hfLkJds0SWkZ4MKvbnq5ZvJ56hcgY2dqfFH/uCEN4e8ccHn1FoSBwiFzSp+bMU/YWzS1RrEGw1qPvx4y+7bAcQUmWC3JYzFvdoWAyctPohRHeRMqFUdvuzZyV4pjjHxshgJj08mUzTaLzP31tc8pEqNs61Oer9NeJcwjyDZBiWRUONtlTC2qRt2tbC7anZcN2RrE6dmxZeSKAkzVl18fwYU95eYFMo7DHIpiLSFNKGI+10OHvIaMDYW48pgthnvbH3AMmkp70f8a8m9jzjJP5R7zgIRRvrstlQNBHmOSE5tEfI31bBDTDEZoWQy8k7kW/VENtJdgwiCC3qsJV77apLII73TxGWhJRsfQl+qSGtOgNskjC6dsCsyjqCAuPemtdztbmy9aUG6LCSPkcAqgHa3Eexz9jBUwpKSc8V3V2S9+gAoC/8mOZjimwsVvPGeyoArnIQggSyXgU86oDz6M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(1800799009)(451199024)(82310400011)(64100799003)(186009)(36840700001)(46966006)(40470700004)(2906002)(40460700003)(6666004)(1076003)(36860700001)(478600001)(70206006)(70586007)(86362001)(426003)(83380400001)(47076005)(81166007)(26005)(356005)(54906003)(921005)(336012)(82740400003)(316002)(8676002)(5660300002)(110136005)(44832011)(36756003)(40480700001)(4326008)(41300700001)(8936002)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:57:24.9105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6511b4c-1adf-401c-a130-08dbc0dadd3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support feature check for all modules, append the module id of the API
that is being checked to the feature check API so it could be routed to
the target module for processing.

There is no need to check compatible string becuase the board information
is taken via firmware interface.

Co-developed-by: Saeed Nowshadi <saeed.nowshadi@amd.com>
Signed-off-by: Saeed Nowshadi <saeed.nowshadi@amd.com>
Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 45 +++++++++++++++++-----------
 include/linux/firmware/xlnx-zynqmp.h | 11 +++++++
 2 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index d102619fd6f4..5f40288f69a9 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -182,9 +182,33 @@ static int __do_feature_check_call(const u32 api_id, u32 *ret_payload)
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
+	 * Feature check of APIs belonging to PM, XSEM, and TF-A are
+	 * handled by calling PM_FEATURE_CHECK API. For other modules,
+	 * call PM_API_FEATURES API.
+	 */
+	if (module_id == PM_MODULE_ID || module_id == XSEM_MODULE_ID ||
+	    module_id == TF_A_MODULE_ID)
+		feature_check_api_id = PM_FEATURE_CHECK;
+	else
+		feature_check_api_id = PM_API_FEATURES;
+
+	/*
+	 * Feature check of TF-A APIs is done in the TF-A layer
+	 * and it expects for MODULE_ID_MASK bits of SMC's arg[0] to
+	 * be the same as PM_MODULE_ID.
+	 */
+	if (module_id == TF_A_MODULE_ID)
+		module_id = PM_MODULE_ID;
+
+	smc_arg[0] = PM_SIP_SVC | FIELD_PREP(MODULE_ID_MASK, module_id) |
+		     feature_check_api_id;
+	smc_arg[1] = (api_id & API_ID_MASK);
 
 	ret = do_fw_call(smc_arg[0], smc_arg[1], 0, 0, ret_payload);
 	if (ret)
@@ -1937,22 +1961,9 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
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
index 9e2d8e02d9e6..86fb73269d95 100644
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
@@ -100,6 +104,12 @@
 #define SD_ITAPDLY	0xFF180314
 #define SD_OTAPDLYSEL	0xFF180318
 
+enum pm_module_id {
+	PM_MODULE_ID = 0x0,
+	XSEM_MODULE_ID = 0x3,
+	TF_A_MODULE_ID = 0xa,
+};
+
 enum pm_api_cb_id {
 	PM_INIT_SUSPEND_CB = 30,
 	PM_ACKNOWLEDGE_CB = 31,
@@ -107,6 +117,7 @@ enum pm_api_cb_id {
 };
 
 enum pm_api_id {
+	PM_API_FEATURES = 0,
 	PM_GET_API_VERSION = 1,
 	PM_REGISTER_NOTIFIER = 5,
 	PM_FORCE_POWERDOWN = 8,
-- 
2.17.1

