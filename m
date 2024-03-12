Return-Path: <linux-kernel+bounces-100214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E5A87939B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF697B24257
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA7F7D07A;
	Tue, 12 Mar 2024 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4OXF0jcY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZNb24sP0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121A77C6EF;
	Tue, 12 Mar 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244833; cv=none; b=LhkR/dJunOsVzsIYFibuWAKZBF+xO7QhdKGX7/nWvAgjjEhdonaYy96gXGrYcvT9hiOFtX3un2lgUhtNbkZTrLZzcTNErEuNkxvxfKjHiBMQZ6CoYVvgKakBKzQijBdT9Bfk7modDqjAPgCQ1zjL+Tk/YexfzgOIe+A5TpX6cfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244833; c=relaxed/simple;
	bh=STNNV4G6PBt9KhZgP9Z/aCGpaRgbnN5ELpCvtYVD8cY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=krEOrRP4ofLsY8bAJE96UTkyinVMBGOaf5ozbfsiAp1iIR+7O3xcqlhdg51S+KWgPuu2M/X6xa2su/ZaASlvedO4ZrRRqBvOruuxIDWv9+ll64jeJbWWwqgx+OSODkn+HP6cOrHTEflKCpbPuu+NneIuQ64xv8b7S4lDaV1Iodw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4OXF0jcY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZNb24sP0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 12:00:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710244830;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rNVlftGwreDGZhV+WF0GbA5V8/eeGc6R0IsvECIa4ZA=;
	b=4OXF0jcYRKg13fUVknQVj3hhNS0zyVof8UHtmk1F5t6Q/0yR9/SL7UXabnkulkWMg3UvFv
	Jncq7ugWzNbGBY52+Z6wTEnVC5MYSsgnTA2TMkVxt8HvWRPEfHStjEoioWA4+RG9h0Gp9Q
	NSfnfbswiBShBCLO3bmV63veHgbBdIJv94Jn5j3JgZv9Gtw5hPzDv0hGWx2Ys9OuklFO5A
	p7JxeG5b07X+JevuskbjtNVlQ7s+T8xphVyWkhqbRznjJ4yl4Z6RCfB2RGZmZ5kBsiGWzt
	POk/v1TVYSgxzPKd2cKW+d/4K7v9gIgkTrWFdJhlGed2uERv6l0bXh6wZmV5dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710244830;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rNVlftGwreDGZhV+WF0GbA5V8/eeGc6R0IsvECIa4ZA=;
	b=ZNb24sP0pjWE9QKUATEpSd3I/bfKdqTPRsAYIOqovH4SG/hiZj58G7MH4uI8sKsByW3Ya+
	PbGMxZFTu/A53SBg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/balancing: Update comments in 'struct
 sg_lb_stats' and 'struct sd_lb_stats'
Cc: Ingo Molnar <mingo@kernel.org>, Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240308105901.1096078-11-mingo@kernel.org>
References: <20240308105901.1096078-11-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171024482862.398.8275371595697685705.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     33928ed8bde066316dc3cb6ccf7f74400073652f
Gitweb:        https://git.kernel.org/tip/33928ed8bde066316dc3cb6ccf7f74400073652f
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 08 Mar 2024 11:59:01 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Mar 2024 11:59:59 +01:00

sched/balancing: Update comments in 'struct sg_lb_stats' and 'struct sd_lb_stats'

- Align for readability
- Capitalize consistently

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240308105901.1096078-11-mingo@kernel.org
---
 kernel/sched/fair.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 40b98e4..116a640 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9433,17 +9433,17 @@ static void update_blocked_averages(int cpu)
 /********** Helpers for find_busiest_group ************************/
 
 /*
- * sg_lb_stats - stats of a sched_group required for load_balancing
+ * sg_lb_stats - stats of a sched_group required for load-balancing:
  */
 struct sg_lb_stats {
-	unsigned long avg_load;			/* Avg load across the CPUs of the group */
-	unsigned long group_load;		/* Total load over the CPUs of the group */
-	unsigned long group_capacity;
-	unsigned long group_util;		/* Total utilization over the CPUs of the group */
+	unsigned long avg_load;			/* Avg load            over the CPUs of the group */
+	unsigned long group_load;		/* Total load          over the CPUs of the group */
+	unsigned long group_capacity;		/* Capacity            over the CPUs of the group */
+	unsigned long group_util;		/* Total utilization   over the CPUs of the group */
 	unsigned long group_runnable;		/* Total runnable time over the CPUs of the group */
-	unsigned int sum_nr_running;		/* Nr of tasks running in the group */
+	unsigned int sum_nr_running;		/* Nr of all tasks running in the group */
 	unsigned int sum_h_nr_running;		/* Nr of CFS tasks running in the group */
-	unsigned int idle_cpus;
+	unsigned int idle_cpus;                 /* Nr of idle CPUs         in the group */
 	unsigned int group_weight;
 	enum group_type group_type;
 	unsigned int group_asym_packing;	/* Tasks should be moved to preferred CPU */
@@ -9456,8 +9456,7 @@ struct sg_lb_stats {
 };
 
 /*
- * sd_lb_stats - Structure to store the statistics of a sched_domain
- *		 during load balancing.
+ * sd_lb_stats - stats of a sched_domain required for load-balancing:
  */
 struct sd_lb_stats {
 	struct sched_group *busiest;		/* Busiest group in this sd */
@@ -9465,7 +9464,7 @@ struct sd_lb_stats {
 	unsigned long total_load;		/* Total load of all groups in sd */
 	unsigned long total_capacity;		/* Total capacity of all groups in sd */
 	unsigned long avg_load;			/* Average load across all groups in sd */
-	unsigned int prefer_sibling;		/* tasks should go to sibling first */
+	unsigned int prefer_sibling;		/* Tasks should go to sibling first */
 
 	struct sg_lb_stats busiest_stat;	/* Statistics of the busiest group */
 	struct sg_lb_stats local_stat;		/* Statistics of the local group */

