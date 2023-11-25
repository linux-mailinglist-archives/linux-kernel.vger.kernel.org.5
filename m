Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A867F8914
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjKYINY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjKYIMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:12:51 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F3B170B;
        Sat, 25 Nov 2023 00:12:57 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Scl2p11f5z4f3mHH;
        Sat, 25 Nov 2023 16:12:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
        by mail.maildlp.com (Postfix) with ESMTP id 7A47F1A01A1;
        Sat, 25 Nov 2023 16:12:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgCnSkmCrGFlWcLEBw--.36822S10;
        Sat, 25 Nov 2023 16:12:54 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] ext4: remove unnecessary parameter "needed" in ext4_discard_preallocations
Date:   Sun, 26 Nov 2023 00:11:43 +0800
Message-Id: <20231125161143.3945726-9-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231125161143.3945726-1-shikemeng@huaweicloud.com>
References: <20231125161143.3945726-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgCnSkmCrGFlWcLEBw--.36822S10
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr4xJw1fWFW3KFW8KFWxZwb_yoWfWFWxpr
        Z8Aa18Ww13X34kuws2qr4UZr1Yga18Ka1UJrWS9w4qvFZxJrn3KF1DtF1ayF1YqFWkXF4Y
        vF10kry7Xw1I937anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIL05UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "needed" controls the number of ext4_prealloc_space to discard in
ext4_discard_preallocations. Function ext4_discard_preallocations is
supposed to discard all non-used preallocated blocks when "needed"
is 0 and now ext4_discard_preallocations is always called with "needed"
= 0. Remove unnecessary parameter "needed" and remove all non-used
preallocated spaces in ext4_discard_preallocations to simplify the
code.

Note: If count of non-used preallocated spaces could be more than
UINT_MAX, there was a memory leak as some non-used preallocated
spaces are left unused and this commit will fix it. Otherwise,
there is no behavior change.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/ext4.h        |  2 +-
 fs/ext4/extents.c     | 10 +++++-----
 fs/ext4/file.c        |  2 +-
 fs/ext4/indirect.c    |  2 +-
 fs/ext4/inode.c       |  6 +++---
 fs/ext4/ioctl.c       |  2 +-
 fs/ext4/mballoc.c     | 10 +++-------
 fs/ext4/move_extent.c |  4 ++--
 fs/ext4/super.c       |  2 +-
 9 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index fb35cae16..2fd444034 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2905,7 +2905,7 @@ extern int ext4_mb_init(struct super_block *);
 extern void ext4_mb_release(struct super_block *);
 extern ext4_fsblk_t ext4_mb_new_blocks(handle_t *,
 				struct ext4_allocation_request *, int *);
-extern void ext4_discard_preallocations(struct inode *, unsigned int);
+extern void ext4_discard_preallocations(struct inode *);
 extern int __init ext4_init_mballoc(void);
 extern void ext4_exit_mballoc(void);
 extern ext4_group_t ext4_mb_prefetch(struct super_block *sb,
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 880f383df..fd350889a 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -100,7 +100,7 @@ static int ext4_ext_trunc_restart_fn(struct inode *inode, int *dropped)
 	 * i_rwsem. So we can safely drop the i_data_sem here.
 	 */
 	BUG_ON(EXT4_JOURNAL(inode) == NULL);
-	ext4_discard_preallocations(inode, 0);
+	ext4_discard_preallocations(inode);
 	up_write(&EXT4_I(inode)->i_data_sem);
 	*dropped = 1;
 	return 0;
@@ -4313,7 +4313,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 			 * not a good idea to call discard here directly,
 			 * but otherwise we'd need to call it every free().
 			 */
-			ext4_discard_preallocations(inode, 0);
+			ext4_discard_preallocations(inode);
 			if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
 				fb_flags = EXT4_FREE_BLOCKS_NO_QUOT_UPDATE;
 			ext4_free_blocks(handle, inode, NULL, newblock,
@@ -5354,7 +5354,7 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE, handle);
 
 	down_write(&EXT4_I(inode)->i_data_sem);
-	ext4_discard_preallocations(inode, 0);
+	ext4_discard_preallocations(inode);
 	ext4_es_remove_extent(inode, punch_start, EXT_MAX_BLOCKS - punch_start);
 
 	ret = ext4_ext_remove_space(inode, punch_start, punch_stop - 1);
@@ -5362,7 +5362,7 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 		up_write(&EXT4_I(inode)->i_data_sem);
 		goto out_stop;
 	}
-	ext4_discard_preallocations(inode, 0);
+	ext4_discard_preallocations(inode);
 
 	ret = ext4_ext_shift_extents(inode, handle, punch_stop,
 				     punch_stop - punch_start, SHIFT_LEFT);
@@ -5494,7 +5494,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 		goto out_stop;
 
 	down_write(&EXT4_I(inode)->i_data_sem);
-	ext4_discard_preallocations(inode, 0);
+	ext4_discard_preallocations(inode);
 
 	path = ext4_find_extent(inode, offset_lblk, NULL, 0);
 	if (IS_ERR(path)) {
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 0166bb9ca..89cb28da8 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -174,7 +174,7 @@ static int ext4_release_file(struct inode *inode, struct file *filp)
 			(atomic_read(&inode->i_writecount) == 1) &&
 			!EXT4_I(inode)->i_reserved_data_blocks) {
 		down_write(&EXT4_I(inode)->i_data_sem);
-		ext4_discard_preallocations(inode, 0);
+		ext4_discard_preallocations(inode);
 		up_write(&EXT4_I(inode)->i_data_sem);
 	}
 	if (is_dx(inode) && filp->private_data)
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index a9f371611..d8ca7f64f 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -714,7 +714,7 @@ static int ext4_ind_trunc_restart_fn(handle_t *handle, struct inode *inode,
 	 * i_rwsem. So we can safely drop the i_data_sem here.
 	 */
 	BUG_ON(EXT4_JOURNAL(inode) == NULL);
-	ext4_discard_preallocations(inode, 0);
+	ext4_discard_preallocations(inode);
 	up_write(&EXT4_I(inode)->i_data_sem);
 	*dropped = 1;
 	return 0;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d77323204..53ed4a0ad 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -371,7 +371,7 @@ void ext4_da_update_reserve_space(struct inode *inode,
 	 */
 	if ((ei->i_reserved_data_blocks == 0) &&
 	    !inode_is_open_for_write(inode))
-		ext4_discard_preallocations(inode, 0);
+		ext4_discard_preallocations(inode);
 }
 
 static int __check_block_validity(struct inode *inode, const char *func,
@@ -4014,7 +4014,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	if (stop_block > first_block) {
 
 		down_write(&EXT4_I(inode)->i_data_sem);
-		ext4_discard_preallocations(inode, 0);
+		ext4_discard_preallocations(inode);
 
 		ext4_es_remove_extent(inode, first_block,
 				      stop_block - first_block);
@@ -4167,7 +4167,7 @@ int ext4_truncate(struct inode *inode)
 
 	down_write(&EXT4_I(inode)->i_data_sem);
 
-	ext4_discard_preallocations(inode, 0);
+	ext4_discard_preallocations(inode);
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		err = ext4_ext_truncate(handle, inode);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 0bfe2ce58..2e2bcd22b 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -458,7 +458,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
 	ext4_reset_inode_seed(inode);
 	ext4_reset_inode_seed(inode_bl);
 
-	ext4_discard_preallocations(inode, 0);
+	ext4_discard_preallocations(inode);
 
 	err = ext4_mark_inode_dirty(handle, inode);
 	if (err < 0) {
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e6561a09d..0e6beb3b4 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5469,7 +5469,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
  *
  * FIXME!! Make sure it is valid at all the call sites
  */
-void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
+void ext4_discard_preallocations(struct inode *inode)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	struct super_block *sb = inode->i_sb;
@@ -5491,15 +5491,12 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 	mb_debug(sb, "discard preallocation for inode %lu\n",
 		 inode->i_ino);
 	trace_ext4_discard_preallocations(inode,
-			atomic_read(&ei->i_prealloc_active), needed);
-
-	if (needed == 0)
-		needed = UINT_MAX;
+			atomic_read(&ei->i_prealloc_active), 0);
 
 repeat:
 	/* first, collect all pa's in the inode */
 	write_lock(&ei->i_prealloc_lock);
-	for (iter = rb_first(&ei->i_prealloc_node); iter && needed;
+	for (iter = rb_first(&ei->i_prealloc_node); iter;
 	     iter = rb_next(iter)) {
 		pa = rb_entry(iter, struct ext4_prealloc_space,
 			      pa_node.inode_node);
@@ -5523,7 +5520,6 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 			spin_unlock(&pa->pa_lock);
 			rb_erase(&pa->pa_node.inode_node, &ei->i_prealloc_node);
 			list_add(&pa->u.pa_tmp_list, &list);
-			needed--;
 			continue;
 		}
 
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 18a9e7c47..0abfc104a 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -689,8 +689,8 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 
 out:
 	if (*moved_len) {
-		ext4_discard_preallocations(orig_inode, 0);
-		ext4_discard_preallocations(donor_inode, 0);
+		ext4_discard_preallocations(orig_inode);
+		ext4_discard_preallocations(donor_inode);
 	}
 
 	ext4_free_ext_path(path);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d062383ea..c0cfc3e46 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1518,7 +1518,7 @@ void ext4_clear_inode(struct inode *inode)
 	ext4_fc_del(inode);
 	invalidate_inode_buffers(inode);
 	clear_inode(inode);
-	ext4_discard_preallocations(inode, 0);
+	ext4_discard_preallocations(inode);
 	ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
 	dquot_drop(inode);
 	if (EXT4_I(inode)->jinode) {
-- 
2.30.0

