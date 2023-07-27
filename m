Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D2C764393
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 03:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjG0B4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 21:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjG0B4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 21:56:05 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D905D212A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 18:56:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VoInHCa_1690422959;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VoInHCa_1690422959)
          by smtp.aliyun-inc.com;
          Thu, 27 Jul 2023 09:56:00 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] mm: Fix some kernel-doc comments
Date:   Thu, 27 Jul 2023 09:55:58 +0800
Message-Id: <20230727015558.69554-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of @mas and @tree_end, remove @mt in unmap_vmas().
to silence the warnings:

mm/memory.c:1837: warning: Function parameter or member 'mas' not described in 'unmap_vmas'
mm/memory.c:1837: warning: Function parameter or member 'tree_end' not described in 'unmap_vmas'
mm/memory.c:1837: warning: Excess function parameter 'mt' description in 'unmap_vmas'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5996
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 mm/memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 2130bad76eb1..49bf57aae7e1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1813,10 +1813,11 @@ static void unmap_single_vma(struct mmu_gather *tlb,
 /**
  * unmap_vmas - unmap a range of memory covered by a list of vma's
  * @tlb: address of the caller's struct mmu_gather
- * @mt: the maple tree
+ * @mas: the maple state
  * @vma: the starting vma
  * @start_addr: virtual address at which to start unmapping
  * @end_addr: virtual address at which to end unmapping
+ * @tree_end: The maximum index to check
  * @mm_wr_locked: lock flag
  *
  * Unmap all pages in the vma list.
-- 
2.20.1.7.g153144c

