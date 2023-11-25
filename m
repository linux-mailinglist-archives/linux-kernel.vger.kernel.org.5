Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD237F8912
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjKYINN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKYIMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:12:51 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E901707;
        Sat, 25 Nov 2023 00:12:56 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Scl2r310Mz4f3jrp;
        Sat, 25 Nov 2023 16:12:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
        by mail.maildlp.com (Postfix) with ESMTP id 34C011A01F4;
        Sat, 25 Nov 2023 16:12:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgCnSkmCrGFlWcLEBw--.36822S9;
        Sat, 25 Nov 2023 16:12:54 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] ext4: remove unused return value of ext4_mb_release_group_pa
Date:   Sun, 26 Nov 2023 00:11:42 +0800
Message-Id: <20231125161143.3945726-8-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231125161143.3945726-1-shikemeng@huaweicloud.com>
References: <20231125161143.3945726-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgCnSkmCrGFlWcLEBw--.36822S9
X-Coremail-Antispam: 1UD129KBjvdXoWrtr4fGF45tF1xKF4DKw1rZwb_yoWkZrc_Ca
        47Xr4kA34fA3s293WrJry3t3yDKan7Zr9rWr4rKrWfAF1rW3ZxAw1DZrsxA397ua10ka43
        GF93Zry8GFZYqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbqkYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
        xGYIkIc2x26280x7IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC
        64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM2
        8EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq
        3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
        1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07js
        txDUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused return value of ext4_mb_release_group_pa.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 1ed6d1d5a..e6561a09d 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5330,7 +5330,7 @@ ext4_mb_release_inode_pa(struct ext4_buddy *e4b, struct buffer_head *bitmap_bh,
 	atomic_add(free, &sbi->s_mb_discarded);
 }
 
-static noinline_for_stack int
+static noinline_for_stack void
 ext4_mb_release_group_pa(struct ext4_buddy *e4b,
 				struct ext4_prealloc_space *pa)
 {
@@ -5344,13 +5344,11 @@ ext4_mb_release_group_pa(struct ext4_buddy *e4b,
 	if (unlikely(group != e4b->bd_group && pa->pa_len != 0)) {
 		ext4_warning(sb, "bad group: expected %u, group %u, pa_start %llu",
 			     e4b->bd_group, group, pa->pa_pstart);
-		return 0;
+		return;
 	}
 	mb_free_blocks(pa->pa_inode, e4b, bit, pa->pa_len);
 	atomic_add(pa->pa_len, &EXT4_SB(sb)->s_mb_discarded);
 	trace_ext4_mballoc_discard(sb, NULL, group, bit, pa->pa_len);
-
-	return 0;
 }
 
 /*
-- 
2.30.0

