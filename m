Return-Path: <linux-kernel+bounces-2369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F83815BCF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 22:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 925D1B239D1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 21:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B04347CB;
	Sat, 16 Dec 2023 21:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bW/4OhJm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BDB341AD
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so8165a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 13:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702760858; x=1703365658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8Lv4Mhj6UyiR6Q1vMDEx023oAmbaBlMqkNYOVuH8Dc=;
        b=bW/4OhJm8QyyUMW8OTZW7aU5jVwMksdD0oY8Ypj3rGTlycCl37Yzv7swW0DMWTW+Zl
         hqFfx+kAD+/a9gDo2imvhbG27FCe0V20h6rANgGlEGKCL2l6EgD7ugse1MKdmd9JayIu
         qfqyKmjlRc/oh8tGAbuWBy/qZ5llv9dDQSOhGAR744N2qVshYVt23P36Oh3BVKnlJYPb
         +q+9n9KAGoxHcLUns9ZSX6LW/64Z9YgwZpiw07+bTyfU1fxKrIS19KiIP4PJj3zwsrOM
         Z6nCjEq6P5ZAEHTKoGDPoYV3tp945OHpK4JeomJs+T5dOODyhQC9K2Z5VtP+1+6K+pAT
         ZK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702760858; x=1703365658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8Lv4Mhj6UyiR6Q1vMDEx023oAmbaBlMqkNYOVuH8Dc=;
        b=VahAJ1vSK3MY19KE0CMm+E8dxpxjmdnSiiCv8wthfojRQPDWgorXK2gHjGFO8V4ZCw
         LR5UOIkixia1X6CKfDwe7e8ZN6DATYKXrMH2szk6GakUX/Iu1NTDHNM71Rj/Vp9p7de1
         q9THt9dr2gHSJ05QG3DPIGVp4SnTnLuCjMXYXa6UNRJDvA6l16G3CSsWW7n8OvXSexny
         9Q0I2oPxnrT/SsE/GZtlHaRPSHvBZjAKdGPtwjKDYyzgi/dzfMQUfJYiSAik6phi5XNP
         D8Irx1PPmFb5JeIDrXS28TNZ0eY4uv9AgAg+KHKOFQDjmxsAui/zQBJhlS+1ziV9fzP3
         bk0Q==
X-Gm-Message-State: AOJu0YwHFTpEhr1Dr55ORoDvmbuz4+0dCjBo4ZlodqsAErnXVGoF/bCE
	R5I6TenzswN/3F9lSq5T138hALDXVocFPH2+95BNZ++COgJ7+3LYM9AjPGuJ+Myz
X-Google-Smtp-Source: AGHT+IHEoDsbPQmFEtUMyt+gQsh1WoSkmyQJ0g+yvn8SwSukWuPPioH65QjB+Xq/QR03YA9f3kKpUqBQGrCe/x0aCbg=
X-Received: by 2002:a50:8d15:0:b0:54d:6a88:507e with SMTP id
 s21-20020a508d15000000b0054d6a88507emr111501eds.4.1702760857619; Sat, 16 Dec
 2023 13:07:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOUHufaBfziNTwypP=dxZXYZi4nniT6aYQZiZxzyQjSa3Zmaow@mail.gmail.com>
 <20231215105324.41241-1-henry.hj@antgroup.com>
In-Reply-To: <20231215105324.41241-1-henry.hj@antgroup.com>
From: Yu Zhao <yuzhao@google.com>
Date: Sat, 16 Dec 2023 14:06:59 -0700
Message-ID: <CAOUHufaHWaBcbaK=hFb5BpUSOLK6PsLxqmTU4N7WGnpS5yp-vQ@mail.gmail.com>
Subject: Re: [RFC v2] mm: Multi-Gen LRU: fix use mm/page_idle/bitmap
To: Henry Huang <henry.hj@antgroup.com>
Cc: akpm@linux-foundation.org, =?UTF-8?B?6LCI6Ym06ZSL?= <henry.tjf@antgroup.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	=?UTF-8?B?5pyx6L6JKOiMtuawtCk=?= <teawater@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 3:53=E2=80=AFAM Henry Huang <henry.hj@antgroup.com>=
 wrote:
>
> On Fri, Dec 15, 2023 at 14:46=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrot=
e:
> > >
> > > Thanks for replying this RFC.
> > >
> > > > 1. page_idle/bitmap isn't a capable interface at all -- yes, Google
> > > > proposed the idea [1], but we don't really use it anymore because o=
f
> > > > its poor scalability.
> > >
> > > In our environment, we use /sys/kernel/mm/page_idle/bitmap to check
> > > pages whether were accessed during a peroid of time.
> >
> > Is it a production environment? If so, what's your
> > 1. scan interval
> > 2. memory size
>
> > I'm trying to understand why scalability isn't a problem for you. On
> > an average server, there are hundreds of millions of PFNs, so it'd be
> > very expensive to use that ABI even for a time interval of minutes.
>
> Thanks for replying.
>
> Our scan interval is 10 minutes and total memory size is 512GB.
> We perferred to reclaim pages which idle age > 1 hour at least.

Yes, that makes sense. We have similar use cases, details below.

> > > We manage all pages
> > > idle time in userspace. Then use a prediction algorithm to select pag=
es
> > > to reclaim. These pages would more likely be idled for a long time.
>
> > "There is a system in place now that is based on a user-space process
> > that reads a bitmap stored in sysfs, but it has a high CPU and memory
> > overhead, so a new approach is being tried."
> > https://lwn.net/Articles/787611/
> >
> > Could you elaborate how you solved this problem?
>
> In out environment, we found that we take average 0.4 core and 300MB memo=
ry
> to do scan, basic analyse and reclaim idle pages.
>
> For reducing cpu & memroy usage, we do:
> 1. We implement a ratelimiter to control rate of scan and reclaim.
> 2. All pages info & idle age were stored in local DB file. Our prediction
> algorithm don't need all pages info in memory at the same time.
>
> In out environment, about 1/3 memory was attemped to allocate as THP,
> which may save some cpu usage of scan.
>
> > > We only need kernel to tell use whether a page is accessed, a boolean
> > > value in kernel is enough for our case.
> >
> > How do you define "accessed"? I.e., through page tables or file
> > descriptors or both?
>
> both
>
> > > > 2. PG_idle/young, being a boolean value, has poor granularity. If
> > > > anyone must use page_idle/bitmap for some specific reason, I'd
> > > > recommend exporting generation numbers instead.
> > >
> > > Yes, at first time, we try using multi-gen LRU proactvie scan and
> > > exporting generation&refs number to do the same thing.
> > >
> > > But there are serveral problems:
> > >
> > > 1. multi-gen LRU only care about self-memcg pages. In our environment=
,
> > > it's likely to see that different memcg's process share pages.
> >
> > This is related to my question above: are those pages mapped into
> > different memcgs or not?
>
> There is a case:
> There are two cgroup A, B (B is child cgroup of A)
> Process in A create a file and use mmap to read/write this file.
> Process in B mmap this file and usually read this file.

Yes, actually we have a private patch to solve a similar problem.
Basically it finds VMAs from other processes in different memcgs that
share a mapping and jumps to those VMAs to scan them. We can upstream
it for you if you find it useful too.

> > > We still have no ideas how to solve this problem.
> > >
> > > 2. We set swappiness 0, and use proactive scan to select cold pages
> > > & proactive reclaim to swap anon pages. But we can't control passive
> > > scan(can_swap =3D false), which would make anon pages cold/hot invers=
ion
> > > in inc_min_seq.
> >
> > There is an option to prevent the inversion, IIUC, the force_scan
> > option is what you are looking for.
>
> It seems that doesn't work now.
>
> static void inc_max_seq(struct lruvec *lruvec, bool can_swap, bool force_=
scan)
> {
> ......
>     for (type =3D ANON_AND_FILE - 1; type >=3D 0; type--) {
>         if (get_nr_gens(lruvec, type) !=3D MAX_NR_GENS)
>             continue;
>
>         VM_WARN_ON_ONCE(!force_scan && (type =3D=3D LRU_GEN_FILE || can_s=
wap));
>
>         if (inc_min_seq(lruvec, type, can_swap))
>             continue;
>
>         spin_unlock_irq(&lruvec->lru_lock);
>         cond_resched();
>         goto restart;
>     }
> .....
> }
>
> force_scan is not a parameter of inc_min_seq.
> In our environment, swappiness is 0, so can_swap would be false.
>
> static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
> {
>     int zone;
>     int remaining =3D MAX_LRU_BATCH;
>     struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
>     int new_gen, old_gen =3D lru_gen_from_seq(lrugen->min_seq[type]);
>
>     if (type =3D=3D LRU_GEN_ANON && !can_swap)
>         goto done;
> ......
> }
>
> If can_swap is false, would pass anon lru list.
>
> What's more, in passive scan, force_scan is also false.

Ok, I see what you mean. (I thought "passive" means proactive scans
triggered by the debugfs interface, but it actually means "reactive"
scans triggered by memory pressure.) We actually have a private patch
too to solve this. But there is a corner case here: that private
change, which is essentially the same as what you suggested, can stall
direct reclaim when there is tons of cold anon memory. E.g., if there
is 300GB anon memory in the oldest generation which can't be swapped,
calling inc_min_seq() with can_swap being true would stall the direct
reclaim. Does it make sense?

Let me check the state of those private patches and get back to you in
a couple of days. Thanks!

