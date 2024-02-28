Return-Path: <linux-kernel+bounces-85755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 619F886BA5A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1C0285BA6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F95776F1A;
	Wed, 28 Feb 2024 22:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L5aIosW4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q1kVylNL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD3A72921;
	Wed, 28 Feb 2024 22:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157618; cv=none; b=aGSOQ1cbxtYiDVGUZfRD6aVBIpJzPW0iGRLBwfJq10Jvay9cffeHg+IdrXgIh0/Zu6j8W1JhawrJlq4dqPeUP9RhXoovzeq5Pt50qkt6yl1sZEPfBk6hHwAusdzs8AQ3ZnlBLHHUywO10M3LXMo4/EJl01vJ2+2IBKwpaXCWDjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157618; c=relaxed/simple;
	bh=Kbc3CBARYMyxP7nPSVDq+QDIHWWxcTvx3Pdbwk22UGs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SMelB35oeVdQe8bwL0r1PJKQOpQBe9k1r3HNVNStczUsZr9E47fJ+To6NwPH1lbsEJNAL9c+iFCUhjK3o/dm9Vmii/DXCN+FLwIXDWS2ZKksSsesOYzkB4yTKroXgIBcMuoSAEaTcX4CpIBEZwxy2mxd0gAWr4KtDmFsP/0Vbdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L5aIosW4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q1kVylNL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Feb 2024 22:00:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709157610;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a40RlwL8R2DxtAw9DQ1Rv47BdvRqUCvsOh8PymgKpb0=;
	b=L5aIosW4W7cub/ulHJn4vSWlmA401qPLPee2jmTH2aEwQdSJrVxv3skYFADuVxPajRxP3h
	nSsAa1ECto86TibDekUCqzGO75hV8hBCDUOO731tyZNEEf1/lmOzbvridBlLP3vBSeHwTB
	uEpI2M9aj6lxOYCLrmvAdxtlXX3BuEYKiQ9vZauUTG1Eb5yBgNhmVZ1Pbwn9xPLmzplAOL
	P1xQNHtzqw1j/5yK10Ylezx/QNltL46Wgn5Zn0RISAUH409Do6cukkstxx0k4ns5OHej1K
	rwJohTg8Famw150o0qeFhxO2wkQc+EQ+4qzG+wQyQhAOh1AXgnCkui8sk1fQBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709157610;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a40RlwL8R2DxtAw9DQ1Rv47BdvRqUCvsOh8PymgKpb0=;
	b=q1kVylNL5uS3S2dwyKxxId36I3eo7O2wwMlElo9nB03bIGqhlAnJEELfwtCPsdjXRshUxw
	MKHSFqF74J3pinDQ==
From: "tip-bot2 for David Vernet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Remove unnecessary goto in update_sd_lb_stats()
Cc: David Vernet <void@manifault.com>, Ingo Molnar <mingo@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240206043921.850302-2-void@manifault.com>
References: <20240206043921.850302-2-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170915760996.398.17950890395789943511.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9dfbc26d27aaf0f5958c5972188f16fe977e5af5
Gitweb:        https://git.kernel.org/tip/9dfbc26d27aaf0f5958c5972188f16fe977e5af5
Author:        David Vernet <void@manifault.com>
AuthorDate:    Mon, 05 Feb 2024 22:39:19 -06:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 28 Feb 2024 15:19:23 +01:00

sched/fair: Remove unnecessary goto in update_sd_lb_stats()

In update_sd_lb_stats(), when we're iterating over the sched groups that
comprise a sched domain, we're skipping the call to
update_sd_pick_busiest() for the sched group that contains the local /
destination CPU. We use a goto to skip the call, but we could just as
easily check !local_group, as there's no other logic that we need to
skip with the goto. Let's remove the goto, and check for !local_group in
the if statement instead.

Signed-off-by: David Vernet <void@manifault.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20240206043921.850302-2-void@manifault.com
---
 kernel/sched/fair.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 352222d..41dda53 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10580,16 +10580,11 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 		update_sg_lb_stats(env, sds, sg, sgs, &sg_status);
 
-		if (local_group)
-			goto next_group;
-
-
-		if (update_sd_pick_busiest(env, sds, sg, sgs)) {
+		if (!local_group && update_sd_pick_busiest(env, sds, sg, sgs)) {
 			sds->busiest = sg;
 			sds->busiest_stat = *sgs;
 		}
 
-next_group:
 		/* Now, start updating sd_lb_stats */
 		sds->total_load += sgs->group_load;
 		sds->total_capacity += sgs->group_capacity;

