Return-Path: <linux-kernel+bounces-12488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6A481F585
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC70D28247E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FED4439;
	Thu, 28 Dec 2023 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XSszNFTb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8EB4402
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 07:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shakeelb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5eb6dba1796so62945187b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 23:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703748667; x=1704353467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NREzK8/wmujY6hf4hjlWHbSO7quR4xEc0yBGUCASod4=;
        b=XSszNFTbU2fW1dqk5+s2HCvZHIyJ2VY3uDNzC5CxZq1HAwZUvDQN20q8iVJuSC8L/5
         GKQ7IiGNabv014L9XGyS8s7o8uIGaTpvPQBsn9kDRHtbFZlCRdqLDOQGAu8LOj0Av3cK
         a8nwGol+3cHmhLPqwZQSDnG6WRVp3H9lnIsSWF5aTRKYrifY4E6aCzbmS2tgB+ID2qJd
         Ceaio+P6ptiON8ZnqxhBt0ye1YueZLsKCSw0IhzoZYA7cWqqKucZC5V4qaidJHr4N3Qw
         u45CoOyfwdMMcvL8/5Kkyyl3RjrPZylsg4uHvDFxa1hU2avKeu0v8lqT+XqcTuTLF/yL
         Jubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703748667; x=1704353467;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NREzK8/wmujY6hf4hjlWHbSO7quR4xEc0yBGUCASod4=;
        b=EBMIQaBgq6VRqKUh7JQ4Cvv4ZGfS3reoUQ+8DQ/61onnhMQcDSqoVkdsu2+vJj7gTA
         EMkYHDwlAiR1nQZ3XZD7MUPZr/BIQK4vCiaOQzzpk36dEh+pz40HsWY1wrd03pcdlPZR
         rh5kGqDmh0bja1gTwD6x6mciaXaH3WHW4bc8Apx26mz1YhR3xu+FSix8SOOtWF4KN+Z9
         JHdbwKA4yyL9giZuaE4LUoK1+vm7kVey6uxJUt4niIxVkwDh4weTIhoc8f12LM0xwUzl
         n20DmGB6Q/31nxoBQVeyTQIYynKh5cTxgnkZeKKSqpp7qhGkmpoRbLlXYRZdDnsTl32R
         Q4UA==
X-Gm-Message-State: AOJu0Yy6wtV4dqFtqpDdlvIeQaYVaGnlCQTLsSx9EtP8KXr0yAbGZenu
	gUhAMJlyy2Yqiw67EA3XKMbEczl9RgvKVSdpEUTk
X-Google-Smtp-Source: AGHT+IGaA30rkF4pNPWE7IN7ftUo+1evzpA09h7euNCR6pksQ2NRwRhyHGW5wC1NyNJI/mF/D74/Qfyabzc0Rg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:690c:b0d:b0:5d3:84d4:eb35 with SMTP
 id cj13-20020a05690c0b0d00b005d384d4eb35mr5018905ywb.3.1703748667481; Wed, 27
 Dec 2023 23:31:07 -0800 (PST)
Date: Thu, 28 Dec 2023 07:30:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231228073055.4046430-1-shakeelb@google.com>
Subject: [PATCH] mm: ratelimit stat flush from workingset shrinker
From: Shakeel Butt <shakeelb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yu Zhao <yuzhao@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"

One of our internal workload regressed on newer upstream kernel and on
further investigation, it seems like the cause is the always synchronous
rstat flush in the count_shadow_nodes() added by the commit f82e6bf9bb9b
("mm: memcg: use rstat for non-hierarchical stats"). On further
inspection it seems like we don't really need accurate stats in this
function as it was already approximating the amount of appropriate
shadow entried to keep for maintaining the refault information. Since
there is already 2 sec periodic rstat flush, we don't need exact stats
here. Let's ratelimit the rstat flush in this code path.

Fixes: f82e6bf9bb9b ("mm: memcg: use rstat for non-hierarchical stats")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/workingset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 2a2a34234df9..226012974328 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -680,7 +680,7 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 		struct lruvec *lruvec;
 		int i;
 
-		mem_cgroup_flush_stats(sc->memcg);
+		mem_cgroup_flush_stats_ratelimited(sc->memcg);
 		lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
 		for (pages = 0, i = 0; i < NR_LRU_LISTS; i++)
 			pages += lruvec_page_state_local(lruvec,
-- 
2.43.0.472.g3155946c3a-goog


