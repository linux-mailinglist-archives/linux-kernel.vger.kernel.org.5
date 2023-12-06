Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7942B806874
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377118AbjLFHcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377123AbjLFHbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:31:42 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E242810FB;
        Tue,  5 Dec 2023 23:31:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EM1yf62RpmLQ4NA2Ozo+U8dcMv5BBe4sFMaKchzebGO4kVhpmnaEhVL9mNtK+K8RRI6gtDZbINsr0IplwCSFOsJ9tGqSzU3mySXtOb7pe39aQs3cZ/Qh95X8r5mymSUg7uOStiAbXnw4mMwnxOEfcvlAhBsbS2HhbpIyR+XmszwNFUqbciFLsDAi8k04eRnthjhS+D65863mztpGWggLJIXmevLmDbzkv7iFyc7c0S2LgHltvNRxy8nrDBoZPZrwz2F3KKMHtfhTLKD1FSj8Oj3zSDWAp0Klfnt6zjNk29w6gjERCyvKDF/EZFHCWBSpumWZp0QwB0u5VWeI3ooYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FG/v7ogyS6xo4c1TLYkdS7kjTNds9VBLaPwExQZrCs=;
 b=agcckDuVrqcnxYcJI4XSGTbGOGc5e0scgLWVALN7dYyez6du4HpipyUaucT1tEvmSwa1oH7k784Jju5ftvzF5MkS7vVI2ekPBImGVirtzb83mRcgZLrSPr4CQmuJk2APTZY4KUj8DZ29ekGsJsXpSsAyTNRVUIp4fX4KLgmz6eW3QRYysIkz4Q7lUIcFMTXSvuroOJKJVExXXfeNJ+IzLi8RCmAATmD0PBi1ugysBcCGXfw1B2hyVp/cGPKN5cUUHd66RnWs18DKDOSq2kRDTTecQmWpLdhSoxVcDwkoVvUcAc5+P8nkpdLUQ/cUY697TRLEGSdGBIgNernM7/cWfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FG/v7ogyS6xo4c1TLYkdS7kjTNds9VBLaPwExQZrCs=;
 b=UIgA5O+cVAGovj/BunraztZqK7N44cSj0SxSIvWEJaeYPtFb1iMkle00nBrOfNMf67kzdKO/OgDASguKENAV5JRpYH28lvkCmnib0Uoydeayhr1Nykp1J0PRh1KFAG45uHNi7IsjTB29H34L5lP+kjzhwq8OzvpgnWVIgPjDBYo=
Received: from MW4P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::9)
 by SJ2PR12MB8829.namprd12.prod.outlook.com (2603:10b6:a03:4d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 07:31:42 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::1c) by MW4P222CA0004.outlook.office365.com
 (2603:10b6:303:114::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 07:31:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.2 via Frontend Transport; Wed, 6 Dec 2023 07:31:41 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 01:31:24 -0600
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
Subject: [PATCH v15 9/9] drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.7
Date:   Wed, 6 Dec 2023 15:29:47 +0800
Message-ID: <20231206072947.1331729-10-Jun.Ma2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|SJ2PR12MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: c8900bf9-76a4-43be-01e6-08dbf62d644c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MijNCUFaWPXSdNdiJeID/Hm3U0InozjB/qdiwyR1LizKY87oJOruK3YVhEgZP/99xL6xNME3hgGsOhdO1jzpyuEOe2EprkWtHpALLI+z4EANR4BUBtZlOhkpMTnb3OrZU0lhBFqZVgjBp83VpwqhI+7rfs1o9chZ54d5YaM1qZgoy8sauBK7eAffzAAlmkP2/QjrIYXPTN04kgX99ZsYO+VnBuYawirAwahy+clorupBntBOWEAma7KtFxpiNwcBv05IshlPq2EkKpNPZ7nWknVUm+SP3aQ2XEICUXL5RJUjNqWcwxlwKvGiuX3EAhQBFczNMlj5hhSjg/2wpCKlKcqhl6hH9W2WK7EzIZ0FhfRolgulSuFfJrzufB7/Yblib4c7zFmd9q5jNJbeWlDVl7ft5QOeEXys+bX+lw30tg15GmpJER5lVAjVXFeEVcnK/Y7n3XjDX7FCQs3KIYFVrEb0RG2XZ1rl65uHK1Wg5CU4rEFYTvat5IraqMLlcvTtCt7rzdL5UpIz00wm7AUfkEktkOyqC0RTKNQWXLumDIKIyFpHyHPrVhgmrryBeOf8kInS5+kQq20gf3oGaswErYYpGvM81bQE3bUER4jkY219LB85AgNkET6B4KRXHcNCH2/6V3EIW0t3r59hw7pXgJylIP8g1HkgI2MkVg4lM2OglhLgVtQbzbKjDdTU6Z5he/yQqxfTsAbLR0FK7V4R8S0H1x6ie7+qbG+5PMmgcH6cEhgJsW7fPGc9m8GSKi7UnYyi07ldqKdhASQRb4eJ95J7WcvKDnR1szpJwO3GFd/WEJPHvsaNiml1AOWFGlHDWJEJhCvheLRjhnn938+nMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230273577357003)(230922051799003)(230173577357003)(64100799003)(82310400011)(1800799012)(186009)(451199024)(40470700004)(36840700001)(40480700001)(426003)(336012)(26005)(2616005)(1076003)(16526019)(40460700003)(81166007)(356005)(82740400003)(36756003)(921008)(7696005)(86362001)(83380400001)(32650700002)(7416002)(5660300002)(6666004)(45080400002)(36860700001)(70586007)(4326008)(70206006)(8936002)(316002)(110136005)(54906003)(478600001)(2906002)(41300700001)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 07:31:41.8002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8900bf9-76a4-43be-01e6-08dbf62d644c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8829
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

Fulfill the SMU13.0.7 support for Wifi RFI mitigation feature.

Signed-off-by: Evan Quan <quanliangl@hotmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
--
v10->v11:
  - downgrade the prompt level on message failure(Lijo)
v13:
 - Fix the format issue (IIpo Jarvinen)
 - Remove duplicate code (IIpo Jarvinen)
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 81eafed76045..eb507cbf5c3d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -140,6 +140,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(AllowGpo,			PPSMC_MSG_SetGpoAllow,           0),
 	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 0),
 	MSG_MAP(NotifyPowerSource,		PPSMC_MSG_NotifyPowerSource,           0),
+	MSG_MAP(EnableUCLKShadow,		PPSMC_MSG_EnableUCLKShadow,            0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] = {
@@ -222,6 +223,7 @@ static struct cmn2asic_mapping smu_v13_0_7_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP(ACTIVITY_MONITOR_COEFF),
 	[SMU_TABLE_COMBO_PPTABLE] = {1, TABLE_COMBO_PPTABLE},
 	TAB_MAP(OVERDRIVE),
+	TAB_MAP(WIFIBAND),
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_pwr_src_map[SMU_POWER_SOURCE_COUNT] = {
@@ -512,6 +514,9 @@ static int smu_v13_0_7_tables_init(struct smu_context *smu)
 		       AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_COMBO_PPTABLE, MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE,
 			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	SMU_TABLE_INIT(tables, SMU_TABLE_WIFIBAND,
+		       sizeof(WifiBandEntryTable_t), PAGE_SIZE,
+		       AMDGPU_GEM_DOMAIN_VRAM);
 
 	smu_table->metrics_table = kzalloc(sizeof(SmuMetricsExternal_t), GFP_KERNEL);
 	if (!smu_table->metrics_table)
@@ -2567,6 +2572,11 @@ static int smu_v13_0_7_set_df_cstate(struct smu_context *smu,
 					       NULL);
 }
 
+static bool smu_v13_0_7_wbrf_support_check(struct smu_context *smu)
+{
+	return smu->smc_fw_version > 0x00524600;
+}
+
 static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_7_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_7_set_default_dpm_table,
@@ -2635,6 +2645,9 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.set_mp1_state = smu_v13_0_7_set_mp1_state,
 	.set_df_cstate = smu_v13_0_7_set_df_cstate,
 	.gpo_control = smu_v13_0_gpo_control,
+	.is_asic_wbrf_supported = smu_v13_0_7_wbrf_support_check,
+	.enable_uclk_shadow = smu_v13_0_enable_uclk_shadow,
+	.set_wbrf_exclusion_ranges = smu_v13_0_set_wbrf_exclusion_ranges,
 };
 
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
-- 
2.34.1

