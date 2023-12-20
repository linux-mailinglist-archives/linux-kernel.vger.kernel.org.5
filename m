Return-Path: <linux-kernel+bounces-6649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 586B4819BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0791C222E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA661F60F;
	Wed, 20 Dec 2023 09:49:41 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDECE1F606
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4Sw7wb74fnz9ykLG;
	Wed, 20 Dec 2023 17:45:51 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 20 Dec
 2023 17:49:27 +0800
Date: Wed, 20 Dec 2023 17:49:26 +0800
From: Wang Jinchao <wangjinchao@xfusion.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <stone.xulei@xfusion.com>, <wangjinchao@xfusion.com>
Subject: [PATCH] sched/eevdf: Correct comment in place_entity
Message-ID: <202312201748+0800-wangjinchao@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: wuxshcsitd00603.xfusion.com (10.32.134.231) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)

Fix variable names in the place_entity function comments
to accurately represent lag calculation.

Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7a3c63a2171..23e3fa1236f5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5160,7 +5160,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		 *   V' = (\Sum w_j*v_j + w_i*v_i) / (W + w_i)
 		 *      = (W*V + w_i*(V - vl_i)) / (W + w_i)
 		 *      = (W*V + w_i*V - w_i*vl_i) / (W + w_i)
-		 *      = (V*(W + w_i) - w_i*l) / (W + w_i)
+		 *      = (V*(W + w_i) - w_i*vl_i) / (W + w_i)
 		 *      = V - w_i*vl_i / (W + w_i)
 		 *
 		 * And the actual lag after adding an entity with vl_i is:
-- 
2.40.0


