Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B337B2288
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjI1Qfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjI1Qfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:35:31 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7EF1B2;
        Thu, 28 Sep 2023 09:35:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPCiRwirDYeknCAvBFZnGYHQ2VHZWt3YQF4qVCfrf+FBP/llKyQvqjZgKMcm8/xHiA8RLuhMILc6tkuBnyKWFF3yrzjmqWNh3XBYj0H2e+vijopou1EHqeNXh3M2BDrTGGT3GkB3Q0/l6nQ/whqBPZuUKXf3VJ7FF9/ctOoNVOk5dEW75s6mvkkdYXEbqilOQJqauUNfjkT0X0Rjmr5X20S9r0esDWwU/xrNWw+SMCNlZDv9cOj7eWLiFTJqsfL0mTYZKP+lSM9NbyBmxl0/8aY+swSC2Z2v++tNVXlZTV4R4UC3K7qnCT4SPNE5afC+Jytnnxs/XIIXYK0GDtf9/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5OIu6RRtVym6D1Xr0OA1kvs4ww2UlYO8OxBK1h0xXM=;
 b=AYq7Pa1dfA8MLgE/KXtSaC3QTeYqJS0LqsV9CSKYXAN6bH0Fo/4EE8JuJJt1Mu51K+A1vM/Ui7wjMFooGrqdksJHQavJ3YrPD4x7jn1hDbsCyxnOJushj9b9jdkSHDKLiaAkAyz99gEMxBaCltjz5kw0whdKdEnq/HhPRKp30qShyYDBJzQucZsdvWULWoOTdp+hA/TWC6vjnlHJfHxFeI4KaH9XmKZOBpDTyHIhkgoKKR2yh4Csu+hqHzguhKkcQPqSRLltz5tnj1Ujamw4fA4Po/yslfJ9Qu7+5fq3m2YtRew6Syfb0/Rlk5gezp9aEiIir+MhY+YR21+Udjva0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5OIu6RRtVym6D1Xr0OA1kvs4ww2UlYO8OxBK1h0xXM=;
 b=wRwAcxD0ps5tCRDBgpU1mm9eqWXcVOoqs1MDJgzHqzckX/Zti5pabBpziyNdUziWdD4Y77cNufNtOwHfXi8NhWWDHGbNdKNXr47Vv5jmW3+3nKGELJRCMtaB1sdTMrbMpEa7LVR2wwMdQdK9TYf8dTtGB1zscIkRFfGggIsTaIw=
Received: from SA1PR02CA0024.namprd02.prod.outlook.com (2603:10b6:806:2cf::24)
 by PH7PR12MB8037.namprd12.prod.outlook.com (2603:10b6:510:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Thu, 28 Sep
 2023 16:35:23 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::7f) by SA1PR02CA0024.outlook.office365.com
 (2603:10b6:806:2cf::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Thu, 28 Sep 2023 16:35:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 28 Sep 2023 16:35:23 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Sep
 2023 11:35:22 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <amd-gfx@lists.freedesktop.org>,
        Sebastian Reichel <sre@kernel.org>,
        "Alex Deucher" <alexander.deucher@amd.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Jun.ma2@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 3/3] Revert "drm/amd/pm: workaround for the wrong ac power detection on smu 13.0.0"
Date:   Tue, 26 Sep 2023 17:59:55 -0500
Message-ID: <20230926225955.386553-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926225955.386553-1-mario.limonciello@amd.com>
References: <20230926225955.386553-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|PH7PR12MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d6e7fd-742b-4f1c-f9b6-08dbc040e9c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pedckA6Vl7QvB7qD5+Hg7vlIMm5JCV5Zgyx9e2mWrNTQmzQzuLIAxQWW2HHbYiq1Bd293+Su7fd7V4s8jjfbfAqxA0NVsX9W1zIoc+ofdUKVu5OrjEpivchGRhSmVlY5+niL2WiwTENVhYx9UEzeEwxc8miWLpYO3Dd9JxYUsPIYbGerbdQpTNgsjYsWYah1feDOPFt9xqtehdao5fT4B+fg49FQ1jxPrjeqrDEdfNPqpI3CTyiYoG5Faoy9CFvIFgE8ItMIm3xDvSIzE48ajYYlODK6uQ9wWdlSabHCCKVNHsaGOeoLfyxTbGFw/srYv50FAza38UEZZ3PoKTvIrqinTi/pc8cvcyJqYG4WCo36KbfCrp2c0qBeuyMGN9hyZw08QmihGlyrMWXbJrWrTndxNfUhqoOFSZjWaZ3TS5dBII0NnjnUw7Fh21LlJ4P2jm2pmmF90uZuqcFj+tG1UJEFsTNEtdaGTHbQ2g6JDrgaUWqMM5Bx55CoHktCeEiY8hJ0Fy4223Fh24udcGTWtVdKPtE/f/Ipqw5kJKr/46PZLsTyLrHRJ84Oln6oI0aj1M+k6Ch5GPPoVWT9v5o7L+YhoyHkAPddSPGIjDKE9cELb84bqsKlA6vQJTpC9zYHkz/BqpIPyVdmqNjPgmEwBNCPsp4rZwLD8j+4TlntIMc8g3TT2CposDNqvBwp7FoUyj0a9zwXRwh53lVWZX4SOC7Bw8cc7fTMFsxptjlhm4GGMKqU3jSk2Zd9Yj22JR1FssSgoFhSpjgRrAwNW2fG9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(82310400011)(64100799003)(1800799009)(451199024)(186009)(40470700004)(46966006)(36840700001)(83380400001)(66574015)(16526019)(26005)(2616005)(1076003)(8676002)(44832011)(5660300002)(336012)(426003)(8936002)(4326008)(82740400003)(81166007)(7696005)(356005)(36860700001)(47076005)(6666004)(478600001)(86362001)(40480700001)(110136005)(70206006)(54906003)(316002)(6636002)(41300700001)(70586007)(36756003)(2906002)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:35:23.4675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d6e7fd-742b-4f1c-f9b6-08dbc040e9c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8037
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This workaround is not necessary with the power supply core fixed.

This reverts commit 0e5e1a84f0b8c814d502a135824244127fed8f23.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index d86499ac8931..8d1e39589057 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1021,7 +1021,8 @@ static int smu_v13_0_process_pending_interrupt(struct smu_context *smu)
 {
 	int ret = 0;
 
-	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_ACDC_BIT))
+	if (smu->dc_controlled_by_gpio &&
+	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_ACDC_BIT))
 		ret = smu_v13_0_allow_ih_interrupt(smu);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 1c15fa911176..684b4e01fac2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -3001,6 +3001,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.enable_mgpu_fan_boost = smu_v13_0_0_enable_mgpu_fan_boost,
 	.get_power_limit = smu_v13_0_0_get_power_limit,
 	.set_power_limit = smu_v13_0_set_power_limit,
+	.set_power_source = smu_v13_0_set_power_source,
 	.get_power_profile_mode = smu_v13_0_0_get_power_profile_mode,
 	.set_power_profile_mode = smu_v13_0_0_set_power_profile_mode,
 	.run_btc = smu_v13_0_run_btc,
-- 
2.34.1

