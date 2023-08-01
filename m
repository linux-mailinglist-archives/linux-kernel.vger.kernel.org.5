Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D6876AB38
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjHAIkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjHAIkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:40:37 -0400
Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5433E1702
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:40:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.167007-0.0010792-0.831913;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5oPFEH_1690879225;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5oPFEH_1690879225)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 16:40:28 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in vega10_pptable.h
Date:   Tue,  1 Aug 2023 08:40:24 +0000
Message-Id: <20230801084024.6826-1-sunran001@208suo.com>
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

ERROR: open brace '{' following struct go on the same line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 .../amd/pm/powerplay/hwmgr/vega10_pptable.h    | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
index 9c479bd9a786..8b0590b834cc 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
@@ -317,16 +317,14 @@ typedef struct _ATOM_Vega10_Thermal_Controller {
     UCHAR ucFlags;          /* to be defined */
 } ATOM_Vega10_Thermal_Controller;
 
-typedef struct _ATOM_Vega10_VCE_State_Record
-{
+typedef struct _ATOM_Vega10_VCE_State_Record {
     UCHAR  ucVCEClockIndex;         /*index into usVCEDependencyTableOffset of 'ATOM_Vega10_MM_Dependency_Table' type */
     UCHAR  ucFlag;                  /* 2 bits indicates memory p-states */
     UCHAR  ucSCLKIndex;             /* index into ATOM_Vega10_SCLK_Dependency_Table */
     UCHAR  ucMCLKIndex;             /* index into ATOM_Vega10_MCLK_Dependency_Table */
 } ATOM_Vega10_VCE_State_Record;
 
-typedef struct _ATOM_Vega10_VCE_State_Table
-{
+typedef struct _ATOM_Vega10_VCE_State_Table {
     UCHAR ucRevId;
     UCHAR ucNumEntries;
     ATOM_Vega10_VCE_State_Record entries[1];
@@ -361,8 +359,7 @@ typedef struct _ATOM_Vega10_PowerTune_Table {
 	USHORT usTemperatureLimitTedge;
 } ATOM_Vega10_PowerTune_Table;
 
-typedef struct _ATOM_Vega10_PowerTune_Table_V2
-{
+typedef struct _ATOM_Vega10_PowerTune_Table_V2 {
 	UCHAR  ucRevId;
 	USHORT usSocketPowerLimit;
 	USHORT usBatteryPowerLimit;
@@ -388,8 +385,7 @@ typedef struct _ATOM_Vega10_PowerTune_Table_V2
 	USHORT usTemperatureLimitTedge;
 } ATOM_Vega10_PowerTune_Table_V2;
 
-typedef struct _ATOM_Vega10_PowerTune_Table_V3
-{
+typedef struct _ATOM_Vega10_PowerTune_Table_V3 {
 	UCHAR  ucRevId;
 	USHORT usSocketPowerLimit;
 	USHORT usBatteryPowerLimit;
@@ -428,15 +424,13 @@ typedef struct _ATOM_Vega10_Hard_Limit_Record {
     USHORT usVddMemLimit;
 } ATOM_Vega10_Hard_Limit_Record;
 
-typedef struct _ATOM_Vega10_Hard_Limit_Table
-{
+typedef struct _ATOM_Vega10_Hard_Limit_Table {
     UCHAR ucRevId;
     UCHAR ucNumEntries;
     ATOM_Vega10_Hard_Limit_Record entries[1];
 } ATOM_Vega10_Hard_Limit_Table;
 
-typedef struct _Vega10_PPTable_Generic_SubTable_Header
-{
+typedef struct _Vega10_PPTable_Generic_SubTable_Header {
     UCHAR  ucRevId;
 } Vega10_PPTable_Generic_SubTable_Header;
 
-- 
2.17.1

