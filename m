Return-Path: <linux-kernel+bounces-25627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF9582D3C5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D7C1F214E8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 05:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B72F23B7;
	Mon, 15 Jan 2024 05:02:36 +0000 (UTC)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462AD17CF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 05:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W-ZivNm_1705293980;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0W-ZivNm_1705293980)
          by smtp.aliyun-inc.com;
          Mon, 15 Jan 2024 12:46:50 +0800
From: Liu Song <liusong@linux.alibaba.com>
To: mingo@redhat.com,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	liusong@linux.alibaba.com
Subject: [PATCH] sched/eevdf: using leftmost improves the readability of the code
Date: Mon, 15 Jan 2024 12:46:19 +0800
Message-Id: <20240115044619.34718-1-liusong@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using 'leftmost' enhances code readability, without involving any logical
changes.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f2bb83675e4a..4247584258ae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -848,12 +848,12 @@ struct sched_entity *__pick_root_entity(struct cfs_rq *cfs_rq)
 
 struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
 {
-	struct rb_node *left = rb_first_cached(&cfs_rq->tasks_timeline);
+	struct rb_node *leftmost = rb_first_cached(&cfs_rq->tasks_timeline);
 
-	if (!left)
+	if (!leftmost)
 		return NULL;
 
-	return __node_2_se(left);
+	return __node_2_se(leftmost);
 }
 
 /*
-- 
2.19.1.6.gb485710b


