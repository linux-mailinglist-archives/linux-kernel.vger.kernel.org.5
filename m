Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550097B1049
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 03:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjI1BN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 21:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1BN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 21:13:58 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049CCBF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 18:13:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vt.c2tB_1695863632;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vt.c2tB_1695863632)
          by smtp.aliyun-inc.com;
          Thu, 28 Sep 2023 09:13:53 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] drm/amd/display: clean up some inconsistent indentings
Date:   Thu, 28 Sep 2023 09:13:51 +0800
Message-Id: <20230928011351.110093-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
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

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn35/dcn35_fpu.c:261 dcn35_update_bw_bounding_box_fpu() warn: inconsistent indenting

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  | 144 +++++++++---------
 1 file changed, 72 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 4d5ee2aad9e4..4f284c31de5d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -258,85 +258,85 @@ void dcn35_update_bw_bounding_box_fpu(struct dc *dc,
 
 	dc_assert_fp_enabled();
 
-		dcn3_5_ip.max_num_otg =
-			dc->res_pool->res_cap->num_timing_generator;
-		dcn3_5_ip.max_num_dpp = dc->res_pool->pipe_count;
-		dcn3_5_soc.num_chans = bw_params->num_channels;
-
-		ASSERT(clk_table->num_entries);
-
-		/* Prepass to find max clocks independent of voltage level. */
-		for (i = 0; i < clk_table->num_entries; ++i) {
-			if (clk_table->entries[i].dispclk_mhz > max_dispclk_mhz)
-				max_dispclk_mhz = clk_table->entries[i].dispclk_mhz;
-			if (clk_table->entries[i].dppclk_mhz > max_dppclk_mhz)
-				max_dppclk_mhz = clk_table->entries[i].dppclk_mhz;
-		}
+	dcn3_5_ip.max_num_otg =
+		dc->res_pool->res_cap->num_timing_generator;
+	dcn3_5_ip.max_num_dpp = dc->res_pool->pipe_count;
+	dcn3_5_soc.num_chans = bw_params->num_channels;
+
+	ASSERT(clk_table->num_entries);
+
+	/* Prepass to find max clocks independent of voltage level. */
+	for (i = 0; i < clk_table->num_entries; ++i) {
+		if (clk_table->entries[i].dispclk_mhz > max_dispclk_mhz)
+			max_dispclk_mhz = clk_table->entries[i].dispclk_mhz;
+		if (clk_table->entries[i].dppclk_mhz > max_dppclk_mhz)
+			max_dppclk_mhz = clk_table->entries[i].dppclk_mhz;
+	}
 
-		for (i = 0; i < clk_table->num_entries; i++) {
-			/* loop backwards*/
-			for (closest_clk_lvl = 0, j = dcn3_5_soc.num_states - 1;
-			     j >= 0; j--) {
-				if (dcn3_5_soc.clock_limits[j].dcfclk_mhz <=
-				    clk_table->entries[i].dcfclk_mhz) {
-					closest_clk_lvl = j;
-					break;
-				}
-			}
-			if (clk_table->num_entries == 1) {
-				/*smu gives one DPM level, let's take the highest one*/
-				closest_clk_lvl = dcn3_5_soc.num_states - 1;
+	for (i = 0; i < clk_table->num_entries; i++) {
+		/* loop backwards*/
+		for (closest_clk_lvl = 0, j = dcn3_5_soc.num_states - 1;
+			j >= 0; j--) {
+			if (dcn3_5_soc.clock_limits[j].dcfclk_mhz <=
+				clk_table->entries[i].dcfclk_mhz) {
+				closest_clk_lvl = j;
+				break;
 			}
+		}
+		if (clk_table->num_entries == 1) {
+			/*smu gives one DPM level, let's take the highest one*/
+			closest_clk_lvl = dcn3_5_soc.num_states - 1;
+		}
 
-			clock_limits[i].state = i;
-
-			/* Clocks dependent on voltage level. */
-			clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
-			if (clk_table->num_entries == 1 &&
-			    clock_limits[i].dcfclk_mhz <
-			    dcn3_5_soc.clock_limits[closest_clk_lvl].dcfclk_mhz) {
-				/*SMU fix not released yet*/
-				clock_limits[i].dcfclk_mhz =
-					dcn3_5_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;
-			}
+		clock_limits[i].state = i;
 
-			clock_limits[i].fabricclk_mhz =
-				clk_table->entries[i].fclk_mhz;
-			clock_limits[i].socclk_mhz =
-				clk_table->entries[i].socclk_mhz;
-
-			if (clk_table->entries[i].memclk_mhz &&
-			    clk_table->entries[i].wck_ratio)
-				clock_limits[i].dram_speed_mts =
-					clk_table->entries[i].memclk_mhz * 2 *
-					clk_table->entries[i].wck_ratio;
-
-			/* Clocks independent of voltage level. */
-			clock_limits[i].dispclk_mhz = max_dispclk_mhz ?
-				max_dispclk_mhz :
-				dcn3_5_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
-
-			clock_limits[i].dppclk_mhz = max_dppclk_mhz ?
-				max_dppclk_mhz :
-				dcn3_5_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
-
-			clock_limits[i].dram_bw_per_chan_gbps =
-				dcn3_5_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
-			clock_limits[i].dscclk_mhz =
-				dcn3_5_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
-			clock_limits[i].dtbclk_mhz =
-				dcn3_5_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
-			clock_limits[i].phyclk_d18_mhz =
-				dcn3_5_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
-			clock_limits[i].phyclk_mhz =
-				dcn3_5_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
+		/* Clocks dependent on voltage level. */
+		clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
+		if (clk_table->num_entries == 1 &&
+			clock_limits[i].dcfclk_mhz <
+			dcn3_5_soc.clock_limits[closest_clk_lvl].dcfclk_mhz) {
+			/*SMU fix not released yet*/
+			clock_limits[i].dcfclk_mhz =
+				dcn3_5_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;
 		}
 
-		memcpy(dcn3_5_soc.clock_limits, clock_limits,
-		       sizeof(dcn3_5_soc.clock_limits));
+		clock_limits[i].fabricclk_mhz =
+			clk_table->entries[i].fclk_mhz;
+		clock_limits[i].socclk_mhz =
+			clk_table->entries[i].socclk_mhz;
+
+		if (clk_table->entries[i].memclk_mhz &&
+			clk_table->entries[i].wck_ratio)
+			clock_limits[i].dram_speed_mts =
+				clk_table->entries[i].memclk_mhz * 2 *
+				clk_table->entries[i].wck_ratio;
+
+		/* Clocks independent of voltage level. */
+		clock_limits[i].dispclk_mhz = max_dispclk_mhz ?
+			max_dispclk_mhz :
+			dcn3_5_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
+
+		clock_limits[i].dppclk_mhz = max_dppclk_mhz ?
+			max_dppclk_mhz :
+			dcn3_5_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
+
+		clock_limits[i].dram_bw_per_chan_gbps =
+			dcn3_5_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
+		clock_limits[i].dscclk_mhz =
+			dcn3_5_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
+		clock_limits[i].dtbclk_mhz =
+			dcn3_5_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
+		clock_limits[i].phyclk_d18_mhz =
+			dcn3_5_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
+		clock_limits[i].phyclk_mhz =
+			dcn3_5_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
+	}
+
+	memcpy(dcn3_5_soc.clock_limits, clock_limits,
+		sizeof(dcn3_5_soc.clock_limits));
 
-		if (clk_table->num_entries)
-			dcn3_5_soc.num_states = clk_table->num_entries;
+	if (clk_table->num_entries)
+		dcn3_5_soc.num_states = clk_table->num_entries;
 
 	if (max_dispclk_mhz) {
 		dcn3_5_soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
-- 
2.20.1.7.g153144c

