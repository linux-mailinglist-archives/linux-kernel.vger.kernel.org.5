Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5C976A8A2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjHAGE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjHAGEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:04:54 -0400
Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16812187
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:04:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07723793|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0904852-0.0047855-0.904729;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5eilLU_1690869884;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5eilLU_1690869884)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 14:04:46 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in vega12_pptable.h
Date:   Tue,  1 Aug 2023 06:04:43 +0000
Message-Id: <20230801060443.6090-1-sunran001@208suo.com>
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
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega12_pptable.h   | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_pptable.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_pptable.h
index bf4f5095b80d..9b8435a4d306 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_pptable.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_pptable.h
@@ -72,8 +72,7 @@ enum ATOM_VEGA12_PPCLOCK_ID {
 typedef enum ATOM_VEGA12_PPCLOCK_ID ATOM_VEGA12_PPCLOCK_ID;
 
 
-typedef struct _ATOM_VEGA12_POWERPLAYTABLE
-{
+typedef struct _ATOM_VEGA12_POWERPLAYTABLE {
       struct atom_common_table_header sHeader;
       UCHAR  ucTableRevision;
       USHORT usTableSize;
@@ -92,11 +91,11 @@ typedef struct _ATOM_VEGA12_POWERPLAYTABLE
       USHORT usODPowerSavePowerLimit;
       USHORT usSoftwareShutdownTemp;
 
-      ULONG PowerSavingClockMax  [ATOM_VEGA12_PPCLOCK_COUNT];
-      ULONG PowerSavingClockMin  [ATOM_VEGA12_PPCLOCK_COUNT];
+      ULONG PowerSavingClockMax[ATOM_VEGA12_PPCLOCK_COUNT];
+      ULONG PowerSavingClockMin[ATOM_VEGA12_PPCLOCK_COUNT];
 
-      ULONG ODSettingsMax [ATOM_VEGA12_ODSETTING_COUNT];
-      ULONG ODSettingsMin [ATOM_VEGA12_ODSETTING_COUNT];
+      ULONG ODSettingsMax[ATOM_VEGA12_ODSETTING_COUNT];
+      ULONG ODSettingsMin[ATOM_VEGA12_ODSETTING_COUNT];
 
       USHORT usReserve[5];
 
-- 
2.17.1

