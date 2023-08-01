Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C96576AE8F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbjHAJj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbjHAJjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:39:33 -0400
Received: from out28-2.mail.aliyun.com (out28-2.mail.aliyun.com [115.124.28.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F0D46B7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:37:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4581243|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00723545-0.000549839-0.992215;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5rVQNr_1690882617;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5rVQNr_1690882617)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 17:36:59 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm/powerplay/hwmgr/hwmgr: Clean up errors in hwmgr.c
Date:   Tue,  1 Aug 2023 09:36:56 +0000
Message-Id: <20230801093656.7761-1-sunran001@208suo.com>
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

ERROR: space prohibited after that '~' (ctx:WxW)
ERROR: spaces required around that '||' (ctx:VxW)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
index f2cef0930aa9..2b5ac21fee39 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
@@ -120,7 +120,7 @@ int hwmgr_early_init(struct pp_hwmgr *hwmgr)
 		case CHIP_TOPAZ:
 			hwmgr->smumgr_funcs = &iceland_smu_funcs;
 			topaz_set_asic_special_caps(hwmgr);
-			hwmgr->feature_mask &= ~ (PP_VBI_TIME_SUPPORT_MASK |
+			hwmgr->feature_mask &= ~(PP_VBI_TIME_SUPPORT_MASK |
 						PP_ENABLE_GFX_CG_THRU_SMU);
 			hwmgr->pp_table_version = PP_TABLE_V0;
 			hwmgr->od_enabled = false;
@@ -133,7 +133,7 @@ int hwmgr_early_init(struct pp_hwmgr *hwmgr)
 		case CHIP_FIJI:
 			hwmgr->smumgr_funcs = &fiji_smu_funcs;
 			fiji_set_asic_special_caps(hwmgr);
-			hwmgr->feature_mask &= ~ (PP_VBI_TIME_SUPPORT_MASK |
+			hwmgr->feature_mask &= ~(PP_VBI_TIME_SUPPORT_MASK |
 						PP_ENABLE_GFX_CG_THRU_SMU);
 			break;
 		case CHIP_POLARIS11:
@@ -195,7 +195,7 @@ int hwmgr_early_init(struct pp_hwmgr *hwmgr)
 
 int hwmgr_sw_init(struct pp_hwmgr *hwmgr)
 {
-	if (!hwmgr|| !hwmgr->smumgr_funcs || !hwmgr->smumgr_funcs->smu_init)
+	if (!hwmgr || !hwmgr->smumgr_funcs || !hwmgr->smumgr_funcs->smu_init)
 		return -EINVAL;
 
 	phm_register_irq_handlers(hwmgr);
-- 
2.17.1

