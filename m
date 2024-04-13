Return-Path: <linux-kernel+bounces-143523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFA68A3A7B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 04:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B4E284340
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5084C1C6B2;
	Sat, 13 Apr 2024 02:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4pxaDSq"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232221B978
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 02:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712975058; cv=none; b=VSplSDEyiL3l+prAYhXgIgxPHSp5EiisY/vslD12P6FtItCBczC55ECMqzHo/U+clhInhD6tyrC8J5pr3/ZzwPr+LgEzYzgkOkXFc1WixQSzTZBxFtSAAr34Mm+wV9BvwEF5oZdh4YCOPdN/owrOPww1X9i5T5paoxXe3nXYZYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712975058; c=relaxed/simple;
	bh=zyDgBGE0uOh7yhHXUN8OqLzqFOje2WXWPFCwIO8VvvQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dO5MryBcCCe20v3S65qoaLAqK1/14x0Z9Ku0Y55I2SEXtI3JuYJa4cWfUqQ97R8cK/df4PLvYN0yJl1z0gtEZVyPhDQKLaxaYPncsnLJk6fcOwj6EALIjtC88RCsjr+w2aP361HG6n6qZgFM9e3lGWBxczkbSOfmuczbVIdsgzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d4pxaDSq; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-617bd0cf61fso28196047b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 19:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712975056; x=1713579856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GGSekAACS+5O/41JM9vPAXBnj4QEps+gftm74rD23xg=;
        b=d4pxaDSqBGDGO9wHMrgP4boezbPfC5OKND7tT9B3V9YzKCl/mT+fRPvw7r9dkSIGGt
         ZOvvSgT/M9BvI9AAsbPm9uZCFGL90zcdHQWfvWVLFhTrVGZOz8JYCaUu6XtOsoZBaqOU
         5tNJv6xJPXJoY2yeriYx9gg2rKBiIXdcIDxgWjavTjWENSg7dTl39yLkVqVLkQUDo9Lr
         qSBvAhstyV56k+4GMJeiFJ80Jjdmmi1vol80thOpC0VjQmUUfreala1wlsTiB0P8YHM8
         7DUtTU5uEM9uKjWIGvUUj+q0ZXeC+cR3PQm0sqN9mffRIPNEQ3pDSnzfGinJsZ3jbu+D
         XsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712975056; x=1713579856;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GGSekAACS+5O/41JM9vPAXBnj4QEps+gftm74rD23xg=;
        b=KycZpQ6owxkavxak6+Sd7/smwx+XAwB4+cxej9EZoIpTjM8L7+uDejGlo9MZwqxFDO
         P7M3l9qfe77jg13cz+ZC6ssxmo8NyN7m1NEROEeYfARoAwubK1jRb4v6L1Q+2KHoHwhf
         s5h/hM7/bxODFw+0OU9EHk3akkMJkknOgu58kJepuH6KWe2S8UKGoNUUaiLn72NN8wDB
         1x+JLyFf3XTaJMqiS4qFvfmczdUHVS/5/Kuxth8GHlcJxzFsg1AmQfp1R9m8zLBvFZBw
         2mwZFjnLqsDmRg/Rr/6CdeXyGxyJwkvX+wHhpUhSSAOxu5WLNvrN8pV4bpAEgNKhM8CG
         7X0g==
X-Forwarded-Encrypted: i=1; AJvYcCXkEmymhrPZeNB2HKBboQya38vc2QBSTRkhWg534SoGpKlKyeSkuLdACh1XALKyWfU8XUq8wvPs+1kn/Ws+Jfi1SKJ8HEsvBXJKs1uo
X-Gm-Message-State: AOJu0YwOoU+l3Ub6FD0tqvZyhcUEm7Bq7qnsa3Wf57TtK6YDv2K/MYhk
	bchSsjPh0Y+diWJV7gg+sL4VvyT0XV8wtlEsKbwvOH73MY1DF71dx5a0P9iobMQUHO8IDkJMiWJ
	Ha+dEnGqbgbx9FEflhg==
X-Google-Smtp-Source: AGHT+IFlkK/1syKwe6dvTycUcSxBT93UngoIpgQpJlcuebA8rvVZJNpQ+d8xJDsJnJOws2HVuhkwwg+6UgtMptz/
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:4fcd:0:b0:618:a530:10aa with SMTP
 id d196-20020a814fcd000000b00618a53010aamr174476ywb.8.1712975056398; Fri, 12
 Apr 2024 19:24:16 -0700 (PDT)
Date: Sat, 13 Apr 2024 02:24:07 +0000
In-Reply-To: <20240413022407.785696-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240413022407.785696-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240413022407.785696-5-yosryahmed@google.com>
Subject: [PATCH v3 4/4] mm: zswap: remove same_filled module params
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Content-Type: text/plain; charset="UTF-8"

These knobs offer more fine-grained control to userspace than needed and
directly expose/influence kernel implementation; remove them.

For disabling same_filled handling, there is no logical reason to refuse
storing same-filled pages more efficiently and opt for compression.
Scanning pages for patterns may be an argument, but the page contents
will be read into the CPU cache anyway during compression. Also,
removing the same_filled handling code does not move the needle
significantly in terms of performance anyway [1].

For disabling non_same_filled handling, it was added when the compressed
pages in zswap were not being properly charged to memcgs, as workloads
could escape the accounting with compression [2]. This is no longer the
case after commit f4840ccfca25 ("zswap: memcg accounting"), and using
zswap without compression does not make much sense.

[1]https://lore.kernel.org/lkml/CAJD7tkaySFP2hBQw4pnZHJJwe3bMdjJ1t9VC2VJd=khn1_TXvA@mail.gmail.com/
[2]https://lore.kernel.org/lkml/19d5cdee-2868-41bd-83d5-6da75d72e940@maciej.szmigiero.name/

Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/zswap.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index f1d3204c604bd..243a7c202c6c7 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -123,19 +123,6 @@ static unsigned int zswap_accept_thr_percent = 90; /* of max pool size */
 module_param_named(accept_threshold_percent, zswap_accept_thr_percent,
 		   uint, 0644);
 
-/*
- * Enable/disable handling same-value filled pages (enabled by default).
- * If disabled every page is considered non-same-value filled.
- */
-static bool zswap_same_filled_pages_enabled = true;
-module_param_named(same_filled_pages_enabled, zswap_same_filled_pages_enabled,
-		   bool, 0644);
-
-/* Enable/disable handling non-same-value filled pages (enabled by default) */
-static bool zswap_non_same_filled_pages_enabled = true;
-module_param_named(non_same_filled_pages_enabled, zswap_non_same_filled_pages_enabled,
-		   bool, 0644);
-
 /* Number of zpools in zswap_pool (empirically determined for scalability) */
 #define ZSWAP_NR_ZPOOLS 32
 
@@ -1386,9 +1373,6 @@ static bool zswap_is_folio_same_filled(struct folio *folio, unsigned long *value
 	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*page) - 1;
 	bool ret = false;
 
-	if (!zswap_same_filled_pages_enabled)
-		return false;
-
 	page = kmap_local_folio(folio, 0);
 	val = page[0];
 
@@ -1466,9 +1450,6 @@ bool zswap_store(struct folio *folio)
 		goto store_entry;
 	}
 
-	if (!zswap_non_same_filled_pages_enabled)
-		goto freepage;
-
 	/* if entry is successfully added, it keeps the reference */
 	entry->pool = zswap_pool_current_get();
 	if (!entry->pool)
-- 
2.44.0.683.g7961c838ac-goog


