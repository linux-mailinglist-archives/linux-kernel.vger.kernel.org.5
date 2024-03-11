Return-Path: <linux-kernel+bounces-99660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8154A878B87
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB711F223DF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF58158AD7;
	Mon, 11 Mar 2024 23:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGQs1M8T"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5708F58ACC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199897; cv=none; b=OlgZM6x5aEacRsfcC9LXII6RewHsxiLeg6d+98d/Tsx+yPyTvJBhZ1lYRI7d4TnCJPsh++YqYZtCd1T73LE5sMtJjxFZfKcb77QC8R65CypTe1z9ltZeMwxqfQC2z0IUX2Y2RuE9ZI7QAg4LO99SGzOvTOSeXRsJ9Ay1CQObiM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199897; c=relaxed/simple;
	bh=oOfJAg1XiL4PSSmd7KgCjlYbvC0AGRVbeOJ3pLmnNC4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tZMefa1wLoyRU400lIU5wfNL1GuF0hhohFXDzypntABUhdU4sUVQLdrHywpJzaceLE8RcknvRrSOeyUtPGjpJJYghXh+XhAleKGELGa7DM3zVHS/tLRLeg9mY6fH+Hcf6KU41ISSRfr5bvgrzM1dwdJoR7xM1MajqSotIEyTWeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uGQs1M8T; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60966f363c1so70056137b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710199894; x=1710804694; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0P+zg3sC3hxFlZRdvUxH346meH/XQ3eQu3bKmdXAuoI=;
        b=uGQs1M8Tb/CGYGcWyg9IJQX+GaNHN/CJATIH/qDIKGkY9yQtzShFMQj0anpjTp5TeF
         la07KmN0Q+YxF1EYbS5tc46l5SmHXbRy+O8ttPCoRApt0us84uO27rmyIfw3nqWNJYes
         FQPTsKllZj2f5H1bmeUxbwN+f+l9+nQKHbC9/4O1Tr6agvOTeGX7JAs8nabPA88Bpqs+
         gvbjKdiLD3Q+sUy/5CkO6LlDha5C3tok+E1fyULMdL43sEhVPMpaxIY2yQsTlNlQP2nd
         W08BqjqNhxhlNBAuXcp3eVZVUKS5UHx2zy1nqLsllKPB8dqurIeQpAGCFgJILs/UwDzI
         nx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710199894; x=1710804694;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0P+zg3sC3hxFlZRdvUxH346meH/XQ3eQu3bKmdXAuoI=;
        b=Sd1pTkN7WIkAKnmOwdVNIe2bTaI3tunJTxPGjTxGpL/Pj0UKn8ZTrkl7x9YI7KvA/T
         HF40rC3Wyr4KgtiEFC7ZPrBzV6MLx+keQzwCgvxQMUj8Y/qK7BhL5Aea9wHREcplMxSj
         jwhuEBzn8kOpuWKd8i4LpLqWsZm2pFdpr1qC7K5LPA0/4WpekXG3FxTgvekbd+RE3yS3
         XSg0hI9lXhfi+QT5MZHkgUa6myDrbAr8wvHOzE/v/cZw0rtkPTyywWwYH/eYKib2iZm+
         9oRInSlLul89UxBUvkIVZkHZsxB/fyg9t5d1ZBOqt0eu4Xiv2Lk8izKhMoIfAMitWkua
         gP2g==
X-Forwarded-Encrypted: i=1; AJvYcCUjER3J8ruwztSGrCu4Drs3ZHPJy9mRCMZXj17FAfYO/gTYE41g8M0OVbS+ma0h9dyWcvSf0dmOE7oINawTVLFEkRof1Rvq+RQJ9JWy
X-Gm-Message-State: AOJu0Yy1at3S1UntLuH0pFuOXJ01iJEr5RJnTGNSNHjZwrkWBymAq0EC
	sApUp0yP8gm+HzNuQtc7WTiUTGa07P4iJypGz8wxPTOzICeQF0TXi6VMj4Z1R4Yis7MxQSDgDLL
	9H9SlCH6IFBE2YXOYyQ==
X-Google-Smtp-Source: AGHT+IGMBbEsaO5zyl+K2nk3KAYXsMMJMbAJP2dlm1GfJvgnn5ewbSWdzUqwcvsox0d4zRQtSE9tqEa7YRzg451v
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1004:b0:dc7:48ce:d17f with
 SMTP id w4-20020a056902100400b00dc748ced17fmr2278245ybt.10.1710199894200;
 Mon, 11 Mar 2024 16:31:34 -0700 (PDT)
Date: Mon, 11 Mar 2024 23:31:32 +0000
In-Reply-To: <20240311-zswap-xarray-v5-1-a3031feb9c85@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240311-zswap-xarray-v5-1-a3031feb9c85@kernel.org>
Message-ID: <Ze-UVMUBIstFNKtp@google.com>
Subject: Re: [PATCH v5] zswap: replace RB tree with xarray
From: Yosry Ahmed <yosryahmed@google.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 11, 2024 at 03:26:05PM -0700, Chris Li wrote:
> Very deep RB tree requires rebalance at times. That
> contributes to the zswap fault latencies. Xarray does not
> need to perform tree rebalance. Replacing RB tree to xarray
> can have some small performance gain.
> 
> One small difference is that xarray insert might fail with
> ENOMEM, while RB tree insert does not allocate additional
> memory.
> 
> The zswap_entry size will reduce a bit due to removing the
> RB node, which has two pointers and a color field. Xarray
> store the pointer in the xarray tree rather than the
> zswap_entry. Every entry has one pointer from the xarray
> tree. Overall, switching to xarray should save some memory,
> if the swap entries are densely packed.
> 
> Notice the zswap_rb_search and zswap_rb_insert always
> followed by zswap_rb_erase. Use xa_erase and xa_store
> directly. That saves one tree lookup as well.
> 
> Remove zswap_invalidate_entry due to no need to call
> zswap_rb_erase any more. Use zswap_free_entry instead.
> 
> The "struct zswap_tree" has been replaced by "struct xarray".
> The tree spin lock has transferred to the xarray lock.
> 
> Run the kernel build testing 10 times for each version, averages:
> (memory.max=2GB, zswap shrinker and writeback enabled,
> one 50GB swapfile, 24 HT core, 32 jobs)
> 
> mm-9a0181a3710eb             xarray v5
> user       3532.385			3535.658
> sys        536.231                      530.083
> real       200.431                      200.176

It would be more useful to show figures for the reduction of the tail
latency since this is what is advertised as the main benefit. Anyway,
there is a small win in the sys build time, and a *lot* of code
simplification, so I like this change regardless.

> 
> ---
> 
> 
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---
> Changes in v5:
> - Remove zswap_xa_insert(), call xa_store and xa_erase directly.
> - Remove zswap_reject_xarray_fail. 
> - Link to v4: https://lore.kernel.org/r/20240304-zswap-xarray-v4-1-c4b45670cc30@kernel.org
> 
> Changes in v4:
> - Remove zswap_xa_search_and_earse, use xa_erase directly.
> - Move charge of objcg after zswap_xa_insert.
> - Avoid erase old entry on insert fail error path.
> - Remove not needed swap_zswap_tree change
> - Link to v3: https://lore.kernel.org/r/20240302-zswap-xarray-v3-1-5900252f2302@kernel.org
> 
> Changes in v3:
> - Use xa_cmpxchg instead of zswap_xa_search_and_delete in zswap_writeback_entry.
> - Use xa_store in zswap_xa_insert directly. Reduce the scope of spinlock.
> - Fix xa_store error handling for same page fill case.
> - Link to v2: https://lore.kernel.org/r/20240229-zswap-xarray-v2-1-e50284dfcdb1@kernel.org
> 
> Changes in v2:
> - Replace struct zswap_tree with struct xarray.
> - Remove zswap_tree spinlock, use xarray lock instead.
> - Fold zswap_rb_erase() into zswap_xa_search_and_delete() and zswap_xa_insert().
> - Delete zswap_invalidate_entry(), use zswap_free_entry() instead.
> - Link to v1: https://lore.kernel.org/r/20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org
> ---
>  mm/zswap.c | 166 +++++++++++++++----------------------------------------------
>  1 file changed, 41 insertions(+), 125 deletions(-)

Nice diffstat :)

Generally LGTM. With a couple of comments below, feel free to add:
Acked-by: Yosry Ahmed <yosryahmed@google.com>

[..]  
> @@ -1555,28 +1473,32 @@ bool zswap_store(struct folio *folio)
>  insert_entry:
>  	entry->swpentry = swp;
>  	entry->objcg = objcg;
> -	if (objcg) {
> -		obj_cgroup_charge_zswap(objcg, entry->length);
> -		/* Account before objcg ref is moved to tree */
> -		count_objcg_event(objcg, ZSWPOUT);
> -	}
>  
> -	/* map */
> -	spin_lock(&tree->lock);
>  	/*
>  	 * The folio may have been dirtied again, invalidate the
>  	 * possibly stale entry before inserting the new entry.
>  	 */
> -	if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
> -		zswap_invalidate_entry(tree, dupentry);
> -		WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentry));
> +	old = xa_store(tree, offset, entry, GFP_KERNEL);
> +

extra blank line here

> +	if (xa_is_err(old)) {
> +		if (xa_err(old) == -ENOMEM)
> +			zswap_reject_alloc_fail++;

I think we want to WARN for any other return codes as they are
unexpected?

