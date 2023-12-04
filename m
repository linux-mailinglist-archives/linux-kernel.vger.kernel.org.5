Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33F38042D4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343542AbjLDXtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbjLDXtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:49:40 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8649F10F9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 15:49:39 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c0a074e71so17036485e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 15:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701733778; x=1702338578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3cSwqrmkX4JsajZqjZTMkfGrxdPyLxfH/2QNfJnXUU=;
        b=cLpJLmnoYEDpEPHmeL+PUVXC8lx7BNv3IFR/5NkjRdbGxzjWeV6VZzX4PEIj2v07tI
         186YF1SX0Sj0qf8vbiI8Z4RhNA4irc+CPnhpbjfCXYRe9CrptN1OaKNUukTrso//HNf8
         PUtsg9faPvvDYccnPX30/RMXCZjsZFwbVKLQO5HWf5O9EFn6ffNG5dFF3Xui8UZ4TxIL
         FrTBZj8h2JVkZZmuFkh55582v84C+AfW0Q+wIlOgyFNXeN6+XBvlzgekYSY5h7w5uWWt
         OZoznn3E9U6wyLIjI6R7lVSbRSdPM9IxxPwUenshBuXJuc78jA1s5e2fWgk+k/V5ab7P
         htfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701733778; x=1702338578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3cSwqrmkX4JsajZqjZTMkfGrxdPyLxfH/2QNfJnXUU=;
        b=dEllqcigMc5/nSddz7078I/5VShFLE48Zg12AnRgG3v6VTKfQj/O3ZzxuYzGyUGD1U
         eSEDqlK/TZu2dvZ/rysXCdRG26S+bTNsnSseEd/zx/Xcdf9jJBqhg61aw+diFeHnO7A5
         gUvPrC8BlrDB/GS63wetgN+Pa16mmNqTo8SfsSAr+GySVTs41SIt+FpH3yweNkFLchnD
         LfOGKT6mmSyOSUYi2aanj55DjwtNvWSyX6/XvZtRN6vL/9RhppZbaTwC2grC8k7FNyfy
         JFlXQrCIzA8uCgELh/kM9x91ggSmQgyhH2rZf9d1e1Xx+KU0AwyRk3aLih2Fhy/3nBw8
         q3yw==
X-Gm-Message-State: AOJu0YzykAtZGS7MIKUQ4ATeNiDKaL4G3CYB1sGEucOgP0AtZoJjNCaS
        CQvFTUN6mEmL0Mzf+/D1Ijd9lDt5+xOiddxZr+uNaw==
X-Google-Smtp-Source: AGHT+IFJVixn9IRyghYbQ/chviwEMl5ahVWnpLTtJrnlI+8MTwnrFk0sy0B4DOMO2QGdJID6Mz7b7izmi65WnmeEdl4=
X-Received: by 2002:a05:600c:310c:b0:404:4b6f:d70d with SMTP id
 g12-20020a05600c310c00b004044b6fd70dmr3255223wmo.17.1701733777666; Mon, 04
 Dec 2023 15:49:37 -0800 (PST)
MIME-Version: 1.0
References: <20231129032154.3710765-1-yosryahmed@google.com>
 <20231129032154.3710765-6-yosryahmed@google.com> <20231202083129.3pmds2cddy765szr@google.com>
 <CAJD7tkZPcBbvcK+Xj0edevemB+801wRvvcFDJEjk4ZcjNVoV_w@mail.gmail.com>
 <CAJD7tkY-YTj-4+A6zQT_SjbYyRYyiJHKc9pf1CMqqwU1VRzxvA@mail.gmail.com>
 <CALvZod5rPrFNLyOpUUbmo2T3zxtDjomDqv+Ba3KyFh=eRwNXjg@mail.gmail.com> <CAAPL-u-Futq5biNhQKTVi15vzihZxoan-dVORPqpov1saJ99=Q@mail.gmail.com>
In-Reply-To: <CAAPL-u-Futq5biNhQKTVi15vzihZxoan-dVORPqpov1saJ99=Q@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 4 Dec 2023 15:49:01 -0800
Message-ID: <CAJD7tkZgP3m-VVPn+fF_YuvXeQYK=tZZjJHj=dzD=CcSSpp2qg@mail.gmail.com>
Subject: Re: [mm-unstable v4 5/5] mm: memcg: restore subtree stats flushing
To:     Wei Xu <weixugc@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
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

On Mon, Dec 4, 2023 at 3:46=E2=80=AFPM Wei Xu <weixugc@google.com> wrote:
>
> On Mon, Dec 4, 2023 at 3:31=E2=80=AFPM Shakeel Butt <shakeelb@google.com>=
 wrote:
> >
> > On Mon, Dec 4, 2023 at 1:38=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> > >
> > > On Mon, Dec 4, 2023 at 12:12=E2=80=AFPM Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
> > > >
> > > > On Sat, Dec 2, 2023 at 12:31=E2=80=AFAM Shakeel Butt <shakeelb@goog=
le.com> wrote:
> > > > >
> > > > > On Wed, Nov 29, 2023 at 03:21:53AM +0000, Yosry Ahmed wrote:
> > > > > [...]
> > > > > > +void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
> > > > > >  {
> > > > > > -     if (memcg_should_flush_stats(root_mem_cgroup))
> > > > > > -             do_flush_stats();
> > > > > > +     static DEFINE_MUTEX(memcg_stats_flush_mutex);
> > > > > > +
> > > > > > +     if (mem_cgroup_disabled())
> > > > > > +             return;
> > > > > > +
> > > > > > +     if (!memcg)
> > > > > > +             memcg =3D root_mem_cgroup;
> > > > > > +
> > > > > > +     if (memcg_should_flush_stats(memcg)) {
> > > > > > +             mutex_lock(&memcg_stats_flush_mutex);
> > > > >
> > > > > What's the point of this mutex now? What is it providing? I under=
stand
> > > > > we can not try_lock here due to targeted flushing. Why not just l=
et the
> > > > > global rstat serialize the flushes? Actually this mutex can cause
> > > > > latency hiccups as the mutex owner can get resched during flush a=
nd then
> > > > > no one can flush for a potentially long time.
> > > >
> > > > I was hoping this was clear from the commit message and code commen=
ts,
> > > > but apparently I was wrong, sorry. Let me give more context.
> > > >
> > > > In previous versions and/or series, the mutex was only used with
> > > > flushes from userspace to guard in-kernel flushers against high
> > > > contention from userspace. Later on, I kept the mutex for all memcg
> > > > flushers for the following reasons:
> > > >
> > > > (a) Allow waiters to sleep:
> > > > Unlike other flushers, the memcg flushing path can see a lot of
> > > > concurrency. The mutex avoids having a lot of CPUs spinning (e.g.
> > > > concurrent reclaimers) by allowing waiters to sleep.
> > > >
> > > > (b) Check the threshold under lock but before calling cgroup_rstat_=
flush():
> > > > The calls to cgroup_rstat_flush() are not very cheap even if there'=
s
> > > > nothing to flush, as we still need to iterate all CPUs. If flushers
> > > > contend directly on the rstat lock, overlapping flushes will
> > > > unnecessarily do the percpu iteration once they hold the lock. With
> > > > the mutex, they will check the threshold again once they hold the
> > > > mutex.
> > > >
> > > > (c) Protect non-memcg flushers from contention from memcg flushers.
> > > > This is not as strong of an argument as protecting in-kernel flushe=
rs
> > > > from userspace flushers.
> > > >
> > > > There has been discussions before about changing the rstat lock its=
elf
> > > > to be a mutex, which would resolve (a), but there are concerns abou=
t
> > > > priority inversions if a low priority task holds the mutex and gets
> > > > preempted, as well as the amount of time the rstat lock holder keep=
s
> > > > the lock for:
> > > > https://lore.kernel.org/lkml/ZO48h7c9qwQxEPPA@slm.duckdns.org/
> > > >
> > > > I agree about possible hiccups due to the inner lock being dropped
> > > > while the mutex is held. Running a synthetic test with high
> > > > concurrency between reclaimers (in-kernel flushers) and stats reade=
rs
> > > > show no material performance difference with or without the mutex.
> > > > Maybe things cancel out, or don't really matter in practice.
> > > >
> > > > I would prefer to keep the current code as I think (a) and (b) coul=
d
> > > > cause problems in the future, and the current form of the code (wit=
h
> > > > the mutex) has already seen mileage with production workloads.
> > >
> > > Correction: The priority inversion is possible on the memcg side due
> > > to the mutex in this patch. Also, for point (a), the spinners will
> > > eventually sleep once they hold the lock and hit the first CPU
> > > boundary -- because of the lock dropping and cond_resched(). So
> > > eventually, all spinners should be able to sleep, although it will be
> > > a while until they do. With the mutex, they all sleep from the
> > > beginning. Point (b) still holds though.
> > >
> > > I am slightly inclined to keep the mutex but I can send a small fixle=
t
> > > to remove it if others think otherwise.
> > >
> > > Shakeel, Wei, any preferences?
> >
> > My preference is to avoid the issue we know we see in production alot
> > i.e. priority inversion.
> >
> > In future if you see issues with spinning then you can come up with
> > the lockless flush mechanism at that time.
>
> Given that the synthetic high concurrency test doesn't show material
> performance difference between the mutex and non-mutex versions, I
> agree that the mutex can be taken out from this patch set (one less
> global mutex to worry about).

Thanks Wei and Shakeel for your input.

Andrew, could you please squash in the fixlet below and remove the
paragraph starting with "Add a mutex to.." from the commit message?

From 19af26e01f93cbf0806d75a234b78e48c1ce9d80 Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 4 Dec 2023 23:43:29 +0000
Subject: [PATCH] mm: memcg: remove stats flushing mutex

The mutex was intended to make the waiters sleep instead of spin, and
such that we can check the update thresholds again after acquiring the
mutex. However, the mutex has a risk of priority inversion, especially
since the underlying rstat lock can de dropped while the mutex is held.

Synthetic testing with high concurrency of flushers shows no
regressions without the mutex, so remove it.

Suggested-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5d300318bf18a..0563625767349 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -749,21 +749,14 @@ static void do_flush_stats(struct mem_cgroup *memcg)
  */
 void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 {
-       static DEFINE_MUTEX(memcg_stats_flush_mutex);
-
        if (mem_cgroup_disabled())
                return;

        if (!memcg)
                memcg =3D root_mem_cgroup;

-       if (memcg_should_flush_stats(memcg)) {
-               mutex_lock(&memcg_stats_flush_mutex);
-               /* Check again after locking, another flush may have occurr=
ed */
-               if (memcg_should_flush_stats(memcg))
-                       do_flush_stats(memcg);
-               mutex_unlock(&memcg_stats_flush_mutex);
-       }
+       if (memcg_should_flush_stats(memcg))
+               do_flush_stats(memcg);
 }

 void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
--
2.43.0.rc2.451.g8631bc7472-goog
