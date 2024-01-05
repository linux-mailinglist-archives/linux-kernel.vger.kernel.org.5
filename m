Return-Path: <linux-kernel+bounces-18394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA28825C7B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 23:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1477E1F24253
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FBE360B0;
	Fri,  5 Jan 2024 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="UTJiNpJS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511CB35887
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d5336986cso471695e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 14:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1704493225; x=1705098025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWGuJgogklqPmh8n8xzFrieuQl+MnLhc8WNAFcUfHaI=;
        b=UTJiNpJSW7rRdxjXOxMOPKEJP5dTvZgLO5/qb2GqJ6mAUoXVNof6tyEu+CHOgit9Q9
         Vsnj4uoeZEj5UVlsRMtwHQ9jouInmOnWPxJeH7+D44RGp2mImaiS48HUzbc+XXiXpoQc
         ZY8WrNi1U/I9Ki2M0W44oA64Z6sJ2hkinkzlmkzh3IrRuUvg2SAGmrU/aA6sBzNWMaQo
         jA3quIHfSjAQCcp2v9RkAdNq7EigLHri7vTy0H0Aj14sAvUkzm2C7GmvFwcoOs2FWZfB
         LVtwF6J//W+XCo7pxjR7SWfs8FwfWdqME4IiV66owKYP1vxx+Zn8IAjtmVVM+6mS86JP
         dmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704493225; x=1705098025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWGuJgogklqPmh8n8xzFrieuQl+MnLhc8WNAFcUfHaI=;
        b=W1SeNH5rRptm60NmTN24mCXoxvo4mWcTnzhTlggqEPmxWOCYIDtC1UdUP3N/fCxZ42
         y8iqHwXm9EyWZGUhrvxU3jT9/JsOedClaHKu0e3CjLk6bIZTZWG2WF69Jr9e6nCS0fqq
         dUXXMYoUhZZqg3OSjpd7wOoFW3i6+fODa9br4z/So7HmL3kIS7Zges6KkSOvF0LOs75n
         LdBGyvCf2Gipz///VUce6QBKUBUkiDTfTpK87JZsbu/WaDx6Jb2v/YBhdqmcb2QtrDWf
         5KpNBR8LVAyL/27EOccA8IJJ78MMuaah/p/ghhUO3O+lEBgWLeIXS5ASJeFb9YV0yVcw
         4mFw==
X-Gm-Message-State: AOJu0Yy/lYaej+vZ045qDYgBB1QACmK7bi6WnRx/80TJM41w0BcOo5xC
	WP0YDzDWMJuina201bos8LQ2tU1HyWrP6w==
X-Google-Smtp-Source: AGHT+IF5e6Ptga6N5JmjnD8EguIHth+StkWxSL4zqokrkjPRbVyUD5cRMvAz9McFy7S5XvoO6fiibw==
X-Received: by 2002:a05:600c:224d:b0:40d:582a:563a with SMTP id a13-20020a05600c224d00b0040d582a563amr86120wmm.44.1704493225518;
        Fri, 05 Jan 2024 14:20:25 -0800 (PST)
Received: from airbuntu.. (host109-154-238-212.range109-154.btcentralplus.com. [109.154.238.212])
        by smtp.gmail.com with ESMTPSA id q13-20020a05600c46cd00b0040d604dea3bsm2799022wmo.4.2024.01.05.14.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 14:20:25 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	"Pierre Gondois" <Pierre.Gondois@arm.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v4 2/2] sched/topology: Sort asym_cap_list in descending order
Date: Fri,  5 Jan 2024 22:20:14 +0000
Message-Id: <20240105222014.1025040-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105222014.1025040-1-qyousef@layalina.io>
References: <20240105222014.1025040-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So that searches always start from biggest CPU which would help misfit
detection logic to be more efficient.

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


