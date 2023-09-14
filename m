Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C9F79FF80
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236876AbjINJFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236774AbjINJFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:05:43 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA0C1BF9;
        Thu, 14 Sep 2023 02:05:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vs1nBqG_1694682334;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Vs1nBqG_1694682334)
          by smtp.aliyun-inc.com;
          Thu, 14 Sep 2023 17:05:36 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     kent.overstreet@linux.dev
Cc:     bfoster@redhat.com, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 4/9] bcachefs: Modify mismatched function name
Date:   Thu, 14 Sep 2023 17:04:53 +0800
Message-Id: <20230914090457.32325-5-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20230914090457.32325-1-jiapeng.chong@linux.alibaba.com>
References: <20230914090457.32325-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

fs/bcachefs/btree_update_interior.c:153: warning: expecting prototype for btree_node_format_fits(). Prototype was for bch2_btree_node_format_fits() instead.
fs/bcachefs/btree_update_interior.c:1235: warning: expecting prototype for bch_btree_set_root(). Prototype was for bch2_btree_set_root() instead.
fs/bcachefs/btree_update_interior.c:1678: warning: expecting prototype for bch_btree_insert_node(). Prototype was for bch2_btree_insert_node() instead.
fs/bcachefs/btree_update_interior.c:1944: warning: expecting prototype for bch_btree_node_rewrite(). Prototype was for bch2_btree_node_rewrite() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6579
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/bcachefs/btree_update_interior.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/bcachefs/btree_update_interior.c b/fs/bcachefs/btree_update_interior.c
index 73c950d2788e..29f5e6174270 100644
--- a/fs/bcachefs/btree_update_interior.c
+++ b/fs/bcachefs/btree_update_interior.c
@@ -143,7 +143,7 @@ static size_t btree_node_u64s_with_format(struct btree *b,
 }
 
 /**
- * btree_node_format_fits - check if we could rewrite node with a new format
+ * bch2_btree_node_format_fits - check if we could rewrite node with a new format
  *
  * This assumes all keys can pack with the new format -- it just checks if
  * the re-packed keys would fit inside the node itself.
@@ -1217,7 +1217,7 @@ static void bch2_btree_set_root_inmem(struct bch_fs *c, struct btree *b)
 }
 
 /**
- * bch_btree_set_root - update the root in memory and on disk
+ * bch2_btree_set_root - update the root in memory and on disk
  *
  * To ensure forward progress, the current task must not be holding any
  * btree node write locks. However, you must hold an intent lock on the
@@ -1661,7 +1661,7 @@ bch2_btree_insert_keys_interior(struct btree_update *as,
 }
 
 /**
- * bch_btree_insert_node - insert bkeys into a given btree node
+ * bch2_btree_insert_node - insert bkeys into a given btree node
  *
  * @iter:		btree iterator
  * @keys:		list of keys to insert
@@ -1935,7 +1935,7 @@ int __bch2_foreground_maybe_merge(struct btree_trans *trans,
 }
 
 /**
- * bch_btree_node_rewrite - Rewrite/move a btree node
+ * bch2_btree_node_rewrite - Rewrite/move a btree node
  */
 int bch2_btree_node_rewrite(struct btree_trans *trans,
 			    struct btree_iter *iter,
-- 
2.20.1.7.g153144c

