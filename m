Return-Path: <linux-kernel+bounces-5855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2AC819031
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E9BEB25C77
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203953A1AD;
	Tue, 19 Dec 2023 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOzAdJWA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E0F3D0D4;
	Tue, 19 Dec 2023 18:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cc690a3712so38701701fa.3;
        Tue, 19 Dec 2023 10:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703012320; x=1703617120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmzQ0fc1PWRGnb/T9bn4tWeaXV6xyW9C+Zz73H3WGdQ=;
        b=NOzAdJWAKXmjCbdCF8Ich3z1lC5cBH6g47MtVCacjbkocWkC7JgRt4/dXeHet6ITEu
         5gS03JQ4B5MvojVb/DQi0yM5DADXbXLHc4AHyBbMqRdxpIhvTrTu7sFbm7uJuw8WXl7B
         G2xyWNS2CKWhd6ULdVTPwivArBWL5BtKAyxxdR2arGyZRRbwTH/DRsptXoR2wkbU61QJ
         Tdcp6WYxiW5uqnyF66WiBUU92hJ72Nx3eJid3a5iXDsxSI4ca1ienAKn/MWhOVatyGh7
         g7X/l6XsKOFkKgBj4oLtj9bMD6PbcSxTopk9RRMSDzf+lH4zZ3wbzNa85xkq7RxNW4cn
         EUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703012320; x=1703617120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmzQ0fc1PWRGnb/T9bn4tWeaXV6xyW9C+Zz73H3WGdQ=;
        b=b+jgLpeW78jfW52lpCgvWM/RyMWyi4ZQzZiYYdWvpVOmlM1KClKmISrRhzsKVkSnDM
         c1d32Rl80DVGZowwbCAmue2WIgNIYCOU3kzkzX3KmWzakiOGD8Wde3DZGC/5Z+9ZGFhm
         4wVZg5TPsY93R5iEfsaYhQCGheziD2AWLVfRBO7HrI/4leShrpzHwEHuGPIomrmYXmOu
         aiS0CMDdUtxhD+8PX3lK8wQrPpTzVPgai7mvDkEKdteppl2iBTBPvNvNYUhY3ctdOtov
         aqfjdDRAJvq9NumW0pJpT77ktaEfwmch+qBVWBScaggna+SvlVrw1Zal5oaWjqu6Pv2B
         6JDw==
X-Gm-Message-State: AOJu0YxSGI6Y1zUGxzW61c4IIzNOV5NbRPq/VuKFUIOr53m9r5Cl2BAa
	knyU+zxSXZpZwKhQA0F5qNJNtINqwuLpk5a4eZTb/GQ1UH0DDUah
X-Google-Smtp-Source: AGHT+IHmkGOytdzIjls/nDY5aHQWThQNOSb2UMQNHWo01LZ40LCEXjV2nWT9/3i9YJt7ax2b/TXEP4SGM/wdU888a9c=
X-Received: by 2002:a2e:3312:0:b0:2cc:5778:eb25 with SMTP id
 d18-20020a2e3312000000b002cc5778eb25mr3029402ljc.15.1703012319352; Tue, 19
 Dec 2023 10:58:39 -0800 (PST)
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
 <CAOUHufZFkdDjCdQKBV5+W_bp_7x5VwrwkYbJeDdQ19S=m4Mc6A@mail.gmail.com> <CAOUHufbRq8WsGzNRn119GqL5AmeSOkZxQv3L2LTaCm=k3bzrRA@mail.gmail.com>
In-Reply-To: <CAOUHufbRq8WsGzNRn119GqL5AmeSOkZxQv3L2LTaCm=k3bzrRA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 20 Dec 2023 02:58:22 +0800
Message-ID: <CAMgjq7C8uUOz5i8rEHNCs37fdEiAuMZsuV+Ktnz3TMX9Nf8F+g@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 1/4] mm/mglru: fix underprotected page cache
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Charan Teja Kalla <quic_charante@quicinc.com>, 
	Kalesh Singh <kaleshsingh@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8819=E6=97=A5=E5=
=91=A8=E4=BA=8C 11:45=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Dec 18, 2023 at 8:21=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote=
:
> >
> > On Mon, Dec 18, 2023 at 11:05=E2=80=AFAM Kairui Song <ryncsn@gmail.com>=
 wrote:
> > >
> > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8815=E6=97=
=A5=E5=91=A8=E4=BA=94 12:56=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Thu, Dec 14, 2023 at 04:51:00PM -0700, Yu Zhao wrote:
> > > > > On Thu, Dec 14, 2023 at 11:38=E2=80=AFAM Kairui Song <ryncsn@gmai=
l.com> wrote:
> > > > > >
> > > > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8814=
=E6=97=A5=E5=91=A8=E5=9B=9B 11:09=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > On Wed, Dec 13, 2023 at 12:59:14AM -0700, Yu Zhao wrote:
> > > > > > > > On Tue, Dec 12, 2023 at 8:03=E2=80=AFPM Kairui Song <ryncsn=
@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Kairui Song <ryncsn@gmail.com> =E4=BA=8E2023=E5=B9=B412=
=E6=9C=8812=E6=97=A5=E5=91=A8=E4=BA=8C 14:52=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > > >
> > > > > > > > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=
=9C=8812=E6=97=A5=E5=91=A8=E4=BA=8C 06:07=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > > > >
> > > > > > > > > > > On Fri, Dec 8, 2023 at 1:24=E2=80=AFAM Kairui Song <r=
yncsn@gmail.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B41=
2=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=94 14:14=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > > > > > >
> > > > > > > > > > > > > Unmapped folios accessed through file descriptors=
 can be
> > > > > > > > > > > > > underprotected. Those folios are added to the old=
est generation based
> > > > > > > > > > > > > on:
> > > > > > > > > > > > > 1. The fact that they are less costly to reclaim =
(no need to walk the
> > > > > > > > > > > > >    rmap and flush the TLB) and have less impact o=
n performance (don't
> > > > > > > > > > > > >    cause major PFs and can be non-blocking if nee=
ded again).
> > > > > > > > > > > > > 2. The observation that they are likely to be sin=
gle-use. E.g., for
> > > > > > > > > > > > >    client use cases like Android, its apps parse =
configuration files
> > > > > > > > > > > > >    and store the data in heap (anon); for server =
use cases like MySQL,
> > > > > > > > > > > > >    it reads from InnoDB files and holds the cache=
d data for tables in
> > > > > > > > > > > > >    buffer pools (anon).
> > > > > > > > > > > > >
> > > > > > > > > > > > > However, the oldest generation can be very short =
lived, and if so, it
> > > > > > > > > > > > > doesn't provide the PID controller with enough ti=
me to respond to a
> > > > > > > > > > > > > surge of refaults. (Note that the PID controller =
uses weighted
> > > > > > > > > > > > > refaults and those from evicted generations only =
take a half of the
> > > > > > > > > > > > > whole weight.) In other words, for a short lived =
generation, the
> > > > > > > > > > > > > moving average smooths out the spike quickly.
> > > > > > > > > > > > >
> > > > > > > > > > > > > To fix the problem:
> > > > > > > > > > > > > 1. For folios that are already on LRU, if they ca=
n be beyond the
> > > > > > > > > > > > >    tracking range of tiers, i.e., five accesses t=
hrough file
> > > > > > > > > > > > >    descriptors, move them to the second oldest ge=
neration to give them
> > > > > > > > > > > > >    more time to age. (Note that tiers are used by=
 the PID controller
> > > > > > > > > > > > >    to statistically determine whether folios acce=
ssed multiple times
> > > > > > > > > > > > >    through file descriptors are worth protecting.=
)
> > > > > > > > > > > > > 2. When adding unmapped folios to LRU, adjust the=
 placement of them so
> > > > > > > > > > > > >    that they are not too close to the tail. The e=
ffect of this is
> > > > > > > > > > > > >    similar to the above.
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Android, launching 55 apps sequentially:
> > > > > > > > > > > > >                            Before     After      =
Change
> > > > > > > > > > > > >   workingset_refault_anon  25641024   25598972   =
0%
> > > > > > > > > > > > >   workingset_refault_file  115016834  106178438  =
-8%
> > > > > > > > > > > >
> > > > > > > > > > > > Hi Yu,
> > > > > > > > > > > >
> > > > > > > > > > > > Thanks you for your amazing works on MGLRU.
> > > > > > > > > > > >
> > > > > > > > > > > > I believe this is the similar issue I was trying to=
 resolve previously:
> > > > > > > > > > > > https://lwn.net/Articles/945266/
> > > > > > > > > > > > The idea is to use refault distance to decide if th=
e page should be
> > > > > > > > > > > > place in oldest generation or some other gen, which=
 per my test,
> > > > > > > > > > > > worked very well, and we have been using refault di=
stance for MGLRU in
> > > > > > > > > > > > multiple workloads.
> > > > > > > > > > > >
> > > > > > > > > > > > There are a few issues left in my previous RFC seri=
es, like anon pages
> > > > > > > > > > > > in MGLRU shouldn't be considered, I wanted to colle=
ct feedback or test
> > > > > > > > > > > > cases, but unfortunately it seems didn't get too mu=
ch attention
> > > > > > > > > > > > upstream.
> > > > > > > > > > > >
> > > > > > > > > > > > I think both this patch and my previous series are =
for solving the
> > > > > > > > > > > > file pages underpertected issue, and I did a quick =
test using this
> > > > > > > > > > > > series, for mongodb test, refault distance seems st=
ill a better
> > > > > > > > > > > > solution (I'm not saying these two optimization are=
 mutually exclusive
> > > > > > > > > > > > though, just they do have some conflicts in impleme=
ntation and solving
> > > > > > > > > > > > similar problem):
> > > > > > > > > > > >
> > > > > > > > > > > > Previous result:
> > > > > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > > > > Execution Results after 905 seconds
> > > > > > > > > > > > ---------------------------------------------------=
---------------
> > > > > > > > > > > >                   Executed        Time (=C2=B5s)   =
    Rate
> > > > > > > > > > > >   STOCK_LEVEL     2542            27121571486.2   0=
.09 txn/s
> > > > > > > > > > > > ---------------------------------------------------=
---------------
> > > > > > > > > > > >   TOTAL           2542            27121571486.2   0=
.09 txn/s
> > > > > > > > > > > >
> > > > > > > > > > > > This patch:
> > > > > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > > > > Execution Results after 900 seconds
> > > > > > > > > > > > ---------------------------------------------------=
---------------
> > > > > > > > > > > >                   Executed        Time (=C2=B5s)   =
    Rate
> > > > > > > > > > > >   STOCK_LEVEL     1594            27061522574.4   0=
.06 txn/s
> > > > > > > > > > > > ---------------------------------------------------=
---------------
> > > > > > > > > > > >   TOTAL           1594            27061522574.4   0=
.06 txn/s
> > > > > > > > > > > >
> > > > > > > > > > > > Unpatched version is always around ~500.
> > > > > > > > > > >
> > > > > > > > > > > Thanks for the test results!
> > > > > > > > > > >
> > > > > > > > > > > > I think there are a few points here:
> > > > > > > > > > > > - Refault distance make use of page shadow so it ca=
n better
> > > > > > > > > > > > distinguish evicted pages of different access patte=
rn (re-access
> > > > > > > > > > > > distance).
> > > > > > > > > > > > - Throttled refault distance can help hold part of =
workingset when
> > > > > > > > > > > > memory is too small to hold the whole workingset.
> > > > > > > > > > > >
> > > > > > > > > > > > So maybe part of this patch and the bits of previou=
s series can be
> > > > > > > > > > > > combined to work better on this issue, how do you t=
hink?
> > > > > > > > > > >
> > > > > > > > > > > I'll try to find some time this week to look at your =
RFC. It'd be a
> > > > > > > > >
> > > > > > > > > Hi Yu,
> > > > > > > > >
> > > > > > > > > I'm working on V4 of the RFC now, which just update some =
comments, and
> > > > > > > > > skip anon page re-activation in refault path for mglru wh=
ich was not
> > > > > > > > > very helpful, only some tiny adjustment.
> > > > > > > > > And I found it easier to test with fio, using following t=
est script:
> > > > > > > > >
> > > > > > > > > #!/bin/bash
> > > > > > > > > swapoff -a
> > > > > > > > >
> > > > > > > > > modprobe brd rd_nr=3D1 rd_size=3D16777216
> > > > > > > > > mkfs.ext4 /dev/ram0
> > > > > > > > > mount /dev/ram0 /mnt
> > > > > > > > >
> > > > > > > > > mkdir -p /sys/fs/cgroup/benchmark
> > > > > > > > > cd /sys/fs/cgroup/benchmark
> > > > > > > > >
> > > > > > > > > echo 4G > memory.max
> > > > > > > > > echo $$ > cgroup.procs
> > > > > > > > > echo 3 > /proc/sys/vm/drop_caches
> > > > > > > > >
> > > > > > > > > fio -name=3Dmglru --numjobs=3D12 --directory=3D/mnt --siz=
e=3D1024m \
> > > > > > > > >           --buffered=3D1 --ioengine=3Dio_uring --iodepth=
=3D128 \
> > > > > > > > >           --iodepth_batch_submit=3D32 --iodepth_batch_com=
plete=3D32 \
> > > > > > > > >           --rw=3Drandread --random_distribution=3Dzipf:0.=
5 --norandommap \
> > > > > > > > >           --time_based --ramp_time=3D5m --runtime=3D5m --=
group_reporting
> > > > > > > > >
> > > > > > > > > zipf:0.5 is used here to simulate a cached read with slig=
ht bias
> > > > > > > > > towards certain pages.
> > > > > > > > > Unpatched 6.7-rc4:
> > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > >    READ: bw=3D6548MiB/s (6866MB/s), 6548MiB/s-6548MiB/s
> > > > > > > > > (6866MB/s-6866MB/s), io=3D1918GiB (2060GB), run=3D300001-=
300001msec
> > > > > > > > >
> > > > > > > > > Patched with RFC v4:
> > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > >    READ: bw=3D7270MiB/s (7623MB/s), 7270MiB/s-7270MiB/s
> > > > > > > > > (7623MB/s-7623MB/s), io=3D2130GiB (2287GB), run=3D300001-=
300001msec
> > > > > > > > >
> > > > > > > > > Patched with this series:
> > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > >    READ: bw=3D7098MiB/s (7442MB/s), 7098MiB/s-7098MiB/s
> > > > > > > > > (7442MB/s-7442MB/s), io=3D2079GiB (2233GB), run=3D300002-=
300002msec
> > > > > > > > >
> > > > > > > > > MGLRU off:
> > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > >    READ: bw=3D6525MiB/s (6842MB/s), 6525MiB/s-6525MiB/s
> > > > > > > > > (6842MB/s-6842MB/s), io=3D1912GiB (2052GB), run=3D300002-=
300002msec
> > > > > > > > >
> > > > > > > > > - If I change zipf:0.5 to random:
> > > > > > > > > Unpatched 6.7-rc4:
> > > > > > > > > Patched with this series:
> > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > >    READ: bw=3D5975MiB/s (6265MB/s), 5975MiB/s-5975MiB/s
> > > > > > > > > (6265MB/s-6265MB/s), io=3D1750GiB (1879GB), run=3D300002-=
300002msec
> > > > > > > > >
> > > > > > > > > Patched with RFC v4:
> > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > >    READ: bw=3D5987MiB/s (6278MB/s), 5987MiB/s-5987MiB/s
> > > > > > > > > (6278MB/s-6278MB/s), io=3D1754GiB (1883GB), run=3D300001-=
300001msec
> > > > > > > > >
> > > > > > > > > Patched with this series:
> > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > >    READ: bw=3D5839MiB/s (6123MB/s), 5839MiB/s-5839MiB/s
> > > > > > > > > (6123MB/s-6123MB/s), io=3D1711GiB (1837GB), run=3D300001-=
300001msec
> > > > > > > > >
> > > > > > > > > MGLRU off:
> > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > >    READ: bw=3D5689MiB/s (5965MB/s), 5689MiB/s-5689MiB/s
> > > > > > > > > (5965MB/s-5965MB/s), io=3D1667GiB (1790GB), run=3D300003-=
300003msec
> > > > > > > > >
> > > > > > > > > fio uses ramdisk so LRU accuracy will have smaller impact=
. The Mongodb
> > > > > > > > > test I provided before uses a SATA SSD so it will have a =
much higher
> > > > > > > > > impact. I'll provides a script to setup the test case and=
 run it, it's
> > > > > > > > > more complex to setup than fio since involving setting up=
 multiple
> > > > > > > > > replicas and auth and hundreds of GB of test fixtures, I'=
m currently
> > > > > > > > > occupied by some other tasks but will try best to send th=
em out as
> > > > > > > > > soon as possible.
> > > > > > > >
> > > > > > > > Thanks! Apparently your RFC did show better IOPS with both =
access
> > > > > > > > patterns, which was a surprise to me because it had higher =
refaults
> > > > > > > > and usually higher refautls result in worse performance.
> > > >
> > > > And thanks for providing the refaults I requested for -- your data
> > > > below confirms what I mentioned above:
> > > >
> > > > For fio:
> > > >                            Your RFC   This series   Change
> > > >   workingset_refault_file  628192729  596790506     -5%
> > > >   IOPS                     1862k      1830k         -2%
> > > >
> > > > For MongoDB:
> > > >                            Your RFC   This series   Change
> > > >   workingset_refault_anon  10512      35277         +30%
> > > >   workingset_refault_file  22751782   20335355      -11%
> > > >   total                    22762294   20370632      -11%
> > > >   TPS                      0.09       0.06          -33%
> > > >
> > > > For MongoDB, this series should be a big win (but apparently it's n=
ot),
> > > > especially when using zram, since an anon refault should be a lot
> > > > cheaper than a file refault.
> > > >
> > > > So, I'm baffled...
> > > >
> > > > One important detail I forgot to mention: based on your data from
> > > > lru_gen_full, I think there is another difference between our Kconf=
igs:
> > > >
> > > >                   Your Kconfig  My Kconfig  Max possible
> > > >   LRU_REFS_WIDTH  1             2           2
> > >
> > > Hi Yu,
> > >
> > > Thanks for the info, my fault, I forgot to update my config as I was
> > > testing some other features.
> > > Buf after I changed LRU_REFS_WIDTH to 2 by disabling IDLE_PAGE, thing
> > > got much worse for MongoDB test:
> > >
> > > With LRU_REFS_WIDTH =3D=3D 2:
> > >
> > > This patch:
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > Execution Results after 919 seconds
> > > ------------------------------------------------------------------
> > >                   Executed        Time (=C2=B5s)       Rate
> > >   STOCK_LEVEL     488             27598136201.9   0.02 txn/s
> > > ------------------------------------------------------------------
> > >   TOTAL           488             27598136201.9   0.02 txn/s
> > >
> > > memcg    86 /system.slice/docker-1c3a90be9f0a072f5719332419550cd0e145=
5f2cd5863bc2780ca4d3f913ece5.scope
> > >  node     0
> > >           1     948187          0x          0x
> > >                      0          0           0           0           0
> > >          0           0=C2=B7
> > >                      1          0           0           0           0
> > >          0           0=C2=B7
> > >                      2          0           0           0           0
> > >          0           0=C2=B7
> > >                      3          0           0           0           0
> > >          0           0=C2=B7
> > >                                 0           0           0           0
> > >          0           0=C2=B7
> > >           2     948187          0     6051788=C2=B7
> > >                      0          0r          0e          0p      11916=
r
> > >      66442e          0p
> > >                      1          0r          0e          0p        903=
r
> > >      16888e          0p
> > >                      2          0r          0e          0p        459=
r
> > >       9764e          0p
> > >                      3          0r          0e          0p          0=
r
> > >          0e       2874p
> > >                                 0           0           0           0
> > >          0           0=C2=B7
> > >           3     948187    1353160        6351=C2=B7
> > >                      0          0           0           0           0
> > >          0           0=C2=B7
> > >                      1          0           0           0           0
> > >          0           0=C2=B7
> > >                      2          0           0           0           0
> > >          0           0=C2=B7
> > >                      3          0           0           0           0
> > >          0           0=C2=B7
> > >                                 0           0           0           0
> > >          0           0=C2=B7
> > >           4      73045      23573          12=C2=B7
> > >                      0          0R          0T          0     3498607=
R
> > >    4868605T          0=C2=B7
> > >                      1          0R          0T          0     3012246=
R
> > >    3270261T          0=C2=B7
> > >                      2          0R          0T          0     2498608=
R
> > >    2839104T          0=C2=B7
> > >                      3          0R          0T          0           0=
R
> > >    1983947T          0=C2=B7
> > >                           1486579L          0O    1380614Y       2945=
N
> > >       2945F       2734A
> > >
> > > workingset_refault_anon 0
> > > workingset_refault_file 18130598
> > >
> > >               total        used        free      shared  buff/cache  =
 available
> > > Mem:          31978        6705         312          20       24960  =
     24786
> > > Swap:         31977           4       31973
> > >
> > > RFC:
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > Execution Results after 908 seconds
> > > ------------------------------------------------------------------
> > >                   Executed        Time (=C2=B5s)       Rate
> > >   STOCK_LEVEL     2252            27159962888.2   0.08 txn/s
> > > ------------------------------------------------------------------
> > >   TOTAL           2252            27159962888.2   0.08 txn/s
> > >
> > > workingset_refault_anon 22585
> > > workingset_refault_file 22715256
> > >
> > > memcg    66 /system.slice/docker-0989446ff78106e32d3f400a0cf371c9a703=
281bded86d6d6bb1af706ebb25da.scope
> > >  node     0
> > >          22     563007       2274     1198225=C2=B7
> > >                      0          0r          1e          0p          0=
r
> > >     697076e          0p
> > >                      1          0r          0e          0p          0=
r
> > >          0e     325661p
> > >                      2          0r          0e          0p          0=
r
> > >          0e     888728p
> > >                      3          0r          0e          0p          0=
r
> > >          0e    3602238p
> > >                                 0           0           0           0
> > >          0           0=C2=B7
> > >          23     532222       7525     4948747=C2=B7
> > >                      0          0           0           0           0
> > >          0           0=C2=B7
> > >                      1          0           0           0           0
> > >          0           0=C2=B7
> > >                      2          0           0           0           0
> > >          0           0=C2=B7
> > >                      3          0           0           0           0
> > >          0           0=C2=B7
> > >                                 0           0           0           0
> > >          0           0=C2=B7
> > >          24     500367    1214667        3292=C2=B7
> > >                      0          0           0           0           0
> > >          0           0=C2=B7
> > >                      1          0           0           0           0
> > >          0           0=C2=B7
> > >                      2          0           0           0           0
> > >          0           0=C2=B7
> > >                      3          0           0           0           0
> > >          0           0=C2=B7
> > >                                 0           0           0           0
> > >          0           0=C2=B7
> > >          25     469692      40797         466=C2=B7
> > >                      0          0R        271T          0           0=
R
> > >    1162165T          0=C2=B7
> > >                      1          0R          0T          0      774028=
R
> > >    1205332T          0=C2=B7
> > >                      2          0R          0T          0           0=
R
> > >     932484T          0=C2=B7
> > >                      3          0R          1T          0           0=
R
> > >    4252158T          0=C2=B7
> > >                          25178380L     156515O   23953602Y      59234=
N
> > >      49391F      48664A
> > >
> > >               total        used        free      shared  buff/cache  =
 available
> > > Mem:          31978        6968         338           5       24671  =
     24555
> > > Swap:         31977        1533       30444
> > >
> > > Using same mongodb config (a 3 replica cluster using the same config)=
:
> > > {
> > >     "net": {
> > >         "bindIpAll": true,
> > >         "ipv6": false,
> > >         "maxIncomingConnections": 10000,
> > >     },
> > >     "setParameter": {
> > >         "disabledSecureAllocatorDomains": "*"
> > >     },
> > >     "replication": {
> > >         "oplogSizeMB": 10480,
> > >         "replSetName": "issa-tpcc_0"
> > >     },
> > >     "security": {
> > >         "keyFile": "/data/db/keyfile"
> > >     },
> > >     "storage": {
> > >         "dbPath": "/data/db/",
> > >         "syncPeriodSecs": 60,
> > >         "directoryPerDB": true,
> > >         "wiredTiger": {
> > >             "engineConfig": {
> > >                 "cacheSizeGB": 5
> > >             }
> > >         }
> > >     },
> > >     "systemLog": {
> > >         "destination": "file",
> > >         "logAppend": true,
> > >         "logRotate": "rename",
> > >         "path": "/data/db/mongod.log",
> > >         "verbosity": 0
> > >     }
> > > }
> > >
> > > The test environment have 32g memory and 16 core.
> > >
> > > Per my analyze, the access pattern for the mongodb test is that page
> > > will be re-access long after it's evicted so PID controller won't
> > > protect higher tier. That RFC will make use of the long existing
> > > shadow to do feedback to PID/Gen so the result will be much better.
> > > Still need more adjusting though, will try to do a rebase on top of
> > > mm-unstable which includes your patch.
> > >
> > > I've no idea why the workingset_refault_* is higher in the better
> > > case, this a clearly an IO bound workload, Memory and IO is busy whil=
e
> > > CPU is not full...
> > >
> > > I've uploaded my local reproducer here:
> > > https://github.com/ryncsn/emm-test-project/tree/master/mongo-cluster
> > > https://github.com/ryncsn/py-tpcc
> >
> > Thanks for the repos -- I'm trying them right now. Which MongoDB
> > version did you use? setup.sh didn't seem to install it.
> >
> > Also do you have a QEMU image? It'd be a lot easier for me to
> > duplicate the exact environment by looking into it.
>
> I ended up using docker.io/mongodb/mongodb-community-server:latest,
> and it's not working:
>
> # docker exec -it mongo-r1 mongosh --eval \
> '"rs.initiate({
>     _id: "issa-tpcc_0",
>     members: [
>       {_id: 0, host: "mongo-r1"},
>       {_id: 1, host: "mongo-r2"},
>       {_id: 2, host: "mongo-r3"}
>     ]
> })"'
> Emulate Docker CLI using podman. Create /etc/containers/nodocker to quiet=
 msg.
> Error: can only create exec sessions on running containers: container
> state improper

Hi Yu,

I've updated the test repo:
https://github.com/ryncsn/emm-test-project/tree/master/mongo-cluster

I've tested it on top of latest Fedora Cloud Image 39 and it worked
well for me, the README now contains detailed and not hard to follow
steps to reproduce this test.

Also I've updated the patch series, I plan to sent out maybe RFC v4
later but need a another or couple days to tidy up and collect test
result:
https://github.com/ryncsn/linux/commits/kasong/devel/refault-distance-v4/

You may want to do test on top of it, I'll be very grateful if there
are any feedback.

It's on top of current mm-unstable to make it work well with your fix
too. I managed to tweak it to be compatible with this series, but it
seems it might cause over-protection of pages and so the performance
is slightly worse than RFC v3.

And this commit message contains my latest test result on the MongoDB case:
https://github.com/ryncsn/linux/commit/cd84e5c8e2449d33d411bce1d863bc391f36=
d7c8
And you can see it's a IO bound task (100% ioutil and low CPU usage)
and anon pages are really idle, using ZRAM/Same disk as swap result in
similar performance on patched kernel.

And about the aging overhead issue I suspected before (regression in
FIO due to more aging), I think it's true, and I added two patches:
https://github.com/ryncsn/linux/commit/f80cc280752da59272870378947aad6c822b=
e2b4
https://github.com/ryncsn/linux/commit/01d091c98077a74bc70153cc7a0179a17da4=
f26f

In the test cases we talked about above, where > ~100 generations are
generated during FIO test, I suspected that the aging overhead is
large and causing performance drain.
After these two patches, for a similar test cases, FIO improved from this:

Run status group 0 (all jobs):
   READ: bw=3D7593MiB/s (7962MB/s), 7593MiB/s-7593MiB/s
(7962MB/s-7962MB/s), io=3D2225GiB (2389GB), run=3D300002-300002msec
workingset_refault_anon 0
workingset_refault_file 641594126

To this:
Run status group 0 (all jobs):
   READ: bw=3D7747MiB/s (8124MB/s), 7747MiB/s-7747MiB/s
(8124MB/s-8124MB/s), io=3D2270GiB (2437GB), run=3D300001-300001msec
workingset_refault_anon 0
workingset_refault_file 641511205

lru_gen stat is similar for both case:
memcg    66 /benchmark
 node     0
        119     155874          0           0x
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

        120     151024          0       71410=C2=B7
                     0          0           0           0           0r
    587382e          0p
                     1          0           0           0           0r
         0e     117796p
                     2          0           0           0           0r
         0e     193086p
                     3          0           0           0           0r
         0e     371926p
                                0           0           0           0
         0           0=C2=B7

        121     146375          0      682854=C2=B7
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

        122     141469          0        1348=C2=B7
                     0          0R          0T          0           0R
   5132602T          0=C2=B7
                     1          0R          0T          0       86010R
    244504T          0=C2=B7
                     2          0R          0T          0           0R
    196061T          0=C2=B7
                     3          0R          0T          0           0R
    397253T          0=C2=B7
                           367101L      15850O      15820Y      93396N
      1275F        459A

The overhead of cmpxchg on page flag update is unavoidable though. I
think I could send out the two bulk update patch first for a proper
review first?

