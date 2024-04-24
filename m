Return-Path: <linux-kernel+bounces-157653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C839B8B1411
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB81DB28C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253C3140368;
	Wed, 24 Apr 2024 20:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v2nExSzp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EDAv7xX0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E4713CAB3;
	Wed, 24 Apr 2024 20:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989105; cv=none; b=uxyFxvPZaRct6LB4LcXS4NUxqXEYOafFh0Stse8YAxAnzuYojWw6Tx/yEr0TyymQPjfxOl01UKKIH0vciZaw3ZyaSc/macgLS5wTlWTW+Mm6NYD7o1yp/jEy3saygKvWjBQeNpHXLJ8gEic9zUVGjNNogHRbJbJOkV3JZm49fYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989105; c=relaxed/simple;
	bh=ydiXp3xrHXeTRZFHo2zNN/Ib+OF3q0t/VTPrpNS7l1I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WoZUF7fDowowh7egvQIc46EH3NXtceE8FRaw0mlv/gmDlCF1zlDaD1bTYTjFbHnuuGNTdKDU31AGl0Ja04pf/4qMeifT2gKXvb9GtykAZh1quJEzSqFQyBymGF3cdC4+AUvdkUzq3ZmoSyTNaXmH723rMDf4zlFmnCC4vqsqJ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v2nExSzp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EDAv7xX0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Apr 2024 20:05:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713989102;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x0ugmBiDyq2dVmJdnmJR0ENqZv0slPHTVJDKJUXgyj4=;
	b=v2nExSzpci4i/H06crtzPKA3MD9obDpqvKXcaIavdYLhJW5OG3YZ9JqtPWymVwfsdujgbk
	qVRkaojPrJ2PNaZWpUvL4WuftuoulMOo+m7g+4svnKbxiAiYrcIHmsRZskX1Uc7ZMwJTew
	dfEVIu/nf5yu3pkEy5IL4XmEg8EQRH2iG+YjaDUS2QHsYmBAWh3GVvn6kS7A7kuICF2Uao
	Z/IlhJa6CFWinFErtg8ZoUttcr/wkA73TJI3pGRws0hkQlR5BVtQ83XgDaftLrD41vMi0I
	kLb/7Xd6RO/6J0IldAV2nqSbApLoUPExcSBeKERVEq7JmRa1AGOLOZdcnfHgOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713989102;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x0ugmBiDyq2dVmJdnmJR0ENqZv0slPHTVJDKJUXgyj4=;
	b=EDAv7xX0m1Wjjm6Kzstt3plifIxSZ+eybjEB06aw0uOKJVMJc2LueCyJ7Qc0Psc8BIQ6Yt
	EL6JJp9PUh3fsGDQ==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/isolation: Fix boot crash when maxcpus <
 first housekeeping CPU
Cc: Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Phil Auld <pauld@redhat.com>, Frederic Weisbecker <frederic@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240413141746.GA10008@redhat.com>
References: <20240413141746.GA10008@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171398910207.10875.4426725644764756607.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     b6ad00418eaf376b4f2a68a1696d6368c1381310
Gitweb:        https://git.kernel.org/tip/b6ad00418eaf376b4f2a68a1696d6368c1381310
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Sat, 13 Apr 2024 16:17:46 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 24 Apr 2024 21:53:34 +02:00

sched/isolation: Fix boot crash when maxcpus < first housekeeping CPU

housekeeping_setup() checks cpumask_intersects(present, online) to ensure
that the kernel will have at least one housekeeping CPU after smp_init(),
but this doesn't work if the maxcpus= kernel parameter limits the number of
processors available after bootup.

For example, a kernel with "maxcpus=2 nohz_full=0-2" parameters crashes at
boot time on a virtual machine with 4 CPUs.

Change housekeeping_setup() to use cpumask_first_and() and check that the
returned CPU number is valid and less than setup_max_cpus.

Another corner case is "nohz_full=0" on a machine with a single CPU or with
the maxcpus=1 kernel argument. In this case non_housekeeping_mask is empty
and tick_nohz_full_setup() makes no sense. And indeed, the kernel hits the
WARN_ON(tick_nohz_full_running) in tick_sched_do_timer().

And how should the kernel interpret the "nohz_full=" parameter? It should
be silently ignored, but currently cpulist_parse() happily returns the
empty cpumask and this leads to the same problem.

Change housekeeping_setup() to check cpumask_empty(non_housekeeping_mask)
and do nothing in this case.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Phil Auld <pauld@redhat.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240413141746.GA10008@redhat.com
---
 kernel/sched/isolation.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 2a262d3..5891e71 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -118,6 +118,7 @@ static void __init housekeeping_setup_type(enum hk_type type,
 static int __init housekeeping_setup(char *str, unsigned long flags)
 {
 	cpumask_var_t non_housekeeping_mask, housekeeping_staging;
+	unsigned int first_cpu;
 	int err = 0;
 
 	if ((flags & HK_FLAG_TICK) && !(housekeeping.flags & HK_FLAG_TICK)) {
@@ -138,7 +139,8 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 	cpumask_andnot(housekeeping_staging,
 		       cpu_possible_mask, non_housekeeping_mask);
 
-	if (!cpumask_intersects(cpu_present_mask, housekeeping_staging)) {
+	first_cpu = cpumask_first_and(cpu_present_mask, housekeeping_staging);
+	if (first_cpu >= nr_cpu_ids || first_cpu >= setup_max_cpus) {
 		__cpumask_set_cpu(smp_processor_id(), housekeeping_staging);
 		__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
 		if (!housekeeping.flags) {
@@ -147,6 +149,9 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 		}
 	}
 
+	if (cpumask_empty(non_housekeeping_mask))
+		goto free_housekeeping_staging;
+
 	if (!housekeeping.flags) {
 		/* First setup call ("nohz_full=" or "isolcpus=") */
 		enum hk_type type;

