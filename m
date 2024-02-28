Return-Path: <linux-kernel+bounces-85760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 650EE86BA65
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F17F28666C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC5415E5D9;
	Wed, 28 Feb 2024 22:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i8BvkiZ1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3oCjP3Uj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC78376F0A;
	Wed, 28 Feb 2024 22:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157620; cv=none; b=XbJp5kMfJxKeYNHADpt3LNaxz3kfsoQ2CgQkc7DH9GzW9Zoaez0Gkmeg+zcrHFXbAaX3ZSIFQ4PSTf92zCmU5pNkmabi1BWoiIpY+32m2GfDLQtM3kKC7nEeuStFYFAol8Zi778q7dphPPTOfuv0K640nwKlEjaRrNh7llQggt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157620; c=relaxed/simple;
	bh=ryJpJr++JH9ILBZsDiPvJLWA6NmY2BKqhb2LWNtd2yY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r3jU0dwYgf7zgZVCY0D5FOM2NXOnMWyIy9q0evGRKpoO48nCJqVPckHQepcnJ5dDpzNyf/mFQ4+KfAZroYfgOpq/D6/sMrR5JeazsqGRdh+7Gh3q8cYhdcSm4zerCliHQcDicHnXCU7xsBRH5Lfk+iNMCU8DHOK1UCn/OPUiyD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i8BvkiZ1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3oCjP3Uj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Feb 2024 22:00:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709157613;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AqnqoMpIl5k6Jdqh1nfd2HSKhwv+pZA6RL42OGDprlA=;
	b=i8BvkiZ1u31+7+nVv4iMK6574b+QKmFyumTA0z64UXrn9Lxia1EP6+LNgi4Wkpp+sBOoJc
	Cfs0NMAjoF2dTbUHF98Dsx6MxShBMzv718xKpqvEy46iS8oAXSosAPccneQedYtrrD9KZi
	TFNvotEk+nPmeEC/WWXsFa8GOOZektQ9DM0VCBDL/Ld0O8uPfXI9QYeXdAhAyRHaJ6c8en
	ya9pU7wWsVUROVJR01WCbEWHUA6z5grEA7eydbZlJSJ6fkTpqrXhq6eYQaI/vukLVSvpw5
	S3qrLfY2MKJ3TUJ7NazIbvUfksRI0i/LVvE2miLl+5ugGq8QnNNdMhW0Y9ctfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709157613;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AqnqoMpIl5k6Jdqh1nfd2HSKhwv+pZA6RL42OGDprlA=;
	b=3oCjP3UjNNbAHtHXbkN9aI3a1KBzXGmKO7vT/2icXl1u4ICHB9R+vxghIjdLcwEK/FaNlh
	dMDqueWfCU2wWzAg==
From: "tip-bot2 for Shrikanth Hegde" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Use existing helper functions to access
 ->avg_rt and ->avg_dl
Cc: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240101154624.100981-2-sshegde@linux.vnet.ibm.com>
References: <20240101154624.100981-2-sshegde@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170915761279.398.5988378021122454655.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8b936fc1d84f7d70009ea34d66bbf6c54c09fae7
Gitweb:        https://git.kernel.org/tip/8b936fc1d84f7d70009ea34d66bbf6c54c09fae7
Author:        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
AuthorDate:    Mon, 01 Jan 2024 21:16:23 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 28 Feb 2024 15:11:14 +01:00

sched/fair: Use existing helper functions to access ->avg_rt and ->avg_dl

There are helper functions called cpu_util_dl() and cpu_util_rt() which give
the average utilization of DL and RT respectively. But there are a few
places in code where access to these variables is open-coded.

Instead use the helper function so that code becomes simpler and easier to
maintain later on.

No functional changes intended.

Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240101154624.100981-2-sshegde@linux.vnet.ibm.com
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8e30e2b..127e727 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9237,10 +9237,10 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
 
 static inline bool others_have_blocked(struct rq *rq)
 {
-	if (READ_ONCE(rq->avg_rt.util_avg))
+	if (cpu_util_rt(rq))
 		return true;
 
-	if (READ_ONCE(rq->avg_dl.util_avg))
+	if (cpu_util_dl(rq))
 		return true;
 
 	if (thermal_load_avg(rq))
@@ -9506,8 +9506,8 @@ static unsigned long scale_rt_capacity(int cpu)
 	 * avg_thermal.load_avg tracks thermal pressure and the weighted
 	 * average uses the actual delta max capacity(load).
 	 */
-	used = READ_ONCE(rq->avg_rt.util_avg);
-	used += READ_ONCE(rq->avg_dl.util_avg);
+	used = cpu_util_rt(rq);
+	used += cpu_util_dl(rq);
 	used += thermal_load_avg(rq);
 
 	if (unlikely(used >= max))

