Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE4A76C546
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjHBG3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjHBG3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:29:30 -0400
Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C14026BA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:29:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4821605|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0156286-0.000344936-0.984026;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6XgVxA_1690957761;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6XgVxA_1690957761)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 14:29:23 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/display: Clean up errors in dmub_cmd.h
Date:   Wed,  2 Aug 2023 06:29:20 +0000
Message-Id: <20230802062920.11513-1-sunran001@208suo.com>
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

ERROR: Use C99 flexible arrays

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index adde1d84d773..b64740977fc8 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1165,7 +1165,7 @@ struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2 {
 			uint16_t vtotal;
 			uint16_t htotal;
 			uint8_t vblank_pipe_index;
-			uint8_t padding[1];
+			uint8_t padding[];
 			struct {
 				uint8_t drr_in_use;
 				uint8_t drr_window_size_ms;	// Indicates largest VMIN/VMAX adjustment per frame
@@ -3056,7 +3056,7 @@ struct dmub_cmd_abm_set_pwm_frac_data {
 	/**
 	 * Explicit padding to 4 byte boundary.
 	 */
-	uint8_t pad[2];
+	uint8_t pad[];
 };
 
 /**
-- 
2.17.1

