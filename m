Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06DC76C5E4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjHBGzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjHBGzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:55:36 -0400
Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBA32D59
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:55:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4842786|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.00285167-8.57873e-06-0.99714;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6ZgWu6_1690959319;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6ZgWu6_1690959319)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 14:55:21 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd: Clean up errors in amdgpu_cgs.c
Date:   Wed,  2 Aug 2023 06:55:18 +0000
Message-Id: <20230802065518.12271-1-sunran001@208suo.com>
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

ERROR: switch and case should be at the same indent

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c | 64 ++++++++++++-------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index 456e385333b6..fafe7057a8c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -163,38 +163,38 @@ static uint16_t amdgpu_get_firmware_version(struct cgs_device *cgs_device,
 	uint16_t fw_version = 0;
 
 	switch (type) {
-		case CGS_UCODE_ID_SDMA0:
-			fw_version = adev->sdma.instance[0].fw_version;
-			break;
-		case CGS_UCODE_ID_SDMA1:
-			fw_version = adev->sdma.instance[1].fw_version;
-			break;
-		case CGS_UCODE_ID_CP_CE:
-			fw_version = adev->gfx.ce_fw_version;
-			break;
-		case CGS_UCODE_ID_CP_PFP:
-			fw_version = adev->gfx.pfp_fw_version;
-			break;
-		case CGS_UCODE_ID_CP_ME:
-			fw_version = adev->gfx.me_fw_version;
-			break;
-		case CGS_UCODE_ID_CP_MEC:
-			fw_version = adev->gfx.mec_fw_version;
-			break;
-		case CGS_UCODE_ID_CP_MEC_JT1:
-			fw_version = adev->gfx.mec_fw_version;
-			break;
-		case CGS_UCODE_ID_CP_MEC_JT2:
-			fw_version = adev->gfx.mec_fw_version;
-			break;
-		case CGS_UCODE_ID_RLC_G:
-			fw_version = adev->gfx.rlc_fw_version;
-			break;
-		case CGS_UCODE_ID_STORAGE:
-			break;
-		default:
-			DRM_ERROR("firmware type %d do not have version\n", type);
-			break;
+	case CGS_UCODE_ID_SDMA0:
+		fw_version = adev->sdma.instance[0].fw_version;
+		break;
+	case CGS_UCODE_ID_SDMA1:
+		fw_version = adev->sdma.instance[1].fw_version;
+		break;
+	case CGS_UCODE_ID_CP_CE:
+		fw_version = adev->gfx.ce_fw_version;
+		break;
+	case CGS_UCODE_ID_CP_PFP:
+		fw_version = adev->gfx.pfp_fw_version;
+		break;
+	case CGS_UCODE_ID_CP_ME:
+		fw_version = adev->gfx.me_fw_version;
+		break;
+	case CGS_UCODE_ID_CP_MEC:
+		fw_version = adev->gfx.mec_fw_version;
+		break;
+	case CGS_UCODE_ID_CP_MEC_JT1:
+		fw_version = adev->gfx.mec_fw_version;
+		break;
+	case CGS_UCODE_ID_CP_MEC_JT2:
+		fw_version = adev->gfx.mec_fw_version;
+		break;
+	case CGS_UCODE_ID_RLC_G:
+		fw_version = adev->gfx.rlc_fw_version;
+		break;
+	case CGS_UCODE_ID_STORAGE:
+		break;
+	default:
+		DRM_ERROR("firmware type %d do not have version\n", type);
+		break;
 	}
 	return fw_version;
 }
-- 
2.17.1

