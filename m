Return-Path: <linux-kernel+bounces-153299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6858ACC2B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E291F22349
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397001474B2;
	Mon, 22 Apr 2024 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iiosEHvP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6Pzi0HoB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A831465B7;
	Mon, 22 Apr 2024 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713785978; cv=none; b=ckRdfWDRNnJfAPad2XhTFQ3asyd3rRZjClK017aAw7PrVNrlWUWrmgtZ24y3tzl8WJxg2yxxu9r8juwOenT1b0UtNV9hCJuZhzQCDCrxNjBHpU+tojHoyU3PV2x/3egGouMt2bCp58jrPXlJJFmbRs3vvRqb6ewpUjjheQaWVR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713785978; c=relaxed/simple;
	bh=EECRdzowpEowAZmGlguCc5GjAUJG1EYPm0MDp3czuVc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fdcf++GymkvMk73PmPkN5KJApRrhJBhYFjSoWIb0rBquVuUVYi9BBof68QRoKqyeoVMtUAjUarcfdSStd+r5IEkANFW1dkJ3HSmkkSCWlFr3ODU2y4r6IHWkb1A/wcWiWK86nzNCXh80Gihd1+WdXrD8xwH8NxoOwtMSobsw2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iiosEHvP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6Pzi0HoB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Apr 2024 11:39:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713785975;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8r76kTVR+OljXjJoSnTmhAtEL3qabccd9975h+qBfGk=;
	b=iiosEHvPG81o3IXDT0KKHSwigbsI1Al3NINAAhGi69OVfoB8LQZAnx2FsQbTKgF6VWlA3y
	vR4OInI7NlMnVRs6PwApvuxbPooBK1mfLB1mV28mfPhSwFw13d1Ub6gFJUY6beMdJtHje+
	IpA01ShfpwD/lywGUkmlt7UfZ6fM59zQ+3cGtjeHv1CcXj7iLWVuvJtwEtPBlntqybHFbi
	wrJM8554QMFXbpi9YQzM6A2CCas6VrL6l+AUehfQZLYR2k0UeD4a9JkaDH8BC/idHYiIoV
	p4O2rEpdqLreIgBZgtSrO4hXJuiLAhyP1WtsqwCIUTW589IBBuxQ4JLAICg0hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713785975;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8r76kTVR+OljXjJoSnTmhAtEL3qabccd9975h+qBfGk=;
	b=6Pzi0HoBb0ENZ6XjuhGlt7jTdjgxi83pvqRlq3IzRn+mPpHUYodS44PI1Ey0lTBJGTD8ym
	2bkwVpXnnk2aA/CQ==
From: "tip-bot2 for Tianchen Ding" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/eevdf: Always update V if se->on_rq when
 reweighting
Cc: Abel Wu <wuyun.abel@bytedance.com>,
 Tianchen Ding <dtcccc@linux.alibaba.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Chen Yu <yu.c.chen@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240306022133.81008-2-dtcccc@linux.alibaba.com>
References: <20240306022133.81008-2-dtcccc@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171378597469.10875.9133852696892913685.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     11b1b8bc2b98e21ddf47e08b56c21502c685b2c3
Gitweb:        https://git.kernel.org/tip/11b1b8bc2b98e21ddf47e08b56c21502c685b2c3
Author:        Tianchen Ding <dtcccc@linux.alibaba.com>
AuthorDate:    Wed, 06 Mar 2024 10:21:32 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 22 Apr 2024 13:01:26 +02:00

sched/eevdf: Always update V if se->on_rq when reweighting

reweight_eevdf() needs the latest V to do accurate calculation for new
ve and vd. So update V unconditionally when se is runnable.

Fixes: eab03c23c2a1 ("sched/eevdf: Fix vruntime adjustment on reweight")
Suggested-by: Abel Wu <wuyun.abel@bytedance.com>
Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Abel Wu <wuyun.abel@bytedance.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Chen Yu <yu.c.chen@intel.com>
Link: https://lore.kernel.org/r/20240306022133.81008-2-dtcccc@linux.alibaba.com
---
 kernel/sched/fair.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03be0d1..5551ce2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3790,9 +3790,8 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
 	if (se->on_rq) {
 		/* commit outstanding execution time */
-		if (curr)
-			update_curr(cfs_rq);
-		else
+		update_curr(cfs_rq);
+		if (!curr)
 			__dequeue_entity(cfs_rq, se);
 		update_load_sub(&cfs_rq->load, se->load.weight);
 	}

