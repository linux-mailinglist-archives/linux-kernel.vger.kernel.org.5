Return-Path: <linux-kernel+bounces-9156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA58E81C1AE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3723F1F24B25
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F4379483;
	Thu, 21 Dec 2023 23:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A+COp/QW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E7D78E90
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 23:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5e6c8b70766so13886317b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703200567; x=1703805367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpexymlvbsYlSMlmmsXVgPV1uAQkpsZNBznFvXRLoYU=;
        b=A+COp/QWIhOKQ9JAT1Qmb/jSWJuNODnA7w9AoeAOBA0+It6CkGO3DonfiMGl6Yqrz1
         InIEtTmKt3WwixMAldx8ZqtYdirIgTP8vXg+rr41Acj350SYE7eEMTV4APpl3MDva0Ts
         jSif62BtBNWgeAYxz4HvSIS3us2cq50iUmuw4GrroLDwmPyeCqrU2L0EoroENFQTYfuD
         /9TRAr1AeqzIhje4UoBaUrm7l5JJ4tz1Y5/qZu1yOnJ3STvDPWew6v8HafZ3PEM/mp1n
         GtJC6XUFwGqWpi2mlXC2vdlcX/mfLiipfMUMF1je9Eu3ZHdnYN8XidbhPGSjQUaLopWW
         4F1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703200567; x=1703805367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpexymlvbsYlSMlmmsXVgPV1uAQkpsZNBznFvXRLoYU=;
        b=rU5HRP+72hOMwC+YbzW9CTjaw7sr1+iK1ddf9AQguwdvzNZeWLnKyTKmrR6p9H+NG2
         MCi7rZW11I7XixpL9Sq/aQAael0OqDlQKQ63cB2eyPD5pdV1rGcXWba94hCLRyEdpn2h
         A7MqQPPnUrNLtVnIu6jhyc5BOo5lZguwaAK2oPWdm54wcWlTci0mSTZnjvAqVcemfkMu
         rwIkWRud5x7qIK9b+0Wftt8eEeOtZ0gyGfY4MtfVJD46Zyd2xKj8u0bjkXgpnzggh10g
         aaoDAFP7BmDNbqOAHe+4Mr8SFErl/5Ko/OeJlPEwqyCD6fQ9sw3GsaNeH2Tdf515TnX7
         mZPg==
X-Gm-Message-State: AOJu0YzXrH3O3GGboH1JwzJ6cbrcmQ/rmCvJqIn1Rz0ocqHdhMMedANn
	A1JNSJWwcdYiXikhAYWWAr78yO3fq2lQ+me6T0CxfyWr7npU
X-Google-Smtp-Source: AGHT+IEGf1KoiAg3qalYzzNpGvsry2XmOirPe4CPw3+bqr7ew0YtDxKoOdwbNY9/lbIL0zPmtJamo7Q5lch6OgyXEq8=
X-Received: by 2002:a81:6dcb:0:b0:5e8:bfc4:c09 with SMTP id
 i194-20020a816dcb000000b005e8bfc40c09mr556497ywc.52.1703200567063; Thu, 21
 Dec 2023 15:16:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOUHufaBfziNTwypP=dxZXYZi4nniT6aYQZiZxzyQjSa3Zmaow@mail.gmail.com>
 <20231215105324.41241-1-henry.hj@antgroup.com>
In-Reply-To: <20231215105324.41241-1-henry.hj@antgroup.com>
From: Yuanchu Xie <yuanchu@google.com>
Date: Thu, 21 Dec 2023 15:15:54 -0800
Message-ID: <CAJj2-QGqDWGVHEwU+=8+ywEAQtK9QKGZCOhkyEgp8LEWbXDggQ@mail.gmail.com>
Subject: Re: [RFC v2] mm: Multi-Gen LRU: fix use mm/page_idle/bitmap
To: Henry Huang <henry.hj@antgroup.com>
Cc: yuzhao@google.com, akpm@linux-foundation.org, 
	=?UTF-8?B?6LCI6Ym06ZSL?= <henry.tjf@antgroup.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	=?UTF-8?B?5pyx6L6JKOiMtuawtCk=?= <teawater@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Henry, I have a question on memcg charging for the shared pages.
Replied inline.

On Fri, Dec 15, 2023 at 2:53=E2=80=AFAM Henry Huang <henry.hj@antgroup.com>=
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
>
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
> Process in B mmap this file and usually read this file.\

How does the shared memory get charged to the cgroups?
Does it all go to cgroup A or B exclusively, or do some pages get
charged to each one?

>
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
>
> static long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *sc=
, bool can_swap)
> {
> ......
>     /* skip this lruvec as it's low on cold folios */
>     return try_to_inc_max_seq(lruvec, max_seq, sc, can_swap, false) ? -1 =
: 0;
> }
>
> Is it a good idea to include a global parameter no_inversion, and modify =
inc_min_seq
> like this:
>
> static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
> {
>     int zone;
>     int remaining =3D MAX_LRU_BATCH;
>     struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
>     int new_gen, old_gen =3D lru_gen_from_seq(lrugen->min_seq[type]);
>
> -   if (type =3D=3D LRU_GEN_ANON && !can_swap)
> +   if (type =3D=3D LRU_GEN_ANON && !can_swap && !no_inversion)
>         goto done;
> ......
> }
>
> --
> 2.43.0
>
>

