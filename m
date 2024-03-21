Return-Path: <linux-kernel+bounces-110563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBFF88609F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B241F2268A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A302B58AC0;
	Thu, 21 Mar 2024 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gcjUmpdt"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5267D12BE80
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711046218; cv=none; b=oeVBtrDLLT/jRQsjOWKwB92eg1ZWl2QvWRn5ErlLgKydqa8YR0VfREP4RT4cuoGxjm04gtHaIZcqu2bY6L0rWfREOOfpr2TsW2ekMUYMVH0LAXAtcoXUAPcxMJZMPy7kzOzCfIX0kFjYMq9qE3D0Wm0feoymfbCZPV+elRrfViw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711046218; c=relaxed/simple;
	bh=eUEa4rrGYlyZhAfRF+ds5sMG/T25zrE7GnOSK5h9F6Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bApBStGQ2wGK33W8V6/EjVFuuqMJ96MgWriwjl/yQkaNX5JcUbLzn1ebbwu/YsbdgQCkxXOOSA+QMcEEf/R6+dkmLY0ydQz6qaZgMw1NqSkHgWevi5s2mPhtIFDXDCoklRUjCXQ3lfZVwEsK8j9EI42gQKiphSxbQ0zNoKse2BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gcjUmpdt; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd169dd4183so1509821276.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711046216; x=1711651016; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bbCcL6OE4hGPljo6KgMnWz9lsSx4HXWFLCLqK+CpD5w=;
        b=gcjUmpdtt60sNeEEaUoO5jbxgfIyxKfnljDZEtqqVrjJ9ef+ictz9pmqTbfbWAKZ72
         qNfKAVkDDeODcF5U1FUJ2ukO3K2046VnGEN/3gGa0qWo5ylKaIj4UNU8WOv+KEwW0T1A
         Z5uT+HLbmK/vpH+bStv9lCTAgi4c0EyGjQ1qhvIPm1gJjp8gWQ/7TBbUNZneAoO6wW76
         B3TZdaIAWjnYyWltQcsDfFbIgpOO4NGPfcCAvlNjCgBEUBdVrPdTY2QWE/FjZtdWngbn
         kwZtS8ZXVTBzNsdwsDeyFojB0wNA+48SC+zrZnDAzrJ8IfQyfFgkhS2DmlB2F/ksHhHK
         vYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711046216; x=1711651016;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bbCcL6OE4hGPljo6KgMnWz9lsSx4HXWFLCLqK+CpD5w=;
        b=sgreHyhlYAALIU/vTj3vPZ83N3b4jZ5Az9Uz+FuIHbGCx1cNwUQnfH9UvganjRCea7
         Spngasr6tptCJKa0Cae3jQ2AJeL2irKaz2K3ttQ/WmY5kIjkx14Wk5xEul1TSs+cvvxE
         GZ0CRrnMrgPSGB6L63lBWJ70cUd17GjwNSq5EtPQmqUR7W7ISXofWErMktq8SATQjxg3
         OVpa4SPIu2V0PnN/iR0zlm07KDw8lBek5vR82V0l8FnGSG2Cw0KKTM51tiD+JHDNhSHx
         02h/x3/Ly051fFzhECtsGSZmAtmwA5jo5hV/8U90bgvIEYRq0TZaoy2SiEq3qRKzhZ/n
         uv6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVx8ViYTRgfiGP91RYiZSMP/5cChbfUAiQALTQblP+JRjluMoRb0HylEUPgfc3WvtBhfXIP7aC1P0eS144FbWSH26y0Cp2Ccf+lKFnP
X-Gm-Message-State: AOJu0YzebUfP7LK071roI8zxAtyfznSmG0BLD9zx+eBvmI4/evIxECsa
	B4m3KiXsfCGVy+4nsSBzR+yhGTUdM77rBglIyJtH+4bgUI7vL3UAxHOfEN++kUUNYz3SLsx5Q6G
	8Ajmactod89a6QLCl1g==
X-Google-Smtp-Source: AGHT+IGVKM74DX/eJBUX2BxRcTwydQ0lZph+eL4O9Qy//R+b2lvRLwx760LaFZnBPco9gucSiCyzr9XwrWOfpihG
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:2301:b0:dc7:865b:22c6 with
 SMTP id do1-20020a056902230100b00dc7865b22c6mr1248392ybb.8.1711046216453;
 Thu, 21 Mar 2024 11:36:56 -0700 (PDT)
Date: Thu, 21 Mar 2024 18:36:54 +0000
In-Reply-To: <20240321182532.60000-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321182532.60000-1-hannes@cmpxchg.org>
Message-ID: <Zfx-RjViLUMwWRmi@google.com>
Subject: Re: [PATCH] mm: zswap: fix writeback shinker GFP_NOIO/GFP_NOFS recursion
From: Yosry Ahmed <yosryahmed@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 21, 2024 at 02:25:32PM -0400, Johannes Weiner wrote:
> Kent forwards this bug report of zswap re-entering the block layer
> from an IO request allocation and locking up:
> 
> [10264.128242] sysrq: Show Blocked State
> [10264.128268] task:kworker/20:0H   state:D stack:0     pid:143   tgid:143   ppid:2      flags:0x00004000
> [10264.128271] Workqueue: bcachefs_io btree_write_submit [bcachefs]
> [10264.128295] Call Trace:
> [10264.128295]  <TASK>
> [10264.128297]  __schedule+0x3e6/0x1520
> [10264.128303]  schedule+0x32/0xd0
> [10264.128304]  schedule_timeout+0x98/0x160
> [10264.128308]  io_schedule_timeout+0x50/0x80
> [10264.128309]  wait_for_completion_io_timeout+0x7f/0x180
> [10264.128310]  submit_bio_wait+0x78/0xb0
> [10264.128313]  swap_writepage_bdev_sync+0xf6/0x150
> [10264.128317]  zswap_writeback_entry+0xf2/0x180
> [10264.128319]  shrink_memcg_cb+0xe7/0x2f0
> [10264.128322]  __list_lru_walk_one+0xb9/0x1d0
> [10264.128325]  list_lru_walk_one+0x5d/0x90
> [10264.128326]  zswap_shrinker_scan+0xc4/0x130
> [10264.128327]  do_shrink_slab+0x13f/0x360
> [10264.128328]  shrink_slab+0x28e/0x3c0
> [10264.128329]  shrink_one+0x123/0x1b0
> [10264.128331]  shrink_node+0x97e/0xbc0
> [10264.128332]  do_try_to_free_pages+0xe7/0x5b0
> [10264.128333]  try_to_free_pages+0xe1/0x200
> [10264.128334]  __alloc_pages_slowpath.constprop.0+0x343/0xde0
> [10264.128337]  __alloc_pages+0x32d/0x350
> [10264.128338]  allocate_slab+0x400/0x460
> [10264.128339]  ___slab_alloc+0x40d/0xa40
> [10264.128345]  kmem_cache_alloc+0x2e7/0x330
> [10264.128348]  mempool_alloc+0x86/0x1b0
> [10264.128349]  bio_alloc_bioset+0x200/0x4f0
> [10264.128352]  bio_alloc_clone+0x23/0x60
> [10264.128354]  alloc_io+0x26/0xf0 [dm_mod 7e9e6b44df4927f93fb3e4b5c782767396f58382]
> [10264.128361]  dm_submit_bio+0xb8/0x580 [dm_mod 7e9e6b44df4927f93fb3e4b5c782767396f58382]
> [10264.128366]  __submit_bio+0xb0/0x170
> [10264.128367]  submit_bio_noacct_nocheck+0x159/0x370
> [10264.128368]  bch2_submit_wbio_replicas+0x21c/0x3a0 [bcachefs 85f1b9a7a824f272eff794653a06dde1a94439f2]
> [10264.128391]  btree_write_submit+0x1cf/0x220 [bcachefs 85f1b9a7a824f272eff794653a06dde1a94439f2]
> [10264.128406]  process_one_work+0x178/0x350
> [10264.128408]  worker_thread+0x30f/0x450
> [10264.128409]  kthread+0xe5/0x120
> 
> The zswap shrinker resumes the swap_writepage()s that were intercepted
> by the zswap store. This will enter the block layer, and may even
> enter the filesystem depending on the swap backing file.
> 
> Make it respect GFP_NOIO and GFP_NOFS.
> 
> Link: https://lore.kernel.org/linux-mm/rc4pk2r42oyvjo4dc62z6sovquyllq56i5cdgcaqbd7wy3hfzr@n4nbxido3fme/
> Reported-by: Kent Overstreet <kent.overstreet@linux.dev>
> Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
> Cc: stable@vger.kernel.org	[v6.8]
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

Thanks for the quick fix.

> ---
>  mm/zswap.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index b31c977f53e9..535c907345e0 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1303,6 +1303,14 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
>  	if (!zswap_shrinker_enabled || !mem_cgroup_zswap_writeback_enabled(memcg))
>  		return 0;
>  
> +	/*
> +	 * The shrinker resumes swap writeback, which will enter block
> +	 * and may enter fs. XXX: Harmonize with vmscan.c __GFP_FS
> +	 * rules (may_enter_fs()), which apply on a per-folio basis.
> +	 */
> +	if (!gfp_has_io_fs(sc->gfp_mask))
> +		return 0;
> +
>  #ifdef CONFIG_MEMCG_KMEM
>  	mem_cgroup_flush_stats(memcg);
>  	nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
> -- 
> 2.44.0
> 

