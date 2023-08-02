Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8868676C324
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjHBCyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjHBCyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:54:52 -0400
Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCF211D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:54:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.6822839|0.6520798;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_alarm|0.168779-0.00358723-0.827634;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6NGrmo_1690944884;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6NGrmo_1690944884)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 10:54:46 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/display: Clean up errors in dce112_hw_sequencer.c
Date:   Wed,  2 Aug 2023 02:54:43 +0000
Message-Id: <20230802025443.10458-1-sunran001@208suo.com>
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
 drivers/gpu/drm/amd/display/dc/dce112/dce112_hw_sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_hw_sequencer.c
index 690caaaff019..0ef9ebb3c1e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_hw_sequencer.c
@@ -127,7 +127,7 @@ static bool dce112_enable_display_power_gating(
 	else
 		cntl = ASIC_PIPE_DISABLE;
 
-	if (power_gating != PIPE_GATING_CONTROL_INIT || controller_id == 0){
+	if (power_gating != PIPE_GATING_CONTROL_INIT || controller_id == 0) {
 
 		bp_result = dcb->funcs->enable_disp_power_gating(
 						dcb, controller_id + 1, cntl);
-- 
2.17.1

