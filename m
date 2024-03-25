Return-Path: <linux-kernel+bounces-118185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3D388B590
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB7E1C3937A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3EA8663E;
	Mon, 25 Mar 2024 23:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vp16IZDx"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CD284D3F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711410626; cv=none; b=GTCVtWoPUrSXK6O2CxFlhWW2EvAAsBNaPf1vigbt1hcaAIA3zd+xAU0UAnqt6V8SZ2L6Y7wqwseVf0uZD5DTRUQwVxiXgtUAHc8BeJ56QnV8XUXj1/lHc8BwNyBAFfV+1cAaaDFI+Gaoh6DP6WZik+fP4qlk4L2goB4bgio3j9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711410626; c=relaxed/simple;
	bh=N3EhBhoPx4G/jPI5J5rhJXw3XGLAmDgO8lD2yh8kUnA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LLs4WW54tOkyLEuGC46DuEPR2lc7xqi1ZtfAB0xM10pjI2t4IHZ+c2xRm6hiHbbVR/EF8Zu0dBV0ZbzrpbdeG3GOnF1rMKG4JY1dZD7yCGfZTGS62RVNJqdym14ovTnXhxgmBeoTiWRp510DXpm8mYPQnH9Bl5ucNKQQoEFMSI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vp16IZDx; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cd041665bso94042327b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711410623; x=1712015423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ltPcwa62HBgtxDU26adJs5Ek9NcA4wCnN/irpaDy45s=;
        b=Vp16IZDx2OImL9QaaZ0imlCmnw9vXM5OYNlINxsa4YnCWqmJ9xwV6d3k8naBoOR0ip
         EisHnAx16oZV9zIj8JYHk96Cr+i2H9uHUnTeHMlZ79NN+7hs6gmXpCMiMWaZLZTQqFxu
         AAtWf7dHc3DvIhfU906cRcwp8hEHXSSFAcGqbrkAsHD4FWOBK17hmkDNMXg0Ydpe/nF2
         WBcwRWtOD3iNfOr4gQsHAJ4febC8g06uPAJBFWmphABqpx0puMnnuQUzpvRCiD/p64RH
         qLGYnuCkQXBaNAG30R1CatkU/CFMawTO9u4ua+QtW9HAXxzdnfRXKy2D/lwh6RqCi/Pu
         VULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711410623; x=1712015423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltPcwa62HBgtxDU26adJs5Ek9NcA4wCnN/irpaDy45s=;
        b=CyzH3Kt0MghGHSZBd70h1GogOqnh8DrFDlr2BEX7JfSMUwmEglt4TDb3Pbg3exwBB1
         GnBSxerQ+JMzLM5YdkafBdBN5iDDg6UBv3LiyR3z8vn0dDd9CFRkozGu8qz+8wAuGcOy
         ZpdfyK6qJs1RKq1RstMOKam74jmMdrHl36bmJ5yzA1OmunFMeCQgX4dGxZxv4N1eQ8OX
         55qik2KAd2dmnnSgb1jstsLPCWlGIYF+5MEoOA1sQenyKu6T6FDU9pB4O1jDk71vCk2D
         5DhVOKFWYDUmJeJOgJjm41lI1mUwG087SD/4jvdTvarCQvPBoBTkbYh2WyZL9aCAcD4X
         BmfA==
X-Forwarded-Encrypted: i=1; AJvYcCWcS2QVP9uRZBMgTSl3IpTdhqhBpQTrEhu9pPpOEhGgvdyHIRO1CaHqQ7VxpP7/VO240Ux55XjLKUbCMCcKOnPc50pEk2Q+WfXBdBqf
X-Gm-Message-State: AOJu0Yz4rR/n6T4OOh0dgLm1PkCM2g5XrTtxNKA4pbnlFgDEb4wt4Iup
	MUdcN4T7O9Wb5sxPYXBwhD+JPjAnW4o2xwzc/od/2wy2wWbb3VD8L1A9/NL+JOXosmwvPeMnVOK
	xoo3dRDDy8nmaAcV/qw==
X-Google-Smtp-Source: AGHT+IETdRLWcKvQU7ALPH/FxGMfk6VVMBGbdetkJernCRp2EMtMjfpphTVvqJ9nLnh8UXcxjIFAV/8JU9lCEqEU
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a0d:eb04:0:b0:610:d0c9:696b with SMTP
 id u4-20020a0deb04000000b00610d0c9696bmr2096495ywe.8.1711410623435; Mon, 25
 Mar 2024 16:50:23 -0700 (PDT)
Date: Mon, 25 Mar 2024 23:50:10 +0000
In-Reply-To: <20240325235018.2028408-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325235018.2028408-3-yosryahmed@google.com>
Subject: [RFC PATCH 2/9] mm: zswap: refactor storing to the tree out of zswap_store()
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Refactor the code that attempts storing to the xarray, handling erros,
and freeing stale entries into a helper. This will be reused in a
following patch to free other types of tree elements as well.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 1cf3ab4b22e64..ff1975afb7e3d 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -827,6 +827,30 @@ static void zswap_entry_free(struct zswap_entry *entry)
 	atomic_dec(&zswap_stored_pages);
 }
 
+/*********************************
+* zswap tree functions
+**********************************/
+static int zswap_tree_store(struct xarray *tree, pgoff_t offset, void *new)
+{
+	void *old;
+	int err;
+
+	old = xa_store(tree, offset, new, GFP_KERNEL);
+	err = xa_is_err(old);
+	if (err) {
+		WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
+		zswap_reject_alloc_fail++;
+	} else if (old) {
+		/*
+		 * We may have had an existing entry that became stale when
+		 * the folio was redirtied and now the new version is being
+		 * swapped out. Get rid of the old.
+		 */
+		zswap_entry_free(old);
+	}
+	return err;
+}
+
 /*********************************
 * compressed storage functions
 **********************************/
@@ -1396,10 +1420,10 @@ bool zswap_store(struct folio *folio)
 	swp_entry_t swp = folio->swap;
 	pgoff_t offset = swp_offset(swp);
 	struct xarray *tree = swap_zswap_tree(swp);
-	struct zswap_entry *entry, *old;
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
 	unsigned long max_pages, cur_pages;
+	struct zswap_entry *entry;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1485,22 +1509,8 @@ bool zswap_store(struct folio *folio)
 	entry->swpentry = swp;
 	entry->objcg = objcg;
 
-	old = xa_store(tree, offset, entry, GFP_KERNEL);
-	if (xa_is_err(old)) {
-		int err = xa_err(old);
-
-		WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
-		zswap_reject_alloc_fail++;
+	if (zswap_tree_store(tree, offset, entry))
 		goto store_failed;
-	}
-
-	/*
-	 * We may have had an existing entry that became stale when
-	 * the folio was redirtied and now the new version is being
-	 * swapped out. Get rid of the old.
-	 */
-	if (old)
-		zswap_entry_free(old);
 
 	if (objcg) {
 		obj_cgroup_charge_zswap(objcg, entry->length);
-- 
2.44.0.396.g6e790dbe36-goog


