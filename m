Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC72A80C5BE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbjLKKHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbjLKKH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:07:29 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81FBAB;
        Mon, 11 Dec 2023 02:07:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cS2aX+VD8iIkMP4BrNgq0ut9tf0do7U20ckbR8LG+Oha21RbqVj9VEFArnJlsAvXTFlAtKToARXnXrGBbPVVTPowl0Cm8N/UxQcx89LndMEU2Nc+zUKhYUKfWT7n4GzOjgBBDNlVhNZliP2k3K+6YMAfw84vMKokOtlYLHG3G/DaMJCePXB6h/IBEYia8V1MQ4pujyeFfB+uSEbG5SSs/bOhG3VjvOic1AY2oprJ40x0HmknCefunkjb6mqXLIjyBqJHoqb7eMU46OtLmGs1TKNStj0fWFf3dRToMABVFNla2+BqhiKwdnyYS5XKNyC02FUSBPXLdn6JaL1aTgQzNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEHzVoh39LZpaGwxTUCrtlAr8gy1MHjaXOrm4p/Ul7U=;
 b=JrCdkY9TaHZHJ84b8ZA4VkslzGyzm1j4rcDT/vZINtqpCs+Xh2d2F24Qe2KeYvWd7QNzkd97VCS46c4eSErGCe3sIm4N3lYL8tnDfhE5mX1m+XMRwomN5AIOGjfxKaWiJ3KKgKglmTxWAcOTfHRkbt4fdNPxvCHy0Mul7q9Fvpd4eD3BrlRqEaWeaE9tBTi/lAjJc/q9oGwPqzK5cmOAeHSV73ezHYyUv8mLEWBdnmGrF7MYo4qRX0nL6hHtTv5dI1kiTpJdKcAtQAsyPXBauaAcvYGs+hajnn/wRuq1TqG8RDqCQQftilTrcjk7xtcDLXBNEsq2ae1suO/EKIxoww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEHzVoh39LZpaGwxTUCrtlAr8gy1MHjaXOrm4p/Ul7U=;
 b=b6LJqrCcrLgREgDluVz77gWq5+fhfFUGnWwt+9MmFN+cZQi1RSRFk9EtErT13mdWpVgT78np+kepWO1giDbOJBpBtbkzB1uFQQ/n3TGdKratPCscsqWZD05lq1BL7a8ZCIpv+n9UWeR0mZC4wRmnEWyCIn607wfo7ZILsg1Vw8c=
Received: from MW4P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::8) by
 DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Mon, 11 Dec 2023 10:07:30 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:8b:cafe::54) by MW4P221CA0003.outlook.office365.com
 (2603:10b6:303:8b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 10:07:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.2 via Frontend Transport; Mon, 11 Dec 2023 10:07:30 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 04:07:25 -0600
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
Subject: [PATCH v16 5/9] drm/amd/pm: update driver_if and ppsmc headers for coming wbrf feature
Date:   Mon, 11 Dec 2023 18:06:26 +0800
Message-ID: <20231211100630.2170152-6-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211100630.2170152-1-Jun.Ma2@amd.com>
References: <20231211100630.2170152-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|DM6PR12MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: 4baeaf0b-0db9-4106-6e77-08dbfa30fc85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c76nIlljZ3fu8S3fnnJQpUyKG2Msrj2DnFD6QOx/46LqehzO1bVAUieiCdmDd/T+fpE9/RTi0gW7NLgOzEfkx/s2XcznzcsGPurLQhjkt7TMmpr0pRbkz+lCtIZmYAEdP1QqBdx1l67gckSIaOh8oSw2jUw5+IEwg0NUthmhgWflu+Xw73UW5hBSP/NnPw8i5eXVGF+F9F8QDma/ArbaPkyCvf4+CHJjR1uw30P1ibGeCBUj7KB8JWDLT30cfaZM554QzJWc07Si4Y8GVw+uPd941RkiCi5a6uPYeOm3pk4umDswef8NcO5ivN5gBhkKKonOhGm+2uDBBEjviHFs+i1BY/Q21BJAs9dQs72Ih+uyKALIRDKK6JBp+o0ISXtW0VHFwjH3LpX6K4uM7wgugjIGqGWkCCcdyLg3n3U+oO5CezOjY44lDel40ZeURbxm7vTm48avb4iYYGwqJwDSe+bFH4pFDJ8Byt97gPwrOKv0WvHX2qKMrnKyBvihcf34r9QXqahcAbizozcOVukIEiAtJfFD64Bk5YuiDP6MGy3pmE9w1fX7Ymjg9krKJWHQhdBXgHawv5umMyT/663hHplWXmsIogcP0IP9Zd+53Ex/lo/GPx62T3EFa4YFVAv3Wa66oUVFcIsKNJXqJ8HDzNo2aUzGzt+vbVv+bH65MPXhx4z6c4l1ooZtvbkiC9OMG9nW1QTScIlhbUINwiXoV7OEAPCgOZD5gzkxBUjAwGnQvnIrIsCUMPH/qO90xKGVMdqWFk07Xl9RRnPU+DjYBt6KjAjshbiHXPuKzczHiDQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(64100799003)(1800799012)(82310400011)(186009)(451199024)(36840700001)(40470700004)(7696005)(45080400002)(7416002)(2906002)(70586007)(54906003)(70206006)(356005)(81166007)(36756003)(86362001)(921008)(316002)(8676002)(15650500001)(8936002)(4326008)(5660300002)(40480700001)(110136005)(478600001)(40460700003)(41300700001)(36860700001)(32650700002)(82740400003)(26005)(336012)(426003)(1076003)(2616005)(83380400001)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 10:07:30.3315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4baeaf0b-0db9-4106-6e77-08dbfa30fc85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
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

