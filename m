Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDB579FF7F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbjINJFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbjINJFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:05:41 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D301BF1;
        Thu, 14 Sep 2023 02:05:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vs23M9I_1694682332;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Vs23M9I_1694682332)
          by smtp.aliyun-inc.com;
          Thu, 14 Sep 2023 17:05:34 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     kent.overstreet@linux.dev
Cc:     bfoster@redhat.com, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 3/9] bcachefs: Modify mismatched function name
Date:   Thu, 14 Sep 2023 17:04:52 +0800
Message-Id: <20230914090457.32325-4-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20230914090457.32325-1-jiapeng.chong@linux.alibaba.com>
References: <20230914090457.32325-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

fs/bcachefs/io.c:1817: warning: expecting prototype for bch_write(). Prototype was for bch2_write() instead.
fs/bcachefs/io.c:747: warning: expecting prototype for bch_write_index(). Prototype was for __bch2_write_index() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6578
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/bcachefs/io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/io.c b/fs/bcachefs/io.c
index 3c614c864b6e..cd14a6d87e2b 100644
--- a/fs/bcachefs/io.c
+++ b/fs/bcachefs/io.c
@@ -741,7 +741,7 @@ static noinline int bch2_write_drop_io_error_ptrs(struct bch_write_op *op)
 }
 
 /**
- * bch_write_index - after a write, update index to point to new data
+ * __bch2_write_index - after a write, update index to point to new data
  */
 static void __bch2_write_index(struct bch_write_op *op)
 {
@@ -1798,7 +1798,7 @@ static void bch2_write_data_inline(struct bch_write_op *op, unsigned data_len)
 }
 
 /**
- * bch_write - handle a write to a cache device or flash only volume
+ * bch2_write - handle a write to a cache device or flash only volume
  *
  * This is the starting point for any data to end up in a cache device; it could
  * be from a normal write, or a writeback write, or a write to a flash only
-- 
2.20.1.7.g153144c

