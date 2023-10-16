Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEB97CA65D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbjJPLNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbjJPLNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:13:41 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866A395
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:13:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cppqKpF9ZPZifLmrJ96gjoxf1HQCvpEwvdnIZuzaT+b8AiJ8J129ZJJfbKwfW/VeLlEjx50w32lw1vDgGLvAHhZGTjV97wY+1FmctCrDeR9uZDIDM+oc7D5VBFlRw/ZuTDfsNChaStNINfQ7iMv4ZoEvK+sizQCzrVzC09Ixfv3G4tAgba45Jb/in7Zz7rLG+f3NlIqAmShn35UMRebR5eonAQrdVRSdgVUGNdzFA4aGnQTnOII0E4ixrZZyapN6qML/1XrRcoGDGfpLPDRcm9dk5fQEY92FDD6dsj4gd0T+rzFToG3PRSQPCoCjyt2OXtRidjHUzqGRImIYjf9MHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1cSlGz84WyrX8BBQZ0YVPFRMN9TkCstOXk3EpZ9UDY=;
 b=FTJMtofovlNPEi+ojMJjcIYhGIaj/eG1cjtFMJKNsFYvqvSiJBVFo/6CJOhFbVUTGnpNDGLkUoJaql2qNCQ5X4daZNt0NMf6hYKiIARxvdw0ftJ2CSqVrokfKogSefq5mx5rGWzZSh7OmYn9ny7kHcAeWv7Bu6mlVjBnuVs1NxxTs0ktGfNfRNwcvQb1NlxJbwkv3FJVE+M2wsPpo1xTgLZRL4prklzbpIcrLzGJ5eybf23QNW+/LBxIsZbz5TRaat8C/vGgOPp5ZpcAsyYyZjf5ZarBoNxv+J0lgRUGQQmdhC2BlNtgVB/FkTxjjwsFISFFortOgWLV4bnjRrKn3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1cSlGz84WyrX8BBQZ0YVPFRMN9TkCstOXk3EpZ9UDY=;
 b=oAgYKwKnZ4wDGR6vw7WoXpqohSF9GSvXBwWaax3pvt03d75X3939OVoPfDGIlEo7v1yw+zQR6/7sLSSgPIKzi69xVLtPKJ2Ui2zv4kIPcMrD55WB2vIaqLXzFfmy/gC+vFoKEh+O1mp1uRjaOi4xQmvCuHXOD1ZD87UBNgxRkv0=
Received: from MW4PR04CA0337.namprd04.prod.outlook.com (2603:10b6:303:8a::12)
 by IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Mon, 16 Oct
 2023 11:13:36 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:8a:cafe::63) by MW4PR04CA0337.outlook.office365.com
 (2603:10b6:303:8a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 11:13:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.6 via Frontend Transport; Mon, 16 Oct 2023 11:13:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 06:13:31 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 16 Oct 2023 06:13:30 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <michal.simek@amd.com>, <tanmay.shah@amd.com>,
        <gregkh@linuxfoundation.org>, <mathieu.poirier@linaro.org>,
        <ben.levinsky@amd.com>, <nava.kishore.manne@amd.com>,
        <marex@denx.de>, <robh@kernel.org>, <arnd@arndb.de>,
        <ruanjinjie@huawei.com>, <sai.krishna.potthuri@amd.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
        Saeed Nowshadi <saeed.nowshadi@amd.com>
Subject: [PATCH v3 2/5] firmware: xilinx: Expand feature check to support all PLM modules
Date:   Mon, 16 Oct 2023 04:12:58 -0700
Message-ID: <20231016111301.13369-3-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231016111301.13369-1-jay.buddhabhatti@amd.com>
References: <20231016111301.13369-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|IA0PR12MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 534ebaa0-40fc-4bfd-db07-08dbce38f113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /SUao8a35RrMfoqEwXslo7m3pP7Vye8+dYDPOLnJeHqi9xiXM2HCJGaC/jHLEaxkDmnu2vT6gd3HvZWpbZA7E+koTT7gEjM7RdqfgmMn4e8UYp/mActMZUsnlCAeEYMeG6ulcdUjmSSmqvj8wLW+OPzQ1dns7x4PqyI7b8OieP1k3feNK8ze1EXaO44T3qTbBRo9T30kz5K4ZJ9EaJquvu0r3Z7mWckUO0gg0EoiqaoEVqtflywDJIEMQ1OFPyIQUN0FrDC1GUMNcbjPOroRtbn1Hmv1kYZMA4ZotPtUHUx7vGSIFzTqVjekkL+u8mlxGhqmHVKL+v8sx/fAIhpJIKJoqQed935eaYEwxz0xTgSck9277B8TXKMSgNoo/7x/KMjPvFMmdwsE3OO2mcmDQzfmD0Hk7gEIer3SrTitEdUmDVVgbPddI/Zl9OS0L/CbAHpC7WuSZW5he62gIWozKHWBo7IDANm3mBpHNPWGAG/s032LoBWY+0dSeVm2fAPVR3vvN3W5YKvgZPpfteAl9c+zXsFDeAqX7bIY0AgXTuM1bKwqxVeBC0I++3iB21u8s2TreikNEAOnGAXEZF0S6RhQWKkohuSUVtzakUPmjsjtRk0c22gYTVvrKvCbdwRuuSKDjImWHLf/Cn2vIuxa9+HV+IdFO5uioVLBl/DcOfqMzoCRZP9PwIR7SSRc9kHEDMKlcM/LVPMQjGNk2/UkAqXnjZothv3c0LwR3VqBM4GG4SzbGeDDBOCFoU0HcrleuGgirab93qNEoqDWyKrOWCBDpxWILfs8xyQlaVjduuo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799009)(46966006)(36840700001)(40470700004)(40460700003)(1076003)(2616005)(336012)(6666004)(921005)(356005)(82740400003)(36756003)(81166007)(86362001)(426003)(47076005)(26005)(36860700001)(40480700001)(70586007)(83380400001)(316002)(54906003)(110136005)(70206006)(2906002)(6636002)(8936002)(8676002)(41300700001)(44832011)(478600001)(4326008)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 11:13:35.9595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 534ebaa0-40fc-4bfd-db07-08dbce38f113
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7555
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index d535ff46c847..353c74aa244b 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -179,9 +179,29 @@ static int __do_feature_check_call(const u32 api_id, u32 *ret_payload)
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
 
 	ret = do_fw_call(smc_arg[0], smc_arg[1], 0, 0, ret_payload);
 	if (ret)
@@ -1877,22 +1897,9 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
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
index 2bea1b6bfbd7..93a77874a50b 100644
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

