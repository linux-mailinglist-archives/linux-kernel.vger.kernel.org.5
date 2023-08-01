Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4373076AA6A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjHAIAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjHAIAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:00:01 -0400
Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com [115.124.28.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33711729
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:00:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.536621|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0202322-0.000328368-0.979439;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5lph8q_1690876792;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5lph8q_1690876792)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 15:59:54 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in smu_helper.c
Date:   Tue,  1 Aug 2023 07:59:51 +0000
Message-Id: <20230801075951.6467-1-sunran001@208suo.com>
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

ERROR: spaces required around that '=' (ctx:VxV)
ERROR: spaces required around that '<' (ctx:VxV)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
index d0b1ab6c4523..79a566f3564a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
@@ -696,7 +696,7 @@ int smu_get_voltage_dependency_table_ppt_v1(
 				return -EINVAL);
 
 	dep_table->count = allowed_dep_table->count;
-	for (i=0; i<dep_table->count; i++) {
+	for (i = 0; i < dep_table->count; i++) {
 		dep_table->entries[i].clk = allowed_dep_table->entries[i].clk;
 		dep_table->entries[i].vddInd = allowed_dep_table->entries[i].vddInd;
 		dep_table->entries[i].vdd_offset = allowed_dep_table->entries[i].vdd_offset;
-- 
2.17.1

