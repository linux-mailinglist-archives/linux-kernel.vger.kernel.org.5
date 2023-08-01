Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D1F76A88C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 07:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjHAF6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 01:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjHAF6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 01:58:38 -0400
Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8349A10C7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 22:58:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1285285|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0182949-0.000150213-0.981555;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5e9L-1_1690869507;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5e9L-1_1690869507)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 13:58:29 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in vega10_hwmgr.c
Date:   Tue,  1 Aug 2023 05:58:26 +0000
Message-Id: <20230801055826.6000-1-sunran001@208suo.com>
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

ERROR: trailing statements should be on next line
ERROR: space required before the open brace '{'
ERROR: space required before the open parenthesis '('
ERROR: space required after that ',' (ctx:VxV)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 08518bc1cbbe..ba7294daddfe 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -670,17 +670,23 @@ static int vega10_patch_voltage_dependency_tables_with_lookup_table(
 	for (i = 0; i < 6; i++) {
 		struct phm_ppt_v1_clock_voltage_dependency_table *vdt;
 		switch (i) {
-		case 0: vdt = table_info->vdd_dep_on_socclk;
+		case 0:
+			vdt = table_info->vdd_dep_on_socclk;
 			break;
-		case 1: vdt = table_info->vdd_dep_on_sclk;
+		case 1:
+			vdt = table_info->vdd_dep_on_sclk;
 			break;
-		case 2: vdt = table_info->vdd_dep_on_dcefclk;
+		case 2:
+			vdt = table_info->vdd_dep_on_dcefclk;
 			break;
-		case 3: vdt = table_info->vdd_dep_on_pixclk;
+		case 3:
+			vdt = table_info->vdd_dep_on_pixclk;
 			break;
-		case 4: vdt = table_info->vdd_dep_on_dispclk;
+		case 4:
+			vdt = table_info->vdd_dep_on_dispclk;
 			break;
-		case 5: vdt = table_info->vdd_dep_on_phyclk;
+		case 5:
+			vdt = table_info->vdd_dep_on_phyclk;
 			break;
 		}
 
-- 
2.17.1

