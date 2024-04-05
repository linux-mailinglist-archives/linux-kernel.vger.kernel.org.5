Return-Path: <linux-kernel+bounces-132310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FD08992D4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC54285D4F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229A218032;
	Fri,  5 Apr 2024 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EwFRSzSU"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2B712E55
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 01:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712280957; cv=none; b=QVlMQdWpZptwUcU9AilbfsJcE/BVfJZ1AXBG5YEOg+BQK5Ynm/cP6q+rHzTMlPIDMyu5pWfG6JaN+5+OskX6q5Lhimbz+OQu2x32KGTt29WuCDpJAp3YGYELiy9GJUfly6mcR7Tm7jCDRfKGLA+e3F+5n5BaTjiPkCmdin1VJHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712280957; c=relaxed/simple;
	bh=+4kOMOZUceNAiAaZTak6VWosZOv5ss8q35Fj8zPEZs8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LzovMnivDGWIYvokwUkkzb7AQlIwiqcxYWE3wdw8pzRclOXh/SCwguaN3NXoiRB6cIk1aqMha6sAZtifWC2EBr84LvY1wR3WLLmb9vPqYDAJFFMHye4hjN+MQCaD76Y80Mk4YJSsgZPedWm9kIK1Zq0+/mv4KFZjE+OkkRd3aZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EwFRSzSU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6156cef8098so29024587b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 18:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712280955; x=1712885755; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yEGVZyHSwt0QZZ3iWSnf36Lx2mkJ2T39ZbIwvSBmEnQ=;
        b=EwFRSzSUzUC/wausfw1kSXQtCeM5WkmxSlQUG+T8IGuGvqkj7O14aM0clck30HluK7
         0tDOJWmDswDcOeIrA8aMyHR1pBarjFjZxWNL7WcM6TdyH3yscRAIIruOn2odBX4anTb+
         +GARuQK27PRQ4ERSiMGFlLfbL6b7fXTmbR/ROxCIKTUsneDyvBLLW8K4mdFz2GAfmpR4
         +XJ+eqkBlbUdUFti5CkF/G1uprtDTNn2VvIYGYpf/rHP11X9g2bGyUgffdwJEpWgZBVS
         8Css2H6+0pWGHvgLiIRrHrx7nclviWldakitYWiVeRUhGufajZvtMcYtLfwqZG88FIg3
         dsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712280955; x=1712885755;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yEGVZyHSwt0QZZ3iWSnf36Lx2mkJ2T39ZbIwvSBmEnQ=;
        b=r8YjmwTXa/3wiORO/ZauR5bvmRrea6maw4bDc255T+sKaXWirtTPnm6vOto3POeR2J
         iEDIzicJ/TGNjo+FOuEyt5j17jbKN/iSPDHe6PIU1Yd9PVydJLZICq5JfW1OdIZtKJn0
         4Ulw94Q2F/DKZpheYZc5+qvFovX+MXPOAdZeqxpoQCj2WOHFbSpG9eFgUeaztSQAo+if
         9/gnrvmF3fl/hV3HvZzG6f12Dm+vtWUzmzpFKsXIQyXBmu/0euxeAmu12JJTiKWjzzqD
         EsIfMXggGK8fDZlz7feLW5oyQr22nMZnacOV4g91BnQ4ROw5yM0OtYR7ncZtJcOpJU5Q
         gc4A==
X-Forwarded-Encrypted: i=1; AJvYcCXME3FuyIYQMiTp/j/lKsPmgn1UpMWHXO/Y078QT+8BFK23PM6YbI5YYT4DXhYh7Bkfj/XWyM5j7UExM1RhtSaycfRujNjOmvhwxQp1
X-Gm-Message-State: AOJu0Yz2Y1vlYXnL8ZbZYTX4zfgxhUIaU8oa73yQDitnO18eZ+JpykTR
	m4z44DtFfWyGYL2kBbKqIAxq1yphyjljnHadXSufcdU+RlLd4qBq5fJt+eTyUDZfExANqHJn4O/
	7BaLyWAamyG6kACFltg==
X-Google-Smtp-Source: AGHT+IH33+SVthekVVKeXhbUOG3wNDshSnpJ5/OwGTrydVxvAVq4kpl3zfciKOFqgaOZ9hcvtHjOLuShz0z5TQ52
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:e1e:b0:615:1b90:d987 with SMTP
 id cp30-20020a05690c0e1e00b006151b90d987mr342246ywb.6.1712280954789; Thu, 04
 Apr 2024 18:35:54 -0700 (PDT)
Date: Fri,  5 Apr 2024 01:35:45 +0000
In-Reply-To: <20240405013547.1859126-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405013547.1859126-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405013547.1859126-4-yosryahmed@google.com>
Subject: [PATCH v1 3/5] mm: zswap: move more same-filled pages checks outside
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
logic contained within the helper. While we are at it, rename the
insert_entry label to store_entry to match xa_store().

No functional change intended.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/zswap.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index fba8f3c3596ab..b92fa37bee277 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1361,26 +1361,32 @@ static void shrink_worker(struct work_struct *w)
 	} while (zswap_total_pages() > thr);
 }
 
-static int zswap_is_page_same_filled(void *ptr, unsigned long *value)
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
@@ -1414,6 +1420,7 @@ bool zswap_store(struct folio *folio)
 	struct zswap_entry *entry, *old;
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
+	unsigned long value;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1446,19 +1453,11 @@ bool zswap_store(struct folio *folio)
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
@@ -1481,7 +1480,7 @@ bool zswap_store(struct folio *folio)
 	if (!zswap_compress(folio, entry))
 		goto put_pool;
 
-insert_entry:
+store_entry:
 	entry->swpentry = swp;
 	entry->objcg = objcg;
 
-- 
2.44.0.478.gd926399ef9-goog


