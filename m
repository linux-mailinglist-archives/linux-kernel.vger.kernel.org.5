Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0430B76C537
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjHBGUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjHBGUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:20:36 -0400
Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C03C26A2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:20:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3399406|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0739442-0.00121786-0.924838;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6Y2FoY_1690957226;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6Y2FoY_1690957226)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 14:20:29 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/display: Clean up errors in display_mode_vba_30.c
Date:   Wed,  2 Aug 2023 06:20:25 +0000
Message-Id: <20230802062025.11332-1-sunran001@208suo.com>
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

ERROR: else should follow close brace '}'

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c  | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 9af1a43c042b..ad741a723c0e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -784,8 +784,7 @@ static unsigned int dscComputeDelay(enum output_format_class pixelFormat, enum o
 		Delay = Delay + 1;
 		//   sft
 		Delay = Delay + 1;
-	}
-	else {
+	} else {
 		//   sfr
 		Delay = Delay + 2;
 		//   dsccif
@@ -3489,8 +3488,7 @@ static double TruncToValidBPP(
 		if (Format == dm_n422) {
 			MinDSCBPP = 7;
 			MaxDSCBPP = 2 * DSCInputBitPerComponent - 1.0 / 16.0;
-		}
-		else {
+		} else {
 			MinDSCBPP = 8;
 			MaxDSCBPP = 3 * DSCInputBitPerComponent - 1.0 / 16.0;
 		}
-- 
2.17.1

