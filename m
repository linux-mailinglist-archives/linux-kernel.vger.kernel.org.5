Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D2A7FD216
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjK2JPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjK2JOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:14:51 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BB31FF6;
        Wed, 29 Nov 2023 01:14:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5ocyAclNEpg20nr29maeqJh5BsANYXMZc+DoJZUK9mFG6lGf+IzFHo1LKv5UGisDkwhp2QaXMMO7C+kLYuiBy2RzKvzbNTV2ZL/rsk/gDM10zEWcTKucF/gDoTF2ckXyGK0lugoByHUX/5NhTp4i6OpntqplmDe1hccRD4Od/5X1HtxiD7HebPEQE9/O3bj7/9mLjqUMoaTYaFkT9hD4tojlhzsTAFyorYeA517axwK3v1QVw6w2XCaXyuYqWNFsyNCaVYgduJfSFeKDpXZP67EqP2lY5etk9Po+h10XwEJWl1xwXQa43/caJtEWoX4sxl7KbQyZZshz1pbLML4xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eq4Rd42wlQROzNEuYi5sI2kBGJwdt8GypGSMU480cBc=;
 b=e32BA1/4UJn3TLodkZyLvcRzHZ+3WUIBSFk14w6RVzJQTjIB1DEUTtKP8kAb9HfmCHu2b/fVykJw7CSnmfZ7qN/YQ0Y8jlk1xYyywTz+DX4nXQaawUSJ4IEJpL3wmX3rXkhjtnSRV0ydIjEiy1OQcikMZ+5fDA15dtkh3jd3q7cqhXO9vsOjfzY62Wgy2wFTO1Fkz3nOGbKZriRIfTLPHdH234BC8gQHV7N/cswhb3vbjjA+bNNwkdyqVwZEatyIqJTBqX09dTtEbTVi1BYCzQEWdFO+GwZYs4xUPlEkE6FnC5n91sCs2f7HpRV/KMOOWmosfqBqc7jPD1Fxt/by2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eq4Rd42wlQROzNEuYi5sI2kBGJwdt8GypGSMU480cBc=;
 b=OxIAHbs4Qq+sdyTHcxXxSBDDHJIr9VNVNH09IRBqDsuy7lh95IIrhYc9t5phm8F3cFhOPFdqTuhyvG2q8k/kqe8DGi7esSIPSjbBo9roJpbsnzBDLn0BM/eWxlPESD8/1JZUUh8dTCh+IN7BZ99b8jdaNT36+PZpnuKFSXODiz0=
Received: from BLAPR03CA0180.namprd03.prod.outlook.com (2603:10b6:208:32f::10)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 09:14:49 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::c9) by BLAPR03CA0180.outlook.office365.com
 (2603:10b6:208:32f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Wed, 29 Nov 2023 09:14:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 09:14:48 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 03:14:43 -0600
From:   Ma Jun <Jun.Ma2@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <lenb@kernel.org>,
        <hdegoede@redhat.com>, <johannes@sipsolutions.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <alexander.deucher@amd.com>,
        <Lijo.Lazar@amd.com>, <mario.limonciello@amd.com>,
        <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     <majun@amd.com>, Evan Quan <quanliangl@hotmail.com>,
        Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v14 5/9] drm/amd/pm: update driver_if and ppsmc headers for coming wbrf feature
Date:   Wed, 29 Nov 2023 17:13:44 +0800
Message-ID: <20231129091348.3972539-6-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129091348.3972539-1-Jun.Ma2@amd.com>
References: <20231129091348.3972539-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db8c314-6f6e-4c2b-5c1c-08dbf0bba30c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KkT0zIFSBiUwe1rXaTAYvR/jWRfW8TK4kj721qUU+XJhGLKSX28tM/xZ1aatfpJX/GyzI5tJy/DyigylRkbRu/jVJxQka2QIDTv+JfJfa5ThGTRnDVkTpRLJzXEQQoeOSDplcwB2DE8T99NjU7iVaebXxh/Q6xVklMvpaRJvqssk+IVPfrb+baqgySqG19zD3WWtgnkx9ZQfeN6lZcbZkrT1QzChB395YXSdp7fgGY9PhfXlp3WNI2cFnwro9Khuju5JclT3PsSKhdtNDXso+BQlZaiIwubR9IQW4SPdSChmEv1c+3MOP2VxR2NXSQh6/u+mqDEppPXnzx/YcI1iH+zbxLwJS+c4pRfNTHP1ukkvS+NFuIUdYujPVwVZ5CfcaS3g/qERvzykqUMsh68eXaJYKJzq2M4ZG/S142cqTSgbRwdpXdFSfiX+VLAIROfCp7BiuBJar3MVAkn/ZAPYD5SXbuZ9vRkOclzcD135UNVN5JP2mJhUHBtni7C5L6SJSlu0EWsolmJ2L1qPZOYzeENHerUlUqNqtWL2/dIprSnPaQ4kdwItmcKcg7JF/i/hzHSikW97pL0n0XfHRraPmnBH5cwau3uWM8naAYO4ZdRbF7+Gf5KG/JRiIL2kZuiEbYTUu4KCQHFt+BeF0NAvpM3BXugUFDHY6R+nR3/2uk1JENkXrSUe/DhwTVKqqQp0wtE8//NSILeRUkBXEPOUezDFf5TaNPT22pQ882JIaNEBmMc5KhBMbyNbwkoygFGGzZquxSOTnNBLXrwXbRnoOJtsC/FFcNbwLsaWeuERDwY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(36840700001)(40470700004)(40460700003)(2616005)(1076003)(26005)(16526019)(45080400002)(8676002)(32650700002)(81166007)(426003)(336012)(8936002)(7696005)(4326008)(82740400003)(110136005)(86362001)(478600001)(2906002)(54906003)(5660300002)(70206006)(316002)(36860700001)(70586007)(83380400001)(356005)(7416002)(921008)(41300700001)(36756003)(40480700001)(15650500001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 09:14:48.7635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db8c314-6f6e-4c2b-5c1c-08dbf0bba30c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Quan <quanliangl@hotmail.com>

Add those data structures to support Wifi RFI mitigation feature.

Signed-off-by: Evan Quan <quanliangl@hotmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

v13:
 - Move some struct variables to amdgpu_smu.h to reduce
duplicate code
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h         | 11 +++++++++++
 .../pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h    |  3 ++-
 .../pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h    |  3 ++-
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h  |  5 ++---
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h  |  3 ++-
 5 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 8def291b18bc..50bdf452bf5d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1476,6 +1476,17 @@ enum smu_baco_seq {
 			 __dst_size);					   \
 })
 
+typedef struct {
+	uint16_t     LowFreq;
+	uint16_t     HighFreq;
+} WifiOneBand_t;
+
+typedef struct {
+	uint32_t		WifiBandEntryNum;
+	WifiOneBand_t	WifiBandEntry[11];
+	uint32_t		MmHubPadding[8];
+} WifiBandEntryTable_t;
+
 #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYER_L4)
 int smu_get_power_limit(void *handle,
 			uint32_t *limit,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
index 9dd1ed5b8940..b114d14fc053 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
@@ -1615,7 +1615,8 @@ typedef struct {
 #define TABLE_I2C_COMMANDS            9
 #define TABLE_DRIVER_INFO             10
 #define TABLE_ECCINFO                 11
-#define TABLE_COUNT                   12
+#define TABLE_WIFIBAND                12
+#define TABLE_COUNT                   13
 
 //IH Interupt ID
 #define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
index 62b7c0daff68..8b1496f8ce58 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
@@ -1605,7 +1605,8 @@ typedef struct {
 #define TABLE_I2C_COMMANDS            9
 #define TABLE_DRIVER_INFO             10
 #define TABLE_ECCINFO                 11
-#define TABLE_COUNT                   12
+#define TABLE_WIFIBAND                12
+#define TABLE_COUNT                   13
 
 //IH Interupt ID
 #define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
index e2ee855c7748..e862d323caab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
@@ -138,10 +138,9 @@
 #define PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel 0x4A
 #define PPSMC_MSG_SetPriorityDeltaGain           0x4B
 #define PPSMC_MSG_AllowIHHostInterrupt           0x4C
-
 #define PPSMC_MSG_DALNotPresent                  0x4E
-
-#define PPSMC_Message_Count                      0x4F
+#define PPSMC_MSG_EnableUCLKShadow               0x51
+#define PPSMC_Message_Count                      0x52
 
 //Debug Dump Message
 #define DEBUGSMC_MSG_TestMessage                    0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h
index 6aaefca9b595..a6bf9cdd130e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h
@@ -134,6 +134,7 @@
 #define PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel 0x4A
 #define PPSMC_MSG_SetPriorityDeltaGain           0x4B
 #define PPSMC_MSG_AllowIHHostInterrupt           0x4C
-#define PPSMC_Message_Count                      0x4D
+#define PPSMC_MSG_EnableUCLKShadow               0x51
+#define PPSMC_Message_Count                      0x52
 
 #endif
-- 
2.34.1

