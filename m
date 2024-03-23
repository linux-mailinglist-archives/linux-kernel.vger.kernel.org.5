Return-Path: <linux-kernel+bounces-112171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49793887683
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 02:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CEAFB21F85
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 01:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F67210F9;
	Sat, 23 Mar 2024 01:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="VsEqUl5Q"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4EEA31
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 01:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711158953; cv=none; b=tuWQ1fYfHlSz3YzKcy3qQyg7dSXruUTo85wSqhdGeotEYDSojXMyRkAg8iWfSqTo/1e6VrsnE1M7kyhYg6W66KOoMySMSomrKdaadkW0mY6qWNeLwqoZwszGMYA7a3TVncsZKfmL+8VITpLC5J4dMBsbo3af9uu+Ai498beJmE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711158953; c=relaxed/simple;
	bh=+Pb1ToNhA16d1cgb8U1s+ZiuJiT2PGhXOZz6H18f0lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+v/TftvyKyYWisFkndoPnH4PnEsYTdAvC7W3dvo5b+FpF2JugaThK4RF3OB+FBIRy59C/GX6wK59TGhXUUnJs89q1As51j6rcyksH2krU3pHvHbe+dL0hnfPb606SROC1pVhf6VR8XDB08hMCVqJgUk2mK2/fSpPnmCAGBpwk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=VsEqUl5Q; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-430b870163eso32732671cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711158949; x=1711763749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3vsgiwxIesEweY/56xdcSGWn13L1TSsWr5GbRXDd3ts=;
        b=VsEqUl5QnNPh40RtUowgRyWNuOnR9psvoEo754n0twwwQ4+DJKga3umCzhZwDBYcmZ
         juEx1GOqUDUqb6YklohsftVhjHqkqFr861ar80Uer4ssOkA1rL5zhW7L46sxYEJGi240
         14UbRHekxOBh+8TraTh7lF3Nh7x5k2psPBHbsSPjyc/uMR5jxdKJhYZ4XRPYu3Gx6uzF
         +ttQXj2ufuTthmiIEVDbXhdz9uzeUg7IYzAGTz9cCDd7njEcR46j9BYhV4eL3V71281M
         dTSt58ablt63oAFkCbzZl8tdMJ6EaUtYzOXUvhoKnLTHrjrXdU66+0kGvsiHi2Qf9dMh
         yEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711158949; x=1711763749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vsgiwxIesEweY/56xdcSGWn13L1TSsWr5GbRXDd3ts=;
        b=VPBBucKRGdf4YXLw2b2KwkLyYkEptUPAuxgNob30pyTfzhz9Z6gpc5oNj50G/WH9Lj
         qKuAMQNQBYaEu+JsvhNjOeK2gTyvzTl9t0a2/jE7g/XMAB2+2JK9Sc6V5C0NmPHTGW8z
         UQRfx6Cke+0FphsCslLPAvw8VwpazISM3FOQRF7J50QpE2bzdrSHM89JsAssXeg0Jbvl
         JHdWup2Y4nMYKUIa9K5S9grXmVmXaIqDhdokm9E92vFuD7FPGpZII5yNJlefL0KGkQhw
         1vC1DWBKahrxCalyijOtoqAMvodgpGsyRSvan9CMbYR65Gh4MxaE/pnG8j8BErG/qaT3
         Qk2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLflRVZexE/vUOd7iUHxOysQmy4wHqpBxhzmuAoDFZGjIBTPy31b+EuXZawTRd2XCOcrBs1O5uGhP5L01V4mVUr7tUvIrDg/ZFBq8J
X-Gm-Message-State: AOJu0YwxK2SFqCW6k6M9snbDEAnfysg4riFpxYQ31KVp6pb9Bi322il6
	IHOhQiXHz2Hccnz62Ua+ZZ0b/azM9p7/NOqNrNK4AzEMuM7pWmD66Kec41eMFNGUXdFAFsf4G5w
	z
X-Google-Smtp-Source: AGHT+IHtAO+0TiuhzdK5UOUufoT0yvPr6F2X4n0RODULlmM9+L2RicUEhrxu84JeLwvBBCoyWpfX1w==
X-Received: by 2002:ac8:7dcd:0:b0:431:3803:eaf2 with SMTP id c13-20020ac87dcd000000b004313803eaf2mr1156393qte.7.1711158948633;
        Fri, 22 Mar 2024 18:55:48 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:16be])
        by smtp.gmail.com with ESMTPSA id he37-20020a05622a602500b00430bad81704sm374664qtb.52.2024.03.22.18.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 18:55:48 -0700 (PDT)
Date: Fri, 22 Mar 2024 21:55:43 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Barry Song <21cnbao@gmail.com>, chengming.zhou@linux.dev,
	nphamcs@gmail.com, akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: Re: [RFC PATCH] mm: add folio in swapcache if swapin from zswap
Message-ID: <20240323015543.GB448621@cmpxchg.org>
References: <20240322163939.17846-1-chengming.zhou@linux.dev>
 <CAJD7tkYuYEsKFvjKKRxOx3fCekA03jPpOpmV7T20q=9K=Jb2bA@mail.gmail.com>
 <CAGsJ_4yc-XB3+FkcZTy1aZ0n6ZKEkfWVYk_TjqqrdcROa5VYtA@mail.gmail.com>
 <Zf4HKUpKpDWZygni@google.com>
 <20240322234826.GA448621@cmpxchg.org>
 <CAJD7tkY2y_nGRq9ft80op6q0B3tfJvtyqYhS6t+x=TpyGy+AXg@mail.gmail.com>
 <CAJD7tkZqrrXuYTMYOAP+arMLeNayafFeLocWu7bJtDFHCYjwDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZqrrXuYTMYOAP+arMLeNayafFeLocWu7bJtDFHCYjwDA@mail.gmail.com>

On Fri, Mar 22, 2024 at 05:14:37PM -0700, Yosry Ahmed wrote:
> [..]
> > > > I don't think we want to stop doing exclusive loads in zswap due to this
> > > > interaction with zram, which shouldn't be common.
> > > >
> > > > I think we can solve this by just writing the folio back to zswap upon
> > > > failure as I mentioned.
> > >
> > > Instead of storing again, can we avoid invalidating the entry in the
> > > first place if the load is not "exclusive"?
> > >
> > > The reason for exclusive loads is that the ownership is transferred to
> > > the swapcache, so there is no point in keeping our copy. With an
> > > optimistic read that doesn't transfer ownership, this doesn't
> > > apply. And we can easily tell inside zswap_load() if we're dealing
> > > with a swapcache read or not by testing the folio.
> > >
> > > The synchronous read already has to pin the swp_entry_t to be safe,
> > > using swapcache_prepare(). That blocks __read_swap_cache_async() which
> > > means no other (exclusive) loads and no invalidates can occur.
> > >
> > > The zswap entry is freed during the regular swap_free() path, which
> > > the sync fault calls on success. Otherwise we keep it.
> >
> > I thought about this, but I was particularly worried about the need to
> > bring back the refcount that was removed when we switched to only
> > supporting exclusive loads:
> > https://lore.kernel.org/lkml/20240201-b4-zswap-invalidate-entry-v2-6-99d4084260a0@bytedance.com/
> >
> > It seems to be that we don't need it, because swap_free() will free
> > the entry as you mentioned before anyone else has the chance to load
> > it or invalidate it. Writeback used to grab a reference as well, but
> > it removes the entry from the tree anyway and takes full ownership of
> > it then frees it, so that should be okay.
> >
> > It makes me nervous though to be honest. For example, not long ago
> > swap_free() didn't call zswap_invalidate() directly (used to happen to
> > swap slots cache draining). Without it, a subsequent load could race
> > with writeback without refcount protection, right? We would need to
> > make sure to backport 0827a1fb143f ("mm/zswap: invalidate zswap entry
> > when swap entry free") with the fix to stable for instance.
> >
> > I can't find a problem with your diff, but it just makes me nervous to
> > have non-exclusive loads without a refcount.
> >
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index 535c907345e0..686364a6dd86 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -1622,6 +1622,7 @@ bool zswap_load(struct folio *folio)
> > >         swp_entry_t swp = folio->swap;
> > >         pgoff_t offset = swp_offset(swp);
> > >         struct page *page = &folio->page;
> > > +       bool swapcache = folio_test_swapcache(folio);
> > >         struct zswap_tree *tree = swap_zswap_tree(swp);
> > >         struct zswap_entry *entry;
> > >         u8 *dst;
> > > @@ -1634,7 +1635,8 @@ bool zswap_load(struct folio *folio)
> > >                 spin_unlock(&tree->lock);
> > >                 return false;
> > >         }
> > > -       zswap_rb_erase(&tree->rbroot, entry);
> > > +       if (swapcache)
> > > +               zswap_rb_erase(&tree->rbroot, entry);
> 
> On second thought, if we don't remove the entry from the tree here,
> writeback could free the entry from under us after we drop the lock
> here, right?

The sync-swapin does swapcache_prepare() and holds SWAP_HAS_CACHE, so
racing writeback would loop on the -EEXIST in __read_swap_cache_async().
(Or, if writeback wins the race, sync-swapin fails on swapcache_prepare()
instead and bails on the fault.)

This isn't coincidental. The sync-swapin needs to, and does, serialize
against the swap entry moving into swapcache or being invalidated for
it to be safe. Which is the same requirement that zswap ops have.

