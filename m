Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E7E76C52F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjHBGQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjHBGQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:16:48 -0400
Received: from out28-127.mail.aliyun.com (out28-127.mail.aliyun.com [115.124.28.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840E526A2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:16:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=SUSPECT;BC=0.6541337|-1;BR=01201311R791b1;CH=blue;DM=|SUSPECT|false|;DS=CONTINUE|ham_alarm|0.028097-0.000655634-0.971247;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6WzUYo_1690956999;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6WzUYo_1690956999)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 14:16:41 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/display: Clean up errors in dcn10_dpp_dscl.c
Date:   Wed,  2 Aug 2023 06:16:35 +0000
Message-Id: <20230802061635.11243-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: else should follow close brace '}'

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
index 7e140c35a0ce..5ca9ab8a76e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
@@ -197,8 +197,7 @@ static void dpp1_dscl_set_lb(
 			DITHER_EN, 0, /* Dithering enable: Disabled */
 			INTERLEAVE_EN, lb_params->interleave_en, /* Interleave source enable */
 			LB_DATA_FORMAT__ALPHA_EN, lb_params->alpha_en); /* Alpha enable */
-	}
-	else {
+	} else {
 		/* DSCL caps: pixel data processed in float format */
 		REG_SET_2(LB_DATA_FORMAT, 0,
 			INTERLEAVE_EN, lb_params->interleave_en, /* Interleave source enable */
-- 
2.17.1

