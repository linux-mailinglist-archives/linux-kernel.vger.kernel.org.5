Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1878D76AC9F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjHAJRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjHAJQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:16:49 -0400
Received: from out198-5.us.a.mail.aliyun.com (out198-5.us.a.mail.aliyun.com [47.90.198.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE5944BB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:15:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1113862|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0177519-0.00266611-0.979582;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5qtWqJ_1690881266;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5qtWqJ_1690881266)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 17:14:30 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd: Clean up errors in processpptables.c
Date:   Tue,  1 Aug 2023 09:14:25 +0000
Message-Id: <20230801091425.7181-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following function definitions go on the next line
ERROR: code indent should use tabs where possible
ERROR: space required before the open parenthesis '('

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index 1866fe20f9e2..f05f011c78be 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -676,7 +676,7 @@ static PP_StateClassificationFlags make_classification_flags(
 static int init_non_clock_fields(struct pp_hwmgr *hwmgr,
 						struct pp_power_state *ps,
 							    uint8_t version,
-			 const ATOM_PPLIB_NONCLOCK_INFO *pnon_clock_info) 
+			 const ATOM_PPLIB_NONCLOCK_INFO *pnon_clock_info)
 {
 	unsigned long rrr_index;
 	unsigned long tmp;
-- 
2.17.1

