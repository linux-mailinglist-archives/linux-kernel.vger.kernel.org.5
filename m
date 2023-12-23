Return-Path: <linux-kernel+bounces-10486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D29981D4F4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 17:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8271C21420
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 16:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF722EAED;
	Sat, 23 Dec 2023 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xApULiD3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="amwVd3rV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A019BFBFD;
	Sat, 23 Dec 2023 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 23 Dec 2023 16:09:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703347788;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdGCwaiRBNJcXRxfRezy5MYbCGCwO8pD1yTpHSGmw0s=;
	b=xApULiD3EJPXXwKhTqafVGQeQhLRjZZdZqJSo4TVo0ZY3kGu/xZnoGRnKSUQkfdMFTuNyn
	iLxww0bF8Hzk3Pj/sgNQRq2u5dMEGDk7iyxAd1mQNmWdokne8PGwZMlPIvqCs6pjijEALl
	AuCXxRHAR9FxZxneauWnY1I5JpvOl0Dcf/njLe30MTsi08G2rqrdf5RypXzjcJ8luRQkqc
	OsyYq5dFuL2MS27N9YM/txKxmuaFaYoy00GPq7xUWOquNVCQGaZDmFmAqQGyW6p3NQ8Ax5
	nHWdXuCzPSXylYaE3hXI2eYtd9XmdH7MQisrP6V03aa/7fbAvfVXMH9mEnjcjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703347788;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdGCwaiRBNJcXRxfRezy5MYbCGCwO8pD1yTpHSGmw0s=;
	b=amwVd3rVTwQn50X2otN5T+uu6f2Bf3yewg02rWHYZc6YBzQhDMDQT1H1LUpnfwEtQ8bM0I
	yJj49RVadrc5j6Bg==
From: "tip-bot2 for Wang Jinchao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove unused 'next_buddy_marked' local
 variable in check_preempt_wakeup_fair()
Cc: Wang Jinchao <wangjinchao@xfusion.com>, Ingo Molnar <mingo@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <202312141319+0800-wangjinchao@xfusion.com>
References: <202312141319+0800-wangjinchao@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170334778771.398.14685074303951213836.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fbb66ce0b1d670c72def736a13ac9176b860df4e
Gitweb:        https://git.kernel.org/tip/fbb66ce0b1d670c72def736a13ac9176b860df4e
Author:        Wang Jinchao <wangjinchao@xfusion.com>
AuthorDate:    Thu, 14 Dec 2023 13:20:29 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 23 Dec 2023 16:12:21 +01:00

sched/fair: Remove unused 'next_buddy_marked' local variable in check_preempt_wakeup_fair()

This variable became unused in:

    5e963f2bd465 ("sched/fair: Commit to EEVDF")

Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/202312141319+0800-wangjinchao@xfusion.com
---
 kernel/sched/fair.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1d561b5..9cc2085 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8221,7 +8221,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int 
 	struct task_struct *curr = rq->curr;
 	struct sched_entity *se = &curr->se, *pse = &p->se;
 	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
-	int next_buddy_marked = 0;
 	int cse_is_idle, pse_is_idle;
 
 	if (unlikely(se == pse))
@@ -8238,7 +8237,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int 
 
 	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK)) {
 		set_next_buddy(pse);
-		next_buddy_marked = 1;
 	}
 
 	/*

