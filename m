Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610BC7F8905
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjKYIM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjKYIMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:12:50 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BDC10F7;
        Sat, 25 Nov 2023 00:12:55 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Scl2p1Vm2z4f3kjX;
        Sat, 25 Nov 2023 16:12:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
        by mail.maildlp.com (Postfix) with ESMTP id F39F91A01F4;
        Sat, 25 Nov 2023 16:12:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgCnSkmCrGFlWcLEBw--.36822S5;
        Sat, 25 Nov 2023 16:12:52 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] ext4: remove unneeded return value of ext4_mb_release_context
Date:   Sun, 26 Nov 2023 00:11:38 +0800
Message-Id: <20231125161143.3945726-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231125161143.3945726-1-shikemeng@huaweicloud.com>
References: <20231125161143.3945726-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgCnSkmCrGFlWcLEBw--.36822S5
X-Coremail-Antispam: 1UD129KBjvdXoWrKFyDWF1UXFyDJw1kCw1kuFg_yoWkuwb_GF
        WUGr4xCFyrA34fC3WFy3yrtFZagrs3Ar1jqFs5tFW3uayUXr4xCw1qyrn8ZrZrWr48A343
        Crn8Cr1UCrZaqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
        xGYIkIc2x26280x7IE14v26r1rM28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kI
        II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7
        xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
        6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
        6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jy0PhUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ext4_mb_release_context always return 0 and the return value is
never used. Just remove unneeded return value of ext4_mb_release_context.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 765b62729..f79e87ad3 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5939,7 +5939,7 @@ static void ext4_mb_add_n_trim(struct ext4_allocation_context *ac)
 /*
  * release all resource we used in allocation
  */
-static int ext4_mb_release_context(struct ext4_allocation_context *ac)
+static void ext4_mb_release_context(struct ext4_allocation_context *ac)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_prealloc_space *pa = ac->ac_pa;
@@ -5976,7 +5976,6 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
 	if (ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC)
 		mutex_unlock(&ac->ac_lg->lg_mutex);
 	ext4_mb_collect_stats(ac);
-	return 0;
 }
 
 static int ext4_mb_discard_preallocations(struct super_block *sb, int needed)
-- 
2.30.0

