Return-Path: <linux-kernel+bounces-13772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3AE820C53
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 18:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE4B1F217EA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 17:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B703BA5F;
	Sun, 31 Dec 2023 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="PvAbRCAZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD62B65D
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-336c5b5c163so2810016f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 09:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1704045152; x=1704649952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTmtGOfOLbd7rqlqlu7Rh0XV04/TE/VO7ZC0eJB267k=;
        b=PvAbRCAZ6hTv4gReYYugaYGjkbsGkMSA0qgBg4XAgk3S1rKGoWtkIfC0gJTay5pVw1
         uc0lGc7CLH/YKGnl/rbunFyzVLOrVCoXscBR71H42qCYHtkNa1dJzhTjvnpgPaiYf26l
         SJ5AqXSoB7tmTJq7RIA1fqAKfHEUlQTECRdxFnuFqz2Fn5kczI/QErdIKlfPdCncPzCM
         5ji72aGI54+vsw6tBFrFUc2813LU188WlnfCSWA0Y5kaqgQKGH2A/DyBV/xMMrWLI7/7
         10T1a/+mZmXiasuJznMr/Mx6oFoZnLkgHG5O0yVl29UgpqcjEc37waJSjFFtx7IFkCR9
         8qTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704045152; x=1704649952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTmtGOfOLbd7rqlqlu7Rh0XV04/TE/VO7ZC0eJB267k=;
        b=nQu0CJVP2xFuYUSXWTTd2bLCbAUY/vwl8cpaa9hwkfIwUvWPOHf2oltAiDRPSKawcM
         JDBVZj8Q/zpqQjqY+K49gA5VmmqF2ThmZHi/wxSaJxcbQYtjbd/y+SKY7own9xprmYAV
         tUGmlR2dI5MNuxEFSgF6AORvkNkk1AtgfTOsSH/c7IxJH21sLLGYvePDWyHoUxByGhxS
         GTp7yAKP6kK23+pUwoPkaA510MWYBWmg1gskZur7tpdkLDx22YZaio2Y9Ov0RAi30XK5
         2kJi/g7+aVRKCU0nV4QhwQeLZ059TaMY6lCSxbwBSR2+wl3c6jsrqa/AhCaJSUlvGSNJ
         agzw==
X-Gm-Message-State: AOJu0YxF2D0aX8Gefq0niMJfI0JIcAfXBG1H5jNydbbw/e+RwzMHEJyC
	62qBC9PhuP9ydl4dPO71JFUiQ8BapSe0VA==
X-Google-Smtp-Source: AGHT+IExCxJA1tIa/FTBHj6ESra05CcxZAcKOa03vSXqp1vJK8CQyNV4KxBfPqywDr7s7tKLv28Dew==
X-Received: by 2002:adf:f30f:0:b0:336:834e:d912 with SMTP id i15-20020adff30f000000b00336834ed912mr6995144wro.13.1704045152316;
        Sun, 31 Dec 2023 09:52:32 -0800 (PST)
Received: from airbuntu.. (host109-154-238-212.range109-154.btcentralplus.com. [109.154.238.212])
        by smtp.gmail.com with ESMTPSA id h17-20020a5d4311000000b003373f723dcbsm1229120wrq.42.2023.12.31.09.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 09:52:32 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	"Pierre Gondois" <Pierre.Gondois@arm.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v3 2/2] sched/topology: Sort asym_cap_list in descending order
Date: Sun, 31 Dec 2023 17:52:18 +0000
Message-Id: <20231231175218.510721-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231231175218.510721-1-qyousef@layalina.io>
References: <20231231175218.510721-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So that searches always start from biggest CPU which would help misfit
detection logic to be more efficient.

I see the following when adding trace_printks() during add and del
operations

            init-1       [000] .....     0.058128: asym_cpu_capacity_update_data: Added new capacity 250. Capacity list order:
            init-1       [000] .....     0.058132: asym_cpu_capacity_update_data: -- 250
            init-1       [000] .....     0.058135: asym_cpu_capacity_update_data: Added new capacity 620. Capacity list order:
            init-1       [000] .....     0.058136: asym_cpu_capacity_update_data: -- 620
            init-1       [000] .....     0.058137: asym_cpu_capacity_update_data: -- 250
            init-1       [000] .....     0.058139: asym_cpu_capacity_update_data: Added new capacity 1024. Capacity list order:
            init-1       [000] .....     0.058140: asym_cpu_capacity_update_data: -- 1024
            init-1       [000] .....     0.058141: asym_cpu_capacity_update_data: -- 620
            init-1       [000] .....     0.058142: asym_cpu_capacity_update_data: -- 250
            init-1       [000] .....     0.058143: asym_cpu_capacity_scan: Final capacity list order:
            init-1       [000] .....     0.058145: asym_cpu_capacity_scan: -- 1024
            init-1       [000] .....     0.058145: asym_cpu_capacity_scan: -- 620
            init-1       [000] .....     0.058146: asym_cpu_capacity_scan: -- 250
           <...>-244     [007] .....     1.959174: asym_cpu_capacity_update_data: Added new capacity 160. Capacity list order:
           <...>-244     [007] .....     1.959175: asym_cpu_capacity_update_data: -- 1024
           <...>-244     [007] .....     1.959176: asym_cpu_capacity_update_data: -- 620
           <...>-244     [007] .....     1.959176: asym_cpu_capacity_update_data: -- 250
           <...>-244     [007] .....     1.959176: asym_cpu_capacity_update_data: -- 160
           <...>-244     [007] .....     1.959183: asym_cpu_capacity_update_data: Added new capacity 498. Capacity list order:
           <...>-244     [007] .....     1.959184: asym_cpu_capacity_update_data: -- 1024
           <...>-244     [007] .....     1.959184: asym_cpu_capacity_update_data: -- 620
           <...>-244     [007] .....     1.959185: asym_cpu_capacity_update_data: -- 498
           <...>-244     [007] .....     1.959185: asym_cpu_capacity_update_data: -- 250
           <...>-244     [007] .....     1.959186: asym_cpu_capacity_update_data: -- 160
           <...>-244     [007] .....     1.959204: asym_cpu_capacity_scan: Deleted capacity 620
           <...>-244     [007] .....     1.959208: asym_cpu_capacity_scan: Deleted capacity 250
           <...>-244     [007] .....     1.959209: asym_cpu_capacity_scan: Final capacity list order:
           <...>-244     [007] .....     1.959209: asym_cpu_capacity_scan: -- 1024
           <...>-244     [007] .....     1.959210: asym_cpu_capacity_scan: -- 498
           <...>-244     [007] .....     1.959210: asym_cpu_capacity_scan: -- 160
         rcuop/7-66      [001] b....     1.968114: free_asym_cap_entry: Freeing capacity 620
         rcuop/7-66      [001] b....     1.968118: free_asym_cap_entry: Freeing capacity 250

Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/topology.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index ba4a0b18ae25..1505677e4247 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1384,18 +1384,30 @@ static void free_asym_cap_entry(struct rcu_head *head)
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
-	list_add_rcu(&entry->link, &asym_cap_list);
+
+	/* If NULL then the new capacity is the smallest, add last. */
+	if (!insert_entry)
+		list_add_tail_rcu(&entry->link, &asym_cap_list);
+	else
+		list_add_rcu(&entry->link, &insert_entry->link);
 done:
 	__cpumask_set_cpu(cpu, cpu_capacity_span(entry));
 }
-- 
2.34.1


