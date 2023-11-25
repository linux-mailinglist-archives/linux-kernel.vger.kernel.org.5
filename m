Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D722D7F8904
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjKYIMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYIMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:12:50 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5703DB5;
        Sat, 25 Nov 2023 00:12:55 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Scl2p6Jmvz4f3jHV;
        Sat, 25 Nov 2023 16:12:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
        by mail.maildlp.com (Postfix) with ESMTP id A4A6B1A0315;
        Sat, 25 Nov 2023 16:12:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgCnSkmCrGFlWcLEBw--.36822S4;
        Sat, 25 Nov 2023 16:12:52 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] ext4: remove unused parameter group in ext4_mb_choose_next_group_*()
Date:   Sun, 26 Nov 2023 00:11:37 +0800
Message-Id: <20231125161143.3945726-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231125161143.3945726-1-shikemeng@huaweicloud.com>
References: <20231125161143.3945726-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgCnSkmCrGFlWcLEBw--.36822S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWrtw43Gw15JF15XFyUAwb_yoW5JFy8pF
        4DtF1j93y3WF1DuF4xW39Fg3WxKw18uryUAry3Wa4F9ryxJry8JF47tF48AF1UCFs7urnx
        Zas0v348Ca1xC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsmiiDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused parameter group in ext4_mb_choose_next_group_*().

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9f9b8dd06..765b62729 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -870,7 +870,7 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
  * cr level needs an update.
  */
 static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context *ac,
-			enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
+			enum criteria *new_cr, ext4_group_t *group)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_group_info *iter;
@@ -944,7 +944,7 @@ ext4_mb_find_good_group_avg_frag_lists(struct ext4_allocation_context *ac, int o
  * order. Updates *new_cr if cr level needs an update.
  */
 static void ext4_mb_choose_next_group_goal_fast(struct ext4_allocation_context *ac,
-		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
+		enum criteria *new_cr, ext4_group_t *group)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_group_info *grp = NULL;
@@ -989,7 +989,7 @@ static void ext4_mb_choose_next_group_goal_fast(struct ext4_allocation_context *
  * much and fall to CR_GOAL_LEN_SLOW in that case.
  */
 static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context *ac,
-		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
+		enum criteria *new_cr, ext4_group_t *group)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_group_info *grp = NULL;
@@ -1124,11 +1124,11 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
 	}
 
 	if (*new_cr == CR_POWER2_ALIGNED) {
-		ext4_mb_choose_next_group_p2_aligned(ac, new_cr, group, ngroups);
+		ext4_mb_choose_next_group_p2_aligned(ac, new_cr, group);
 	} else if (*new_cr == CR_GOAL_LEN_FAST) {
-		ext4_mb_choose_next_group_goal_fast(ac, new_cr, group, ngroups);
+		ext4_mb_choose_next_group_goal_fast(ac, new_cr, group);
 	} else if (*new_cr == CR_BEST_AVAIL_LEN) {
-		ext4_mb_choose_next_group_best_avail(ac, new_cr, group, ngroups);
+		ext4_mb_choose_next_group_best_avail(ac, new_cr, group);
 	} else {
 		/*
 		 * TODO: For CR=2, we can arrange groups in an rb tree sorted by
-- 
2.30.0

