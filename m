Return-Path: <linux-kernel+bounces-143522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A80B8A3A7A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 04:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795CE1C21811
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA831C2A5;
	Sat, 13 Apr 2024 02:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lO+GtrUe"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB1518EB1
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 02:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712975057; cv=none; b=qFFUSb8bYDpXMYc5I0ajIe70xCrVNGzF6LC8y5vm1yZOKCwk22eG8WR8Zg69ycvX6AXagq9+/3DJr2YDHnurx0s+bVQdYoj0VoIsofH7y7ZDFNyuBiPNb4sgt+pkDFPBiHmbPInSiICRwJLxxEPCd8jp+JOxgSxNjSklY/lU+a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712975057; c=relaxed/simple;
	bh=qDusTmxjn2kC5lBhg/CWFsj5+co4gZBN2F/Gz2WVfPs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XLP9nZViQmQHtBFuh3T4UMHqEq79uiaPfipRieQS+h3f7cr//aFNwYuUqZoj51J8fnRYpjIIdLaAkpHi8jEdYeOlT8/8rxvfshHTZ6ph79r43X+rsL9IHlJT0RWfKaox9tC1M6yzR3MJNyUeZe2UH5r9+sb1U/Uc3VG4I7GaUJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lO+GtrUe; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-618946f8e7bso4078637b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 19:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712975055; x=1713579855; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZYUWNTiUhiZC6PVJ2X+TVQi5b4PqWXfNQ2Zo+Rl5yk=;
        b=lO+GtrUeBFRPHuUAJ8VCq1XAfh3kf1TzzlhC/2pa3kMDsIRCYd9jVOsZAPNMNea+Qi
         kIdijuN6ADfeGjpMRJmNhb/eoU+yA7OjiRZkePjW+l8pMsDlYtstjClXYuJ133LKM3XB
         fzlOvA/YkoIS9y6gvNXoSIeaesFHCC+MON45xYXA8lyW79UDnDYPbB+43Tggdzjzu8eX
         k8hgdhkVaj1e+q0CB32GChdXFS06hxLFcFI75SP7zytWcej5jtDAQHdp+K0EgTHrBQ1E
         0toUSandXUodSZ6EhQX4SfkvMJP0xV21l0wxh4ofXClzmanpPAhVo0HJ4Ms8IapTDtzA
         7W4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712975055; x=1713579855;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZYUWNTiUhiZC6PVJ2X+TVQi5b4PqWXfNQ2Zo+Rl5yk=;
        b=lAM9X9YCtPY5mtDkrthgVic3WXTFlYUXV7GwhbTON90mHzc/zXIP2rDhzNFlAnB2Aj
         ZwjuMj1QsWyZ3GyzJFx8aKpUlwUq8kD7D9Lml3/EuZ+s4zLHZcfyk9MEIOVR3IIINgU0
         k7WZ7sxfOeAcexRDv5o1VDnMNwEW5KnzfKFK/AS9Pav8zpuHty9aCMhG7S1QOPyNdPcH
         SDgkmsaYR72W3zygJii+xL2vML66pds7VHkVV1UOxm1bznoU8hlUbWGLBNWcPwmEXQIs
         plWABrs1w45/gRehvMVZ1Pl4tdj0u/EM9vv6RP1cJqwyH5LQj+SSsXhs17ZUWZFvgtvT
         KU0w==
X-Forwarded-Encrypted: i=1; AJvYcCXIzDqPXhgmb8obWBYRfBG9korzgZlj9LWiuR5I1iKXMPfWgDSi4RAOdIudc5XGX7HVRF88tE5d/TIrlGvLJVZVq2XcaqXjg5LNuNEl
X-Gm-Message-State: AOJu0Yy9TOk35o5ssNNMKfy3PpSkd1pyBnksD9KITNxJmU/LZ+/4d0vY
	WV/cBcKVfPqiaWh/gcTTTJNLQOkaFuEogrlZc2swvPJ9CMCWk4C/AtvHSqsP4i/5G/t+5BVfOfG
	26ES9g84jk72I9RTEgw==
X-Google-Smtp-Source: AGHT+IGTrx1GnvC7Seu3eWAOb4tBFHfkiqWBD9kd67Bwq3v4nuuqOaFgb15AT9eRdbOLIz4wHqs3/FUeUlx91LlG
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1243:b0:dbd:ee44:8908 with
 SMTP id t3-20020a056902124300b00dbdee448908mr1442080ybu.0.1712975054816; Fri,
 12 Apr 2024 19:24:14 -0700 (PDT)
Date: Sat, 13 Apr 2024 02:24:06 +0000
In-Reply-To: <20240413022407.785696-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240413022407.785696-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240413022407.785696-4-yosryahmed@google.com>
Subject: [PATCH v3 3/4] mm: zswap: move more same-filled pages checks outside
 of zswap_store()
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, zswap_store() checks zswap_same_filled_pages_enabled, kmaps
the folio, then calls zswap_is_page_same_filled() to check the folio
contents. Move this logic into zswap_is_page_same_filled() as well (and
rename it to use 'folio' while we are at it).

This makes zswap_store() cleaner, and makes following changes to that
logic contained within the helper.

While we are at it:
- Rename the insert_entry label to store_entry to match xa_store().
- Add comment headers for same-filled functions and the main API
  functions (load, store, invalidate, swapon, swapoff).

No functional change intended.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 7cddbca3ac62c..f1d3204c604bd 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1376,26 +1376,35 @@ static void shrink_worker(struct work_struct *w)
 	} while (zswap_total_pages() > thr);
 }
 
-static int zswap_is_page_same_filled(void *ptr, unsigned long *value)
+/*********************************
+* same-filled functions
+**********************************/
+static bool zswap_is_folio_same_filled(struct folio *folio, unsigned long *value)
 {
 	unsigned long *page;
 	unsigned long val;
 	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*page) - 1;
+	bool ret = false;
 
-	page = (unsigned long *)ptr;
+	if (!zswap_same_filled_pages_enabled)
+		return false;
+
+	page = kmap_local_folio(folio, 0);
 	val = page[0];
 
 	if (val != page[last_pos])
-		return 0;
+		goto out;
 
 	for (pos = 1; pos < last_pos; pos++) {
 		if (val != page[pos])
-			return 0;
+			goto out;
 	}
 
 	*value = val;
-
-	return 1;
+	ret = true;
+out:
+	kunmap_local(page);
+	return ret;
 }
 
 static void zswap_fill_page(void *ptr, unsigned long value)
@@ -1406,6 +1415,9 @@ static void zswap_fill_page(void *ptr, unsigned long value)
 	memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
 }
 
+/*********************************
+* main API
+**********************************/
 bool zswap_store(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
@@ -1414,6 +1426,7 @@ bool zswap_store(struct folio *folio)
 	struct zswap_entry *entry, *old;
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
+	unsigned long value;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1446,19 +1459,11 @@ bool zswap_store(struct folio *folio)
 		goto reject;
 	}
 
-	if (zswap_same_filled_pages_enabled) {
-		unsigned long value;
-		u8 *src;
-
-		src = kmap_local_folio(folio, 0);
-		if (zswap_is_page_same_filled(src, &value)) {
-			kunmap_local(src);
-			entry->length = 0;
-			entry->value = value;
-			atomic_inc(&zswap_same_filled_pages);
-			goto insert_entry;
-		}
-		kunmap_local(src);
+	if (zswap_is_folio_same_filled(folio, &value)) {
+		entry->length = 0;
+		entry->value = value;
+		atomic_inc(&zswap_same_filled_pages);
+		goto store_entry;
 	}
 
 	if (!zswap_non_same_filled_pages_enabled)
@@ -1481,7 +1486,7 @@ bool zswap_store(struct folio *folio)
 	if (!zswap_compress(folio, entry))
 		goto put_pool;
 
-insert_entry:
+store_entry:
 	entry->swpentry = swp;
 	entry->objcg = objcg;
 
-- 
2.44.0.683.g7961c838ac-goog


