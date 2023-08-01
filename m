Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A5F76AA79
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjHAIDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjHAIC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:02:59 -0400
Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com [115.124.28.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4AAC6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:02:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3852659|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00401577-0.000669347-0.995315;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5lXUi6_1690876967;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5lXUi6_1690876967)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 16:02:49 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in vega20_baco.c
Date:   Tue,  1 Aug 2023 08:02:46 +0000
Message-Id: <20230801080246.6556-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line
ERROR: space required before the open parenthesis '('

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
index 8d99c7a5abf8..994c0d374bfa 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
@@ -31,8 +31,7 @@
 
 #include "amdgpu_ras.h"
 
-static const struct soc15_baco_cmd_entry clean_baco_tbl[] =
-{
+static const struct soc15_baco_cmd_entry clean_baco_tbl[] = {
 	{CMD_WRITE, SOC15_REG_ENTRY(NBIF, 0, mmBIOS_SCRATCH_6), 0, 0, 0, 0},
 	{CMD_WRITE, SOC15_REG_ENTRY(NBIF, 0, mmBIOS_SCRATCH_7), 0, 0, 0, 0},
 };
@@ -90,11 +89,11 @@ int vega20_baco_set_state(struct pp_hwmgr *hwmgr, enum BACO_STATE state)
 			data |= 0x80000000;
 			WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL, data);
 
-			if(smum_send_msg_to_smc_with_parameter(hwmgr,
+			if (smum_send_msg_to_smc_with_parameter(hwmgr,
 					PPSMC_MSG_EnterBaco, 0, NULL))
 				return -EINVAL;
 		} else {
-			if(smum_send_msg_to_smc_with_parameter(hwmgr,
+			if (smum_send_msg_to_smc_with_parameter(hwmgr,
 					PPSMC_MSG_EnterBaco, 1, NULL))
 				return -EINVAL;
 		}
-- 
2.17.1

