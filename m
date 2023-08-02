Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978BC76C52E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjHBGOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjHBGOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:14:35 -0400
Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com [115.124.28.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4471E26A2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:14:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.7543166|0.4514992;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_alarm|0.0711045-0.00413473-0.924761;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6X1g.p_1690956865;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6X1g.p_1690956865)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 14:14:27 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/display: Clean up errors in dc_stream.c
Date:   Wed,  2 Aug 2023 06:14:23 +0000
Message-Id: <20230802061423.11155-1-sunran001@208suo.com>
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

ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index ea3d4b328e8e..05bb23bc122d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -71,8 +71,7 @@ static bool dc_stream_construct(struct dc_stream_state *stream,
 
 	/* Copy audio modes */
 	/* TODO - Remove this translation */
-	for (i = 0; i < (dc_sink_data->edid_caps.audio_mode_count); i++)
-	{
+	for (i = 0; i < (dc_sink_data->edid_caps.audio_mode_count); i++) {
 		stream->audio_info.modes[i].channel_count = dc_sink_data->edid_caps.audio_modes[i].channel_count;
 		stream->audio_info.modes[i].format_code = dc_sink_data->edid_caps.audio_modes[i].format_code;
 		stream->audio_info.modes[i].sample_rates.all = dc_sink_data->edid_caps.audio_modes[i].sample_rate;
-- 
2.17.1

