Return-Path: <linux-kernel+bounces-6554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24E1819A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC0E285DB9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CE91EB5D;
	Wed, 20 Dec 2023 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wF2rzoCU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506521EA74
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso3051a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703060248; x=1703665048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vOAyyVEVpa8qMFppzgoViL2yb2XDpzbKQHbzqyHCMU=;
        b=wF2rzoCUZlwec3XUfzEYbCUOeabbMheH+3t4cSNNsh4JLoqz9q7hvbDdshDtyrubJd
         hpcvcOhxp56ZJOlIslMVtIwP1PrRO31kxTZS0QiA7k2jENKpS60IQdA9NXabjrng+YrQ
         /fGLucrxh5Si1GspVaUf7jAV3zHgQU4uRLSfw3JPqAP/AoZ38J56SLqYnu9SQlyFDT7B
         JDQRtKPVWkk1tepFlmlQzEnFPgyxJ2wy1tfBhBEpuNSkr8x4cwlBEK9fk3LHqFeoILfO
         JIPVaXkwkoMw5EsLLv+cGbvWYzbWRhZTA/kFhsu9BiRgeYn8pHRxyxTdOnUJOzdI2M+k
         yK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703060248; x=1703665048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vOAyyVEVpa8qMFppzgoViL2yb2XDpzbKQHbzqyHCMU=;
        b=lUSpRD/5b/BI8o/09z/3s49pdYJCxMr247OF1I4rXJbKNZzksrnDPiXcJb+i3EDSIG
         hg5SZyCOTcE6D+1sPTZwb3qoWdOOVn24pkP/z5DlQkORbnlXES2QDJifBOzd0akeT+LP
         n++6lLMv7Oqo8ttqQI+fIjjfuy5LuBUUYiUKm4TE7EwJJLDnL+xfYn9ttao4xDpPsmDH
         GflfYpmslO7WRGsrHChrr6qHzp/P7xF9zcoGTrjOHyFzUhc4M9li0nhPXEBaY4kOoKSU
         IKYgl6QVPU9JLF/qAUcK+3Z/9F5IC1wEv6mubsJoSk+gWWXqKo6vx9b2CElE12lb43Kg
         x3zg==
X-Gm-Message-State: AOJu0Yx3SRfmEAxZFHr2CVMXCAB21aKGufs2q2KnPl9KkEVePFSCxUj0
	5MElJXxpyfKL9V+cguj/9MjZ7fg1Fi2yrv/2XTYZahiN/lBK
X-Google-Smtp-Source: AGHT+IGKtdFQzbgDzPUbfX03yfqoakmjSeUDS0e/kJKOd2KPA5FZY3iY/jtu2tiazin6/FpacDPtzjhrDYu7A7VxFAA=
X-Received: by 2002:a05:6402:3106:b0:553:ee95:2b4f with SMTP id
 dc6-20020a056402310600b00553ee952b4fmr22213edb.3.1703060248223; Wed, 20 Dec
 2023 00:17:28 -0800 (PST)
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
 <ZXvcgyjTu92Qqk5X@google.com> <CAMgjq7BsY1tJeOZwSppxUN7Lha-_a7WLfhv1_bxTuU4EuiQyVg@mail.gmail.com>
 <CAOUHufZFkdDjCdQKBV5+W_bp_7x5VwrwkYbJeDdQ19S=m4Mc6A@mail.gmail.com>
 <CAOUHufbRq8WsGzNRn119GqL5AmeSOkZxQv3L2LTaCm=k3bzrRA@mail.gmail.com>
 <CAMgjq7C8uUOz5i8rEHNCs37fdEiAuMZsuV+Ktnz3TMX9Nf8F+g@mail.gmail.com> <CAOUHufamzdOL8ByV9V7KQJKnvZBMboVz-EGD=Fus7LZk1inhCw@mail.gmail.com>
In-Reply-To: <CAOUHufamzdOL8ByV9V7KQJKnvZBMboVz-EGD=Fus7LZk1inhCw@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 20 Dec 2023 01:16:50 -0700
Message-ID: <CAOUHufaWkAvQK_fmXF5WZW4ZKQ0W4UZfjWDG+OZAxgF_J0dOuA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 1/4] mm/mglru: fix underprotected page cache
To: Kairui Song <ryncsn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Charan Teja Kalla <quic_charante@quicinc.com>, 
	Kalesh Singh <kaleshsingh@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 11:38=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Tue, Dec 19, 2023 at 11:58=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8819=E6=97=
=A5=E5=91=A8=E4=BA=8C 11:45=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Mon, Dec 18, 2023 at 8:21=E2=80=AFPM Yu Zhao <yuzhao@google.com> w=
rote:
> > > >
> > > > On Mon, Dec 18, 2023 at 11:05=E2=80=AFAM Kairui Song <ryncsn@gmail.=
com> wrote:
> > > > >
> > > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8815=
=E6=97=A5=E5=91=A8=E4=BA=94 12:56=E5=86=99=E9=81=93=EF=BC=9A
> > > > > >
> > > > > > On Thu, Dec 14, 2023 at 04:51:00PM -0700, Yu Zhao wrote:
> > > > > > > On Thu, Dec 14, 2023 at 11:38=E2=80=AFAM Kairui Song <ryncsn@=
gmail.com> wrote:
> > > > > > > >
> > > > > > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=
=8814=E6=97=A5=E5=91=A8=E5=9B=9B 11:09=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > > On Wed, Dec 13, 2023 at 12:59:14AM -0700, Yu Zhao wrote:
> > > > > > > > > > On Tue, Dec 12, 2023 at 8:03=E2=80=AFPM Kairui Song <ry=
ncsn@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Kairui Song <ryncsn@gmail.com> =E4=BA=8E2023=E5=B9=B4=
12=E6=9C=8812=E6=97=A5=E5=91=A8=E4=BA=8C 14:52=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > > > > >
> > > > > > > > > > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B41=
2=E6=9C=8812=E6=97=A5=E5=91=A8=E4=BA=8C 06:07=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, Dec 8, 2023 at 1:24=E2=80=AFAM Kairui Son=
g <ryncsn@gmail.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=
=B412=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=94 14:14=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Unmapped folios accessed through file descrip=
tors can be
> > > > > > > > > > > > > > > underprotected. Those folios are added to the=
 oldest generation based
> > > > > > > > > > > > > > > on:
> > > > > > > > > > > > > > > 1. The fact that they are less costly to recl=
aim (no need to walk the
> > > > > > > > > > > > > > >    rmap and flush the TLB) and have less impa=
ct on performance (don't
> > > > > > > > > > > > > > >    cause major PFs and can be non-blocking if=
 needed again).
> > > > > > > > > > > > > > > 2. The observation that they are likely to be=
 single-use. E.g., for
> > > > > > > > > > > > > > >    client use cases like Android, its apps pa=
rse configuration files
> > > > > > > > > > > > > > >    and store the data in heap (anon); for ser=
ver use cases like MySQL,
> > > > > > > > > > > > > > >    it reads from InnoDB files and holds the c=
ached data for tables in
> > > > > > > > > > > > > > >    buffer pools (anon).
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > However, the oldest generation can be very sh=
ort lived, and if so, it
> > > > > > > > > > > > > > > doesn't provide the PID controller with enoug=
h time to respond to a
> > > > > > > > > > > > > > > surge of refaults. (Note that the PID control=
ler uses weighted
> > > > > > > > > > > > > > > refaults and those from evicted generations o=
nly take a half of the
> > > > > > > > > > > > > > > whole weight.) In other words, for a short li=
ved generation, the
> > > > > > > > > > > > > > > moving average smooths out the spike quickly.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > To fix the problem:
> > > > > > > > > > > > > > > 1. For folios that are already on LRU, if the=
y can be beyond the
> > > > > > > > > > > > > > >    tracking range of tiers, i.e., five access=
es through file
> > > > > > > > > > > > > > >    descriptors, move them to the second oldes=
t generation to give them
> > > > > > > > > > > > > > >    more time to age. (Note that tiers are use=
d by the PID controller
> > > > > > > > > > > > > > >    to statistically determine whether folios =
accessed multiple times
> > > > > > > > > > > > > > >    through file descriptors are worth protect=
ing.)
> > > > > > > > > > > > > > > 2. When adding unmapped folios to LRU, adjust=
 the placement of them so
> > > > > > > > > > > > > > >    that they are not too close to the tail. T=
he effect of this is
> > > > > > > > > > > > > > >    similar to the above.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Android, launching 55 apps sequentially:
> > > > > > > > > > > > > > >                            Before     After  =
    Change
> > > > > > > > > > > > > > >   workingset_refault_anon  25641024   2559897=
2   0%
> > > > > > > > > > > > > > >   workingset_refault_file  115016834  1061784=
38  -8%
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Hi Yu,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Thanks you for your amazing works on MGLRU.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I believe this is the similar issue I was tryin=
g to resolve previously:
> > > > > > > > > > > > > > https://lwn.net/Articles/945266/
> > > > > > > > > > > > > > The idea is to use refault distance to decide i=
f the page should be
> > > > > > > > > > > > > > place in oldest generation or some other gen, w=
hich per my test,
> > > > > > > > > > > > > > worked very well, and we have been using refaul=
t distance for MGLRU in
> > > > > > > > > > > > > > multiple workloads.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > There are a few issues left in my previous RFC =
series, like anon pages
> > > > > > > > > > > > > > in MGLRU shouldn't be considered, I wanted to c=
ollect feedback or test
> > > > > > > > > > > > > > cases, but unfortunately it seems didn't get to=
o much attention
> > > > > > > > > > > > > > upstream.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I think both this patch and my previous series =
are for solving the
> > > > > > > > > > > > > > file pages underpertected issue, and I did a qu=
ick test using this
> > > > > > > > > > > > > > series, for mongodb test, refault distance seem=
s still a better
> > > > > > > > > > > > > > solution (I'm not saying these two optimization=
 are mutually exclusive
> > > > > > > > > > > > > > though, just they do have some conflicts in imp=
lementation and solving
> > > > > > > > > > > > > > similar problem):
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Previous result:
> > > > > > > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > > > > > > > > > > > > Execution Results after 905 seconds
> > > > > > > > > > > > > > -----------------------------------------------=
-------------------
> > > > > > > > > > > > > >                   Executed        Time (=C2=B5s=
)       Rate
> > > > > > > > > > > > > >   STOCK_LEVEL     2542            27121571486.2=
   0.09 txn/s
> > > > > > > > > > > > > > -----------------------------------------------=
-------------------
> > > > > > > > > > > > > >   TOTAL           2542            27121571486.2=
   0.09 txn/s
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > This patch:
> > > > > > > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > > > > > > > > > > > > Execution Results after 900 seconds
> > > > > > > > > > > > > > -----------------------------------------------=
-------------------
> > > > > > > > > > > > > >                   Executed        Time (=C2=B5s=
)       Rate
> > > > > > > > > > > > > >   STOCK_LEVEL     1594            27061522574.4=
   0.06 txn/s
> > > > > > > > > > > > > > -----------------------------------------------=
-------------------
> > > > > > > > > > > > > >   TOTAL           1594            27061522574.4=
   0.06 txn/s
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Unpatched version is always around ~500.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Thanks for the test results!
> > > > > > > > > > > > >
> > > > > > > > > > > > > > I think there are a few points here:
> > > > > > > > > > > > > > - Refault distance make use of page shadow so i=
t can better
> > > > > > > > > > > > > > distinguish evicted pages of different access p=
attern (re-access
> > > > > > > > > > > > > > distance).
> > > > > > > > > > > > > > - Throttled refault distance can help hold part=
 of workingset when
> > > > > > > > > > > > > > memory is too small to hold the whole workingse=
t.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > So maybe part of this patch and the bits of pre=
vious series can be
> > > > > > > > > > > > > > combined to work better on this issue, how do y=
ou think?
> > > > > > > > > > > > >
> > > > > > > > > > > > > I'll try to find some time this week to look at y=
our RFC. It'd be a
> > > > > > > > > > >
> > > > > > > > > > > Hi Yu,
> > > > > > > > > > >
> > > > > > > > > > > I'm working on V4 of the RFC now, which just update s=
ome comments, and
> > > > > > > > > > > skip anon page re-activation in refault path for mglr=
u which was not
> > > > > > > > > > > very helpful, only some tiny adjustment.
> > > > > > > > > > > And I found it easier to test with fio, using followi=
ng test script:
> > > > > > > > > > >
> > > > > > > > > > > #!/bin/bash
> > > > > > > > > > > swapoff -a
> > > > > > > > > > >
> > > > > > > > > > > modprobe brd rd_nr=3D1 rd_size=3D16777216
> > > > > > > > > > > mkfs.ext4 /dev/ram0
> > > > > > > > > > > mount /dev/ram0 /mnt
> > > > > > > > > > >
> > > > > > > > > > > mkdir -p /sys/fs/cgroup/benchmark
> > > > > > > > > > > cd /sys/fs/cgroup/benchmark
> > > > > > > > > > >
> > > > > > > > > > > echo 4G > memory.max
> > > > > > > > > > > echo $$ > cgroup.procs
> > > > > > > > > > > echo 3 > /proc/sys/vm/drop_caches
> > > > > > > > > > >
> > > > > > > > > > > fio -name=3Dmglru --numjobs=3D12 --directory=3D/mnt -=
-size=3D1024m \
> > > > > > > > > > >           --buffered=3D1 --ioengine=3Dio_uring --iode=
pth=3D128 \
> > > > > > > > > > >           --iodepth_batch_submit=3D32 --iodepth_batch=
_complete=3D32 \
> > > > > > > > > > >           --rw=3Drandread --random_distribution=3Dzip=
f:0.5 --norandommap \
> > > > > > > > > > >           --time_based --ramp_time=3D5m --runtime=3D5=
m --group_reporting
> > > > > > > > > > >
> > > > > > > > > > > zipf:0.5 is used here to simulate a cached read with =
slight bias
> > > > > > > > > > > towards certain pages.
> > > > > > > > > > > Unpatched 6.7-rc4:
> > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > >    READ: bw=3D6548MiB/s (6866MB/s), 6548MiB/s-6548MiB=
/s
> > > > > > > > > > > (6866MB/s-6866MB/s), io=3D1918GiB (2060GB), run=3D300=
001-300001msec
> > > > > > > > > > >
> > > > > > > > > > > Patched with RFC v4:
> > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > >    READ: bw=3D7270MiB/s (7623MB/s), 7270MiB/s-7270MiB=
/s
> > > > > > > > > > > (7623MB/s-7623MB/s), io=3D2130GiB (2287GB), run=3D300=
001-300001msec
> > > > > > > > > > >
> > > > > > > > > > > Patched with this series:
> > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > >    READ: bw=3D7098MiB/s (7442MB/s), 7098MiB/s-7098MiB=
/s
> > > > > > > > > > > (7442MB/s-7442MB/s), io=3D2079GiB (2233GB), run=3D300=
002-300002msec
> > > > > > > > > > >
> > > > > > > > > > > MGLRU off:
> > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > >    READ: bw=3D6525MiB/s (6842MB/s), 6525MiB/s-6525MiB=
/s
> > > > > > > > > > > (6842MB/s-6842MB/s), io=3D1912GiB (2052GB), run=3D300=
002-300002msec
> > > > > > > > > > >
> > > > > > > > > > > - If I change zipf:0.5 to random:
> > > > > > > > > > > Unpatched 6.7-rc4:
> > > > > > > > > > > Patched with this series:
> > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > >    READ: bw=3D5975MiB/s (6265MB/s), 5975MiB/s-5975MiB=
/s
> > > > > > > > > > > (6265MB/s-6265MB/s), io=3D1750GiB (1879GB), run=3D300=
002-300002msec
> > > > > > > > > > >
> > > > > > > > > > > Patched with RFC v4:
> > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > >    READ: bw=3D5987MiB/s (6278MB/s), 5987MiB/s-5987MiB=
/s
> > > > > > > > > > > (6278MB/s-6278MB/s), io=3D1754GiB (1883GB), run=3D300=
001-300001msec
> > > > > > > > > > >
> > > > > > > > > > > Patched with this series:
> > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > >    READ: bw=3D5839MiB/s (6123MB/s), 5839MiB/s-5839MiB=
/s
> > > > > > > > > > > (6123MB/s-6123MB/s), io=3D1711GiB (1837GB), run=3D300=
001-300001msec
> > > > > > > > > > >
> > > > > > > > > > > MGLRU off:
> > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > >    READ: bw=3D5689MiB/s (5965MB/s), 5689MiB/s-5689MiB=
/s
> > > > > > > > > > > (5965MB/s-5965MB/s), io=3D1667GiB (1790GB), run=3D300=
003-300003msec
> > > > > > > > > > >
> > > > > > > > > > > fio uses ramdisk so LRU accuracy will have smaller im=
pact. The Mongodb
> > > > > > > > > > > test I provided before uses a SATA SSD so it will hav=
e a much higher
> > > > > > > > > > > impact. I'll provides a script to setup the test case=
 and run it, it's
> > > > > > > > > > > more complex to setup than fio since involving settin=
g up multiple
> > > > > > > > > > > replicas and auth and hundreds of GB of test fixtures=
, I'm currently
> > > > > > > > > > > occupied by some other tasks but will try best to sen=
d them out as
> > > > > > > > > > > soon as possible.
> > > > > > > > > >
> > > > > > > > > > Thanks! Apparently your RFC did show better IOPS with b=
oth access
> > > > > > > > > > patterns, which was a surprise to me because it had hig=
her refaults
> > > > > > > > > > and usually higher refautls result in worse performance=
.
> > > > > >
> > > > > > And thanks for providing the refaults I requested for -- your d=
ata
> > > > > > below confirms what I mentioned above:
> > > > > >
> > > > > > For fio:
> > > > > >                            Your RFC   This series   Change
> > > > > >   workingset_refault_file  628192729  596790506     -5%
> > > > > >   IOPS                     1862k      1830k         -2%
> > > > > >
> > > > > > For MongoDB:
> > > > > >                            Your RFC   This series   Change
> > > > > >   workingset_refault_anon  10512      35277         +30%
> > > > > >   workingset_refault_file  22751782   20335355      -11%
> > > > > >   total                    22762294   20370632      -11%
> > > > > >   TPS                      0.09       0.06          -33%
> > > > > >
> > > > > > For MongoDB, this series should be a big win (but apparently it=
's not),
> > > > > > especially when using zram, since an anon refault should be a l=
ot
> > > > > > cheaper than a file refault.
> > > > > >
> > > > > > So, I'm baffled...
> > > > > >
> > > > > > One important detail I forgot to mention: based on your data fr=
om
> > > > > > lru_gen_full, I think there is another difference between our K=
configs:
> > > > > >
> > > > > >                   Your Kconfig  My Kconfig  Max possible
> > > > > >   LRU_REFS_WIDTH  1             2           2
> > > > >
> > > > > Hi Yu,
> > > > >
> > > > > Thanks for the info, my fault, I forgot to update my config as I =
was
> > > > > testing some other features.
> > > > > Buf after I changed LRU_REFS_WIDTH to 2 by disabling IDLE_PAGE, t=
hing
> > > > > got much worse for MongoDB test:
> > > > >
> > > > > With LRU_REFS_WIDTH =3D=3D 2:
> > > > >
> > > > > This patch:
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > Execution Results after 919 seconds
> > > > > -----------------------------------------------------------------=
-
> > > > >                   Executed        Time (=C2=B5s)       Rate
> > > > >   STOCK_LEVEL     488             27598136201.9   0.02 txn/s
> > > > > -----------------------------------------------------------------=
-
> > > > >   TOTAL           488             27598136201.9   0.02 txn/s
> > > > >
> > > > > memcg    86 /system.slice/docker-1c3a90be9f0a072f5719332419550cd0=
e1455f2cd5863bc2780ca4d3f913ece5.scope
> > > > >  node     0
> > > > >           1     948187          0x          0x
> > > > >                      0          0           0           0        =
   0
> > > > >          0           0=C2=B7
> > > > >                      1          0           0           0        =
   0
> > > > >          0           0=C2=B7
> > > > >                      2          0           0           0        =
   0
> > > > >          0           0=C2=B7
> > > > >                      3          0           0           0        =
   0
> > > > >          0           0=C2=B7
> > > > >                                 0           0           0        =
   0
> > > > >          0           0=C2=B7
> > > > >           2     948187          0     6051788=C2=B7
> > > > >                      0          0r          0e          0p      1=
1916r
> > > > >      66442e          0p
> > > > >                      1          0r          0e          0p       =
 903r
> > > > >      16888e          0p
> > > > >                      2          0r          0e          0p       =
 459r
> > > > >       9764e          0p
> > > > >                      3          0r          0e          0p       =
   0r
> > > > >          0e       2874p
> > > > >                                 0           0           0        =
   0
> > > > >          0           0=C2=B7
> > > > >           3     948187    1353160        6351=C2=B7
> > > > >                      0          0           0           0        =
   0
> > > > >          0           0=C2=B7
> > > > >                      1          0           0           0        =
   0
> > > > >          0           0=C2=B7
> > > > >                      2          0           0           0        =
   0
> > > > >          0           0=C2=B7
> > > > >                      3          0           0           0        =
   0
> > > > >          0           0=C2=B7
> > > > >                                 0           0           0        =
   0
> > > > >          0           0=C2=B7
> > > > >           4      73045      23573          12=C2=B7
> > > > >                      0          0R          0T          0     349=
8607R
> > > > >    4868605T          0=C2=B7
> > > > >                      1          0R          0T          0     301=
2246R
> > > > >    3270261T          0=C2=B7
> > > > >                      2          0R          0T          0     249=
8608R
> > > > >    2839104T          0=C2=B7
> > > > >                      3          0R          0T          0        =
   0R
> > > > >    1983947T          0=C2=B7
> > > > >                           1486579L          0O    1380614Y       =
2945N
> > > > >       2945F       2734A
> > > > >
> > > > > workingset_refault_anon 0
> > > > > workingset_refault_file 18130598
> > > > >
> > > > >               total        used        free      shared  buff/cac=
he   available
> > > > > Mem:          31978        6705         312          20       249=
60       24786
> > > > > Swap:         31977           4       31973
> > > > >
> > > > > RFC:
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > Execution Results after 908 seconds
> > > > > -----------------------------------------------------------------=
-
> > > > >                   Executed        Time (=C2=B5s)       Rate
> > > > >   STOCK_LEVEL     2252            27159962888.2   0.08 txn/s
> > > > > -----------------------------------------------------------------=
-
> > > > >   TOTAL           2252            27159962888.2   0.08 txn/s
> > > > >
> > > > > workingset_refault_anon 22585
> > > > > workingset_refault_file 22715256
> > > > >
> > > > > memcg    66 /system.slice/docker-0989446ff78106e32d3f400a0cf371c9=
a703281bded86d6d6bb1af706ebb25da.scope
> > > > >  node     0
> > > > >          22     563007       2274     1198225=C2=B7
> > > > >                      0          0r          1e          0p       =
   0r
> > > > >     697076e          0p
> > > > >                      1          0r          0e          0p       =
   0r
> > > > >          0e     325661p
> > > > >                      2          0r          0e          0p       =
   0r
> > > > >          0e     888728p
> > > > >                      3          0r          0e          0p       =
   0r
> > > > >          0e    3602238p
> > > > >                                 0           0           0        =
   0
> > > > >          0           0=C2=B7
> > > > >          23     532222       7525     4948747=C2=B7
> > > > >                      0          0           0           0        =
   0
> > > > >          0           0=C2=B7
> > > > >                      1          0           0           0        =
   0
> > > > >          0           0=C2=B7
> > > > >                      2          0           0           0        =
   0
> > > > >          0           0=C2=B7
> > > > >                      3          0           0           0        =
   0
> > > > >          0           0=C2=B7
> > > > >                                 0           0           0        =
   0
> > > > >          0           0=C2=B7
> > > > >          24     500367    1214667        3292=C2=B7
> > > > >                      0          0           0           0        =
   0
> > > > >          0           0=C2=B7
> > > > >                      1          0           0           0        =
   0
> > > > >          0           0=C2=B7
> > > > >                      2          0           0           0        =
   0
> > > > >          0           0=C2=B7
> > > > >                      3          0           0           0        =
   0
> > > > >          0           0=C2=B7
> > > > >                                 0           0           0        =
   0
> > > > >          0           0=C2=B7
> > > > >          25     469692      40797         466=C2=B7
> > > > >                      0          0R        271T          0        =
   0R
> > > > >    1162165T          0=C2=B7
> > > > >                      1          0R          0T          0      77=
4028R
> > > > >    1205332T          0=C2=B7
> > > > >                      2          0R          0T          0        =
   0R
> > > > >     932484T          0=C2=B7
> > > > >                      3          0R          1T          0        =
   0R
> > > > >    4252158T          0=C2=B7
> > > > >                          25178380L     156515O   23953602Y      5=
9234N
> > > > >      49391F      48664A
> > > > >
> > > > >               total        used        free      shared  buff/cac=
he   available
> > > > > Mem:          31978        6968         338           5       246=
71       24555
> > > > > Swap:         31977        1533       30444
> > > > >
> > > > > Using same mongodb config (a 3 replica cluster using the same con=
fig):
> > > > > {
> > > > >     "net": {
> > > > >         "bindIpAll": true,
> > > > >         "ipv6": false,
> > > > >         "maxIncomingConnections": 10000,
> > > > >     },
> > > > >     "setParameter": {
> > > > >         "disabledSecureAllocatorDomains": "*"
> > > > >     },
> > > > >     "replication": {
> > > > >         "oplogSizeMB": 10480,
> > > > >         "replSetName": "issa-tpcc_0"
> > > > >     },
> > > > >     "security": {
> > > > >         "keyFile": "/data/db/keyfile"
> > > > >     },
> > > > >     "storage": {
> > > > >         "dbPath": "/data/db/",
> > > > >         "syncPeriodSecs": 60,
> > > > >         "directoryPerDB": true,
> > > > >         "wiredTiger": {
> > > > >             "engineConfig": {
> > > > >                 "cacheSizeGB": 5
> > > > >             }
> > > > >         }
> > > > >     },
> > > > >     "systemLog": {
> > > > >         "destination": "file",
> > > > >         "logAppend": true,
> > > > >         "logRotate": "rename",
> > > > >         "path": "/data/db/mongod.log",
> > > > >         "verbosity": 0
> > > > >     }
> > > > > }
> > > > >
> > > > > The test environment have 32g memory and 16 core.
> > > > >
> > > > > Per my analyze, the access pattern for the mongodb test is that p=
age
> > > > > will be re-access long after it's evicted so PID controller won't
> > > > > protect higher tier. That RFC will make use of the long existing
> > > > > shadow to do feedback to PID/Gen so the result will be much bette=
r.
> > > > > Still need more adjusting though, will try to do a rebase on top =
of
> > > > > mm-unstable which includes your patch.
> > > > >
> > > > > I've no idea why the workingset_refault_* is higher in the better
> > > > > case, this a clearly an IO bound workload, Memory and IO is busy =
while
> > > > > CPU is not full...
> > > > >
> > > > > I've uploaded my local reproducer here:
> > > > > https://github.com/ryncsn/emm-test-project/tree/master/mongo-clus=
ter
> > > > > https://github.com/ryncsn/py-tpcc
> > > >
> > > > Thanks for the repos -- I'm trying them right now. Which MongoDB
> > > > version did you use? setup.sh didn't seem to install it.
> > > >
> > > > Also do you have a QEMU image? It'd be a lot easier for me to
> > > > duplicate the exact environment by looking into it.
> > >
> > > I ended up using docker.io/mongodb/mongodb-community-server:latest,
> > > and it's not working:
> > >
> > > # docker exec -it mongo-r1 mongosh --eval \
> > > '"rs.initiate({
> > >     _id: "issa-tpcc_0",
> > >     members: [
> > >       {_id: 0, host: "mongo-r1"},
> > >       {_id: 1, host: "mongo-r2"},
> > >       {_id: 2, host: "mongo-r3"}
> > >     ]
> > > })"'
> > > Emulate Docker CLI using podman. Create /etc/containers/nodocker to q=
uiet msg.
> > > Error: can only create exec sessions on running containers: container
> > > state improper
> >
> > Hi Yu,
> >
> > I've updated the test repo:
> > https://github.com/ryncsn/emm-test-project/tree/master/mongo-cluster
> >
> > I've tested it on top of latest Fedora Cloud Image 39 and it worked
> > well for me, the README now contains detailed and not hard to follow
> > steps to reproduce this test.
>
> Thanks. I was following the instructions down to the letter and it
> fell apart again at line 46 (./tpcc.py).

I think you just broke it by
https://github.com/ryncsn/py-tpcc/commit/7b9b380d636cb84faa5b11b5562e531f92=
4eeb7e

(But it's also possible you actually wanted me to use this latest
commit but forgot to account for it in your instructions.)

> Were you able to successfully run the benchmark on a fresh VM by
> following the instructions? If not, I'd appreciate it if you could do
> so and document all the missing steps.

