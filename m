Return-Path: <linux-kernel+bounces-150949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EDE8AA711
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 04:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81201C214E2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4D979CF;
	Fri, 19 Apr 2024 02:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cHU4kgZf"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89892137E;
	Fri, 19 Apr 2024 02:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713495398; cv=none; b=RqaMNZy8zH3mm/oWmvzxB/j6To83D4x2JcllvVchkUSAdbjwLSx1ThR0SDjthxKS0aFs766gEOK/BJUIoaW/dpvLbO52fcZHerfy37ua9zqVzaGZ1Qw7dbXbtL9ljMSSKTVMO3Cxqas/maBdHjOVSWul1LCxX352q1jT2mytczw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713495398; c=relaxed/simple;
	bh=ZaTNtrj/QjepYAH6dUYRXFmkTXp4LQWQe6YFN8eGG0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tQdPlGiCn3y4+toZWqCvwD0gNWfMtGwuYjznPk/jbv9NpjMkNTTHYiycBf36HU5DquddnspFtVvRJb3WyXbo4KO7lw96r2VPis/BIYWKUejC8nJToqWJKIsf+tYtzVGydTBiRU5NoM0F44qhB8ORQwfGeEEnrrMxeA2BLeym7Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cHU4kgZf; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713495387; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=uD3xIs6JXd7EI+1vS/WMHeLOp0GK3fl5H0/8s4XMiKo=;
	b=cHU4kgZf3drYSdGFHDWFfRde593eneuAfOQiwjAPq0q3Mz06YRZz6xfjJxM9K3IkKx2sm8YLLY2ZO8tN+womRydDPmkF5KnFJhRD4cdvG7c9tThv8qvD3/zfL0UFUb6HkOVWnzahbnNhnAMNejEe3OvQPXVzqliIIsshQXwQfp8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W4qTuPv_1713495371;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W4qTuPv_1713495371)
          by smtp.aliyun-inc.com;
          Fri, 19 Apr 2024 10:56:26 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] block/mq-deadline: Remove some unused functions
Date: Fri, 19 Apr 2024 10:56:10 +0800
Message-Id: <20240419025610.34298-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These functions are defined in the mq-deadline.c file, but not called
elsewhere, so delete these unused functions.

block/mq-deadline.c:134:1: warning: unused function 'deadline_earlier_request'.
block/mq-deadline.c:148:1: warning: unused function 'deadline_latter_request'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8803
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 block/mq-deadline.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index dce8d746b5bd..94eede4fb9eb 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -127,34 +127,6 @@ static u8 dd_rq_ioclass(struct request *rq)
 	return IOPRIO_PRIO_CLASS(req_get_ioprio(rq));
 }
 
-/*
- * get the request before `rq' in sector-sorted order
- */
-static inline struct request *
-deadline_earlier_request(struct request *rq)
-{
-	struct rb_node *node = rb_prev(&rq->rb_node);
-
-	if (node)
-		return rb_entry_rq(node);
-
-	return NULL;
-}
-
-/*
- * get the request after `rq' in sector-sorted order
- */
-static inline struct request *
-deadline_latter_request(struct request *rq)
-{
-	struct rb_node *node = rb_next(&rq->rb_node);
-
-	if (node)
-		return rb_entry_rq(node);
-
-	return NULL;
-}
-
 /*
  * Return the first request for which blk_rq_pos() >= @pos.
  */
-- 
2.20.1.7.g153144c


