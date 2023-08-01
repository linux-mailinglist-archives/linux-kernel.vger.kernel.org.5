Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219C676A6BB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjHACGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 22:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHACGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:06:38 -0400
Received: from out28-149.mail.aliyun.com (out28-149.mail.aliyun.com [115.124.28.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137E2103
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 19:06:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08576864|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0754816-0.000674398-0.923844;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5Ek3oJ_1690855589;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5Ek3oJ_1690855589)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 10:06:31 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in smu_v13_0_6_ppt.c
Date:   Tue,  1 Aug 2023 02:06:25 +0000
Message-Id: <20230801020625.4281-1-sunran001@208suo.com>
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

ERROR: code indent should use tabs where possible
ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 1ac552142763..43afa1ee1b4a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1248,9 +1248,9 @@ static int smu_v13_0_6_get_power_limit(struct smu_context *smu,
 				       uint32_t *default_power_limit,
 				       uint32_t *max_power_limit)
 {
-        struct smu_table_context *smu_table = &smu->smu_table;
-        struct PPTable_t *pptable =
-                (struct PPTable_t *)smu_table->driver_pptable;
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct PPTable_t *pptable =
+		(struct PPTable_t *)smu_table->driver_pptable;
 	uint32_t power_limit = 0;
 	int ret;
 
@@ -1366,8 +1366,7 @@ static int smu_v13_0_6_set_irq_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static const struct amdgpu_irq_src_funcs smu_v13_0_6_irq_funcs =
-{
+static const struct amdgpu_irq_src_funcs smu_v13_0_6_irq_funcs = {
 	.set = smu_v13_0_6_set_irq_state,
 	.process = smu_v13_0_6_irq_process,
 };
-- 
2.17.1

