Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0442776C6BA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjHBHY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjHBHYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:24:51 -0400
Received: from out28-129.mail.aliyun.com (out28-129.mail.aliyun.com [115.124.28.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1413198B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:24:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=SUSPECT;BC=0.6737961|-1;BR=01201311R121b1;CH=blue;DM=|SUSPECT|false|;DS=CONTINUE|ham_alarm|0.0083597-0.000449926-0.99119;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6bVeRD_1690961081;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6bVeRD_1690961081)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 15:24:43 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in mes_v11_0.c
Date:   Wed,  2 Aug 2023 07:24:40 +0000
Message-Id: <20230802072440.13073-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: else should follow close brace '}'

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 11fda318064f..6827d547042e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -788,8 +788,7 @@ static int mes_v11_0_mqd_init(struct amdgpu_ring *ring)
 				    DOORBELL_SOURCE, 0);
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 				    DOORBELL_HIT, 0);
-	}
-	else
+	} else
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 				    DOORBELL_EN, 0);
 	mqd->cp_hqd_pq_doorbell_control = tmp;
-- 
2.17.1

