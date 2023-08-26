Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE7C789470
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 09:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjHZHsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 03:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjHZHsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 03:48:03 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABFA1FD7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 00:48:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RXpp33cYTz4f3kjB
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 15:47:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgB3B6osrulk6+l0Bg--.52079S4;
        Sat, 26 Aug 2023 15:47:58 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        naoya.horiguchi@nec.com, osalvador@suse.de
Subject: [PATCH v2 2/3] mm/page_alloc: remove unnecessary check in break_down_buddy_pages
Date:   Sat, 26 Aug 2023 23:47:44 +0800
Message-Id: <20230826154745.4019371-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230826154745.4019371-1-shikemeng@huaweicloud.com>
References: <20230826154745.4019371-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3B6osrulk6+l0Bg--.52079S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XF4rWr48Kr18Wr1rWw1xZrb_yoWDAFb_ua
        n7trn5tFyUKF17KF17C3W7GrWkWw1F9w4xWr4YgF43Ka4UAFn0yan5XFyrJr1Duay8ur98
        u3ZxZrW2qr1a9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
        xGYIkIc2x26280x7IE14v26r15M28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kI
        II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7
        xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
        6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUVHGHUUUUU
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
index 88c5f5aea9b0..bb74b40dc195 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6510,10 +6510,8 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
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

