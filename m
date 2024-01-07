Return-Path: <linux-kernel+bounces-18959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFDB8265B3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 19:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DF1281DD5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 18:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E3510A3B;
	Sun,  7 Jan 2024 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWdaRQSs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD7510A2C
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7b7f6caf047so64279639f.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 10:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704653599; x=1705258399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Tq/x7+l+dEZblRxj/FIt/GF5Ojn1xhSqyYD3OqRmVk=;
        b=IWdaRQSsHAcswoDk6RSRPKWAXWSZIt6xMzjNbvu1CELDbKi4r9MrnrOAR1TaXNIZdV
         goZ8T1BBIYAg4hHajQpbK5AvU9k4kTEczCSaz1toMiXaNJdcuBKZROoPAvn4qEJGDc12
         fd3OpIGLSZaptgVJo+2C8uzMwsEHVzNIGAzg6INIs6v4QOYfz/5DCnLRA4YPvT7SsaZG
         SXlrJ4OvUDiF7qiyKGtg5NzXU25FI0L6ax1vYmoXPBWUVr2wcjg3pLZnbe0vUvV5ik5r
         gjPkYm7Z54UiQeA0pjdn+CWXwoZEcGxF5siaGlozqSbUb9EI0moyrpKJlZiys8BDoGvN
         s8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704653599; x=1705258399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Tq/x7+l+dEZblRxj/FIt/GF5Ojn1xhSqyYD3OqRmVk=;
        b=VDfPol4aQgr+mK0m4YhLiuLHhp9XjoIyuQ4WIZkgYN5vv+6MtsvrOtoIMPm16atG59
         trEhXGSvLBuUuNCTcctupWzEfmLT9S3pTOswbQ5YkAV+Oe3CQp6N2vD6ghvGPnxGnYbz
         qECE5DrQzfJM3jDMFZ6lAarfteM+DTe0xUZ4tdvK9EN89oDtn5KjiNwrp57QC8P7dA39
         pZyQG0XsuWeze5Lx6+QCpor8Ph00ykbPS3CTI97YK8BUVi5R+/FZEhlmYGeS6074/H+L
         2MCUViblhxZ7EsolmG4EQkWtbBEX4ke2zzKaXZYXDtdPSOWnLfFEll1pdLZqoTUrE1S3
         27DA==
X-Gm-Message-State: AOJu0Yx/jEK68c8Wh8RK4/+O9XQEXCm0K+KvxlRnleW+p/VB/sp8GNG4
	i/WIQga/AbdJj7g2R/9+sgnGBYvSh/6iz4r7LV10ZdmkTbLUgA==
X-Google-Smtp-Source: AGHT+IEbVK1rN7WHGe/bkWjVE/28Dbr1kjqmBa2h1jnCGJW+8BzruTIY4XSVLdnajEzuApp5+kyc8Vhjp6MSjSKdOqg=
X-Received: by 2002:a5d:9508:0:b0:7ba:9c04:2e03 with SMTP id
 d8-20020a5d9508000000b007ba9c042e03mr3118070iom.27.1704653599406; Sun, 07 Jan
 2024 10:53:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024142706.195517-1-hezhongkun.hzk@bytedance.com>
 <CAKEwX=OiNB+pPhb-3Tf7O=F7psKE3EOpwmbPSeLSOyuHpj3i+Q@mail.gmail.com>
 <CACSyD1P6HmH9tSvONnNxYv8P+am_hH2dK3UJQd9_+o6EWkPsXA@mail.gmail.com>
 <CAKEwX=PC3C-PrWAH3XiYGyR4ujqBJQBBX6uRa2jXKCy9VMyRCQ@mail.gmail.com>
 <CACSyD1O7t0+BXUujJ81RAdEys3MUnmpu0sRADLazoyvayx5DLA@mail.gmail.com>
 <CAKEwX=P5AC+ubnunnZr5vMiC6fFU+E_E7jg_FZztWwZRYSxTWQ@mail.gmail.com> <CACSyD1Nnc_w3epbt6+EMt7a-4pAzgW1hbE=G5Fy5Tc5R5+uxKw@mail.gmail.com>
In-Reply-To: <CACSyD1Nnc_w3epbt6+EMt7a-4pAzgW1hbE=G5Fy5Tc5R5+uxKw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sun, 7 Jan 2024 10:53:08 -0800
Message-ID: <CAKEwX=P+T1n8phFfwWW3pgc5YB=wNT==8=P1-C_A9sMQqn=56Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 6:10=E2=80=AFAM Zhongkun He <hezhongkun.hzk@bytedanc=
e.com> wrote:
>
> >
> > Hmm originally I was thinking of doing an (unconditional)
> > lru_add_drain() outside of zswap_writeback_entry() - once in
> > shrink_worker() and/or zswap_shrinker_scan(), before we write back any
> > of the entries. Not sure if it would work/help here tho - haven't
> > tested that idea yet.
> >
>
> The pages are allocated by __read_swap_cache_async() in
>  zswap_writeback_entry() and it must be newly allocated=EF=BC=8C
> not cached in swap.
> Please see the code below in zswap_writeback_entry()
>
> page =3D __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
>                 NO_INTERLEAVE_INDEX, &page_was_allocated);
>     if (!page) {
>         goto fail;}
>     /* Found an existing page, we raced with load/swapin */
>     if (!page_was_allocated) {
>         put_page(page);
>         ret =3D -EEXIST;
>         goto fail;
>     }
>
> So when it comes to SetPageReclaim(page),
> The page has just been allocated and is still in the percpu batch,
> which has not been added to the LRU.
>
> Therefore=EF=BC=8Clru_add_drain() did not work outside the
> zswap_writeback_entry(=EF=BC=89

You're right hmmm.

>
> > >
> > > New test:
> > > This patch will add the execution of folio_rotate_reclaimable(not exe=
cuted
> > > without this patch) and lru_add_drain,including percpu lock competiti=
on.
> > > I bind a new task to allocate memory and use the same batch lock to c=
ompete
> > > with the target process, on the same CPU.
> > > context:
> > > 1:stress --vm 1 --vm-bytes 1g    (bind to cpu0)
> > > 2:stress --vm 1 --vm-bytes 5g --vm-hang 0=EF=BC=88bind to cpu0=EF=BC=
=89
> > > 3:reclaim pages, and writeback 5G zswap_entry in cpu0 and node 0.
> > >
> > > Average time of five tests
> > >
> > > Base      patch            patch + compete
> > > 4.947      5.0676          5.1336
> > >                 +2.4%          +3.7%
> > > compete means: a new stress run in cpu0 to compete with the writeback=
 process.
> > > PID USER        %CPU  %MEM     TIME+ COMMAND                         =
P
> > >  1367 root         49.5      0.0       1:09.17 bash     =EF=BC=88writ=
eback=EF=BC=89            0
> > >  1737 root         49.5      2.2       0:27.46 stress      (use percp=
u
> > > lock)    0
> > >
> > > around 2.4% increase in real time,including the execution of
> > > folio_rotate_reclaimable(not executed without this patch) and lru_add=
_drain,but
> > > no lock contentions.
> >
> > Hmm looks like the regression is still there, no?
>
> Yes, it cannot be eliminated.

Yeah this solution is not convincing to me. The overall effect of this
patch is we're trading runtime to save some swap usage. That seems
backward to me? Are there any other observable benefits to this?

Otherwise, unless the benchmark is an adversarial workload that is not
representative of the common case (and you'll need to show me some
alternative benchmark numbers or justifications to convince me here),
IMHO this is a risky change to merge. This is not a feature that is
gated behind a flag that users can safely ignore/disable.

>
> >
> > >
> > > around 1.3% additional  increase in real time with lock contentions o=
n the same
> > > cpu.
> > >
> > > There is another option here, which is not to move the page to the
> > > tail of the inactive
> > > list after end_writeback and delete the following code in
> > > zswap_writeback_entry(),
> > > which did not work properly. But the pages will not be released first=
.
> > >
> > > /* move it to the tail of the inactive list after end_writeback */
> > > SetPageReclaim(page);
> >
> > Or only SetPageReclaim on pages on LRU?
>
> No, all the pages are newly allocted and not on LRU.
>
> This patch should add lru_add_drain() directly, remove the
> if statement.
> The purpose of writing back data is to release the page,
> so I think it is necessary to fix it.
>
> Thanks for your time, Nhat.

Is there a way to detect these kinds of folios at
folio_rotate_reclaimable() callsite? i.e if this is a zswap-owned page
etc. etc.?

