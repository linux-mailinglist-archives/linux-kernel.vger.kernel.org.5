Return-Path: <linux-kernel+bounces-64769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1507C85429E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F5A0B287AA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12132125BC;
	Wed, 14 Feb 2024 06:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="og/fa3q+"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84D611C80
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 06:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707890765; cv=none; b=gmnTCvS7IdSOKnwpsN/BkPcF1wl7OoZGUK4r1xqPfxhNxKmYjNizk6V46ZgTuqZ5PBNqIjy7ASOttEusR3xVf7SLtaUbiXM/mPeRLNGkYN8I5ZULdbFUcBtWFNasiyujsJOqUzlikQwIsJ1QMxSo8kjv+j7O0eqkUFn3DwsRNA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707890765; c=relaxed/simple;
	bh=zA3vgExuReWUwe5vdIcTKP6pAnPF79HFJPWi4qGi0jU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=abNElxGdT1HHZkNeZuWcsFXDLUTWgSWqylyGdaOeQRLy7jga1zYNC0miYhwEH2quq+r+oIOMQv6rHx9bC6voJK+PNvpPh/sTW6dkusQM7bTjQt2OpKKVFKoZGRr3OWd0L92eazuLtr+zNhSYFTuG3VfccTrV6Z4QewMPZEy1vE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=og/fa3q+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2968956dd6bso4119601a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707890763; x=1708495563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WP4kkPaAqTjN0MzajVa9lPmQ9VDuB302oaofmpmGZdQ=;
        b=og/fa3q+/vVkZb61SJYy6oVjejOH6UhXWPEfnudR8kxMeEwEsTu09lfHfpNFUKFJEL
         IFCBxy64VaD/puAWhtlIm9sq+KomDcwPQvjOeY4I9BZs2j1dPXNoG8mXtKa/vBahK/pY
         nO8UoKqoXigybb7QqG8yeAvwv9q16ng6le9uGvJ6ak0hZPO1/vxEds+iz8u9HMGhrmCa
         dllT48ouG/tR0d2TQ78ABZov2lW5NiLRcft8igHWxcM0aiYHNeutGa2Lh8sllBb9bThe
         Q0wF8zy0JJ6X+T2V7jmj4tBQ+Mwgc7ibIArURSGAzKtmm17Efi3ZVPS4jqNs0d8oCJns
         Vjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707890763; x=1708495563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WP4kkPaAqTjN0MzajVa9lPmQ9VDuB302oaofmpmGZdQ=;
        b=sZV+cIOHuu3Ib8YMZMKIYK4d7SACa0UbeDwKrPGgq1V8DupfsOKAJhEKqBQLI0OsyP
         41SDW6pahLawEDYWlfHnOumtLO8b9gJ5QH48BYUVzvv+khE8eF3bZqLLb0xz4p0TW0tk
         9jjrSpi3b7gqJBJGi0o0ScWEfvncR6zlPYNHMACoHDHhBJiotH1X4jmzLhZg+bZzT/9b
         PziUqf30CfGCbA9OJj+xwOFT4HvECKXhQbDQxkRlKfwFXcgbJ6kVuK7iFHcGppNUuwah
         CP0u2EtxVREPyUdEBqPghqVUxO2VPP6Vc/lPIjqlcgcOq23TByl7M2nq7sIIIHk4p6zP
         xfrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKphPY04sLSrpBH9fsxl1uSiwTz5uIwywQn2FFSIoaI4w8Ak2wK0+NGvw31ov1SJDp2VRsVYYlmq8fqXyaOl9B6LylWfKNj4NpG8SD
X-Gm-Message-State: AOJu0YyFnqkaZc5UR5HfwpC6Hq4FvzKLCRuNr8AlmC0L4IN/vRhgpi9P
	SXxjOlBGl1uHyRkwb7ZwdaFUGq6dhlAX/6Sy8oaNg58bN9vtYLH6kReLsge8MSUifOUW/sdautk
	+PwPu0Z3++w==
X-Google-Smtp-Source: AGHT+IEAKJ9kgF386MkOM3xFg+SPbOEIWEah+riJXPIPrS/5ct+Xs8R6OIjB4aSVppyEe2jFSaw8kcHvXKWoIQ==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a17:90b:4ccd:b0:298:966f:e7e1 with SMTP
 id nd13-20020a17090b4ccd00b00298966fe7e1mr38390pjb.4.1707890763039; Tue, 13
 Feb 2024 22:06:03 -0800 (PST)
Date: Wed, 14 Feb 2024 06:05:36 +0000
In-Reply-To: <20240214060538.3524462-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214060538.3524462-1-kinseyho@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240214060538.3524462-4-kinseyho@google.com>
Subject: [PATCH mm-unstable v1 3/5] mm/mglru: improve reset_mm_stats()
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Donet Tom <donettom@linux.vnet.ibm.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

struct lruvec* is already a field of struct lru_gen_mm_walk.
Remove the parameter struct lruvec* into functions that already have
access to struct lru_gen_mm_walk*.

Also, we do not need to handle reset histogram stats when
!should_walk_mmu(). Remove the call to reset_mm_stats()
in iterate_mm_list_nowalk().

Signed-off-by: Kinsey Ho <kinseyho@google.com>
---
 mm/vmscan.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 87de39e7410b..8c77c332a67a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2897,38 +2897,37 @@ static struct mm_struct *get_next_mm(struct lru_gen_mm_walk *walk)
 
 #endif
 
-static void reset_mm_stats(struct lruvec *lruvec, struct lru_gen_mm_walk *walk, bool last)
+static void reset_mm_stats(struct lru_gen_mm_walk *walk, bool last)
 {
 	int i;
 	int hist;
+	struct lruvec *lruvec = walk->lruvec;
 	struct lru_gen_mm_state *mm_state = get_mm_state(lruvec);
 
 	lockdep_assert_held(&get_mm_list(lruvec_memcg(lruvec))->lock);
 
-	if (walk) {
-		hist = lru_hist_from_seq(walk->max_seq);
+	hist = lru_hist_from_seq(walk->max_seq);
 
-		for (i = 0; i < NR_MM_STATS; i++) {
-			WRITE_ONCE(mm_state->stats[hist][i],
-				   mm_state->stats[hist][i] + walk->mm_stats[i]);
-			walk->mm_stats[i] = 0;
-		}
+	for (i = 0; i < NR_MM_STATS; i++) {
+		WRITE_ONCE(mm_state->stats[hist][i],
+			   mm_state->stats[hist][i] + walk->mm_stats[i]);
+		walk->mm_stats[i] = 0;
 	}
 
 	if (NR_HIST_GENS > 1 && last) {
-		hist = lru_hist_from_seq(mm_state->seq + 1);
+		hist = lru_hist_from_seq(walk->max_seq + 1);
 
 		for (i = 0; i < NR_MM_STATS; i++)
 			WRITE_ONCE(mm_state->stats[hist][i], 0);
 	}
 }
 
-static bool iterate_mm_list(struct lruvec *lruvec, struct lru_gen_mm_walk *walk,
-			    struct mm_struct **iter)
+static bool iterate_mm_list(struct lru_gen_mm_walk *walk, struct mm_struct **iter)
 {
 	bool first = false;
 	bool last = false;
 	struct mm_struct *mm = NULL;
+	struct lruvec *lruvec = walk->lruvec;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	struct lru_gen_mm_list *mm_list = get_mm_list(memcg);
 	struct lru_gen_mm_state *mm_state = get_mm_state(lruvec);
@@ -2972,7 +2971,7 @@ static bool iterate_mm_list(struct lruvec *lruvec, struct lru_gen_mm_walk *walk,
 	} while (!(mm = get_next_mm(walk)));
 done:
 	if (*iter || last)
-		reset_mm_stats(lruvec, walk, last);
+		reset_mm_stats(walk, last);
 
 	spin_unlock(&mm_list->lock);
 
@@ -3002,7 +3001,6 @@ static bool iterate_mm_list_nowalk(struct lruvec *lruvec, unsigned long max_seq)
 		mm_state->head = NULL;
 		mm_state->tail = NULL;
 		WRITE_ONCE(mm_state->seq, mm_state->seq + 1);
-		reset_mm_stats(lruvec, NULL, true);
 		success = true;
 	}
 
@@ -3177,9 +3175,10 @@ static void update_batch_size(struct lru_gen_mm_walk *walk, struct folio *folio,
 	walk->nr_pages[new_gen][type][zone] += delta;
 }
 
-static void reset_batch_size(struct lruvec *lruvec, struct lru_gen_mm_walk *walk)
+static void reset_batch_size(struct lru_gen_mm_walk *walk)
 {
 	int gen, type, zone;
+	struct lruvec *lruvec = walk->lruvec;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	walk->batched = 0;
@@ -3609,7 +3608,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long start, unsigned long end,
 	return -EAGAIN;
 }
 
-static void walk_mm(struct lruvec *lruvec, struct mm_struct *mm, struct lru_gen_mm_walk *walk)
+static void walk_mm(struct mm_struct *mm, struct lru_gen_mm_walk *walk)
 {
 	static const struct mm_walk_ops mm_walk_ops = {
 		.test_walk = should_skip_vma,
@@ -3618,6 +3617,7 @@ static void walk_mm(struct lruvec *lruvec, struct mm_struct *mm, struct lru_gen_
 	};
 
 	int err;
+	struct lruvec *lruvec = walk->lruvec;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 
 	walk->next_addr = FIRST_USER_ADDRESS;
@@ -3646,7 +3646,7 @@ static void walk_mm(struct lruvec *lruvec, struct mm_struct *mm, struct lru_gen_
 
 		if (walk->batched) {
 			spin_lock_irq(&lruvec->lru_lock);
-			reset_batch_size(lruvec, walk);
+			reset_batch_size(walk);
 			spin_unlock_irq(&lruvec->lru_lock);
 		}
 
@@ -3874,9 +3874,9 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 	walk->force_scan = force_scan;
 
 	do {
-		success = iterate_mm_list(lruvec, walk, &mm);
+		success = iterate_mm_list(walk, &mm);
 		if (mm)
-			walk_mm(lruvec, mm, walk);
+			walk_mm(mm, walk);
 	} while (mm);
 done:
 	if (success) {
@@ -4576,8 +4576,10 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 	move_folios_to_lru(lruvec, &list);
 
 	walk = current->reclaim_state->mm_walk;
-	if (walk && walk->batched)
-		reset_batch_size(lruvec, walk);
+	if (walk && walk->batched) {
+		walk->lruvec = lruvec;
+		reset_batch_size(walk);
+	}
 
 	item = PGSTEAL_KSWAPD + reclaimer_offset();
 	if (!cgroup_reclaim(sc))
-- 
2.43.0.687.g38aa6559b0-goog


