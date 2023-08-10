Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03746776DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 03:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjHJBxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 21:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjHJBxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 21:53:05 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE25C5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 18:53:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RLqgx5D5jz4f3mHy
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:53:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgCXJ6r8QtRkiaZjAQ--.27199S4;
        Thu, 10 Aug 2023 09:53:02 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 2/3] mm/page_alloc: remove unnecessary check in break_down_buddy_pages
Date:   Thu, 10 Aug 2023 17:53:08 +0800
Message-Id: <20230810095309.3109107-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230810095309.3109107-1-shikemeng@huaweicloud.com>
References: <20230810095309.3109107-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCXJ6r8QtRkiaZjAQ--.27199S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XF4rWr48Kr18Wr1rWw1xZrb_yoWDAFb_ua
        n7tr95tFy5KF1IgF17C3W7GrWkWw1F9w4xWF4YgFsxKa4UAFnxta1kXFyrJr1Duay8ur98
        W3ZxArW2qr1a9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbqAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
        xGYIkIc2x26280x7IE14v26r15M28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kI
        II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7
        xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
        6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
        AqYI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
        43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
        WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTR
        QNVDUUUUU
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

1. We always have target in range started with next_page and full free
range started with current_buddy.
2. The last splited range size is 1 << low and low should be >= 0, then
size >= 1, then page + size and page will not interleave.
As summary, current_page will not equal to target page.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page_alloc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fd93d1396ccd..d0b400733031 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6562,10 +6562,8 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
 		if (set_page_guard(zone, current_buddy, high, migratetype))
 			continue;
 
-		if (current_buddy != target) {
-			add_to_free_list(current_buddy, zone, high, migratetype);
-			set_buddy_order(current_buddy, high);
-		}
+		add_to_free_list(current_buddy, zone, high, migratetype);
+		set_buddy_order(current_buddy, high);
 	}
 }
 
-- 
2.30.0

