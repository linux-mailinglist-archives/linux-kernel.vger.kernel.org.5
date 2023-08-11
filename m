Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7592E778653
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbjHKD7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjHKD7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:59:43 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF8A2D78
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 20:59:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RMVRZ6LqWz4f3jLX
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:59:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgB3B6opstVkr4O6AQ--.62491S3;
        Fri, 11 Aug 2023 11:59:39 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 1/2] mm/page_alloc: remove unnecessary inner __get_pfnblock_flags_mask
Date:   Fri, 11 Aug 2023 19:59:44 +0800
Message-Id: <20230811115945.3423894-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230811115945.3423894-1-shikemeng@huaweicloud.com>
References: <20230811115945.3423894-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3B6opstVkr4O6AQ--.62491S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWkXw17urWUArW8JrWfAFb_yoW8tw1Dpa
        4xtFyjyF42934a9ayxZF1qvry3Awn8Ww45ArsxK342va45AFy7Wrn3KFyfXF4FqrWxAF15
        ZrW5tFykZFnrJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
        87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
        C7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRE2NtUUUUUU=
        =
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function get_pfnblock_flags_mask just calls inline inner
__get_pfnblock_flags_mask without any extra work. Just opencode
__get_pfnblock_flags_mask in get_pfnblock_flags_mask and replace call
to __get_pfnblock_flags_mask with call to get_pfnblock_flags_mask to
remove unnecessary __get_pfnblock_flags_mask.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page_alloc.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e884d3fd0d06..6c2294ccc6cb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -371,10 +371,16 @@ static inline int pfn_to_bitidx(const struct page *page, unsigned long pfn)
 	return (pfn >> pageblock_order) * NR_PAGEBLOCK_BITS;
 }
 
-static __always_inline
-unsigned long __get_pfnblock_flags_mask(const struct page *page,
-					unsigned long pfn,
-					unsigned long mask)
+/**
+ * get_pfnblock_flags_mask - Return the requested group of flags for the pageblock_nr_pages block of pages
+ * @page: The page within the block of interest
+ * @pfn: The target page frame number
+ * @mask: mask of bits that the caller is interested in
+ *
+ * Return: pageblock_bits flags
+ */
+unsigned long get_pfnblock_flags_mask(const struct page *page,
+					unsigned long pfn, unsigned long mask)
 {
 	unsigned long *bitmap;
 	unsigned long bitidx, word_bitidx;
@@ -393,24 +399,10 @@ unsigned long __get_pfnblock_flags_mask(const struct page *page,
 	return (word >> bitidx) & mask;
 }
 
-/**
- * get_pfnblock_flags_mask - Return the requested group of flags for the pageblock_nr_pages block of pages
- * @page: The page within the block of interest
- * @pfn: The target page frame number
- * @mask: mask of bits that the caller is interested in
- *
- * Return: pageblock_bits flags
- */
-unsigned long get_pfnblock_flags_mask(const struct page *page,
-					unsigned long pfn, unsigned long mask)
-{
-	return __get_pfnblock_flags_mask(page, pfn, mask);
-}
-
 static __always_inline int get_pfnblock_migratetype(const struct page *page,
 					unsigned long pfn)
 {
-	return __get_pfnblock_flags_mask(page, pfn, MIGRATETYPE_MASK);
+	return get_pfnblock_flags_mask(page, pfn, MIGRATETYPE_MASK);
 }
 
 /**
-- 
2.30.0

