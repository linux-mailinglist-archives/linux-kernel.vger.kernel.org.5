Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8F880C5CC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbjLKKIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjLKKHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:07:43 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BCDB8;
        Mon, 11 Dec 2023 02:07:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuObbBp1sOd+AhE2j0MF1SRiQ/LxpltfBx0GQm8dhHp7XsbR/nRLYuMyRt4xXb75QnndgJHx/Q6QRxkt2AMlSLUTc5pRGXbUJf4NYk/Mef0fOB/4o4LjYX15yrUBQ93ISfum4Lv+8Hcn7E1ujeEiihsLxKnFiQf+ciBXRfgRrc/VU5CroEjN1Xp+PapUMoXTSZOJkhgriE6c/SvDTotjhQTq3/4V5OgvIH0ndGiyizLpCvUAEahYppBNLgIHB4MHNyVmSHpDNYz8fnfQPc66NtUrckJEzgF9NMH0Fq7KPuddnii/8dyErvA+InVMIlnPHR8ACftZRpQwNs9B6I2rtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HXkzJ5/Fnz9ixaj/wfr23dR0L+5kmkYhg4XIF1GWDA=;
 b=RZKN4gDROrGz8ST5cYzmueIW2EMJW751wZW1O6skXssLVsByIopYtl185/dcc0avAfsgUvuarXwlOMUDknSh+KhPq34G9pD7HvXTDVuF0SGtSc5P6HwagYWsRwQXObLXUEzQinic065cjsJFCyXVWRqoIW/Lb4sRX7c5/B3hiVdZ046fb7AX9typIaR0Gzkedy0Dmp1JvPhDZuvuNo0SImILGHiA1UShGBtg1rBm1R/npIqwRCuVCP05krV0BePFYKHyQGvcWnONbfZZJmbiEf1/U0YrZi+BT4Aoc0pYGRAUSFG+2iUjJYzytgg0FznqJEWU08YH6tl8JaNnNoYN5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HXkzJ5/Fnz9ixaj/wfr23dR0L+5kmkYhg4XIF1GWDA=;
 b=nMUZHlnFfiyUnrqRbRZ7DhtwTKtYr9QFz5cmRk4pZ3Pi/RlrTwP9QVVGikBbA4AUeN9p9ltKCnUq54KN7xW/yJ7dxrrSenLqO/1LaE7U48qAqFKmkxNrGCUinI81ZbcoZrKrnkzhjbnCixO5BxXSa7ezJ9Sw9Lfks8SUpmMD8Sw=
Received: from MW4PR04CA0303.namprd04.prod.outlook.com (2603:10b6:303:82::8)
 by SN7PR12MB6669.namprd12.prod.outlook.com (2603:10b6:806:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 10:07:46 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:82:cafe::76) by MW4PR04CA0303.outlook.office365.com
 (2603:10b6:303:82::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 10:07:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.2 via Frontend Transport; Mon, 11 Dec 2023 10:07:45 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 04:07:40 -0600
From:   Ma Jun <Jun.Ma2@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <lenb@kernel.org>,
        <hdegoede@redhat.com>, <johannes@sipsolutions.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <alexander.deucher@amd.com>,
        <Lijo.Lazar@amd.com>, <mario.limonciello@amd.com>,
        <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     <majun@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
        Evan Quan <quanliangl@hotmail.com>
Subject: [PATCH v16 8/9] drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.0
Date:   Mon, 11 Dec 2023 18:06:29 +0800
Message-ID: <20231211100630.2170152-9-Jun.Ma2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|SN7PR12MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf2a7e8-74c0-4700-c5f1-08dbfa3105d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4gU8H1XcBoYkXGlFnw1WoEP25lp9E3HyfjTc88K/I/C3ZBuC49hYM2XkS2Iq80NiVJoEk5Yo9w3FtX9IdQVfsCqBJAHKb6E+lLRZc/Hcaj74JlDSda+XIxN75dnbad8Nw4ejNZUTsBEhWsR2U1i741sOSdYz+zUxxfeJpxdG35lRMELpSZTkgYlbQWINgLmdur3T1Dm9vp+UvY2f9i7g2gNRyxHZvhhy5gQD6ZPjfDXaTn1zQ5IfBurFbCCM90aJhoXL5Oy1ydQRwztMkbe0Cp1GBJ1XZDxzY+oPSzypDraBNYngPYPFl1GUq5qJwsE3bpOP86zrIqjhOjb0wr+D1xCUuiNUQpZ2hq9wl/lB6jmM0uk9KbWa/OyaTvUNXnPj0ZJmggQuRSl6Cz4utRMA9pf2NW/YGysfoQ8Reni4UMMkANEakw/XivOg1XWr68O40LMcPhCuzXF5s6LywaP8Ak1IvovpFZ91xQFbHo9vzAEJMUQ+xeM4NuxnpJhhMrg7fPsyywAiQu4Fnb+iGZUnMwI38RD7Nb9Co5qHMKrpaNaUs0YNUV/dISrli9t4y3TON8JBVDYfuazjcN3tiJC1hpK3v3c3AcdsveZsqK16Xkcau9KqqzyG594X/60BLMOt1IlpKToNjb9MkvM8c8RVq6FpCk5xGLYyGhHwYHGnswyiJW9UfZi+mPIakW8YKCcYttmgLhoj3dLfd8dtiheq/bMDFvBDNHnw7xA+Vqg3swiHA6IRun77gSFVGNjJkOq98jpS2vhR0sliSmObky0vAQV7/u16/FBp2lV811pb3Tvj9cgQI6mRzWEQ29tTUnal1NTmCeJVJXisUbfPfs0Dzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(40470700004)(36840700001)(7416002)(6666004)(7696005)(45080400002)(2906002)(54906003)(70206006)(356005)(81166007)(36756003)(86362001)(921008)(316002)(8936002)(4326008)(8676002)(5660300002)(40480700001)(110136005)(70586007)(478600001)(40460700003)(41300700001)(36860700001)(32650700002)(82740400003)(26005)(336012)(426003)(1076003)(2616005)(83380400001)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 10:07:45.9863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf2a7e8-74c0-4700-c5f1-08dbfa3105d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6669
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fulfill the SMU13.0.0 support for Wifi RFI mitigation feature.

Co-developed-by: Evan Quan <quanliangl@hotmail.com>
Signed-off-by: Evan Quan <quanliangl@hotmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
--
v10->v11:
 - downgrade the prompt level on message failure(Lijo)
v13:
 - Fix the format issue (IIpo Jarvinen)
 - Move function smu_v13_0_0_set_wbrf_exclusion_ranges to
smu_v13_0.c as a generic code for later use (IIpo Jarvinen)
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  4 ++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 48 +++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 22 +++++++++
 5 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 24032c5bc883..a321f57878ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -23,6 +23,7 @@
 #define __AMDGPU_SMU_H__
 
 #include <linux/acpi_amd_wbrf.h>
+#include <linux/units.h>
 
 #include "amdgpu.h"
 #include "kgd_pp_interface.h"
@@ -319,6 +320,7 @@ enum smu_table_id {
 	SMU_TABLE_PACE,
 	SMU_TABLE_ECCINFO,
 	SMU_TABLE_COMBO_PPTABLE,
+	SMU_TABLE_WIFIBAND,
 	SMU_TABLE_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 9dd47d91093e..2b569fed1362 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -259,7 +259,8 @@
 	__SMU_DUMMY_MAP(PowerUpUmsch),	\
 	__SMU_DUMMY_MAP(PowerDownUmsch),	\
 	__SMU_DUMMY_MAP(SetSoftMaxVpe),	\
-	__SMU_DUMMY_MAP(SetSoftMinVpe),
+	__SMU_DUMMY_MAP(SetSoftMinVpe),    \
+	__SMU_DUMMY_MAP(EnableUCLKShadow),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 95cb919718ae..07fe31ce26fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -301,5 +301,9 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
 
 int smu_v13_0_disable_pmfw_state(struct smu_context *smu);
 
+int smu_v13_0_enable_uclk_shadow(struct smu_context *smu, bool enable);
+
+int smu_v13_0_set_wbrf_exclusion_ranges(struct smu_context *smu,
+						 struct freq_band_range *exclusion_ranges);
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index cf1b84060bc3..0dd3c7ad9d8b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2490,3 +2490,51 @@ int smu_v13_0_disable_pmfw_state(struct smu_context *smu)
 
 	return ret == 0 ? 0 : -EINVAL;
 }
+
+int smu_v13_0_enable_uclk_shadow(struct smu_context *smu, bool enable)
+{
+	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnableUCLKShadow, enable, NULL);
+}
+
+int smu_v13_0_set_wbrf_exclusion_ranges(struct smu_context *smu,
+						 struct freq_band_range *exclusion_ranges)
+{
+	WifiBandEntryTable_t wifi_bands;
+	int valid_entries = 0;
+	int ret, i;
+
+	memset(&wifi_bands, 0, sizeof(wifi_bands));
+	for (i = 0; i < ARRAY_SIZE(wifi_bands.WifiBandEntry); i++) {
+		if (!exclusion_ranges[i].start && !exclusion_ranges[i].end)
+			break;
+
+		/* PMFW expects the inputs to be in Mhz unit */
+		wifi_bands.WifiBandEntry[valid_entries].LowFreq =
+			DIV_ROUND_DOWN_ULL(exclusion_ranges[i].start, HZ_PER_MHZ);
+		wifi_bands.WifiBandEntry[valid_entries++].HighFreq =
+			DIV_ROUND_UP_ULL(exclusion_ranges[i].end, HZ_PER_MHZ);
+	}
+	wifi_bands.WifiBandEntryNum = valid_entries;
+
+	/*
+	 * Per confirm with PMFW team, WifiBandEntryNum = 0
+	 * is a valid setting.
+	 *
+	 * Considering the scenarios below:
+	 * - At first the wifi device adds an exclusion range e.g. (2400,2500) to
+	 *   BIOS and our driver gets notified. We will set WifiBandEntryNum = 1
+	 *   and pass the WifiBandEntry (2400, 2500) to PMFW.
+	 *
+	 * - Later the wifi device removes the wifiband list added above and
+	 *   our driver gets notified again. At this time, driver will set
+	 *   WifiBandEntryNum = 0 and pass an empty WifiBandEntry list to PMFW.
+	 *
+	 * - PMFW may still need to do some uclk shadow update(e.g. switching
+	 *   from shadow clock back to primary clock) on receiving this.
+	 */
+	ret = smu_cmn_update_table(smu, SMU_TABLE_WIFIBAND, 0, &wifi_bands, true);
+	if (ret)
+		dev_warn(smu->adev->dev, "Failed to set wifiband!");
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 82c4e1f1c6f0..d74559fe3e83 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -169,6 +169,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(AllowIHHostInterrupt,		PPSMC_MSG_AllowIHHostInterrupt,       0),
 	MSG_MAP(ReenableAcDcInterrupt,		PPSMC_MSG_ReenableAcDcInterrupt,       0),
 	MSG_MAP(DALNotPresent,		PPSMC_MSG_DALNotPresent,       0),
+	MSG_MAP(EnableUCLKShadow,		PPSMC_MSG_EnableUCLKShadow,            0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] = {
@@ -253,6 +254,7 @@ static struct cmn2asic_mapping smu_v13_0_0_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP(I2C_COMMANDS),
 	TAB_MAP(ECCINFO),
 	TAB_MAP(OVERDRIVE),
+	TAB_MAP(WIFIBAND),
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_pwr_src_map[SMU_POWER_SOURCE_COUNT] = {
@@ -498,6 +500,9 @@ static int smu_v13_0_0_tables_init(struct smu_context *smu)
 			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_ECCINFO, sizeof(EccInfoTable_t),
 			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	SMU_TABLE_INIT(tables, SMU_TABLE_WIFIBAND,
+		       sizeof(WifiBandEntryTable_t), PAGE_SIZE,
+		       AMDGPU_GEM_DOMAIN_VRAM);
 
 	smu_table->metrics_table = kzalloc(sizeof(SmuMetricsExternal_t), GFP_KERNEL);
 	if (!smu_table->metrics_table)
@@ -2970,6 +2975,20 @@ static ssize_t smu_v13_0_0_get_ecc_info(struct smu_context *smu,
 	return ret;
 }
 
+static bool smu_v13_0_0_wbrf_support_check(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	switch (adev->ip_versions[MP1_HWIP][0]) {
+	case IP_VERSION(13, 0, 0):
+		return smu->smc_fw_version >= 0x004e6300;
+	case IP_VERSION(13, 0, 10):
+		return smu->smc_fw_version >= 0x00503300;
+	default:
+		return false;
+	}
+}
+
 static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_0_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_0_set_default_dpm_table,
@@ -3050,6 +3069,9 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.gpo_control = smu_v13_0_gpo_control,
 	.get_ecc_info = smu_v13_0_0_get_ecc_info,
 	.notify_display_change = smu_v13_0_notify_display_change,
+	.is_asic_wbrf_supported = smu_v13_0_0_wbrf_support_check,
+	.enable_uclk_shadow = smu_v13_0_enable_uclk_shadow,
+	.set_wbrf_exclusion_ranges = smu_v13_0_set_wbrf_exclusion_ranges,
 };
 
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
-- 
2.34.1

