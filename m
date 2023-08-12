Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9C3779B86
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbjHKXoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjHKXoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:44:04 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FA31702
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:44:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bcc0adab4so332933166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691797442; x=1692402242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubu6cpSKCExe0JS1Xgq3IdqkchcgSB+dFH9xM8CV6jU=;
        b=tUXhrrtVVfMzHpqG3xIMGLb6eN/YldQQ2YrcWpXjKPKYRxU79jrCpyAbRRfz7Rgr9O
         UxspBtncf/Tm1aOGXTuzZFndxnesBqXKn1vmSoVYdweq5UY6attL/TncKzoO3NP8iPPu
         FS6DOFd6sFolww7TWeFubk8Jx6BM9VgdyqDwQ999HZ3c6uOeu/VHnx0ksh+g2dC8yj5c
         s9AxlBf66mKwnUtV7SXDAlF1jeAzmA5AIDGCZbpJkSuAVM7Pa7P0Ldu8aBviF0+wv2AW
         IVd2WRMs68fWM5MkUnhAsgJlw9Di5LSsJtRDbLnHXYOkC6Uh3SNel/0lVgD/XrE6iwSL
         ic7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691797442; x=1692402242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubu6cpSKCExe0JS1Xgq3IdqkchcgSB+dFH9xM8CV6jU=;
        b=M0jLul+kHYR+yx6gR3NHt+CTRLRUhbguEDDJn+S2ryEEfgUM807zVwL7F9uA/hIDpk
         xFPvdriUIcGGDhiWFn1Kup+33HMWMgONlYg9uIE9gvTfUG4T2isMgS5Uuytgyn3g50A8
         VCdYq/EzkacCbvLi5LvRe9I8eXBgMeivp2AKkglvP8oAkSz1ABaofNGYGraEQ7GFK/MN
         ACYleaBn8OuOA1E3ZPKXqVDWaHpDnEo1eZUq0AuLMW3+hLKiaWR6qW7Dn+Hswje+EdUj
         XIR+xihxtrESdSxDojMa4PYa6bPlihVIEtAbQikuegkPR51n5ZSFbbjylDGWl37mjiMu
         vPNw==
X-Gm-Message-State: AOJu0YxT7ZxIxWXfNlWPtzZyW5C9k5OtHBU+avV3q7a85U7pD/vJhzwd
        B+olk2uAdz2VohOJcrXdba9CMDFvjQ6awIHsWdCYVw==
X-Google-Smtp-Source: AGHT+IER0lh1pG8/lcj4DuztPypyOZRpMthfP89RkV1SUO7Va0QD5ETE77hyZKbMlocXj2Ro5gCSOA59WjFZ55yOhMo=
X-Received: by 2002:a17:906:30d0:b0:993:f15f:efbe with SMTP id
 b16-20020a17090630d000b00993f15fefbemr2575875ejb.5.1691797441599; Fri, 11 Aug
 2023 16:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com>
 <20230706062045.xwmwns7cm4fxd7iu@google.com> <CABWYdi2pBaCrdKcM37oBomc+5W8MdRp1HwPpOExBGYfZitxyWA@mail.gmail.com>
 <d3f3a7bc-b181-a408-af1d-dd401c172cbf@redhat.com> <CABWYdi2iWYT0sHpK74W6=Oz6HA_3bAqKQd4h+amK0n3T3nge6g@mail.gmail.com>
 <CABWYdi3YNwtPDwwJWmCO-ER50iP7CfbXkCep5TKb-9QzY-a40A@mail.gmail.com> <CABWYdi0+0gxr7PB4R8rh6hXO=H7ZaCzfk8bmOSeQMuZR7s7Pjg@mail.gmail.com>
In-Reply-To: <CABWYdi0+0gxr7PB4R8rh6hXO=H7ZaCzfk8bmOSeQMuZR7s7Pjg@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 11 Aug 2023 16:43:22 -0700
Message-ID: <CAJD7tkaf5GNbyhCbWyyLtxpqmZ4+iByQgmS1QEFf+bnEMCdmFA@mail.gmail.com>
Subject: Re: Expensive memory.stat + cpu.stat reads
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     Waiman Long <longman@redhat.com>,
        Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 3:03=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com> w=
rote:
>
> On Fri, Jul 14, 2023 at 5:30=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com>=
 wrote:
> >
> > On Thu, Jul 13, 2023 at 4:25=E2=80=AFPM Ivan Babrou <ivan@cloudflare.co=
m> wrote:
> > > > My understanding of mem-stat and cpu-stat is that they are independ=
ent
> > > > of each other. In theory, reading one shouldn't affect the performa=
nce
> > > > of reading the others. Since you are doing mem-stat and cpu-stat re=
ading
> > > > repetitively in a loop, it is likely that all the data are in the c=
ache
> > > > most of the time resulting in very fast processing time. If it happ=
ens
> > > > that the specific memory location of mem-stat and cpu-stat data are=
 such
> > > > that reading one will cause the other data to be flushed out of the
> > > > cache and have to be re-read from memory again, you could see
> > > > significant performance regression.
> > > >
> > > > It is one of the possible causes, but I may be wrong.
> > >
> > > Do you think it's somewhat similar to how iterating a matrix in rows
> > > is faster than in columns due to sequential vs random memory reads?
> > >
> > > * https://stackoverflow.com/q/9936132
> > > * https://en.wikipedia.org/wiki/Row-_and_column-major_order
> > > * https://en.wikipedia.org/wiki/Loop_interchange
> > >
> > > I've had a similar suspicion and it would be good to confirm whether
> > > it's that or something else. I can probably collect perf counters for
> > > different runs, but I'm not sure which ones I'll need.
> > >
> > > In a similar vein, if we could come up with a tracepoint that would
> > > tell us the amount of work done (or any other relevant metric that
> > > would help) during rstat flushing, I can certainly collect that
> > > information as well for every reading combination.
> >
> > Since cgroup_rstat_flush_locked appears in flamegraphs for both fast
> > (discrete) and slow (combined) cases, I grabbed some stats for it:
> >
> > * Slow:
> >
> > completed: 19.43s [manual / mem-stat + cpu-stat]
> >
> > $ sudo /usr/share/bcc/tools/funclatency -uT cgroup_rstat_flush_locked
> > Tracing 1 functions for "cgroup_rstat_flush_locked"... Hit Ctrl-C to en=
d.
> > ^C
> > 00:12:55
> >      usecs               : count     distribution
> >          0 -> 1          : 0        |                                  =
      |
> >          2 -> 3          : 0        |                                  =
      |
> >          4 -> 7          : 0        |                                  =
      |
> >          8 -> 15         : 0        |                                  =
      |
> >         16 -> 31         : 0        |                                  =
      |
> >         32 -> 63         : 0        |                                  =
      |
> >         64 -> 127        : 1        |                                  =
      |
> >        128 -> 255        : 191      |************                      =
      |
> >        256 -> 511        : 590      |**********************************=
******|
> >        512 -> 1023       : 186      |************                      =
      |
> >       1024 -> 2047       : 2        |                                  =
      |
> >       2048 -> 4095       : 0        |                                  =
      |
> >       4096 -> 8191       : 0        |                                  =
      |
> >       8192 -> 16383      : 504      |**********************************=
      |
> >      16384 -> 32767      : 514      |**********************************=
      |
> >      32768 -> 65535      : 3        |                                  =
      |
> >      65536 -> 131071     : 1        |                                  =
      |
> >
> > avg =3D 8852 usecs, total: 17633268 usecs, count: 1992
> >
> > * Fast:
> >
> > completed:  0.95s [manual / mem-stat]
> > completed:  0.05s [manual / cpu-stat]
> >
> > $ sudo /usr/share/bcc/tools/funclatency -uT cgroup_rstat_flush_locked
> > Tracing 1 functions for "cgroup_rstat_flush_locked"... Hit Ctrl-C to en=
d.
> > ^C
> > 00:13:27
> >      usecs               : count     distribution
> >          0 -> 1          : 0        |                                  =
      |
> >          2 -> 3          : 0        |                                  =
      |
> >          4 -> 7          : 499      |**********************************=
******|
> >          8 -> 15         : 253      |********************              =
      |
> >         16 -> 31         : 191      |***************                   =
      |
> >         32 -> 63         : 41       |***                               =
      |
> >         64 -> 127        : 12       |                                  =
      |
> >        128 -> 255        : 2        |                                  =
      |
> >        256 -> 511        : 2        |                                  =
      |
> >        512 -> 1023       : 0        |                                  =
      |
> >       1024 -> 2047       : 0        |                                  =
      |
> >       2048 -> 4095       : 0        |                                  =
      |
> >       4096 -> 8191       : 0        |                                  =
      |
> >       8192 -> 16383      : 34       |**                                =
      |
> >      16384 -> 32767      : 21       |*                                 =
      |
> >
> > avg =3D 857 usecs, total: 904762 usecs, count: 1055
> >
> > There's a different number of calls into cgroup_rstat_flush_locked and
> > they are much slower in the slow case. There are also two bands in the
> > slow case, with 8ms..32ms having the half of the calls.
> >
> > For mem_cgroup_css_rstat_flush:
> >
> > * Slow:
> >
> > completed: 32.77s [manual / mem-stat + cpu-stat]
> >
> > $ sudo /usr/share/bcc/tools/funclatency -uT mem_cgroup_css_rstat_flush
> > Tracing 1 functions for "mem_cgroup_css_rstat_flush"... Hit Ctrl-C to e=
nd.
> > ^C
> > 00:21:25
> >      usecs               : count     distribution
> >          0 -> 1          : 93078    |*                                 =
      |
> >          2 -> 3          : 3397714  |**********************************=
******|
> >          4 -> 7          : 1009440  |***********                       =
      |
> >          8 -> 15         : 168013   |*                                 =
      |
> >         16 -> 31         : 93       |                                  =
      |
> >
> > avg =3D 3 usecs, total: 17189289 usecs, count: 4668338
> >
> > * Fast:
> >
> > completed:  0.16s [manual / mem-stat]
> > completed:  0.04s [manual / cpu-stat]
> >
> > $ sudo /usr/share/bcc/tools/funclatency -uT mem_cgroup_css_rstat_flush
> > Tracing 1 functions for "mem_cgroup_css_rstat_flush"... Hit Ctrl-C to e=
nd.
> > ^C
> > 00:21:57
> >      usecs               : count     distribution
> >          0 -> 1          : 1441     |***                               =
      |
> >          2 -> 3          : 18780    |**********************************=
******|
> >          4 -> 7          : 4826     |**********                        =
      |
> >          8 -> 15         : 732      |*                                 =
      |
> >         16 -> 31         : 1        |                                  =
      |
> >
> > avg =3D 3 usecs, total: 89174 usecs, count: 25780
> >
> > There's an 181x difference in the number of calls into
> > mem_cgroup_css_rstat_flush.
> >
> > Does this provide a clue? Perhaps cgroup_rstat_cpu_pop_updated is
> > yielding a ton more iterations for some reason here?
> >
> > * https://elixir.bootlin.com/linux/v6.1/source/kernel/cgroup/rstat.c#L1=
96
> >
> > It's inlined, but I can place a probe into the loop:
> >
> >       7         for_each_possible_cpu(cpu) {
> >       8                 raw_spinlock_t *cpu_lock =3D
> > per_cpu_ptr(&cgroup_rstat_cpu_lock,
> >                                                                cpu);
> >      10                 struct cgroup *pos =3D NULL;
> >                         unsigned long flags;
> >
> >                         /*
> >                          * The _irqsave() is needed because cgroup_rsta=
t_lock is
> >                          * spinlock_t which is a sleeping lock on
> > PREEMPT_RT. Acquiring
> >                          * this lock with the _irq() suffix only
> > disables interrupts on
> >                          * a non-PREEMPT_RT kernel. The raw_spinlock_t
> > below disables
> >                          * interrupts on both configurations. The
> > _irqsave() ensures
> >                          * that interrupts are always disabled and
> > later restored.
> >                          */
> >                         raw_spin_lock_irqsave(cpu_lock, flags);
> >                         while ((pos =3D
> > cgroup_rstat_cpu_pop_updated(pos, cgrp, cpu))) {
> >                                 struct cgroup_subsys_state *css;
> >
> >                                 cgroup_base_stat_flush(pos, cpu);
> >      26                         bpf_rstat_flush(pos, cgroup_parent(pos)=
, cpu);
> >
> >      28                         rcu_read_lock();
> >      29                         list_for_each_entry_rcu(css,
> > &pos->rstat_css_list,
> >                                                         rstat_css_node)
> >      31                                 css->ss->css_rstat_flush(css, c=
pu);
> >      32                         rcu_read_unlock();
> >                         }
> >      34                 raw_spin_unlock_irqrestore(cpu_lock, flags);
> >
> > I added probes on both line 26 and line 31 to catch the middle and inne=
r loops.
> >
> > * Slow:
> >
> > completed: 32.97s [manual / mem-stat + cpu-stat]
> >
> >  Performance counter stats for '/tmp/derp':
> >
> >          4,702,570      probe:cgroup_rstat_flush_locked_L26
> >          9,301,436      probe:cgroup_rstat_flush_locked_L31
> >
> > * Fast:
> >
> > completed:  0.17s [manual / mem-stat]
> > completed:  0.34s [manual / cpu-stat]
> >
> >  Performance counter stats for '/tmp/derp':
> >
> >             31,769      probe:cgroup_rstat_flush_locked_L26
> >             62,849      probe:cgroup_rstat_flush_locked_L31
> >
> > It definitely looks like cgroup_rstat_cpu_pop_updated is yielding a
> > lot more positions.
> >
> > I'm going to sign off for the week, but let me know if I should place
> > any more probes to nail this down.
>
> I spent some time looking into this and I think I landed on a fix:
>
> * https://github.com/bobrik/linux/commit/50b627811d54
>
> I'm not 100% sure if it's the right fix for the issue, but it reduces
> the runtime significantly.

Flushing the entire hierarchy in mem_cgroup_flush_stats() was added
such that concurrent flushers can just skip and let one flusher do the
work for everyone. This was added because we flush the stats in some
paths (like reclaim, refault, dirty throttling) where sometimes there
is a lot of concurrency and we have a thundering herd problem on the
cgroup rstat global lock.

Maybe we can separate userspace reads from other flushers, such that
userspace reads flush the cgroup in question only, while in-kernel
flushers skip if someone else is flushing.

There is also some inconsistency today as not all paths use
mem_cgroup_flush_stats() (see zswap charging function in
mm/memcontrol.c).

Separating userspace reads from in-kernel flushers would also help
because skipping a flush if someone else is flushing for userspace
reads can lead to inaccuracy (see [1]).

I would wait for Shakeel to weigh in here, since he introduced the
unified flushing.

[1]https://lore.kernel.org/lkml/20230809045810.1659356-1-yosryahmed@google.=
com/

>
> We see a 50x decrease for memory.stat + cpu.stat loop duration with
> the patch applied. TL;DR is that memory.stat flushes all cgroups,
> while cpu.stat flushes just the subtree you're asking for. Both do it
> for cpu and memory at the same time, since both are rstat based. See
> the description for the commit linked above for more details.
>
> There are two more graphs to add. I rebooted 4 servers, 2 of which
> received my patch and 2 were the control. The reboot happened at
> around 05:00Z
>
> First is the latency of scraping cadvisor, where you can clearly see
> that the control group is rising with the daily load, while the test
> group is staying mostly flat:
>
> * https://i.imgur.com/GMtzHIu.png
>
> Second is the CPU time spent by cadvisor, where you can see a similar pic=
ture:
>
> * https://i.imgur.com/LWHt14P.png
>
> Let me know what you think.
>
