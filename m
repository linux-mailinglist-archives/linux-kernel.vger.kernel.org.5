Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315D276C55D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjHBGh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjHBGhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:37:53 -0400
Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFCB1FF3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:37:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.5040528|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.103306-0.00202804-0.894666;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6YtKML_1690958263;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6YtKML_1690958263)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 14:37:45 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in vce_v3_0.c
Date:   Wed,  2 Aug 2023 06:37:42 +0000
Message-Id: <20230802063742.11697-1-sunran001@208suo.com>
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

ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 8def62c83ffd..18f6e62af339 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -998,8 +998,7 @@ static void vce_v3_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->vce.irq.funcs = &vce_v3_0_irq_funcs;
 };
 
-const struct amdgpu_ip_block_version vce_v3_0_ip_block =
-{
+const struct amdgpu_ip_block_version vce_v3_0_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_VCE,
 	.major = 3,
 	.minor = 0,
@@ -1007,8 +1006,7 @@ const struct amdgpu_ip_block_version vce_v3_0_ip_block =
 	.funcs = &vce_v3_0_ip_funcs,
 };
 
-const struct amdgpu_ip_block_version vce_v3_1_ip_block =
-{
+const struct amdgpu_ip_block_version vce_v3_1_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_VCE,
 	.major = 3,
 	.minor = 1,
@@ -1016,8 +1014,7 @@ const struct amdgpu_ip_block_version vce_v3_1_ip_block =
 	.funcs = &vce_v3_0_ip_funcs,
 };
 
-const struct amdgpu_ip_block_version vce_v3_4_ip_block =
-{
+const struct amdgpu_ip_block_version vce_v3_4_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_VCE,
 	.major = 3,
 	.minor = 4,
-- 
2.17.1

