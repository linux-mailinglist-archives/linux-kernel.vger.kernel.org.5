Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D07576ACE0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjHAJYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjHAJXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:23:50 -0400
Received: from out28-93.mail.aliyun.com (out28-93.mail.aliyun.com [115.124.28.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331DC44B5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:22:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=SUSPECT;BC=0.6030169|-1;BR=01201311R211b1;CH=blue;DM=|SUSPECT|false|;DS=CONTINUE|ham_alarm|0.122626-0.119945-0.757429;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5qaegt_1690881734;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5qaegt_1690881734)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 17:22:17 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu/powerplay: Clean up errors in smu_helper.h
Date:   Tue,  1 Aug 2023 09:22:13 +0000
Message-Id: <20230801092213.7360-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: space prohibited before that close parenthesis ')'

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h
index 2a75da1e9f03..83b3c9315143 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h
@@ -194,7 +194,7 @@ int smu_set_watermarks_for_clocks_ranges(void *wt_table,
 #define PHM_WAIT_INDIRECT_FIELD_UNEQUAL(hwmgr, port, reg, field, fieldval)                          \
 		PHM_WAIT_INDIRECT_REGISTER_UNEQUAL(hwmgr, port, reg, \
 				(fieldval) << PHM_FIELD_SHIFT(reg, field), \
-					PHM_FIELD_MASK(reg, field) )
+					PHM_FIELD_MASK(reg, field))
 
 
 #define PHM_WAIT_VFPF_INDIRECT_REGISTER_UNEQUAL_GIVEN_INDEX(hwmgr,	\
-- 
2.17.1

