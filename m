Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CE176C319
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjHBCwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjHBCwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:52:12 -0400
Received: from out28-106.mail.aliyun.com (out28-106.mail.aliyun.com [115.124.28.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52A71FD6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:52:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1871421|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_alarm|0.114493-0.00247554-0.883031;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6NOoqR_1690944723;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6NOoqR_1690944723)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 10:52:05 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/display: Clean up errors in dce110_timing_generator.c
Date:   Wed,  2 Aug 2023 02:52:02 +0000
Message-Id: <20230802025202.10282-1-sunran001@208suo.com>
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

ERROR: spaces required around that '=' (ctx:WxV)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 .../gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
index 27cbb5b42c7e..6424e7f279dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
@@ -288,7 +288,7 @@ bool dce110_timing_generator_program_timing_generator(
 
 	uint32_t vsync_offset = dc_crtc_timing->v_border_bottom +
 			dc_crtc_timing->v_front_porch;
-	uint32_t v_sync_start =dc_crtc_timing->v_addressable + vsync_offset;
+	uint32_t v_sync_start = dc_crtc_timing->v_addressable + vsync_offset;
 
 	uint32_t hsync_offset = dc_crtc_timing->h_border_right +
 			dc_crtc_timing->h_front_porch;
@@ -603,7 +603,7 @@ void dce110_timing_generator_program_blanking(
 {
 	uint32_t vsync_offset = timing->v_border_bottom +
 			timing->v_front_porch;
-	uint32_t v_sync_start =timing->v_addressable + vsync_offset;
+	uint32_t v_sync_start = timing->v_addressable + vsync_offset;
 
 	uint32_t hsync_offset = timing->h_border_right +
 			timing->h_front_porch;
-- 
2.17.1

