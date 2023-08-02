Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2603776C302
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjHBCkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjHBCkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:40:05 -0400
Received: from out28-135.mail.aliyun.com (out28-135.mail.aliyun.com [115.124.28.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D861199F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:40:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4055942|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_alarm|0.00105794-0.000121474-0.998821;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6N4oZg_1690943996;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6N4oZg_1690943996)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 10:39:58 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/display: Clean up errors in color_gamma.c
Date:   Wed,  2 Aug 2023 02:39:55 +0000
Message-Id: <20230802023955.10014-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: trailing whitespace
ERROR: else should follow close brace '}'

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 67a062af3ab0..ff8e5708735d 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -359,7 +359,7 @@ static struct fixed31_32 translate_from_linear_space(
 		scratch_1 = dc_fixpt_add(one, args->a3);
 		/* In the first region (first 16 points) and in the
 		 * region delimited by START/END we calculate with
-		 * full precision to avoid error accumulation. 
+		 * full precision to avoid error accumulation.
 		 */
 		if ((cal_buffer->buffer_index >= PRECISE_LUT_REGION_START &&
 			cal_buffer->buffer_index <= PRECISE_LUT_REGION_END) ||
@@ -379,8 +379,7 @@ static struct fixed31_32 translate_from_linear_space(
 		scratch_1 = dc_fixpt_sub(scratch_1, args->a2);
 
 		return scratch_1;
-	}
-	else
+	} else
 		return dc_fixpt_mul(args->arg, args->a1);
 }
 
-- 
2.17.1

