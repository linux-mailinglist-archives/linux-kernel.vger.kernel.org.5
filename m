Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F7176A713
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjHACj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 22:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjHACjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:39:25 -0400
Received: from out28-97.mail.aliyun.com (out28-97.mail.aliyun.com [115.124.28.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9741723
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 19:39:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2376815|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0270291-0.000544939-0.972426;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5H.BoE_1690857556;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5H.BoE_1690857556)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 10:39:18 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in vega20_hwmgr.h
Date:   Tue,  1 Aug 2023 02:39:15 +0000
Message-Id: <20230801023915.4756-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following enum go on the same line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.h
index 075c0094da9c..1ba9b5fe2a5d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.h
@@ -385,8 +385,7 @@ struct vega20_odn_data {
 	struct vega20_odn_temp_table	odn_temp_table;
 };
 
-enum OD8_FEATURE_ID
-{
+enum OD8_FEATURE_ID {
 	OD8_GFXCLK_LIMITS               = 1 << 0,
 	OD8_GFXCLK_CURVE                = 1 << 1,
 	OD8_UCLK_MAX                    = 1 << 2,
@@ -399,8 +398,7 @@ enum OD8_FEATURE_ID
 	OD8_FAN_ZERO_RPM_CONTROL        = 1 << 9
 };
 
-enum OD8_SETTING_ID
-{
+enum OD8_SETTING_ID {
 	OD8_SETTING_GFXCLK_FMIN = 0,
 	OD8_SETTING_GFXCLK_FMAX,
 	OD8_SETTING_GFXCLK_FREQ1,
-- 
2.17.1

