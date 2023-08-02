Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C41776C752
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjHBHqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjHBHpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:45:39 -0400
Received: from out28-105.mail.aliyun.com (out28-105.mail.aliyun.com [115.124.28.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1D53595
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:43:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1447226|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_system_inform|0.180895-0.00661834-0.812487;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6d8ofZ_1690962195;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6d8ofZ_1690962195)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 15:43:17 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in vcn_v4_0.c
Date:   Wed,  2 Aug 2023 07:43:15 +0000
Message-Id: <20230802074315.13688-1-sunran001@208suo.com>
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

spaces required around that '==' (ctx:VxV)
ERROR: space required before the open parenthesis '('
ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 6089c7deba8a..ef5b16061e96 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1139,11 +1139,11 @@ static int vcn_v4_0_start(struct amdgpu_device *adev)
 				if (status & 2)
 					break;
 				mdelay(10);
-				if (amdgpu_emu_mode==1)
+				if (amdgpu_emu_mode == 1)
 					msleep(1);
 			}
 
-			if (amdgpu_emu_mode==1) {
+			if (amdgpu_emu_mode == 1) {
 				r = -1;
 				if (status & 2) {
 					r = 0;
@@ -1959,7 +1959,7 @@ static int vcn_v4_0_set_powergating_state(void *handle, enum amd_powergating_sta
 		return 0;
 	}
 
-	if(state == adev->vcn.cur_state)
+	if (state == adev->vcn.cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1967,7 +1967,7 @@ static int vcn_v4_0_set_powergating_state(void *handle, enum amd_powergating_sta
 	else
 		ret = vcn_v4_0_start(adev);
 
-	if(!ret)
+	if (!ret)
 		adev->vcn.cur_state = state;
 
 	return ret;
@@ -2101,8 +2101,7 @@ static const struct amd_ip_funcs vcn_v4_0_ip_funcs = {
 	.set_powergating_state = vcn_v4_0_set_powergating_state,
 };
 
-const struct amdgpu_ip_block_version vcn_v4_0_ip_block =
-{
+const struct amdgpu_ip_block_version vcn_v4_0_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_VCN,
 	.major = 4,
 	.minor = 0,
-- 
2.17.1

