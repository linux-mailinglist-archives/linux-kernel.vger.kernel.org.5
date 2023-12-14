Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDF0813A1D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573052AbjLNSiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLNSiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:38:16 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A388210F;
        Thu, 14 Dec 2023 10:38:19 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2cc48cf8e70so6719171fa.3;
        Thu, 14 Dec 2023 10:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702579098; x=1703183898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ziBL7UK9Oc1/5L7WtyU+dQKrNlKre5zYkXTgqofHVc=;
        b=k7/m7/VAjes6X/4ewq2fSboDsWHhsIYwMb5/14LdgozwpaJmJQlzoi7k34ta9W9M+l
         Xhe5H2KuPo1GOHUWlWVzsaFfcpUrluBkMOtR7Ti47IVFU1O4K3/cLexa49sGVVkYIM1o
         WK6yZkJ4ibIi+5OshxSZs9aOn2BqttlZPSXYsx5fFN5FcqGtsP/ygHqmVwhlubSlPIx0
         5dxUeqkgvxPp5m9zPwwU1WaViqJdtpSfeaXUmSJ56/L+Ot5fLv/6HV9ThbcUtEm5qBod
         IdNkHpnHZTf9UmCdYSmjI3+xLD4UAiYEXKYtmv950Eo9QgappeFYoBIcx8OaXTTUvmi0
         C5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702579098; x=1703183898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ziBL7UK9Oc1/5L7WtyU+dQKrNlKre5zYkXTgqofHVc=;
        b=lYV47wrNqvy0Qv7H+PWjz866+gUO9iSGFe99ifgIlvTRbEnqTQWHnorOAnUvrSEEW6
         nkjqG0pq19U3nqbTridprLIjdAnq5wEWbykRbpvb+sk2yknGhrOWRjTfoQzERCwtR4kK
         KWsY/15c78SWhdVmNu9ZOUkLuZ/A/E7kq0WQVi2X2AQfVr81CGEM/DItazzlgnPI+MJ+
         rMjNap1Xc9+iLmdtWw9fzw+1pODo3xB78SysfBht2Cfbth9IqjIKmcWxUb9TK2IaJ0vm
         N5FTruYl7dozkIy/8rXrOCHu8jg0lthm+9A9bJRRAoWPBf9T9iFNX/Fvca3kXal6Rt8C
         5AGg==
X-Gm-Message-State: AOJu0YyiQATQfwDarvo0qkN/Cyd0nK894/UesP5pfqXSRzlh7Q0BToYj
        LmBTN7cvsP/90+qfGEjvE+u149Ok/VCRiRrwlLo=
X-Google-Smtp-Source: AGHT+IE5JaoMVwuhIY4Gwu9lAkiIl+968KlVrVviAdZl3oq7GhMdYQw9+5rUp9endHfP09HKQyGzDw8FXlvhJFWlE+A=
X-Received: by 2002:a2e:22c4:0:b0:2cc:2853:2563 with SMTP id
 i187-20020a2e22c4000000b002cc28532563mr2612142lji.79.1702579097179; Thu, 14
 Dec 2023 10:38:17 -0800 (PST)
MIME-Version: 1.0
References: <20231208061407.2125867-1-yuzhao@google.com> <CAMgjq7BTaV5OvHNjGRVJP2VDxj+PXhfd6957CjS4BJ9J4OY8HA@mail.gmail.com>
 <CAOUHufYwZAUaJh6i8Fazc4gVMSqcsz9JbRNpj0cpx2qR+bZBFw@mail.gmail.com>
 <CAMgjq7AtceR-CXnKFfQHM3qi0y4oGyJ4_sw_uh5EkpXCBzkCXg@mail.gmail.com>
 <CAMgjq7CJ3hYHysyRfHzYU4hOYqhUOttxMYGtg0FxzM_wvvyhFA@mail.gmail.com>
 <CAOUHufa=ybd-EPos9DryLHYyhphN0P7qyV5NY3Pui0dfVSk9tQ@mail.gmail.com> <ZXpx0K8Vdo3FJixg@google.com>
In-Reply-To: <ZXpx0K8Vdo3FJixg@google.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Fri, 15 Dec 2023 02:37:57 +0800
Message-ID: <CAMgjq7CRf4iEKuW2qWKzbhssMbixBo3UoLPqsSk4b+Tvw8at8A@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 1/4] mm/mglru: fix underprotected page cache
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Kalesh Singh <kaleshsingh@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8814=E6=97=A5=E5=
=91=A8=E5=9B=9B 11:09=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, Dec 13, 2023 at 12:59:14AM -0700, Yu Zhao wrote:
> > On Tue, Dec 12, 2023 at 8:03=E2=80=AFPM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > Kairui Song <ryncsn@gmail.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=BA=8C 14:52=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=BA=8C 06:07=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > On Fri, Dec 8, 2023 at 1:24=E2=80=AFAM Kairui Song <ryncsn@gmail.=
com> wrote:
> > > > > >
> > > > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=888=
=E6=97=A5=E5=91=A8=E4=BA=94 14:14=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > >
> > > > > > > Unmapped folios accessed through file descriptors can be
> > > > > > > underprotected. Those folios are added to the oldest generati=
on based
> > > > > > > on:
> > > > > > > 1. The fact that they are less costly to reclaim (no need to =
walk the
> > > > > > >    rmap and flush the TLB) and have less impact on performanc=
e (don't
> > > > > > >    cause major PFs and can be non-blocking if needed again).
> > > > > > > 2. The observation that they are likely to be single-use. E.g=
., for
> > > > > > >    client use cases like Android, its apps parse configuratio=
n files
> > > > > > >    and store the data in heap (anon); for server use cases li=
ke MySQL,
> > > > > > >    it reads from InnoDB files and holds the cached data for t=
ables in
> > > > > > >    buffer pools (anon).
> > > > > > >
> > > > > > > However, the oldest generation can be very short lived, and i=
f so, it
> > > > > > > doesn't provide the PID controller with enough time to respon=
d to a
> > > > > > > surge of refaults. (Note that the PID controller uses weighte=
d
> > > > > > > refaults and those from evicted generations only take a half =
of the
> > > > > > > whole weight.) In other words, for a short lived generation, =
the
> > > > > > > moving average smooths out the spike quickly.
> > > > > > >
> > > > > > > To fix the problem:
> > > > > > > 1. For folios that are already on LRU, if they can be beyond =
the
> > > > > > >    tracking range of tiers, i.e., five accesses through file
> > > > > > >    descriptors, move them to the second oldest generation to =
give them
> > > > > > >    more time to age. (Note that tiers are used by the PID con=
troller
> > > > > > >    to statistically determine whether folios accessed multipl=
e times
> > > > > > >    through file descriptors are worth protecting.)
> > > > > > > 2. When adding unmapped folios to LRU, adjust the placement o=
f them so
> > > > > > >    that they are not too close to the tail. The effect of thi=
s is
> > > > > > >    similar to the above.
> > > > > > >
> > > > > > > On Android, launching 55 apps sequentially:
> > > > > > >                            Before     After      Change
> > > > > > >   workingset_refault_anon  25641024   25598972   0%
> > > > > > >   workingset_refault_file  115016834  106178438  -8%
> > > > > >
> > > > > > Hi Yu,
> > > > > >
> > > > > > Thanks you for your amazing works on MGLRU.
> > > > > >
> > > > > > I believe this is the similar issue I was trying to resolve pre=
viously:
> > > > > > https://lwn.net/Articles/945266/
> > > > > > The idea is to use refault distance to decide if the page shoul=
d be
> > > > > > place in oldest generation or some other gen, which per my test=
,
> > > > > > worked very well, and we have been using refault distance for M=
GLRU in
> > > > > > multiple workloads.
> > > > > >
> > > > > > There are a few issues left in my previous RFC series, like ano=
n pages
> > > > > > in MGLRU shouldn't be considered, I wanted to collect feedback =
or test
> > > > > > cases, but unfortunately it seems didn't get too much attention
> > > > > > upstream.
> > > > > >
> > > > > > I think both this patch and my previous series are for solving =
the
> > > > > > file pages underpertected issue, and I did a quick test using t=
his
> > > > > > series, for mongodb test, refault distance seems still a better
> > > > > > solution (I'm not saying these two optimization are mutually ex=
clusive
> > > > > > though, just they do have some conflicts in implementation and =
solving
> > > > > > similar problem):
> > > > > >
> > > > > > Previous result:
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > Execution Results after 905 seconds
> > > > > > ---------------------------------------------------------------=
---
> > > > > >                   Executed        Time (=C2=B5s)       Rate
> > > > > >   STOCK_LEVEL     2542            27121571486.2   0.09 txn/s
> > > > > > ---------------------------------------------------------------=
---
> > > > > >   TOTAL           2542            27121571486.2   0.09 txn/s
> > > > > >
> > > > > > This patch:
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > Execution Results after 900 seconds
> > > > > > ---------------------------------------------------------------=
---
> > > > > >                   Executed        Time (=C2=B5s)       Rate
> > > > > >   STOCK_LEVEL     1594            27061522574.4   0.06 txn/s
> > > > > > ---------------------------------------------------------------=
---
> > > > > >   TOTAL           1594            27061522574.4   0.06 txn/s
> > > > > >
> > > > > > Unpatched version is always around ~500.
> > > > >
> > > > > Thanks for the test results!
> > > > >
> > > > > > I think there are a few points here:
> > > > > > - Refault distance make use of page shadow so it can better
> > > > > > distinguish evicted pages of different access pattern (re-acces=
s
> > > > > > distance).
> > > > > > - Throttled refault distance can help hold part of workingset w=
hen
> > > > > > memory is too small to hold the whole workingset.
> > > > > >
> > > > > > So maybe part of this patch and the bits of previous series can=
 be
> > > > > > combined to work better on this issue, how do you think?
> > > > >
> > > > > I'll try to find some time this week to look at your RFC. It'd be=
 a
> > >
> > > Hi Yu,
> > >
> > > I'm working on V4 of the RFC now, which just update some comments, an=
d
> > > skip anon page re-activation in refault path for mglru which was not
> > > very helpful, only some tiny adjustment.
> > > And I found it easier to test with fio, using following test script:
> > >
> > > #!/bin/bash
> > > swapoff -a
> > >
> > > modprobe brd rd_nr=3D1 rd_size=3D16777216
> > > mkfs.ext4 /dev/ram0
> > > mount /dev/ram0 /mnt
> > >
> > > mkdir -p /sys/fs/cgroup/benchmark
> > > cd /sys/fs/cgroup/benchmark
> > >
> > > echo 4G > memory.max
> > > echo $$ > cgroup.procs
> > > echo 3 > /proc/sys/vm/drop_caches
> > >
> > > fio -name=3Dmglru --numjobs=3D12 --directory=3D/mnt --size=3D1024m \
> > >           --buffered=3D1 --ioengine=3Dio_uring --iodepth=3D128 \
> > >           --iodepth_batch_submit=3D32 --iodepth_batch_complete=3D32 \
> > >           --rw=3Drandread --random_distribution=3Dzipf:0.5 --norandom=
map \
> > >           --time_based --ramp_time=3D5m --runtime=3D5m --group_report=
ing
> > >
> > > zipf:0.5 is used here to simulate a cached read with slight bias
> > > towards certain pages.
> > > Unpatched 6.7-rc4:
> > > Run status group 0 (all jobs):
> > >    READ: bw=3D6548MiB/s (6866MB/s), 6548MiB/s-6548MiB/s
> > > (6866MB/s-6866MB/s), io=3D1918GiB (2060GB), run=3D300001-300001msec
> > >
> > > Patched with RFC v4:
> > > Run status group 0 (all jobs):
> > >    READ: bw=3D7270MiB/s (7623MB/s), 7270MiB/s-7270MiB/s
> > > (7623MB/s-7623MB/s), io=3D2130GiB (2287GB), run=3D300001-300001msec
> > >
> > > Patched with this series:
> > > Run status group 0 (all jobs):
> > >    READ: bw=3D7098MiB/s (7442MB/s), 7098MiB/s-7098MiB/s
> > > (7442MB/s-7442MB/s), io=3D2079GiB (2233GB), run=3D300002-300002msec
> > >
> > > MGLRU off:
> > > Run status group 0 (all jobs):
> > >    READ: bw=3D6525MiB/s (6842MB/s), 6525MiB/s-6525MiB/s
> > > (6842MB/s-6842MB/s), io=3D1912GiB (2052GB), run=3D300002-300002msec
> > >
> > > - If I change zipf:0.5 to random:
> > > Unpatched 6.7-rc4:
> > > Patched with this series:
> > > Run status group 0 (all jobs):
> > >    READ: bw=3D5975MiB/s (6265MB/s), 5975MiB/s-5975MiB/s
> > > (6265MB/s-6265MB/s), io=3D1750GiB (1879GB), run=3D300002-300002msec
> > >
> > > Patched with RFC v4:
> > > Run status group 0 (all jobs):
> > >    READ: bw=3D5987MiB/s (6278MB/s), 5987MiB/s-5987MiB/s
> > > (6278MB/s-6278MB/s), io=3D1754GiB (1883GB), run=3D300001-300001msec
> > >
> > > Patched with this series:
> > > Run status group 0 (all jobs):
> > >    READ: bw=3D5839MiB/s (6123MB/s), 5839MiB/s-5839MiB/s
> > > (6123MB/s-6123MB/s), io=3D1711GiB (1837GB), run=3D300001-300001msec
> > >
> > > MGLRU off:
> > > Run status group 0 (all jobs):
> > >    READ: bw=3D5689MiB/s (5965MB/s), 5689MiB/s-5689MiB/s
> > > (5965MB/s-5965MB/s), io=3D1667GiB (1790GB), run=3D300003-300003msec
> > >
> > > fio uses ramdisk so LRU accuracy will have smaller impact. The Mongod=
b
> > > test I provided before uses a SATA SSD so it will have a much higher
> > > impact. I'll provides a script to setup the test case and run it, it'=
s
> > > more complex to setup than fio since involving setting up multiple
> > > replicas and auth and hundreds of GB of test fixtures, I'm currently
> > > occupied by some other tasks but will try best to send them out as
> > > soon as possible.
> >
> > Thanks! Apparently your RFC did show better IOPS with both access
> > patterns, which was a surprise to me because it had higher refaults
> > and usually higher refautls result in worse performance.
> >
> > So I'm still trying to figure out why it turned out the opposite. My
> > current guess is that:
> > 1. It had a very small but stable inactive LRU list, which was able to
> > fit into the L3 cache entirely.
> > 2. It counted few folios as workingset and therefore incurred less
> > overhead from CONFIG_PSI and/or CONFIG_TASK_DELAY_ACCT.
> >
> > Did you save workingset_refault_file when you ran the test? If so, can
> > you check the difference between this series and your RFC?
>
>
> It seems I was right about #1 above. After I scaled your test up by 20x,
> I saw my series performed ~5% faster with zipf and ~9% faster with random
> accesses.

Hi Yu,

Thank you so much for testing and sharing this result.

I'm not sure about #1, the ramdisk size, access data, are far larger
than L3 (16M on my CPU) even in down scaled test, and both random/zipf
shows similar result.

>
> IOW, I made rd_size from 16GB to 320GB, memory.max from 4GB to 80GB,
> --numjobs from 12 to 60 and --size from 1GB to 4GB.
>
> v6.7-c5 + this series
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> zipf
> ----
>
> mglru: (groupid=3D0, jobs=3D60): err=3D 0: pid=3D12155: Wed Dec 13 17:50:=
36 2023
>   read: IOPS=3D5074k, BW=3D19.4GiB/s (20.8GB/s)(5807GiB/300007msec)
>     slat (usec): min=3D36, max=3D109326, avg=3D363.67, stdev=3D1829.97
>     clat (nsec): min=3D783, max=3D113292k, avg=3D1136755.10, stdev=3D3162=
056.05
>      lat (usec): min=3D37, max=3D149232, avg=3D1500.43, stdev=3D3644.21
>     clat percentiles (usec):
>      |  1.00th=3D[  490],  5.00th=3D[  519], 10.00th=3D[  537], 20.00th=
=3D[  553],
>      | 30.00th=3D[  570], 40.00th=3D[  586], 50.00th=3D[  627], 60.00th=
=3D[  840],
>      | 70.00th=3D[  988], 80.00th=3D[ 1074], 90.00th=3D[ 1188], 95.00th=
=3D[ 1336],
>      | 99.00th=3D[ 7308], 99.50th=3D[31327], 99.90th=3D[36963], 99.95th=
=3D[45351],
>      | 99.99th=3D[53216]
>    bw (  MiB/s): min=3D 8332, max=3D27116, per=3D100.00%, avg=3D19846.67,=
 stdev=3D58.20, samples=3D35903
>    iops        : min=3D2133165, max=3D6941826, avg=3D5080741.79, stdev=3D=
14899.13, samples=3D35903
>   lat (nsec)   : 1000=3D0.01%
>   lat (usec)   : 4=3D0.01%, 10=3D0.01%, 20=3D0.01%, 50=3D0.01%, 100=3D0.0=
1%
>   lat (usec)   : 250=3D0.01%, 500=3D1.76%, 750=3D52.94%, 1000=3D16.65%
>   lat (msec)   : 2=3D26.22%, 4=3D0.15%, 10=3D1.36%, 20=3D0.01%, 50=3D0.90=
%
>   lat (msec)   : 100=3D0.02%, 250=3D0.01%
>   cpu          : usr=3D5.42%, sys=3D87.59%, ctx=3D470315, majf=3D0, minf=
=3D2184
>   IO depths    : 1=3D0.0%, 2=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=3D=
0.0%, >=3D64=3D100.0%
>      submit    : 0=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.1%, 32=3D100.0%, 64=
=3D0.0%, >=3D64=3D0.0%
>      complete  : 0=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=3D100.0%, 64=
=3D0.0%, >=3D64=3D0.1%
>      issued rwts: total=3D1522384845,0,0,0 short=3D0,0,0,0 dropped=3D0,0,=
0,0
>      latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D12=
8
>
> Run status group 0 (all jobs):
>    READ: bw=3D19.4GiB/s (20.8GB/s), 19.4GiB/s-19.4GiB/s (20.8GB/s-20.8GB/=
s), io=3D5807GiB (6236GB), run=3D300007-300007msec
>
> Disk stats (read/write):
>   ram0: ios=3D0/0, sectors=3D0/0, merge=3D0/0, ticks=3D0/0, in_queue=3D0,=
 util=3D0.00%
> mglru: (g=3D0): rw=3Drandread, bs=3D(R) 4096B-4096B, (W) 4096B-4096B, (T)=
 4096B-4096B, ioengine=3Dio_uring, iodepth=3D128
>
> random
> ------
>
> mglru: (groupid=3D0, jobs=3D60): err=3D 0: pid=3D12576: Wed Dec 13 18:00:=
50 2023
>   read: IOPS=3D3853k, BW=3D14.7GiB/s (15.8GB/s)(4410GiB/300014msec)
>     slat (usec): min=3D58, max=3D118605, avg=3D486.45, stdev=3D2311.45
>     clat (usec): min=3D3, max=3D169810, avg=3D1496.60, stdev=3D3982.89
>      lat (usec): min=3D73, max=3D170019, avg=3D1983.06, stdev=3D4585.87
>     clat percentiles (usec):
>      |  1.00th=3D[  586],  5.00th=3D[  627], 10.00th=3D[  644], 20.00th=
=3D[  668],
>      | 30.00th=3D[  693], 40.00th=3D[  725], 50.00th=3D[  816], 60.00th=
=3D[ 1123],
>      | 70.00th=3D[ 1221], 80.00th=3D[ 1352], 90.00th=3D[ 1516], 95.00th=
=3D[ 1713],
>      | 99.00th=3D[31851], 99.50th=3D[34866], 99.90th=3D[41681], 99.95th=
=3D[54264],
>      | 99.99th=3D[61080]
>    bw (  MiB/s): min=3D 6049, max=3D21328, per=3D100.00%, avg=3D15070.00,=
 stdev=3D45.96, samples=3D35940
>    iops        : min=3D1548543, max=3D5459997, avg=3D3857912.87, stdev=3D=
11765.30, samples=3D35940
>   lat (usec)   : 4=3D0.01%, 10=3D0.01%, 20=3D0.01%, 100=3D0.01%, 250=3D0.=
01%
>   lat (usec)   : 500=3D0.01%, 750=3D44.64%, 1000=3D8.20%
>   lat (msec)   : 2=3D43.84%, 4=3D0.27%, 10=3D1.79%, 20=3D0.01%, 50=3D1.20=
%
>   lat (msec)   : 100=3D0.07%, 250=3D0.01%
>   cpu          : usr=3D3.19%, sys=3D89.87%, ctx=3D463840, majf=3D0, minf=
=3D2248
>   IO depths    : 1=3D0.0%, 2=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=3D=
0.0%, >=3D64=3D100.0%
>      submit    : 0=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=3D100.0%, 64=
=3D0.0%, >=3D64=3D0.0%
>      complete  : 0=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=3D100.0%, 64=
=3D0.0%, >=3D64=3D0.1%
>      issued rwts: total=3D1155923744,0,0,0 short=3D0,0,0,0 dropped=3D0,0,=
0,0
>      latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D12=
8
>
> Run status group 0 (all jobs):
>    READ: bw=3D14.7GiB/s (15.8GB/s), 14.7GiB/s-14.7GiB/s (15.8GB/s-15.8GB/=
s), io=3D4410GiB (4735GB), run=3D300014-300014msec
>
> Disk stats (read/write):
>   ram0: ios=3D0/0, sectors=3D0/0, merge=3D0/0, ticks=3D0/0, in_queue=3D0,=
 util=3D0.00%
>
> memcg     3 /zipf
>  node     0
>           0    1521654          0           0x
>                      0          0r          0e          0p          0    =
       0           0
>                      1          0r          0e          0p          0    =
       0           0
>                      2          0r          0e          0p          0    =
       0           0
>                      3          0r          0e          0p          0    =
       0           0
>                                 0           0           0           0    =
       0           0
>           1    1521654          0          21
>                      0          0           0           0  1077016797r 11=
11542014e          0p
>                      1          0           0           0   317997853r  3=
24814007e          0p
>                      2          0           0           0    68064253r   =
68866308e     124302p
>                      3          0           0           0           0r   =
       0e   12282816p
>                                 0           0           0           0    =
       0           0
>           2    1521654          0           0
>                      0          0           0           0           0    =
       0           0
>                      1          0           0           0           0    =
       0           0
>                      2          0           0           0           0    =
       0           0
>                      3          0           0           0           0    =
       0           0
>                                 0           0           0           0    =
       0           0
>           3    1521654          0           0
>                      0          0R          0T          0           0R   =
       0T          0
>                      1          0R          0T          0           0R   =
       0T          0
>                      2          0R          0T          0           0R   =
       0T          0
>                      3          0R          0T          0           0R   =
       0T          0
>                                 0L          0O          0Y          0N   =
       0F          0A
>  node     1
>           0    1521654          0           0
>                      0          0r          0e          0p          0r   =
       0e          0p
>                      1          0r          0e          0p          0r   =
       0e          0p
>                      2          0r          0e          0p          0r   =
       0e          0p
>                      3          0r          0e          0p          0r   =
       0e          0p
>                                 0           0           0           0    =
       0           0
>           1    1521654          0           0
>                      0          0           0           0           0    =
       0           0
>                      1          0           0           0           0    =
       0           0
>                      2          0           0           0           0    =
       0           0
>                      3          0           0           0           0    =
       0           0
>                                 0           0           0           0    =
       0           0
>           2    1521654          0           0
>                      0          0           0           0           0    =
       0           0
>                      1          0           0           0           0    =
       0           0
>                      2          0           0           0           0    =
       0           0
>                      3          0           0           0           0    =
       0           0
>                                 0           0           0           0    =
       0           0
>           3    1521654          0           0
>                      0          0R          0T          0           0R   =
       0T          0
>                      1          0R          0T          0           0R   =
       0T          0
>                      2          0R          0T          0           0R   =
       0T          0
>                      3          0R          0T          0           0R   =
       0T          0
>                                 0L          0O          0Y          0N   =
       0F          0A
> memcg     4 /random
>  node     0
>           0     600431          0           0x
>                      0          0r          0e          0p          0    =
       0           0
>                      1          0r          0e          0p          0    =
       0           0
>                      2          0r          0e          0p          0    =
       0           0
>                      3          0r          0e          0p          0    =
       0           0
>                                 0           0           0           0    =
       0           0
>           1     600431          0    11169201
>                      0          0           0           0  1071724785r 11=
03937007e          0p
>                      1          0           0           0   376193810r  3=
84852629e          0p
>                      2          0           0           0    77315518r   =
78596395e          0p
>                      3          0           0           0           0r   =
       0e    9593442p
>                                 0           0           0           0    =
       0           0
>           2     600431          1     9593442
>                      0          0           0           0           0    =
       0           0
>                      1          0           0           0           0    =
       0           0
>                      2          0           0           0           0    =
       0           0
>                      3          0           0           0           0    =
       0           0
>                                 0           0           0           0    =
       0           0
>           3     600431         36         754
>                      0          0R          0T          0           0R   =
       0T          0
>                      1          0R          0T          0           0R   =
       0T          0
>                      2          0R          0T          0           0R   =
       0T          0
>                      3          0R          0T          0           0R   =
       0T          0
>                                 0L          0O          0Y          0N   =
       0F          0A
>  node     1
>           0     600431          0           0
>                      0          0r          0e          0p          0r   =
       0e          0p
>                      1          0r          0e          0p          0r   =
       0e          0p
>                      2          0r          0e          0p          0r   =
       0e          0p
>                      3          0r          0e          0p          0r   =
       0e          0p
>                                 0           0           0           0    =
       0           0
>           1     600431          0           0
>                      0          0           0           0           0    =
       0           0
>                      1          0           0           0           0    =
       0           0
>                      2          0           0           0           0    =
       0           0
>                      3          0           0           0           0    =
       0           0
>                                 0           0           0           0    =
       0           0
>           2     600431          0           0
>                      0          0           0           0           0    =
       0           0
>                      1          0           0           0           0    =
       0           0
>                      2          0           0           0           0    =
       0           0
>                      3          0           0           0           0    =
       0           0
>                                 0           0           0           0    =
       0           0
>           3     600431          0           0
>                      0          0R          0T          0           0R   =
       0T          0
>                      1          0R          0T          0           0R   =
       0T          0
>                      2          0R          0T          0           0R   =
       0T          0
>                      3          0R          0T          0           0R   =
       0T          0
>                                 0L          0O          0Y          0N   =
       0F          0A
>
> v6.7-c5 + RFC v3
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> zipf
> ----
>
> mglru: (groupid=3D0, jobs=3D60): err=3D 0: pid=3D11600: Wed Dec 13 18:34:=
31 2023
>   read: IOPS=3D4816k, BW=3D18.4GiB/s (19.7GB/s)(5512GiB/300014msec)
>     slat (usec): min=3D3, max=3D121722, avg=3D384.46, stdev=3D2066.10
>     clat (nsec): min=3D356, max=3D174717k, avg=3D1197513.60, stdev=3D3568=
734.58
>      lat (usec): min=3D3, max=3D174919, avg=3D1581.97, stdev=3D4112.49
>     clat percentiles (usec):
>      |  1.00th=3D[  486],  5.00th=3D[  515], 10.00th=3D[  529], 20.00th=
=3D[  553],
>      | 30.00th=3D[  570], 40.00th=3D[  594], 50.00th=3D[  652], 60.00th=
=3D[  898],
>      | 70.00th=3D[  988], 80.00th=3D[ 1139], 90.00th=3D[ 1254], 95.00th=
=3D[ 1369],
>      | 99.00th=3D[ 6915], 99.50th=3D[35914], 99.90th=3D[42206], 99.95th=
=3D[52167],
>      | 99.99th=3D[61604]
>    bw (  MiB/s): min=3D 7716, max=3D26325, per=3D100.00%, avg=3D18836.65,=
 stdev=3D57.20, samples=3D35880
>    iops        : min=3D1975306, max=3D6739280, avg=3D4822176.85, stdev=3D=
14642.35, samples=3D35880
>   lat (nsec)   : 500=3D0.01%, 750=3D0.01%, 1000=3D0.01%
>   lat (usec)   : 4=3D0.01%, 10=3D0.01%, 20=3D0.01%, 100=3D0.01%, 250=3D0.=
01%
>   lat (usec)   : 500=3D2.57%, 750=3D50.99%, 1000=3D17.56%
>   lat (msec)   : 2=3D26.41%, 4=3D0.16%, 10=3D1.41%, 20=3D0.01%, 50=3D0.84=
%
>   lat (msec)   : 100=3D0.05%, 250=3D0.01%
>   cpu          : usr=3D4.95%, sys=3D88.09%, ctx=3D457609, majf=3D0, minf=
=3D2184
>   IO depths    : 1=3D0.0%, 2=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=3D=
0.0%, >=3D64=3D100.0%
>      submit    : 0=3D0.0%, 4=3D0.1%, 8=3D0.0%, 16=3D0.0%, 32=3D100.0%, 64=
=3D0.0%, >=3D64=3D0.0%
>      complete  : 0=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=3D100.0%, 64=
=3D0.0%, >=3D64=3D0.1%
>      issued rwts: total=3D1445015808,0,0,0 short=3D0,0,0,0 dropped=3D0,0,=
0,0
>      latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D12=
8
>
> Run status group 0 (all jobs):
>    READ: bw=3D18.4GiB/s (19.7GB/s), 18.4GiB/s-18.4GiB/s (19.7GB/s-19.7GB/=
s), io=3D5512GiB (5919GB), run=3D300014-300014msec
>
> Disk stats (read/write):
>   ram0: ios=3D0/0, sectors=3D0/0, merge=3D0/0, ticks=3D0/0, in_queue=3D0,=
 util=3D0.00%
> mglru: (g=3D0): rw=3Drandread, bs=3D(R) 4096B-4096B, (W) 4096B-4096B, (T)=
 4096B-4096B, ioengine=3Dio_uring, iodepth=3D128
>
> random
> ------
>
> mglru: (groupid=3D0, jobs=3D60): err=3D 0: pid=3D12024: Wed Dec 13 18:44:=
45 2023
>   read: IOPS=3D3519k, BW=3D13.4GiB/s (14.4GB/s)(4027GiB/300011msec)
>     slat (usec): min=3D54, max=3D136278, avg=3D534.57, stdev=3D2738.72
>     clat (usec): min=3D3, max=3D176186, avg=3D1638.66, stdev=3D4714.55
>      lat (usec): min=3D78, max=3D176426, avg=3D2173.23, stdev=3D5426.40
>     clat percentiles (usec):
>      |  1.00th=3D[  627],  5.00th=3D[  676], 10.00th=3D[  693], 20.00th=
=3D[  725],
>      | 30.00th=3D[  766], 40.00th=3D[  816], 50.00th=3D[ 1090], 60.00th=
=3D[ 1205],
>      | 70.00th=3D[ 1270], 80.00th=3D[ 1369], 90.00th=3D[ 1500], 95.00th=
=3D[ 1614],
>      | 99.00th=3D[38536], 99.50th=3D[41681], 99.90th=3D[47973], 99.95th=
=3D[65799],
>      | 99.99th=3D[72877]
>    bw (  MiB/s): min=3D 5586, max=3D20476, per=3D100.00%, avg=3D13760.26,=
 stdev=3D45.33, samples=3D35904
>    iops        : min=3D1430070, max=3D5242110, avg=3D3522621.15, stdev=3D=
11604.46, samples=3D35904
>   lat (usec)   : 4=3D0.01%, 10=3D0.01%, 20=3D0.01%, 100=3D0.01%, 250=3D0.=
01%
>   lat (usec)   : 500=3D0.01%, 750=3D26.33%, 1000=3D21.81%
>   lat (msec)   : 2=3D48.54%, 4=3D0.16%, 10=3D1.91%, 20=3D0.01%, 50=3D1.17=
%
>   lat (msec)   : 100=3D0.09%, 250=3D0.01%
>   cpu          : usr=3D2.74%, sys=3D90.35%, ctx=3D481356, majf=3D0, minf=
=3D2244
>   IO depths    : 1=3D0.0%, 2=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=3D=
0.0%, >=3D64=3D100.0%
>      submit    : 0=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=3D100.0%, 64=
=3D0.0%, >=3D64=3D0.0%
>      complete  : 0=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=3D100.0%, 64=
=3D0.0%, >=3D64=3D0.1%
>      issued rwts: total=3D1055590880,0,0,0 short=3D0,0,0,0 dropped=3D0,0,=
0,0
>      latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D12=
8
>
> Run status group 0 (all jobs):
>    READ: bw=3D13.4GiB/s (14.4GB/s), 13.4GiB/s-13.4GiB/s (14.4GB/s-14.4GB/=
s), io=3D4027GiB (4324GB), run=3D300011-300011msec
>
> Disk stats (read/write):
>   ram0: ios=3D0/0, sectors=3D0/0, merge=3D0/0, ticks=3D0/0, in_queue=3D0,=
 util=3D0.00%
>
> memcg     3 /zipf
>  node     0
>           0    1522519          0          22
>                      0          0r          0e          0p  996363383r 10=
92111170e          0p
>                      1          0r          0e          0p  274581982r  2=
35766575e          0p
>                      2          0r          0e          0p   85176438r   =
71356676e      96114p
>                      3          0r          0e          0p   12470364r   =
11510461e     221796p
>                                 0           0           0           0    =
       0           0
>           1    1522519          0           0
>                      0          0           0           0           0    =
       0           0
>                      1          0           0           0           0    =
       0           0
>                      2          0           0           0           0    =
       0           0
>                      3          0           0           0           0    =
       0           0
>                                 0           0           0           0    =
       0           0
>           2    1522519          0           0
>                      0          0           0           0           0    =
       0           0
>                      1          0           0           0           0    =
       0           0
>                      2          0           0           0           0    =
       0           0
>                      3          0           0           0           0    =
       0           0
>                                 0           0           0           0    =
       0           0
>           3    1522519          0           0
>                      0          0R          0T          0           0R   =
       0T          0
>                      1          0R          0T          0           0R   =
       0T          0
>                      2          0R          0T          0           0R   =
       0T          0
>                      3          0R          0T          0           0R   =
       0T          0
>                                 0L          0O          0Y          0N   =
       0F          0A
>  node     1
>           0    1522519          0           0
>                      0          0r          0e          0p          0r   =
       0e          0p
>                      1          0r          0e          0p          0r   =
       0e          0p
>                      2          0r          0e          0p          0r   =
       0e          0p
>                      3          0r          0e          0p          0r   =
       0e          0p
>                                 0           0           0           0    =
       0           0
>           1    1522519          0           0
>                      0          0           0           0           0    =
       0           0
>                      1          0           0           0           0    =
       0           0
>                      2          0           0           0           0    =
       0           0
>                      3          0           0           0           0    =
       0           0
>                                 0           0           0           0    =
       0           0
>           2    1522519          0           0
>                      0          0           0           0           0    =
       0           0
>                      1          0           0           0           0    =
       0           0
>                      2          0           0           0           0    =
       0           0
>                      3          0           0           0           0    =
       0           0
>                                 0           0           0           0    =
       0           0
>           3    1522519          0           0
>                      0          0R          0T          0           0R   =
       0T          0
>                      1          0R          0T          0           0R   =
       0T          0
>                      2          0R          0T          0           0R   =
       0T          0
>                      3          0R          0T          0           0R   =
       0T          0
>                                 0L          0O          0Y          0N   =
       0F          0A
> memcg     4 /random
>  node     0
>           0     600413          0     2289676
>                      0          0r          0e          0p  875605725r  9=
60492874e          0p
>                      1          0r          0e          0p  411230731r  3=
83704269e          0p
>                      2          0r          0e          0p  112639317r   =
97774351e          0p
>                      3          0r          0e          0p    2103334r   =
 1766407e          0p
>                                 0           0           0           0    =
       0           0
>           1     600413          1           0
>                      0          0           0           0           0    =
       0           0
>                      1          0           0           0           0    =
       0           0
>                      2          0           0           0           0    =
       0           0
>                      3          0           0           0           0    =
       0           0
>                                 0           0           0           0    =
       0           0
>           2     600413          0           0
>                      0          0           0           0           0    =
       0           0
>                      1          0           0           0           0    =
       0           0
>                      2          0           0           0           0    =
       0           0
>                      3          0           0           0           0    =
       0           0
>                                 0           0           0           0    =
       0           0
>           3     600413         35    18466878
>                      0          0R          0T          0           0R   =
       0T          0
>                      1          0R          0T          0           0R   =
       0T          0
>                      2          0R          0T          0           0R   =
       0T          0
>                      3          0R          0T          0           0R   =
       0T          0
>                                 0L          0O          0Y          0N   =
       0F          0A
>  node     1
>           0     600413          0           0
>                      0          0r          0e          0p          0r   =
       0e          0p
>                      1          0r          0e          0p          0r   =
       0e          0p
>                      2          0r          0e          0p          0r   =
       0e          0p
>                      3          0r          0e          0p          0r   =
       0e          0p
>                                 0           0           0           0    =
       0           0
>           1     600413          0           0
>                      0          0           0           0           0    =
       0           0
>                      1          0           0           0           0    =
       0           0
>                      2          0           0           0           0    =
       0           0
>                      3          0           0           0           0    =
       0           0
>                                 0           0           0           0    =
       0           0
>           2     600413          0           0
>                      0          0           0           0           0    =
       0           0
>                      1          0           0           0           0    =
       0           0
>                      2          0           0           0           0    =
       0           0
>                      3          0           0           0           0    =
       0           0
>                                 0           0           0           0    =
       0           0
>           3     600413          0           0
>                      0          0R          0T          0           0R   =
       0T          0
>                      1          0R          0T          0           0R   =
       0T          0
>                      2          0R          0T          0           0R   =
       0T          0
>                      3          0R          0T          0           0R   =
       0T          0
>                                 0L          0O          0Y          0N   =
       0F          0A

And I reran the scaled down zipf test again:

RFC:
Jobs: 12 (f=3D12): [r(12)][100.0%][r=3D7267MiB/s][r=3D1860k IOPS][eta 00m:0=
0s]7s]s]
mglru: (groupid=3D0, jobs=3D12): err=3D 0: pid=3D5159: Thu Dec 14 23:57:01 =
2023
  read: IOPS=3D1862k, BW=3D7274MiB/s (7628MB/s)(2131GiB/300001msec)
    slat (usec): min=3D60, max=3D4711, avg=3D195.05, stdev=3D138.41
    clat (usec): min=3D2, max=3D5097, avg=3D619.70, stdev=3D215.90
     lat (usec): min=3D112, max=3D5271, avg=3D814.78, stdev=3D237.75
    clat percentiles (usec):
     |  1.00th=3D[  388],  5.00th=3D[  408], 10.00th=3D[  424], 20.00th=3D[=
  457],
     | 30.00th=3D[  482], 40.00th=3D[  502], 50.00th=3D[  523], 60.00th=3D[=
  545],
     | 70.00th=3D[  603], 80.00th=3D[  889], 90.00th=3D[  988], 95.00th=3D[=
 1037],
     | 99.00th=3D[ 1106], 99.50th=3D[ 1139], 99.90th=3D[ 1237], 99.95th=3D[=
 1369],
     | 99.99th=3D[ 1483]
   bw (  MiB/s): min=3D 6526, max=3D 8474, per=3D100.00%, avg=3D7284.26,
stdev=3D48.62, samples=3D7176
   iops        : min=3D1670753, max=3D2169575, avg=3D1864770.39,
stdev=3D12446.01, samples=3D7176
  lat (usec)   : 4=3D0.01%, 10=3D0.01%, 250=3D0.01%, 500=3D38.35%, 750=3D33=
.88%
  lat (usec)   : 1000=3D19.46%
  lat (msec)   : 2=3D8.30%, 4=3D0.01%, 10=3D0.01%
  cpu          : usr=3D8.62%, sys=3D91.24%, ctx=3D531703, majf=3D0, minf=3D=
700
  IO depths    : 1=3D0.0%, 2=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.=
0%, >=3D64=3D100.0%
     submit    : 0=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=3D100.0%, 64=
=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=3D100.0%, 64=
=3D0.0%, >=3D64=3D0.1%
     issued rwts: total=3D558664800,0,0,0 short=3D0,0,0,0 dropped=3D0,0,0,0
     latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D128

Run status group 0 (all jobs):
   READ: bw=3D7274MiB/s (7628MB/s), 7274MiB/s-7274MiB/s
(7628MB/s-7628MB/s), io=3D2131GiB (2288GB), run=3D300001-300001msec

workingset_refault_file 628192729

memcg    73 /benchmark
 node     0
          0    1092186          0           0x
                     0          0r          0e          0p          0
         0           0=C2=B7
                     1          0r          0e          0p          0
         0           0=C2=B7
                     2          0r          0e          0p          0
         0           0=C2=B7
                     3          0r          0e          0p          0
         0           0=C2=B7
                                0           0           0           0
         0           0=C2=B7
          1    1092186          0        4283=C2=B7
                     0          0           0           0   507816078r
 511714221e          0p
                     1          0           0           0     4682206r
   3201136e          0p
                     2          0           0           0       64762r
     43587e          0p
                     3          0           0           0           0r
         0e          0p
                                0           0           0           0
         0           0=C2=B7
          2    1092186          0           0=C2=B7
                     0          0           0           0           0
         0           0=C2=B7
                     1          0           0           0           0
         0           0=C2=B7
                     2          0           0           0           0
         0           0=C2=B7
                     3          0           0           0           0
         0           0=C2=B7
                                0           0           0           0
         0           0=C2=B7
          3    1092186          0      750308=C2=B7
                     0          0R          0T          0    49689099R
  52516254T          0=C2=B7
                     1          0R          0T          0     5786054R
   5786054T          0=C2=B7
                     2          0R          0T          0     1140749R
   1140749T          0=C2=B7
                     3          0R          0T          0           0R
         0T          0=C2=B7
                                0L          0O          0Y          0N
         0F          0A

This series:
Jobs: 12 (f=3D12): [r(12)][100.0%][r=3D6447MiB/s][r=3D1650k IOPS][eta 00m:0=
0s]
mglru: (groupid=3D0, jobs=3D12): err=3D 0: pid=3D3665: Fri Dec 15 00:16:06 =
2023
  read: IOPS=3D1830k, BW=3D7148MiB/s (7495MB/s)(2094GiB/300001msec)
    slat (usec): min=3D59, max=3D35006, avg=3D198.58, stdev=3D201.99
    clat (nsec): min=3D972, max=3D37489k, avg=3D630651.61, stdev=3D384748.5=
0
     lat (usec): min=3D108, max=3D39688, avg=3D829.26, stdev=3D461.06
    clat percentiles (usec):
     |  1.00th=3D[  355],  5.00th=3D[  379], 10.00th=3D[  392], 20.00th=3D[=
  424],
     | 30.00th=3D[  478], 40.00th=3D[  510], 50.00th=3D[  529], 60.00th=3D[=
  553],
     | 70.00th=3D[  635], 80.00th=3D[  898], 90.00th=3D[ 1012], 95.00th=3D[=
 1090],
     | 99.00th=3D[ 1221], 99.50th=3D[ 1401], 99.90th=3D[ 2606], 99.95th=3D[=
 3654],
     | 99.99th=3D[18220]
   bw (  MiB/s): min=3D 4870, max=3D 9145, per=3D100.00%, avg=3D7157.39,
stdev=3D81.13, samples=3D7176
   iops        : min=3D1246811, max=3D2341342, avg=3D1832289.80,
stdev=3D20768.76, samples=3D7176
  lat (nsec)   : 1000=3D0.01%
  lat (usec)   : 4=3D0.01%, 10=3D0.01%, 250=3D0.01%, 500=3D36.53%, 750=3D36=
.20%
  lat (usec)   : 1000=3D15.90%
  lat (msec)   : 2=3D11.18%, 4=3D0.15%, 10=3D0.02%, 20=3D0.01%, 50=3D0.01%
  cpu          : usr=3D8.59%, sys=3D91.27%, ctx=3D512635, majf=3D0, minf=3D=
711
  IO depths    : 1=3D0.0%, 2=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.=
0%, >=3D64=3D100.0%
     submit    : 0=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=3D100.0%, 64=
=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=3D100.0%, 64=
=3D0.0%, >=3D64=3D0.1%
     issued rwts: total=3D548956313,0,0,0 short=3D0,0,0,0 dropped=3D0,0,0,0
     latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D128

Run status group 0 (all jobs):
   READ: bw=3D7148MiB/s (7495MB/s), 7148MiB/s-7148MiB/s
(7495MB/s-7495MB/s), io=3D2094GiB (2249GB), run=3D300001-300001msec

workingset_refault_file 596790506

memcg    68 /benchmark
 node     0
        122     160248          0           0x
                     0          0r          0e          0p          0
         0           0=C2=B7
                     1          0r          0e          0p          0
         0           0=C2=B7
                     2          0r          0e          0p          0
         0           0=C2=B7
                     3          0r          0e          0p          0
         0           0=C2=B7
                                0           0           0           0
         0           0=C2=B7
        123     155360          0      239405=C2=B7
                     0          0           0           0      301462r
   1186271e          0p
                     1          0           0           0       80013r
    218961e          0p
                     2          0           0           0           0r
         0e     516139p
                     3          0           0           0           0r
         0e          0p
                                0           0           0           0
         0           0=C2=B7
        124     150495          0      516188=C2=B7
                     0          0           0           0           0
         0           0=C2=B7
                     1          0           0           0           0
         0           0=C2=B7
                     2          0           0           0           0
         0           0=C2=B7
                     3          0           0           0           0
         0           0=C2=B7
                                0           0           0           0
         0           0=C2=B7
        125     145582          0        1345=C2=B7
                     0          0R          0T          0     2577270R
   4518284T          0=C2=B7
                     1          0R          0T          0      290933R
    369324T          0=C2=B7
                     2          0R          0T          0           0R
    752170T          0=C2=B7
                     3          0R          0T          0           0R
         0T          0=C2=B7
                           388483L      17226O      18419Y      95408N
      1314F        578A

I think the problem might be related to this series ages faster and so
have higher overhead in some case. In your test the test is large
scaled so MGLRU just keep reclaiming last gen, no aging, and my RFC
bring extra overhead due to workingset checking and memcg flushing
(the memcg flushing patch in unstable tree may help?), and also the
current refault distance checking model, simply glued to MGLRU (some
known issues, the most obvious issue is that refault distance check
can't prevent the file page underprotected issue at all when active is
low or empty, and using active/inactive is not accurate enough for
MGLRU), not performing good enough.

And for the MongoDB test, I still didn't have enough time to tidy up
the setup scripts and modified repo yet, sorry about this, in past few
days I only have time to check this issue at late night... but a quick
test shows interesting reading too:

RFC:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Execution Results after 902 seconds
------------------------------------------------------------------
                  Executed        Time (=C2=B5s)       Rate=C2=B7=C2=B7=C2=
=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7
  STOCK_LEVEL     2544            27114484261.0   0.09 txn/s=C2=B7=C2=B7=C2=
=B7=C2=B7=C2=B7=C2=B7
------------------------------------------------------------------
  TOTAL           2544            27114484261.0   0.09 txn/s=C2=B7=C2=B7=C2=
=B7=C2=B7=C2=B7=C2=B7

workingset_refault_anon 10512
workingset_refault_file 22751782

memcg    44 /system.slice/docker-1313de5323016713a0efa95d3b3f1aeafc9f43df80=
051bd013f3d29f1e13fa58.scope
 node     0
         12     190714      41736      640699=C2=B7
                     0          0r          2e          0p          0r
   1293703e          0p
                     1          0r          0e          0p          0r
         0e     463477p
                     2          0r          0e          0p          0r
         0e    5029378p
                     3          0r          0e          0p          0r
         0e          0p
                                0           0           0           0
         0           0=C2=B7
         13     139686     462351     5483828=C2=B7
                     0          0           0           0           0
         0           0=C2=B7
                     1          0           0           0           0
         0           0=C2=B7
                     2          0           0           0           0
         0           0=C2=B7
                     3          0           0           0           0
         0           0=C2=B7
                                0           0           0           0
         0           0=C2=B7
         14      86529     692892        3795=C2=B7
                     0          0           0           0           0
         0           0=C2=B7
                     1          0           0           0           0
         0           0=C2=B7
                     2          0           0           0           0
         0           0=C2=B7
                     3          0           0           0           0
         0           0=C2=B7
                                0           0           0           0
         0           0=C2=B7
         15      41548      47767         366=C2=B7
                     0         12R       1113T          0        3497R
   1857252T          0=C2=B7
                     1          0R          0T          0     1000193R
   1692818T          0=C2=B7
                     2          0R          0T          0           0R
   5422505T          0=C2=B7
                     3          0R          0T          0           0R
         0T          0=C2=B7
                          3889671L      42917O    3674613Y      11910N
      7609F       7547A

This series:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Execution Results after 904 seconds
------------------------------------------------------------------
                  Executed        Time (=C2=B5s)       Rate=C2=B7=C2=B7=C2=
=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7
  STOCK_LEVEL     1668            27108414456.6   0.06 txn/s=C2=B7=C2=B7=C2=
=B7=C2=B7=C2=B7=C2=B7
------------------------------------------------------------------
  TOTAL           1668            27108414456.6   0.06 txn/s=C2=B7=C2=B7=C2=
=B7=C2=B7=C2=B7=C2=B7

workingset_refault_anon 35277
workingset_refault_file 20335355

memcg    77 /system.slice/docker-731f3d33dca1dbea9d763a7a9519bb92c4ca1bbdb0=
6c6a23d5203f8baad97f6e.scope
 node     0
         14     218191          0x          0x
                     0          0           0           0           0
         0           0=C2=B7
                     1          0           0           0           0
         0           0=C2=B7
                     2          0           0           0           0
         0           0=C2=B7
                     3          0           0           0           0
         0           0=C2=B7
                                0           0           0           0
         0           0=C2=B7
         15     170722       1923     6172558=C2=B7
                     0          0r          0e          0p          9r
     29052e          0p
                     1          0r          0e          0p          0r
     10643e          0p
                     2          0r          0e          0p          0r
         0e       5714p
                     3          0r          0e          0p          0r
         0e          0p
                                0           0           0           0
         0           0=C2=B7
         16     127628    1223689       10249=C2=B7
                     0          0           0           0           0
         0           0=C2=B7
                     1          0           0           0           0
         0           0=C2=B7
                     2          0           0           0           0
         0           0=C2=B7
                     3          0           0           0           0
         0           0=C2=B7
                                0           0           0           0
         0           0=C2=B7
         17      79949      40444         408=C2=B7
                     0       1413R       5628T          0      352479R
   1259370T          0=C2=B7
                     1          0R          0T          0      252950R
    439843T          0=C2=B7
                     2          0R          1T          0           0R
   5083446T          0=C2=B7
                     3          0R          0T          0           0R
         0T          0=C2=B7
                         18667726L     229222O   17641112Y      40116N
     36473F      35963A

And I've turned off all unrelated features off (psi, delayacct) for
above tests. When PSI is on, the MongoDB test shows 70 - 100 PSI SOME,
it's not using a very high performance disk.
I think this could suggest some time evict of file page is not that
costly. And page shadow can store fine grained data of page's access
distance, so maybe I can tune the refault distance checking model for
MGLRU, combine with this series, which may help to improve the protect
policy to be more balanced (not too fast, and still accurate)?
