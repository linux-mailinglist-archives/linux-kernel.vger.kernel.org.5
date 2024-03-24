Return-Path: <linux-kernel+bounces-114704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E9E888BD3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BACC91C29B66
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBBC18D879;
	Mon, 25 Mar 2024 00:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piafpu+2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097F615FCF8;
	Sun, 24 Mar 2024 23:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322365; cv=none; b=oOn/1w7VbNuIY7AvsEOuTIEgmK7F0XJyXcrJanc9rWRIMuq6Xqo4r+qvKyxHuvaa/JywwqPf4VxquhsEMMitEDXn/WrxsPSruKHMiS2Bv7BfnPJQDoNJ/wzsM1mJifq4IFZe+sh0yRE3mlIjsA1yPA3DSNVAvp1eV8dusLKRNOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322365; c=relaxed/simple;
	bh=DfLTW7tq151VFYToRaEaLt4zUz1xMvnjacGECvEqAQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlutfL7HniyYxBsg4PwHU3SQLo09xpx8cVtVYBUmLwmdKn4qdB2t3+5/IZ929fHrjZ8Cn5Yqs1Zm9p3sKiD1fvnQIdHrCpZny3MnzI9lHIzdCLdFqpVoKPfNirXg6RVorYWtqqcO7Ai41Xjx3wbmZ4Vd1I22+2DHyn0zMRE4J0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piafpu+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47638C433C7;
	Sun, 24 Mar 2024 23:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322363;
	bh=DfLTW7tq151VFYToRaEaLt4zUz1xMvnjacGECvEqAQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=piafpu+2Cr1nwxv1NJiCi0BE24xW3XFmHGquz4WeWa041x4t7NlcGBLghxI3Fq+JI
	 /lSwoAIRw72dgcr0n5YTeriaREfKCmYuexAoVx+iG633GIerSl2F+qysl227RCaRZv
	 iXyc4eTnSMnnk3GQvjH2G65ts4IOc5MscCoHgYrBzpD9QnVyTtRMFi3NeIP3+duNuE
	 0jYegpQRre79ckDLYQl68bRFVCFCoNFYsffxjEh3vBdnRVpPUJJWHTW7vBI23iGsak
	 Qiba+yRglnXXMCRwKsnBGYtBuAF99n9X90uI8egFZmGR+egWDIBEi0XgLBlNxXFgi6
	 QzTzOy7ws1XEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heinz Mauelshagen <heinzm@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 446/451] dm: address indent/space issues
Date: Sun, 24 Mar 2024 19:12:02 -0400
Message-ID: <20240324231207.1351418-447-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Heinz Mauelshagen <heinzm@redhat.com>

[ Upstream commit 255e2646496fcbf836a3dfe1b535692f09f11b45 ]

Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Stable-dep-of: b4d78cfeb304 ("dm-integrity: align the outgoing bio in integrity_recheck")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-cache-policy.h                     | 2 +-
 drivers/md/dm-crypt.c                            | 2 +-
 drivers/md/dm-integrity.c                        | 5 ++---
 drivers/md/dm-log.c                              | 8 ++++----
 drivers/md/dm-raid.c                             | 8 ++++----
 drivers/md/dm-raid1.c                            | 2 +-
 drivers/md/dm-table.c                            | 4 ++--
 drivers/md/dm-thin.c                             | 6 +++---
 drivers/md/dm-writecache.c                       | 2 +-
 drivers/md/persistent-data/dm-btree.c            | 6 +++---
 drivers/md/persistent-data/dm-space-map-common.c | 2 +-
 drivers/md/persistent-data/dm-space-map-common.h | 2 +-
 12 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/md/dm-cache-policy.h b/drivers/md/dm-cache-policy.h
index 6ba3e9c91af53..8bc21d54884e9 100644
--- a/drivers/md/dm-cache-policy.h
+++ b/drivers/md/dm-cache-policy.h
@@ -75,7 +75,7 @@ struct dm_cache_policy {
 	 * background work.
 	 */
 	int (*get_background_work)(struct dm_cache_policy *p, bool idle,
-			           struct policy_work **result);
+				   struct policy_work **result);
 
 	/*
 	 * You must pass in the same work pointer that you were given, not
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index e8c534b5870ac..25e51dc6e5598 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2535,7 +2535,7 @@ static int crypt_set_keyring_key(struct crypt_config *cc, const char *key_string
 		type = &key_type_encrypted;
 		set_key = set_key_encrypted;
 	} else if (IS_ENABLED(CONFIG_TRUSTED_KEYS) &&
-	           !strncmp(key_string, "trusted:", key_desc - key_string + 1)) {
+		   !strncmp(key_string, "trusted:", key_desc - key_string + 1)) {
 		type = &key_type_trusted;
 		set_key = set_key_trusted;
 	} else {
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index e1bf91faa462b..94382e43ea506 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2367,7 +2367,6 @@ static void dm_integrity_map_continue(struct dm_integrity_io *dio, bool from_map
 		else
 skip_check:
 			dec_in_flight(dio);
-
 	} else {
 		INIT_WORK(&dio->work, integrity_metadata);
 		queue_work(ic->metadata_wq, &dio->work);
@@ -4151,7 +4150,7 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
 		} else if (sscanf(opt_string, "block_size:%u%c", &val, &dummy) == 1) {
 			if (val < 1 << SECTOR_SHIFT ||
 			    val > MAX_SECTORS_PER_BLOCK << SECTOR_SHIFT ||
-			    (val & (val -1))) {
+			    (val & (val - 1))) {
 				r = -EINVAL;
 				ti->error = "Invalid block_size argument";
 				goto bad;
@@ -4477,7 +4476,7 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
 	if (ic->internal_hash) {
 		size_t recalc_tags_size;
 		ic->recalc_wq = alloc_workqueue("dm-integrity-recalc", WQ_MEM_RECLAIM, 1);
-		if (!ic->recalc_wq ) {
+		if (!ic->recalc_wq) {
 			ti->error = "Cannot allocate workqueue";
 			r = -ENOMEM;
 			goto bad;
diff --git a/drivers/md/dm-log.c b/drivers/md/dm-log.c
index 05141eea18d3c..b7dd5a0cd58ba 100644
--- a/drivers/md/dm-log.c
+++ b/drivers/md/dm-log.c
@@ -756,8 +756,8 @@ static void core_set_region_sync(struct dm_dirty_log *log, region_t region,
 	log_clear_bit(lc, lc->recovering_bits, region);
 	if (in_sync) {
 		log_set_bit(lc, lc->sync_bits, region);
-                lc->sync_count++;
-        } else if (log_test_bit(lc->sync_bits, region)) {
+		lc->sync_count++;
+	} else if (log_test_bit(lc->sync_bits, region)) {
 		lc->sync_count--;
 		log_clear_bit(lc, lc->sync_bits, region);
 	}
@@ -765,9 +765,9 @@ static void core_set_region_sync(struct dm_dirty_log *log, region_t region,
 
 static region_t core_get_sync_count(struct dm_dirty_log *log)
 {
-        struct log_c *lc = (struct log_c *) log->context;
+	struct log_c *lc = (struct log_c *) log->context;
 
-        return lc->sync_count;
+	return lc->sync_count;
 }
 
 #define	DMEMIT_SYNC \
diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 7fbce214e00f5..bf833ca880bc1 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -362,8 +362,8 @@ static struct {
 	const int mode;
 	const char *param;
 } _raid456_journal_mode[] = {
-	{ R5C_JOURNAL_MODE_WRITE_THROUGH , "writethrough" },
-	{ R5C_JOURNAL_MODE_WRITE_BACK    , "writeback" }
+	{ R5C_JOURNAL_MODE_WRITE_THROUGH, "writethrough" },
+	{ R5C_JOURNAL_MODE_WRITE_BACK,    "writeback" }
 };
 
 /* Return MD raid4/5/6 journal mode for dm @journal_mode one */
@@ -1114,7 +1114,7 @@ static int validate_raid_redundancy(struct raid_set *rs)
  *    [stripe_cache <sectors>]		Stripe cache size for higher RAIDs
  *    [region_size <sectors>]		Defines granularity of bitmap
  *    [journal_dev <dev>]		raid4/5/6 journaling deviice
- *    					(i.e. write hole closing log)
+ *					(i.e. write hole closing log)
  *
  * RAID10-only options:
  *    [raid10_copies <# copies>]	Number of copies.  (Default: 2)
@@ -3999,7 +3999,7 @@ static int raid_preresume(struct dm_target *ti)
 	}
 
 	/* Resize bitmap to adjust to changed region size (aka MD bitmap chunksize) or grown device size */
-        if (test_bit(RT_FLAG_RS_BITMAP_LOADED, &rs->runtime_flags) && mddev->bitmap &&
+	if (test_bit(RT_FLAG_RS_BITMAP_LOADED, &rs->runtime_flags) && mddev->bitmap &&
 	    (test_bit(RT_FLAG_RS_GROW, &rs->runtime_flags) ||
 	     (rs->requested_bitmap_chunk_sectors &&
 	       mddev->bitmap_info.chunksize != to_bytes(rs->requested_bitmap_chunk_sectors)))) {
diff --git a/drivers/md/dm-raid1.c b/drivers/md/dm-raid1.c
index c38e63706d911..2327645fc0648 100644
--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@ -902,7 +902,7 @@ static struct mirror_set *alloc_context(unsigned int nr_mirrors,
 	if (IS_ERR(ms->io_client)) {
 		ti->error = "Error creating dm_io client";
 		kfree(ms);
- 		return NULL;
+		return NULL;
 	}
 
 	ms->rh = dm_region_hash_create(ms, dispatch_bios, wakeup_mirrord,
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index e0367a672eabf..aabb2435070b8 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -72,7 +72,7 @@ static sector_t high(struct dm_table *t, unsigned int l, unsigned int n)
 		n = get_child(n, CHILDREN_PER_NODE - 1);
 
 	if (n >= t->counts[l])
-		return (sector_t) - 1;
+		return (sector_t) -1;
 
 	return get_node(t, l, n)[KEYS_PER_NODE - 1];
 }
@@ -1533,7 +1533,7 @@ static bool dm_table_any_dev_attr(struct dm_table *t,
 		if (ti->type->iterate_devices &&
 		    ti->type->iterate_devices(ti, func, data))
 			return true;
-        }
+	}
 
 	return false;
 }
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 601f9e4e6234f..f24d89af7c5f0 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -1179,9 +1179,9 @@ static void process_prepared_discard_passdown_pt1(struct dm_thin_new_mapping *m)
 	discard_parent = bio_alloc(NULL, 1, 0, GFP_NOIO);
 	discard_parent->bi_end_io = passdown_endio;
 	discard_parent->bi_private = m;
- 	if (m->maybe_shared)
- 		passdown_double_checking_shared_status(m, discard_parent);
- 	else {
+	if (m->maybe_shared)
+		passdown_double_checking_shared_status(m, discard_parent);
+	else {
 		struct discard_op op;
 
 		begin_discard(&op, tc, discard_parent);
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index c6ff43a8f0b25..a705e24d3e2b6 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -531,7 +531,7 @@ static void ssd_commit_flushed(struct dm_writecache *wc, bool wait_for_ios)
 		req.notify.context = &endio;
 
 		/* writing via async dm-io (implied by notify.fn above) won't return an error */
-	        (void) dm_io(&req, 1, &region, NULL);
+		(void) dm_io(&req, 1, &region, NULL);
 		i = j;
 	}
 
diff --git a/drivers/md/persistent-data/dm-btree.c b/drivers/md/persistent-data/dm-btree.c
index 1cc783d7030d8..18d949d63543b 100644
--- a/drivers/md/persistent-data/dm-btree.c
+++ b/drivers/md/persistent-data/dm-btree.c
@@ -726,7 +726,7 @@ static int shadow_child(struct dm_btree_info *info, struct dm_btree_value_type *
  * nodes, so saves metadata space.
  */
 static int split_two_into_three(struct shadow_spine *s, unsigned int parent_index,
-                                struct dm_btree_value_type *vt, uint64_t key)
+				struct dm_btree_value_type *vt, uint64_t key)
 {
 	int r;
 	unsigned int middle_index;
@@ -781,7 +781,7 @@ static int split_two_into_three(struct shadow_spine *s, unsigned int parent_inde
 		if (shadow_current(s) != right)
 			unlock_block(s->info, right);
 
-	        return r;
+		return r;
 	}
 
 
@@ -1216,7 +1216,7 @@ int btree_get_overwrite_leaf(struct dm_btree_info *info, dm_block_t root,
 static bool need_insert(struct btree_node *node, uint64_t *keys,
 			unsigned int level, unsigned int index)
 {
-        return ((index >= le32_to_cpu(node->header.nr_entries)) ||
+	return ((index >= le32_to_cpu(node->header.nr_entries)) ||
 		(le64_to_cpu(node->keys[index]) != keys[level]));
 }
 
diff --git a/drivers/md/persistent-data/dm-space-map-common.c b/drivers/md/persistent-data/dm-space-map-common.c
index af800efed9f3c..4833a3998c1d9 100644
--- a/drivers/md/persistent-data/dm-space-map-common.c
+++ b/drivers/md/persistent-data/dm-space-map-common.c
@@ -390,7 +390,7 @@ int sm_ll_find_free_block(struct ll_disk *ll, dm_block_t begin,
 }
 
 int sm_ll_find_common_free_block(struct ll_disk *old_ll, struct ll_disk *new_ll,
-	                         dm_block_t begin, dm_block_t end, dm_block_t *b)
+				 dm_block_t begin, dm_block_t end, dm_block_t *b)
 {
 	int r;
 	uint32_t count;
diff --git a/drivers/md/persistent-data/dm-space-map-common.h b/drivers/md/persistent-data/dm-space-map-common.h
index 706ceb85d6800..63d9a72e3265c 100644
--- a/drivers/md/persistent-data/dm-space-map-common.h
+++ b/drivers/md/persistent-data/dm-space-map-common.h
@@ -120,7 +120,7 @@ int sm_ll_lookup(struct ll_disk *ll, dm_block_t b, uint32_t *result);
 int sm_ll_find_free_block(struct ll_disk *ll, dm_block_t begin,
 			  dm_block_t end, dm_block_t *result);
 int sm_ll_find_common_free_block(struct ll_disk *old_ll, struct ll_disk *new_ll,
-	                         dm_block_t begin, dm_block_t end, dm_block_t *result);
+				 dm_block_t begin, dm_block_t end, dm_block_t *result);
 
 /*
  * The next three functions return (via nr_allocations) the net number of
-- 
2.43.0


