Return-Path: <linux-kernel+bounces-73785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DE685CB33
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE87283F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF3A15443B;
	Tue, 20 Feb 2024 22:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="TtK4QeHY"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9AD78688
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469799; cv=none; b=qgiCuBQsOdwgK4IBJSvB7XqBiUHQg1jikkmRkgDayGkJFxRvAxfZekSc2+wWiCuyb3ldUmODg/C8YlVdk2a71LNKQ3Z/e4/dDPJ9dE9mqFBjdu7BAURPsyOOo6pVfbdkyR2rL/rOpWeyI3Z60FiMNx0GLW14ShU3zBUk4XD5iS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469799; c=relaxed/simple;
	bh=pJbxNcidnAquuRUBnbM5G/Xt7klZVoRT5zrWcv5qa6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MvVyx7EOIInqaskGzESPDIaD72yKEoFjM8zEEVuJ8D9JkuPjS5yBr6kbj7cpOujfekU/GG3HahSeisT2szc0iFmnThX9d+TpLb50tO7DT4PWUA5rEW4mfiT6rE+TBBfHqoNYYjQ3mIs1wmnt8LNg1RRORBZ0eA7Lx0tTwHJ9mnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=TtK4QeHY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3f1bf03722so91537066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708469796; x=1709074596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aT2II4hSJb5JlN6Q/dAyII0ZNTG9/pbj1emmIil5nPc=;
        b=TtK4QeHYY3eKULAkUjZCc5wxcQqszXYiU1IjCYCTWVnRp/0gpbt9n7RlUoDxBv/iQ8
         Dl0Hk85lrmqMSQS77IiV0tQn5xvPCxwla2j5Htuw2H7DgEBfIsV5XHcrZV2ko3VLZf+P
         5B6Vt3euYWRBH8AP2Q6yTlNpoHlJYXs8nMoxYSchbyAnYscm7xd/hvchIqh+NP2SRECm
         4nAYIgLR0+3+QD/v4AsGE3qkiZuxGn3Yz+OLZkRbvI4txvFg5YD0UQFViPuTrIoAPbd7
         rGaG4xHw2/fRmPeBtLqrsBCxpodGfVzz5o0QEaQacNDvIW8KQV8KC1/HICYqgJZFoeLm
         F2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708469796; x=1709074596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aT2II4hSJb5JlN6Q/dAyII0ZNTG9/pbj1emmIil5nPc=;
        b=fyglTSC56NlYwzuJEI0JocZn+LlFWLLgQ/0pxIdfY9CFM7xDGc0WrjEArtlk8/dG4i
         bLs6LvgPWaAPuuYsK5lqEkdudg+EZ6mMOSQexA656QcGEmkW31FZh0p0irrwrZxJzsgz
         1Qq6qxVZAYMIXZwI6c7ksuGuhysaionn4r8JUZBKpPGErrUEVNzEQg4H4TLBPc6YWrfW
         lJUe08tNquQ6gzUipoXQXLozFAmDY3GEwC4fQ+9K9CdwmjqDy1eUqXufoR/y6VwY2OyA
         yA1lSnx49Z28/e1zWQ3b1DYaFIzoPo91MRIPWxD0dUwpvcCwESKVgPNK8O7y/V3yNKk1
         hx8w==
X-Gm-Message-State: AOJu0YwDRt+6oVS2KwawqnH8G83a9nLG/0A72LsdyfYAG/WWQ8262HaN
	Ki1hg8pC7spa6GxW6Quc5x8lK4szS29obPcaHFztq8ch2Zf6NCoWiVbZltdXbyE=
X-Google-Smtp-Source: AGHT+IHdWfx7cLwsPeIhe8u/keSXJ7SEWTP42c9O/UxSWDheo2IV2uhYtI1XKt3FebDxbN6Z/OPI2g==
X-Received: by 2002:a17:906:60b:b0:a3e:b8e4:2b6b with SMTP id s11-20020a170906060b00b00a3eb8e42b6bmr4372934ejb.17.1708469795797;
        Tue, 20 Feb 2024 14:56:35 -0800 (PST)
Received: from airbuntu.. (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id vw13-20020a170907a70d00b00a3c5d10bcdbsm4381946ejc.114.2024.02.20.14.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:56:35 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	"Pierre Gondois" <Pierre.Gondois@arm.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v6 1/4] sched/topology: Export asym_capacity_list
Date: Tue, 20 Feb 2024 22:56:19 +0000
Message-Id: <20240220225622.2626569-2-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220225622.2626569-1-qyousef@layalina.io>
References: <20240220225622.2626569-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So that we can use it to iterate through available capacities in the
system. Sort asym_cap_list in descending order as expected users are
likely to be interested on the highest capacity first.

Make the list RCU protected to allow for cheap access in hot paths.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/sched.h    | 14 ++++++++++++++
 kernel/sched/topology.c | 43 ++++++++++++++++++++++++-----------------
 2 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 001fe047bd5d..e85976bd2bab 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -109,6 +109,20 @@ extern int sysctl_sched_rt_period;
 extern int sysctl_sched_rt_runtime;
 extern int sched_rr_timeslice;
 
+/*
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
 /*
  * Helpers for converting nanosecond timing to jiffy resolution
  */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 10d1391e7416..1505677e4247 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1329,24 +1329,13 @@ static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
 	update_group_capacity(sd, cpu);
 }
 
-/*
- * Asymmetric CPU capacity bits
- */
-struct asym_cap_data {
-	struct list_head link;
-	unsigned long capacity;
-	unsigned long cpus[];
-};
-
 /*
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
 
-- 
2.34.1


