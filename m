Return-Path: <linux-kernel+bounces-3847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670368173DF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFAB6B23058
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59E03064A;
	Mon, 18 Dec 2023 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tF/ZkDce"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CDA200C0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2356bb40e3so95067766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702910392; x=1703515192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pTaPp82Aa5VZmUHLjVfWpth1QdXOXHq0YobrMTPaUg=;
        b=tF/ZkDceha8LK/6OvLLlhyrHVEOXJEcS0DaYFsoEE0SEuxGUuA8Z0COlkBTsLoy+Mr
         IwelOXhWZqlHD7xq3ToJFnTR2Z/vzlnQYcshkmk14Wg9CxofTX8i2UL8BdCVXz0eZ05S
         XF7Js10wYruR8gGRsruAUmULIfi4tvbaI4HrLrBUdrlG6ijsYbcLsZlVu6ccgq0LpPxm
         N2xFlbCnYp+zliaLeqvmmTDuwdqiVJEsrstiFNmYrsNhUAhTP69lPl3c5VCm+LcRXj8c
         YCDgpURPMFUFxfo287S31LIsd+VgUzFCEnux/0AaA2eva3LFpVPSxIhFKhsbzPmcevRS
         7AZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702910392; x=1703515192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pTaPp82Aa5VZmUHLjVfWpth1QdXOXHq0YobrMTPaUg=;
        b=udRuTKgfOBTG/kHV9/UTNByfEAWNvI2XCWPyVGubo5ajqDU7IY0RSazxUtzqT6RpC1
         jNPVSNCzl/EafcVkChTTHBpyZV9Z0ZpJGrZNK+AID+bdch9G8XD0x9z5g+eXEfj6unZ+
         4g+deJMyvk5Gwm9LQlKaWFBxRUXehUPOXdZoGWMDTGhzQF98EqTXfA4jWkrhKQJT8a5s
         4pAor5KEzh4SftY0Qi2oYZky4D4pBi7EzMOaQ6z7wjU+pW+HC/AZLBGNshl5+dFFOCD4
         OcYe58yiLad7o0ZxF74i87YFxUMCJsjBFGh2PZFdBdFTP8h3w8YQiS1ZFkLb3HGQa+QZ
         8mVw==
X-Gm-Message-State: AOJu0YwEDQ52lNkZ2FLTIYrDW0p0F/gZnRaoHnUQY0XJS4I/16KN482T
	s/PXNRIpegnkno8SqieNWKG0661gQdkL23SKvmAXNg==
X-Google-Smtp-Source: AGHT+IErhmQSsH2j5h0Y+N6BksWa046h7FS1zKFIgfG1GpHJ04zswD4nFe+yo9vE93FPqIp1665sVEPOkMGUwGXIA10=
X-Received: by 2002:a17:906:6847:b0:a23:5412:c4a5 with SMTP id
 a7-20020a170906684700b00a235412c4a5mr1280318ejs.61.1702910391612; Mon, 18 Dec
 2023 06:39:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-5-896763369d04@bytedance.com> <CAJD7tkb5cKopA-Lfvtsn7sqgqjRf2kyaMwZhhp6SkveNEwArGw@mail.gmail.com>
 <20231214142320.f5cf319e619dbb2127c423e9@linux-foundation.org>
 <CAJD7tkaJVB+BoYmcO3MtGD7Ku88Sjk-VAK640h9B-aQzyGPdZQ@mail.gmail.com> <20231218140313.GA19167@cmpxchg.org>
In-Reply-To: <20231218140313.GA19167@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 18 Dec 2023 06:39:13 -0800
Message-ID: <CAJD7tkbdCv7CMy71UOCefR2Y1BXevJ2eMmYwk+=e=GPcCqn3+w@mail.gmail.com>
Subject: Re: [PATCH 5/5] mm/zswap: cleanup zswap_reclaim_entry()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>, 
	Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, 
	Vitaly Wool <vitaly.wool@konsulko.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 6:03=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, Dec 14, 2023 at 02:41:26PM -0800, Yosry Ahmed wrote:
> > On Thu, Dec 14, 2023 at 2:23=E2=80=AFPM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> > >
> > > On Wed, 13 Dec 2023 17:02:25 -0800 Yosry Ahmed <yosryahmed@google.com=
> wrote:
> > >
> > > > On Tue, Dec 12, 2023 at 8:18=E2=80=AFPM Chengming Zhou
> > > > <zhouchengming@bytedance.com> wrote:
> > > > >
> > > > > Also after the common decompress part goes to __zswap_load(), we =
can
> > > > > cleanup the zswap_reclaim_entry() a little.
> > > >
> > > > I think you mean zswap_writeback_entry(), same for the commit title=
.
> > >
> > > I updated my copy of the changelog, thanks.
> > >
> > > > > -       /*
> > > > > -        * If we get here because the page is already in swapcach=
e, a
> > > > > -        * load may be happening concurrently. It is safe and oka=
y to
> > > > > -        * not free the entry. It is also okay to return !0.
> > > > > -        */
> > > >
> > > > This comment should be moved above the failure check of
> > > > __read_swap_cache_async() above, not completely removed.
> > >
> > > This?
> >
> > Yes, thanks a lot. Although I think a new version is needed anyway to
> > address other comments.
> >
> > >
> > > --- a/mm/zswap.c~mm-zswap-cleanup-zswap_reclaim_entry-fix
> > > +++ a/mm/zswap.c
> > > @@ -1457,8 +1457,14 @@ static int zswap_writeback_entry(struct
> > >         mpol =3D get_task_policy(current);
> > >         page =3D __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
> > >                                 NO_INTERLEAVE_INDEX, &page_was_alloca=
ted, true);
> > > -       if (!page)
> > > +       if (!page) {
> > > +               /*
> > > +                * If we get here because the page is already in swap=
cache, a
> > > +                * load may be happening concurrently. It is safe and=
 okay to
> > > +                * not free the entry. It is also okay to return !0.
> > > +                */
> > >                 return -ENOMEM;
> > > +       }
> > >
> > >         /* Found an existing page, we raced with load/swapin */
> > >         if (!page_was_allocated) {
>
> That's the wrong branch, no?
>
> !page -> -ENOMEM
>
> page && !page_was_allocated -> already in swapcache

Ah yes, my bad.

>
> Personally, I don't really get the comment. What does it mean that
> it's "okay" not to free the entry? There is a put, which may or may
> not free the entry if somebody else is using it. Is it explaining how
> lifetime works for refcounted objects? I'm similarly confused by the
> "it's okay" to return non-zero. What is that trying to convey?
>
> Deletion seemed like the right choice here, IMO ;)

It's not the clearest of comments for sure. I think it is just trying
to say that it is okay not to write back the entry from zswap and to
fail, because the caller will just try another page. I did not like
silently deleting the comment during the refactoring. How about
rewriting it to something like:

/*
 * If we get here because the page is already in the swapcache, a
 * load may be happening concurrently. Skip this page, the caller
 * will move on to a different page.
 */

