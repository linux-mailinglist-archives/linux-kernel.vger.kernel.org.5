Return-Path: <linux-kernel+bounces-124174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB36A891365
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7A41C23058
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6E53D0DF;
	Fri, 29 Mar 2024 05:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XO0QRqOE"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430C43D0A1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 05:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711691361; cv=none; b=nHQTCccjgJD8Y0YQp0xAjukXjEAzrA2EHvTPcAMtQH3umfnIXq8/4fa9YMdrBRXXEPrqBUaW069uASawPHGlWEll61tXK+ve5fyx6jn0YpAcdG/iXeUMJFHygX7jS1x41QvSJZ53BFRNuG4NBbvvzMia5t2yG3yRurcN55apgeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711691361; c=relaxed/simple;
	bh=41ANgLP26Xacw1kzmcPKuKVk8ZrFzwqg0e1XO0ZHZr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSStFsQKCebD+h9gNLnQWGXBOPcRfca4qududro0hJEz3/6c7ez07nDqTnOae/lOYl3vymhJpucfziHGEQg1jCAP3cfeSdigOYp/fuzNB8I161c1Nw2KMRfkq9rJBSDWrq8nXPFNlb94h8AVTKDMq4OJai8oJkEfCXwLn4YzE+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XO0QRqOE; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d6ff0422a2so23469451fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711691357; x=1712296157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWh5XvZuNSI0MNsT9yYNdgNOdtZxhUHRtmIKymQhmqw=;
        b=XO0QRqOEGclyGsT6ANIy3LLo/fI18KB91TP93CkDqkZOYX92ZjDHl6eJ6Ozqx4A15C
         +oTrBwRAiUQFz3yRVsDUmt7kIRlYFNNx2RRZYJzZvI412kYqIewZ6JRFdYAqytBHaffl
         2uo6cE3j+QNpy+w4vtgGeSabI9+ra7VjQDGDhpMpP1PEIm+zsJ2qjGi6SS+v/VQGjq/Y
         4356SqJhzZxTY+c0OdmqW6q6E+dW7HksqtAm/uOYPZnuKWk/X0DSrQb1unqDR9cN+1uX
         8+doILzsQg1+zhjMDy1mxeZwpXnCOdgitrUfSt+hkl1tS1DnWY8ooeh0VlcwOHUtCLJ2
         1hFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711691357; x=1712296157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWh5XvZuNSI0MNsT9yYNdgNOdtZxhUHRtmIKymQhmqw=;
        b=xDLC27PTrSQQUcpfDXQ5PRDVHE49dPIU4sx0M3Wg4arGG0qZEWMweqyh5Z/1L37hZ6
         PgqoPC42yGAJpgeZat/e3r6/GSd+Ntpb1L0T5mkat7aEDtlBWJPauIk3+b023hP55kkT
         Nc1Dd8rKyXrKxsgXHh4saFHoDRaPAKPXzvJmMgbLRAAYxtbKzYqVPFLY//WfyewION3b
         +dSZzrdr2fbwV6ai9TQA3mIRH0Z8PB+x2pu9Ami16FPqTkBcjk5Q6E+NPbPjaEWLI8P6
         ujDJ28gu2k79C7DUrTGZ963jc6lhJQWpnjzS/8yFDdij2N0vsez9wwzS2IYU9jY2hZ5Y
         oayg==
X-Forwarded-Encrypted: i=1; AJvYcCVEg677UxfGDIr8aKGRL1Y3GKoq5+KEEsl6O26FjcngqE3T+LoLlXWVYKbZs2RrsGfzfOm07LzxOOdQu3xCLUi5lY5xP9aBCt0IkZeE
X-Gm-Message-State: AOJu0Yycj9OT4TZruqutK/OOfgo8fXpvlOqZR1Ic87I3zLiG0KpiYuWR
	ECH7W0UjP/6+Efkb4h1hGtTw295vqsQjm9qVgADBoQl+Ebjuck1H8dr8E/aasuR497wXXC4p00N
	Z70kH5UnCt1OgYnEJ+YPn98EPJfVsphBwF4s=
X-Google-Smtp-Source: AGHT+IHNszf3yjMtPQSQfg0jO0L5dBCy4o0EbE1Rt8A2Pswsp2ttuCMGV6of+mS7TP848kwMhi5wJCrWe0vRDwcSsLg=
X-Received: by 2002:a2e:be15:0:b0:2d6:cb82:24e6 with SMTP id
 z21-20020a2ebe15000000b002d6cb8224e6mr879339ljq.37.1711691356982; Thu, 28 Mar
 2024 22:49:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zfz4_GJAHRInB8ul@casper.infradead.org> <CAGWkznEzpcWi4oXVn_WFahnQj3dHcwc_4VW6m1Ss-KJ8mD3F3Q@mail.gmail.com>
 <ZgDt9mwN-Py5Y-xr@casper.infradead.org> <CAGWkznHO27EpVVpFyKnv-SX-JTYCXQxb0MG+EW07gaupocR4RQ@mail.gmail.com>
 <ZgK91II_eSYY6D2F@casper.infradead.org> <CAGWkznGLySzLE17+rCe=UoA26vx=iM375o2zkruKM9ssG05QzA@mail.gmail.com>
 <ZgQRtQ60mrvOUKXo@casper.infradead.org> <CAGWkznF3GfCs8odhR-Hue5H8MZ=eXb82V20ZoCCjeoSjAPQ9cw@mail.gmail.com>
 <ZgThg-pzQzRl3ckF@casper.infradead.org> <CAGWkznEMCXQSe10E-pbdxk2uFgQO038wH6g=iojtSU6-N+GJdg@mail.gmail.com>
 <ZgV65ercduTnVWCA@casper.infradead.org>
In-Reply-To: <ZgV65ercduTnVWCA@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 29 Mar 2024 13:49:05 +0800
Message-ID: <CAGWkznG7oyh9D-ozN7zQrpJz3s+N_ra1P=Yw3Nd3B0X=thCAxg@mail.gmail.com>
Subject: Re: summarize all information again at bottom//reply: reply: [PATCH]
 mm: fix a race scenario in folio_isolate_lru
To: Matthew Wilcox <willy@infradead.org>
Cc: =?UTF-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	=?UTF-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 10:12=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Thu, Mar 28, 2024 at 12:03:02PM +0800, Zhaoyang Huang wrote:
> > On Thu, Mar 28, 2024 at 11:18=E2=80=AFAM Matthew Wilcox <willy@infradea=
d.org> wrote:
> > >
> > > On Thu, Mar 28, 2024 at 09:27:31AM +0800, Zhaoyang Huang wrote:
> > > > ok, I missed the refcnt from alloc_pages. However, I still think it=
 is
> > > > a bug to call readahead_folio in read_pages as the refcnt obtained =
by
> > > > alloc_pages should be its final guard which is paired to the one wh=
ich
> > > > checked in shrink_folio_list->__remove_mapping->folio_ref_freeze(2)=
(this
> > > > 2 represent alloc_pages & page cache). If we removed this one witho=
ut
> > >
> > > __remove_mapping()  requires that the caller holds the folio locked.
> > > Since the readahead code unlocks the folio, __remove_mapping() cannot
> > > be run because the caller of __remove_mapping() will wait for the fol=
io
> > > lock.
> > repost the whole timing sequence to make it more clear and fix
> > incorrect description of previous feedback
>
> I can't understand what you think the problem is here.  Please try
> again.
>
> > Follow the refcount through.
> >
> > In page_cache_ra_unbounded():
> >
> >                 folio =3D filemap_alloc_folio(gfp_mask, 0);
> > (folio has refcount 1)
> >                 ret =3D filemap_add_folio(mapping, folio, index + i, gf=
p_mask);
> > (folio has refcount 2, PG_lru)
> >
> > Then we call read_pages()
> > First we call ->readahead() which for some reason stops early.
> > Then we call readahead_folio() which calls folio_put()
> > (folio has refcount 1)
> > Then we call folio_get()
> > (folio has refcount 2)
> > Then we call filemap_remove_folio()
> > (folio has refcount 1)
> > Then we call folio_unlock()
> > Then we call folio_put()
> >
> > Amending steps for previous timing sequence below where [1] races with
> > [2] that has nothing to do with __remove_mapping(). IMO, no file_folio
> > should be freed by folio_put as the refcnt obtained by alloc_pages
> > keep it always imbalanced until shrink_folio_list->__remove_mapping,
> > where the folio_ref_freeze(2) implies the refcnt of alloc_pages and
> > isolation should be the last two. release_pages is a special scenario
> > that the refcnt of alloc_pages is freed implicitly in
> > delete_from_page_cache_batch->filemap_free_folio.
> >
> >     folio_put()
> >     {
> >          if(folio_put_test_zero())
> > *** we should NOT be here as the refcnt of alloc_pages should NOT be dr=
opped ***
> >          if (folio_test_lru())
> > ***  preempted here with refcnt =3D=3D 0 and pass PG_lru check ***
> > [1]
> >          lruvec_del_folio()
> > Then thread_isolate call folio_isolate_lru()
> >       folio_isolate_lru()
> >       {
> >          folio_test_clear_lru()
> >          folio_get()
> > [2]
> >          lruvec_del_folio()
> >       }
> > -----------------------------------------------------------------------=
---------------------
> > shrink_folio_list()
> > {
> >     __remove_mapping()
> >     {
> >         refcount =3D 1 + folio_nr_pages;
> > *** the refcount =3D 1 + 1 implies there should be only the refcnt of
> > alloc_pages and previous isolation for a no-busy folio as all PTE has
> > gone***
> >         if (!folio_ref_freeze(refcount))
> >              goto keeplock;
> >      }
> > }
key steps in brief:
Thread_truncate get folio to its local fbatch by find_get_entry in step 2
The refcnt is deducted to 1 which is not as expect as from alloc_pages
but from thread_truncate's local fbatch in step 7
Thread_reclaim succeed to isolate the folio by the wrong refcnt(not
the value but meaning) in step 8
Thread_truncate hit the VM_BUG_ON in step 9

all steps:
Thread_readahead:
0. folio =3D filemap_alloc_folio(gfp_mask, 0);
       (folio has refcount 1)
1. ret =3D filemap_add_folio(mapping, folio, index + i, gfp_mask);
       (folio has refcount 2)
2. thread_truncate hold one refcnt and add this folio to fbatch_truncate
       (folio has refcount 3(alloc, page cache, fbatch_truncate), PG_lru)
3. Then we call read_pages()
       First we call ->readahead() which for some reason stops early.
4. Then we call readahead_folio() which calls folio_put()
       (folio has refcount 2)
5. Then we call folio_get()
       (folio has refcount 3)
6. Then we call filemap_remove_folio()
       (folio has refcount 2)
7. Then we call folio_unlock()
       Then we call folio_put()
       (folio has refcount 1(fbatch_truncate))
8. thread_reclaim call shrink_inactive_list->isolate_lru_folios
        shrink_inactive_list
            isolate_lru_folios
               if (!folio_test_lru(folio))
               if (!folio_try_get(folio))
               if (!folio_test_clear_lru(folio))
               list_move(folio, dst)
       (folio has refcount 2)

8.1. thread_reclaim call shrink_folio_list->__remove_mapping
    shrink_folio_list()
        __remove_mapping()
             (refcount =3D 2)
            if (!folio_ref_freeze(2)) //true
         list_add(folio, free_folios);
       (folio has refcount 0)

9. thread_truncate will hit the refcnt VM_BUG_ON(refcnt =3D=3D 0) in
folio_put_testzero

