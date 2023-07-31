Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B127691A4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjGaJZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjGaJYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:24:40 -0400
Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com [115.124.28.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442E410F9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:22:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07502602|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.461785-0.00373639-0.534478;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U4lAjtS_1690795270;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U4lAjtS_1690795270)
          by smtp.aliyun-inc.com;
          Mon, 31 Jul 2023 17:22:36 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in smu_v11_0_pptable.h
Date:   Mon, 31 Jul 2023 09:21:08 +0000
Message-Id: <20230731092108.3162-1-sunran001@208suo.com>
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

ERROR: trailing whitespace
ERROR: open brace '{' following struct go on the same line
ERROR: code indent should use tabs where possible

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 .../gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h  | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h
index 0116e3d04fad..df7430876e0c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h
@@ -101,8 +101,7 @@ enum SMU_11_0_ODSETTING_ID {
 };
 #define SMU_11_0_MAX_ODSETTING    32          //Maximum Number of ODSettings
 
-struct smu_11_0_overdrive_table
-{
+struct smu_11_0_overdrive_table {
     uint8_t  revision;                                        //Revision = SMU_11_0_PP_OVERDRIVE_VERSION
     uint8_t  reserve[3];                                      //Zero filled field reserved for future use
     uint32_t feature_count;                                   //Total number of supported features
@@ -127,8 +126,7 @@ enum SMU_11_0_PPCLOCK_ID {
 };
 #define SMU_11_0_MAX_PPCLOCK      16          //Maximum Number of PP Clocks
 
-struct smu_11_0_power_saving_clock_table
-{
+struct smu_11_0_power_saving_clock_table {
     uint8_t  revision;                                        //Revision = SMU_11_0_PP_POWERSAVINGCLOCK_VERSION
     uint8_t  reserve[3];                                      //Zero filled field reserved for future use
     uint32_t count;                                           //power_saving_clock_count = SMU_11_0_PPCLOCK_COUNT
@@ -136,8 +134,7 @@ struct smu_11_0_power_saving_clock_table
     uint32_t min[SMU_11_0_MAX_PPCLOCK];                       //PowerSavingClock Mode Clock Minimum array In MHz
 };
 
-struct smu_11_0_powerplay_table
-{
+struct smu_11_0_powerplay_table {
       struct atom_common_table_header header;
       uint8_t  table_revision;
       uint16_t table_size;                          //Driver portion table size. The offset to smc_pptable including header size
@@ -145,14 +142,14 @@ struct smu_11_0_powerplay_table
       uint32_t golden_revision;
       uint16_t format_id;
       uint32_t platform_caps;                       //POWERPLAYABLE::ulPlatformCaps
-                                                    
+
       uint8_t  thermal_controller_type;             //one of SMU_11_0_PP_THERMALCONTROLLER
 
       uint16_t small_power_limit1;
       uint16_t small_power_limit2;
       uint16_t boost_power_limit;
-      uint16_t od_turbo_power_limit;                //Power limit setting for Turbo mode in Performance UI Tuning. 
-      uint16_t od_power_save_power_limit;           //Power limit setting for PowerSave/Optimal mode in Performance UI Tuning. 
+      uint16_t od_turbo_power_limit;                //Power limit setting for Turbo mode in Performance UI Tuning.
+      uint16_t od_power_save_power_limit;           //Power limit setting for PowerSave/Optimal mode in Performance UI Tuning.
       uint16_t software_shutdown_temp;
 
       uint16_t reserve[6];                          //Zero filled field reserved for future use
-- 
2.17.1

