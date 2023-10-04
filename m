Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF827B7C7A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242042AbjJDJnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242027AbjJDJnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:43:06 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154C4B7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:43:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnKKkvJLW8+N5h3bFpRDJPPYkdl05dSj3+xGQKQnAZFdMFksqWsZPbPKhPO+vzL67PJPMUZvYg8kWqU99XeR+Vy76sH6LpaOzf88nTbnrxba12XR+nzZuR/S2sptetg23KHdU4vC8DKumWe5D/0sFfmhMTqYK4H0AruVnbGM3cJ6splmiBKwhsVZ4DR9LzFQFei1Nd4sRhJhPj9RZOLkRtxBXArk/nCZYe5+P3bySAXAPjTUHP5IELsYFXksrI3GoToA4oo1lOVZIay5hq/j8IijxnQ2YYvnYteQrt8/jhMn9JVPiRvpwMMAlmVzzWNDKZwoVroBwtJtzfQAYsT9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTYwIdByS9O9WjKhtSHGjEQJ7fs/UHneiVQrvavhD6s=;
 b=ZSyE2BXvTd6uxn4CLUaraNlPAt2yOZ414wVggEisLjB9R11z9zsRrOVH5lKJrc5B9j/D78HZKEYhQFaBdDvJgsPqHXY2NMWMedMUU4hHbfKXbYjjTfEqh+ONfFFF/eh6DS8uGoI8VKEB5qXJt5vWwpmelUV226SeD6zYhAX5estPvUvTulAiLIIi7+dbn3ZWYqAcmjXWkJsHPeBCZ0Gl4aSUu1OxWDKNrR+HxMKlk/csQBAW/xzwNy8suLCakWBgyc9lLSyJBVN3rZY/uaZVlhv1hwfZjvIr2uvBa75fRwzxoBaZIGKbtDPRbZog6oYfSzDbCkLkZr6O5Wu0Vn5SPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTYwIdByS9O9WjKhtSHGjEQJ7fs/UHneiVQrvavhD6s=;
 b=Y79tafxUXvoRf5rMaZBuIZX6cWpv5bydXUViTL0at1gN3RPjeozkBIMBLcCK3YemZmSzroxn0CZvt7FgW8TPC7gw+59s16FJlBXCuOJn2FtxdjOqPUVobb67csem19UYmbQ/nMjfP6O5xkHYR1kw0Ki82vxzK279j+XLr1btz1A=
Received: from MN2PR15CA0011.namprd15.prod.outlook.com (2603:10b6:208:1b4::24)
 by SA1PR12MB6972.namprd12.prod.outlook.com (2603:10b6:806:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Wed, 4 Oct
 2023 09:42:56 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:1b4:cafe::b5) by MN2PR15CA0011.outlook.office365.com
 (2603:10b6:208:1b4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 09:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 09:42:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:42:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:42:55 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 04:42:54 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <tanmay.shah@amd.com>,
        <gregkh@linuxfoundation.org>, <nava.kishore.manne@amd.com>,
        <ben.levinsky@amd.com>, <robh@kernel.org>, <dhaval.r.shah@amd.com>,
        <marex@denx.de>, <izhar.ameer.shaikh@amd.com>, <arnd@arndb.de>,
        <ruanjinjie@huawei.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
        Saeed Nowshadi <saeed.nowshadi@amd.com>
Subject: [PATCH v2 2/6] firmware: xilinx: Expand feature check to support all PLM modules
Date:   Wed, 4 Oct 2023 02:41:12 -0700
Message-ID: <20231004094116.27128-3-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
References: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|SA1PR12MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af85d81-26ea-410b-6684-08dbc4be49ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E80YYUMLF3GeY30Gp4IEAKzpmgfIU0goMzmm1jp2+JQiokBfTgG4n+2wMiCFl79zv+fOZCzny1auXdEu9chSrALX0ajsugslg7YUtvPnxiImeDY+xvMyJsHWF6z/m8Qp92+YovwX7rKLuBh3Ofdn2KLBA+74+6QJj8ULvHvC9KgW74QdyKWLEonPtShOnEppk7ZMTwcirhuUDNs/Lu8cvnGmQRZJK0hZbJxuD8br4oYgLJPUqQjgr9AdF4wRH63tvjJNbrXZsWZmU0uvg8jGbX43IA1yeTxJMqVckhxFfMGXzx4hWWtvs4wUUzrqz4IIrKnQbGe8E+GDTUgqS4Jf6a7GG39okHJyr/ozX4B2yOqS8ZPMaxHk4dDke2jAqaHjIJUCTQH1DFW8TVlfgroBISEyKwsW9WtQFCrWk4nDqTjwPLHPisea9VmXE4BqXVUNCHKWmeCE+f6mvgjQ0AElgMKHiL2GS/T/zvH2ZB2SUdbNf3pK/zRdyCVQdGJ0zRQCxn0Z8j6jrzt59Mxi8RDxHxAq51HbMbt0iiB/rZ32YtFYPoq7ntS8YohifsvQk0UEpr8iwFlRTBlAbTvV8Xfq3sxKdTTm63LeCZ7r4mOHZTXEbx2iofkh0sH/5Wxbwp6CVcMdhAtnudi7nrX401PT7huNfpfnpfGzw0S7rauN01ca5bfXs2nsNlPxV7/CbQTJUpAwYPzxL9plVw9P95kjtja0OXNCt8o5fxCf6/taTvVCQj30YYkJ4ensGEUfISvr1UNcFdIBURmQNlPy0vOi8Rhn7Z9azCHK4ZqzAQK2voA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(47076005)(4326008)(8936002)(8676002)(478600001)(41300700001)(6666004)(36860700001)(26005)(2616005)(82740400003)(1076003)(336012)(316002)(921005)(70206006)(426003)(70586007)(81166007)(356005)(54906003)(110136005)(44832011)(5660300002)(36756003)(83380400001)(86362001)(2906002)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:42:56.5844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af85d81-26ea-410b-6684-08dbc4be49ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6972
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
2.25.1

