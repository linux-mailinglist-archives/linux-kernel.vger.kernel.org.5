Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA0A76C2E7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjHBCbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjHBCbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:31:23 -0400
Received: from out28-135.mail.aliyun.com (out28-135.mail.aliyun.com [115.124.28.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1B5213F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:31:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2471169|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_alarm|0.00983395-0.000359475-0.989807;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6LyXcz_1690943470;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6LyXcz_1690943470)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 10:31:17 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in amdgpu_pm.c
Date:   Wed,  2 Aug 2023 02:31:09 +0000
Message-Id: <20230802023109.9924-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line
ERROR: space required before the open parenthesis '('

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 3922dd274f30..acaab3441030 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -743,7 +743,7 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 		type = PP_OD_EDIT_CCLK_VDDC_TABLE;
 	else if (*buf == 'm')
 		type = PP_OD_EDIT_MCLK_VDDC_TABLE;
-	else if(*buf == 'r')
+	else if (*buf == 'r')
 		type = PP_OD_RESTORE_DEFAULT_TABLE;
 	else if (*buf == 'c')
 		type = PP_OD_COMMIT_DPM_TABLE;
@@ -3532,7 +3532,8 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
 #if defined(CONFIG_DEBUG_FS)
 
 static void amdgpu_debugfs_prints_cpu_info(struct seq_file *m,
-					   struct amdgpu_device *adev) {
+					   struct amdgpu_device *adev)
+{
 	uint16_t *p_val;
 	uint32_t size;
 	int i;
-- 
2.17.1

