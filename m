Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C099C806872
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377055AbjLFHcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377122AbjLFHbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:31:42 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC6710E6;
        Tue,  5 Dec 2023 23:31:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGIRAn7l5hPH1wVWI5Lz75SsKG0mQO/CUWnR0s8tBhDo0eFyK7gJvYW9+jtX4fAzfPDKG3hqm2gEBj+jBMoPOjwhqx7qadd42rIuCnao3XYZpRct70HSj6Pber0Jn+9rvaTVXJ+nk2zWdBA4XnPP5QS6K6Qmks6Tkukd7JzjWxlVRuB2rI77YmKZ82JKYVMFjYXJfGngld9iBKofH5Z6YkJCzyyMlwsdgIU/TWp5qIeWP8t2AlOUEw5Yx7ScQMd7LU0aEt5c17B56soSdmniuectnhuk4ouhoay4uVk579y6F4zqThI+ZYmDlmRPCPafaIERC6M5VCSELRJY4+yz5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HXkzJ5/Fnz9ixaj/wfr23dR0L+5kmkYhg4XIF1GWDA=;
 b=DiX2yJqHNSoJGC5WNlhNxXAba4SSq0C8krYYhd17SegpP9geKJIiLDbCpy9P6FlBLh+tSD6/YS2l6sGsfiMWy0zJm/IbQdJK31Ail2D/4OirSUkrL31Sc5daFbth1/nsqu7dja0zM62+cC8bwnNhTWUBDl+N8ohHvigDtITMMd/6Jr9837o41+3auGYuAmKuMtMP9UylErKCGmY+81m74kIEEeOb1loj2CRzY0M7vd7GzjXirOBUpHKYTiyrMgYW1OF2MfkjE5kGK/4lk2P/7TGgIRMWG5BjRZgfqQYQDWE7I4aKn6I2Mx9wKIqffMoaxl2sXlxPFhLWOrB3zaVang==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HXkzJ5/Fnz9ixaj/wfr23dR0L+5kmkYhg4XIF1GWDA=;
 b=oirIWjG8//PZLhn2jG0HjOQMI99tsMx+lDb9Ouso8ZB0gxp7lnLq3AjLudu0Rw4EwqriBEKlziyRLr/HQ7AqeWn36engJ/htatg/gkum4kfzIkYI70+dvNsY0ZiHHRj24tBC678w2brqvrsn5x561yFEhBf5drBroyuB9AWLLk8=
Received: from MW3PR06CA0023.namprd06.prod.outlook.com (2603:10b6:303:2a::28)
 by BL3PR12MB6524.namprd12.prod.outlook.com (2603:10b6:208:38c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 07:31:36 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:2a:cafe::be) by MW3PR06CA0023.outlook.office365.com
 (2603:10b6:303:2a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 07:31:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.2 via Frontend Transport; Wed, 6 Dec 2023 07:31:36 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 01:31:19 -0600
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
Subject: [PATCH v15 8/9] drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.0
Date:   Wed, 6 Dec 2023 15:29:46 +0800
Message-ID: <20231206072947.1331729-9-Jun.Ma2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|BL3PR12MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dfec7f3-69e8-4271-09e5-08dbf62d60dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1X42Bg6kubLchqA+7Df3k/A09tzljVWRo5lbkmrEMZEiZ4Gq0n+pJ7gLbP2u3eL8RuLvSaQdVXkguK9SKm/p0ERRQUWgWh342EeY6Bpq+wHuH0E98Cpte3UXTm8+Xu6UpzpDNp2c4LkW808dST5Khcmd1/iXqN/bnTZM0fiUoVQ1aQAyXEQZCDQh8sNrJHYINZg0x32Rxkcg5Pzu9kqYGU6GtwB3oByhuUeKpwRoKko68VuCTTAks6uY3OnXcbkYVYlpr1jMSoP64w65tEDJWWB8E6ixGaxeGo6JzfwA9xx7gB0Q8vrkRxrKB4SqUVH+IIkmCqi77hJybJ8SUI7+rQsfxHRIQ9nQj1TUndMA2HeY8PazRyfNmvVdSZZLrGCtRPqC0fMz+W45o+r6haPaJXU+Y9tRePTQQ20u2L9MkkdJDs7s9sVdiaSc2fwo+IIFQFEvmWadS9JadV3uTFg1jr+DirX2Mpuv0hWPH3WMZNIUWJZNYU9PQSqhVR/S0ET1AKAk8v580D+bTdnV7g0GAzSAYVejG3v+Fky3I52y19hP8V5aY95HGBu7nY1wygnXjt5m76QBYoJf0BAZkAczzN/AkSsbgPWlwG3cCFv95FAhEtiN2FLEGtgL2CujggmQCCAimlEdgYPzhUwUykACsWVvg6C7BmQHczF/EYHvRqRpH2rLF8Sp/5Ycz9UGnZwkgewarP9vbbqWoWxBSB7692B4os3Z13gNtg0e/zer9D8V31dwnqRXhPudRw6vZXm76/f9NcNEeYBcbBpZVwg8cQ5ZdF3fvpcYcEGe70gpd6za6wudTEVSFrdEXawk3o/PEALJtbaP6gj7fDYT/nuqQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230273577357003)(230173577357003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(40470700004)(36840700001)(478600001)(5660300002)(6666004)(45080400002)(40460700003)(54906003)(316002)(8676002)(8936002)(4326008)(7696005)(70586007)(86362001)(70206006)(110136005)(921008)(81166007)(356005)(36860700001)(32650700002)(336012)(426003)(83380400001)(82740400003)(40480700001)(36756003)(41300700001)(2616005)(7416002)(1076003)(2906002)(26005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 07:31:36.0398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfec7f3-69e8-4271-09e5-08dbf62d60dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6524
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

