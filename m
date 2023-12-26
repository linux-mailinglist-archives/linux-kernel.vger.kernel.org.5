Return-Path: <linux-kernel+bounces-11392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5521881E589
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 07:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66DD282CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3924C3CE;
	Tue, 26 Dec 2023 06:45:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA514A99D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 06:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VzGovLI_1703573063;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VzGovLI_1703573063)
          by smtp.aliyun-inc.com;
          Tue, 26 Dec 2023 14:44:53 +0800
From: Liu Song <liusong@linux.alibaba.com>
To: mingo@redhat.com,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	liusong@linux.alibaba.com
Subject: [PATCH] sched/eevdf: fix two comment typos
Date: Tue, 26 Dec 2023 14:44:23 +0800
Message-Id: <20231226064423.47510-1-liusong@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed two typing errors in the comments related to EEVDF.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bcd0f230e21f..0d18fcf88d1d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -601,7 +601,7 @@ static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
  *
  *	    Also see the comment in place_entity() that deals with this. ]]
  *
- * However, since v_i is u64, and the multiplcation could easily overflow
+ * However, since v_i is u64, and the multiplication could easily overflow
  * transform it into a relative form that uses smaller quantities:
  *
  * Substitute: v_i == (v_i - v0) + v0
@@ -5215,7 +5215,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	se->vruntime = vruntime - lag;
 
 	/*
-	 * When joining the competition; the exisiting tasks will be,
+	 * When joining the competition; the existing tasks will be,
 	 * on average, halfway through their slice, as such start tasks
 	 * off with half a slice to ease into the competition.
 	 */
-- 
2.19.1.6.gb485710b


