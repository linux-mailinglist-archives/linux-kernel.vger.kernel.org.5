Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D1C79C9D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjILIZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjILIZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:25:34 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBBAE7F;
        Tue, 12 Sep 2023 01:25:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40037db2fe7so57251775e9.0;
        Tue, 12 Sep 2023 01:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694507128; x=1695111928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D7De/Z5pdwojJ2jszAuU+85kLqgXihOlwaZjwgP1sxA=;
        b=K0nC4cL9QHO/D+jpgh21Y7d4L0zCmbRkDb0vg2gV15UqJuRwmOO073cETS92VatcD3
         G8oaHAyhQm305CrOeLGGtl9SjmmTyRCpStOLWk8ruWrL3mkd8xjYZRbGC41+rv6GGlIj
         asHm5aKm+YgHUnF0Z/bApVRMJw95fP8oAuIMxNZoWRAOTSgqAaBc4zwH02PSEMxURfRT
         HzAAhZmyjKm/0mXmDrsZjki19e2ohggfiQCUUsme2JVx4jK+TxFmq6wfObK3Gajwpm0c
         EaLWWivLsv+ucRYAVxKcJhI0wHdbS3voJJ08SG8gAXhtWDzOk5qjabqVty/POvqB2jUr
         FaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694507128; x=1695111928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7De/Z5pdwojJ2jszAuU+85kLqgXihOlwaZjwgP1sxA=;
        b=wzvgARlOz60ciXOuvrfgGmtY8OaSwvqR+z4oWMwgT92BOVgU9w163QnU6Au0ecnOq4
         CDhY9bNGJr3Whagu9PPTNlbLepumPIwoqdBYzd2QGZgIG77eSHlmvlgDD+6ti56jKw+Z
         Dibh3WsMFyMJ7t1JRovR6TUzTSUvYTVYSipLDufztyLlXY7gXD/uk+TP3phH+eZ6l4gA
         8PLUqgMALr6Ue7R69wcttTqm9l32mTt1Tiix0pYso4aDKUM2lS2XSjLUtSAWrySwPmky
         owppRyrEVqt1ZISSqrXd3+OM5XoMGWyPhB9engyoGaFqaZnT1cQXmxwWwn5LV83cQJ8w
         H6wg==
X-Gm-Message-State: AOJu0YxxLqCcxAeQWa2Opg0v5hIQOiJ0VDyjl5z8mew7xkRJctKo20QH
        EWmUt3E6B9xLaxloMKX2vpJP8IssANvhdw==
X-Google-Smtp-Source: AGHT+IEmyam1ZgZag5nPuvuHC8kshNWVtdrwUjXTCwVabXtYAaVg/+h0lBIGOMko+UCiW5dNL2eW6A==
X-Received: by 2002:a5d:6a03:0:b0:314:1e47:8bc2 with SMTP id m3-20020a5d6a03000000b003141e478bc2mr9505317wru.0.1694507128342;
        Tue, 12 Sep 2023 01:25:28 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o21-20020adfa115000000b0031f9bdb79dasm6749997wro.61.2023.09.12.01.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 01:25:27 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>,
        linux-bcachefs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] bcachefs: Fix a handful of spelling mistakes in various messages
Date:   Tue, 12 Sep 2023 09:25:27 +0100
Message-Id: <20230912082527.3913330-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several spelling mistakes in error messages. Fix these.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/bcachefs/alloc_background.c | 2 +-
 fs/bcachefs/backpointers.c     | 2 +-
 fs/bcachefs/btree_iter.c       | 2 +-
 fs/bcachefs/fsck.c             | 2 +-
 fs/bcachefs/recovery.c         | 2 +-
 fs/bcachefs/snapshot.c         | 2 +-
 fs/bcachefs/super-io.c         | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/bcachefs/alloc_background.c b/fs/bcachefs/alloc_background.c
index 540d94c0cceb..dd9f3cbace1e 100644
--- a/fs/bcachefs/alloc_background.c
+++ b/fs/bcachefs/alloc_background.c
@@ -1247,7 +1247,7 @@ static noinline_for_stack int __bch2_check_discard_freespace_key(struct btree_tr
 		return ret;
 
 	if (fsck_err_on(!bch2_dev_bucket_exists(c, pos), c,
-			"entry in %s btree for nonexistant dev:bucket %llu:%llu",
+			"entry in %s btree for non-existent dev:bucket %llu:%llu",
 			bch2_btree_ids[iter->btree_id], pos.inode, pos.offset))
 		goto delete;
 
diff --git a/fs/bcachefs/backpointers.c b/fs/bcachefs/backpointers.c
index 8747c5e19f99..bec62e5b21e5 100644
--- a/fs/bcachefs/backpointers.c
+++ b/fs/bcachefs/backpointers.c
@@ -357,7 +357,7 @@ static int bch2_check_btree_backpointer(struct btree_trans *trans, struct btree_
 	int ret = 0;
 
 	if (fsck_err_on(!bch2_dev_exists2(c, k.k->p.inode), c,
-			"backpointer for mising device:\n%s",
+			"backpointer for missing device:\n%s",
 			(bch2_bkey_val_to_text(&buf, c, k), buf.buf))) {
 		ret = bch2_btree_delete_at(trans, bp_iter, 0);
 		goto out;
diff --git a/fs/bcachefs/btree_iter.c b/fs/bcachefs/btree_iter.c
index 1dbb4d7dfb45..8d089bbdb1e5 100644
--- a/fs/bcachefs/btree_iter.c
+++ b/fs/bcachefs/btree_iter.c
@@ -1495,7 +1495,7 @@ static void bch2_trans_update_max_paths(struct btree_trans *trans)
 static noinline void btree_path_overflow(struct btree_trans *trans)
 {
 	bch2_dump_trans_paths_updates(trans);
-	panic("trans path oveflow\n");
+	panic("trans path overflow\n");
 }
 
 static inline struct btree_path *btree_path_alloc(struct btree_trans *trans,
diff --git a/fs/bcachefs/fsck.c b/fs/bcachefs/fsck.c
index 238caeeaf06c..cc04d5a22f40 100644
--- a/fs/bcachefs/fsck.c
+++ b/fs/bcachefs/fsck.c
@@ -80,7 +80,7 @@ static int __snapshot_lookup_subvol(struct btree_trans *trans, u32 snapshot,
 	if (!ret)
 		*subvol = le32_to_cpu(s.subvol);
 	else if (bch2_err_matches(ret, ENOENT))
-		bch_err(trans->c, "snapshot %u not fonud", snapshot);
+		bch_err(trans->c, "snapshot %u not found", snapshot);
 	return ret;
 
 }
diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
index 30efb3c90560..a78f5d023ef2 100644
--- a/fs/bcachefs/recovery.c
+++ b/fs/bcachefs/recovery.c
@@ -561,7 +561,7 @@ static void check_version_upgrade(struct bch_fs *c)
 			if ((recovery_passes & RECOVERY_PASS_ALL_FSCK) == RECOVERY_PASS_ALL_FSCK)
 				prt_str(&buf, "fsck required");
 			else {
-				prt_str(&buf, "running recovery passses: ");
+				prt_str(&buf, "running recovery passes: ");
 				prt_bitflags(&buf, bch2_recovery_passes, recovery_passes);
 			}
 
diff --git a/fs/bcachefs/snapshot.c b/fs/bcachefs/snapshot.c
index 9da09911466e..c2af574acb7c 100644
--- a/fs/bcachefs/snapshot.c
+++ b/fs/bcachefs/snapshot.c
@@ -1385,7 +1385,7 @@ int bch2_delete_dead_snapshots(struct bch_fs *c)
 	if (!test_bit(BCH_FS_STARTED, &c->flags)) {
 		ret = bch2_fs_read_write_early(c);
 		if (ret) {
-			bch_err(c, "error deleleting dead snapshots: error going rw: %s", bch2_err_str(ret));
+			bch_err(c, "error deleting dead snapshots: error going rw: %s", bch2_err_str(ret));
 			return ret;
 		}
 	}
diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
index f01883e785a5..6efd279655ae 100644
--- a/fs/bcachefs/super-io.c
+++ b/fs/bcachefs/super-io.c
@@ -385,7 +385,7 @@ static int bch2_sb_validate(struct bch_sb_handle *disk_sb, struct printbuf *out,
 	}
 
 	if (bch2_is_zero(sb->uuid.b, sizeof(sb->uuid))) {
-		prt_printf(out, "Bad intenal UUID (got zeroes)");
+		prt_printf(out, "Bad internal UUID (got zeroes)");
 		return -BCH_ERR_invalid_sb_uuid;
 	}
 
-- 
2.39.2

