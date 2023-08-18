Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBE47804AE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357702AbjHRD37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357703AbjHRD3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:29:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7001982;
        Thu, 17 Aug 2023 20:28:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q59sZV0h8vgJco3xyXWywWGF022qF6Jz+h1nMMT/QSkNdxofHQS+bqezmex9Lnsh1H1L0dJ9egfbnAopT6AANfb7m8UirXwLxFVUeGI1am7fX+ijT0LEYlJR23TyktDoF/jdkEmzyP+zwZ+J0e5UsKXPCXX5EZKCr+6m0whopVh7jhrQOfuwmzdoXssIzkTBeXuI3X4N+gd9GokuBfjZ1t3HCDKd2tpt9ehvDT+51JM4pUJ/BoeZdetEVglBayHSjqxxLEy4H0nf9SXVFxa5j7qgBUy3bqxG87hokHBXFLk7Nw5gclpM9ifKi4lqGtyUVcfs/lrU2xOG7tyadNYi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBMyP5sjBldwqJ3K6uKO9aVAXKYlirNWck9M6BuMFVM=;
 b=oEFdqbrtoGlcjhmDDU8reNuzagSCuEcUoXllXj4VuQAY+QoFmRKaR3S/LIXvL8K3HVzwYOhJyVQvzcHr6qyPlWaDzhMtrC/cgADnW/r7e12KS8PRsM0noABkp24J/0hj1XaDlBpbUd4F7d/8psN4BBeGmTXixyeUz4TdP4TgiDlCMkFwyIUUxJPt9T5eO7nWnLEIbTvceG3t+2goFMvJFCFbmmDzWqQsSnkPfLGCKXSeQD5OfpEDvSCW7Ss5w2krPkaOvlTIAk5Jsi8USGutE6b2Sg0bpVwXq6v44gKHigXUBRuMY/ZkBHO6kIhSaIigHvuj7UZhiN9Sa9G0byH2vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBMyP5sjBldwqJ3K6uKO9aVAXKYlirNWck9M6BuMFVM=;
 b=itAqSOwhCJEA/Z3elDq7tA+6t86fofZCsZ+O7wgjd2Hcs8D6r7WYDpoZEb+jp0CkR7AzTzuINo4P55KKkr6gy/APm0xK5qaAMa10S6HsyaDzwi12xgYfKBfRUh87KLKfzOzr+2wwtKtz8+SPXHVDJLAYcZxWsD44efhaovuFm1M=
Received: from SA0PR11CA0055.namprd11.prod.outlook.com (2603:10b6:806:d0::30)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 03:28:35 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:d0:cafe::7a) by SA0PR11CA0055.outlook.office365.com
 (2603:10b6:806:d0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Fri, 18 Aug 2023 03:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 03:28:35 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 22:28:29 -0500
From:   Evan Quan <evan.quan@amd.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <lenb@kernel.org>, <johannes@sipsolutions.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <alexander.deucher@amd.com>, <andrew@lunn.ch>,
        <rdunlap@infradead.org>, <quic_jjohnson@quicinc.com>,
        <horms@kernel.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        Evan Quan <evan.quan@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [V9 9/9] drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.7
Date:   Fri, 18 Aug 2023 11:26:19 +0800
Message-ID: <20230818032619.3341234-10-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818032619.3341234-1-evan.quan@amd.com>
References: <20230818032619.3341234-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: b25620ae-9e20-435f-befc-08db9f9b34b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Umn1oYGDFgJ/55mze+LvMfff/fxXyQqbGgAOOXYG1fsJaU9QIu6JISQ2SeLWZH9RxGlIa+p1Q/YIB6Xqx3sfPXR/n0ubtxPWkWnKYEqZ5PPQkuP0/5OzcjOIhymrxG8zCsCIWpbjC3FWo7dxzSHZnQq53OnGWu+8x1TcYAShr+n1xMcUu6GEL3eiSe6kwokP93QcVxjoTlXAIl5Jtd7N+ZsVAsNpXXvo/HN3qPFOrIFQN8KLW/lb8rAPZtovvMmqIneZ7tLWepAnvYAKYkRSomfxslxL2n9U1MWLVs0/KJwzxtRrNSIlmsvZDasfwNlT0W/YAZuBB9SQNtOMZ7N8mJb9r2dREPCBPA+MdHTC2kDD/1QEt6NwnQECl9TA6WsXBMZ5ONGNtamfeiVbSAeDdKriGBGDUHyqqn2mRJym1l9lGX5W0DyHdHiw521rVxxJqlwD5WyQW90wFmlerkuoiB3EuObasI3NbvU0225Xk18kqQx4YMwrj8AUz42fWnJDJ+eeg8TaiL8KAeTcQLtSFiKiERUfy9PWUNYbDdAmszjgR1/lEwMk36bqLuGH85UW+QYB96SgM6m5gVzRFUlToo6xMoM3FdLytiIbP4eSbuvJqiNRBF5QhbUBH5wAyK9yqkLjhCvD6L7WS78dxteCz8mBBMI0OBLEkecOH2K8b5ZSJ8oOPyasQageUvjbf2Iq/fymw646ayjjQzE2ipKtok4tAc75xN69dMTcE6Vh9k/ZaqaGGSCbMAdGWSBYcSze8F29I2qTwZTO6a7aVZq0fikZwqN00c6gRuJZQcnnehfVEEKnLzYPkvW6DAKwSnYoC8OFZpx3jTr4Oqvw4LeEvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199024)(1800799009)(82310400011)(186009)(40470700004)(36840700001)(46966006)(86362001)(36756003)(82740400003)(356005)(921005)(81166007)(40480700001)(2616005)(5660300002)(44832011)(110136005)(16526019)(70586007)(478600001)(70206006)(7696005)(6666004)(54906003)(316002)(26005)(1076003)(4326008)(8676002)(8936002)(41300700001)(40460700003)(47076005)(336012)(36860700001)(83380400001)(7416002)(426003)(2906002)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 03:28:35.5767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b25620ae-9e20-435f-befc-08db9f9b34b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fulfill the SMU13.0.7 support for Wifi RFI mitigation feature.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index b1f0937ccade..d02fe284b05d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -126,6 +126,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(AllowGpo,			PPSMC_MSG_SetGpoAllow,           0),
 	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 0),
 	MSG_MAP(NotifyPowerSource,		PPSMC_MSG_NotifyPowerSource,           0),
+	MSG_MAP(EnableUCLKShadow,		PPSMC_MSG_EnableUCLKShadow,            0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] = {
@@ -207,6 +208,7 @@ static struct cmn2asic_mapping smu_v13_0_7_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP(ACTIVITY_MONITOR_COEFF),
 	[SMU_TABLE_COMBO_PPTABLE] = {1, TABLE_COMBO_PPTABLE},
 	TAB_MAP(OVERDRIVE),
+	TAB_MAP(WIFIBAND),
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_pwr_src_map[SMU_POWER_SOURCE_COUNT] = {
@@ -497,6 +499,9 @@ static int smu_v13_0_7_tables_init(struct smu_context *smu)
 	               AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_COMBO_PPTABLE, MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE,
 			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	SMU_TABLE_INIT(tables, SMU_TABLE_WIFIBAND,
+		       sizeof(WifiBandEntryTable_t), PAGE_SIZE,
+		       AMDGPU_GEM_DOMAIN_VRAM);
 
 	smu_table->metrics_table = kzalloc(sizeof(SmuMetricsExternal_t), GFP_KERNEL);
 	if (!smu_table->metrics_table)
@@ -2173,6 +2178,57 @@ static int smu_v13_0_7_set_df_cstate(struct smu_context *smu,
 					       NULL);
 }
 
+static bool smu_v13_0_7_wbrf_support_check(struct smu_context *smu)
+{
+	return smu->smc_fw_version > 0x00524600;
+}
+
+static int smu_v13_0_7_set_wbrf_exclusion_ranges(struct smu_context *smu,
+						 struct exclusion_range *exclusion_ranges)
+{
+	WifiBandEntryTable_t wifi_bands;
+	int valid_entries = 0;
+	int ret, i;
+
+	memset(&wifi_bands, 0, sizeof(wifi_bands));
+	for (i = 0; i < ARRAY_SIZE(wifi_bands.WifiBandEntry); i++) {
+		if (!exclusion_ranges[i].start &&
+		    !exclusion_ranges[i].end)
+			break;
+
+		/* PMFW expects the inputs to be in Mhz unit */
+		wifi_bands.WifiBandEntry[valid_entries].LowFreq =
+			DIV_ROUND_DOWN_ULL(exclusion_ranges[i].start, HZ_IN_MHZ);
+		wifi_bands.WifiBandEntry[valid_entries++].HighFreq =
+			DIV_ROUND_UP_ULL(exclusion_ranges[i].end, HZ_IN_MHZ);
+	}
+	wifi_bands.WifiBandEntryNum = valid_entries;
+
+	/*
+	 * Per confirm with PMFW team, WifiBandEntryNum = 0 is a valid setting.
+	 * Considering the scenarios below:
+	 * - At first the wifi device adds an exclusion range e.g. (2400,2500) to
+	 *   BIOS and our driver gets notified. We will set WifiBandEntryNum = 1
+	 *   and pass the WifiBandEntry (2400, 2500) to PMFW.
+	 *
+	 * - Later the wifi device removes the wifiband list added above and
+	 *   our driver gets notified again. At this time, driver will set
+	 *   WifiBandEntryNum = 0 and pass an empty WifiBandEntry list to PMFW.
+	 *   - PMFW may still need to do some uclk shadow update(e.g. switching
+	 *     from shadow clock back to primary clock) on receiving this.
+	 */
+
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_WIFIBAND,
+				   0,
+				   (void *)(&wifi_bands),
+				   true);
+	if (ret)
+		dev_err(smu->adev->dev, "Failed to set wifiband!");
+
+	return ret;
+}
+
 static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_7_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_7_set_default_dpm_table,
@@ -2241,6 +2297,9 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.set_mp1_state = smu_v13_0_7_set_mp1_state,
 	.set_df_cstate = smu_v13_0_7_set_df_cstate,
 	.gpo_control = smu_v13_0_gpo_control,
+	.is_asic_wbrf_supported = smu_v13_0_7_wbrf_support_check,
+	.enable_uclk_shadow = smu_v13_0_enable_uclk_shadow,
+	.set_wbrf_exclusion_ranges = smu_v13_0_7_set_wbrf_exclusion_ranges,
 };
 
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
-- 
2.34.1

