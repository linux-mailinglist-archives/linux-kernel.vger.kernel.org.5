Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D383D76C79D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjHBH4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjHBHzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:55:48 -0400
Received: from out28-107.mail.aliyun.com (out28-107.mail.aliyun.com [115.124.28.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D778E213F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:53:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09949107|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_system_inform|0.051677-0.00259581-0.945727;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6d9036_1690962790;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6d9036_1690962790)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 15:53:12 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in vcn_v3_0.c
Date:   Wed,  2 Aug 2023 07:53:09 +0000
Message-Id: <20230802075309.13950-1-sunran001@208suo.com>
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

ERROR: space required before the open brace '{'
ERROR: "foo * bar" should be "foo *bar"
ERROR: space required before the open parenthesis '('
ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index b76ba21b5a89..1e7613bb80ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1105,7 +1105,7 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG){
+		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
 			r = vcn_v3_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
 			continue;
 		}
@@ -1789,7 +1789,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	struct amdgpu_bo *bo;
 	uint64_t start, end;
 	unsigned int i;
-	void * ptr;
+	void *ptr;
 	int r;
 
 	addr &= AMDGPU_GMC_HOLE_MASK;
@@ -2129,7 +2129,7 @@ static int vcn_v3_0_set_powergating_state(void *handle,
 		return 0;
 	}
 
-	if(state == adev->vcn.cur_state)
+	if (state == adev->vcn.cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -2137,7 +2137,7 @@ static int vcn_v3_0_set_powergating_state(void *handle,
 	else
 		ret = vcn_v3_0_start(adev);
 
-	if(!ret)
+	if (!ret)
 		adev->vcn.cur_state = state;
 
 	return ret;
@@ -2228,8 +2228,7 @@ static const struct amd_ip_funcs vcn_v3_0_ip_funcs = {
 	.set_powergating_state = vcn_v3_0_set_powergating_state,
 };
 
-const struct amdgpu_ip_block_version vcn_v3_0_ip_block =
-{
+const struct amdgpu_ip_block_version vcn_v3_0_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_VCN,
 	.major = 3,
 	.minor = 0,
-- 
2.17.1

