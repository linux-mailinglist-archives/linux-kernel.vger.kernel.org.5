Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428E478F375
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347196AbjHaTjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjHaTjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:39:09 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FD01BF;
        Thu, 31 Aug 2023 12:39:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAKqX01R/LepbLxLfsnHr4+wmr/s0vga78Qlm8l99tHmp+royrrIax9zcXD43n7E4BETQS+Rv9PM6T6dSyLC0WqDKVJCFdj8sxLFAfalCHapGLOO0Hitu6yB9rLpodoYNtjhJxsA+pXg2OrIdzvlfLUaj5nRKCA0dQE8ocAxtcYBq+aNFyM64bcvsqcSRTb/S9dofTis8QHCfxIBWjCyKqErbhalfLozFTpsJMQs7v1hMOhZFDcpst5vB5L1cy6scHUOH0e20rxkg/SX1QYfOJEqqmldC2/EEfyU3GODckgnora+9zlq7kPmiXWHVDfP4VuKEumClN3hX7SP9jF6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHoFikkHZlk/NJWt/jLlG914P/y7IVqyTmQ+TUyD6zw=;
 b=Ujt3HAffSsU8jQMVv5AQs3ceHGH6oMLNyBXmZG2R2BDHykqC99HRuIoqsFUijq3GSlvq/9U+yn2HXtlFG30X74ZrCW2Cu6X/9ZYXQH+WNXX4fFCoyfzhIsmTpVdZJM4RxQG6jiIAerkMhXg8mPUPrdSOExswrRFYtWm5dPsD79X2PMbNYgIWCgYD0DmJelQP/Vuuz4fomCsKWdB02AafLMM9YcJJ0PkQBBZGswPhaA5uTneopCvwHiOONimbB2Bi2Or0VN4iMzCdDSkYAsdeqosSD4C4IuCAPTqSA0PzZamON+4R/cU6UBGw7zqplN03hUjIJCxuv93GjY1uaMl+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHoFikkHZlk/NJWt/jLlG914P/y7IVqyTmQ+TUyD6zw=;
 b=3JaXazPJdW2anDu5luSKwBJbApkObUqOP/cxQKF6Sh8fOHjNXAuIQ8LPR+ODyARgS+yenOvU06i2LOvdsO8sne4TCXTxzCILASIiiGpiBQfWo734EW/DD70GKDXaSB5+Fbaw0W/ykbRhPMq3amKCUVN54LvKlrJQ72PvD+CwHHQ=
Received: from SJ2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:a03:505::26)
 by PH7PR12MB9068.namprd12.prod.outlook.com (2603:10b6:510:1f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 19:39:03 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::7) by SJ2PR07CA0003.outlook.office365.com
 (2603:10b6:a03:505::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Thu, 31 Aug 2023 19:39:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 19:39:00 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 14:38:58 -0500
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     Fangzhi Zuo <jerry.zuo@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        <stable@vger.kernel.org>, Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jun Lei <jun.lei@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        "Nicholas Kazlauskas" <nicholas.kazlauskas@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        Alvin Lee <Alvin.Lee2@amd.com>,
        Sung Joon Kim <sungjoon.kim@amd.com>,
        "Daniel Miess" <daniel.miess@amd.com>,
        Gabe Teeger <gabe.teeger@amd.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] Revert "drm/amd/display: Remove v_startup workaround for dcn3+"
Date:   Thu, 31 Aug 2023 15:38:41 -0400
Message-ID: <20230831193844.154254-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|PH7PR12MB9068:EE_
X-MS-Office365-Filtering-Correlation-Id: d913baeb-609d-4a44-ebb0-08dbaa59ed1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rnrww5mWuzDtEgm+kZlvtCI1zhHDpG9oNYMGRl6o5Pvpw2BpF4ZtuWZmQ92quNOlE06yFtwcBwc440hAa+9pFggwRhDSDikO2joKAKZ5y0g03FiZmngszA104zKqvtaVenLE3Ch9p0+cQYqHjzt71hrJs3QL/dR+bFnUIyLnCnqeCty145M4bdI5T4JQUyy4WQx00t4tn4r1GIEzgKq7CvUMQfariz4a+GRCqwuvVsI+92Uc7wFnnOjQKhoB/1uAd1XdK2cwzx6c+mG0MuZ76NZyecf4/lvSkke36tOScxWMohPG21nBXbLb7CrW3E95CI2ADyIkDT4qo+z+3Lak8CyR0zb08SQm9eU+ivOuSdav5Y/cWfkAgt/YaSygc8OIHp1LnhblPiARXOJGUiL4DBcfTxG0AbCpM4AG58MRWwYRoqp3WXn2Rh51oARuu9K4BL3FcXG0zXf5MUhOoVtxYk4jUCB3yxAKmAsm3NdeoM42WtnOeRvfFPwknbcjmN+7AwpCcQfnYEVb7JIJdcPPe5bnpjue1beH+7ifxlpHIXnfkrJH/GfMr3f6HVhdEQHXauddWyJxJ8PiEvxIndyoSabgZtaCSHxEmz/YfP6cLEV3or2uFB5uzueGDp3KZ4MPVwj8wTTLze9MuZoDQRgNDFeEOvGHqQXaN/Iowdm8XXHbaLKTkTmVP38PK2R6y54jZvsW6uRebfX9rpTNmwtgOfmSwHeV7WzVm6E5Fl5rJipA16Op66am8i8P2syv5zUNbQSkBEgn8Sa1aw4DrLX+yzYCElUZdI8BSPpwR6uVXfk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199024)(1800799009)(82310400011)(186009)(36840700001)(46966006)(40470700004)(6666004)(2906002)(5660300002)(86362001)(316002)(6916009)(478600001)(44832011)(2616005)(47076005)(4326008)(36860700001)(8676002)(8936002)(966005)(40460700003)(1076003)(26005)(82740400003)(40480700001)(41300700001)(336012)(426003)(36756003)(356005)(81166007)(70206006)(70586007)(83380400001)(54906003)(16526019)(16060500005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 19:39:00.8426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d913baeb-609d-4a44-ebb0-08dbaa59ed1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9068
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 3a31e8b89b7240d9a17ace8a1ed050bdcb560f9e.

We still need to call dcn20_adjust_freesync_v_startup() for older DCN3+
ASICs otherwise it can cause DP to HDMI 2.1 PCONs to fail to light up.

Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2809
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 24 ++++---------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 0989a0152ae8..1bfdf0271fdf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1099,6 +1099,10 @@ void dcn20_calculate_dlg_params(struct dc *dc,
 		context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz =
 						pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
 		context->res_ctx.pipe_ctx[i].pipe_dlg_param = pipes[pipe_idx].pipe.dest;
+		if (context->res_ctx.pipe_ctx[i].stream->adaptive_sync_infopacket.valid)
+			dcn20_adjust_freesync_v_startup(
+				&context->res_ctx.pipe_ctx[i].stream->timing,
+				&context->res_ctx.pipe_ctx[i].pipe_dlg_param.vstartup_start);
 
 		pipe_idx++;
 	}
@@ -1927,7 +1931,6 @@ static bool dcn20_validate_bandwidth_internal(struct dc *dc, struct dc_state *co
 	int vlevel = 0;
 	int pipe_split_from[MAX_PIPES];
 	int pipe_cnt = 0;
-	int i = 0;
 	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_ATOMIC);
 	DC_LOGGER_INIT(dc->ctx->logger);
 
@@ -1951,15 +1954,6 @@ static bool dcn20_validate_bandwidth_internal(struct dc *dc, struct dc_state *co
 	dcn20_calculate_wm(dc, context, pipes, &pipe_cnt, pipe_split_from, vlevel, fast_validate);
 	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		if (!context->res_ctx.pipe_ctx[i].stream)
-			continue;
-		if (context->res_ctx.pipe_ctx[i].stream->adaptive_sync_infopacket.valid)
-			dcn20_adjust_freesync_v_startup(
-				&context->res_ctx.pipe_ctx[i].stream->timing,
-				&context->res_ctx.pipe_ctx[i].pipe_dlg_param.vstartup_start);
-	}
-
 	BW_VAL_TRACE_END_WATERMARKS();
 
 	goto validate_out;
@@ -2232,7 +2226,6 @@ bool dcn21_validate_bandwidth_fp(struct dc *dc,
 	int vlevel = 0;
 	int pipe_split_from[MAX_PIPES];
 	int pipe_cnt = 0;
-	int i = 0;
 	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_ATOMIC);
 	DC_LOGGER_INIT(dc->ctx->logger);
 
@@ -2261,15 +2254,6 @@ bool dcn21_validate_bandwidth_fp(struct dc *dc,
 	dcn21_calculate_wm(dc, context, pipes, &pipe_cnt, pipe_split_from, vlevel, fast_validate);
 	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		if (!context->res_ctx.pipe_ctx[i].stream)
-			continue;
-		if (context->res_ctx.pipe_ctx[i].stream->adaptive_sync_infopacket.valid)
-			dcn20_adjust_freesync_v_startup(
-				&context->res_ctx.pipe_ctx[i].stream->timing,
-				&context->res_ctx.pipe_ctx[i].pipe_dlg_param.vstartup_start);
-	}
-
 	BW_VAL_TRACE_END_WATERMARKS();
 
 	goto validate_out;
-- 
2.41.0

