Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D940766885
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbjG1JNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbjG1JMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:12:39 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7937944BC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:10:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RC20R15Vzz4f3mJ5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:10:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgA3n7L1hcNkCrD+Ow--.32454S7;
        Fri, 28 Jul 2023 17:10:17 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, willy@infradead.org, david@redhat.com
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 5/8] mm/compaction: corret comment of cached migrate pfn update
Date:   Sat, 29 Jul 2023 01:10:34 +0800
Message-Id: <20230728171037.2219226-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230728171037.2219226-1-shikemeng@huaweicloud.com>
References: <20230728171037.2219226-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3n7L1hcNkCrD+Ow--.32454S7
X-Coremail-Antispam: 1UD129KBjvdXoWruF1kGw4xtr1kGw4rtw18Zrb_yoWktFX_Xa
        1xtrs0k390kFyvqanrAw4akr4UGFWDZF1DG3Wktr47CFyvy3WDZ3WDZr1fur90qa9rWr9x
        Gw1kuFyjkFyakjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbDkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28IrcIa0xkI8V
        A2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJ
        M28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2I
        x0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
        6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
        AGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
        1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRRkucDUU
        UUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e380bebe47715 ("mm, compaction: keep migration source private to
a single compaction instance") moved update of async and sync
compact_cached_migrate_pfn from update_pageblock_skip to
update_cached_migrate but left the comment behind.
Move the relevant comment to correct this.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/compaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 09c36251c613..1eebb61a1f63 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -464,6 +464,7 @@ static void update_cached_migrate(struct compact_control *cc, unsigned long pfn)
 
 	pfn = pageblock_end_pfn(pfn);
 
+	/* Update where async and sync compaction should restart */
 	if (pfn > zone->compact_cached_migrate_pfn[0])
 		zone->compact_cached_migrate_pfn[0] = pfn;
 	if (cc->mode != MIGRATE_ASYNC &&
@@ -485,7 +486,6 @@ static void update_pageblock_skip(struct compact_control *cc,
 
 	set_pageblock_skip(page);
 
-	/* Update where async and sync compaction should restart */
 	if (pfn < zone->compact_cached_free_pfn)
 		zone->compact_cached_free_pfn = pfn;
 }
-- 
2.30.0

