Return-Path: <linux-kernel+bounces-108349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D88E880977
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02252285366
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C37410942;
	Wed, 20 Mar 2024 02:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2vS6Er52"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3200CF9CE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710900509; cv=none; b=VN0Mz7kRZm488wa+aH1+ew+fTIp2Wro/kN7X/L2AMQ6V86Cc812OGNkTiZNjh2FC1QJ44Nzyw0j3rkUNTcyBy8JfBqZIKmErGAn7ja9A0e+r2RE/MczRq3p3P3H6caaQYjGq80gMPRRZC1TVMI8XozsIuhNAzfkNp2qkO7rnazE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710900509; c=relaxed/simple;
	bh=6b1HSPl6nsepzN39xGf0RLV0KItmZQ4a71qGKlaYe+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ta81cfTjGZYwC2dIGi7u6w/JZ4sWZll87D4d+FHe+6DOJkx8Qa8sXQ0r9LLeEH+wnIrtKd8tA8DgkPepRgsezYJjYi1vLleVdINj0xnwmvJJdGT0DzuKY0b+ZqSleb19FXUFKcQ2CSJQrq1PxL2Q5zNEOK4ykZWP9HAY7p4dvss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2vS6Er52; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60ff1816749so76766077b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710900507; x=1711505307; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4f2cmQGIIvYk0KlMI8Lk64bezK2vGQGAMrw9pw7eCqU=;
        b=2vS6Er520gnUvxILLS/ezGlHLtFa9xl+xDe4YENJCaDgSwBealWui/gdE3PoYeCzIa
         pmzbDDc1khooKpMDWW6fU97TbJeItcIVsQB4m3vK6PbhOEUN/8lFRdzfemTxebQquUHd
         cSqbdhEaU8CP6b1qDMaW1+ENgEoqtufxbuYpTVU4EZyMd7vPQX9nekZ2AJbKc+q2eSXy
         qZQvmVmjris+rDX/VrI4TnxJRV80TrBWlNc8AKswuRLzRaFz/nK3sMGOSOJQX/eca3YZ
         sBuTnIqD7pC2ztT6lAogRgPJOh7aB89pg7DqmO7HfkAmRaKqQqRe91sbdm19DFIamdMu
         BjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710900507; x=1711505307;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4f2cmQGIIvYk0KlMI8Lk64bezK2vGQGAMrw9pw7eCqU=;
        b=jUnI4si5yISY6frg5lDVwFB/wKSkrH87qiwhbHA3HA0uPYRR9RL+DN1GsqiJR0FjRx
         jP2i6S6ay4FxO2SZbIwF2+PxuqYjHuYrG2mPp3pOb2vWJYzYlIenJDrV7zF7DmfvN3j/
         Zva2w+IXnzpAQgDFIzoGCsD7LrwtrLPJsbnnHyTwf+J2rM0M3tVDlq6bqhGwt7yAIh2t
         9hVzrdRKVE2/obBouxv9NUo1DeFn9d2gI42Hitslp08KD5hHNPY+ogr7jWtvbuxfcuQ3
         OoNDAuKBG6TG6GBv8clx71CYCRNYu5+1ts9tqLZrFD4RTBEd57uGyGQcDeVJGYSdjCj4
         X49g==
X-Forwarded-Encrypted: i=1; AJvYcCXtNpChHXDy2DisxvJCVRTc9lbX0orQFJykZDFYvl9+Up/gLXqzZ38EqX42sEwl8veGbTLl/1fyvQo0gS6nKRdo+16zIMkBUnD8pT/o
X-Gm-Message-State: AOJu0YyMEededR01EfZIVo9u05AOgaAF0I+hdQJTWVSQo0PaX0QMP5Gy
	HXfXgAkY7gPv4OOOdKA++/7vencgqYaextmecqc4O9Lfhlt/CfhorOl/sZKtePb+YiVu0yKUuct
	VEOjgVodNnrwh2MqfYg==
X-Google-Smtp-Source: AGHT+IFsvhJOuJBMAwJK0L9AcJGw/zZI7HjSUBr+0ZmCaaIAiZxx6HFfHdp9ILj8xjHSBNtVwPjPcmu8Za+Wats5
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a0d:d54e:0:b0:60a:2307:e3b with SMTP id
 x75-20020a0dd54e000000b0060a23070e3bmr3040512ywd.3.1710900507103; Tue, 19 Mar
 2024 19:08:27 -0700 (PDT)
Date: Wed, 20 Mar 2024 02:08:23 +0000
In-Reply-To: <20240320020823.337644-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240320020823.337644-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240320020823.337644-2-yosryahmed@google.com>
Subject: [PATCH 2/2] mm: zswap: remove nr_zswap_stored atomic
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

zswap_nr_stored is used to maintain the number of stored pages in zswap
that are not same-filled pages. It is used in zswap_shrinker_count() to
scale the number of freeable compressed pages by the compression ratio.
That is, to reduce the amount of writeback from zswap with higher
compression ratios as the ROI from IO diminishes.

However, the need for this counter is questionable due to two reasons:
- It is redundant. The value can be inferred from (zswap_stored_pages -
  zswap_same_filled_pages).
- When memcgs are enabled, we use memcg_page_state(memcg,
  MEMCG_ZSWAPPED), which includes same-filled pages anyway (i.e.
  equivalent to zswap_stored_pages).

Use zswap_stored_pages instead in zswap_shrinker_count() to keep things
consistent whether memcgs are enabled or not, and add a comment about
the number of freeable pages possibly being scaled down more than it
should if we have lots of same-filled pages (i.e. inflated compression
ratio).

Remove nr_zswap_stored and one atomic operation in the store and free
paths.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 323f1dea43d22..ffcfce05a4408 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -181,8 +181,6 @@ struct zswap_pool {
 
 /* Global LRU lists shared by all zswap pools. */
 static struct list_lru zswap_list_lru;
-/* counter of pages stored in all zswap pools. */
-static atomic_t zswap_nr_stored = ATOMIC_INIT(0);
 
 /* The lock protects zswap_next_shrink updates. */
 static DEFINE_SPINLOCK(zswap_shrink_lock);
@@ -880,7 +878,6 @@ static void zswap_entry_free(struct zswap_entry *entry)
 	else {
 		zswap_lru_del(&zswap_list_lru, entry);
 		zpool_free(zswap_find_zpool(entry), entry->handle);
-		atomic_dec(&zswap_nr_stored);
 		zswap_pool_put(entry->pool);
 	}
 	if (entry->objcg) {
@@ -1305,7 +1302,7 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 #else
 	/* use pool stats instead of memcg stats */
 	nr_backing = zswap_total_pages();
-	nr_stored = atomic_read(&zswap_nr_stored);
+	nr_stored = atomic_read(&zswap_stored_pages);
 #endif
 
 	if (!nr_stored)
@@ -1325,6 +1322,11 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	 * This ensures that the better zswap compresses memory, the fewer
 	 * pages we will evict to swap (as it will otherwise incur IO for
 	 * relatively small memory saving).
+	 *
+	 * The memory saving factor calculated here takes same-filled pages into
+	 * account, but those are not freeable since they almost occupy no
+	 * space. Hence, we may scale nr_freeable down a little bit more than we
+	 * should if we have a lot of same-filled pages.
 	 */
 	return mult_frac(nr_freeable, nr_backing, nr_stored);
 }
@@ -1570,7 +1572,6 @@ bool zswap_store(struct folio *folio)
 	if (entry->length) {
 		INIT_LIST_HEAD(&entry->lru);
 		zswap_lru_add(&zswap_list_lru, entry);
-		atomic_inc(&zswap_nr_stored);
 	}
 	spin_unlock(&tree->lock);
 
-- 
2.44.0.291.gc1ea87d7ee-goog


