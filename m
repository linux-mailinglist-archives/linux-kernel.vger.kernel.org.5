Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9D57CED1B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjJSBDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJSBDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:03:42 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8571B0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 18:03:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VuS1dn5_1697677416;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VuS1dn5_1697677416)
          by smtp.aliyun-inc.com;
          Thu, 19 Oct 2023 09:03:36 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     alexander.deucher@amd.com, harry.wentland@amd.com,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 2/2] drm/amd/display: clean up one inconsistent indenting
Date:   Thu, 19 Oct 2023 09:03:32 +0800
Message-Id: <20231019010332.25878-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20231019010332.25878-1-yang.lee@linux.alibaba.com>
References: <20231019010332.25878-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_policy.c:206 dml2_policy_build_synthetic_soc_states() warn: inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6933
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
index f8e9aa32ceab..0b3ab7aaea87 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
@@ -203,7 +203,7 @@ int dml2_policy_build_synthetic_soc_states(struct dml2_policy_build_synthetic_so
 			s->entry.fabricclk_mhz = p->in_states->state_array[i].fabricclk_mhz;
 			s->entry.dram_speed_mts = 0;
 
-		insert_entry_into_table_sorted(p->in_bbox, p->out_states, &s->entry);
+			insert_entry_into_table_sorted(p->in_bbox, p->out_states, &s->entry);
 		}
 	}
 	// Add max FCLK
-- 
2.20.1.7.g153144c

