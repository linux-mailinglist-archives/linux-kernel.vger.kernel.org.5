Return-Path: <linux-kernel+bounces-116938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EAC88A550
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4E52C684B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FCB1C9ECE;
	Mon, 25 Mar 2024 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z06D15Hn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CZ1dn4T5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36D21B6769;
	Mon, 25 Mar 2024 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711366104; cv=none; b=THUSSDjqyCDwX7Y2+d1b8WNNmk+9mgSgwq+M3rtD3YaO6baBU/YkSuhf42VYL7KaXXW28Iemi5dYL8GTeJfzMfZRmHW3yiAmJudYxdxiW78p6u63uPAzi3U9EjLltPEXVW8ZON4AA6E/Wubh1SwlQPdf/I8M3fNyPIIzcVIc/V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711366104; c=relaxed/simple;
	bh=YS+Hdc0FQ2ruuN16lR4wOAhHklhVdZV0KLqmhzkQuec=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=vGH1bOokOfzXvtHiFyFaCaq8Ho60LvmeGDIsinusgcDQUJrOPmoTkzqRl82XhrPr6OSuUwYpmF9ns4cefZB0HFKgU4bVs0GHvv1ob0mBNPkupmdqYZHcCFZxprk8fB0HJNukK992fCKNf4YC+oQzh9m8iQ0mxB/+ZVso7GCOrE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z06D15Hn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CZ1dn4T5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Mar 2024 11:28:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711366101;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fGauF6AT2ue4vYZSk7napXXPBw8PNlF5GtiB9b3dgZY=;
	b=Z06D15HnD9259/Q1/AzRN/woPMU/Z37OPCWHjm/VC7ACUK6fGKf6z0xq/bJvRj/Orzx1jU
	Q7qWRc2Yb48JouHs80oqA+hH5vC1b4BF/DN+CYgIOeHLjF2WMASvZ3k/eU9V5C0Rvw1G3H
	+et36tpB3ZGQE2gImWTz5F+upAXRPd1LmzEYMF2Y4PQbdH3vjuF9TB1lE5u8oEZ/VnVQ6k
	OAbmsEvJURh+Ti3c8vnJEabSFr7HsHfoH5AIxHw7RRcRPQA5dxtmIVWr3NV9xJfSl43YTa
	Jdsa1veSItQneVZIQE8+CelvDF9PZm7AyDcMAmX8KJa1y1Pr2PSSuTKY4XhU4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711366101;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fGauF6AT2ue4vYZSk7napXXPBw8PNlF5GtiB9b3dgZY=;
	b=CZ1dn4T5Uumnwjja2Zkrvouh/LjwJ3Z5WGG5H4NQdAkLbxjjTPVoi4gmCaZgg01wuz3oyD
	Hs81HTav9Iqn0sDg==
From: "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Export asym_cap_list
Cc: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240324004552.999936-2-qyousef@layalina.io>
References: <20240324004552.999936-2-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171136610032.10875.2343914683147581353.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     77222b0d12e8ae6f082261842174cc2e981bf99c
Gitweb:        https://git.kernel.org/tip/77222b0d12e8ae6f082261842174cc2e981bf99c
Author:        Qais Yousef <qyousef@layalina.io>
AuthorDate:    Sun, 24 Mar 2024 00:45:49 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 25 Mar 2024 12:09:53 +01:00

sched/topology: Export asym_cap_list

So that we can use it to iterate through available capacities in the
system. Sort asym_cap_list in descending order as expected users are
likely to be interested on the highest capacity first.

Make the list RCU protected to allow for cheap access in hot paths.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240324004552.999936-2-qyousef@layalina.io
---
 kernel/sched/sched.h    | 14 +++++++++++++-
 kernel/sched/topology.c | 43 +++++++++++++++++++++++-----------------
 2 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 41024c1..f77c00d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -110,6 +110,20 @@ extern int sysctl_sched_rt_runtime;
 extern int sched_rr_timeslice;
 
 /*
+ * Asymmetric CPU capacity bits
+ */
+struct asym_cap_data {
+	struct list_head link;
+	struct rcu_head rcu;
+	unsigned long capacity;
+	unsigned long cpus[];
+};
+
+extern struct list_head asym_cap_list;
+
+#define cpu_capacity_span(asym_data) to_cpumask((asym_data)->cpus)
+
+/*
  * Helpers for converting nanosecond timing to jiffy resolution
  */
 #define NS_TO_JIFFIES(TIME)	((unsigned long)(TIME) / (NSEC_PER_SEC / HZ))
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 99ea598..44ed3d0 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1330,23 +1330,12 @@ next:
 }
 
 /*
- * Asymmetric CPU capacity bits
- */
-struct asym_cap_data {
-	struct list_head link;
-	unsigned long capacity;
-	unsigned long cpus[];
-};
-
-/*
  * Set of available CPUs grouped by their corresponding capacities
  * Each list entry contains a CPU mask reflecting CPUs that share the same
  * capacity.
  * The lifespan of data is unlimited.
  */
-static LIST_HEAD(asym_cap_list);
-
-#define cpu_capacity_span(asym_data) to_cpumask((asym_data)->cpus)
+LIST_HEAD(asym_cap_list);
 
 /*
  * Verify whether there is any CPU capacity asymmetry in a given sched domain.
@@ -1386,21 +1375,39 @@ asym_cpu_capacity_classify(const struct cpumask *sd_span,
 
 }
 
+static void free_asym_cap_entry(struct rcu_head *head)
+{
+	struct asym_cap_data *entry = container_of(head, struct asym_cap_data, rcu);
+	kfree(entry);
+}
+
 static inline void asym_cpu_capacity_update_data(int cpu)
 {
 	unsigned long capacity = arch_scale_cpu_capacity(cpu);
-	struct asym_cap_data *entry = NULL;
+	struct asym_cap_data *insert_entry = NULL;
+	struct asym_cap_data *entry;
 
+	/*
+	 * Search if capacity already exits. If not, track which the entry
+	 * where we should insert to keep the list ordered descendingly.
+	 */
 	list_for_each_entry(entry, &asym_cap_list, link) {
 		if (capacity == entry->capacity)
 			goto done;
+		else if (!insert_entry && capacity > entry->capacity)
+			insert_entry = list_prev_entry(entry, link);
 	}
 
 	entry = kzalloc(sizeof(*entry) + cpumask_size(), GFP_KERNEL);
 	if (WARN_ONCE(!entry, "Failed to allocate memory for asymmetry data\n"))
 		return;
 	entry->capacity = capacity;
-	list_add(&entry->link, &asym_cap_list);
+
+	/* If NULL then the new capacity is the smallest, add last. */
+	if (!insert_entry)
+		list_add_tail_rcu(&entry->link, &asym_cap_list);
+	else
+		list_add_rcu(&entry->link, &insert_entry->link);
 done:
 	__cpumask_set_cpu(cpu, cpu_capacity_span(entry));
 }
@@ -1423,8 +1430,8 @@ static void asym_cpu_capacity_scan(void)
 
 	list_for_each_entry_safe(entry, next, &asym_cap_list, link) {
 		if (cpumask_empty(cpu_capacity_span(entry))) {
-			list_del(&entry->link);
-			kfree(entry);
+			list_del_rcu(&entry->link);
+			call_rcu(&entry->rcu, free_asym_cap_entry);
 		}
 	}
 
@@ -1434,8 +1441,8 @@ static void asym_cpu_capacity_scan(void)
 	 */
 	if (list_is_singular(&asym_cap_list)) {
 		entry = list_first_entry(&asym_cap_list, typeof(*entry), link);
-		list_del(&entry->link);
-		kfree(entry);
+		list_del_rcu(&entry->link);
+		call_rcu(&entry->rcu, free_asym_cap_entry);
 	}
 }
 

