Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8278776AF4B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbjHAJqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjHAJqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:46:24 -0400
Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7217B3ABA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:44:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0743643|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0623864-0.000420737-0.937193;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5rttun_1690883085;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5rttun_1690883085)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 17:44:47 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in vega20_pptable.h
Date:   Tue,  1 Aug 2023 09:44:43 +0000
Message-Id: <20230801094443.7942-1-sunran001@208suo.com>
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

ERROR: open brace '{' following struct go on the same line
ERROR: space prohibited before open square bracket '['

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 .../amd/pm/powerplay/hwmgr/vega20_pptable.h   | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_pptable.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_pptable.h
index 2222e29405c6..b468dddbefff 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_pptable.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_pptable.h
@@ -73,14 +73,13 @@ enum ATOM_VEGA20_ODSETTING_ID {
 };
 typedef enum ATOM_VEGA20_ODSETTING_ID ATOM_VEGA20_ODSETTING_ID;
 
-typedef struct _ATOM_VEGA20_OVERDRIVE8_RECORD
-{
+typedef struct _ATOM_VEGA20_OVERDRIVE8_RECORD {
   UCHAR ucODTableRevision;
   ULONG ODFeatureCount;
-  UCHAR ODFeatureCapabilities [ATOM_VEGA20_ODFEATURE_MAX_COUNT];   //OD feature support flags
+  UCHAR ODFeatureCapabilities[ATOM_VEGA20_ODFEATURE_MAX_COUNT];   //OD feature support flags
   ULONG ODSettingCount;
-  ULONG ODSettingsMax [ATOM_VEGA20_ODSETTING_MAX_COUNT];           //Upper Limit for each OD Setting
-  ULONG ODSettingsMin [ATOM_VEGA20_ODSETTING_MAX_COUNT];           //Lower Limit for each OD Setting
+  ULONG ODSettingsMax[ATOM_VEGA20_ODSETTING_MAX_COUNT];           //Upper Limit for each OD Setting
+  ULONG ODSettingsMin[ATOM_VEGA20_ODSETTING_MAX_COUNT];           //Lower Limit for each OD Setting
 } ATOM_VEGA20_OVERDRIVE8_RECORD;
 
 enum ATOM_VEGA20_PPCLOCK_ID {
@@ -99,16 +98,14 @@ enum ATOM_VEGA20_PPCLOCK_ID {
 };
 typedef enum ATOM_VEGA20_PPCLOCK_ID ATOM_VEGA20_PPCLOCK_ID;
 
-typedef struct _ATOM_VEGA20_POWER_SAVING_CLOCK_RECORD
-{
+typedef struct _ATOM_VEGA20_POWER_SAVING_CLOCK_RECORD {
   UCHAR ucTableRevision;
   ULONG PowerSavingClockCount;                                 // Count of PowerSavingClock Mode
-  ULONG PowerSavingClockMax  [ATOM_VEGA20_PPCLOCK_MAX_COUNT];      // PowerSavingClock Mode Clock Maximum array In MHz
-  ULONG PowerSavingClockMin  [ATOM_VEGA20_PPCLOCK_MAX_COUNT];      // PowerSavingClock Mode Clock Minimum array In MHz
+  ULONG PowerSavingClockMax[ATOM_VEGA20_PPCLOCK_MAX_COUNT];      // PowerSavingClock Mode Clock Maximum array In MHz
+  ULONG PowerSavingClockMin[ATOM_VEGA20_PPCLOCK_MAX_COUNT];      // PowerSavingClock Mode Clock Minimum array In MHz
 } ATOM_VEGA20_POWER_SAVING_CLOCK_RECORD;
 
-typedef struct _ATOM_VEGA20_POWERPLAYTABLE
-{
+typedef struct _ATOM_VEGA20_POWERPLAYTABLE {
       struct atom_common_table_header sHeader;
       UCHAR  ucTableRevision;
       USHORT usTableSize;
-- 
2.17.1

