Return-Path: <linux-kernel+bounces-109340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FDE8817D0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D3A1C21980
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D628563C;
	Wed, 20 Mar 2024 19:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="DwO4K5Zq"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB666AFAE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710962771; cv=none; b=AURH0gXTcDy3KURzLjh/CDVmEShoqnaL0hBR+JD7O7OYMqyMjyr81lHqdriTAducYAjpruPfGxGNgyTeIMznFXr4zqZ9wtP0RPrBkxHX5A1stIbbwlaHUvv6WDTQjF6HIX7vD/FNqe73LOe4sTjQVFIBTGGsBJ00uXmW7dJ57k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710962771; c=relaxed/simple;
	bh=yRG3Expm90FpKj26oMVD1bU6sPrJz9uUnbTMHH4lTe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/lCOKFgg5NL8VcKH6/G2oxM1rOVsP0+VDvdseJ9mW4KttUjwk62snMLmm1oEleazDBsQAfDVULf3FrKTTqAJ7E9JbPMh4hybEgw3SKVU7OMAvgM7EBOmC3JTCfcDcke6nzUvhP/e+vPtJiOcX17f8ONidssn+HQ6f/ojUENBhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=DwO4K5Zq; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e6a9e2e2b6so85276a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 12:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710962763; x=1711567563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SUAmkJ7Zv9WiJkajEZOR6HGXSWRqX1yJKfLHYkohCk0=;
        b=DwO4K5ZqlnbsP3Z7PUlRZr0JciiqT+DrY4rhGsg2R6Gx3gikH0zNrxIQxhXqh1wulV
         w+YCvcl8oo7XesmfKaYxnHXO4x3GU/MfbNAuz/bndh+cbeFsZagqxKWIGyOvy8AeYABY
         Aq9r5/SpwE82WkGmN4Rk01ZjLQtYGFrCSK7nl1t6y/Rj3JFP0bPN+B5JRLkIkiIJ2KDx
         zatpAnXUl87m260nl+urkP9VAmJ5NbOeuhFDOgGSO5kD72+wIHrMpSMHrdbNYl24bFK3
         9P4EybBmbK3kvcyDeh1Sak/eC6RxbUBoLvzX7Z/kDotwySOMpx04OqzAQOcWMro+wYDh
         HtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710962763; x=1711567563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUAmkJ7Zv9WiJkajEZOR6HGXSWRqX1yJKfLHYkohCk0=;
        b=nCQxERZ/MHOnUii3b0rVIoNgre0bqc79pYdAEjzNHNTsrzdkzAUpzmn0qd6ZObnGTu
         rCUpxk9zEkiymtKCwF3uMfnE2SbNoRqTVOKH2/zoAlCzLspIInmGAtm4ZHNerb6GYBMh
         9bVlY9TJDILYwlY2ger9nmPxSCgcGMxZvNLU1OVAUDEHp9YK5923jcpZusOFN/9IfbwW
         FhZ7f9efzSvhDoJJEnU0ieRUUL+lGap4+esUTWB57yQDZzcIRKJcsrq3Lg5OSZfY2fW9
         +mZ8aayr+JDE3buwG9sGeldpJdAmy3nU8nIHTj3ovbUUNgl8UYSQYU268yPMupqhjE0i
         UDBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6V9a/zwIOJAu65tmoM+6YDMypwYfEvnxnPGwNNLV5aRlFiPYo8YMdqsLd1DtArsESc2xxb5rHulaEMfI2ZwcQhxnTxRFjXh2uXT10
X-Gm-Message-State: AOJu0YzhRjCCgleruCxVD6Zp+UGTwwyxsfTcUD2WkM5KAt+qQG87tkRt
	DS0124zcBtAiL0xUuagrouOACQVWwfC1LlZoEozlVThcwWih9a4+1/NYcF/kjPs=
X-Google-Smtp-Source: AGHT+IFdTm5jr+xarUfCTBIqZRXqNODUtrSWkzvgkjJVREUvZEZapOPguoGm6+vTJumSQqZzSG0emA==
X-Received: by 2002:a05:6830:2705:b0:6e5:2535:266a with SMTP id j5-20020a056830270500b006e52535266amr20835209otu.22.1710962763009;
        Wed, 20 Mar 2024 12:26:03 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id l4-20020ae9f004000000b00788744ccaecsm6845341qkg.96.2024.03.20.12.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 12:26:02 -0700 (PDT)
Date: Wed, 20 Mar 2024 15:25:58 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Nhat Pham <nphamcs@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v7] zswap: replace RB tree with xarray
Message-ID: <20240320192558.GF294822@cmpxchg.org>
References: <20240319-zswap-xarray-v7-1-e9a03a049e86@kernel.org>
 <Zfp-iWaDfqeCOElt@google.com>
 <CANeU7Q=yxf0dnerTOZfe_ioeCbjnZd2Fpb-szvW7-Q1BzCUpOw@mail.gmail.com>
 <ZfqPK7AVunq2SC1l@google.com>
 <20240320100803.GB294822@cmpxchg.org>
 <Zfs06maKhjH_gXqL@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfs06maKhjH_gXqL@google.com>

On Wed, Mar 20, 2024 at 07:11:38PM +0000, Yosry Ahmed wrote:
> On Wed, Mar 20, 2024 at 06:08:03AM -0400, Johannes Weiner wrote:
> > On Wed, Mar 20, 2024 at 07:24:27AM +0000, Yosry Ahmed wrote:
> > > [..]
> > > > > > -     /* map */
> > > > > > -     spin_lock(&tree->lock);
> > > > > >       /*
> > > > > > -      * The folio may have been dirtied again, invalidate the
> > > > > > -      * possibly stale entry before inserting the new entry.
> > > > > > +      * We finish initializing the entry while it's already in xarray.
> > > > > > +      * This is safe because:
> > > > > > +      *
> > > > > > +      * 1. Concurrent stores and invalidations are excluded by folio lock.
> > > > > > +      *
> > > > > > +      * 2. Writeback is excluded by the entry not being on the LRU yet.
> > > > > > +      *    The publishing order matters to prevent writeback from seeing
> > > > > > +      *    an incoherent entry.
> > > > >
> > > > > As I mentioned before, writeback is also protected by the folio lock.
> > > > > Concurrent writeback will find the folio in the swapcache and abort. The
> > > > > fact that the entry is not on the LRU yet is just additional protection,
> > > > > so I don't think the publishing order actually matters here. Right?
> > > > 
> > > > Right. This comment is explaining why this publishing order does not
> > > > matter. I think we are talking about the same thing here?
> > > 
> > > The comment literally says "the publishing order matters.." :)
> > > 
> > > I believe Johannes meant that we should only publish the entry to the
> > > LRU once it is fully initialized, to prevent writeback from using a
> > > partially initialized entry.
> > > 
> > > What I am saying is that, even if we add a partially initialized entry
> > > to the zswap LRU, writeback will skip it anyway because the folio is
> > > locked in the swapcache.
> > > 
> > > So basically I think the comment should say:
> > > 
> > > 	/*
> > > 	 * We finish initializing the entry while it's already in the
> > > 	 * xarray. This is safe because the folio is locked in the swap
> > > 	 * cache, which should protect against concurrent stores,
> > > 	 * invalidations, and writeback.
> > > 	 */
> > > 
> > > Johannes, what do you think?
> > 
> > I don't think that's quite right.
> > 
> > Writeback will bail on swapcache insert, yes, but it will access the
> > entry before attempting it. If LRU publishing happened before setting
> > entry->swpentry e.g., we'd have a problem, while your comment suggets
> > it would be safe to rearrange the code like this.
> > 
> > So LRU publishing order does matter.
> 
> Ah yes, you are right. entry->swpentry should be set to make sure we
> lookup the correct entry in the swapcache and the tree.
> 
> Perhaps we should spell this out in the comment and make the
> initialization ordering more explicit? Maybe something like:
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index d8a14b27adcd7..70924b437743a 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1472,9 +1472,6 @@ bool zswap_store(struct folio *folio)
>  		goto put_pool;
>  
>  insert_entry:
> -	entry->swpentry = swp;
> -	entry->objcg = objcg;
> -
>  	old = xa_store(tree, offset, entry, GFP_KERNEL);
>  	if (xa_is_err(old)) {
>  		int err = xa_err(old);
> @@ -1491,6 +1488,7 @@ bool zswap_store(struct folio *folio)
>  	if (old)
>  		zswap_entry_free(old);
>  
> +	entry->objcg = objcg;
>  	if (objcg) {
>  		obj_cgroup_charge_zswap(objcg, entry->length);
>  		count_objcg_event(objcg, ZSWPOUT);
> @@ -1498,15 +1496,16 @@ bool zswap_store(struct folio *folio)
>  
>  	/*
>  	 * We finish initializing the entry while it's already in xarray.
> -	 * This is safe because:
> -	 *
> -	 * 1. Concurrent stores and invalidations are excluded by folio lock.
> +	 * This is safe because the folio is locked in the swapcache, which
> +	 * protects against concurrent stores and invalidations.
>  	 *
> -	 * 2. Writeback is excluded by the entry not being on the LRU yet.
> -	 *    The publishing order matters to prevent writeback from seeing
> -	 *    an incoherent entry.
> +	 * Concurrent writeback is not possible until we add the entry to the
> +	 * LRU. We need to at least initialize entry->swpentry *before* adding
> +	 * the entry to the LRU to make sure writeback looks up the correct
> +	 * entry in the swapcache.
>  	 */
>  	if (entry->length) {
> +		entry->swpentry = swp;
>  		INIT_LIST_HEAD(&entry->lru);
>  		zswap_lru_add(&zswap_list_lru, entry);
>  		atomic_inc(&zswap_nr_stored);
> 
> 
> This also got me wondering, do we need a write barrier between
> initializing entry->swpentry and zswap_lru_add()?
> 
> I guess if we read the wrong swpentry in zswap_writeback_entry() we will
> eventually fail the xa_cmpxchg() and drop it anyway, but it seems
> bug-prone.

I think it's more robust the way Chris has it now. Writeback only
derefs ->swpentry today, but who knows if somebody wants to make a
changes that relies on a different member. Having submembers follow
different validity rules and timelines is error prone and makes the
code less hackable without buying all that much. The concept of
"publishing" an object like this is more common: if you can see it,
you can expect it to be coherent.

