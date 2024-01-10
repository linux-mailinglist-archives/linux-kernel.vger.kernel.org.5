Return-Path: <linux-kernel+bounces-21624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E3382920A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7316289CC6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CD133D6;
	Wed, 10 Jan 2024 01:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MvyDGcAf"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D362595
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 01:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbed375def6so4640467276.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 17:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704849758; x=1705454558; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oxelwYVTfqx3BsJBc98Q1mFz+9jmLLkrSjInccUU7OY=;
        b=MvyDGcAffBko7JXl6ZvADYXaW9PT5o3mXomrOjt1msiwbPgEq9QB421i9smJEP6ofY
         rcLaz1VNFStIwRT2oyk2S/3WgdYOpTyP6rzRWjcLxPswIkiBqykHFHHC+EAk3oV8wRvL
         v1au1Ga4mWlSkjzbgmH4vnfV4mUruTYRMRfhcJzS4b5oDE06x9SFGTLlTjrIVRe4IKnN
         r4cLxrvcDqAs/46ZhURnxZCkg4nqiJPUowSAYTifYt7vA82ubbFDiwi6SKmu3PXH+cEh
         MaA+sKQjHh10Igfg4+3GF5wpU/hEuaEx2ekXHvwCc/GTwVW0dy4xZRf32ha+9+7r50Xg
         mQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704849758; x=1705454558;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oxelwYVTfqx3BsJBc98Q1mFz+9jmLLkrSjInccUU7OY=;
        b=Wp6hhvFmJsV6aVAxNe14l5DfTumFVnUA08UWsLK8lCWbN/hKk7+ae8j3IlT9oFi5WK
         SBx6ZtF0aDAjQm9VRhrvra5ebqL20uoA0jihWjke9UFVQAncR+W5XvI1FNSyCOqOUfqI
         U1pW2D9aqMXznjVNaFvpARyzTOeLguSFxJ0Z6tEUkPaHhqOkRFpbjts0jrtIMiuMQEkj
         2jtTC/wp9scRPmXcpmZ7g/avbwvL4Dot0Y5DKpXCFT5oLmI7HpTloDSi3cqmtWlpz0sV
         WpWpEKknAv/Mf4BikdB9f48EJqnuemvJQDa71Q5fH4Zu9VwUmzue/oNBnHjBBrmsP+wH
         1C8w==
X-Gm-Message-State: AOJu0YwRtPqj6ap7a9Xb6q3GZE7A5jWHH39fiE1JWEMxUzmN1oEBhv87
	lg+TfmUnYne3E8IJCFwFMn1qA8wB/YJt+8wm1fn1ecEO
X-Google-Smtp-Source: AGHT+IEwO3CkIi5BqYZ7/kmBvc2O4ubrd60l4MicjgcfNaoXF4Ph5JwiFjmqNVehIeJw8ttt7GJreAzLDO8sOWM1AA==
X-Received: from kalesh.mtv.corp.google.com ([2620:15c:211:201:c35c:511:8258:7aa2])
 (user=kaleshsingh job=sendgmr) by 2002:a25:8404:0:b0:dbe:d797:ef35 with SMTP
 id u4-20020a258404000000b00dbed797ef35mr644980ybk.3.1704849757983; Tue, 09
 Jan 2024 17:22:37 -0800 (PST)
Date: Tue,  9 Jan 2024 17:22:33 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240110012234.3793639-1-kaleshsingh@google.com>
Subject: [PATCH] mm/cma: Fix placement of trace_cma_alloc_start/finish
From: Kalesh Singh <kaleshsingh@google.com>
To: minchan@kernel.org, akpm@linux-foundation.org, lmark@codeaurora.org
Cc: surenb@google.com, android-mm@google.com, kernel-team@android.com, 
	Kalesh Singh <kaleshsingh@google.com>, Georgi Djakov <djakov@kernel.org>, 
	Liam Mark <quic_lmark@quicinc.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The current placement of trace_cma_alloc_start/finish misses the
fail cases: !cma || !cma->count || !cma->bitmap.

trace_cma_alloc_finish is also not emitted for the failure case
where bitmap_count > bitmap_maxno.

Fix these missed cases by moving the start event before the failure
checks and moving the finish event to the out label.

Fixes: 7bc1aec5e287 ("mm: cma: add trace events for CMA alloc perf testing")
Cc: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Liam Mark <lmark@codeaurora.org>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 mm/cma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 2b2494fd6b59..8341f1217a85 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -436,6 +436,9 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 	unsigned long i;
 	struct page *page = NULL;
 	int ret = -ENOMEM;
+	const char *name = cma ? cma->name : NULL;
+
+	trace_cma_alloc_start(name, count, align);
 
 	if (!cma || !cma->count || !cma->bitmap)
 		goto out;
@@ -446,8 +449,6 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 	if (!count)
 		goto out;
 
-	trace_cma_alloc_start(cma->name, count, align);
-
 	mask = cma_bitmap_aligned_mask(cma, align);
 	offset = cma_bitmap_aligned_offset(cma, align);
 	bitmap_maxno = cma_bitmap_maxno(cma);
@@ -496,8 +497,6 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 		start = bitmap_no + mask + 1;
 	}
 
-	trace_cma_alloc_finish(cma->name, pfn, page, count, align, ret);
-
 	/*
 	 * CMA can allocate multiple page blocks, which results in different
 	 * blocks being marked with different tags. Reset the tags to ignore
@@ -516,6 +515,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 
 	pr_debug("%s(): returned %p\n", __func__, page);
 out:
+	trace_cma_alloc_finish(name, pfn, page, count, align, ret);
 	if (page) {
 		count_vm_event(CMA_ALLOC_SUCCESS);
 		cma_sysfs_account_success_pages(cma, count);

base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
-- 
2.43.0.472.g3155946c3a-goog


