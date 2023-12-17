Return-Path: <linux-kernel+bounces-2776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CEF81619E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 19:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424281C20B63
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DA536AE8;
	Sun, 17 Dec 2023 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3jJlt+Bd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE221DFE5
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c32bea30dso53185e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 10:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702837938; x=1703442738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xi8WxnO/5ju1HSV+e8T/TEEABVPzUu+B2D1s+/TqHas=;
        b=3jJlt+Bd7d/jRLGy9LwxTN1t+ckbRwK2FRLawsiFAnfsmi7rE+2vcfoOUe973po2Zk
         gEB1YsVvEda5OAmRdEV+vNrygrHm4j6ARIf7WXbtGyviICjZKXto/OMug2Av2ZE2/lqr
         lnUWkdiVo1ucoIcPcr4meo7jiUupEksX0x8L9TSPEe1oXI7ph3UV/gRkh6n2/vlW+CKF
         gEdnndFMwpoKfzWrkjHICLIqO+ld/xqBKLXX73wwiVEXF2w9Ztq8n7KruK/ZsjtDXU8M
         I/k96H6DPCqTaYNrx/0ZmKNWdY8M7s+uost/9D3fKB0Sz/PrKi7RIs1EnzTMxOMKwZ4J
         YBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702837938; x=1703442738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xi8WxnO/5ju1HSV+e8T/TEEABVPzUu+B2D1s+/TqHas=;
        b=t0eqV52Qg1U12fdAf5+MDzuloorIkOI2p/5KBJ12kCYzipzn9cxGUX2XethpExj4AO
         e79oa9CdZ13q/c365l9UgmKa8kazvaoTk/3PbBd7M13OwBysJF+DsNPmHANZeXY9kURI
         ZdC9ggFItntynQQY8trmfFmdCDDgcuBYkj/t5tOtXEV2MrHU3ghLVwJM2jKLO42UIPkX
         sCsHztWXUYTKYGOJ3nr8SIfuAYL/D+yMrwwGvR3Ce3BcPdHeRBYKuyvHPzXiCO7x/2hr
         1nmuv+hH7G2xBOFvkSuztB308zMWLyE5IaAKKD0RslUZjsr757K5Szx3tBb98W1zmSvD
         TBDA==
X-Gm-Message-State: AOJu0YyFSJBKSFou0p4/DfHLB8ct0lt5uMM6Rc/CUqqnBVS1LIg7yXYP
	YsmymCS+2bQuT6oSasWvu/wuh95NJPxi8XddrtPVodVC91AMg3XmfvuN8bV6Z7Xa
X-Google-Smtp-Source: AGHT+IGdXOu9eyPcTs+cJBufM93L37weDLAN8z1jWXvoCUM6NrDSrdmQ2RCVAhUxS6+gFnQdcTdQA5rb3u3Bvdsop+0=
X-Received: by 2002:a05:600c:4655:b0:40d:1482:896a with SMTP id
 n21-20020a05600c465500b0040d1482896amr96929wmo.1.1702837937966; Sun, 17 Dec
 2023 10:32:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208061407.2125867-1-yuzhao@google.com> <CAMgjq7BTaV5OvHNjGRVJP2VDxj+PXhfd6957CjS4BJ9J4OY8HA@mail.gmail.com>
 <CAOUHufYwZAUaJh6i8Fazc4gVMSqcsz9JbRNpj0cpx2qR+bZBFw@mail.gmail.com>
 <CAMgjq7AtceR-CXnKFfQHM3qi0y4oGyJ4_sw_uh5EkpXCBzkCXg@mail.gmail.com>
 <CAMgjq7CJ3hYHysyRfHzYU4hOYqhUOttxMYGtg0FxzM_wvvyhFA@mail.gmail.com>
 <CAOUHufa=ybd-EPos9DryLHYyhphN0P7qyV5NY3Pui0dfVSk9tQ@mail.gmail.com>
 <ZXpx0K8Vdo3FJixg@google.com> <CAMgjq7CRf4iEKuW2qWKzbhssMbixBo3UoLPqsSk4b+Tvw8at8A@mail.gmail.com>
 <CAOUHufY6x_Erz02Bzoejfs_g2hcmrMFpiOdjiaWZ97oirz71aQ@mail.gmail.com>
In-Reply-To: <CAOUHufY6x_Erz02Bzoejfs_g2hcmrMFpiOdjiaWZ97oirz71aQ@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Sun, 17 Dec 2023 11:31:39 -0700
Message-ID: <CAOUHufatF_xUqJLeNQ5D_5zUetYHJmHiai=KmD5Ttpji4pkv0g@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 1/4] mm/mglru: fix underprotected page cache
To: Kairui Song <ryncsn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Charan Teja Kalla <quic_charante@quicinc.com>, 
	Kalesh Singh <kaleshsingh@google.com>, stable@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 4:51=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Thu, Dec 14, 2023 at 11:38=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8814=E6=97=
=A5=E5=91=A8=E5=9B=9B 11:09=E5=86=99=E9=81=93=EF=BC=9A
> > > On Wed, Dec 13, 2023 at 12:59:14AM -0700, Yu Zhao wrote:
> > > > On Tue, Dec 12, 2023 at 8:03=E2=80=AFPM Kairui Song <ryncsn@gmail.c=
om> wrote:
> > > > >
> > > > > Kairui Song <ryncsn@gmail.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=881=
2=E6=97=A5=E5=91=A8=E4=BA=8C 14:52=E5=86=99=E9=81=93=EF=BC=9A
> > > > > >
> > > > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8812=
=E6=97=A5=E5=91=A8=E4=BA=8C 06:07=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > >
> > > > > > > On Fri, Dec 8, 2023 at 1:24=E2=80=AFAM Kairui Song <ryncsn@gm=
ail.com> wrote:
> > > > > > > >
> > > > > > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=
=888=E6=97=A5=E5=91=A8=E4=BA=94 14:14=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > >
> > > > > > > > > Unmapped folios accessed through file descriptors can be
> > > > > > > > > underprotected. Those folios are added to the oldest gene=
ration based
> > > > > > > > > on:
> > > > > > > > > 1. The fact that they are less costly to reclaim (no need=
 to walk the
> > > > > > > > >    rmap and flush the TLB) and have less impact on perfor=
mance (don't
> > > > > > > > >    cause major PFs and can be non-blocking if needed agai=
n).
> > > > > > > > > 2. The observation that they are likely to be single-use.=
 E.g., for
> > > > > > > > >    client use cases like Android, its apps parse configur=
ation files
> > > > > > > > >    and store the data in heap (anon); for server use case=
s like MySQL,
> > > > > > > > >    it reads from InnoDB files and holds the cached data f=
or tables in
> > > > > > > > >    buffer pools (anon).
> > > > > > > > >
> > > > > > > > > However, the oldest generation can be very short lived, a=
nd if so, it
> > > > > > > > > doesn't provide the PID controller with enough time to re=
spond to a
> > > > > > > > > surge of refaults. (Note that the PID controller uses wei=
ghted
> > > > > > > > > refaults and those from evicted generations only take a h=
alf of the
> > > > > > > > > whole weight.) In other words, for a short lived generati=
on, the
> > > > > > > > > moving average smooths out the spike quickly.
> > > > > > > > >
> > > > > > > > > To fix the problem:
> > > > > > > > > 1. For folios that are already on LRU, if they can be bey=
ond the
> > > > > > > > >    tracking range of tiers, i.e., five accesses through f=
ile
> > > > > > > > >    descriptors, move them to the second oldest generation=
 to give them
> > > > > > > > >    more time to age. (Note that tiers are used by the PID=
 controller
> > > > > > > > >    to statistically determine whether folios accessed mul=
tiple times
> > > > > > > > >    through file descriptors are worth protecting.)
> > > > > > > > > 2. When adding unmapped folios to LRU, adjust the placeme=
nt of them so
> > > > > > > > >    that they are not too close to the tail. The effect of=
 this is
> > > > > > > > >    similar to the above.
> > > > > > > > >
> > > > > > > > > On Android, launching 55 apps sequentially:
> > > > > > > > >                            Before     After      Change
> > > > > > > > >   workingset_refault_anon  25641024   25598972   0%
> > > > > > > > >   workingset_refault_file  115016834  106178438  -8%
> > > > > > > >
> > > > > > > > Hi Yu,
> > > > > > > >
> > > > > > > > Thanks you for your amazing works on MGLRU.
> > > > > > > >
> > > > > > > > I believe this is the similar issue I was trying to resolve=
 previously:
> > > > > > > > https://lwn.net/Articles/945266/
> > > > > > > > The idea is to use refault distance to decide if the page s=
hould be
> > > > > > > > place in oldest generation or some other gen, which per my =
test,
> > > > > > > > worked very well, and we have been using refault distance f=
or MGLRU in
> > > > > > > > multiple workloads.
> > > > > > > >
> > > > > > > > There are a few issues left in my previous RFC series, like=
 anon pages
> > > > > > > > in MGLRU shouldn't be considered, I wanted to collect feedb=
ack or test
> > > > > > > > cases, but unfortunately it seems didn't get too much atten=
tion
> > > > > > > > upstream.
> > > > > > > >
> > > > > > > > I think both this patch and my previous series are for solv=
ing the
> > > > > > > > file pages underpertected issue, and I did a quick test usi=
ng this
> > > > > > > > series, for mongodb test, refault distance seems still a be=
tter
> > > > > > > > solution (I'm not saying these two optimization are mutuall=
y exclusive
> > > > > > > > though, just they do have some conflicts in implementation =
and solving
> > > > > > > > similar problem):
> > > > > > > >
> > > > > > > > Previous result:
> > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > Execution Results after 905 seconds
> > > > > > > > -----------------------------------------------------------=
-------
> > > > > > > >                   Executed        Time (=C2=B5s)       Rate
> > > > > > > >   STOCK_LEVEL     2542            27121571486.2   0.09 txn/=
s
> > > > > > > > -----------------------------------------------------------=
-------
> > > > > > > >   TOTAL           2542            27121571486.2   0.09 txn/=
s
> > > > > > > >
> > > > > > > > This patch:
> > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > Execution Results after 900 seconds
> > > > > > > > -----------------------------------------------------------=
-------
> > > > > > > >                   Executed        Time (=C2=B5s)       Rate
> > > > > > > >   STOCK_LEVEL     1594            27061522574.4   0.06 txn/=
s
> > > > > > > > -----------------------------------------------------------=
-------
> > > > > > > >   TOTAL           1594            27061522574.4   0.06 txn/=
s
> > > > > > > >
> > > > > > > > Unpatched version is always around ~500.
> > > > > > >
> > > > > > > Thanks for the test results!
> > > > > > >
> > > > > > > > I think there are a few points here:
> > > > > > > > - Refault distance make use of page shadow so it can better
> > > > > > > > distinguish evicted pages of different access pattern (re-a=
ccess
> > > > > > > > distance).
> > > > > > > > - Throttled refault distance can help hold part of workings=
et when
> > > > > > > > memory is too small to hold the whole workingset.
> > > > > > > >
> > > > > > > > So maybe part of this patch and the bits of previous series=
 can be
> > > > > > > > combined to work better on this issue, how do you think?
> > > > > > >
> > > > > > > I'll try to find some time this week to look at your RFC. It'=
d be a
> > > > >
> > > > > Hi Yu,
> > > > >
> > > > > I'm working on V4 of the RFC now, which just update some comments=
, and
> > > > > skip anon page re-activation in refault path for mglru which was =
not
> > > > > very helpful, only some tiny adjustment.
> > > > > And I found it easier to test with fio, using following test scri=
pt:
> > > > >
> > > > > #!/bin/bash
> > > > > swapoff -a
> > > > >
> > > > > modprobe brd rd_nr=3D1 rd_size=3D16777216
> > > > > mkfs.ext4 /dev/ram0
> > > > > mount /dev/ram0 /mnt
> > > > >
> > > > > mkdir -p /sys/fs/cgroup/benchmark
> > > > > cd /sys/fs/cgroup/benchmark
> > > > >
> > > > > echo 4G > memory.max
> > > > > echo $$ > cgroup.procs
> > > > > echo 3 > /proc/sys/vm/drop_caches
> > > > >
> > > > > fio -name=3Dmglru --numjobs=3D12 --directory=3D/mnt --size=3D1024=
m \
> > > > >           --buffered=3D1 --ioengine=3Dio_uring --iodepth=3D128 \
> > > > >           --iodepth_batch_submit=3D32 --iodepth_batch_complete=3D=
32 \
> > > > >           --rw=3Drandread --random_distribution=3Dzipf:0.5 --nora=
ndommap \
> > > > >           --time_based --ramp_time=3D5m --runtime=3D5m --group_re=
porting
> > > > >
> > > > > zipf:0.5 is used here to simulate a cached read with slight bias
> > > > > towards certain pages.
> > > > > Unpatched 6.7-rc4:
> > > > > Run status group 0 (all jobs):
> > > > >    READ: bw=3D6548MiB/s (6866MB/s), 6548MiB/s-6548MiB/s
> > > > > (6866MB/s-6866MB/s), io=3D1918GiB (2060GB), run=3D300001-300001ms=
ec
> > > > >
> > > > > Patched with RFC v4:
> > > > > Run status group 0 (all jobs):
> > > > >    READ: bw=3D7270MiB/s (7623MB/s), 7270MiB/s-7270MiB/s
> > > > > (7623MB/s-7623MB/s), io=3D2130GiB (2287GB), run=3D300001-300001ms=
ec
> > > > >
> > > > > Patched with this series:
> > > > > Run status group 0 (all jobs):
> > > > >    READ: bw=3D7098MiB/s (7442MB/s), 7098MiB/s-7098MiB/s
> > > > > (7442MB/s-7442MB/s), io=3D2079GiB (2233GB), run=3D300002-300002ms=
ec
> > > > >
> > > > > MGLRU off:
> > > > > Run status group 0 (all jobs):
> > > > >    READ: bw=3D6525MiB/s (6842MB/s), 6525MiB/s-6525MiB/s
> > > > > (6842MB/s-6842MB/s), io=3D1912GiB (2052GB), run=3D300002-300002ms=
ec
> > > > >
> > > > > - If I change zipf:0.5 to random:
> > > > > Unpatched 6.7-rc4:
> > > > > Patched with this series:
> > > > > Run status group 0 (all jobs):
> > > > >    READ: bw=3D5975MiB/s (6265MB/s), 5975MiB/s-5975MiB/s
> > > > > (6265MB/s-6265MB/s), io=3D1750GiB (1879GB), run=3D300002-300002ms=
ec
> > > > >
> > > > > Patched with RFC v4:
> > > > > Run status group 0 (all jobs):
> > > > >    READ: bw=3D5987MiB/s (6278MB/s), 5987MiB/s-5987MiB/s
> > > > > (6278MB/s-6278MB/s), io=3D1754GiB (1883GB), run=3D300001-300001ms=
ec
> > > > >
> > > > > Patched with this series:
> > > > > Run status group 0 (all jobs):
> > > > >    READ: bw=3D5839MiB/s (6123MB/s), 5839MiB/s-5839MiB/s
> > > > > (6123MB/s-6123MB/s), io=3D1711GiB (1837GB), run=3D300001-300001ms=
ec
> > > > >
> > > > > MGLRU off:
> > > > > Run status group 0 (all jobs):
> > > > >    READ: bw=3D5689MiB/s (5965MB/s), 5689MiB/s-5689MiB/s
> > > > > (5965MB/s-5965MB/s), io=3D1667GiB (1790GB), run=3D300003-300003ms=
ec
> > > > >
> > > > > fio uses ramdisk so LRU accuracy will have smaller impact. The Mo=
ngodb
> > > > > test I provided before uses a SATA SSD so it will have a much hig=
her
> > > > > impact. I'll provides a script to setup the test case and run it,=
 it's
> > > > > more complex to setup than fio since involving setting up multipl=
e
> > > > > replicas and auth and hundreds of GB of test fixtures, I'm curren=
tly
> > > > > occupied by some other tasks but will try best to send them out a=
s
> > > > > soon as possible.
> > > >
> > > > Thanks! Apparently your RFC did show better IOPS with both access
> > > > patterns, which was a surprise to me because it had higher refaults
> > > > and usually higher refautls result in worse performance.
> > > >
> > > > So I'm still trying to figure out why it turned out the opposite. M=
y
> > > > current guess is that:
> > > > 1. It had a very small but stable inactive LRU list, which was able=
 to
> > > > fit into the L3 cache entirely.
> > > > 2. It counted few folios as workingset and therefore incurred less
> > > > overhead from CONFIG_PSI and/or CONFIG_TASK_DELAY_ACCT.
> > > >
> > > > Did you save workingset_refault_file when you ran the test? If so, =
can
> > > > you check the difference between this series and your RFC?
> > >
> > >
> > > It seems I was right about #1 above. After I scaled your test up by 2=
0x,
> > > I saw my series performed ~5% faster with zipf and ~9% faster with ra=
ndom
> > > accesses.
> >
> > Hi Yu,
> >
> > Thank you so much for testing and sharing this result.
> >
> > I'm not sure about #1, the ramdisk size, access data, are far larger
> > than L3 (16M on my CPU) even in down scaled test, and both random/zipf
> > shows similar result.
>
> It's the LRU list not pages. IOW, the kernel data structure, not the
> content in LRU pages. Does it make sense?

FYI. Willy just reminded me that he explained it a lot better than I
did: https://lore.kernel.org/linux-mm/ZTc7SHQ4RbPkD3eZ@casper.infradead.org=
/

> > > IOW, I made rd_size from 16GB to 320GB, memory.max from 4GB to 80GB,
> > > --numjobs from 12 to 60 and --size from 1GB to 4GB.
>
> Would you be able to try a larger configuration like above instead?

