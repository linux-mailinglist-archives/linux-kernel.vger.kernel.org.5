Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC12376C290
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjHBB7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjHBB7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:59:51 -0400
Received: from out28-128.mail.aliyun.com (out28-128.mail.aliyun.com [115.124.28.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BBB137
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:59:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1085532|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_system_inform|0.0392941-0.000118786-0.960587;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6KNjwR_1690941582;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6KNjwR_1690941582)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 09:59:44 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in smu75.h
Date:   Wed,  2 Aug 2023 01:59:41 +0000
Message-Id: <20230802015941.9124-1-sunran001@208suo.com>
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

ERROR: space prohibited before open square bracket '['
ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h
index 771523001533..7d5ed7751976 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h
@@ -224,8 +224,8 @@ struct SMU7_LocalDpmScoreboard {
 	uint8_t  DteClampMode;
 	uint8_t  FpsClampMode;
 
-	uint16_t LevelResidencyCounters [SMU75_MAX_LEVELS_GRAPHICS];
-	uint16_t LevelSwitchCounters [SMU75_MAX_LEVELS_GRAPHICS];
+	uint16_t LevelResidencyCounters[SMU75_MAX_LEVELS_GRAPHICS];
+	uint16_t LevelSwitchCounters[SMU75_MAX_LEVELS_GRAPHICS];
 
 	void     (*TargetStateCalculator)(uint8_t);
 	void     (*SavedTargetStateCalculator)(uint8_t);
@@ -316,7 +316,7 @@ struct SMU7_VoltageScoreboard {
 
 	VoltageChangeHandler_t functionLinks[6];
 
-	uint16_t * VddcFollower1;
+	uint16_t *VddcFollower1;
 	int16_t  Driver_OD_RequestedVidOffset1;
 	int16_t  Driver_OD_RequestedVidOffset2;
 };
@@ -677,9 +677,9 @@ typedef struct SCS_CELL_t SCS_CELL_t;
 
 struct VFT_TABLE_t {
 	VFT_CELL_t    Cell[TEMP_RANGE_MAXSTEPS][NUM_VFT_COLUMNS];
-	uint16_t      AvfsGbv [NUM_VFT_COLUMNS];
-	uint16_t      BtcGbv  [NUM_VFT_COLUMNS];
-	int16_t       Temperature [TEMP_RANGE_MAXSTEPS];
+	uint16_t      AvfsGbv[NUM_VFT_COLUMNS];
+	uint16_t      BtcGbv[NUM_VFT_COLUMNS];
+	int16_t       Temperature[TEMP_RANGE_MAXSTEPS];
 
 #ifdef SMU__FIRMWARE_SCKS_PRESENT__1
 	SCS_CELL_t    ScksCell[TEMP_RANGE_MAXSTEPS][NUM_VFT_COLUMNS];
-- 
2.17.1

