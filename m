Return-Path: <linux-kernel+bounces-4380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C262E817C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F0C1F246F5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4B773469;
	Mon, 18 Dec 2023 20:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QIaHgIUT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0712CA2D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 20:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a23566e91d5so221127866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702932799; x=1703537599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QsdbGbSxsszPpaiGKZHTHrV8rAdzIP6V+qMuxlnTDw=;
        b=QIaHgIUTZjEbIK6dwFXC/NLdISJVCG2eDOlbXFskHIkULnUp5QQmukyOraDDTueVCX
         A7TH8ZpmnVtliNwbuvRUlREEx6TFyU9u32hLjJ2QEUAS4b5LM5d/L9Wa6c8qxfettQ+e
         4UtzJg0gdD5oqKOoHZFu/QtyQtuFy4xsEyPS3PyMllwSoMpa5ESjJJVBpwaQQuwVYmLM
         obQPBrKHvju8/UZ+ag/uaSkzAOJJxcEVbrO+ZN/ka8bA3g1axyccB5kFq2IyZLNyo/yK
         3HfryAX5z8wLm8xnO+DSL5DGwFu7FDodQHWGqVWrSXOUErapOOq2nvfoln8DuLD+mjB7
         u67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702932799; x=1703537599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QsdbGbSxsszPpaiGKZHTHrV8rAdzIP6V+qMuxlnTDw=;
        b=APeky1GG3yAZ4Xx7jk8megBw/Lu8P6+IVL/jgsL2Pf63sw1ZmfDXlXjAwtJbVjm8ca
         ssNwIYfRqAmB1Rb/74Zy6Qw9b8rvStccIlTd9J61aejFdJRKym2amfvzYxVMK8F+8UUq
         jBRx5TuqshrxUMkmIuLTAJsWBen/3p9nZ2I+u3pQHCaP16RXTMI/BMFaYjOwfdXyroyD
         X0uefQ6jN5CV5rK4vtWCMyOiLI8wwlkHhGYeg2RHShpD1sEMV+lU0WuPW0jx951vWdno
         z92mt2ew5BT15GUQYrnwJZCtZ+H9xDb8ii9RQ6/+MUDAcFIqdWiszVJ0q6c/UNHsXh6C
         3bkw==
X-Gm-Message-State: AOJu0YxZ7ufgD+iVMaqbLNCTltB1rLX9iV17HtF8AGzPBAzpatVBQB2b
	BBxQpcxyh/m8kIenu+m5T7smKykecFV+YR2CsBUHDg==
X-Google-Smtp-Source: AGHT+IFAlpTWtObKtyA6+//MnW75oNmM97bzaqn8nKtpZT6NFC3S8Lw42wbMozqITvlLij86MbxeoPoAZHdX898UWWw=
X-Received: by 2002:a17:906:73c3:b0:a22:feea:a69e with SMTP id
 n3-20020a17090673c300b00a22feeaa69emr3534950ejl.2.1702932798922; Mon, 18 Dec
 2023 12:53:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-5-896763369d04@bytedance.com> <CAJD7tkb5cKopA-Lfvtsn7sqgqjRf2kyaMwZhhp6SkveNEwArGw@mail.gmail.com>
 <20231214142320.f5cf319e619dbb2127c423e9@linux-foundation.org>
 <CAJD7tkaJVB+BoYmcO3MtGD7Ku88Sjk-VAK640h9B-aQzyGPdZQ@mail.gmail.com>
 <20231218140313.GA19167@cmpxchg.org> <CAJD7tkbdCv7CMy71UOCefR2Y1BXevJ2eMmYwk+=e=GPcCqn3+w@mail.gmail.com>
 <20231218145815.GA21073@cmpxchg.org>
In-Reply-To: <20231218145815.GA21073@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 18 Dec 2023 12:52:40 -0800
Message-ID: <CAJD7tkZhC+cniDpFW31Q+7F1AZDkUBNSDNaMvfVT9AG31BNJmg@mail.gmail.com>
Subject: Re: [PATCH 5/5] mm/zswap: cleanup zswap_reclaim_entry()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>, 
	Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, 
	Vitaly Wool <vitaly.wool@konsulko.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 6:58=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Mon, Dec 18, 2023 at 06:39:13AM -0800, Yosry Ahmed wrote:
> > On Mon, Dec 18, 2023 at 6:03=E2=80=AFAM Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> > >
> > > On Thu, Dec 14, 2023 at 02:41:26PM -0800, Yosry Ahmed wrote:
> > > > On Thu, Dec 14, 2023 at 2:23=E2=80=AFPM Andrew Morton <akpm@linux-f=
oundation.org> wrote:
> > > > >
> > > > > On Wed, 13 Dec 2023 17:02:25 -0800 Yosry Ahmed <yosryahmed@google=
.com> wrote:
> > > > >
> > > > > > On Tue, Dec 12, 2023 at 8:18=E2=80=AFPM Chengming Zhou
> > > > > > <zhouchengming@bytedance.com> wrote:
> > > > > > >
> > > > > > > Also after the common decompress part goes to __zswap_load(),=
 we can
> > > > > > > cleanup the zswap_reclaim_entry() a little.
> > > > > >
> > > > > > I think you mean zswap_writeback_entry(), same for the commit t=
itle.
> > > > >
> > > > > I updated my copy of the changelog, thanks.
> > > > >
> > > > > > > -       /*
> > > > > > > -        * If we get here because the page is already in swap=
cache, a
> > > > > > > -        * load may be happening concurrently. It is safe and=
 okay to
> > > > > > > -        * not free the entry. It is also okay to return !0.
> > > > > > > -        */
> > > > > >
> > > > > > This comment should be moved above the failure check of
> > > > > > __read_swap_cache_async() above, not completely removed.
> > > > >
> > > > > This?
> > > >
> > > > Yes, thanks a lot. Although I think a new version is needed anyway =
to
> > > > address other comments.
> > > >
> > > > >
> > > > > --- a/mm/zswap.c~mm-zswap-cleanup-zswap_reclaim_entry-fix
> > > > > +++ a/mm/zswap.c
> > > > > @@ -1457,8 +1457,14 @@ static int zswap_writeback_entry(struct
> > > > >         mpol =3D get_task_policy(current);
> > > > >         page =3D __read_swap_cache_async(swpentry, GFP_KERNEL, mp=
ol,
> > > > >                                 NO_INTERLEAVE_INDEX, &page_was_al=
located, true);
> > > > > -       if (!page)
> > > > > +       if (!page) {
> > > > > +               /*
> > > > > +                * If we get here because the page is already in =
swapcache, a
> > > > > +                * load may be happening concurrently. It is safe=
 and okay to
> > > > > +                * not free the entry. It is also okay to return =
!0.
> > > > > +                */
> > > > >                 return -ENOMEM;
> > > > > +       }
> > > > >
> > > > >         /* Found an existing page, we raced with load/swapin */
> > > > >         if (!page_was_allocated) {
> > >
> > > That's the wrong branch, no?
> > >
> > > !page -> -ENOMEM
> > >
> > > page && !page_was_allocated -> already in swapcache
> >
> > Ah yes, my bad.
> >
> > >
> > > Personally, I don't really get the comment. What does it mean that
> > > it's "okay" not to free the entry? There is a put, which may or may
> > > not free the entry if somebody else is using it. Is it explaining how
> > > lifetime works for refcounted objects? I'm similarly confused by the
> > > "it's okay" to return non-zero. What is that trying to convey?
> > >
> > > Deletion seemed like the right choice here, IMO ;)
> >
> > It's not the clearest of comments for sure. I think it is just trying
> > to say that it is okay not to write back the entry from zswap and to
> > fail, because the caller will just try another page. I did not like
> > silently deleting the comment during the refactoring. How about
> > rewriting it to something like:
> >
> > /*
> >  * If we get here because the page is already in the swapcache, a
> >  * load may be happening concurrently. Skip this page, the caller
> >  * will move on to a different page.
> >  */
>
> Well there is this one already on the branch:
>
> /* Found an existing page, we raced with load/swapin */
>
> which covers the first half. The unspoken assumption there is that
> writeback is an operation for an aged out page, while swapin means the
> age just got reset to 0. Maybe it makes sense to elaborate on that?

How about the following diff? This applies on top of Andrew's fix:

diff --git a/mm/zswap.c b/mm/zswap.c
index e8f8f47596dae..8228a0b370979 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1458,15 +1458,14 @@ static int zswap_writeback_entry(struct
zswap_entry *entry,
        page =3D __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
                                NO_INTERLEAVE_INDEX, &page_was_allocated, t=
rue);
        if (!page) {
-               /*
-                * If we get here because the page is already in swapcache,=
 a
-                * load may be happening concurrently. It is safe and okay =
to
-                * not free the entry. It is also okay to return !0.
-                */
                return -ENOMEM;
        }

-       /* Found an existing page, we raced with load/swapin */
+       /*
+        * Found an existing page, we raced with load/swapin. We generally
+        * writeback cold pages from zswap, and swapin means the page just
+        * became hot. Skip this page and let the caller find another one.
+        */
        if (!page_was_allocated) {
                put_page(page);
                return -EEXIST;

