Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D8D779A5B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 00:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbjHKWD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 18:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbjHKWDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 18:03:25 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07EA10FE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 15:03:23 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31965c94001so324482f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 15:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1691791402; x=1692396202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ja3T5Gn8bLTs8qahcXFipYQYmGJRSKtUGuI+S1plgzI=;
        b=BCkR64PQ+4ZowJnTdL/8Q57Vjgc2DUqxzAKs7PPP/dsDYI643mKbY5uqKbzZBWXkEz
         g1GYpYTqnZ1R41mWMmSb1tcMTVaZlecl5tpBS2XcUprIKdqCoi+Oo2EK+Tf6Z7aCYkTx
         C/hlpDMY+tgfhz4ggN8Qn86MQLd+3Lyx51WKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691791402; x=1692396202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ja3T5Gn8bLTs8qahcXFipYQYmGJRSKtUGuI+S1plgzI=;
        b=NZ4ywLC5/yQQ+TXfHNPIw9mMFTD41DPahweR/oyvcpjzqRITYz6hHp/EG+yY1tHmqf
         kyOBbmRVSKUTBtfKfzzt8CGudNhelXafK8eg+T5Oai73e9oN4XmEs2eSLjQ2qVP/pftH
         S5iBdZXiHp/log37Xp5Qwl8ovU4I8Cam1VBZCLTxkroTNIZi2wGfzjfyDNEfK9xa0Go8
         euLdk5zmOW7JkCfFLoxneEvDVC//A0PVKKOy7KIkO+8GxUz375XAw5GsAJ1sALLsCNPv
         pSrYZ3JoypIzy5tf6ls6aCPEml9kZjkgtUH6TzNlnJztwFowGi+DjZwbk8rv1pm3RDAO
         u1Bg==
X-Gm-Message-State: AOJu0YxTIGKE6INHvYJAWt9QSDGOIvHsGQLAumKp+Acyx9SsxUDTCB7e
        s9BV8t3vjuRfNPpO+AxJtJszmefKQErBHA/i8jZfPQ==
X-Google-Smtp-Source: AGHT+IESEWv/Rl1Jy+jhKvpDr9oX97g8iXD1Qt4d7rTfbcNR2B4y1+d+xq9HHmST3FjcoToExwg3sdVTcCqGi77gqqE=
X-Received: by 2002:a5d:49cf:0:b0:317:5b1b:1a40 with SMTP id
 t15-20020a5d49cf000000b003175b1b1a40mr2391981wrs.49.1691791402291; Fri, 11
 Aug 2023 15:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com>
 <20230706062045.xwmwns7cm4fxd7iu@google.com> <CABWYdi2pBaCrdKcM37oBomc+5W8MdRp1HwPpOExBGYfZitxyWA@mail.gmail.com>
 <d3f3a7bc-b181-a408-af1d-dd401c172cbf@redhat.com> <CABWYdi2iWYT0sHpK74W6=Oz6HA_3bAqKQd4h+amK0n3T3nge6g@mail.gmail.com>
 <CABWYdi3YNwtPDwwJWmCO-ER50iP7CfbXkCep5TKb-9QzY-a40A@mail.gmail.com>
In-Reply-To: <CABWYdi3YNwtPDwwJWmCO-ER50iP7CfbXkCep5TKb-9QzY-a40A@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 11 Aug 2023 15:03:11 -0700
Message-ID: <CABWYdi0+0gxr7PB4R8rh6hXO=H7ZaCzfk8bmOSeQMuZR7s7Pjg@mail.gmail.com>
Subject: Re: Expensive memory.stat + cpu.stat reads
To:     Waiman Long <longman@redhat.com>
Cc:     Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 5:30=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com> w=
rote:
>
> On Thu, Jul 13, 2023 at 4:25=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com>=
 wrote:
> > > My understanding of mem-stat and cpu-stat is that they are independen=
t
> > > of each other. In theory, reading one shouldn't affect the performanc=
e
> > > of reading the others. Since you are doing mem-stat and cpu-stat read=
ing
> > > repetitively in a loop, it is likely that all the data are in the cac=
he
> > > most of the time resulting in very fast processing time. If it happen=
s
> > > that the specific memory location of mem-stat and cpu-stat data are s=
uch
> > > that reading one will cause the other data to be flushed out of the
> > > cache and have to be re-read from memory again, you could see
> > > significant performance regression.
> > >
> > > It is one of the possible causes, but I may be wrong.
> >
> > Do you think it's somewhat similar to how iterating a matrix in rows
> > is faster than in columns due to sequential vs random memory reads?
> >
> > * https://stackoverflow.com/q/9936132
> > * https://en.wikipedia.org/wiki/Row-_and_column-major_order
> > * https://en.wikipedia.org/wiki/Loop_interchange
> >
> > I've had a similar suspicion and it would be good to confirm whether
> > it's that or something else. I can probably collect perf counters for
> > different runs, but I'm not sure which ones I'll need.
> >
> > In a similar vein, if we could come up with a tracepoint that would
> > tell us the amount of work done (or any other relevant metric that
> > would help) during rstat flushing, I can certainly collect that
> > information as well for every reading combination.
>
> Since cgroup_rstat_flush_locked appears in flamegraphs for both fast
> (discrete) and slow (combined) cases, I grabbed some stats for it:
>
> * Slow:
>
> completed: 19.43s [manual / mem-stat + cpu-stat]
>
> $ sudo /usr/share/bcc/tools/funclatency -uT cgroup_rstat_flush_locked
> Tracing 1 functions for "cgroup_rstat_flush_locked"... Hit Ctrl-C to end.
> ^C
> 00:12:55
>      usecs               : count     distribution
>          0 -> 1          : 0        |                                    =
    |
>          2 -> 3          : 0        |                                    =
    |
>          4 -> 7          : 0        |                                    =
    |
>          8 -> 15         : 0        |                                    =
    |
>         16 -> 31         : 0        |                                    =
    |
>         32 -> 63         : 0        |                                    =
    |
>         64 -> 127        : 1        |                                    =
    |
>        128 -> 255        : 191      |************                        =
    |
>        256 -> 511        : 590      |************************************=
****|
>        512 -> 1023       : 186      |************                        =
    |
>       1024 -> 2047       : 2        |                                    =
    |
>       2048 -> 4095       : 0        |                                    =
    |
>       4096 -> 8191       : 0        |                                    =
    |
>       8192 -> 16383      : 504      |**********************************  =
    |
>      16384 -> 32767      : 514      |**********************************  =
    |
>      32768 -> 65535      : 3        |                                    =
    |
>      65536 -> 131071     : 1        |                                    =
    |
>
> avg =3D 8852 usecs, total: 17633268 usecs, count: 1992
>
> * Fast:
>
> completed:  0.95s [manual / mem-stat]
> completed:  0.05s [manual / cpu-stat]
>
> $ sudo /usr/share/bcc/tools/funclatency -uT cgroup_rstat_flush_locked
> Tracing 1 functions for "cgroup_rstat_flush_locked"... Hit Ctrl-C to end.
> ^C
> 00:13:27
>      usecs               : count     distribution
>          0 -> 1          : 0        |                                    =
    |
>          2 -> 3          : 0        |                                    =
    |
>          4 -> 7          : 499      |************************************=
****|
>          8 -> 15         : 253      |********************                =
    |
>         16 -> 31         : 191      |***************                     =
    |
>         32 -> 63         : 41       |***                                 =
    |
>         64 -> 127        : 12       |                                    =
    |
>        128 -> 255        : 2        |                                    =
    |
>        256 -> 511        : 2        |                                    =
    |
>        512 -> 1023       : 0        |                                    =
    |
>       1024 -> 2047       : 0        |                                    =
    |
>       2048 -> 4095       : 0        |                                    =
    |
>       4096 -> 8191       : 0        |                                    =
    |
>       8192 -> 16383      : 34       |**                                  =
    |
>      16384 -> 32767      : 21       |*                                   =
    |
>
> avg =3D 857 usecs, total: 904762 usecs, count: 1055
>
> There's a different number of calls into cgroup_rstat_flush_locked and
> they are much slower in the slow case. There are also two bands in the
> slow case, with 8ms..32ms having the half of the calls.
>
> For mem_cgroup_css_rstat_flush:
>
> * Slow:
>
> completed: 32.77s [manual / mem-stat + cpu-stat]
>
> $ sudo /usr/share/bcc/tools/funclatency -uT mem_cgroup_css_rstat_flush
> Tracing 1 functions for "mem_cgroup_css_rstat_flush"... Hit Ctrl-C to end=
.
> ^C
> 00:21:25
>      usecs               : count     distribution
>          0 -> 1          : 93078    |*                                   =
    |
>          2 -> 3          : 3397714  |************************************=
****|
>          4 -> 7          : 1009440  |***********                         =
    |
>          8 -> 15         : 168013   |*                                   =
    |
>         16 -> 31         : 93       |                                    =
    |
>
> avg =3D 3 usecs, total: 17189289 usecs, count: 4668338
>
> * Fast:
>
> completed:  0.16s [manual / mem-stat]
> completed:  0.04s [manual / cpu-stat]
>
> $ sudo /usr/share/bcc/tools/funclatency -uT mem_cgroup_css_rstat_flush
> Tracing 1 functions for "mem_cgroup_css_rstat_flush"... Hit Ctrl-C to end=
.
> ^C
> 00:21:57
>      usecs               : count     distribution
>          0 -> 1          : 1441     |***                                 =
    |
>          2 -> 3          : 18780    |************************************=
****|
>          4 -> 7          : 4826     |**********                          =
    |
>          8 -> 15         : 732      |*                                   =
    |
>         16 -> 31         : 1        |                                    =
    |
>
> avg =3D 3 usecs, total: 89174 usecs, count: 25780
>
> There's an 181x difference in the number of calls into
> mem_cgroup_css_rstat_flush.
>
> Does this provide a clue? Perhaps cgroup_rstat_cpu_pop_updated is
> yielding a ton more iterations for some reason here?
>
> * https://elixir.bootlin.com/linux/v6.1/source/kernel/cgroup/rstat.c#L196
>
> It's inlined, but I can place a probe into the loop:
>
>       7         for_each_possible_cpu(cpu) {
>       8                 raw_spinlock_t *cpu_lock =3D
> per_cpu_ptr(&cgroup_rstat_cpu_lock,
>                                                                cpu);
>      10                 struct cgroup *pos =3D NULL;
>                         unsigned long flags;
>
>                         /*
>                          * The _irqsave() is needed because cgroup_rstat_=
lock is
>                          * spinlock_t which is a sleeping lock on
> PREEMPT_RT. Acquiring
>                          * this lock with the _irq() suffix only
> disables interrupts on
>                          * a non-PREEMPT_RT kernel. The raw_spinlock_t
> below disables
>                          * interrupts on both configurations. The
> _irqsave() ensures
>                          * that interrupts are always disabled and
> later restored.
>                          */
>                         raw_spin_lock_irqsave(cpu_lock, flags);
>                         while ((pos =3D
> cgroup_rstat_cpu_pop_updated(pos, cgrp, cpu))) {
>                                 struct cgroup_subsys_state *css;
>
>                                 cgroup_base_stat_flush(pos, cpu);
>      26                         bpf_rstat_flush(pos, cgroup_parent(pos), =
cpu);
>
>      28                         rcu_read_lock();
>      29                         list_for_each_entry_rcu(css,
> &pos->rstat_css_list,
>                                                         rstat_css_node)
>      31                                 css->ss->css_rstat_flush(css, cpu=
);
>      32                         rcu_read_unlock();
>                         }
>      34                 raw_spin_unlock_irqrestore(cpu_lock, flags);
>
> I added probes on both line 26 and line 31 to catch the middle and inner =
loops.
>
> * Slow:
>
> completed: 32.97s [manual / mem-stat + cpu-stat]
>
>  Performance counter stats for '/tmp/derp':
>
>          4,702,570      probe:cgroup_rstat_flush_locked_L26
>          9,301,436      probe:cgroup_rstat_flush_locked_L31
>
> * Fast:
>
> completed:  0.17s [manual / mem-stat]
> completed:  0.34s [manual / cpu-stat]
>
>  Performance counter stats for '/tmp/derp':
>
>             31,769      probe:cgroup_rstat_flush_locked_L26
>             62,849      probe:cgroup_rstat_flush_locked_L31
>
> It definitely looks like cgroup_rstat_cpu_pop_updated is yielding a
> lot more positions.
>
> I'm going to sign off for the week, but let me know if I should place
> any more probes to nail this down.

I spent some time looking into this and I think I landed on a fix:

* https://github.com/bobrik/linux/commit/50b627811d54

I'm not 100% sure if it's the right fix for the issue, but it reduces
the runtime significantly.

We see a 50x decrease for memory.stat + cpu.stat loop duration with
the patch applied. TL;DR is that memory.stat flushes all cgroups,
while cpu.stat flushes just the subtree you're asking for. Both do it
for cpu and memory at the same time, since both are rstat based. See
the description for the commit linked above for more details.

There are two more graphs to add. I rebooted 4 servers, 2 of which
received my patch and 2 were the control. The reboot happened at
around 05:00Z

First is the latency of scraping cadvisor, where you can clearly see
that the control group is rising with the daily load, while the test
group is staying mostly flat:

* https://i.imgur.com/GMtzHIu.png

Second is the CPU time spent by cadvisor, where you can see a similar pictu=
re:

* https://i.imgur.com/LWHt14P.png

Let me know what you think.
