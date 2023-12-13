Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3CE810887
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 04:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378378AbjLMDDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 22:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjLMDDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 22:03:07 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205FDB2;
        Tue, 12 Dec 2023 19:03:13 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c9f8faf57bso82543441fa.3;
        Tue, 12 Dec 2023 19:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702436591; x=1703041391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmdVgMNTGQhlO8xslqjDOun90RL8Cnjj+IZGL+fIg18=;
        b=PLPXoMn7p/vfRzoAEGgmJFhKyFN//RHHGsmHXw3pcpo0GwGIm+VB16bMNa6QSGxQWH
         /udgjgsX9GBStrdQr30Nqf7PthH4y7F6RcvMYI7bLtZxfxlQtolAVC3FCKshfeAn85Fu
         Dhqra1GXE5y3y4QUdL6HGJ763+qIu6y3dHXnDww5thkQ0XyAi/J6+mXm3bbrV57k1m1E
         W/rj0VvqLgl0Zhi2k28stBAj/BigZw9ei4LP2UiWZA8vUf65luvl2NkGO6f845l0SpK+
         D0Uuh0trxbDcLpzklzfn6Ev+IAJyOuHowMHZJl+iAppafdiRncstJ0MP38M6qf6RVNnV
         L2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702436591; x=1703041391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmdVgMNTGQhlO8xslqjDOun90RL8Cnjj+IZGL+fIg18=;
        b=UC0d2b4q5LFPY+0WonSd69gJTiK7RBwLa1vkMUkdS1M/dl4d2Lvywf685kyVdG6qRR
         k6DyPmCoeXaFS4IkdhE8BG/BbF/uFDRAcXPpPrDkE+x1Jw3DbGg2/Tn8VQuV4G0T9tT7
         uAqWwCP4wAoWwK2m+a1lh9zCRRHgJdemEg7QiFkw8girStOkvAzVyK1BQ15XDHQmtLJ/
         HwnbI0p4wovyCjQwIGxCZEQSgQEgqZlhXCD6TlsSCgKsuBxNR2g7RVW/SMhI/iwGMf2G
         K/oV76B9n7BXo381AcI+/yYBig8kuqOnWn2mJVSiu6+fkDvqgUgCzGJgnKFkb/viKR8K
         U02Q==
X-Gm-Message-State: AOJu0YywQFREsTL9Y7BqYNXROcCPpP9ZQwTvy5ItGUbIaw1BuA1LzZgp
        B6TYFcWE3NsbANDZmzGy4bxjNrsiXNAEWAXJgBU=
X-Google-Smtp-Source: AGHT+IEGHNPRMT1y4DbpNigFLxiTDz6QwrOyHzSEklbz1RugyR56UDijbMNGVrIcXyVVOmf/+R7EXkXBZtUAvRLFNrs=
X-Received: by 2002:a05:651c:894:b0:2cc:321d:8654 with SMTP id
 d20-20020a05651c089400b002cc321d8654mr917030ljq.8.1702436590921; Tue, 12 Dec
 2023 19:03:10 -0800 (PST)
MIME-Version: 1.0
References: <20231208061407.2125867-1-yuzhao@google.com> <CAMgjq7BTaV5OvHNjGRVJP2VDxj+PXhfd6957CjS4BJ9J4OY8HA@mail.gmail.com>
 <CAOUHufYwZAUaJh6i8Fazc4gVMSqcsz9JbRNpj0cpx2qR+bZBFw@mail.gmail.com> <CAMgjq7AtceR-CXnKFfQHM3qi0y4oGyJ4_sw_uh5EkpXCBzkCXg@mail.gmail.com>
In-Reply-To: <CAMgjq7AtceR-CXnKFfQHM3qi0y4oGyJ4_sw_uh5EkpXCBzkCXg@mail.gmail.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Wed, 13 Dec 2023 11:02:53 +0800
Message-ID: <CAMgjq7CJ3hYHysyRfHzYU4hOYqhUOttxMYGtg0FxzM_wvvyhFA@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kairui Song <ryncsn@gmail.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8812=E6=97=A5=
=E5=91=A8=E4=BA=8C 14:52=E5=86=99=E9=81=93=EF=BC=9A
>
> Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8812=E6=97=A5=
=E5=91=A8=E4=BA=8C 06:07=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Fri, Dec 8, 2023 at 1:24=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> > >
> > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=888=E6=97=
=A5=E5=91=A8=E4=BA=94 14:14=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > Unmapped folios accessed through file descriptors can be
> > > > underprotected. Those folios are added to the oldest generation bas=
ed
> > > > on:
> > > > 1. The fact that they are less costly to reclaim (no need to walk t=
he
> > > >    rmap and flush the TLB) and have less impact on performance (don=
't
> > > >    cause major PFs and can be non-blocking if needed again).
> > > > 2. The observation that they are likely to be single-use. E.g., for
> > > >    client use cases like Android, its apps parse configuration file=
s
> > > >    and store the data in heap (anon); for server use cases like MyS=
QL,
> > > >    it reads from InnoDB files and holds the cached data for tables =
in
> > > >    buffer pools (anon).
> > > >
> > > > However, the oldest generation can be very short lived, and if so, =
it
> > > > doesn't provide the PID controller with enough time to respond to a
> > > > surge of refaults. (Note that the PID controller uses weighted
> > > > refaults and those from evicted generations only take a half of the
> > > > whole weight.) In other words, for a short lived generation, the
> > > > moving average smooths out the spike quickly.
> > > >
> > > > To fix the problem:
> > > > 1. For folios that are already on LRU, if they can be beyond the
> > > >    tracking range of tiers, i.e., five accesses through file
> > > >    descriptors, move them to the second oldest generation to give t=
hem
> > > >    more time to age. (Note that tiers are used by the PID controlle=
r
> > > >    to statistically determine whether folios accessed multiple time=
s
> > > >    through file descriptors are worth protecting.)
> > > > 2. When adding unmapped folios to LRU, adjust the placement of them=
 so
> > > >    that they are not too close to the tail. The effect of this is
> > > >    similar to the above.
> > > >
> > > > On Android, launching 55 apps sequentially:
> > > >                            Before     After      Change
> > > >   workingset_refault_anon  25641024   25598972   0%
> > > >   workingset_refault_file  115016834  106178438  -8%
> > >
> > > Hi Yu,
> > >
> > > Thanks you for your amazing works on MGLRU.
> > >
> > > I believe this is the similar issue I was trying to resolve previousl=
y:
> > > https://lwn.net/Articles/945266/
> > > The idea is to use refault distance to decide if the page should be
> > > place in oldest generation or some other gen, which per my test,
> > > worked very well, and we have been using refault distance for MGLRU i=
n
> > > multiple workloads.
> > >
> > > There are a few issues left in my previous RFC series, like anon page=
s
> > > in MGLRU shouldn't be considered, I wanted to collect feedback or tes=
t
> > > cases, but unfortunately it seems didn't get too much attention
> > > upstream.
> > >
> > > I think both this patch and my previous series are for solving the
> > > file pages underpertected issue, and I did a quick test using this
> > > series, for mongodb test, refault distance seems still a better
> > > solution (I'm not saying these two optimization are mutually exclusiv=
e
> > > though, just they do have some conflicts in implementation and solvin=
g
> > > similar problem):
> > >
> > > Previous result:
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > Execution Results after 905 seconds
> > > ------------------------------------------------------------------
> > >                   Executed        Time (=C2=B5s)       Rate
> > >   STOCK_LEVEL     2542            27121571486.2   0.09 txn/s
> > > ------------------------------------------------------------------
> > >   TOTAL           2542            27121571486.2   0.09 txn/s
> > >
> > > This patch:
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > Execution Results after 900 seconds
> > > ------------------------------------------------------------------
> > >                   Executed        Time (=C2=B5s)       Rate
> > >   STOCK_LEVEL     1594            27061522574.4   0.06 txn/s
> > > ------------------------------------------------------------------
> > >   TOTAL           1594            27061522574.4   0.06 txn/s
> > >
> > > Unpatched version is always around ~500.
> >
> > Thanks for the test results!
> >
> > > I think there are a few points here:
> > > - Refault distance make use of page shadow so it can better
> > > distinguish evicted pages of different access pattern (re-access
> > > distance).
> > > - Throttled refault distance can help hold part of workingset when
> > > memory is too small to hold the whole workingset.
> > >
> > > So maybe part of this patch and the bits of previous series can be
> > > combined to work better on this issue, how do you think?
> >
> > I'll try to find some time this week to look at your RFC. It'd be a

Hi Yu,

I'm working on V4 of the RFC now, which just update some comments, and
skip anon page re-activation in refault path for mglru which was not
very helpful, only some tiny adjustment.
And I found it easier to test with fio, using following test script:

#!/bin/bash
swapoff -a

modprobe brd rd_nr=3D1 rd_size=3D16777216
mkfs.ext4 /dev/ram0
mount /dev/ram0 /mnt

mkdir -p /sys/fs/cgroup/benchmark
cd /sys/fs/cgroup/benchmark

echo 4G > memory.max
echo $$ > cgroup.procs
echo 3 > /proc/sys/vm/drop_caches

fio -name=3Dmglru --numjobs=3D12 --directory=3D/mnt --size=3D1024m \
          --buffered=3D1 --ioengine=3Dio_uring --iodepth=3D128 \
          --iodepth_batch_submit=3D32 --iodepth_batch_complete=3D32 \
          --rw=3Drandread --random_distribution=3Dzipf:0.5 --norandommap \
          --time_based --ramp_time=3D5m --runtime=3D5m --group_reporting

zipf:0.5 is used here to simulate a cached read with slight bias
towards certain pages.
Unpatched 6.7-rc4:
Run status group 0 (all jobs):
   READ: bw=3D6548MiB/s (6866MB/s), 6548MiB/s-6548MiB/s
(6866MB/s-6866MB/s), io=3D1918GiB (2060GB), run=3D300001-300001msec

Patched with RFC v4:
Run status group 0 (all jobs):
   READ: bw=3D7270MiB/s (7623MB/s), 7270MiB/s-7270MiB/s
(7623MB/s-7623MB/s), io=3D2130GiB (2287GB), run=3D300001-300001msec

Patched with this series:
Run status group 0 (all jobs):
   READ: bw=3D7098MiB/s (7442MB/s), 7098MiB/s-7098MiB/s
(7442MB/s-7442MB/s), io=3D2079GiB (2233GB), run=3D300002-300002msec

MGLRU off:
Run status group 0 (all jobs):
   READ: bw=3D6525MiB/s (6842MB/s), 6525MiB/s-6525MiB/s
(6842MB/s-6842MB/s), io=3D1912GiB (2052GB), run=3D300002-300002msec

- If I change zipf:0.5 to random:
Unpatched 6.7-rc4:
Patched with this series:
Run status group 0 (all jobs):
   READ: bw=3D5975MiB/s (6265MB/s), 5975MiB/s-5975MiB/s
(6265MB/s-6265MB/s), io=3D1750GiB (1879GB), run=3D300002-300002msec

Patched with RFC v4:
Run status group 0 (all jobs):
   READ: bw=3D5987MiB/s (6278MB/s), 5987MiB/s-5987MiB/s
(6278MB/s-6278MB/s), io=3D1754GiB (1883GB), run=3D300001-300001msec

Patched with this series:
Run status group 0 (all jobs):
   READ: bw=3D5839MiB/s (6123MB/s), 5839MiB/s-5839MiB/s
(6123MB/s-6123MB/s), io=3D1711GiB (1837GB), run=3D300001-300001msec

MGLRU off:
Run status group 0 (all jobs):
   READ: bw=3D5689MiB/s (5965MB/s), 5689MiB/s-5689MiB/s
(5965MB/s-5965MB/s), io=3D1667GiB (1790GB), run=3D300003-300003msec

fio uses ramdisk so LRU accuracy will have smaller impact. The Mongodb
test I provided before uses a SATA SSD so it will have a much higher
impact. I'll provides a script to setup the test case and run it, it's
more complex to setup than fio since involving setting up multiple
replicas and auth and hundreds of GB of test fixtures, I'm currently
occupied by some other tasks but will try best to send them out as
soon as possible.
