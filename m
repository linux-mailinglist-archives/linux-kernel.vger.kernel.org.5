Return-Path: <linux-kernel+bounces-10904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F1B81DE9B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 07:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9E61F21468
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 06:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E574C7D;
	Mon, 25 Dec 2023 06:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UCqxhguy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0054A27
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 06:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d3102d5d6so142725e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 22:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703485856; x=1704090656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewhT6bOGXpbYhySZE/BYs2IiWQ4vAxjbNi3lxNg24Xc=;
        b=UCqxhguyZRM7nWLL5VMqUMczrLqOJx8KSDMcF/pr7if2InedWiCfo2GEykrQBQrgRd
         cI1KAN8+sFtMV4KHdP6uFyJrsmwpSUqV4Kr5bxklOnbd2catBcmZCXqMW6XjbqCXZoN/
         sRraqOa/WgN0BO4mzvqdJ3gJjCQM5fv5zk6Be5QgIwVw6F5eydnWhOEQc214mIKHBqj2
         y4NBdkudgJMD6BkJgIsV9yjwArZW7GTPRDq3e1DhgOVpKJFLBQiRiVW9IurQ3elWQ8SN
         fk5dj4O/xnNYTcBM6vAsAkKZUQSfW1xVwbdJiovjlfbaUOJy2Ks+0SVcmbnjStcundCN
         +WBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703485856; x=1704090656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewhT6bOGXpbYhySZE/BYs2IiWQ4vAxjbNi3lxNg24Xc=;
        b=RuH/AsBiWduqBtAdBWJsrUJtX+6/7lL5n3Ox87H1uSQr+FCr0VBqKNTFLfd+84XGBK
         Oe14IHjgqziFuxeqPeC4SHp7Y4pdeTji7jQyBCus1SGEmNhLSXEiOjA4XPsV0s5PQNhU
         Plm3WuUoy+tFH558Sc8BkdX9jvsgDK9UqyNQtBMhW3SJPUPn4tkAikZGUCDkJ9CgfZ+c
         +BHJQYw7upfc3ua/15hVMw2h5scxy5tjCm7xPSYfqhsiZFOtpmGbLexy2ysHkisPtYVw
         AXx7vWaMQoje6Nzd5w9vqUa3c7UmXyql/qZgVxQ3zFaTMh6xJcxIw5XVib39s7p31jAr
         j2DQ==
X-Gm-Message-State: AOJu0YzH/4yLsRt4k8vVlvrg0cmK57YTUM21tLg117SObiKDpQ9rwVbN
	XxcwgK8fqe5BxUoynueGl2dA8kEX36Uzou+PS6GTYd6wbi2L
X-Google-Smtp-Source: AGHT+IEZExLqTEk9/oMYL1vqD5K1scDRXGhlQwCygDnflW3ABvZL2a4Bq4rjGhcXeDUIKpAbZALXZ/mLdrnDumQFDCM=
X-Received: by 2002:a05:600c:3b93:b0:40d:4a11:3aab with SMTP id
 n19-20020a05600c3b9300b0040d4a113aabmr297140wms.7.1703485855967; Sun, 24 Dec
 2023 22:30:55 -0800 (PST)
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
 <CAMgjq7C8uUOz5i8rEHNCs37fdEiAuMZsuV+Ktnz3TMX9Nf8F+g@mail.gmail.com>
 <CAOUHufamzdOL8ByV9V7KQJKnvZBMboVz-EGD=Fus7LZk1inhCw@mail.gmail.com>
 <CAOUHufaWkAvQK_fmXF5WZW4ZKQ0W4UZfjWDG+OZAxgF_J0dOuA@mail.gmail.com> <CAMgjq7BR4wyT5itvs58Wjar6EymdazhKvpAjSPHF-SYvrguu2Q@mail.gmail.com>
In-Reply-To: <CAMgjq7BR4wyT5itvs58Wjar6EymdazhKvpAjSPHF-SYvrguu2Q@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Sun, 24 Dec 2023 23:30:17 -0700
Message-ID: <CAOUHufbZTJN6TRv55DVDjMp3frqpJOZP0HsQx3Y7veGCuaih8g@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 1/4] mm/mglru: fix underprotected page cache
To: Kairui Song <ryncsn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Charan Teja Kalla <quic_charante@quicinc.com>, 
	Kalesh Singh <kaleshsingh@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 1:24=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8820=E6=97=A5=
=E5=91=A8=E4=B8=89 16:17=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, Dec 19, 2023 at 11:38=E2=80=AFPM Yu Zhao <yuzhao@google.com> wr=
ote:
> > >
> > > On Tue, Dec 19, 2023 at 11:58=E2=80=AFAM Kairui Song <ryncsn@gmail.co=
m> wrote:
> > > >
> > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8819=E6=
=97=A5=E5=91=A8=E4=BA=8C 11:45=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > On Mon, Dec 18, 2023 at 8:21=E2=80=AFPM Yu Zhao <yuzhao@google.co=
m> wrote:
> > > > > >
> > > > > > On Mon, Dec 18, 2023 at 11:05=E2=80=AFAM Kairui Song <ryncsn@gm=
ail.com> wrote:
> > > > > > >
> > > > > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=88=
15=E6=97=A5=E5=91=A8=E4=BA=94 12:56=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > >
> > > > > > > > On Thu, Dec 14, 2023 at 04:51:00PM -0700, Yu Zhao wrote:
> > > > > > > > > On Thu, Dec 14, 2023 at 11:38=E2=80=AFAM Kairui Song <ryn=
csn@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=
=9C=8814=E6=97=A5=E5=91=A8=E5=9B=9B 11:09=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > > > > On Wed, Dec 13, 2023 at 12:59:14AM -0700, Yu Zhao wro=
te:
> > > > > > > > > > > > On Tue, Dec 12, 2023 at 8:03=E2=80=AFPM Kairui Song=
 <ryncsn@gmail.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Kairui Song <ryncsn@gmail.com> =E4=BA=8E2023=E5=
=B9=B412=E6=9C=8812=E6=97=A5=E5=91=A8=E4=BA=8C 14:52=E5=86=99=E9=81=93=EF=
=BC=9A
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=
=B412=E6=9C=8812=E6=97=A5=E5=91=A8=E4=BA=8C 06:07=E5=86=99=E9=81=93=EF=BC=
=9A
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Fri, Dec 8, 2023 at 1:24=E2=80=AFAM Kairui=
 Song <ryncsn@gmail.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=
=E5=B9=B412=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=94 14:14=E5=86=99=E9=81=93=EF=
=BC=9A
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Unmapped folios accessed through file des=
criptors can be
> > > > > > > > > > > > > > > > > underprotected. Those folios are added to=
 the oldest generation based
> > > > > > > > > > > > > > > > > on:
> > > > > > > > > > > > > > > > > 1. The fact that they are less costly to =
reclaim (no need to walk the
> > > > > > > > > > > > > > > > >    rmap and flush the TLB) and have less =
impact on performance (don't
> > > > > > > > > > > > > > > > >    cause major PFs and can be non-blockin=
g if needed again).
> > > > > > > > > > > > > > > > > 2. The observation that they are likely t=
o be single-use. E.g., for
> > > > > > > > > > > > > > > > >    client use cases like Android, its app=
s parse configuration files
> > > > > > > > > > > > > > > > >    and store the data in heap (anon); for=
 server use cases like MySQL,
> > > > > > > > > > > > > > > > >    it reads from InnoDB files and holds t=
he cached data for tables in
> > > > > > > > > > > > > > > > >    buffer pools (anon).
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > However, the oldest generation can be ver=
y short lived, and if so, it
> > > > > > > > > > > > > > > > > doesn't provide the PID controller with e=
nough time to respond to a
> > > > > > > > > > > > > > > > > surge of refaults. (Note that the PID con=
troller uses weighted
> > > > > > > > > > > > > > > > > refaults and those from evicted generatio=
ns only take a half of the
> > > > > > > > > > > > > > > > > whole weight.) In other words, for a shor=
t lived generation, the
> > > > > > > > > > > > > > > > > moving average smooths out the spike quic=
kly.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > To fix the problem:
> > > > > > > > > > > > > > > > > 1. For folios that are already on LRU, if=
 they can be beyond the
> > > > > > > > > > > > > > > > >    tracking range of tiers, i.e., five ac=
cesses through file
> > > > > > > > > > > > > > > > >    descriptors, move them to the second o=
ldest generation to give them
> > > > > > > > > > > > > > > > >    more time to age. (Note that tiers are=
 used by the PID controller
> > > > > > > > > > > > > > > > >    to statistically determine whether fol=
ios accessed multiple times
> > > > > > > > > > > > > > > > >    through file descriptors are worth pro=
tecting.)
> > > > > > > > > > > > > > > > > 2. When adding unmapped folios to LRU, ad=
just the placement of them so
> > > > > > > > > > > > > > > > >    that they are not too close to the tai=
l. The effect of this is
> > > > > > > > > > > > > > > > >    similar to the above.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Android, launching 55 apps sequentiall=
y:
> > > > > > > > > > > > > > > > >                            Before     Aft=
er      Change
> > > > > > > > > > > > > > > > >   workingset_refault_anon  25641024   255=
98972   0%
> > > > > > > > > > > > > > > > >   workingset_refault_file  115016834  106=
178438  -8%
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Hi Yu,
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Thanks you for your amazing works on MGLRU.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I believe this is the similar issue I was t=
rying to resolve previously:
> > > > > > > > > > > > > > > > https://lwn.net/Articles/945266/
> > > > > > > > > > > > > > > > The idea is to use refault distance to deci=
de if the page should be
> > > > > > > > > > > > > > > > place in oldest generation or some other ge=
n, which per my test,
> > > > > > > > > > > > > > > > worked very well, and we have been using re=
fault distance for MGLRU in
> > > > > > > > > > > > > > > > multiple workloads.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > There are a few issues left in my previous =
RFC series, like anon pages
> > > > > > > > > > > > > > > > in MGLRU shouldn't be considered, I wanted =
to collect feedback or test
> > > > > > > > > > > > > > > > cases, but unfortunately it seems didn't ge=
t too much attention
> > > > > > > > > > > > > > > > upstream.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I think both this patch and my previous ser=
ies are for solving the
> > > > > > > > > > > > > > > > file pages underpertected issue, and I did =
a quick test using this
> > > > > > > > > > > > > > > > series, for mongodb test, refault distance =
seems still a better
> > > > > > > > > > > > > > > > solution (I'm not saying these two optimiza=
tion are mutually exclusive
> > > > > > > > > > > > > > > > though, just they do have some conflicts in=
 implementation and solving
> > > > > > > > > > > > > > > > similar problem):
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Previous result:
> > > > > > > > > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > > > > > > > > > > > > > > > Execution Results after 905 seconds
> > > > > > > > > > > > > > > > -------------------------------------------=
-----------------------
> > > > > > > > > > > > > > > >                   Executed        Time (=C2=
=B5s)       Rate
> > > > > > > > > > > > > > > >   STOCK_LEVEL     2542            271215714=
86.2   0.09 txn/s
> > > > > > > > > > > > > > > > -------------------------------------------=
-----------------------
> > > > > > > > > > > > > > > >   TOTAL           2542            271215714=
86.2   0.09 txn/s
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > This patch:
> > > > > > > > > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > > > > > > > > > > > > > > > Execution Results after 900 seconds
> > > > > > > > > > > > > > > > -------------------------------------------=
-----------------------
> > > > > > > > > > > > > > > >                   Executed        Time (=C2=
=B5s)       Rate
> > > > > > > > > > > > > > > >   STOCK_LEVEL     1594            270615225=
74.4   0.06 txn/s
> > > > > > > > > > > > > > > > -------------------------------------------=
-----------------------
> > > > > > > > > > > > > > > >   TOTAL           1594            270615225=
74.4   0.06 txn/s
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Unpatched version is always around ~500.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Thanks for the test results!
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I think there are a few points here:
> > > > > > > > > > > > > > > > - Refault distance make use of page shadow =
so it can better
> > > > > > > > > > > > > > > > distinguish evicted pages of different acce=
ss pattern (re-access
> > > > > > > > > > > > > > > > distance).
> > > > > > > > > > > > > > > > - Throttled refault distance can help hold =
part of workingset when
> > > > > > > > > > > > > > > > memory is too small to hold the whole worki=
ngset.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > So maybe part of this patch and the bits of=
 previous series can be
> > > > > > > > > > > > > > > > combined to work better on this issue, how =
do you think?
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I'll try to find some time this week to look =
at your RFC. It'd be a
> > > > > > > > > > > > >
> > > > > > > > > > > > > Hi Yu,
> > > > > > > > > > > > >
> > > > > > > > > > > > > I'm working on V4 of the RFC now, which just upda=
te some comments, and
> > > > > > > > > > > > > skip anon page re-activation in refault path for =
mglru which was not
> > > > > > > > > > > > > very helpful, only some tiny adjustment.
> > > > > > > > > > > > > And I found it easier to test with fio, using fol=
lowing test script:
> > > > > > > > > > > > >
> > > > > > > > > > > > > #!/bin/bash
> > > > > > > > > > > > > swapoff -a
> > > > > > > > > > > > >
> > > > > > > > > > > > > modprobe brd rd_nr=3D1 rd_size=3D16777216
> > > > > > > > > > > > > mkfs.ext4 /dev/ram0
> > > > > > > > > > > > > mount /dev/ram0 /mnt
> > > > > > > > > > > > >
> > > > > > > > > > > > > mkdir -p /sys/fs/cgroup/benchmark
> > > > > > > > > > > > > cd /sys/fs/cgroup/benchmark
> > > > > > > > > > > > >
> > > > > > > > > > > > > echo 4G > memory.max
> > > > > > > > > > > > > echo $$ > cgroup.procs
> > > > > > > > > > > > > echo 3 > /proc/sys/vm/drop_caches
> > > > > > > > > > > > >
> > > > > > > > > > > > > fio -name=3Dmglru --numjobs=3D12 --directory=3D/m=
nt --size=3D1024m \
> > > > > > > > > > > > >           --buffered=3D1 --ioengine=3Dio_uring --=
iodepth=3D128 \
> > > > > > > > > > > > >           --iodepth_batch_submit=3D32 --iodepth_b=
atch_complete=3D32 \
> > > > > > > > > > > > >           --rw=3Drandread --random_distribution=
=3Dzipf:0.5 --norandommap \
> > > > > > > > > > > > >           --time_based --ramp_time=3D5m --runtime=
=3D5m --group_reporting
> > > > > > > > > > > > >
> > > > > > > > > > > > > zipf:0.5 is used here to simulate a cached read w=
ith slight bias
> > > > > > > > > > > > > towards certain pages.
> > > > > > > > > > > > > Unpatched 6.7-rc4:
> > > > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > > > >    READ: bw=3D6548MiB/s (6866MB/s), 6548MiB/s-654=
8MiB/s
> > > > > > > > > > > > > (6866MB/s-6866MB/s), io=3D1918GiB (2060GB), run=
=3D300001-300001msec
> > > > > > > > > > > > >
> > > > > > > > > > > > > Patched with RFC v4:
> > > > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > > > >    READ: bw=3D7270MiB/s (7623MB/s), 7270MiB/s-727=
0MiB/s
> > > > > > > > > > > > > (7623MB/s-7623MB/s), io=3D2130GiB (2287GB), run=
=3D300001-300001msec
> > > > > > > > > > > > >
> > > > > > > > > > > > > Patched with this series:
> > > > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > > > >    READ: bw=3D7098MiB/s (7442MB/s), 7098MiB/s-709=
8MiB/s
> > > > > > > > > > > > > (7442MB/s-7442MB/s), io=3D2079GiB (2233GB), run=
=3D300002-300002msec
> > > > > > > > > > > > >
> > > > > > > > > > > > > MGLRU off:
> > > > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > > > >    READ: bw=3D6525MiB/s (6842MB/s), 6525MiB/s-652=
5MiB/s
> > > > > > > > > > > > > (6842MB/s-6842MB/s), io=3D1912GiB (2052GB), run=
=3D300002-300002msec
> > > > > > > > > > > > >
> > > > > > > > > > > > > - If I change zipf:0.5 to random:
> > > > > > > > > > > > > Unpatched 6.7-rc4:
> > > > > > > > > > > > > Patched with this series:
> > > > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > > > >    READ: bw=3D5975MiB/s (6265MB/s), 5975MiB/s-597=
5MiB/s
> > > > > > > > > > > > > (6265MB/s-6265MB/s), io=3D1750GiB (1879GB), run=
=3D300002-300002msec
> > > > > > > > > > > > >
> > > > > > > > > > > > > Patched with RFC v4:
> > > > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > > > >    READ: bw=3D5987MiB/s (6278MB/s), 5987MiB/s-598=
7MiB/s
> > > > > > > > > > > > > (6278MB/s-6278MB/s), io=3D1754GiB (1883GB), run=
=3D300001-300001msec
> > > > > > > > > > > > >
> > > > > > > > > > > > > Patched with this series:
> > > > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > > > >    READ: bw=3D5839MiB/s (6123MB/s), 5839MiB/s-583=
9MiB/s
> > > > > > > > > > > > > (6123MB/s-6123MB/s), io=3D1711GiB (1837GB), run=
=3D300001-300001msec
> > > > > > > > > > > > >
> > > > > > > > > > > > > MGLRU off:
> > > > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > > > >    READ: bw=3D5689MiB/s (5965MB/s), 5689MiB/s-568=
9MiB/s
> > > > > > > > > > > > > (5965MB/s-5965MB/s), io=3D1667GiB (1790GB), run=
=3D300003-300003msec
> > > > > > > > > > > > >
> > > > > > > > > > > > > fio uses ramdisk so LRU accuracy will have smalle=
r impact. The Mongodb
> > > > > > > > > > > > > test I provided before uses a SATA SSD so it will=
 have a much higher
> > > > > > > > > > > > > impact. I'll provides a script to setup the test =
case and run it, it's
> > > > > > > > > > > > > more complex to setup than fio since involving se=
tting up multiple
> > > > > > > > > > > > > replicas and auth and hundreds of GB of test fixt=
ures, I'm currently
> > > > > > > > > > > > > occupied by some other tasks but will try best to=
 send them out as
> > > > > > > > > > > > > soon as possible.
> > > > > > > > > > > >
> > > > > > > > > > > > Thanks! Apparently your RFC did show better IOPS wi=
th both access
> > > > > > > > > > > > patterns, which was a surprise to me because it had=
 higher refaults
> > > > > > > > > > > > and usually higher refautls result in worse perform=
ance.
> > > > > > > >
> > > > > > > > And thanks for providing the refaults I requested for -- yo=
ur data
> > > > > > > > below confirms what I mentioned above:
> > > > > > > >
> > > > > > > > For fio:
> > > > > > > >                            Your RFC   This series   Change
> > > > > > > >   workingset_refault_file  628192729  596790506     -5%
> > > > > > > >   IOPS                     1862k      1830k         -2%
> > > > > > > >
> > > > > > > > For MongoDB:
> > > > > > > >                            Your RFC   This series   Change
> > > > > > > >   workingset_refault_anon  10512      35277         +30%
> > > > > > > >   workingset_refault_file  22751782   20335355      -11%
> > > > > > > >   total                    22762294   20370632      -11%
> > > > > > > >   TPS                      0.09       0.06          -33%
> > > > > > > >
> > > > > > > > For MongoDB, this series should be a big win (but apparentl=
y it's not),
> > > > > > > > especially when using zram, since an anon refault should be=
 a lot
> > > > > > > > cheaper than a file refault.
> > > > > > > >
> > > > > > > > So, I'm baffled...
> > > > > > > >
> > > > > > > > One important detail I forgot to mention: based on your dat=
a from
> > > > > > > > lru_gen_full, I think there is another difference between o=
ur Kconfigs:
> > > > > > > >
> > > > > > > >                   Your Kconfig  My Kconfig  Max possible
> > > > > > > >   LRU_REFS_WIDTH  1             2           2
> > > > > > >
> > > > > > > Hi Yu,
> > > > > > >
> > > > > > > Thanks for the info, my fault, I forgot to update my config a=
s I was
> > > > > > > testing some other features.
> > > > > > > Buf after I changed LRU_REFS_WIDTH to 2 by disabling IDLE_PAG=
E, thing
> > > > > > > got much worse for MongoDB test:
> > > > > > >
> > > > > > > With LRU_REFS_WIDTH =3D=3D 2:
> > > > > > >
> > > > > > > This patch:
> > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > Execution Results after 919 seconds
> > > > > > > -------------------------------------------------------------=
-----
> > > > > > >                   Executed        Time (=C2=B5s)       Rate
> > > > > > >   STOCK_LEVEL     488             27598136201.9   0.02 txn/s
> > > > > > > -------------------------------------------------------------=
-----
> > > > > > >   TOTAL           488             27598136201.9   0.02 txn/s
> > > > > > >
> > > > > > > memcg    86 /system.slice/docker-1c3a90be9f0a072f571933241955=
0cd0e1455f2cd5863bc2780ca4d3f913ece5.scope
> > > > > > >  node     0
> > > > > > >           1     948187          0x          0x
> > > > > > >                      0          0           0           0    =
       0
> > > > > > >          0           0=C2=B7
> > > > > > >                      1          0           0           0    =
       0
> > > > > > >          0           0=C2=B7
> > > > > > >                      2          0           0           0    =
       0
> > > > > > >          0           0=C2=B7
> > > > > > >                      3          0           0           0    =
       0
> > > > > > >          0           0=C2=B7
> > > > > > >                                 0           0           0    =
       0
> > > > > > >          0           0=C2=B7
> > > > > > >           2     948187          0     6051788=C2=B7
> > > > > > >                      0          0r          0e          0p   =
   11916r
> > > > > > >      66442e          0p
> > > > > > >                      1          0r          0e          0p   =
     903r
> > > > > > >      16888e          0p
> > > > > > >                      2          0r          0e          0p   =
     459r
> > > > > > >       9764e          0p
> > > > > > >                      3          0r          0e          0p   =
       0r
> > > > > > >          0e       2874p
> > > > > > >                                 0           0           0    =
       0
> > > > > > >          0           0=C2=B7
> > > > > > >           3     948187    1353160        6351=C2=B7
> > > > > > >                      0          0           0           0    =
       0
> > > > > > >          0           0=C2=B7
> > > > > > >                      1          0           0           0    =
       0
> > > > > > >          0           0=C2=B7
> > > > > > >                      2          0           0           0    =
       0
> > > > > > >          0           0=C2=B7
> > > > > > >                      3          0           0           0    =
       0
> > > > > > >          0           0=C2=B7
> > > > > > >                                 0           0           0    =
       0
> > > > > > >          0           0=C2=B7
> > > > > > >           4      73045      23573          12=C2=B7
> > > > > > >                      0          0R          0T          0    =
 3498607R
> > > > > > >    4868605T          0=C2=B7
> > > > > > >                      1          0R          0T          0    =
 3012246R
> > > > > > >    3270261T          0=C2=B7
> > > > > > >                      2          0R          0T          0    =
 2498608R
> > > > > > >    2839104T          0=C2=B7
> > > > > > >                      3          0R          0T          0    =
       0R
> > > > > > >    1983947T          0=C2=B7
> > > > > > >                           1486579L          0O    1380614Y   =
    2945N
> > > > > > >       2945F       2734A
> > > > > > >
> > > > > > > workingset_refault_anon 0
> > > > > > > workingset_refault_file 18130598
> > > > > > >
> > > > > > >               total        used        free      shared  buff=
/cache   available
> > > > > > > Mem:          31978        6705         312          20      =
 24960       24786
> > > > > > > Swap:         31977           4       31973
> > > > > > >
> > > > > > > RFC:
> > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > Execution Results after 908 seconds
> > > > > > > -------------------------------------------------------------=
-----
> > > > > > >                   Executed        Time (=C2=B5s)       Rate
> > > > > > >   STOCK_LEVEL     2252            27159962888.2   0.08 txn/s
> > > > > > > -------------------------------------------------------------=
-----
> > > > > > >   TOTAL           2252            27159962888.2   0.08 txn/s
> > > > > > >
> > > > > > > workingset_refault_anon 22585
> > > > > > > workingset_refault_file 22715256
> > > > > > >
> > > > > > > memcg    66 /system.slice/docker-0989446ff78106e32d3f400a0cf3=
71c9a703281bded86d6d6bb1af706ebb25da.scope
> > > > > > >  node     0
> > > > > > >          22     563007       2274     1198225=C2=B7
> > > > > > >                      0          0r          1e          0p   =
       0r
> > > > > > >     697076e          0p
> > > > > > >                      1          0r          0e          0p   =
       0r
> > > > > > >          0e     325661p
> > > > > > >                      2          0r          0e          0p   =
       0r
> > > > > > >          0e     888728p
> > > > > > >                      3          0r          0e          0p   =
       0r
> > > > > > >          0e    3602238p
> > > > > > >                                 0           0           0    =
       0
> > > > > > >          0           0=C2=B7
> > > > > > >          23     532222       7525     4948747=C2=B7
> > > > > > >                      0          0           0           0    =
       0
> > > > > > >          0           0=C2=B7
> > > > > > >                      1          0           0           0    =
       0
> > > > > > >          0           0=C2=B7
> > > > > > >                      2          0           0           0    =
       0
> > > > > > >          0           0=C2=B7
> > > > > > >                      3          0           0           0    =
       0
> > > > > > >          0           0=C2=B7
> > > > > > >                                 0           0           0    =
       0
> > > > > > >          0           0=C2=B7
> > > > > > >          24     500367    1214667        3292=C2=B7
> > > > > > >                      0          0           0           0    =
       0
> > > > > > >          0           0=C2=B7
> > > > > > >                      1          0           0           0    =
       0
> > > > > > >          0           0=C2=B7
> > > > > > >                      2          0           0           0    =
       0
> > > > > > >          0           0=C2=B7
> > > > > > >                      3          0           0           0    =
       0
> > > > > > >          0           0=C2=B7
> > > > > > >                                 0           0           0    =
       0
> > > > > > >          0           0=C2=B7
> > > > > > >          25     469692      40797         466=C2=B7
> > > > > > >                      0          0R        271T          0    =
       0R
> > > > > > >    1162165T          0=C2=B7
> > > > > > >                      1          0R          0T          0    =
  774028R
> > > > > > >    1205332T          0=C2=B7
> > > > > > >                      2          0R          0T          0    =
       0R
> > > > > > >     932484T          0=C2=B7
> > > > > > >                      3          0R          1T          0    =
       0R
> > > > > > >    4252158T          0=C2=B7
> > > > > > >                          25178380L     156515O   23953602Y   =
   59234N
> > > > > > >      49391F      48664A
> > > > > > >
> > > > > > >               total        used        free      shared  buff=
/cache   available
> > > > > > > Mem:          31978        6968         338           5      =
 24671       24555
> > > > > > > Swap:         31977        1533       30444
> > > > > > >
> > > > > > > Using same mongodb config (a 3 replica cluster using the same=
 config):
> > > > > > > {
> > > > > > >     "net": {
> > > > > > >         "bindIpAll": true,
> > > > > > >         "ipv6": false,
> > > > > > >         "maxIncomingConnections": 10000,
> > > > > > >     },
> > > > > > >     "setParameter": {
> > > > > > >         "disabledSecureAllocatorDomains": "*"
> > > > > > >     },
> > > > > > >     "replication": {
> > > > > > >         "oplogSizeMB": 10480,
> > > > > > >         "replSetName": "issa-tpcc_0"
> > > > > > >     },
> > > > > > >     "security": {
> > > > > > >         "keyFile": "/data/db/keyfile"
> > > > > > >     },
> > > > > > >     "storage": {
> > > > > > >         "dbPath": "/data/db/",
> > > > > > >         "syncPeriodSecs": 60,
> > > > > > >         "directoryPerDB": true,
> > > > > > >         "wiredTiger": {
> > > > > > >             "engineConfig": {
> > > > > > >                 "cacheSizeGB": 5
> > > > > > >             }
> > > > > > >         }
> > > > > > >     },
> > > > > > >     "systemLog": {
> > > > > > >         "destination": "file",
> > > > > > >         "logAppend": true,
> > > > > > >         "logRotate": "rename",
> > > > > > >         "path": "/data/db/mongod.log",
> > > > > > >         "verbosity": 0
> > > > > > >     }
> > > > > > > }
> > > > > > >
> > > > > > > The test environment have 32g memory and 16 core.
> > > > > > >
> > > > > > > Per my analyze, the access pattern for the mongodb test is th=
at page
> > > > > > > will be re-access long after it's evicted so PID controller w=
on't
> > > > > > > protect higher tier. That RFC will make use of the long exist=
ing
> > > > > > > shadow to do feedback to PID/Gen so the result will be much b=
etter.
> > > > > > > Still need more adjusting though, will try to do a rebase on =
top of
> > > > > > > mm-unstable which includes your patch.
> > > > > > >
> > > > > > > I've no idea why the workingset_refault_* is higher in the be=
tter
> > > > > > > case, this a clearly an IO bound workload, Memory and IO is b=
usy while
> > > > > > > CPU is not full...
> > > > > > >
> > > > > > > I've uploaded my local reproducer here:
> > > > > > > https://github.com/ryncsn/emm-test-project/tree/master/mongo-=
cluster
> > > > > > > https://github.com/ryncsn/py-tpcc
> > > > > >
> > > > > > Thanks for the repos -- I'm trying them right now. Which MongoD=
B
> > > > > > version did you use? setup.sh didn't seem to install it.
> > > > > >
> > > > > > Also do you have a QEMU image? It'd be a lot easier for me to
> > > > > > duplicate the exact environment by looking into it.
> > > > >
> > > > > I ended up using docker.io/mongodb/mongodb-community-server:lates=
t,
> > > > > and it's not working:
> > > > >
> > > > > # docker exec -it mongo-r1 mongosh --eval \
> > > > > '"rs.initiate({
> > > > >     _id: "issa-tpcc_0",
> > > > >     members: [
> > > > >       {_id: 0, host: "mongo-r1"},
> > > > >       {_id: 1, host: "mongo-r2"},
> > > > >       {_id: 2, host: "mongo-r3"}
> > > > >     ]
> > > > > })"'
> > > > > Emulate Docker CLI using podman. Create /etc/containers/nodocker =
to quiet msg.
> > > > > Error: can only create exec sessions on running containers: conta=
iner
> > > > > state improper
> > > >
> > > > Hi Yu,
> > > >
> > > > I've updated the test repo:
> > > > https://github.com/ryncsn/emm-test-project/tree/master/mongo-cluste=
r
> > > >
> > > > I've tested it on top of latest Fedora Cloud Image 39 and it worked
> > > > well for me, the README now contains detailed and not hard to follo=
w
> > > > steps to reproduce this test.
> > >
> > > Thanks. I was following the instructions down to the letter and it
> > > fell apart again at line 46 (./tpcc.py).
> >
> > I think you just broke it by
> > https://github.com/ryncsn/py-tpcc/commit/7b9b380d636cb84faa5b11b5562e53=
1f924eeb7e
> >
> > (But it's also possible you actually wanted me to use this latest
> > commit but forgot to account for it in your instructions.)
> >
> > > Were you able to successfully run the benchmark on a fresh VM by
> > > following the instructions? If not, I'd appreciate it if you could do
> > > so and document all the missing steps.
>
> Ah, you are right, I attempted to convert it to Python3 but found it
> only brought more trouble, so I gave up and the instruction is still
> using Python2. However I accidentally pushed the WIP python3 convert
> commit... I've reset the repo to
> https://github.com/ryncsn/py-tpcc/commit/86e862c5cf3b2d1f51e0297742fa837c=
7a99ebf8,
> this is working well. Sorry for the inconvenient.

Thanks -- I was able to reproduce results similar to yours.

It turned out the mystery (fewer refaults but worse performance) was caused=
 by
    13.89%    13.89%  kswapd0  [kernel.vmlinux]  [k]
__list_del_entry_valid_or_report

Apparently Fedora has CONFIG_DEBUG_LIST=3Dy by default, and after I
turned it off (the only change I made), this series showed better TPS
(I used"--duration=3D10800" for more reliable results):
                         v6.7-rc6   RFC [1]    change
total txns               25024      24672      +1%
workingset_refault_anon  573668     680248     -16%
workingset_refault_file  260631976  265808452  -2%

I think this is easy to explain: this series is "lazy", i.e.,
deferring the protection to eviction time, whereas your RFC tries to
do it upfront, i.e., at (re)fault time. The advantage of the former is
that it has more up-to-date information because a folio that is hot
when it's faulted in doesn't mean it's still hot later when memory
pressure kicks in. The disadvantage is that it needs to protect folios
that are still hot at eviction time, by moving them to a younger
generation, where the slow down happened with CONFIG_DEBUG_LIST=3Dy.

(It's not really a priority for me to investigate why
__list_del_entry_valid_or_report() is so heavy. Hopefully someone else
can shed some light on it.)

[1] v3 on top of v6.7-rc6 with "mm/mglru: fix underprotected page
cache" reverted.

