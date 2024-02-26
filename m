Return-Path: <linux-kernel+bounces-80439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D6A866870
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03C5AB21216
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F431172C;
	Mon, 26 Feb 2024 03:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OrAqBBZ3"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9696EEDE;
	Mon, 26 Feb 2024 03:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708916440; cv=none; b=tzRanl7GwG6f56zKZaPXONjuzVAaqlktp3TLlI5he9m44N9QtGCj0WDDofm5doPpynz+9Q4fV+PHbWU6CIKbGubjdpmD9Klgr9DXGotk6H4dWi06QArbeY5dIWVjwfzzk0aSv+veO0l/j+dIgFX7wZ689rpHxRm7Zaxy9tJOSzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708916440; c=relaxed/simple;
	bh=csSYGWemCbLGZwDYJ4avPHeqV2/fyzcR4e4AEvbbhkU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l3MR7eHXDHD+qFXMOSEbFDwNNZ9pAUwYcJFHNDDBdsXicA9TT9V52SxKOjDlBEfRXXRdqwWmd80u5Lc8cnuxJxaKdLT4t7BjsSgmDKUdXZHFvOqIRSJZzwV50wayHwoSmS97ivkyvhWyCod0c8X9H1c3PMKBphJF/ZK4Qb53eLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OrAqBBZ3; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708916435; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=j52EVcWLD2Oyf2TLWnGwY3nHXSPDfngP9hva8J3Fsgg=;
	b=OrAqBBZ3/HZGlrqsVKIjR/jGcU8B4gLYhqRp2GVPg6vX/o6WYa6qpkv5PoxF/3tIQx32LHos9HUm1YEzDlpHbx4MSuqEhWqCD1oKrKZ9E1yND91r3CDrSNuXsEIUaYCMdCkNy+7L9ZdLYneEckPuKur6NoJHbxXUe80sb2LgyX0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W1ACdfU_1708916419;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W1ACdfU_1708916419)
          by smtp.aliyun-inc.com;
          Mon, 26 Feb 2024 11:00:35 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: kent.overstreet@linux.dev
Cc: bfoster@redhat.com,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] bcachefs: Remove unused function
Date: Mon, 26 Feb 2024 11:00:18 +0800
Message-Id: <20240226030018.98875-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function are defined in the journal_io.c file, but not called
elsewhere, so delete the unused function.

fs/bcachefs/journal_io.c:1592:35: warning: unused function 'journal_last_unwritten_buf'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8315
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/bcachefs/journal_io.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/bcachefs/journal_io.c b/fs/bcachefs/journal_io.c
index f9e5b100a9da..ee5c53cc58d0 100644
--- a/fs/bcachefs/journal_io.c
+++ b/fs/bcachefs/journal_io.c
@@ -1589,11 +1589,6 @@ static void journal_buf_realloc(struct journal *j, struct journal_buf *buf)
 	kvfree(new_buf);
 }
 
-static inline struct journal_buf *journal_last_unwritten_buf(struct journal *j)
-{
-	return j->buf + (journal_last_unwritten_seq(j) & JOURNAL_BUF_MASK);
-}
-
 static CLOSURE_CALLBACK(journal_write_done)
 {
 	closure_type(w, struct journal_buf, io);
-- 
2.20.1.7.g153144c


