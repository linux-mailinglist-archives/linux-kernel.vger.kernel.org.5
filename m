Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F1276C592
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjHBGtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjHBGtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:49:04 -0400
Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27759359E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:48:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3444751|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00639894-4.13957e-05-0.99356;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6YuGG9_1690958904;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6YuGG9_1690958904)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 14:48:25 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in mmhub_v9_4.c
Date:   Wed,  2 Aug 2023 06:48:22 +0000
Message-Id: <20230802064822.12093-1-sunran001@208suo.com>
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

ERROR: code indent should use tabs where possible
ERROR: space required before the open parenthesis '('

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index e790f890aec6..5718e4d40e66 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -108,7 +108,7 @@ static void mmhub_v9_4_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmi
 }
 
 static void mmhub_v9_4_init_system_aperture_regs(struct amdgpu_device *adev,
-					         int hubid)
+						int hubid)
 {
 	uint64_t value;
 	uint32_t tmp;
@@ -1568,7 +1568,7 @@ static int mmhub_v9_4_get_ras_error_count(struct amdgpu_device *adev,
 	uint32_t sec_cnt, ded_cnt;
 
 	for (i = 0; i < ARRAY_SIZE(mmhub_v9_4_ras_fields); i++) {
-		if(mmhub_v9_4_ras_fields[i].reg_offset != reg->reg_offset)
+		if (mmhub_v9_4_ras_fields[i].reg_offset != reg->reg_offset)
 			continue;
 
 		sec_cnt = (value &
-- 
2.17.1

