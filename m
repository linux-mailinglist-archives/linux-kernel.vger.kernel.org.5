Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B486376AA55
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjHAHzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHAHzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:55:20 -0400
Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com [115.124.28.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC3C1BE9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 00:55:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3847548|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00255057-0.000655741-0.996794;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5l-U8X_1690876509;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5l-U8X_1690876509)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 15:55:11 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in common_baco.c
Date:   Tue,  1 Aug 2023 07:55:07 +0000
Message-Id: <20230801075507.6377-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: code indent should use tabs where possible

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/common_baco.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/common_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/common_baco.c
index 1c73776bd606..fd79337a3536 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/common_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/common_baco.c
@@ -42,7 +42,7 @@ static bool baco_wait_register(struct pp_hwmgr *hwmgr, u32 reg, u32 mask, u32 va
 }
 
 static bool baco_cmd_handler(struct pp_hwmgr *hwmgr, u32 command, u32 reg, u32 mask,
-			        u32 shift, u32 value, u32 timeout)
+				u32 shift, u32 value, u32 timeout)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
 	u32 data;
-- 
2.17.1

