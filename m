Return-Path: <linux-kernel+bounces-14095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C4D8217CE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BB92821B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6E4DDB8;
	Tue,  2 Jan 2024 06:50:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624FDD27D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VznCwIF_1704178198;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VznCwIF_1704178198)
          by smtp.aliyun-inc.com;
          Tue, 02 Jan 2024 14:50:22 +0800
From: Liu Song <liusong@linux.alibaba.com>
To: mingo@redhat.com,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	liusong@linux.alibaba.com
Subject: [PATCH] sched/eevdf: fix typo in the comment of place_entity
Date: Tue,  2 Jan 2024 14:49:58 +0800
Message-Id: <20240102064958.100300-1-liusong@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the derivation of the formula, 'l' should be 'vl_i', fix it.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bcd0f230e21f..b3dc606ce565 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5177,7 +5177,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		 *   V' = (\Sum w_j*v_j + w_i*v_i) / (W + w_i)
 		 *      = (W*V + w_i*(V - vl_i)) / (W + w_i)
 		 *      = (W*V + w_i*V - w_i*vl_i) / (W + w_i)
-		 *      = (V*(W + w_i) - w_i*l) / (W + w_i)
+		 *      = (V*(W + w_i) - w_i*vl_i) / (W + w_i)
 		 *      = V - w_i*vl_i / (W + w_i)
 		 *
 		 * And the actual lag after adding an entity with vl_i is:
-- 
2.19.1.6.gb485710b


