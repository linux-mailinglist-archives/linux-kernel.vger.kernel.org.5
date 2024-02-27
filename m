Return-Path: <linux-kernel+bounces-83032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6E1868D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6FC1F221A3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDC61384AD;
	Tue, 27 Feb 2024 10:28:35 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D476136647;
	Tue, 27 Feb 2024 10:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029714; cv=none; b=TslRty9NekQzpyq5sb5amxe8XGEBkSp95RCvR4RuZ53yHzmIZXQ70n3I4+6GAReZT/l1I3bgkSBwFx6Ji3uEmssqiu0Es/BmEeT66J7IqPUzM8XpyO2SgA/H/b9xH6OrNKSfSjHd+t1depbYRd9TuqUyugySO0jVdZ1VgY1pd6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029714; c=relaxed/simple;
	bh=0Gh1B/g232P8l864mjhfxWMXA7q/alNOrw3DD2l0faY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IoSwMO6iWjw5dH6SElHo+tv7QfLrgmW20X9gXd6pgJaKdbHJ29O/Lla13cLMDjFiEAxBsKp+fLkFxmOoa8DdXtJakubE38eOqV/iVPcdJ7Re2f7aMiAOETx7QonmlcgZgninA7r/2EglauEcwQ+8O71MiqGmt2xLyEYnUvBR0gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from lijuan-ubuntu-04.home.arpa (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowACHjp6Bt91lwfN_Aw--.2900S2;
	Tue, 27 Feb 2024 18:20:49 +0800 (CST)
From: lilijuan@iscas.ac.cn
To: kent.overstreet@linux.dev
Cc: bfoster@redhat.com,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn,
	Lijuan Li <lilijuan@iscas.ac.cn>
Subject: [PATCH] bcachefs: mark some of the functions in the bcachefs directory static
Date: Tue, 27 Feb 2024 18:20:35 +0800
Message-Id: <20240227102035.537903-1-lilijuan@iscas.ac.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHjp6Bt91lwfN_Aw--.2900S2
X-Coremail-Antispam: 1UD129KBjvAXoWfWw1xJr4xXry7WF4rur1fCrg_yoW5Xr4xGo
	Zaya17ArnYkFWkXrW5Kwn3JF98ur98tw45XF4YgrsrXa4Fy3yUWFy3Jay5GF17Wa1rKrW0
	vF15ua1DXry7X34xn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY47AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xx
	MxkIecxEwVAFwVW8twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
	7VUjt8n7UUUUU==
X-CM-SenderInfo: poloxyxxdqqxpvfd2hldfou0/

From: Lijuan Li <lilijuan@iscas.ac.cn>

The modified functions are only used in the .c files
in which they are defined, so mark them static.

Signed-off-by: Lijuan Li <lilijuan@iscas.ac.cn>
---
 fs/bcachefs/bkey.c               | 2 +-
 fs/bcachefs/bkey.h               | 4 ----
 fs/bcachefs/bkey_methods.c       | 6 +++---
 fs/bcachefs/bkey_methods.h       | 4 ----
 fs/bcachefs/btree_journal_iter.c | 2 +-
 fs/bcachefs/btree_journal_iter.h | 2 --
 fs/bcachefs/btree_types.h        | 2 --
 fs/bcachefs/btree_write_buffer.c | 2 +-
 fs/bcachefs/btree_write_buffer.h | 1 -
 fs/bcachefs/buckets.c            | 2 +-
 fs/bcachefs/buckets.h            | 2 --
 fs/bcachefs/checksum.c           | 4 ++--
 fs/bcachefs/checksum.h           | 4 ----
 fs/bcachefs/clock.c              | 4 ++--
 fs/bcachefs/clock.h              | 2 --
 fs/bcachefs/disk_groups.c        | 2 +-
 fs/bcachefs/disk_groups.h        | 2 --
 fs/bcachefs/extent_update.c      | 2 +-
 fs/bcachefs/extent_update.h      | 2 --
 fs/bcachefs/fs-io.c              | 2 +-
 fs/bcachefs/fs-io.h              | 4 ----
 fs/bcachefs/journal_io.c         | 2 +-
 fs/bcachefs/journal_io.h         | 3 ---
 fs/bcachefs/lru.c                | 2 +-
 fs/bcachefs/lru.h                | 1 -
 fs/bcachefs/move.c               | 2 +-
 fs/bcachefs/move.h               | 2 --
 fs/bcachefs/opts.c               | 4 ++--
 fs/bcachefs/opts.h               | 2 --
 fs/bcachefs/sb-clean.c           | 2 +-
 fs/bcachefs/sb-clean.h           | 1 -
 fs/bcachefs/sb-counters.c        | 2 +-
 fs/bcachefs/sb-counters.h        | 1 -
 fs/bcachefs/snapshot.c           | 6 +++---
 fs/bcachefs/snapshot.h           | 4 ----
 fs/bcachefs/subvolume.h          | 1 -
 fs/bcachefs/super-io.c           | 4 ++--
 fs/bcachefs/super-io.h           | 2 --
 fs/bcachefs/util.c               | 4 ++--
 fs/bcachefs/util.h               | 2 --
 40 files changed, 28 insertions(+), 76 deletions(-)

diff --git a/fs/bcachefs/bkey.c b/fs/bcachefs/bkey.c
index 76e79a15ba08..60de858cd599 100644
--- a/fs/bcachefs/bkey.c
+++ b/fs/bcachefs/bkey.c
@@ -9,7 +9,7 @@
 
 const struct bkey_format bch2_bkey_format_current = BKEY_FORMAT_CURRENT;
 
-void bch2_bkey_packed_to_binary_text(struct printbuf *out,
+static void bch2_bkey_packed_to_binary_text(struct printbuf *out,
 				     const struct bkey_format *f,
 				     const struct bkey_packed *k)
 {
diff --git a/fs/bcachefs/bkey.h b/fs/bcachefs/bkey.h
index 831be01809f2..fc5c6627dcf2 100644
--- a/fs/bcachefs/bkey.h
+++ b/fs/bcachefs/bkey.h
@@ -27,10 +27,6 @@ enum bkey_invalid_flags {
 #endif
 #endif
 
-void bch2_bkey_packed_to_binary_text(struct printbuf *,
-				     const struct bkey_format *,
-				     const struct bkey_packed *);
-
 /* bkey with split value, const */
 struct bkey_s_c {
 	const struct bkey	*k;
diff --git a/fs/bcachefs/bkey_methods.c b/fs/bcachefs/bkey_methods.c
index 5e52684764eb..8939aef69598 100644
--- a/fs/bcachefs/bkey_methods.c
+++ b/fs/bcachefs/bkey_methods.c
@@ -152,7 +152,7 @@ static u64 bch2_key_types_allowed[] = {
 #undef x
 };
 
-const char *bch2_btree_node_type_str(enum btree_node_type type)
+static const char *bch2_btree_node_type_str(enum btree_node_type type)
 {
 	return type == BKEY_TYPE_btree ? "internal btree node" : bch2_btree_id_str(type - 1);
 }
@@ -307,7 +307,7 @@ void bch2_bkey_val_to_text(struct printbuf *out, struct bch_fs *c,
 	}
 }
 
-void bch2_bkey_swab_val(struct bkey_s k)
+static void bch2_bkey_swab_val(struct bkey_s k)
 {
 	const struct bkey_ops *ops = bch2_bkey_type_ops(k.k->type);
 
@@ -354,7 +354,7 @@ static const struct old_bkey_type {
 	{BKEY_TYPE_quotas,	128, KEY_TYPE_quota		},
 };
 
-void bch2_bkey_renumber(enum btree_node_type btree_node_type,
+static void bch2_bkey_renumber(enum btree_node_type btree_node_type,
 			struct bkey_packed *k,
 			int write)
 {
diff --git a/fs/bcachefs/bkey_methods.h b/fs/bcachefs/bkey_methods.h
index 03efe8ee565a..21972af2c157 100644
--- a/fs/bcachefs/bkey_methods.h
+++ b/fs/bcachefs/bkey_methods.h
@@ -63,8 +63,6 @@ void bch2_val_to_text(struct printbuf *, struct bch_fs *,
 void bch2_bkey_val_to_text(struct printbuf *, struct bch_fs *,
 			   struct bkey_s_c);
 
-void bch2_bkey_swab_val(struct bkey_s);
-
 bool bch2_bkey_normalize(struct bch_fs *, struct bkey_s);
 
 static inline bool bch2_bkey_maybe_mergable(const struct bkey *l, const struct bkey *r)
@@ -160,8 +158,6 @@ static inline int bch2_key_trigger_new(struct btree_trans *trans,
 				BTREE_TRIGGER_INSERT|flags);
 }
 
-void bch2_bkey_renumber(enum btree_node_type, struct bkey_packed *, int);
-
 void __bch2_bkey_compat(unsigned, enum btree_id, unsigned, unsigned,
 			int, struct bkey_format *, struct bkey_packed *);
 
diff --git a/fs/bcachefs/btree_journal_iter.c b/fs/bcachefs/btree_journal_iter.c
index 207dd32e2ecc..e837813e25d3 100644
--- a/fs/bcachefs/btree_journal_iter.c
+++ b/fs/bcachefs/btree_journal_iter.c
@@ -440,7 +440,7 @@ void bch2_btree_and_journal_iter_init_node_iter(struct btree_trans *trans,
 
 /* sort and dedup all keys in the journal: */
 
-void bch2_journal_entries_free(struct bch_fs *c)
+static void bch2_journal_entries_free(struct bch_fs *c)
 {
 	struct journal_replay **i;
 	struct genradix_iter iter;
diff --git a/fs/bcachefs/btree_journal_iter.h b/fs/bcachefs/btree_journal_iter.h
index c9d19da3ea04..f398f9fb8be4 100644
--- a/fs/bcachefs/btree_journal_iter.h
+++ b/fs/bcachefs/btree_journal_iter.h
@@ -62,8 +62,6 @@ static inline void bch2_journal_keys_put_initial(struct bch_fs *c)
 	c->journal_keys.initial_ref_held = false;
 }
 
-void bch2_journal_entries_free(struct bch_fs *);
-
 int bch2_journal_keys_sort(struct bch_fs *);
 
 #endif /* _BCACHEFS_BTREE_JOURNAL_ITER_H */
diff --git a/fs/bcachefs/btree_types.h b/fs/bcachefs/btree_types.h
index b2ebf143c3b7..9abc9319c2b3 100644
--- a/fs/bcachefs/btree_types.h
+++ b/fs/bcachefs/btree_types.h
@@ -652,8 +652,6 @@ static inline enum btree_node_type btree_node_type(struct btree *b)
 	return __btree_node_type(b->c.level, b->c.btree_id);
 }
 
-const char *bch2_btree_node_type_str(enum btree_node_type);
-
 #define BTREE_NODE_TYPE_HAS_TRANS_TRIGGERS		\
 	(BIT_ULL(BKEY_TYPE_extents)|			\
 	 BIT_ULL(BKEY_TYPE_alloc)|			\
diff --git a/fs/bcachefs/btree_write_buffer.c b/fs/bcachefs/btree_write_buffer.c
index b77e7b382b66..dc165f904605 100644
--- a/fs/bcachefs/btree_write_buffer.c
+++ b/fs/bcachefs/btree_write_buffer.c
@@ -442,7 +442,7 @@ int bch2_btree_write_buffer_flush_sync(struct btree_trans *trans)
 	return btree_write_buffer_flush_seq(trans, journal_cur_seq(&c->journal));
 }
 
-int bch2_btree_write_buffer_flush_nocheck_rw(struct btree_trans *trans)
+static int bch2_btree_write_buffer_flush_nocheck_rw(struct btree_trans *trans)
 {
 	struct bch_fs *c = trans->c;
 	struct btree_write_buffer *wb = &c->btree_write_buffer;
diff --git a/fs/bcachefs/btree_write_buffer.h b/fs/bcachefs/btree_write_buffer.h
index eebcd2b15249..73b6cce4e913 100644
--- a/fs/bcachefs/btree_write_buffer.h
+++ b/fs/bcachefs/btree_write_buffer.h
@@ -20,7 +20,6 @@ static inline bool bch2_btree_write_buffer_must_wait(struct bch_fs *c)
 
 struct btree_trans;
 int bch2_btree_write_buffer_flush_sync(struct btree_trans *);
-int bch2_btree_write_buffer_flush_nocheck_rw(struct btree_trans *);
 int bch2_btree_write_buffer_tryflush(struct btree_trans *);
 
 struct journal_keys_to_wb {
diff --git a/fs/bcachefs/buckets.c b/fs/bcachefs/buckets.c
index c2f46b267b3a..cb6385f8d4f6 100644
--- a/fs/bcachefs/buckets.c
+++ b/fs/bcachefs/buckets.c
@@ -98,7 +98,7 @@ void bch2_dev_usage_read_fast(struct bch_dev *ca, struct bch_dev_usage *usage)
 	} while (read_seqcount_retry(&c->usage_lock, seq));
 }
 
-u64 bch2_fs_usage_read_one(struct bch_fs *c, u64 *v)
+static u64 bch2_fs_usage_read_one(struct bch_fs *c, u64 *v)
 {
 	ssize_t offset = v - (u64 *) c->usage_base;
 	unsigned i, seq;
diff --git a/fs/bcachefs/buckets.h b/fs/bcachefs/buckets.h
index 6387e039f789..bcccdd61c2a9 100644
--- a/fs/bcachefs/buckets.h
+++ b/fs/bcachefs/buckets.h
@@ -288,8 +288,6 @@ static inline unsigned dev_usage_u64s(void)
 	return sizeof(struct bch_dev_usage) / sizeof(u64);
 }
 
-u64 bch2_fs_usage_read_one(struct bch_fs *, u64 *);
-
 struct bch_fs_usage_online *bch2_fs_usage_read(struct bch_fs *);
 
 void bch2_fs_usage_acc_to_base(struct bch_fs *, unsigned);
diff --git a/fs/bcachefs/checksum.c b/fs/bcachefs/checksum.c
index 4701457f6381..3a06c73dfae7 100644
--- a/fs/bcachefs/checksum.c
+++ b/fs/bcachefs/checksum.c
@@ -152,7 +152,7 @@ static inline int do_encrypt(struct crypto_sync_skcipher *tfm,
 	}
 }
 
-int bch2_chacha_encrypt_key(struct bch_key *key, struct nonce nonce,
+static int bch2_chacha_encrypt_key(struct bch_key *key, struct nonce nonce,
 			    void *buf, size_t len)
 {
 	struct crypto_sync_skcipher *chacha20 =
@@ -608,7 +608,7 @@ int bch2_revoke_key(struct bch_sb *sb)
 }
 #endif
 
-int bch2_decrypt_sb_key(struct bch_fs *c,
+static int bch2_decrypt_sb_key(struct bch_fs *c,
 			struct bch_sb_field_crypt *crypt,
 			struct bch_key *key)
 {
diff --git a/fs/bcachefs/checksum.h b/fs/bcachefs/checksum.h
index 1b8c2c1016dc..ecf32796436d 100644
--- a/fs/bcachefs/checksum.h
+++ b/fs/bcachefs/checksum.h
@@ -68,7 +68,6 @@ static inline void bch2_csum_err_msg(struct printbuf *out,
 	prt_printf(out, " type %s", bch2_csum_types[type]);
 }
 
-int bch2_chacha_encrypt_key(struct bch_key *, struct nonce, void *, size_t);
 int bch2_request_key(struct bch_sb *, struct bch_key *);
 #ifndef __KERNEL__
 int bch2_revoke_key(struct bch_sb *);
@@ -99,9 +98,6 @@ static inline int bch2_encrypt_bio(struct bch_fs *c, unsigned type,
 
 extern const struct bch_sb_field_ops bch_sb_field_ops_crypt;
 
-int bch2_decrypt_sb_key(struct bch_fs *, struct bch_sb_field_crypt *,
-			struct bch_key *);
-
 int bch2_disable_encryption(struct bch_fs *);
 int bch2_enable_encryption(struct bch_fs *, bool);
 
diff --git a/fs/bcachefs/clock.c b/fs/bcachefs/clock.c
index 363644451106..12f5a7dc72e7 100644
--- a/fs/bcachefs/clock.c
+++ b/fs/bcachefs/clock.c
@@ -13,7 +13,7 @@ static inline long io_timer_cmp(io_timer_heap *h,
 	return l->expire - r->expire;
 }
 
-void bch2_io_timer_add(struct io_clock *clock, struct io_timer *timer)
+static void bch2_io_timer_add(struct io_clock *clock, struct io_timer *timer)
 {
 	size_t i;
 
@@ -35,7 +35,7 @@ void bch2_io_timer_add(struct io_clock *clock, struct io_timer *timer)
 	spin_unlock(&clock->timer_lock);
 }
 
-void bch2_io_timer_del(struct io_clock *clock, struct io_timer *timer)
+static void bch2_io_timer_del(struct io_clock *clock, struct io_timer *timer)
 {
 	size_t i;
 
diff --git a/fs/bcachefs/clock.h b/fs/bcachefs/clock.h
index 70a0f7436c84..41627a2952b0 100644
--- a/fs/bcachefs/clock.h
+++ b/fs/bcachefs/clock.h
@@ -2,8 +2,6 @@
 #ifndef _BCACHEFS_CLOCK_H
 #define _BCACHEFS_CLOCK_H
 
-void bch2_io_timer_add(struct io_clock *, struct io_timer *);
-void bch2_io_timer_del(struct io_clock *, struct io_timer *);
 void bch2_kthread_io_clock_wait(struct io_clock *, unsigned long,
 				unsigned long);
 
diff --git a/fs/bcachefs/disk_groups.c b/fs/bcachefs/disk_groups.c
index 06a7df529b40..0ecf927472bb 100644
--- a/fs/bcachefs/disk_groups.c
+++ b/fs/bcachefs/disk_groups.c
@@ -330,7 +330,7 @@ static int __bch2_disk_group_add(struct bch_sb_handle *sb, unsigned parent,
 	return i;
 }
 
-int bch2_disk_path_find(struct bch_sb_handle *sb, const char *name)
+static int bch2_disk_path_find(struct bch_sb_handle *sb, const char *name)
 {
 	struct bch_sb_field_disk_groups *groups =
 		bch2_sb_field_get(sb->sb, disk_groups);
diff --git a/fs/bcachefs/disk_groups.h b/fs/bcachefs/disk_groups.h
index 441826fff224..5e435441af76 100644
--- a/fs/bcachefs/disk_groups.h
+++ b/fs/bcachefs/disk_groups.h
@@ -80,8 +80,6 @@ static inline bool bch2_target_accepts_data(struct bch_fs *c,
 
 bool bch2_dev_in_target(struct bch_fs *, unsigned, unsigned);
 
-int bch2_disk_path_find(struct bch_sb_handle *, const char *);
-
 /* Exported for userspace bcachefs-tools: */
 int bch2_disk_path_find_or_create(struct bch_sb_handle *, const char *);
 
diff --git a/fs/bcachefs/extent_update.c b/fs/bcachefs/extent_update.c
index b9033bb4f11c..50f51ae0922d 100644
--- a/fs/bcachefs/extent_update.c
+++ b/fs/bcachefs/extent_update.c
@@ -102,7 +102,7 @@ static int count_iters_for_insert(struct btree_trans *trans,
 
 #define EXTENT_ITERS_MAX	(BTREE_ITER_INITIAL / 3)
 
-int bch2_extent_atomic_end(struct btree_trans *trans,
+static int bch2_extent_atomic_end(struct btree_trans *trans,
 			   struct btree_iter *iter,
 			   struct bkey_i *insert,
 			   struct bpos *end)
diff --git a/fs/bcachefs/extent_update.h b/fs/bcachefs/extent_update.h
index 6f5cf449361a..2d956d971b11 100644
--- a/fs/bcachefs/extent_update.h
+++ b/fs/bcachefs/extent_update.h
@@ -4,8 +4,6 @@
 
 #include "bcachefs.h"
 
-int bch2_extent_atomic_end(struct btree_trans *, struct btree_iter *,
-			   struct bkey_i *, struct bpos *);
 int bch2_extent_trim_atomic(struct btree_trans *, struct btree_iter *,
 			    struct bkey_i *);
 
diff --git a/fs/bcachefs/fs-io.c b/fs/bcachefs/fs-io.c
index 8c70123b6a0c..3b99ab555229 100644
--- a/fs/bcachefs/fs-io.c
+++ b/fs/bcachefs/fs-io.c
@@ -128,7 +128,7 @@ static int inode_set_size(struct btree_trans *trans,
 	return 0;
 }
 
-int __must_check bch2_write_inode_size(struct bch_fs *c,
+static int __must_check bch2_write_inode_size(struct bch_fs *c,
 				       struct bch_inode_info *inode,
 				       loff_t new_size, unsigned fields)
 {
diff --git a/fs/bcachefs/fs-io.h b/fs/bcachefs/fs-io.h
index ca70346e68dc..b90124246e15 100644
--- a/fs/bcachefs/fs-io.h
+++ b/fs/bcachefs/fs-io.h
@@ -159,10 +159,6 @@ static inline bool fdm_dropped_locks(void)
 void bch2_inode_flush_nocow_writes_async(struct bch_fs *,
 			struct bch_inode_info *, struct closure *);
 
-int __must_check bch2_write_inode_size(struct bch_fs *,
-				       struct bch_inode_info *,
-				       loff_t, unsigned);
-
 int bch2_fsync(struct file *, loff_t, loff_t, int);
 
 int bchfs_truncate(struct mnt_idmap *,
diff --git a/fs/bcachefs/journal_io.c b/fs/bcachefs/journal_io.c
index b37b75ccd602..83436385e313 100644
--- a/fs/bcachefs/journal_io.c
+++ b/fs/bcachefs/journal_io.c
@@ -17,7 +17,7 @@
 #include "sb-clean.h"
 #include "trace.h"
 
-void bch2_journal_ptrs_to_text(struct printbuf *out, struct bch_fs *c,
+static void bch2_journal_ptrs_to_text(struct printbuf *out, struct bch_fs *c,
 			       struct journal_replay *j)
 {
 	darray_for_each(j->ptrs, i) {
diff --git a/fs/bcachefs/journal_io.h b/fs/bcachefs/journal_io.h
index 59790456d58c..789240711c06 100644
--- a/fs/bcachefs/journal_io.h
+++ b/fs/bcachefs/journal_io.h
@@ -58,9 +58,6 @@ int bch2_journal_entry_validate(struct bch_fs *, struct jset *,
 void bch2_journal_entry_to_text(struct printbuf *, struct bch_fs *,
 				struct jset_entry *);
 
-void bch2_journal_ptrs_to_text(struct printbuf *, struct bch_fs *,
-			       struct journal_replay *);
-
 int bch2_journal_read(struct bch_fs *, u64 *, u64 *, u64 *);
 
 CLOSURE_CALLBACK(bch2_journal_write);
diff --git a/fs/bcachefs/lru.c b/fs/bcachefs/lru.c
index ed7577cdb212..fa9daab5ffb8 100644
--- a/fs/bcachefs/lru.c
+++ b/fs/bcachefs/lru.c
@@ -49,7 +49,7 @@ static int __bch2_lru_set(struct btree_trans *trans, u16 lru_id,
 		: 0;
 }
 
-int bch2_lru_del(struct btree_trans *trans, u16 lru_id, u64 dev_bucket, u64 time)
+static int bch2_lru_del(struct btree_trans *trans, u16 lru_id, u64 dev_bucket, u64 time)
 {
 	return __bch2_lru_set(trans, lru_id, dev_bucket, time, KEY_TYPE_deleted);
 }
diff --git a/fs/bcachefs/lru.h b/fs/bcachefs/lru.h
index 429dca816df5..22485f4bd031 100644
--- a/fs/bcachefs/lru.h
+++ b/fs/bcachefs/lru.h
@@ -60,7 +60,6 @@ void bch2_lru_pos_to_text(struct printbuf *, struct bpos);
 	.min_val_size	= 8,			\
 })
 
-int bch2_lru_del(struct btree_trans *, u16, u64, u64);
 int bch2_lru_set(struct btree_trans *, u16, u64, u64);
 int bch2_lru_change(struct btree_trans *, u16, u64, u64, u64);
 
diff --git a/fs/bcachefs/move.c b/fs/bcachefs/move.c
index bf68ea49447b..0160bd95d9f0 100644
--- a/fs/bcachefs/move.c
+++ b/fs/bcachefs/move.c
@@ -409,7 +409,7 @@ int bch2_move_extent(struct moving_context *ctxt,
 	return ret;
 }
 
-struct bch_io_opts *bch2_move_get_io_opts(struct btree_trans *trans,
+static struct bch_io_opts *bch2_move_get_io_opts(struct btree_trans *trans,
 			  struct per_snapshot_io_opts *io_opts,
 			  struct bkey_s_c extent_k)
 {
diff --git a/fs/bcachefs/move.h b/fs/bcachefs/move.h
index 9baf3093a678..6802feac4dda 100644
--- a/fs/bcachefs/move.h
+++ b/fs/bcachefs/move.h
@@ -110,8 +110,6 @@ static inline void per_snapshot_io_opts_exit(struct per_snapshot_io_opts *io_opt
 	darray_exit(&io_opts->d);
 }
 
-struct bch_io_opts *bch2_move_get_io_opts(struct btree_trans *,
-				struct per_snapshot_io_opts *, struct bkey_s_c);
 int bch2_move_get_io_opts_one(struct btree_trans *, struct bch_io_opts *, struct bkey_s_c);
 
 int bch2_scan_old_btree_nodes(struct bch_fs *, struct bch_move_stats *);
diff --git a/fs/bcachefs/opts.c b/fs/bcachefs/opts.c
index b1ed0b9a20d3..bb6b4c26e6b4 100644
--- a/fs/bcachefs/opts.c
+++ b/fs/bcachefs/opts.c
@@ -143,7 +143,7 @@ u64 BCH2_NO_SB_OPT(const struct bch_sb *sb)
 	BUG();
 }
 
-void SET_BCH2_NO_SB_OPT(struct bch_sb *sb, u64 v)
+static void SET_BCH2_NO_SB_OPT(struct bch_sb *sb, u64 v)
 {
 	BUG();
 }
@@ -549,7 +549,7 @@ int bch2_opts_from_sb(struct bch_opts *opts, struct bch_sb *sb)
 	return 0;
 }
 
-void __bch2_opt_set_sb(struct bch_sb *sb, const struct bch_option *opt, u64 v)
+static void __bch2_opt_set_sb(struct bch_sb *sb, const struct bch_option *opt, u64 v)
 {
 	if (opt->set_sb == SET_BCH2_NO_SB_OPT)
 		return;
diff --git a/fs/bcachefs/opts.h b/fs/bcachefs/opts.h
index f8c2341e8d3d..4fc0e6faaed0 100644
--- a/fs/bcachefs/opts.h
+++ b/fs/bcachefs/opts.h
@@ -47,7 +47,6 @@ static inline const char *bch2_d_type_str(unsigned d_type)
 
 /* dummy option, for options that aren't stored in the superblock */
 u64 BCH2_NO_SB_OPT(const struct bch_sb *);
-void SET_BCH2_NO_SB_OPT(struct bch_sb *, u64);
 
 /* When can be set: */
 enum opt_flags {
@@ -543,7 +542,6 @@ void bch2_opt_set_by_id(struct bch_opts *, enum bch_opt_id, u64);
 
 u64 bch2_opt_from_sb(struct bch_sb *, enum bch_opt_id);
 int bch2_opts_from_sb(struct bch_opts *, struct bch_sb *);
-void __bch2_opt_set_sb(struct bch_sb *, const struct bch_option *, u64);
 void bch2_opt_set_sb(struct bch_fs *, const struct bch_option *, u64);
 
 int bch2_opt_lookup(const char *);
diff --git a/fs/bcachefs/sb-clean.c b/fs/bcachefs/sb-clean.c
index 5980ba2563fe..00685ce8c7d3 100644
--- a/fs/bcachefs/sb-clean.c
+++ b/fs/bcachefs/sb-clean.c
@@ -20,7 +20,7 @@
  * as they would be in the journal:
  */
 
-int bch2_sb_clean_validate_late(struct bch_fs *c, struct bch_sb_field_clean *clean,
+static int bch2_sb_clean_validate_late(struct bch_fs *c, struct bch_sb_field_clean *clean,
 				int write)
 {
 	struct jset_entry *entry;
diff --git a/fs/bcachefs/sb-clean.h b/fs/bcachefs/sb-clean.h
index 71caef281239..2cba6a5ce39c 100644
--- a/fs/bcachefs/sb-clean.h
+++ b/fs/bcachefs/sb-clean.h
@@ -2,7 +2,6 @@
 #ifndef _BCACHEFS_SB_CLEAN_H
 #define _BCACHEFS_SB_CLEAN_H
 
-int bch2_sb_clean_validate_late(struct bch_fs *, struct bch_sb_field_clean *, int);
 int bch2_verify_superblock_clean(struct bch_fs *, struct bch_sb_field_clean **,
 				 struct jset *);
 struct bch_sb_field_clean *bch2_read_superblock_clean(struct bch_fs *);
diff --git a/fs/bcachefs/sb-counters.c b/fs/bcachefs/sb-counters.c
index 7dc898761bb3..1f9e79499270 100644
--- a/fs/bcachefs/sb-counters.c
+++ b/fs/bcachefs/sb-counters.c
@@ -46,7 +46,7 @@ static void bch2_sb_counters_to_text(struct printbuf *out, struct bch_sb *sb,
 	}
 };
 
-int bch2_sb_counters_to_cpu(struct bch_fs *c)
+static int bch2_sb_counters_to_cpu(struct bch_fs *c)
 {
 	struct bch_sb_field_counters *ctrs = bch2_sb_field_get(c->disk_sb.sb, counters);
 	unsigned int i;
diff --git a/fs/bcachefs/sb-counters.h b/fs/bcachefs/sb-counters.h
index 81f8aec9fcb1..f61aafc6b205 100644
--- a/fs/bcachefs/sb-counters.h
+++ b/fs/bcachefs/sb-counters.h
@@ -5,7 +5,6 @@
 #include "bcachefs.h"
 #include "super-io.h"
 
-int bch2_sb_counters_to_cpu(struct bch_fs *);
 int bch2_sb_counters_from_cpu(struct bch_fs *);
 
 void bch2_fs_counters_exit(struct bch_fs *);
diff --git a/fs/bcachefs/snapshot.c b/fs/bcachefs/snapshot.c
index ac6ba04d5521..afc3bc53205d 100644
--- a/fs/bcachefs/snapshot.c
+++ b/fs/bcachefs/snapshot.c
@@ -55,7 +55,7 @@ int bch2_snapshot_tree_lookup(struct btree_trans *trans, u32 id,
 	return ret;
 }
 
-struct bkey_i_snapshot_tree *
+static struct bkey_i_snapshot_tree *
 __bch2_snapshot_tree_create(struct btree_trans *trans)
 {
 	struct btree_iter iter;
@@ -617,7 +617,7 @@ static int snapshot_tree_ptr_good(struct btree_trans *trans,
 	return bch2_snapshot_is_ancestor_early(trans->c, snap_id, le32_to_cpu(s_t.root_snapshot));
 }
 
-u32 bch2_snapshot_skiplist_get(struct bch_fs *c, u32 id)
+static u32 bch2_snapshot_skiplist_get(struct bch_fs *c, u32 id)
 {
 	const struct snapshot_t *s;
 
@@ -1359,7 +1359,7 @@ static int bch2_fix_child_of_deleted_snapshot(struct btree_trans *trans,
 	return bch2_trans_update(trans, iter, &s->k_i, 0);
 }
 
-int bch2_delete_dead_snapshots(struct bch_fs *c)
+static int bch2_delete_dead_snapshots(struct bch_fs *c)
 {
 	struct btree_trans *trans;
 	snapshot_id_list deleted = { 0 };
diff --git a/fs/bcachefs/snapshot.h b/fs/bcachefs/snapshot.h
index 7c66ffc06385..bf76996a20c4 100644
--- a/fs/bcachefs/snapshot.h
+++ b/fs/bcachefs/snapshot.h
@@ -14,8 +14,6 @@ int bch2_snapshot_tree_invalid(struct bch_fs *, struct bkey_s_c,
 	.min_val_size	= 8,					\
 })
 
-struct bkey_i_snapshot_tree *__bch2_snapshot_tree_create(struct btree_trans *);
-
 int bch2_snapshot_tree_lookup(struct btree_trans *, u32, struct bch_snapshot_tree *);
 
 void bch2_snapshot_to_text(struct printbuf *, struct bch_fs *, struct bkey_s_c);
@@ -100,8 +98,6 @@ static inline u32 bch2_snapshot_nth_parent(struct bch_fs *c, u32 id, u32 n)
 	return id;
 }
 
-u32 bch2_snapshot_skiplist_get(struct bch_fs *, u32);
-
 static inline u32 bch2_snapshot_root(struct bch_fs *c, u32 id)
 {
 	u32 parent;
diff --git a/fs/bcachefs/subvolume.h b/fs/bcachefs/subvolume.h
index 4045a180154a..6795328563be 100644
--- a/fs/bcachefs/subvolume.h
+++ b/fs/bcachefs/subvolume.h
@@ -30,7 +30,6 @@ int bch2_subvolume_get_snapshot(struct btree_trans *, u32, u32 *);
 int bch2_subvol_is_ro_trans(struct btree_trans *, u32);
 int bch2_subvol_is_ro(struct bch_fs *, u32);
 
-int bch2_delete_dead_snapshots(struct bch_fs *);
 void bch2_delete_dead_snapshots_async(struct bch_fs *);
 
 int bch2_subvolume_unlink(struct btree_trans *, u32);
diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
index c6d590404425..95857dfcd6d7 100644
--- a/fs/bcachefs/super-io.c
+++ b/fs/bcachefs/super-io.c
@@ -151,7 +151,7 @@ void bch2_free_super(struct bch_sb_handle *sb)
 	memset(sb, 0, sizeof(*sb));
 }
 
-int bch2_sb_realloc(struct bch_sb_handle *sb, unsigned u64s)
+static int bch2_sb_realloc(struct bch_sb_handle *sb, unsigned u64s)
 {
 	size_t new_bytes = __vstruct_bytes(struct bch_sb, u64s);
 	size_t new_buffer_size;
@@ -1226,7 +1226,7 @@ void bch2_sb_field_to_text(struct printbuf *out, struct bch_sb *sb,
 	__bch2_sb_field_to_text(out, sb, f);
 }
 
-void bch2_sb_layout_to_text(struct printbuf *out, struct bch_sb_layout *l)
+static void bch2_sb_layout_to_text(struct printbuf *out, struct bch_sb_layout *l)
 {
 	unsigned i;
 
diff --git a/fs/bcachefs/super-io.h b/fs/bcachefs/super-io.h
index f37620919e11..fd00bf78a35b 100644
--- a/fs/bcachefs/super-io.h
+++ b/fs/bcachefs/super-io.h
@@ -77,7 +77,6 @@ int bch2_sb_to_fs(struct bch_fs *, struct bch_sb *);
 int bch2_sb_from_fs(struct bch_fs *, struct bch_dev *);
 
 void bch2_free_super(struct bch_sb_handle *);
-int bch2_sb_realloc(struct bch_sb_handle *, unsigned);
 
 int bch2_read_super(const char *, struct bch_opts *, struct bch_sb_handle *);
 int bch2_read_super_silent(const char *, struct bch_opts *, struct bch_sb_handle *);
@@ -97,7 +96,6 @@ void __bch2_sb_field_to_text(struct printbuf *, struct bch_sb *,
 			     struct bch_sb_field *);
 void bch2_sb_field_to_text(struct printbuf *, struct bch_sb *,
 			   struct bch_sb_field *);
-void bch2_sb_layout_to_text(struct printbuf *, struct bch_sb_layout *);
 void bch2_sb_to_text(struct printbuf *, struct bch_sb *, bool, unsigned);
 
 #endif /* _BCACHEFS_SUPER_IO_H */
diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
index 098ebbe41c2e..4b8fd77adf12 100644
--- a/fs/bcachefs/util.c
+++ b/fs/bcachefs/util.c
@@ -272,7 +272,7 @@ void bch2_print_string_as_lines(const char *prefix, const char *lines)
 	console_unlock();
 }
 
-int bch2_save_backtrace(bch_stacktrace *stack, struct task_struct *task, unsigned skipnr,
+static int bch2_save_backtrace(bch_stacktrace *stack, struct task_struct *task, unsigned skipnr,
 			gfp_t gfp)
 {
 #ifdef CONFIG_STACKTRACE
@@ -300,7 +300,7 @@ int bch2_save_backtrace(bch_stacktrace *stack, struct task_struct *task, unsigne
 #endif
 }
 
-void bch2_prt_backtrace(struct printbuf *out, bch_stacktrace *stack)
+static void bch2_prt_backtrace(struct printbuf *out, bch_stacktrace *stack)
 {
 	darray_for_each(*stack, i) {
 		prt_printf(out, "[<0>] %pB", (void *) *i);
diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
index c5fec87d8ecc..b7bd760d90fd 100644
--- a/fs/bcachefs/util.h
+++ b/fs/bcachefs/util.h
@@ -315,8 +315,6 @@ void bch2_prt_u64_base2(struct printbuf *, u64);
 void bch2_print_string_as_lines(const char *prefix, const char *lines);
 
 typedef DARRAY(unsigned long) bch_stacktrace;
-int bch2_save_backtrace(bch_stacktrace *stack, struct task_struct *, unsigned, gfp_t);
-void bch2_prt_backtrace(struct printbuf *, bch_stacktrace *);
 int bch2_prt_task_backtrace(struct printbuf *, struct task_struct *, unsigned, gfp_t);
 
 static inline void prt_bdevname(struct printbuf *out, struct block_device *bdev)
-- 
2.40.1


