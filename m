Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1DD76C541
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjHBG0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjHBG0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:26:10 -0400
Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com [115.124.28.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D4F119
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:26:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.6958764|0.7372184;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_alarm|0.067393-0.00265674-0.92995;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6XebAJ_1690957561;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6XebAJ_1690957561)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 14:26:02 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/display: Clean up errors in dce_clk_mgr.c
Date:   Wed,  2 Aug 2023 06:25:59 +0000
Message-Id: <20230802062559.11421-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: spaces required around that '?' (ctx:VxE)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c
index 07359eb89efc..e7acd6eec1fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c
@@ -640,7 +640,7 @@ static void dce11_pplib_apply_display_requirements(
 	 * on power saving.
 	 *
 	 */
-	pp_display_cfg->min_dcfclock_khz = (context->stream_count > 4)?
+	pp_display_cfg->min_dcfclock_khz = (context->stream_count > 4) ?
 			pp_display_cfg->min_engine_clock_khz : 0;
 
 	pp_display_cfg->min_engine_clock_deep_sleep_khz
-- 
2.17.1

