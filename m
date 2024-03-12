Return-Path: <linux-kernel+bounces-100204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B3C879384
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336EC1F227B0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F0D7A710;
	Tue, 12 Mar 2024 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ABuSb0mL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e0jZtylr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0F279DC9;
	Tue, 12 Mar 2024 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244824; cv=none; b=E+qhHuNd54OXLOjrAhEmU85XPXKqqUqkmTDDv9jh2inO8iDXb6xF7okVxqAisfXgz0JyRAc6mLHxPxLFVMtR9+42fDYYpjkooPDuyq+E8oYp851JUR1fTCEmPS1scfvOpJn/I7aHCiXuX1aEvWhvINPXh/fk5Ug8JEX/g9jsiP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244824; c=relaxed/simple;
	bh=OtN2WiBCi7+9TjZRH+mwkjsnl9BgMTcsF/1lxObfBWU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PTabpU7CBV2tRSDV+s45urEcg1G3vDIjiJNRvkwtfBttDONWwHcBGw5WfMeEnMye4U3SmmDUHmcmHGSF3MnGogNLzEbeERAosE8Y9NcMgkzlwxxj2ju4xXi8021Xg1xDly3OxYfsIRnCj+cgIi6R7B5jdTT0Y0Ur7WudR4HH2TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ABuSb0mL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e0jZtylr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 12:00:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710244820;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYtfrPZN9iFXCDlXOhOkIYqn/H8zc/GJbSnb66ECkBs=;
	b=ABuSb0mLF3WdM5anDPpSZhOCT7Q/Z4+KnI6qnuoCYCBLDyGU2+hm+1ZmDlkfSQxP5NCcgJ
	lwpLwwmguzRMnC+YGpW5uStyFMhSQ968QT1T7+AJrjY1zMt8Xx35sAZ0j7Tjh9e5aif2pJ
	lRgfnHTs0PKYPSGwTFZImuFU2q9Irg285V9/NlgFdRl63SG6c8YITBg42HxvxC+3XdIAKO
	3FbweVa4D0rKlEWIcEtGoWbN6IZdZJVnPwzddNetIpAlSXdD87iSL/+k2EnwvIq2iQdrLr
	4m2wDRHIUpV/J85i/fTG9+BjiK2W6xbi6OLPTK0qHJ0DiOaULvcH+LD62sZSlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710244820;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYtfrPZN9iFXCDlXOhOkIYqn/H8zc/GJbSnb66ECkBs=;
	b=e0jZtylrYIxLSED9VlVv9iqNJguHoravJvtgV8z0OKyDAR3+IBMD821w1MGy0NZQNmkPW4
	ULDyH4B+MZrn8TBg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/balancing: Rename find_idlest_group_cpu() =>
 sched_balance_find_dst_group_cpu()
Cc: Ingo Molnar <mingo@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240308111819.1101550-12-mingo@kernel.org>
References: <20240308111819.1101550-12-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171024481979.398.14006051455096223466.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     646ebaf51c64c6416ca89765c20041363fc1b518
Gitweb:        https://git.kernel.org/tip/646ebaf51c64c6416ca89765c20041363fc1b518
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 08 Mar 2024 12:18:17 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Mar 2024 12:00:00 +01:00

sched/balancing: Rename find_idlest_group_cpu() => sched_balance_find_dst_group_cpu()

Standardize scheduler load-balancing function names on the
sched_balance_() prefix.

Also use 'dst' instead of 'idlest': while historically correct,
today it's not really true anymore that we return the 'idlest'
group or CPU, we sort by idle-exit latency and only return the
idlest CPUs from the lowest-latency set of CPUs.

The true 'idlest' CPUs often remain idle for a long time
and are never returned as long as the system is under-loaded.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://lore.kernel.org/r/20240308111819.1101550-12-mingo@kernel.org
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aa5ff0e..02ff027 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7101,10 +7101,10 @@ static struct sched_group *
 find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
 
 /*
- * find_idlest_group_cpu - find the idlest CPU among the CPUs in the group.
+ * sched_balance_find_dst_group_cpu - find the idlest CPU among the CPUs in the group.
  */
 static int
-find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this_cpu)
+sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *p, int this_cpu)
 {
 	unsigned long load, min_load = ULONG_MAX;
 	unsigned int min_exit_latency = UINT_MAX;
@@ -7191,7 +7191,7 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 			continue;
 		}
 
-		new_cpu = find_idlest_group_cpu(group, p, cpu);
+		new_cpu = sched_balance_find_dst_group_cpu(group, p, cpu);
 		if (new_cpu == cpu) {
 			/* Now try balancing at a lower domain level of 'cpu': */
 			sd = sd->child;

