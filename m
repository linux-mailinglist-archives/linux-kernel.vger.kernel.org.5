Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546C27DB411
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjJ3HUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjJ3HU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:20:27 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40A810C;
        Mon, 30 Oct 2023 00:20:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4EJEa2BpPbYzzjUyU1xJA8xUA4VWXWuETvlp9zbOGTpLBPp6g/kyEHVFm+17lE7OQOP3GALmiULRHNEFaYZoLI0ynaDiYOkiEDgcjcshKNjog5OR5erQU3HfdPi4kYXVfdi7UIsgaKwFnOHpCcyu5Z8XyxRNbx7kTCTvisHzO7FFV7TjIWJqpMIJxuJtiwQFTCREMZ9EmqkVMTeVX9GYxT361OyGiGC0WJT212A667qyti3d2Ll44Q92OPKfg0WcHheZ7749f4XrJ0sWN62GV4GC4o062BPAMpsHy6sCL/5gO9ScdCAif38A0Nt2kbk82dK8XhpFjjYn2TPqZqXdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1XOWVVtWY45HBepnoCI/Ml43DNr9H3H4CqOcEGQCm8=;
 b=YZ/6UJxTqGwqOt6SCXkzwmLilK58+Wsrki7zLwClMCo68+2+J6DAFJ/Qmmvt5UX5p0CpavNYHp0WRbEGO9PNwdKF38r8lN9GYbkwxqXY7/P4V1O0HU7g1TL2ICFuaPnLTUBsXEndCxrDPmegwvpTF3MDjbUiNegPgReH/meZlFROOqAOH7xYzI20pKt/YTbn5szUf1BzATJacaGdJoyZQ5Nbg+4FVTiKqVMdu3f0vvEuLfhRcTpwejkp4t5eiAPueOUAOW8PWMeqV5gBl4Td4xmUFnldVAJSQtOfWsp3gqloZJJbTtBCnkUEddb4XQGgZupRafJy/JaS77SBf74NHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1XOWVVtWY45HBepnoCI/Ml43DNr9H3H4CqOcEGQCm8=;
 b=XNkC4faAhnxyXGLX6y5x661Lyj5l8VyS/p3HakQCx7UdE3HyQyLmRajeAWdkxQ5QWllhe50IcylG+nDe5PGeysJeZ/cjXIXqWHMfZm7rNR9ROsU1tnR5jEwJ8bertUCN7T0mHS+BGKFQV4vZzUiyXrQtFEzhdU6azr0sdIi4IYg=
Received: from CY5PR04CA0030.namprd04.prod.outlook.com (2603:10b6:930:1e::23)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 07:20:06 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:1e:cafe::92) by CY5PR04CA0030.outlook.office365.com
 (2603:10b6:930:1e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26 via Frontend
 Transport; Mon, 30 Oct 2023 07:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 30 Oct 2023 07:20:05 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 30 Oct
 2023 02:19:39 -0500
From:   Ma Jun <Jun.Ma2@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <lenb@kernel.org>,
        <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <alexander.deucher@amd.com>, <Lijo.Lazar@amd.com>,
        <mario.limonciello@amd.com>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
CC:     <majun@amd.com>, Evan Quan <quanliangl@hotmail.com>,
        Ma Jun <Jun.Ma2@amd.com>
Subject: [Patch v13 5/9] drm/amd/pm: update driver_if and ppsmc headers for coming wbrf feature
Date:   Mon, 30 Oct 2023 15:18:28 +0800
Message-ID: <20231030071832.2217118-6-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030071832.2217118-1-Jun.Ma2@amd.com>
References: <20231030071832.2217118-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: d4365309-ae32-42a3-be34-08dbd918a42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eAGng1Xs655QeP/Lnd2ToogsTaM9qxo/7xdRkn3LJqSTmb6x0JMkhgiDjmHAUTeueqeGniW8vVagpkhxjuujmZW6/mdBABfuwpZTAsRaxZhioSdQA2QTZT0m9owDxKY74HELUYWZFFRbrGdJBkDBLAJAGSs3aIkGPc2qNUZlweUMd0abv/lm0G71FL/s/q3W/1EeZpf9eXfqPTbkg3X0GV4apDV/v6XYRK7EM+0ILsP1te1nPzzBPZ+PlZ+Q75fRbD3ANerIIXMddjis4mu2HFeoJEG/VxL8tlbRLGnkVcakmFodpRy6xjnAIci7A80/N2pwgJwNRdEGOAKyw2ogL+lGZC9hBUJ/Cs9+zKbIzMZXWrfNhDz1KRy6B2pj5Sy31hck/59tCkJ0oZ8SQc8YfAzkN+Du7B3gt97ZkSsIYmc4M8wNfOYuh2mWlYdRhlcnbuKsZSxcFK/ifr8G/d/KMsucmI2joeNU+kSMgKHzBoseZEORHjmOxLn738iS3Q0qYbPEtduYUQhi19upbd27l+2IP7Xp6Gc8SbIwyWVfAZa0nHWYht3T+GNNTUuUboGiQdHp3ELgoZQeOBaKx/GUFjpyiI/nwvm6GGu+nf9WAiczmBPzJrCusQwutR/w/DBI8YwcPnFNn/OAU+PTuv5K9Xaic9nSrIpsv9LLAZir46XTcVDJvdEO0zGLI1l2eXk4QBgTjXFJdFPCa5v/EuzpUZBWnsvElUs4t7cgeISv/tllYYOf5idxj0KaJ5HLMJGly7vRw4vniaj4s32Vzn0SMUM/2dz/K0+H3IPcuBDyBd4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(64100799003)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(7696005)(6666004)(45080400002)(478600001)(83380400001)(16526019)(26005)(2616005)(1076003)(336012)(426003)(2906002)(5660300002)(7416002)(15650500001)(41300700001)(54906003)(316002)(70206006)(110136005)(4326008)(8676002)(32650700002)(8936002)(921008)(70586007)(36860700001)(86362001)(36756003)(81166007)(356005)(82740400003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 07:20:05.8736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4365309-ae32-42a3-be34-08dbd918a42b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
index 5a52098bcf16..fbcaa0947b39 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1457,6 +1457,17 @@ enum smu_baco_seq {
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

