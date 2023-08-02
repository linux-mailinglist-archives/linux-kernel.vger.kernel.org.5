Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E3376C29B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjHBCDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjHBCDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:03:22 -0400
Received: from out28-134.mail.aliyun.com (out28-134.mail.aliyun.com [115.124.28.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A9E212D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:03:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4950177|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_alarm|0.0492171-0.00117622-0.949607;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6KTuiI_1690941793;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6KTuiI_1690941793)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 10:03:15 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in smu8_smumgr.h
Date:   Wed,  2 Aug 2023 02:03:12 +0000
Message-Id: <20230802020312.9233-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
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
 drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h
index c7b61222d258..475ffcf743d2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h
@@ -73,7 +73,7 @@ struct smu8_register_index_data_pair {
 
 struct smu8_ih_meta_data {
 	uint32_t command;
-	struct smu8_register_index_data_pair register_index_value_pair[1];
+	struct smu8_register_index_data_pair register_index_value_pair[0];
 };
 
 struct smu8_smumgr {
-- 
2.17.1

