Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06E476C277
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjHBBsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjHBBsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:48:10 -0400
Received: from out28-102.mail.aliyun.com (out28-102.mail.aliyun.com [115.124.28.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C1FF1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:48:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2541763|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_alarm|0.0473417-0.000161502-0.952497;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6Jxphb_1690940881;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6Jxphb_1690940881)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 09:48:03 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in hwmgr.h
Date:   Wed,  2 Aug 2023 01:48:00 +0000
Message-Id: <20230802014800.8945-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line
ERROR: Use C99 flexible arrays

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 612d66aeaab9..81650727a5de 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -190,8 +190,7 @@ struct phm_vce_clock_voltage_dependency_table {
 };
 
 
-enum SMU_ASIC_RESET_MODE
-{
+enum SMU_ASIC_RESET_MODE {
     SMU_ASIC_RESET_MODE_0,
     SMU_ASIC_RESET_MODE_1,
     SMU_ASIC_RESET_MODE_2,
@@ -516,7 +515,7 @@ struct phm_vq_budgeting_record {
 
 struct phm_vq_budgeting_table {
 	uint8_t numEntries;
-	struct phm_vq_budgeting_record entries[1];
+	struct phm_vq_budgeting_record entries[0];
 };
 
 struct phm_clock_and_voltage_limits {
@@ -607,8 +606,7 @@ struct phm_ppt_v2_information {
 	uint8_t  uc_dcef_dpm_voltage_mode;
 };
 
-struct phm_ppt_v3_information
-{
+struct phm_ppt_v3_information {
 	uint8_t uc_thermal_controller_type;
 
 	uint16_t us_small_power_limit1;
-- 
2.17.1

