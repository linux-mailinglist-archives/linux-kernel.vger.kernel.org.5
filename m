Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051AE80685C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377071AbjLFHbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377030AbjLFHbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:31:20 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8928410FF;
        Tue,  5 Dec 2023 23:31:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5cPPleNzMXFehIGHLinYdIpei5H/BBRYDr6fvZirVSlxdyImWm1CPrSF/W7yc96/nFSxua5Gowh3gW90zwNhK3EjoK1OYgUbj2uQs3zXycfFRM24UwHlHa/RrQ7rziiIj6fSCeE+8T3ZF8e1qgeS6t+kYxcN87JAwMQ1j160XgSEekPKQ2y7I17RadQ5ujMRLiQpZ81MePRNaUJj24rBOExZEAplBSbBueYUUnm7oR8JFwdVRxZ9OY4qGuqIbUZe30duU++TzfarHh+MhGUf53AuwZFjrbPAhbHX9sLIE0Rby0PRL80gKqFDcBt+Fv+Sfy8YfieT3497HDLutNBhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEHzVoh39LZpaGwxTUCrtlAr8gy1MHjaXOrm4p/Ul7U=;
 b=ET3yvNNJBYY4uAFmUes9VFYlDLQ76UMvmNycqvGMk9mF1uE771QUuCBQPEaUG07U0SVUQtmj61kAFrkQq1gEgfdj/Ry7Qu9hIKP/w722V06IxQpErIiw5a4D5MXN5TDciCbysuM102y7Go0ZLOt2S6XpvvbpQiMCJbIZIQr9HEY0A9NCLT1wnw3QuEqukgKdPdBIzL+0z1X0Rl2gFMnLjBhyQUlr5Xwz9DaR7ZlXU98gyFFpqOhba/BGrYquPS7mLSYkjSJLHpXp7sk2TjUSvOZO73Lyb9lWwt4u11PY0EHICEIPbqG0YW13PEB1qzhR2B3BeSvRaFLEjZXkUhOOXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEHzVoh39LZpaGwxTUCrtlAr8gy1MHjaXOrm4p/Ul7U=;
 b=MnFTxSZ/wzXM/KSCgL47rQ1kI/I2D+dlyTEJ3w3RDFhQ2A5E3uYqVDd1HIkJoxrE5O9mYpJ9f16ZypWaEZEHsCIy5llAAd3uDAWQ7HEnZWqcNopfIf9JZn8miqovW+ICOr9HO/yzHmipgqN5eeSU54IEvfWkBDuI13HlD97MwOo=
Received: from MW4PR04CA0229.namprd04.prod.outlook.com (2603:10b6:303:87::24)
 by CH3PR12MB8969.namprd12.prod.outlook.com (2603:10b6:610:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 07:31:09 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::df) by MW4PR04CA0229.outlook.office365.com
 (2603:10b6:303:87::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 07:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.2 via Frontend Transport; Wed, 6 Dec 2023 07:31:09 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 01:30:41 -0600
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
Subject: [PATCH v15 5/9] drm/amd/pm: update driver_if and ppsmc headers for coming wbrf feature
Date:   Wed, 6 Dec 2023 15:29:43 +0800
Message-ID: <20231206072947.1331729-6-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206072947.1331729-1-Jun.Ma2@amd.com>
References: <20231206072947.1331729-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|CH3PR12MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: 247e26b3-6826-4979-8706-08dbf62d50c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hay5cv+ViRguLA1jH56o4KZRHklNkC+BJRDriEUGhDGuy6VhhFWNwf2BpCy35sn+PXXzEbM7Wu4PywAeBtTgDiRqzckojgDAaau8WG649+1xlWKAH8i+6U7qEHNT9v1xamIyD3mvmmtBfJdbzha1XGLQnYz0LzJPDou+bBaIPHlgrL6/u1fWCWBF7hNzT70W6wnTGeZmWvdIge//HDwpeOtg9MgA1peHETcaCp98rLlYCD+f6tNYDr3PQX5tCKI11Ve4KmMbEhEJpuNAC4iW+6HVlvJc5Glla7BzeTkhrkvTMJFfZERqo7GmL3dp1yP2rFm7YuWJMmwhSTlE+T3Ew6u8JKcK4BfXm9J80mht5tb3T/4RK3JDDZE1M6/vYBbhcRR0uYRqO2bm0e+vIutNCa4S3dfSzQFGk54QUDEPoe3tycaj3zxKsZZ878LPfZIpNkJYc7c5ALXgtKM7s4m4A0HYu+XG0LoHL1/7XMqGfc1M577+gpdQ57ZPKRCMu01ibWIC+XfnIMTxn6xBOFX0lR6WfbNcz/maj5pynKHir2U9VrIn0KOhOOZcHvKr/olCRmvz8/qw4b/C2BY5bdBRTtQntqrngIqx5pgWg299XxC1MNnypTM+YB2sL0lrlBBAK6JwmctQIwjvlud9E9HFlUe7Cvj7oTs5wdknpAaovFKUIoTBWqv0Eie9vCHoi7X3hmZyxxh/b82MT8Sd3mpBoZsV+F7oGAZ7slbbfNamM18/UqMVehguJ2EXFW+cq6AKVRXQ2bG8kkNVUQbT5OCKiPfLXFM+ZZ1xXWBqDYPzYvE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(82310400011)(186009)(36840700001)(40470700004)(36860700001)(81166007)(356005)(7696005)(26005)(336012)(426003)(16526019)(40480700001)(32650700002)(8676002)(4326008)(8936002)(110136005)(54906003)(316002)(70586007)(70206006)(82740400003)(83380400001)(2616005)(478600001)(1076003)(45080400002)(86362001)(15650500001)(40460700003)(5660300002)(7416002)(2906002)(921008)(36756003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 07:31:09.0553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 247e26b3-6826-4979-8706-08dbf62d50c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8969
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
index 23fa71cafb14..b1b1154d70a5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1481,6 +1481,17 @@ enum smu_baco_seq {
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

