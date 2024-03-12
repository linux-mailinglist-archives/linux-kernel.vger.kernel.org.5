Return-Path: <linux-kernel+bounces-100215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C3F87939D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74BFF1F2200F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA547D3FC;
	Tue, 12 Mar 2024 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="34Qtdwet";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cFWyfzEd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E887CF0A;
	Tue, 12 Mar 2024 12:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244834; cv=none; b=r/V5Wv7yKYFeLB/CYyc8AKcODLojrUV0z6Adm1GBwaQampAsytzL1Tjda9c7nr0aMenBq8BFriBebzDWCgQqh1rree59JWE0RFO5LHZoL67zwH/v6sl6p0UjoGDb2cIjOkNeazq6fwXz0UZSiVAgngMQupNM8eIRQ+X+XnTGci8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244834; c=relaxed/simple;
	bh=8g8ssDEsGYMGiMVRsHGCx7TjAPUTYetZ3H8KsEL0udQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QiRyBtNG02TL/xs3uMQtQx0vw82ofBiAQT0s+himBHt4FU/iGzEX3mSOCiMETX67Pjt3n5HyccMbE6LBHV5nMtW3CvqoJR02LfNmfh8s25m69X1/bi7DzkhzoxJiXu4CeYt3uXTPtTKjhMpTWJ6XLBNP0Ig+h2DTJVsf5zDjkBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=34Qtdwet; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cFWyfzEd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 12:00:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710244830;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=coLR6vFwaIE38cA1zaq85aVHTyXVgLKlB7FcGnEpxJM=;
	b=34QtdwetuFMUUhKPcijn3KMVGXHRbO3x1Wwg/J/DjaOKWk0gHv5hvuZk8R5xflvTNvJJwH
	nPBbKLhEmU8JVJA7xxMjsio/uTNDO/xmJLYP+mf6UC713X1NhtkUE85LsQDHVpGhCAixZS
	SsbnCHT98oJviNVOIEGl72ovXAKR2FyG9otvl8hpL1j/bjsV6qyz6bmnuLfBvr5k2zoY3m
	13pnAhw7oG8ZRz/hwGf9OqwqanpjDzlw361oeZ2KnRaDomqI5LcbG0z83kBPfLgpHRcWT0
	wJz78k2FSWjVwex0OImiNuGfpoWRHaL36w45uoiKpkiJoiRhmj9tHg1WW6aJVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710244830;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=coLR6vFwaIE38cA1zaq85aVHTyXVgLKlB7FcGnEpxJM=;
	b=cFWyfzEdu5U1l2N3Cbu3YjNfIxndoZGAy6icR5w0k4k8w6Incfa//Tlj2NrPyF7Dx6hxFF
	qFhHlehReaSWG+Dw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/balancing: Vertically align the comments of
 'struct sg_lb_stats' and 'struct sd_lb_stats'
Cc: Ingo Molnar <mingo@kernel.org>, Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240308105901.1096078-10-mingo@kernel.org>
References: <20240308105901.1096078-10-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171024482986.398.7681408639990321939.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e492e1b0e0721f3929ef9d9708d029144b396dd7
Gitweb:        https://git.kernel.org/tip/e492e1b0e0721f3929ef9d9708d029144b396dd7
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 08 Mar 2024 11:59:00 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Mar 2024 11:59:59 +01:00

sched/balancing: Vertically align the comments of 'struct sg_lb_stats' and 'struct sd_lb_stats'

Make them easier to read.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240308105901.1096078-10-mingo@kernel.org
---
 kernel/sched/fair.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b567c07..40b98e4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9436,19 +9436,19 @@ static void update_blocked_averages(int cpu)
  * sg_lb_stats - stats of a sched_group required for load_balancing
  */
 struct sg_lb_stats {
-	unsigned long avg_load; /*Avg load across the CPUs of the group */
-	unsigned long group_load; /* Total load over the CPUs of the group */
+	unsigned long avg_load;			/* Avg load across the CPUs of the group */
+	unsigned long group_load;		/* Total load over the CPUs of the group */
 	unsigned long group_capacity;
-	unsigned long group_util; /* Total utilization over the CPUs of the group */
-	unsigned long group_runnable; /* Total runnable time over the CPUs of the group */
-	unsigned int sum_nr_running; /* Nr of tasks running in the group */
-	unsigned int sum_h_nr_running; /* Nr of CFS tasks running in the group */
+	unsigned long group_util;		/* Total utilization over the CPUs of the group */
+	unsigned long group_runnable;		/* Total runnable time over the CPUs of the group */
+	unsigned int sum_nr_running;		/* Nr of tasks running in the group */
+	unsigned int sum_h_nr_running;		/* Nr of CFS tasks running in the group */
 	unsigned int idle_cpus;
 	unsigned int group_weight;
 	enum group_type group_type;
-	unsigned int group_asym_packing; /* Tasks should be moved to preferred CPU */
-	unsigned int group_smt_balance;  /* Task on busy SMT be moved */
-	unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
+	unsigned int group_asym_packing;	/* Tasks should be moved to preferred CPU */
+	unsigned int group_smt_balance;		/* Task on busy SMT be moved */
+	unsigned long group_misfit_task_load;	/* A CPU has a task too big for its capacity */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
 	unsigned int nr_preferred_running;
@@ -9460,15 +9460,15 @@ struct sg_lb_stats {
  *		 during load balancing.
  */
 struct sd_lb_stats {
-	struct sched_group *busiest;	/* Busiest group in this sd */
-	struct sched_group *local;	/* Local group in this sd */
-	unsigned long total_load;	/* Total load of all groups in sd */
-	unsigned long total_capacity;	/* Total capacity of all groups in sd */
-	unsigned long avg_load;	/* Average load across all groups in sd */
-	unsigned int prefer_sibling; /* tasks should go to sibling first */
-
-	struct sg_lb_stats busiest_stat;/* Statistics of the busiest group */
-	struct sg_lb_stats local_stat;	/* Statistics of the local group */
+	struct sched_group *busiest;		/* Busiest group in this sd */
+	struct sched_group *local;		/* Local group in this sd */
+	unsigned long total_load;		/* Total load of all groups in sd */
+	unsigned long total_capacity;		/* Total capacity of all groups in sd */
+	unsigned long avg_load;			/* Average load across all groups in sd */
+	unsigned int prefer_sibling;		/* tasks should go to sibling first */
+
+	struct sg_lb_stats busiest_stat;	/* Statistics of the busiest group */
+	struct sg_lb_stats local_stat;		/* Statistics of the local group */
 };
 
 static inline void init_sd_lb_stats(struct sd_lb_stats *sds)

