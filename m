Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC4C79DD4C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 02:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbjIMA6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 20:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjIMA6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 20:58:05 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFDC10F6;
        Tue, 12 Sep 2023 17:58:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VryGzmx_1694566677;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VryGzmx_1694566677)
          by smtp.aliyun-inc.com;
          Wed, 13 Sep 2023 08:57:58 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     kent.overstreet@linux.dev, bfoster@redhat.com
Cc:     linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] bcachefs: Remove unneeded semicolon
Date:   Wed, 13 Sep 2023 08:57:56 +0800
Message-Id: <20230913005756.6827-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./fs/bcachefs/btree_gc.c:1249:2-3: Unneeded semicolon
./fs/bcachefs/btree_gc.c:1521:2-3: Unneeded semicolon
./fs/bcachefs/btree_gc.c:1575:2-3: Unneeded semicolon
./fs/bcachefs/counters.c:46:2-3: Unneeded semicolon

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/bcachefs/btree_gc.c | 6 +++---
 fs/bcachefs/counters.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/bcachefs/btree_gc.c b/fs/bcachefs/btree_gc.c
index dac2eb76c985..56c671638c43 100644
--- a/fs/bcachefs/btree_gc.c
+++ b/fs/bcachefs/btree_gc.c
@@ -1246,7 +1246,7 @@ static int bch2_gc_done(struct bch_fs *c,
 			copy_dev_field(d[i].sectors,	"%s sectors", bch2_data_types[i]);
 			copy_dev_field(d[i].fragmented,	"%s fragmented", bch2_data_types[i]);
 		}
-	};
+	}
 
 	{
 		unsigned nr = fs_usage_u64s(c);
@@ -1518,7 +1518,7 @@ static int bch2_gc_alloc_start(struct bch_fs *c, bool metadata_only)
 		buckets->first_bucket	= ca->mi.first_bucket;
 		buckets->nbuckets	= ca->mi.nbuckets;
 		rcu_assign_pointer(ca->buckets_gc, buckets);
-	};
+	}
 
 	bch2_trans_init(&trans, c, 0, 0);
 
@@ -1572,7 +1572,7 @@ static void bch2_gc_alloc_reset(struct bch_fs *c, bool metadata_only)
 			g->dirty_sectors = 0;
 			g->cached_sectors = 0;
 		}
-	};
+	}
 }
 
 static int bch2_gc_write_reflink_key(struct btree_trans *trans,
diff --git a/fs/bcachefs/counters.c b/fs/bcachefs/counters.c
index 442a9b806a3c..26eb3d82b1cb 100644
--- a/fs/bcachefs/counters.c
+++ b/fs/bcachefs/counters.c
@@ -43,7 +43,7 @@ static void bch2_sb_counters_to_text(struct printbuf *out, struct bch_sb *sb,
 		prt_tab(out);
 		prt_printf(out, "%llu", le64_to_cpu(ctrs->d[i]));
 		prt_newline(out);
-	};
+	}
 };
 
 int bch2_sb_counters_to_cpu(struct bch_fs *c)
-- 
2.20.1.7.g153144c

