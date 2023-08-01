Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAD676A688
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjHABng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjHABnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:43:35 -0400
Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14A7E46
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 18:43:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0994977|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0138158-0.000495978-0.985688;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5Ch.34_1690854200;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5Ch.34_1690854200)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 09:43:22 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in smu_v13_0.c
Date:   Tue,  1 Aug 2023 01:43:18 +0000
Message-Id: <20230801014318.4097-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: space required before the open parenthesis '('
ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 9b62b45ebb7f..895cda8e6934 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1121,7 +1121,7 @@ smu_v13_0_display_clock_voltage_request(struct smu_context *smu,
 
 		ret = smu_v13_0_set_hard_freq_limited_range(smu, clk_select, clk_freq, 0);
 
-		if(clk_select == SMU_UCLK)
+		if (clk_select == SMU_UCLK)
 			smu->hard_min_uclk_req_from_dal = clk_freq;
 	}
 
@@ -1437,8 +1437,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
 	return 0;
 }
 
-static const struct amdgpu_irq_src_funcs smu_v13_0_irq_funcs =
-{
+static const struct amdgpu_irq_src_funcs smu_v13_0_irq_funcs = {
 	.set = smu_v13_0_set_irq_state,
 	.process = smu_v13_0_irq_process,
 };
@@ -1933,7 +1932,7 @@ static int smu_v13_0_get_dpm_level_count(struct smu_context *smu,
 
 	ret = smu_v13_0_get_dpm_freq_by_index(smu, clk_type, 0xff, value);
 	/* SMU v13.0.2 FW returns 0 based max level, increment by one for it */
-	if((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2)) && (!ret && value))
+	if ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2)) && (!ret && value))
 		++(*value);
 
 	return ret;
-- 
2.17.1

