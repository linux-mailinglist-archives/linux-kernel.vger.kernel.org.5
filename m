Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2F776C5F9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjHBG6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbjHBG6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:58:14 -0400
Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0878211A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:58:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3522126|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0108132-0.00065214-0.988535;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6a9kda_1690959486;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6a9kda_1690959486)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 14:58:08 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in uvd_v7_0.c
Date:   Wed,  2 Aug 2023 06:58:04 +0000
Message-Id: <20230802065804.12360-1-sunran001@208suo.com>
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

ERROR: spaces required around that ':' (ctx:VxE)
that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index abaa4463e906..86d1d46e1e5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -679,11 +679,11 @@ static void uvd_v7_0_mc_resume(struct amdgpu_device *adev)
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 			WREG32_SOC15(UVD, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
 				i == 0 ?
-				adev->firmware.ucode[AMDGPU_UCODE_ID_UVD].tmr_mc_addr_lo:
+				adev->firmware.ucode[AMDGPU_UCODE_ID_UVD].tmr_mc_addr_lo :
 				adev->firmware.ucode[AMDGPU_UCODE_ID_UVD1].tmr_mc_addr_lo);
 			WREG32_SOC15(UVD, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
 				i == 0 ?
-				adev->firmware.ucode[AMDGPU_UCODE_ID_UVD].tmr_mc_addr_hi:
+				adev->firmware.ucode[AMDGPU_UCODE_ID_UVD].tmr_mc_addr_hi :
 				adev->firmware.ucode[AMDGPU_UCODE_ID_UVD1].tmr_mc_addr_hi);
 			WREG32_SOC15(UVD, i, mmUVD_VCPU_CACHE_OFFSET0, 0);
 			offset = 0;
@@ -1908,8 +1908,7 @@ static void uvd_v7_0_set_irq_funcs(struct amdgpu_device *adev)
 	}
 }
 
-const struct amdgpu_ip_block_version uvd_v7_0_ip_block =
-{
+const struct amdgpu_ip_block_version uvd_v7_0_ip_block = {
 		.type = AMD_IP_BLOCK_TYPE_UVD,
 		.major = 7,
 		.minor = 0,
-- 
2.17.1

