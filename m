Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DCE780817
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358987AbjHRJQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358994AbjHRJQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:16:19 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0D030E6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:16:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Vq1xg1D_1692350166;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Vq1xg1D_1692350166)
          by smtp.aliyun-inc.com;
          Fri, 18 Aug 2023 17:16:14 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     dwmw2@infradead.org
Cc:     baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] iommu/vt-d: Remove unused function
Date:   Fri, 18 Aug 2023 17:16:03 +0800
Message-Id: <20230818091603.64800-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
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

The function are defined in the pasid.c file, but not called
elsewhere, so delete the unused function.

drivers/iommu/intel/pasid.c:342:20: warning: unused function 'pasid_set_wpe'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6185
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/iommu/intel/pasid.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 8f92b92f3d2a..06ddb3c927f5 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -335,15 +335,6 @@ static inline void pasid_set_fault_enable(struct pasid_entry *pe)
 	pasid_set_bits(&pe->val[0], 1 << 1, 0);
 }
 
-/*
- * Setup the WPE(Write Protect Enable) field (Bit 132) of a
- * scalable mode PASID entry.
- */
-static inline void pasid_set_wpe(struct pasid_entry *pe)
-{
-	pasid_set_bits(&pe->val[2], 1 << 4, 1 << 4);
-}
-
 /*
  * Setup the P(Present) field (Bit 0) of a scalable mode PASID
  * entry.
-- 
2.20.1.7.g153144c

