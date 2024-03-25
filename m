Return-Path: <linux-kernel+bounces-116937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C39E988A700
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A986CB44419
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3E9183BAE;
	Mon, 25 Mar 2024 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aGIjHI5p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+249sJcc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD771B676C;
	Mon, 25 Mar 2024 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711366102; cv=none; b=ZpP8XESxTGoJbqdggqkLY3HRwZsHZkCcXAoHqAk8x2K0sjTLknazAgmt6AjJAK1ZF2KnoW6aTIvzkkYvIhdsKijRQaFili+MLYkuVRQjHjcKjxoCLCsUoc34HghTZMa2Ac6PoAoNnccRu4geKK1z3IsEVZXyA3bwNnbFZcDWPnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711366102; c=relaxed/simple;
	bh=KNDp3jRDFDklfJlUKQQts+H70dIwd0ih7z/WwhczkXg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=K5P2ozS8sPFhzD7aqSbKbfSuVxsVef6BTOjbvtsiuWKodI9KhRW3NXQveqsoFIiqDBW4K2Ft5GVg2/lLq7esGEJ9nmQKjsvfiPTPOVDpyxxouCfNKgh4mGhhGnS4Xb8SdUgMgUlvAyvJCoUnvVH/ZL0+QC6QOv/wKXXcx9SJyJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aGIjHI5p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+249sJcc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Mar 2024 11:28:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711366099;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b0foAp6Jh3HG07zsbyZU5KG4EcvhR89BySV+yv087Pc=;
	b=aGIjHI5p1MDcpzC9ZS30bWhZjhSFeIfCaVMDygBPVIbE6vHiuaDM3qMFO2nClQh8u3nIIc
	fRpIs/wvTjCeMjboNJ57bBw8APER1GnqLX9LW8/hLgV9Fp3yMqGIYoHLOvjdiaOOvYWjga
	fKOX5OCAaU64UlZr0MbBz/x40MKjcIp3xEDdvpR/4AoaGUfQ+7u0oUTXQfKwI0mGMTDtCm
	ng4PXZRK5rRF084v8h5IUouJRNZmDFlJqyEPHEQWgXmkJ7/tbtduSwulPRSLPc/v76CevG
	ptIQwxVdsYYqmt/KfEHR/QnEjZQe5jOE81Atzzjzo8fYpMXsUhgHHoVsJHF9Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711366099;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b0foAp6Jh3HG07zsbyZU5KG4EcvhR89BySV+yv087Pc=;
	b=+249sJccnOPbWT7s8XbRfWrYvpV2a33ZzCMe2xC0DcCqjlOJ8ygi58E0Ij38ef/4Tvo8W4
	2Y0zWaWanK1TpXDA==
From: "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/topology: Remove root_domain::max_cpu_capacity
Cc: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240324004552.999936-4-qyousef@layalina.io>
References: <20240324004552.999936-4-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171136609892.10875.3581762872501656625.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fa427e8e53d8db15090af7e952a55870dc2a453f
Gitweb:        https://git.kernel.org/tip/fa427e8e53d8db15090af7e952a55870dc2a453f
Author:        Qais Yousef <qyousef@layalina.io>
AuthorDate:    Sun, 24 Mar 2024 00:45:51 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 25 Mar 2024 12:09:56 +01:00

sched/topology: Remove root_domain::max_cpu_capacity

The value is no longer used as we now keep track of max_allowed_capacity
for each task instead.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240324004552.999936-4-qyousef@layalina.io
---
 kernel/sched/sched.h    |  2 --
 kernel/sched/topology.c | 13 ++-----------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f77c00d..4f9e952 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -917,8 +917,6 @@ struct root_domain {
 	cpumask_var_t		rto_mask;
 	struct cpupri		cpupri;
 
-	unsigned long		max_cpu_capacity;
-
 	/*
 	 * NULL-terminated list of performance domains intersecting with the
 	 * CPUs of the rd. Protected by RCU.
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 44ed3d0..63aecd2 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2514,16 +2514,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	/* Attach the domains */
 	rcu_read_lock();
 	for_each_cpu(i, cpu_map) {
-		unsigned long capacity;
-
 		rq = cpu_rq(i);
 		sd = *per_cpu_ptr(d.sd, i);
 
-		capacity = arch_scale_cpu_capacity(i);
-		/* Use READ_ONCE()/WRITE_ONCE() to avoid load/store tearing: */
-		if (capacity > READ_ONCE(d.rd->max_cpu_capacity))
-			WRITE_ONCE(d.rd->max_cpu_capacity, capacity);
-
 		cpu_attach_domain(sd, d.rd, i);
 
 		if (lowest_flag_domain(i, SD_CLUSTER))
@@ -2537,10 +2530,8 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	if (has_cluster)
 		static_branch_inc_cpuslocked(&sched_cluster_active);
 
-	if (rq && sched_debug_verbose) {
-		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
-			cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
-	}
+	if (rq && sched_debug_verbose)
+		pr_info("root domain span: %*pbl\n", cpumask_pr_args(cpu_map));
 
 	ret = 0;
 error:

