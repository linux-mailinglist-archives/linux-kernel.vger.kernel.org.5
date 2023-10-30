Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9726C7DB421
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjJ3HVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjJ3HU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:20:59 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B961B3;
        Mon, 30 Oct 2023 00:20:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GL0NhqPVCzjSRPxWHZ7HvXa5gAG0ZT5+h3Kp6EB1AwEw1uZsudFx2MoVylDQimnZCXOjNRmtnp8iCnpdhY+rvXkUhDbBSRdJpplhz6fiJMFrsLyYGVeuyJfgzE5hOxVB5N9oBi8I4caWGNWzy6mHnyhbRpcH8c/fBEE9qRbEdR/9G+Jti38efmPLTedUO1FFq1nJudvQHefjNOQQ3jEs4D4ZM3nVPAJSIv1IuRRflgf5EA/7cujGnTDRGCr6AlYesq7h0qrLIGAb5FJm2JhKwtZDtjUEVGef5qkvluLgEbDvMPbKOeppB5s3lw1f1SaTNW9hOOysXJLoWACBtbQkjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vP1wCT9rAxWtNY+/Zm6kmN9ULRiGso0luVIOZ4aFcfo=;
 b=FerVBxRYw0Rlx83211VMzI42GXQm3rnAsbSAZ5wl1mAKoPcI8HnH/FdTrhsCUEMTu3qqioHWLwkiuHTRFaA3CyoDYoOVGMA/gT4AtvL/0gak1sFzPQgFWsocaxYP+XRsa2yQJ5948b+DxMp/HgdG64vuWeqNmvo8Pa26KaeuMhued0q8LWNz0TA/48M4GbCUVqAPpyj7LEC04jfaehDb367DhhnI8K2tNJBYz+5oMkPXK3GrZVGHz1aetPLHAYZYAUSMGJQDXkL9TaowDfGy0goY8K/mu3xJSCS5erfSa6FBzuGcA99i//YbWs8Zs55sYpLw1ql6v5P7JoIxvSHhow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vP1wCT9rAxWtNY+/Zm6kmN9ULRiGso0luVIOZ4aFcfo=;
 b=pvXBG2VdpyFGle/E2C2O1ep3+caWlvKBbvoU978WSVxaZFVd9Cg+gH8q1zJHRD1ljUjBsMX59dtWlHM6kiUuR42O7AUWrfKYBEn/D1F4BTfKzBpiH7endYEPFtn4+tkbj4W8SMNXF3I4g/FsHQDzSy5T0AKW2scv7bwsNo/YvuY=
Received: from CY5PR04CA0029.namprd04.prod.outlook.com (2603:10b6:930:1e::20)
 by MW4PR12MB8609.namprd12.prod.outlook.com (2603:10b6:303:1e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 07:20:48 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:1e:cafe::58) by CY5PR04CA0029.outlook.office365.com
 (2603:10b6:930:1e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27 via Frontend
 Transport; Mon, 30 Oct 2023 07:20:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 30 Oct 2023 07:20:48 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 30 Oct
 2023 02:20:18 -0500
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
Subject: [Patch v13 9/9] drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.7
Date:   Mon, 30 Oct 2023 15:18:32 +0800
Message-ID: <20231030071832.2217118-10-Jun.Ma2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|MW4PR12MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: d1594655-bfbf-41dd-0411-08dbd918bdba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8oe0FE4JukUW7NrkweqT26aUuySbTkrW5cs5FR7y33SczOd6slSv28z0mfZ1Czmz4PYIfSx5hF7xa1USLZVSd172FyFXShmEQ9bxqmyPrmLLad03oCiToB2akTbVDN0ZwjKx6HoOzUKXBOCXFWygKctgUExA2/WNKyWFMx/8KjPkp2IlcZ7FeHnW8BsP2/MGBRFEPDa/QVdY50lSlePNBuRCyDIDYtSBirlKOu4mU8XqXDAWdQuIN76fWex8D0PzlM8oR+C/rs5Gpjx05eZ0PQmm3XDN/nkkU0MilDcE/VY0dJUbJLSoBeLeulQFhXX7Q94hwG3DnyGrf+EcNeFHjMTthhA7GdXg6VTzgLeqSdBUQkHgI12R5q8NrlL4wh4lebiwXcTYJz1/uGUEBL1hghpnW1zfAQ1dJD9b6PbRDG2uxiW2ijvVaN73afTof6qMcOBh4ruRsOvjP3FuTJQWv/lPtfndZ4SQKIyllE28FFJYrMB1AKPSaxtoo0KLeuG7su3cK3ZSMO8g97MsNGrqmL3Rs0elW3rtYyCjiAZ+qbJukfN7pK+NoPxEflhzaMH1SuLiHYzXjmEDVtWBWZ02F7owJV+zztfbSgRDt0Z5tItPq1gCgAjLyL+iIQctScczqUbNIQ2C/+cee+uSvHALiSQ9aa88s+lBXjkX9FtuIMp1JibQjNnJwwX4Uz+bZ4dJTS30DHIG5BB/CNlp7icf+xCYQM+VD5Z/PR+kyEtmm2DAbmsb/6Xz6HvODsRvRUPlOqwE1ZN12Jxe0quoQVEGGQ2yZddyZ6H3q7wy90NoWQHsY4KcvtGCWCUY5AylrgMUZ/UT/WET885mYPlhB1+Nw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230273577357003)(230173577357003)(230922051799003)(82310400011)(64100799003)(1800799009)(186009)(451199024)(36840700001)(40470700004)(83380400001)(16526019)(110136005)(41300700001)(2906002)(7416002)(5660300002)(2616005)(86362001)(36756003)(40480700001)(1076003)(426003)(336012)(26005)(40460700003)(32650700002)(81166007)(36860700001)(7696005)(478600001)(54906003)(70586007)(70206006)(4326008)(8936002)(8676002)(316002)(45080400002)(921008)(82740400003)(356005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 07:20:48.7490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1594655-bfbf-41dd-0411-08dbd918bdba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8609
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
index 94ef5b4d116d..b230d13fc5b0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -134,6 +134,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(AllowGpo,			PPSMC_MSG_SetGpoAllow,           0),
 	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 0),
 	MSG_MAP(NotifyPowerSource,		PPSMC_MSG_NotifyPowerSource,           0),
+	MSG_MAP(EnableUCLKShadow,		PPSMC_MSG_EnableUCLKShadow,            0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] = {
@@ -215,6 +216,7 @@ static struct cmn2asic_mapping smu_v13_0_7_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP(ACTIVITY_MONITOR_COEFF),
 	[SMU_TABLE_COMBO_PPTABLE] = {1, TABLE_COMBO_PPTABLE},
 	TAB_MAP(OVERDRIVE),
+	TAB_MAP(WIFIBAND),
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_pwr_src_map[SMU_POWER_SOURCE_COUNT] = {
@@ -510,6 +512,9 @@ static int smu_v13_0_7_tables_init(struct smu_context *smu)
 		       AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_COMBO_PPTABLE, MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE,
 			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	SMU_TABLE_INIT(tables, SMU_TABLE_WIFIBAND,
+		       sizeof(WifiBandEntryTable_t), PAGE_SIZE,
+		       AMDGPU_GEM_DOMAIN_VRAM);
 
 	smu_table->metrics_table = kzalloc(sizeof(SmuMetricsExternal_t), GFP_KERNEL);
 	if (!smu_table->metrics_table)
@@ -2178,6 +2183,11 @@ static int smu_v13_0_7_set_df_cstate(struct smu_context *smu,
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
@@ -2246,6 +2256,9 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
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

