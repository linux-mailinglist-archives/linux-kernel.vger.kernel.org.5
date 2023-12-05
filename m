Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995408042C7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbjLDXrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbjLDXrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:47:22 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0918D4D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 15:46:44 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-332fd78fa9dso4049062f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 15:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701733603; x=1702338403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtEY70Swapvm1FcCGsKX1rWlu1dJk5FF5Xvr3KubAN8=;
        b=TjCqGhX5NancIvUQCaA4I61jwwjcTFOIE1UqYz0pwpEWB2bzdyeuqm/eu5iZqi3SWA
         CZfj3qNpDct0ARYDJjIlKmbJxXagXYBcXCD7VWxhgw8jRvOmNwnw/i5v6Jedd2vc25tC
         oekt4Ba80Rn39QEtnJBNAr+iDmUcR0kUxJN0Fd5yjVg8OqDOw3XP7pU7mavgdXvKdNjd
         P4yocS3PApu0fjEZEsTkIxjm8g/ySu8ijlPnbTVxDmHZZdLZ6RxdvghLP2i4ne23zbmk
         4AAThz7WQsZPvAUoMZV/86J2jQGGheKWC3KDzoLve2RMNXY64j0UCz7ayc3RbZdAvg8t
         Ystg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701733603; x=1702338403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtEY70Swapvm1FcCGsKX1rWlu1dJk5FF5Xvr3KubAN8=;
        b=sbH53rgw5Im9Qqhn+d+8Id5yGwgAE5iinRQDowLmvx+AaJM4VxX3yAp4tp0BDKJGSZ
         PdCv55EQXnkwztcsaNu9/RtaG5Oy2vVaO/gcUWUEWrgiKpHLGarpZ3OiZNCCl/t4xJQ6
         9pL2djMNFLAcX5YLG+Ce9MYyXUD+sIuRY3WfSI4aDUh0FmXi3538381cC7zI5lP5PbcB
         WPBDbMVktFNBVr6k9afkeSuKNuKaMREltyJw9SqbAOdFBmNfTbX8x4ADCiowU59sWzSn
         YftanRqOLAWle5BFCsYkhpHUN9M6bYbENBVlRa3VvncYGzBxA1DTQ10rhuQoBKTbwR4C
         z5lA==
X-Gm-Message-State: AOJu0Yw/6hc/dVAJPq83zzNhunTNX9GwY+P5F/mp4pWpiCG1UUl51kCB
        dmSysHubDGz0UyK8QcMfLAVFNgY/OjfJlXyuwuwcyg==
X-Google-Smtp-Source: AGHT+IE6ULI8JV4+eD+zIqJ2v9i8llmjoQMRAXBnLD0T3fufb9SBUjHdRYjit5Tgsr0qq16efN0gRrPzFUwQEuk7UXA=
X-Received: by 2002:a5d:522b:0:b0:333:43bd:5c67 with SMTP id
 i11-20020a5d522b000000b0033343bd5c67mr884514wra.170.1701733602840; Mon, 04
 Dec 2023 15:46:42 -0800 (PST)
MIME-Version: 1.0
References: <20231129032154.3710765-1-yosryahmed@google.com>
 <20231129032154.3710765-6-yosryahmed@google.com> <20231202083129.3pmds2cddy765szr@google.com>
 <CAJD7tkZPcBbvcK+Xj0edevemB+801wRvvcFDJEjk4ZcjNVoV_w@mail.gmail.com>
 <CAJD7tkY-YTj-4+A6zQT_SjbYyRYyiJHKc9pf1CMqqwU1VRzxvA@mail.gmail.com> <CALvZod5rPrFNLyOpUUbmo2T3zxtDjomDqv+Ba3KyFh=eRwNXjg@mail.gmail.com>
In-Reply-To: <CALvZod5rPrFNLyOpUUbmo2T3zxtDjomDqv+Ba3KyFh=eRwNXjg@mail.gmail.com>
From:   Wei Xu <weixugc@google.com>
Date:   Mon, 4 Dec 2023 15:46:31 -0800
Message-ID: <CAAPL-u-Futq5biNhQKTVi15vzihZxoan-dVORPqpov1saJ99=Q@mail.gmail.com>
Subject: Re: [mm-unstable v4 5/5] mm: memcg: restore subtree stats flushing
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Greg Thelen <gthelen@google.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 3:31=E2=80=AFPM Shakeel Butt <shakeelb@google.com> w=
rote:
>
> On Mon, Dec 4, 2023 at 1:38=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
> > On Mon, Dec 4, 2023 at 12:12=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > On Sat, Dec 2, 2023 at 12:31=E2=80=AFAM Shakeel Butt <shakeelb@google=
.com> wrote:
> > > >
> > > > On Wed, Nov 29, 2023 at 03:21:53AM +0000, Yosry Ahmed wrote:
> > > > [...]
> > > > > +void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
> > > > >  {
> > > > > -     if (memcg_should_flush_stats(root_mem_cgroup))
> > > > > -             do_flush_stats();
> > > > > +     static DEFINE_MUTEX(memcg_stats_flush_mutex);
> > > > > +
> > > > > +     if (mem_cgroup_disabled())
> > > > > +             return;
> > > > > +
> > > > > +     if (!memcg)
> > > > > +             memcg =3D root_mem_cgroup;
> > > > > +
> > > > > +     if (memcg_should_flush_stats(memcg)) {
> > > > > +             mutex_lock(&memcg_stats_flush_mutex);
> > > >
> > > > What's the point of this mutex now? What is it providing? I underst=
and
> > > > we can not try_lock here due to targeted flushing. Why not just let=
 the
> > > > global rstat serialize the flushes? Actually this mutex can cause
> > > > latency hiccups as the mutex owner can get resched during flush and=
 then
> > > > no one can flush for a potentially long time.
> > >
> > > I was hoping this was clear from the commit message and code comments=
,
> > > but apparently I was wrong, sorry. Let me give more context.
> > >
> > > In previous versions and/or series, the mutex was only used with
> > > flushes from userspace to guard in-kernel flushers against high
> > > contention from userspace. Later on, I kept the mutex for all memcg
> > > flushers for the following reasons:
> > >
> > > (a) Allow waiters to sleep:
> > > Unlike other flushers, the memcg flushing path can see a lot of
> > > concurrency. The mutex avoids having a lot of CPUs spinning (e.g.
> > > concurrent reclaimers) by allowing waiters to sleep.
> > >
> > > (b) Check the threshold under lock but before calling cgroup_rstat_fl=
ush():
> > > The calls to cgroup_rstat_flush() are not very cheap even if there's
> > > nothing to flush, as we still need to iterate all CPUs. If flushers
> > > contend directly on the rstat lock, overlapping flushes will
> > > unnecessarily do the percpu iteration once they hold the lock. With
> > > the mutex, they will check the threshold again once they hold the
> > > mutex.
> > >
> > > (c) Protect non-memcg flushers from contention from memcg flushers.
> > > This is not as strong of an argument as protecting in-kernel flushers
> > > from userspace flushers.
> > >
> > > There has been discussions before about changing the rstat lock itsel=
f
> > > to be a mutex, which would resolve (a), but there are concerns about
> > > priority inversions if a low priority task holds the mutex and gets
> > > preempted, as well as the amount of time the rstat lock holder keeps
> > > the lock for:
> > > https://lore.kernel.org/lkml/ZO48h7c9qwQxEPPA@slm.duckdns.org/
> > >
> > > I agree about possible hiccups due to the inner lock being dropped
> > > while the mutex is held. Running a synthetic test with high
> > > concurrency between reclaimers (in-kernel flushers) and stats readers
> > > show no material performance difference with or without the mutex.
> > > Maybe things cancel out, or don't really matter in practice.
> > >
> > > I would prefer to keep the current code as I think (a) and (b) could
> > > cause problems in the future, and the current form of the code (with
> > > the mutex) has already seen mileage with production workloads.
> >
> > Correction: The priority inversion is possible on the memcg side due
> > to the mutex in this patch. Also, for point (a), the spinners will
> > eventually sleep once they hold the lock and hit the first CPU
> > boundary -- because of the lock dropping and cond_resched(). So
> > eventually, all spinners should be able to sleep, although it will be
> > a while until they do. With the mutex, they all sleep from the
> > beginning. Point (b) still holds though.
> >
> > I am slightly inclined to keep the mutex but I can send a small fixlet
> > to remove it if others think otherwise.
> >
> > Shakeel, Wei, any preferences?
>
> My preference is to avoid the issue we know we see in production alot
> i.e. priority inversion.
>
> In future if you see issues with spinning then you can come up with
> the lockless flush mechanism at that time.

Given that the synthetic high concurrency test doesn't show material
performance difference between the mutex and non-mutex versions, I
agree that the mutex can be taken out from this patch set (one less
global mutex to worry about).
