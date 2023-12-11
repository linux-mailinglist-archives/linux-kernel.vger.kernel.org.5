Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC4780C5D5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbjLKKIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbjLKKID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:08:03 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D1B10D0;
        Mon, 11 Dec 2023 02:07:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJOkQdzKYcHQM4nCAudlZV6JOvqaEizAJjLJ/llmHcSkSdkPEcAWyCx32X4MdRmMgG3aMrarGZOzuMKTbijosIV8EL4cjUhsXR6rslrwFSiReluZ+SzNPMnqbmynuvrLC28Drd9OVqgXkFLp9EgE1tYNkNXRHFBbsLxJccOLT3j9quECCqMYPn3kObZ1qx/rs4r050+fASdg46hQ0WyiA3IQcFcy52rxjjEgrRJCqmqifkEzw/O84pBZu5rrTM/yYz9abI+sj8uj52V9BPgd/YEiG1lHs1FqupCnHi/6RSgXzcqXRtkhcxStDxTMi376hkfRIEHYDx8ofY/DRhH/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FG/v7ogyS6xo4c1TLYkdS7kjTNds9VBLaPwExQZrCs=;
 b=WX6aXiihv0WGwP3j+eAsk14kYj4SkJ2Xscdscg0566opmxhEo+m4aBrTkQliW8Pml7gZmI+/7ZUEsyQROQvWkqLO/IqXjEJEney1/z2LObbZEhHf+haQcekv+/QOLN8rT3yOXNDsHb3nUgJFdSiI3ergMtTCFFNr/cSjlEPPgiwlXigarrhckPtpHHQnRe3RYem5Zu18rt77Ha0pmTF8m1XvYhffkjGRlEukH1WJV2D2kqrQq0Cbtc3z9/Wy12qJDQFQpEOP+JtOsqyUuy2eqEJB0esDNOTWYLXKcj4F0kBnJLeiWFUs6HvjUvqXRinO2iBk/Qmi8J96Dzm9azd+cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FG/v7ogyS6xo4c1TLYkdS7kjTNds9VBLaPwExQZrCs=;
 b=2c9Fnj9jeYPInr2HmnoRlx64LdoqNVQqS+hmZKqX5bZBz39/U/OtuR/K5Gmo6+UqYad7JCmHYABNStqU7vGxOuTpmQ5PP66BxuejiTilyvLYceKogNqLaIhM9A0qyFu/mWPf+M1tIgdcrbtxqjFJhfW4OnSl8un2W3oK5vPMwgU=
Received: from CH2PR20CA0021.namprd20.prod.outlook.com (2603:10b6:610:58::31)
 by CH2PR12MB4954.namprd12.prod.outlook.com (2603:10b6:610:63::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 10:07:51 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:610:58:cafe::d6) by CH2PR20CA0021.outlook.office365.com
 (2603:10b6:610:58::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29 via Frontend
 Transport; Mon, 11 Dec 2023 10:07:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.2 via Frontend Transport; Mon, 11 Dec 2023 10:07:51 +0000
Received: from compile-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 04:07:45 -0600
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
Subject: [PATCH v16 9/9] drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.7
Date:   Mon, 11 Dec 2023 18:06:30 +0800
Message-ID: <20231211100630.2170152-10-Jun.Ma2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|CH2PR12MB4954:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7232a0-f0cc-4f6f-1a94-08dbfa3108da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L9cq9DkRrTqetYFpHCgArKcNV5e6mikHHcLyllnA48sRaQJPokC85DCIOSbxt3pBFpdoRspiAb7TuZcjB0guMhoKfSPyDYuf5v+0V4RXRsAWKbQET3te+LLtkuFHvZhu5o3RowaSMB7gGvVkc0lAN5YFpyOFeZ9rHZYFYujAHgwz3+Fq9gRq45g3R+QC1kjYwohI+1hOo3fozR64nQ3cgURPPw78igGXiHLElspenuXkvYrDhDd89wE7JNFr7wa3t7KXeaO+pePos7OxQZF+ih5JXUdBE7bRHbBrL1QfxH1/r41qXvpFscVgLyQuW/Ee4YsqAmdS6VmupYh0WuJMYvsbLXiWPwcRFVQRpjcL85TzYx/P1ULN7B2yI8c+R4XLR3JGkYlnH5Z3uDwX9ouGj3U6SxdGMMxYTHGKZ3guDmB71Vv0LsmafXSyBsQfAmgOyvAcgCpD2DNXzZx48Q9WGy1pxUnXNxvt7wwwG9e1Tibvqs6gBJOQZnVBXuEvQno0LDtzBWkaIu5jLVfDKqHfE7Wy/clCxdvnxubMsXdgKZJW1c+zCtXKwfU/gOk7mXsgf/JRhkaXQwbHaqZf8LDLrOw+CA94WAj/5RH/Laez9JzY0x+Pumx4cAvPdRFDN+wyqbluz/vFYHj5ap0c+s5fZalVPEc6BEfGhIFshS4cFEXq3n2T9iladys7RkQbNO434cwJQoWXilaIa+Ni0kJea8fZXhzClah9OBQX8LbQ2fc/yIIM7AgK9Vb1A8n0Sf56o8C7hR3wLJMfEaPiQHc3EkqAJQ7BQ2FD/MWoFERx3ZDSBB1DKqfMMPxXa12eS5unBjZL6Ozu+EfsvcLRlsDDRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799012)(40470700004)(36840700001)(2616005)(1076003)(7696005)(36756003)(6666004)(45080400002)(478600001)(70206006)(110136005)(316002)(54906003)(70586007)(8676002)(40460700003)(86362001)(4326008)(356005)(81166007)(82740400003)(36860700001)(32650700002)(8936002)(40480700001)(26005)(336012)(426003)(83380400001)(16526019)(921008)(7416002)(5660300002)(41300700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 10:07:51.0503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7232a0-f0cc-4f6f-1a94-08dbfa3108da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4954
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

