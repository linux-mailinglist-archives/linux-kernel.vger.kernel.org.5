Return-Path: <linux-kernel+bounces-109328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB558817B4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 647A0B227A1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AE88562D;
	Wed, 20 Mar 2024 19:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sqpAv9Hz"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6728527E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710961903; cv=none; b=Iz9EzYRHm7XZ8ztZGE0nkq+ucGrTecDiHV+8cqJlftdTAIyyij+6i2OnOabjRr8CYz83Q1vcMQrFULuP/VzkG34hVDbqY9rZhNombsItkn/sA+/enouaLhjdqqiXecsFx37+RafRSCmxel7nq7yHJ4vhWi3oeAadt/rtEjLcTbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710961903; c=relaxed/simple;
	bh=7wozTtg9F7RZNqRIGuw4EPFsbUo5tObiVMkcPAaCVnI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PVsS9YLhsnSBcR4cJAIVq2dvaFQVfbNJ2gHCrkLJ60BTDrjKo/x6lX5bJbYghVnQTjjuhGX+rGSRopHjk4F7Zbw6kFGEG3gxkR7S+7reIuuq/yzb8qUILkoJMofr4UY4rS1CJzsHyT4ouOV3d2uYt1kpiTFJoRUYZ6tHa3DCp28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sqpAv9Hz; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so223594276.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 12:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710961900; x=1711566700; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j7LMRio+PS8aI9k3DhAx1SV/ZtsvK3v4/pXa7Z8PPvo=;
        b=sqpAv9HzYwEiX/fF3LJEJjOEwL6FuYHnHqqvXcvqL2/eXXkh3Vw+YE/LWzCjf7lk4O
         9W7NtYxXePIwLrZOJMPd67G6WCpasByMDh3fkUswJCupNiB4qVEqcUAfrNmqTF1+hATe
         jkqxkRCVGgdtrXEt223nDTk2eeshCA9I3ZpAbAACL+6sEDTbblwhjRZU7iJb2PM33Uc0
         OogMOmOH65GJQfqBq9Ie5XNvfSpm63MctfJ9fkONMPUqupq5wapCxiJzwO9iH99Xkp9X
         Hgoid8E80f9KrtXGhbEpY2kRKqkyFVuDqudxjLyqfwjQ47zzo0l83g1/X59LJjsmfNM5
         drRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710961900; x=1711566700;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j7LMRio+PS8aI9k3DhAx1SV/ZtsvK3v4/pXa7Z8PPvo=;
        b=wcSzt2Xo1FDSXd8ISv72Dy7/TmMteZF367fV0kFsGY6/TKlXBXyytgZAL6KF0tcn5Y
         pa1H3qiLUwGXg7TB9PXhGqMonptJGLF/LGCh/hq4E5S5X4XVYMbqLkiBFuFSW5qnCXla
         8ol8Rv7C5aO/UEva6Fb161vDTPdE2gPFWj3ldX3aDseDvQTvJb+g9G81QfrDdT3UJ5SH
         rrcJARst+HGGt4KfSt28tCmFPEHIXzT8sX8Pn/fbP9sT8GWRXVskSB7eswkFC9AH/x5+
         NSvgm13b2adSlB+ZXPZ9zWbC/Mn9KlS8LAW2iFrMY5lnj4d+ixTwbg3Cttn2YsNTFEbE
         V7qA==
X-Forwarded-Encrypted: i=1; AJvYcCW/bUfow7XAMSPRMYOigL4l+GXl3xA2ja0oXxGOzm/N0GDrTuiQOeP4ku3riBv5P0ThpWZsqeh1dRDTJ+2xF67XaFI2FZMDrgd08RZH
X-Gm-Message-State: AOJu0YydUv60Mznv2h0rJcXOc72/HH4ofgxml2M00X8X64wh1DedVjEG
	hF4l+e6fVIrfp8TTsh9BmU/DKrg/CkI2nGDNvERa4nB96FSwCn1lO78+3YXOEQ4cdRN3o/LBlqr
	kbPUsuo9uGO7ouaVAHQ==
X-Google-Smtp-Source: AGHT+IF2exxs4A0z7JTbw+RIKRHHmq4+3usbqdmbipaxHHv7PEsceQthi2sGcPPpOdLj4dwpa7bwWyOHNzP+4VZO
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:e09:b0:dc2:3441:897f with SMTP
 id df9-20020a0569020e0900b00dc23441897fmr4715579ybb.6.1710961900635; Wed, 20
 Mar 2024 12:11:40 -0700 (PDT)
Date: Wed, 20 Mar 2024 19:11:38 +0000
In-Reply-To: <20240320100803.GB294822@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240319-zswap-xarray-v7-1-e9a03a049e86@kernel.org>
 <Zfp-iWaDfqeCOElt@google.com> <CANeU7Q=yxf0dnerTOZfe_ioeCbjnZd2Fpb-szvW7-Q1BzCUpOw@mail.gmail.com>
 <ZfqPK7AVunq2SC1l@google.com> <20240320100803.GB294822@cmpxchg.org>
Message-ID: <Zfs06maKhjH_gXqL@google.com>
Subject: Re: [PATCH v7] zswap: replace RB tree with xarray
From: Yosry Ahmed <yosryahmed@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Nhat Pham <nphamcs@gmail.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Mar 20, 2024 at 06:08:03AM -0400, Johannes Weiner wrote:
> On Wed, Mar 20, 2024 at 07:24:27AM +0000, Yosry Ahmed wrote:
> > [..]
> > > > > -     /* map */
> > > > > -     spin_lock(&tree->lock);
> > > > >       /*
> > > > > -      * The folio may have been dirtied again, invalidate the
> > > > > -      * possibly stale entry before inserting the new entry.
> > > > > +      * We finish initializing the entry while it's already in xarray.
> > > > > +      * This is safe because:
> > > > > +      *
> > > > > +      * 1. Concurrent stores and invalidations are excluded by folio lock.
> > > > > +      *
> > > > > +      * 2. Writeback is excluded by the entry not being on the LRU yet.
> > > > > +      *    The publishing order matters to prevent writeback from seeing
> > > > > +      *    an incoherent entry.
> > > >
> > > > As I mentioned before, writeback is also protected by the folio lock.
> > > > Concurrent writeback will find the folio in the swapcache and abort. The
> > > > fact that the entry is not on the LRU yet is just additional protection,
> > > > so I don't think the publishing order actually matters here. Right?
> > > 
> > > Right. This comment is explaining why this publishing order does not
> > > matter. I think we are talking about the same thing here?
> > 
> > The comment literally says "the publishing order matters.." :)
> > 
> > I believe Johannes meant that we should only publish the entry to the
> > LRU once it is fully initialized, to prevent writeback from using a
> > partially initialized entry.
> > 
> > What I am saying is that, even if we add a partially initialized entry
> > to the zswap LRU, writeback will skip it anyway because the folio is
> > locked in the swapcache.
> > 
> > So basically I think the comment should say:
> > 
> > 	/*
> > 	 * We finish initializing the entry while it's already in the
> > 	 * xarray. This is safe because the folio is locked in the swap
> > 	 * cache, which should protect against concurrent stores,
> > 	 * invalidations, and writeback.
> > 	 */
> > 
> > Johannes, what do you think?
> 
> I don't think that's quite right.
> 
> Writeback will bail on swapcache insert, yes, but it will access the
> entry before attempting it. If LRU publishing happened before setting
> entry->swpentry e.g., we'd have a problem, while your comment suggets
> it would be safe to rearrange the code like this.
> 
> So LRU publishing order does matter.

Ah yes, you are right. entry->swpentry should be set to make sure we
lookup the correct entry in the swapcache and the tree.

Perhaps we should spell this out in the comment and make the
initialization ordering more explicit? Maybe something like:

diff --git a/mm/zswap.c b/mm/zswap.c
index d8a14b27adcd7..70924b437743a 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1472,9 +1472,6 @@ bool zswap_store(struct folio *folio)
 		goto put_pool;
 
 insert_entry:
-	entry->swpentry = swp;
-	entry->objcg = objcg;
-
 	old = xa_store(tree, offset, entry, GFP_KERNEL);
 	if (xa_is_err(old)) {
 		int err = xa_err(old);
@@ -1491,6 +1488,7 @@ bool zswap_store(struct folio *folio)
 	if (old)
 		zswap_entry_free(old);
 
+	entry->objcg = objcg;
 	if (objcg) {
 		obj_cgroup_charge_zswap(objcg, entry->length);
 		count_objcg_event(objcg, ZSWPOUT);
@@ -1498,15 +1496,16 @@ bool zswap_store(struct folio *folio)
 
 	/*
 	 * We finish initializing the entry while it's already in xarray.
-	 * This is safe because:
-	 *
-	 * 1. Concurrent stores and invalidations are excluded by folio lock.
+	 * This is safe because the folio is locked in the swapcache, which
+	 * protects against concurrent stores and invalidations.
 	 *
-	 * 2. Writeback is excluded by the entry not being on the LRU yet.
-	 *    The publishing order matters to prevent writeback from seeing
-	 *    an incoherent entry.
+	 * Concurrent writeback is not possible until we add the entry to the
+	 * LRU. We need to at least initialize entry->swpentry *before* adding
+	 * the entry to the LRU to make sure writeback looks up the correct
+	 * entry in the swapcache.
 	 */
 	if (entry->length) {
+		entry->swpentry = swp;
 		INIT_LIST_HEAD(&entry->lru);
 		zswap_lru_add(&zswap_list_lru, entry);
 		atomic_inc(&zswap_nr_stored);


This also got me wondering, do we need a write barrier between
initializing entry->swpentry and zswap_lru_add()?

I guess if we read the wrong swpentry in zswap_writeback_entry() we will
eventually fail the xa_cmpxchg() and drop it anyway, but it seems
bug-prone.

