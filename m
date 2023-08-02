Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8E976C37A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 05:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjHBDXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 23:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjHBDXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 23:23:07 -0400
Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com [115.124.28.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF4BE4C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 20:23:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08068386|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0424418-0.000212042-0.957346;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6PnZk8_1690946577;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6PnZk8_1690946577)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 11:22:59 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/display: Clean up errors in bios_parser2.c
Date:   Wed,  2 Aug 2023 03:22:56 +0000
Message-Id: <20230802032256.10846-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: switch and case should be at the same indent
ERROR: code indent should use tabs where possible

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 540d19efad8f..033ce2638eb2 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -772,20 +772,20 @@ static enum bp_result bios_parser_get_device_tag(
 		return BP_RESULT_BADINPUT;
 
 	switch (bp->object_info_tbl.revision.minor) {
-	    case 4:
-	    default:
+	case 4:
+	default:
 	        /* getBiosObject will return MXM object */
-	        object = get_bios_object(bp, connector_object_id);
+		object = get_bios_object(bp, connector_object_id);
 
 		if (!object) {
 			BREAK_TO_DEBUGGER(); /* Invalid object id */
 			return BP_RESULT_BADINPUT;
 		}
 
-	        info->acpi_device = 0; /* BIOS no longer provides this */
-	        info->dev_id = device_type_from_device_id(object->device_tag);
-	        break;
-	    case 5:
+		info->acpi_device = 0; /* BIOS no longer provides this */
+		info->dev_id = device_type_from_device_id(object->device_tag);
+		break;
+	case 5:
 		object_path_v3 = get_bios_object_from_path_v3(bp, connector_object_id);
 
 		if (!object_path_v3) {
@@ -1580,13 +1580,13 @@ static bool bios_parser_is_device_id_supported(
 	uint32_t mask = get_support_mask_for_device_id(id);
 
 	switch (bp->object_info_tbl.revision.minor) {
-	    case 4:
-	    default:
-	        return (le16_to_cpu(bp->object_info_tbl.v1_4->supporteddevices) & mask) != 0;
-			break;
-	    case 5:
-			return (le16_to_cpu(bp->object_info_tbl.v1_5->supporteddevices) & mask) != 0;
-			break;
+	case 4:
+	default:
+		return (le16_to_cpu(bp->object_info_tbl.v1_4->supporteddevices) & mask) != 0;
+		break;
+	case 5:
+		return (le16_to_cpu(bp->object_info_tbl.v1_5->supporteddevices) & mask) != 0;
+		break;
 	}
 
 	return false;
@@ -1755,7 +1755,7 @@ static enum bp_result bios_parser_get_firmware_info(
 			case 2:
 			case 3:
 				result = get_firmware_info_v3_2(bp, info);
-                                break;
+			break;
 			case 4:
 				result = get_firmware_info_v3_4(bp, info);
 				break;
@@ -2225,7 +2225,7 @@ static enum bp_result bios_parser_get_disp_connector_caps_info(
 		return BP_RESULT_BADINPUT;
 
 	switch (bp->object_info_tbl.revision.minor) {
-	    case 4:
+	case 4:
 	    default:
 		    object = get_bios_object(bp, object_id);
 
-- 
2.17.1

