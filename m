Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6D17E64A5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjKIHsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjKIHsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:48:31 -0500
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84B52693;
        Wed,  8 Nov 2023 23:48:27 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vw.x3PM_1699516096;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Vw.x3PM_1699516096)
          by smtp.aliyun-inc.com;
          Thu, 09 Nov 2023 15:48:23 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     kent.overstreet@linux.dev
Cc:     bfoster@redhat.com, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] bcachefs: clean up some inconsistent indenting
Date:   Thu,  9 Nov 2023 15:48:15 +0800
Message-Id: <20231109074815.117232-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

fs/bcachefs/journal_io.c:1832 bch2_journal_write_pick_flush() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7207
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/bcachefs/journal_io.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/bcachefs/journal_io.c b/fs/bcachefs/journal_io.c
index f4bc2cdbfdd7..72b0f3972170 100644
--- a/fs/bcachefs/journal_io.c
+++ b/fs/bcachefs/journal_io.c
@@ -1823,16 +1823,13 @@ static int bch2_journal_write_pick_flush(struct journal *j, struct journal_buf *
 	if (error && test_bit(JOURNAL_NEED_FLUSH_WRITE, &j->flags))
 		return -EIO;
 
-	if (error ||
-	    w->noflush ||
-	    (!w->must_flush &&
-	     (jiffies - j->last_flush_write) < msecs_to_jiffies(c->opts.journal_flush_delay) &&
-	     test_bit(JOURNAL_MAY_SKIP_FLUSH, &j->flags))) {
-		     w->noflush = true;
+	if (error || w->noflush || (!w->must_flush &&
+	    (jiffies - j->last_flush_write) < msecs_to_jiffies(c->opts.journal_flush_delay) &&
+	    test_bit(JOURNAL_MAY_SKIP_FLUSH, &j->flags))) {
+		w->noflush = true;
 		SET_JSET_NO_FLUSH(w->data, true);
 		w->data->last_seq	= 0;
 		w->last_seq		= 0;
-
 		j->nr_noflush_writes++;
 	} else {
 		j->last_flush_write = jiffies;
-- 
2.20.1.7.g153144c

