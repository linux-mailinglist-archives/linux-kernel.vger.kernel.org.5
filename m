Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDB376C321
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjHBCxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjHBCxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:53:39 -0400
Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1B626A1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:53:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.7130933|0.6509981;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_alarm|0.161067-0.00309727-0.835836;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6NOR6j_1690944809;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6NOR6j_1690944809)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 10:53:31 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/display: Clean up errors in dce110_hw_sequencer.c
Date:   Wed,  2 Aug 2023 02:53:27 +0000
Message-Id: <20230802025327.10370-1-sunran001@208suo.com>
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

ERROR: space required before the open brace '{'

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 20d4d08a6a2f..7f306d979c63 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -219,7 +219,7 @@ static bool dce110_enable_display_power_gating(
 	if (controller_id == underlay_idx)
 		controller_id = CONTROLLER_ID_UNDERLAY0 - 1;
 
-	if (power_gating != PIPE_GATING_CONTROL_INIT || controller_id == 0){
+	if (power_gating != PIPE_GATING_CONTROL_INIT || controller_id == 0) {
 
 		bp_result = dcb->funcs->enable_disp_power_gating(
 						dcb, controller_id + 1, cntl);
-- 
2.17.1

