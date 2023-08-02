Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A796076C622
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjHBHMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjHBHMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:12:12 -0400
Received: from out28-5.mail.aliyun.com (out28-5.mail.aliyun.com [115.124.28.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D111705
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:12:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1645156|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0352353-0.000645299-0.964119;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6anUDl_1690960322;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6anUDl_1690960322)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 15:12:04 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu/jpeg: Clean up errors in vcn_v1_0.c
Date:   Wed,  2 Aug 2023 07:12:01 +0000
Message-Id: <20230802071201.12717-1-sunran001@208suo.com>
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

ERROR: space required before the open parenthesis '('
ERROR: space prohibited after that '~' (ctx:WxW)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 16feb491adf5..25ba27151ac0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -473,7 +473,7 @@ static void vcn_v1_0_disable_clock_gating(struct amdgpu_device *adev)
 	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
 		data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
 	else
-		data &= ~ UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
+		data &= ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
 
 	data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
 	data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
@@ -1772,7 +1772,7 @@ static int vcn_v1_0_set_powergating_state(void *handle,
 	int ret;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if(state == adev->vcn.cur_state)
+	if (state == adev->vcn.cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1780,7 +1780,7 @@ static int vcn_v1_0_set_powergating_state(void *handle,
 	else
 		ret = vcn_v1_0_start(adev);
 
-	if(!ret)
+	if (!ret)
 		adev->vcn.cur_state = state;
 	return ret;
 }
@@ -2065,8 +2065,7 @@ static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->vcn.inst->irq.funcs = &vcn_v1_0_irq_funcs;
 }
 
-const struct amdgpu_ip_block_version vcn_v1_0_ip_block =
-{
+const struct amdgpu_ip_block_version vcn_v1_0_ip_block = {
 		.type = AMD_IP_BLOCK_TYPE_VCN,
 		.major = 1,
 		.minor = 0,
-- 
2.17.1

