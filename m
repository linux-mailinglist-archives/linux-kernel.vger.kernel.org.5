Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5013178F6B8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 03:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348083AbjIAB3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 21:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348074AbjIAB3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 21:29:39 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFD4E7E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 18:29:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Vqzer6v_1693531772;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vqzer6v_1693531772)
          by smtp.aliyun-inc.com;
          Fri, 01 Sep 2023 09:29:33 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        harry.wentland@amd.com, Rodrigo.Siqueira@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 4/5] drm/amd/display: clean up some inconsistent indentings
Date:   Fri,  1 Sep 2023 09:29:23 +0800
Message-Id: <20230901012924.120196-4-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20230901012924.120196-1-yang.lee@linux.alibaba.com>
References: <20230901012924.120196-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c:288 dcn35_update_clocks() warn: inconsistent indenting

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 9314e75195cd..98d6a1f8af60 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -288,8 +288,8 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	// workaround: Limit dppclk to 100Mhz to avoid lower eDP panel switch to plus 4K monitor underflow.
-		if (new_clocks->dppclk_khz < 100000)
-			new_clocks->dppclk_khz = 100000;
+	if (new_clocks->dppclk_khz < 100000)
+		new_clocks->dppclk_khz = 100000;
 
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr->base.clks.dppclk_khz)) {
 		if (clk_mgr->base.clks.dppclk_khz > new_clocks->dppclk_khz)
@@ -901,21 +901,21 @@ void dcn35_clk_mgr_construct(
 
 	ASSERT(smu_dpm_clks.dpm_clks);
 
-		clk_mgr->base.smu_ver = dcn35_smu_get_smu_version(&clk_mgr->base);
+	clk_mgr->base.smu_ver = dcn35_smu_get_smu_version(&clk_mgr->base);
 
-		if (clk_mgr->base.smu_ver)
-			clk_mgr->base.smu_present = true;
+	if (clk_mgr->base.smu_ver)
+		clk_mgr->base.smu_present = true;
 
-		/* TODO: Check we get what we expect during bringup */
-		clk_mgr->base.base.dentist_vco_freq_khz = get_vco_frequency_from_reg(&clk_mgr->base);
+	/* TODO: Check we get what we expect during bringup */
+	clk_mgr->base.base.dentist_vco_freq_khz = get_vco_frequency_from_reg(&clk_mgr->base);
 
-		if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType) {
-			dcn35_bw_params.wm_table = lpddr5_wm_table;
-		} else {
-			dcn35_bw_params.wm_table = ddr5_wm_table;
-		}
-		/* Saved clocks configured at boot for debug purposes */
-		 dcn35_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, &clk_mgr->base.base, &log_info);
+	if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType) {
+		dcn35_bw_params.wm_table = lpddr5_wm_table;
+	} else {
+		dcn35_bw_params.wm_table = ddr5_wm_table;
+	}
+	/* Saved clocks configured at boot for debug purposes */
+	dcn35_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, &clk_mgr->base.base, &log_info);
 
 	clk_mgr->base.base.dprefclk_khz = dcn35_smu_get_dprefclk(&clk_mgr->base);
 	clk_mgr->base.base.clks.ref_dtbclk_khz = dcn35_smu_get_dtbclk(&clk_mgr->base);
-- 
2.20.1.7.g153144c

