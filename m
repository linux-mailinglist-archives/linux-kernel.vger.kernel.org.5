Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50EA79FF81
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbjINJFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbjINJFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:05:45 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50231BEF;
        Thu, 14 Sep 2023 02:05:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vs25CXx_1694682336;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Vs25CXx_1694682336)
          by smtp.aliyun-inc.com;
          Thu, 14 Sep 2023 17:05:38 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     kent.overstreet@linux.dev
Cc:     bfoster@redhat.com, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 5/9] bcachefs: Modify mismatched function name
Date:   Thu, 14 Sep 2023 17:04:54 +0800
Message-Id: <20230914090457.32325-6-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20230914090457.32325-1-jiapeng.chong@linux.alibaba.com>
References: <20230914090457.32325-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

fs/bcachefs/btree_trans_commit.c:223: warning: expecting prototype for btree_insert_key(). Prototype was for bch2_btree_insert_key_leaf() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6580
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/bcachefs/btree_trans_commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/btree_trans_commit.c b/fs/bcachefs/btree_trans_commit.c
index eafb0388ef82..5388bfa4d15b 100644
--- a/fs/bcachefs/btree_trans_commit.c
+++ b/fs/bcachefs/btree_trans_commit.c
@@ -214,7 +214,7 @@ inline void bch2_btree_add_journal_pin(struct bch_fs *c,
 }
 
 /**
- * btree_insert_key - insert a key one key into a leaf node
+ * bch2_btree_insert_key_leaf - insert a key one key into a leaf node
  */
 inline void bch2_btree_insert_key_leaf(struct btree_trans *trans,
 				       struct btree_path *path,
-- 
2.20.1.7.g153144c

