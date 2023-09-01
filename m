Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE95078F6B5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 03:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348071AbjIAB3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 21:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237692AbjIAB3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 21:29:37 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4A8E6E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 18:29:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VqzgJqc_1693531771;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VqzgJqc_1693531771)
          by smtp.aliyun-inc.com;
          Fri, 01 Sep 2023 09:29:31 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        harry.wentland@amd.com, Rodrigo.Siqueira@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 3/5] drm/amd/display: clean up some inconsistent indentings
Date:   Fri,  1 Sep 2023 09:29:22 +0800
Message-Id: <20230901012924.120196-3-yang.lee@linux.alibaba.com>
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

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn35/dcn35_hwseq.c:159 dcn35_init_hw() warn: inconsistent indentig

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 .../drm/amd/display/dc/dcn35/dcn35_hwseq.c    | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c
index 666e2809d9dc..025849143254 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c
@@ -155,22 +155,22 @@ void dcn35_init_hw(struct dc *dc)
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
 
-			if (res_pool->dccg && res_pool->hubbub) {
-
-				(res_pool->dccg->funcs->get_dccg_ref_freq)(res_pool->dccg,
-						dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency,
-						&res_pool->ref_clocks.dccg_ref_clock_inKhz);
-
-				(res_pool->hubbub->funcs->get_dchub_ref_freq)(res_pool->hubbub,
-						res_pool->ref_clocks.dccg_ref_clock_inKhz,
-						&res_pool->ref_clocks.dchub_ref_clock_inKhz);
-			} else {
-				// Not all ASICs have DCCG sw component
-				res_pool->ref_clocks.dccg_ref_clock_inKhz =
-						res_pool->ref_clocks.xtalin_clock_inKhz;
-				res_pool->ref_clocks.dchub_ref_clock_inKhz =
-						res_pool->ref_clocks.xtalin_clock_inKhz;
-			}
+		if (res_pool->dccg && res_pool->hubbub) {
+
+			(res_pool->dccg->funcs->get_dccg_ref_freq)(res_pool->dccg,
+				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency,
+				&res_pool->ref_clocks.dccg_ref_clock_inKhz);
+
+			(res_pool->hubbub->funcs->get_dchub_ref_freq)(res_pool->hubbub,
+				res_pool->ref_clocks.dccg_ref_clock_inKhz,
+				&res_pool->ref_clocks.dchub_ref_clock_inKhz);
+		} else {
+			// Not all ASICs have DCCG sw component
+			res_pool->ref_clocks.dccg_ref_clock_inKhz =
+				res_pool->ref_clocks.xtalin_clock_inKhz;
+			res_pool->ref_clocks.dchub_ref_clock_inKhz =
+				res_pool->ref_clocks.xtalin_clock_inKhz;
+		}
 	} else
 		ASSERT_CRITICAL(false);
 
-- 
2.20.1.7.g153144c

