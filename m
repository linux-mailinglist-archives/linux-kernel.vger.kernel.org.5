Return-Path: <linux-kernel+bounces-22648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D117882A0E7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F381C22919
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B8E4E1C2;
	Wed, 10 Jan 2024 19:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXBLean9"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F392C95;
	Wed, 10 Jan 2024 19:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cd65f803b7so27289641fa.1;
        Wed, 10 Jan 2024 11:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704914184; x=1705518984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRxCeCqbSy+dXKwUNhFRHp3sYdzLQBdPKyVZQC6mfYM=;
        b=jXBLean94NYcQG04ZpGfbtXNoI/jj7hywFOfSd8hdUVPxO3ds+iH4DM5RznhNbWPjP
         zAx+onu9UFrKrm/FQunPa+1zrs/TlNRYOX7Mw3HpfWAAG2gl0c7W5Wg7fRRdjetkBYcu
         RXS3rqA7SyuY7vprF11PeYn7FxGS95h+0nhG2bNnYIywYW9tanD7GkMyY573fFd7Zbaf
         zsGhYZQQN63YpB9FuTyZ13L0rJb2HIMoxVy7A77fhNyvNtnMNwbDp4kvVQ6IRx6IVkyy
         wX4DkKj8d4NzZBreJoiBeJ0Vu+q5sqZBflByGoADRgCBkkXkVdHUI74Sxz/naNDUmvHh
         nVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704914184; x=1705518984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRxCeCqbSy+dXKwUNhFRHp3sYdzLQBdPKyVZQC6mfYM=;
        b=bty32vN8JSUJkUgQomUMdvBs2VelMlEXCiigygcWLX8juRJdqVw8ugGtrvcZb9iNSv
         aPsqWHQcIUhEC05Nu//QLPO7jnBOsWwRocNNUkOfrEsliets4CaR1h6Hr+AwjWglp62H
         Vm8ZimSk1lzE0IdRiiCsnyBmgqDydWfQFRIzSKh/Rv0Yy0FMaVAPG6DcJX20KKzGtq9F
         gwYz/pluaCVl8QNNh7z/sIhgpEf+ehozVJEqpQ4PktqG33vc5buG7SQgoHtcU+y2mz/W
         BsLh/QNp/kw8EqqZqiUm8NTdo57Veds5tpNGFNvyKcIg7dGPXj2ufNiZYjQDF5gU1l/5
         hnsw==
X-Gm-Message-State: AOJu0YxkSLHaBBzgfQ4Z675YQFwd1YSehtb7TXZjwCSH1zG1XTjbjMqE
	PTkSTPu9IBQMcf0VdNdh7DWuxiaBuBE2BQIe4SQ=
X-Google-Smtp-Source: AGHT+IF62nUTOLBQDsalT9RwrgMk6pHnElcpRBzAbhxYOZ5X0dCDeYaj8cMvI80qFuD6zRZ9ypx1A6AYFFgKxcyxEO8=
X-Received: by 2002:a2e:8903:0:b0:2cd:3300:bdf1 with SMTP id
 d3-20020a2e8903000000b002cd3300bdf1mr16659lji.87.1704914183400; Wed, 10 Jan
 2024 11:16:23 -0800 (PST)
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
 <CAOUHufaWkAvQK_fmXF5WZW4ZKQ0W4UZfjWDG+OZAxgF_J0dOuA@mail.gmail.com>
 <CAMgjq7BR4wyT5itvs58Wjar6EymdazhKvpAjSPHF-SYvrguu2Q@mail.gmail.com>
 <CAOUHufbZTJN6TRv55DVDjMp3frqpJOZP0HsQx3Y7veGCuaih8g@mail.gmail.com>
 <CAMgjq7C+zMYtoE=JVsXZitxKHoCh5MqB76OENs7a+NDgGGQ0Kw@mail.gmail.com>
 <CAOUHufbnLX60n+=OV92kXLZGY5_-f_y0ZtETV+0uTqFo5dvBCg@mail.gmail.com> <CAOUHufa12C7Knp78fq4C-ohGz1yrtdriW5xQD=wchinTJD8UVQ@mail.gmail.com>
In-Reply-To: <CAOUHufa12C7Knp78fq4C-ohGz1yrtdriW5xQD=wchinTJD8UVQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 11 Jan 2024 03:16:05 +0800
Message-ID: <CAMgjq7BRaRgYLf2+8=+=nWtzkrHFKmudZPRm41PR6W+A+L=AKA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 1/4] mm/mglru: fix underprotected page cache
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Charan Teja Kalla <quic_charante@quicinc.com>, 
	Kalesh Singh <kaleshsingh@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8826=E6=97=A5=E5=
=91=A8=E4=BA=8C 06:01=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Dec 25, 2023 at 2:52=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote=
:
> >
> > On Mon, Dec 25, 2023 at 5:03=E2=80=AFAM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=B8=80 14:30=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Wed, Dec 20, 2023 at 1:24=E2=80=AFAM Kairui Song <ryncsn@gmail.c=
om> wrote:
> > > > >
> > > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=8820=
=E6=97=A5=E5=91=A8=E4=B8=89 16:17=E5=86=99=E9=81=93=EF=BC=9A
> > > > > >
> > > > > > On Tue, Dec 19, 2023 at 11:38=E2=80=AFPM Yu Zhao <yuzhao@google=
com> wrote:
> > > > > > >
> > > > > > > On Tue, Dec 19, 2023 at 11:58=E2=80=AFAM Kairui Song <ryncsn@=
gmail.com> wrote:
> > > > > > > >
> > > > > > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=E6=9C=
=8819=E6=97=A5=E5=91=A8=E4=BA=8C 11:45=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > >
> > > > > > > > > On Mon, Dec 18, 2023 at 8:21=E2=80=AFPM Yu Zhao <yuzhao@g=
oogle.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Dec 18, 2023 at 11:05=E2=80=AFAM Kairui Song <r=
yncsn@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=B412=
=E6=9C=8815=E6=97=A5=E5=91=A8=E4=BA=94 12:56=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, Dec 14, 2023 at 04:51:00PM -0700, Yu Zhao w=
rote:
> > > > > > > > > > > > > On Thu, Dec 14, 2023 at 11:38=E2=80=AFAM Kairui S=
ong <ryncsn@gmail.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E2023=E5=B9=
=B412=E6=9C=8814=E6=97=A5=E5=91=A8=E5=9B=9B 11:09=E5=86=99=E9=81=93=EF=BC=
=9A
> > > > > > > > > > > > > > > On Wed, Dec 13, 2023 at 12:59:14AM -0700, Yu =
Zhao wrote:
> > > > > > > > > > > > > > > > On Tue, Dec 12, 2023 at 8:03=E2=80=AFPM Kai=
rui Song <ryncsn@gmail.com> wrote:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Kairui Song <ryncsn@gmail.com> =E4=BA=8E2=
023=E5=B9=B412=E6=9C=8812=E6=97=A5=E5=91=A8=E4=BA=8C 14:52=E5=86=99=E9=81=
=93=EF=BC=9A
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Yu Zhao <yuzhao@google.com> =E4=BA=8E20=
23=E5=B9=B412=E6=9C=8812=E6=97=A5=E5=91=A8=E4=BA=8C 06:07=E5=86=99=E9=81=93=
=EF=BC=9A
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > On Fri, Dec 8, 2023 at 1:24=E2=80=AFA=
M Kairui Song <ryncsn@gmail.com> wrote:
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Yu Zhao <yuzhao@google.com> =E4=BA=
=8E2023=E5=B9=B412=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=94 14:14=E5=86=99=E9=
=81=93=EF=BC=9A
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Unmapped folios accessed through =
file descriptors can be
> > > > > > > > > > > > > > > > > > > > > underprotected. Those folios are =
added to the oldest generation based
> > > > > > > > > > > > > > > > > > > > > on:
> > > > > > > > > > > > > > > > > > > > > 1. The fact that they are less co=
stly to reclaim (no need to walk the
> > > > > > > > > > > > > > > > > > > > >    rmap and flush the TLB) and ha=
ve less impact on performance (don't
> > > > > > > > > > > > > > > > > > > > >    cause major PFs and can be non=
-blocking if needed again).
> > > > > > > > > > > > > > > > > > > > > 2. The observation that they are =
likely to be single-use. E.g., for
> > > > > > > > > > > > > > > > > > > > >    client use cases like Android,=
 its apps parse configuration files
> > > > > > > > > > > > > > > > > > > > >    and store the data in heap (an=
on); for server use cases like MySQL,
> > > > > > > > > > > > > > > > > > > > >    it reads from InnoDB files and=
 holds the cached data for tables in
> > > > > > > > > > > > > > > > > > > > >    buffer pools (anon).
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > However, the oldest generation ca=
n be very short lived, and if so, it
> > > > > > > > > > > > > > > > > > > > > doesn't provide the PID controlle=
r with enough time to respond to a
> > > > > > > > > > > > > > > > > > > > > surge of refaults. (Note that the=
 PID controller uses weighted
> > > > > > > > > > > > > > > > > > > > > refaults and those from evicted g=
enerations only take a half of the
> > > > > > > > > > > > > > > > > > > > > whole weight.) In other words, fo=
r a short lived generation, the
> > > > > > > > > > > > > > > > > > > > > moving average smooths out the sp=
ike quickly.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > To fix the problem:
> > > > > > > > > > > > > > > > > > > > > 1. For folios that are already on=
 LRU, if they can be beyond the
> > > > > > > > > > > > > > > > > > > > >    tracking range of tiers, i.e.,=
 five accesses through file
> > > > > > > > > > > > > > > > > > > > >    descriptors, move them to the =
second oldest generation to give them
> > > > > > > > > > > > > > > > > > > > >    more time to age. (Note that t=
iers are used by the PID controller
> > > > > > > > > > > > > > > > > > > > >    to statistically determine whe=
ther folios accessed multiple times
> > > > > > > > > > > > > > > > > > > > >    through file descriptors are w=
orth protecting.)
> > > > > > > > > > > > > > > > > > > > > 2. When adding unmapped folios to=
 LRU, adjust the placement of them so
> > > > > > > > > > > > > > > > > > > > >    that they are not too close to=
 the tail. The effect of this is
> > > > > > > > > > > > > > > > > > > > >    similar to the above.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > On Android, launching 55 apps seq=
uentially:
> > > > > > > > > > > > > > > > > > > > >                            Before=
     After      Change
> > > > > > > > > > > > > > > > > > > > >   workingset_refault_anon  256410=
24   25598972   0%
> > > > > > > > > > > > > > > > > > > > >   workingset_refault_file  115016=
834  106178438  -8%
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Hi Yu,
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Thanks you for your amazing works o=
n MGLRU.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > I believe this is the similar issue=
 I was trying to resolve previously:
> > > > > > > > > > > > > > > > > > > > https://lwn.net/Articles/945266/
> > > > > > > > > > > > > > > > > > > > The idea is to use refault distance=
 to decide if the page should be
> > > > > > > > > > > > > > > > > > > > place in oldest generation or some =
other gen, which per my test,
> > > > > > > > > > > > > > > > > > > > worked very well, and we have been =
using refault distance for MGLRU in
> > > > > > > > > > > > > > > > > > > > multiple workloads.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > There are a few issues left in my p=
revious RFC series, like anon pages
> > > > > > > > > > > > > > > > > > > > in MGLRU shouldn't be considered, I=
 wanted to collect feedback or test
> > > > > > > > > > > > > > > > > > > > cases, but unfortunately it seems d=
idn't get too much attention
> > > > > > > > > > > > > > > > > > > > upstream.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > I think both this patch and my prev=
ious series are for solving the
> > > > > > > > > > > > > > > > > > > > file pages underpertected issue, an=
d I did a quick test using this
> > > > > > > > > > > > > > > > > > > > series, for mongodb test, refault d=
istance seems still a better
> > > > > > > > > > > > > > > > > > > > solution (I'm not saying these two =
optimization are mutually exclusive
> > > > > > > > > > > > > > > > > > > > though, just they do have some conf=
licts in implementation and solving
> > > > > > > > > > > > > > > > > > > > similar problem):
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Previous result:
> > > > > > > > > > > > > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > > > > > > > > > > > > > > > > > Execution Results after 905 seconds
> > > > > > > > > > > > > > > > > > > > -----------------------------------=
-------------------------------
> > > > > > > > > > > > > > > > > > > >                   Executed        T=
ime (=C2=B5s)       Rate
> > > > > > > > > > > > > > > > > > > >   STOCK_LEVEL     2542            2=
7121571486.2   0.09 txn/s
> > > > > > > > > > > > > > > > > > > > -----------------------------------=
-------------------------------
> > > > > > > > > > > > > > > > > > > >   TOTAL           2542            2=
7121571486.2   0.09 txn/s
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > This patch:
> > > > > > > > > > > > > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > > > > > > > > > > > > > > > > > Execution Results after 900 seconds
> > > > > > > > > > > > > > > > > > > > -----------------------------------=
-------------------------------
> > > > > > > > > > > > > > > > > > > >                   Executed        T=
ime (=C2=B5s)       Rate
> > > > > > > > > > > > > > > > > > > >   STOCK_LEVEL     1594            2=
7061522574.4   0.06 txn/s
> > > > > > > > > > > > > > > > > > > > -----------------------------------=
-------------------------------
> > > > > > > > > > > > > > > > > > > >   TOTAL           1594            2=
7061522574.4   0.06 txn/s
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Unpatched version is always around =
~500.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Thanks for the test results!
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > I think there are a few points here=
:
> > > > > > > > > > > > > > > > > > > > - Refault distance make use of page=
 shadow so it can better
> > > > > > > > > > > > > > > > > > > > distinguish evicted pages of differ=
ent access pattern (re-access
> > > > > > > > > > > > > > > > > > > > distance).
> > > > > > > > > > > > > > > > > > > > - Throttled refault distance can he=
lp hold part of workingset when
> > > > > > > > > > > > > > > > > > > > memory is too small to hold the who=
le workingset.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > So maybe part of this patch and the=
 bits of previous series can be
> > > > > > > > > > > > > > > > > > > > combined to work better on this iss=
ue, how do you think?
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > I'll try to find some time this week =
to look at your RFC. It'd be a
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Hi Yu,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > I'm working on V4 of the RFC now, which j=
ust update some comments, and
> > > > > > > > > > > > > > > > > skip anon page re-activation in refault p=
ath for mglru which was not
> > > > > > > > > > > > > > > > > very helpful, only some tiny adjustment.
> > > > > > > > > > > > > > > > > And I found it easier to test with fio, u=
sing following test script:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > #!/bin/bash
> > > > > > > > > > > > > > > > > swapoff -a
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > modprobe brd rd_nr=3D1 rd_size=3D16777216
> > > > > > > > > > > > > > > > > mkfs.ext4 /dev/ram0
> > > > > > > > > > > > > > > > > mount /dev/ram0 /mnt
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > mkdir -p /sys/fs/cgroup/benchmark
> > > > > > > > > > > > > > > > > cd /sys/fs/cgroup/benchmark
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > echo 4G > memory.max
> > > > > > > > > > > > > > > > > echo $$ > cgroup.procs
> > > > > > > > > > > > > > > > > echo 3 > /proc/sys/vm/drop_caches
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > fio -name=3Dmglru --numjobs=3D12 --direct=
ory=3D/mnt --size=3D1024m \
> > > > > > > > > > > > > > > > >           --buffered=3D1 --ioengine=3Dio_=
uring --iodepth=3D128 \
> > > > > > > > > > > > > > > > >           --iodepth_batch_submit=3D32 --i=
odepth_batch_complete=3D32 \
> > > > > > > > > > > > > > > > >           --rw=3Drandread --random_distri=
bution=3Dzipf:0.5 --norandommap \
> > > > > > > > > > > > > > > > >           --time_based --ramp_time=3D5m -=
-runtime=3D5m --group_reporting
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > zipf:0.5 is used here to simulate a cache=
d read with slight bias
> > > > > > > > > > > > > > > > > towards certain pages.
> > > > > > > > > > > > > > > > > Unpatched 6.7-rc4:
> > > > > > > > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > > > > > > > >    READ: bw=3D6548MiB/s (6866MB/s), 6548M=
iB/s-6548MiB/s
> > > > > > > > > > > > > > > > > (6866MB/s-6866MB/s), io=3D1918GiB (2060GB=
), run=3D300001-300001msec
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Patched with RFC v4:
> > > > > > > > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > > > > > > > >    READ: bw=3D7270MiB/s (7623MB/s), 7270M=
iB/s-7270MiB/s
> > > > > > > > > > > > > > > > > (7623MB/s-7623MB/s), io=3D2130GiB (2287GB=
), run=3D300001-300001msec
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Patched with this series:
> > > > > > > > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > > > > > > > >    READ: bw=3D7098MiB/s (7442MB/s), 7098M=
iB/s-7098MiB/s
> > > > > > > > > > > > > > > > > (7442MB/s-7442MB/s), io=3D2079GiB (2233GB=
), run=3D300002-300002msec
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > MGLRU off:
> > > > > > > > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > > > > > > > >    READ: bw=3D6525MiB/s (6842MB/s), 6525M=
iB/s-6525MiB/s
> > > > > > > > > > > > > > > > > (6842MB/s-6842MB/s), io=3D1912GiB (2052GB=
), run=3D300002-300002msec
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > - If I change zipf:0.5 to random:
> > > > > > > > > > > > > > > > > Unpatched 6.7-rc4:
> > > > > > > > > > > > > > > > > Patched with this series:
> > > > > > > > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > > > > > > > >    READ: bw=3D5975MiB/s (6265MB/s), 5975M=
iB/s-5975MiB/s
> > > > > > > > > > > > > > > > > (6265MB/s-6265MB/s), io=3D1750GiB (1879GB=
), run=3D300002-300002msec
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Patched with RFC v4:
> > > > > > > > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > > > > > > > >    READ: bw=3D5987MiB/s (6278MB/s), 5987M=
iB/s-5987MiB/s
> > > > > > > > > > > > > > > > > (6278MB/s-6278MB/s), io=3D1754GiB (1883GB=
), run=3D300001-300001msec
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Patched with this series:
> > > > > > > > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > > > > > > > >    READ: bw=3D5839MiB/s (6123MB/s), 5839M=
iB/s-5839MiB/s
> > > > > > > > > > > > > > > > > (6123MB/s-6123MB/s), io=3D1711GiB (1837GB=
), run=3D300001-300001msec
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > MGLRU off:
> > > > > > > > > > > > > > > > > Run status group 0 (all jobs):
> > > > > > > > > > > > > > > > >    READ: bw=3D5689MiB/s (5965MB/s), 5689M=
iB/s-5689MiB/s
> > > > > > > > > > > > > > > > > (5965MB/s-5965MB/s), io=3D1667GiB (1790GB=
), run=3D300003-300003msec
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > fio uses ramdisk so LRU accuracy will hav=
e smaller impact. The Mongodb
> > > > > > > > > > > > > > > > > test I provided before uses a SATA SSD so=
 it will have a much higher
> > > > > > > > > > > > > > > > > impact. I'll provides a script to setup t=
he test case and run it, it's
> > > > > > > > > > > > > > > > > more complex to setup than fio since invo=
lving setting up multiple
> > > > > > > > > > > > > > > > > replicas and auth and hundreds of GB of t=
est fixtures, I'm currently
> > > > > > > > > > > > > > > > > occupied by some other tasks but will try=
 best to send them out as
> > > > > > > > > > > > > > > > > soon as possible.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Thanks! Apparently your RFC did show better=
 IOPS with both access
> > > > > > > > > > > > > > > > patterns, which was a surprise to me becaus=
e it had higher refaults
> > > > > > > > > > > > > > > > and usually higher refautls result in worse=
 performance.
> > > > > > > > > > > >
> > > > > > > > > > > > And thanks for providing the refaults I requested f=
or -- your data
> > > > > > > > > > > > below confirms what I mentioned above:
> > > > > > > > > > > >
> > > > > > > > > > > > For fio:
> > > > > > > > > > > >                            Your RFC   This series  =
 Change
> > > > > > > > > > > >   workingset_refault_file  628192729  596790506    =
 -5%
> > > > > > > > > > > >   IOPS                     1862k      1830k        =
 -2%
> > > > > > > > > > > >
> > > > > > > > > > > > For MongoDB:
> > > > > > > > > > > >                            Your RFC   This series  =
 Change
> > > > > > > > > > > >   workingset_refault_anon  10512      35277        =
 +30%
> > > > > > > > > > > >   workingset_refault_file  22751782   20335355     =
 -11%
> > > > > > > > > > > >   total                    22762294   20370632     =
 -11%
> > > > > > > > > > > >   TPS                      0.09       0.06         =
 -33%
> > > > > > > > > > > >
> > > > > > > > > > > > For MongoDB, this series should be a big win (but a=
pparently it's not),
> > > > > > > > > > > > especially when using zram, since an anon refault s=
hould be a lot
> > > > > > > > > > > > cheaper than a file refault.
> > > > > > > > > > > >
> > > > > > > > > > > > So, I'm baffled...
> > > > > > > > > > > >
> > > > > > > > > > > > One important detail I forgot to mention: based on =
your data from
> > > > > > > > > > > > lru_gen_full, I think there is another difference b=
etween our Kconfigs:
> > > > > > > > > > > >
> > > > > > > > > > > >                   Your Kconfig  My Kconfig  Max pos=
sible
> > > > > > > > > > > >   LRU_REFS_WIDTH  1             2           2
> > > > > > > > > > >
> > > > > > > > > > > Hi Yu,
> > > > > > > > > > >
> > > > > > > > > > > Thanks for the info, my fault, I forgot to update my =
config as I was
> > > > > > > > > > > testing some other features.
> > > > > > > > > > > Buf after I changed LRU_REFS_WIDTH to 2 by disabling =
IDLE_PAGE, thing
> > > > > > > > > > > got much worse for MongoDB test:
> > > > > > > > > > >
> > > > > > > > > > > With LRU_REFS_WIDTH =3D=3D 2:
> > > > > > > > > > >
> > > > > > > > > > > This patch:
> > > > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > > > Execution Results after 919 seconds
> > > > > > > > > > > -----------------------------------------------------=
-------------
> > > > > > > > > > >                   Executed        Time (=C2=B5s)     =
  Rate
> > > > > > > > > > >   STOCK_LEVEL     488             27598136201.9   0.0=
2 txn/s
> > > > > > > > > > > -----------------------------------------------------=
-------------
> > > > > > > > > > >   TOTAL           488             27598136201.9   0.0=
2 txn/s
> > > > > > > > > > >
> > > > > > > > > > > memcg    86 /system.slice/docker-1c3a90be9f0a072f5719=
332419550cd0e1455f2cd5863bc2780ca4d3f913ece5.scope
> > > > > > > > > > >  node     0
> > > > > > > > > > >           1     948187          0x          0x
> > > > > > > > > > >                      0          0           0        =
   0           0
> > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > >                      1          0           0        =
   0           0
> > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > >                      2          0           0        =
   0           0
> > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > >                      3          0           0        =
   0           0
> > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > >                                 0           0        =
   0           0
> > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > >           2     948187          0     6051788=C2=B7
> > > > > > > > > > >                      0          0r          0e       =
   0p      11916r
> > > > > > > > > > >      66442e          0p
> > > > > > > > > > >                      1          0r          0e       =
   0p        903r
> > > > > > > > > > >      16888e          0p
> > > > > > > > > > >                      2          0r          0e       =
   0p        459r
> > > > > > > > > > >       9764e          0p
> > > > > > > > > > >                      3          0r          0e       =
   0p          0r
> > > > > > > > > > >          0e       2874p
> > > > > > > > > > >                                 0           0        =
   0           0
> > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > >           3     948187    1353160        6351=C2=B7
> > > > > > > > > > >                      0          0           0        =
   0           0
> > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > >                      1          0           0        =
   0           0
> > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > >                      2          0           0        =
   0           0
> > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > >                      3          0           0        =
   0           0
> > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > >                                 0           0        =
   0           0
> > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > >           4      73045      23573          12=C2=B7
> > > > > > > > > > >                      0          0R          0T       =
   0     3498607R
> > > > > > > > > > >    4868605T          0=C2=B7
> > > > > > > > > > >                      1          0R          0T       =
   0     3012246R
> > > > > > > > > > >    3270261T          0=C2=B7
> > > > > > > > > > >                      2          0R          0T       =
   0     2498608R
> > > > > > > > > > >    2839104T          0=C2=B7
> > > > > > > > > > >                      3          0R          0T       =
   0           0R
> > > > > > > > > > >    1983947T          0=C2=B7
> > > > > > > > > > >                           1486579L          0O    138=
0614Y       2945N
> > > > > > > > > > >       2945F       2734A
> > > > > > > > > > >
> > > > > > > > > > > workingset_refault_anon 0
> > > > > > > > > > > workingset_refault_file 18130598
> > > > > > > > > > >
> > > > > > > > > > >               total        used        free      shar=
ed  buff/cache   available
> > > > > > > > > > > Mem:          31978        6705         312          =
20       24960       24786
> > > > > > > > > > > Swap:         31977           4       31973
> > > > > > > > > > >
> > > > > > > > > > > RFC:
> > > > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > > > Execution Results after 908 seconds
> > > > > > > > > > > -----------------------------------------------------=
-------------
> > > > > > > > > > >                   Executed        Time (=C2=B5s)     =
  Rate
> > > > > > > > > > >   STOCK_LEVEL     2252            27159962888.2   0.0=
8 txn/s
> > > > > > > > > > > -----------------------------------------------------=
-------------
> > > > > > > > > > >   TOTAL           2252            27159962888.2   0.0=
8 txn/s
> > > > > > > > > > >
> > > > > > > > > > > workingset_refault_anon 22585
> > > > > > > > > > > workingset_refault_file 22715256
> > > > > > > > > > >
> > > > > > > > > > > memcg    66 /system.slice/docker-0989446ff78106e32d3f=
400a0cf371c9a703281bded86d6d6bb1af706ebb25da.scope
> > > > > > > > > > >  node     0
> > > > > > > > > > >          22     563007       2274     1198225=C2=B7
> > > > > > > > > > >                      0          0r          1e       =
   0p          0r
> > > > > > > > > > >     697076e          0p
> > > > > > > > > > >                      1          0r          0e       =
   0p          0r
> > > > > > > > > > >          0e     325661p
> > > > > > > > > > >                      2          0r          0e       =
   0p          0r
> > > > > > > > > > >          0e     888728p
> > > > > > > > > > >                      3          0r          0e       =
   0p          0r
> > > > > > > > > > >          0e    3602238p
> > > > > > > > > > >                                 0           0        =
   0           0
> > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > >          23     532222       7525     4948747=C2=B7
> > > > > > > > > > >                      0          0           0        =
   0           0
> > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > >                      1          0           0        =
   0           0
> > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > >                      2          0           0        =
   0           0
> > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > >                      3          0           0        =
   0           0
> > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > >                                 0           0        =
   0           0
> > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > >          24     500367    1214667        3292=C2=B7
> > > > > > > > > > >                      0          0           0        =
   0           0
> > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > >                      1          0           0        =
   0           0
> > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > >                      2          0           0        =
   0           0
> > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > >                      3          0           0        =
   0           0
> > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > >                                 0           0        =
   0           0
> > > > > > > > > > >          0           0=C2=B7
> > > > > > > > > > >          25     469692      40797         466=C2=B7
> > > > > > > > > > >                      0          0R        271T       =
   0           0R
> > > > > > > > > > >    1162165T          0=C2=B7
> > > > > > > > > > >                      1          0R          0T       =
   0      774028R
> > > > > > > > > > >    1205332T          0=C2=B7
> > > > > > > > > > >                      2          0R          0T       =
   0           0R
> > > > > > > > > > >     932484T          0=C2=B7
> > > > > > > > > > >                      3          0R          1T       =
   0           0R
> > > > > > > > > > >    4252158T          0=C2=B7
> > > > > > > > > > >                          25178380L     156515O   2395=
3602Y      59234N
> > > > > > > > > > >      49391F      48664A
> > > > > > > > > > >
> > > > > > > > > > >               total        used        free      shar=
ed  buff/cache   available
> > > > > > > > > > > Mem:          31978        6968         338          =
 5       24671       24555
> > > > > > > > > > > Swap:         31977        1533       30444
> > > > > > > > > > >
> > > > > > > > > > > Using same mongodb config (a 3 replica cluster using =
the same config):
> > > > > > > > > > > {
> > > > > > > > > > >     "net": {
> > > > > > > > > > >         "bindIpAll": true,
> > > > > > > > > > >         "ipv6": false,
> > > > > > > > > > >         "maxIncomingConnections": 10000,
> > > > > > > > > > >     },
> > > > > > > > > > >     "setParameter": {
> > > > > > > > > > >         "disabledSecureAllocatorDomains": "*"
> > > > > > > > > > >     },
> > > > > > > > > > >     "replication": {
> > > > > > > > > > >         "oplogSizeMB": 10480,
> > > > > > > > > > >         "replSetName": "issa-tpcc_0"
> > > > > > > > > > >     },
> > > > > > > > > > >     "security": {
> > > > > > > > > > >         "keyFile": "/data/db/keyfile"
> > > > > > > > > > >     },
> > > > > > > > > > >     "storage": {
> > > > > > > > > > >         "dbPath": "/data/db/",
> > > > > > > > > > >         "syncPeriodSecs": 60,
> > > > > > > > > > >         "directoryPerDB": true,
> > > > > > > > > > >         "wiredTiger": {
> > > > > > > > > > >             "engineConfig": {
> > > > > > > > > > >                 "cacheSizeGB": 5
> > > > > > > > > > >             }
> > > > > > > > > > >         }
> > > > > > > > > > >     },
> > > > > > > > > > >     "systemLog": {
> > > > > > > > > > >         "destination": "file",
> > > > > > > > > > >         "logAppend": true,
> > > > > > > > > > >         "logRotate": "rename",
> > > > > > > > > > >         "path": "/data/db/mongod.log",
> > > > > > > > > > >         "verbosity": 0
> > > > > > > > > > >     }
> > > > > > > > > > > }
> > > > > > > > > > >
> > > > > > > > > > > The test environment have 32g memory and 16 core.
> > > > > > > > > > >
> > > > > > > > > > > Per my analyze, the access pattern for the mongodb te=
st is that page
> > > > > > > > > > > will be re-access long after it's evicted so PID cont=
roller won't
> > > > > > > > > > > protect higher tier. That RFC will make use of the lo=
ng existing
> > > > > > > > > > > shadow to do feedback to PID/Gen so the result will b=
e much better.
> > > > > > > > > > > Still need more adjusting though, will try to do a re=
base on top of
> > > > > > > > > > > mm-unstable which includes your patch.
> > > > > > > > > > >
> > > > > > > > > > > I've no idea why the workingset_refault_* is higher i=
n the better
> > > > > > > > > > > case, this a clearly an IO bound workload, Memory and=
 IO is busy while
> > > > > > > > > > > CPU is not full...
> > > > > > > > > > >
> > > > > > > > > > > I've uploaded my local reproducer here:
> > > > > > > > > > > https://github.com/ryncsn/emm-test-project/tree/maste=
r/mongo-cluster
> > > > > > > > > > > https://github.com/ryncsn/py-tpcc
> > > > > > > > > >
> > > > > > > > > > Thanks for the repos -- I'm trying them right now. Whic=
h MongoDB
> > > > > > > > > > version did you use? setup.sh didn't seem to install it=
.
> > > > > > > > > >
> > > > > > > > > > Also do you have a QEMU image? It'd be a lot easier for=
 me to
> > > > > > > > > > duplicate the exact environment by looking into it.
> > > > > > > > >
> > > > > > > > > I ended up using docker.io/mongodb/mongodb-community-serv=
er:latest,
> > > > > > > > > and it's not working:
> > > > > > > > >
> > > > > > > > > # docker exec -it mongo-r1 mongosh --eval \
> > > > > > > > > '"rs.initiate({
> > > > > > > > >     _id: "issa-tpcc_0",
> > > > > > > > >     members: [
> > > > > > > > >       {_id: 0, host: "mongo-r1"},
> > > > > > > > >       {_id: 1, host: "mongo-r2"},
> > > > > > > > >       {_id: 2, host: "mongo-r3"}
> > > > > > > > >     ]
> > > > > > > > > })"'
> > > > > > > > > Emulate Docker CLI using podman. Create /etc/containers/n=
odocker to quiet msg.
> > > > > > > > > Error: can only create exec sessions on running container=
s: container
> > > > > > > > > state improper
> > > > > > > >
> > > > > > > > Hi Yu,
> > > > > > > >
> > > > > > > > I've updated the test repo:
> > > > > > > > https://github.com/ryncsn/emm-test-project/tree/master/mong=
o-cluster
> > > > > > > >
> > > > > > > > I've tested it on top of latest Fedora Cloud Image 39 and i=
t worked
> > > > > > > > well for me, the README now contains detailed and not hard =
to follow
> > > > > > > > steps to reproduce this test.
> > > > > > >
> > > > > > > Thanks. I was following the instructions down to the letter a=
nd it
> > > > > > > fell apart again at line 46 (./tpcc.py).
> > > > > >
> > > > > > I think you just broke it by
> > > > > > https://github.com/ryncsn/py-tpcc/commit/7b9b380d636cb84faa5b11=
b5562e531f924eeb7e
> > > > > >
> > > > > > (But it's also possible you actually wanted me to use this late=
st
> > > > > > commit but forgot to account for it in your instructions.)
> > > > > >
> > > > > > > Were you able to successfully run the benchmark on a fresh VM=
 by
> > > > > > > following the instructions? If not, I'd appreciate it if you =
could do
> > > > > > > so and document all the missing steps.
> > > > >
> > > > > Ah, you are right, I attempted to convert it to Python3 but found=
 it
> > > > > only brought more trouble, so I gave up and the instruction is st=
ill
> > > > > using Python2. However I accidentally pushed the WIP python3 conv=
ert
> > > > > commit... I've reset the repo to
> > > > > https://github.com/ryncsn/py-tpcc/commit/86e862c5cf3b2d1f51e02977=
42fa837c7a99ebf8,
> > > > > this is working well. Sorry for the inconvenient.
> > > >
> > > > Thanks -- I was able to reproduce results similar to yours.
> > > >
> > >
> > > Hi Yu,
> > >
> > > Thanks for the testing, and merry xmas.
> > >
> > > > It turned out the mystery (fewer refaults but worse performance) wa=
s caused by
> > > >     13.89%    13.89%  kswapd0  [kernel.vmlinux]  [k]
> > > > __list_del_entry_valid_or_report
> > >
> > > I'm not sure about this, if the task is CPU bounded, this could
> > > explain. But it's not, the performance gap is larger when tested on
> > > slow IO device.
> > >
> > > The iostat output during my test run:
> > > avg-cpu:  %user   %nice %system %iowait  %steal   %idle
> > >            7.40    0.00    2.42   83.37    0.00    6.80
> > > Device            r/s     w/s     rkB/s     wkB/s   rrqm/s   wrqm/s
> > > %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
> > > vda             35.00    0.80    167.60     17.20     6.90     3.50
> > > 16.47  81.40    0.47    1.62   0.02     4.79    21.50   0.63   2.27
> > > vdb           5999.30    4.80 104433.60     84.00     0.00     8.30
> > > 0.00  63.36    6.54    1.31  39.25    17.41    17.50   0.17 100.00
> > > zram0            0.00    0.00      0.00      0.00     0.00     0.00
> > > 0.00   0.00    0.00    0.00   0.00     0.00     0.00   0.00   0.00
> >
> > I ran the benchmark on the slowest bare metal I have that roughly
> > matches your CPU/DRAM configurations (ThinkPad P1 G4
> > https://support.lenovo.com/us/en/solutions/pd031426).
> >
> > But it seems you used a VM (vda/vdb) -- I never run performance
> > benchmarks in VMs because the host and hypervisor can complicate
> > things, for example, in this case, is it possible the host page cache
> > cached your disk image containing the database files?
> >
> > > You can see CPU is waiting for IO, %user is always around 10%.
> > > The hotspot you posted only take up 13.89% of the runtime, which
> > > shouldn't cause so much performance drop.
> > >
> > > >
> > > > Apparently Fedora has CONFIG_DEBUG_LIST=3Dy by default, and after I
> > > > turned it off (the only change I made), this series showed better T=
PS
> > > > (I used"--duration=3D10800" for more reliable results):
> > > >                          v6.7-rc6   RFC [1]    change
> > > > total txns               25024      24672      +1%
> > > > workingset_refault_anon  573668     680248     -16%
> > > > workingset_refault_file  260631976  265808452  -2%
> > >
> > > I have disabled CONFIG_DEBUG_LIST when doing performance comparison t=
est.
>
> Also I'd suggest we both use the same distro you shared with me and
> the default .config except CONFIG_DEBUG_LIST=3Dn, and v6.7-rc6 for now.
>
> (I'm attaching the default .config based on /boot/config-6.5.6-300.fc39.x=
86_64.)
>

Hi Yu

I've been adapting and testing the refault distance series based on
latest 6.7. Also I found a serious bug in my previous V3, so I updated
it here with some importance changes (using a seperate refault
distance model, instead of glueing to active/inactive model):
https://github.com/ryncsn/linux/commits/kasong/devel/refault-distance-2024-=
1/

So far I can conclude that previous result is not caused by host
cache, I setup a baremetal test environment, strictly using your
config, I gathered some data (I also updated the refault distance
patch series, updated version in link above, and also the baremetal
hava a fast NVME so the performance gap wasn't so large but still
stably observable):

With latest 6.7 (Your config):
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Execution Results after 905 seconds
------------------------------------------------------------------
                  Executed        Time (=C2=B5s)       Rate
  STOCK_LEVEL     4025            27162035181.5   0.15 txn/s
------------------------------------------------------------------
  TOTAL           4025            27162035181.5   0.15 txn/s

vmstat:
workingset_nodes 82996
workingset_refault_anon 269371
workingset_refault_file 37671044
workingset_activate_anon 121061
workingset_activate_file 8927227
workingset_restore_anon 121061
workingset_restore_file 2578269
workingset_nodereclaim 62394

lru_gen_full:
memcg    67 /machine.slice/libpod-38b33777db34724cf8edfbef1ac2e4fd0621f1415=
1e241bbf1430d397d3dee51.scope/container
 node     0
         34      60565      21248     1254331
                     0          0r          0e          0p     121186r
    169948e          0p
                     1          0r          0e          0p     156224r
    222553e          0p
                     2          0r          0e          0p          0r
         0e    4227858p
                     3          0r          0e          0p          0r
         0e          0p
                                0           0           0           0
         0           0
         35      41132     714504     4300280
                     0          0           0           0           0
         0           0
                     1          0           0           0           0
         0           0
                     2          0           0           0           0
         0           0
                     3          0           0           0           0
         0           0
                                0           0           0           0
         0           0
         36      20586     473476        2105
                     0          0           0           0           0
         0           0
                     1          0           0           0           0
         0           0
                     2          0           0           0           0
         0           0
                     3          0           0           0           0
         0           0
                                0           0           0           0
         0           0
         37       2035        817         876
                     0       6647R       9116T          0      166836R
    871850T          0
                     1          0R          0T          0      110807R
    296447T          0
                     2          0R        268T          0           0R
   4655276T          0
                     3          0R          0T          0           0R
         0T          0
                         12510062L     639646O   11048666Y      45512N
     24520F      23613A
iostat:
avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          76.29    0.00   12.09    3.50    1.44    6.69

Device             tps    kB_read/s    kB_wrtn/s    kB_dscd/s
kB_read    kB_wrtn    kB_dscd
dm-0             16.12       684.50        36.93         0.00
649996      35070          0
dm-1              0.05         1.10         0.00         0.00
1044          0          0
nvme0n1      16.47       700.22        39.09         0.00     664922
   37118          0
nvme1n1        4905.93    205287.92      1030.70         0.00
194939353     978740          0
zram0          4440.17      5356.90     12404.81         0.00
5086856   11779480          0

free -m:
               total        used        free      shared  buff/cache   avai=
lable
Mem:           31830        9475         403           0       21951       =
21918
Swap:          31829        6500       25329

With latest refault distance series (Your config):
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Execution Results after 902 seconds
------------------------------------------------------------------
                  Executed        Time (=C2=B5s)       Rate
  STOCK_LEVEL     4260            27065448172.8   0.16 txn/s
------------------------------------------------------------------
  TOTAL           4260            27065448172.8   0.16 txn/s

workingset_nodes 113824
workingset_refault_anon 293426
workingset_refault_file 42700484
workingset_activate_anon 0
workingset_activate_file 13410174
workingset_restore_anon 289106
workingset_restore_file 5592042
workingset_nodereclaim 33249

memcg    67 /machine.slice/libpod-8eff6b7b65e34fe0497ff5c0c88c750f6896c43a0=
6bb26e8cd6470de596be76e.scope/container
 node     0
         15     261222     266350       65081
                     0          0r          0e          0p     185212r
   2314329e          0p
                     1          0r          0e          0p      40887r
    710312e          0p
                     2          0r          0e          0p          0r
         0e    5026031p
                     3          0r          0e          0p          0r
         0e          0p
                                0           0           0           0
         0           0
         16     199341     267661     5034442
                     0          0           0           0           0
         0           0
                     1          0           0           0           0
         0           0
                     2          0           0           0           0
         0           0
                     3          0           0           0           0
         0           0
                                0           0           0           0
         0           0
         17     120655     547852         592
                     0          0           0           0           0
         0           0
                     1          0           0           0           0
         0           0
                     2          0           0           0           0
         0           0
                     3          0           0           0           0
         0           0
                                0           0           0           0
         0           0
         18      55172     127769        3855
                     0       1910R       2975T          0     1894614R
   4375361T          0
                     1          0R          0T          0     2099208R
   2861460T          0
                     2          0R         27T          0      446000R
   5569781T          0
                     3          0R          0T          0           0R
         0T          0
                          2817512L      35421O    2579377Y      10452N
      5517F       5414A

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          76.34    0.00   11.25    4.22    1.29    6.90

Device             tps    kB_read/s    kB_wrtn/s    kB_dscd/s
kB_read    kB_wrtn    kB_dscd
dm-0             12.85       563.18        30.75         0.00
532390      29070          0
dm-1              0.05         1.10         0.00         0.00
1044          0          0
nvme0n1          13.22       578.97        32.92         0.00
547315      31119          0
nvme1n1        5384.11    229164.12      1038.95         0.00
216635713     982152          0
zram0          3590.88      4730.84      9633.71         0.00
4472204    9107032          0

               total        used        free      shared  buff/cache   avai=
lable
Mem:           31830       10854         520           0       20455       =
20541
Swap:          31829        4508       27321

You see actually refault distance is now protecting more anon page,
total IO on ZRAM is lower, It's mostly CPU bound, and NVME is fast
enough, and result in a better performance.

Things get more interesting if I disable page idle flag (so refs bits
is extended, in your config, refs bit is only one bit, so it maybe
overprotect file pages):

Latest 6.7 (You config with page idle flag disabled):
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Execution Results after 904 seconds
------------------------------------------------------------------
                  Executed        Time (=C2=B5s)       Rate
  STOCK_LEVEL     4016            27122163703.9   0.15 txn/s
------------------------------------------------------------------
  TOTAL           4016            27122163703.9   0.15 txn/s

workingset_nodes 99637
workingset_refault_anon 309548
workingset_refault_file 45896663
workingset_activate_anon 129401
workingset_activate_file 18461236
workingset_restore_anon 129400
workingset_restore_file 4963707
workingset_nodereclaim 43970

memcg    67 /machine.slice/libpod-7546463bd2b257a9b799817ca11bee1389d7deec2=
0032529098520a89a207d7e.scope/container
 node     0
         27     103004     328070      269733
                     0          0r          0e          0p     509949r
   1957117e          0p
                     1          0r          0e          0p     141642r
    319695e          0p
                     2          0r          0e          0p     777835r
    793518e          0p
                     3          0r          0e          0p          0r
         0e    4333835p
                                0           0           0           0
         0           0
         28      82361      24748     5192182
                     0          0           0           0           0
         0           0
                     1          0           0           0           0
         0           0
                     2          0           0           0           0
         0           0
                     3          0           0           0           0
         0           0
                                0           0           0           0
         0           0
         29      57025     786386        5681
                     0          0           0           0           0
         0           0
                     1          0           0           0           0
         0           0
                     2          0           0           0           0
         0           0
                     3          0           0           0           0
         0           0
                                0           0           0           0
         0           0
         30      18619      76289        1273
                     0       4295R       8888T          0      222326R
   1044601T          0
                     1          0R          0T          0      117646R
    301735T          0
                     2          0R          0T          0      433431R
    825516T          0
                     3          0R          1T          0           0R
   4076839T          0
                         13369819L     603360O   11981074Y      47388N
     26235F      25276A

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          74.90    0.00   11.96    4.92    1.62    6.60

Device             tps    kB_read/s    kB_wrtn/s    kB_dscd/s
kB_read    kB_wrtn    kB_dscd
dm-0             14.93       645.44        36.54         0.00
610150      34540          0
dm-1              0.05         1.10         0.00         0.00
1044          0          0
nvme0n1          15.30       661.23        38.71         0.00
625076      36589          0
nvme1n1        6352.42    240726.35      1036.47         0.00
227565845     979808          0
zram0          4189.65      4883.27     11876.36         0.00
4616304   11227080          0

               total        used        free      shared  buff/cache   avai=
lable
Mem:           31830        9529         509           0       21791       =
21867
Swap:          31829        6441       25388

Refault distance seriese (Your config with page idle flag disabled):
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Execution Results after 901 seconds
------------------------------------------------------------------
                  Executed        Time (=C2=B5s)       Rate
  STOCK_LEVEL     4268            27060267967.7   0.16 txn/s
------------------------------------------------------------------
  TOTAL           4268            27060267967.7   0.16 txn/s

workingset_nodes 115394
workingset_refault_anon 144774
workingset_refault_file 41055081
workingset_activate_anon 8
workingset_activate_file 13194460
workingset_restore_anon 144629
workingset_restore_file 187419
workingset_nodereclaim 19598

memcg    66 /machine.slice/libpod-4866051af817731602b37017b0e71feb2a8f2cbaa=
949f577e0444af01b4f3b0c.scope/container
 node     0
         12     213402      18054     1287510
                     0          0r          0e          0p          0r
     15755e          0p
                     1          0r          0e          0p          0r
      4771e          0p
                     2          0r          0e          0p        908r
      6810e          0p
                     3          0r          0e          0p          0r
         0e    3533888p
                                0           0           0           0
         0           0
         13     141209      10690     3571958
                     0          0           0           0           0
         0           0
                     1          0           0           0           0
         0           0
                     2          0           0           0           0
         0           0
                     3          0           0           0           0
         0           0
                                0           0           0           0
         0           0
         14      69327    1165064       34657
                     0          0           0           0           0
         0           0
                     1          0           0           0           0
         0           0
                     2          0           0           0           0
         0           0
                     3          0           0           0           0
         0           0
                                0           0           0           0
         0           0
         15       6404      21574        3363
                     0        953R       1773T          0     1263395R
   3816639T          0
                     1          0R          0T          0     1164069R
   1936973T          0
                     2          0R          0T          0      350041R
    409121T          0
                     3          0R          3T          0       12305R
   4767303T          0
                          3622197L      36916O    3338446Y      10409N
      7120F       6945A

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          75.79    0.00   10.68    3.91    1.18    8.44

Device             tps    kB_read/s    kB_wrtn/s    kB_dscd/s
kB_read    kB_wrtn    kB_dscd
dm-0             12.66       547.71        38.73         0.00
526782      37248          0
dm-1              0.05         1.09         0.00         0.00
1044          0          0
nvme0n1         13.02       563.23        40.86         0.00
541708      39297          0
nvme1n1       4916.00    217529.48      1018.04         0.00
209217677     979136          0
zram0          1744.90      1970.86      5009.75         0.00
1895556    4818328          0

               total        used        free      shared  buff/cache   avai=
lable
Mem:           31830       11713         485           0       19630       =
19684
Swap:          31829        2847       28982

And still refault distance series is better, and refault is also lower
for both anon/file pages.

------
I did some more test using MySQL and other workflow, no performance
drop observed so far.
And with a loop MongoDB test (keep running 900s test in loop) using my
previous VM env
(the SATA SSD vdb is using cache bypass so not a host cache issue here)
I found one thing interesting (refs bit is set to 2 in config):

Loop test using 6.7:
  STOCK_LEVEL     874             27246011368.3   0.03 txn/s
  STOCK_LEVEL     1533            27023181579.6   0.06 txn/s
  STOCK_LEVEL     1122            28044867987.6   0.04 txn/s
  STOCK_LEVEL     1032            27378070931.9   0.04 txn/s
  STOCK_LEVEL     1021            27612530579.1   0.04 txn/s
  STOCK_LEVEL     750             28076187896.3   0.03 txn/s
  STOCK_LEVEL     780             27519993034.8   0.03 txn/s
Refault stat here:
workingset_refault_anon 126369
workingset_refault_file 170389428
  STOCK_LEVEL     750             27464016123.5   0.03 txn/s
  STOCK_LEVEL     780             27529550313.0   0.03 txn/s
  STOCK_LEVEL     750             28296286486.1   0.03 txn/s
  STOCK_LEVEL     690             27504193850.3   0.03 txn/s
  STOCK_LEVEL     716             28089360754.5   0.03 txn/s
  STOCK_LEVEL     607             27852180474.3   0.02 txn/s
  STOCK_LEVEL     689             27703367075.4   0.02 txn/s
  STOCK_LEVEL     630             28184685482.7   0.02 txn/s
  STOCK_LEVEL     450             28667721196.2   0.02 txn/s
  STOCK_LEVEL     450             28047985314.4   0.02 txn/s
  STOCK_LEVEL     450             28125609857.3   0.02 txn/s
  STOCK_LEVEL     420             27393478488.0   0.02 txn/s
  STOCK_LEVEL     420             27435537312.3   0.02 txn/s
  STOCK_LEVEL     420             29060748699.2   0.01 txn/s
  STOCK_LEVEL     420             28155584095.2   0.01 txn/s
  STOCK_LEVEL     420             27888635407.0   0.02 txn/s
  STOCK_LEVEL     420             27307856858.5   0.02 txn/s
  STOCK_LEVEL     420             28842280889.0   0.01 txn/s
  STOCK_LEVEL     390             27640696814.1   0.01 txn/s
  STOCK_LEVEL     420             28471605716.7   0.01 txn/s
  STOCK_LEVEL     420             27648174237.5   0.02 txn/s
  STOCK_LEVEL     420             27848217938.7   0.02 txn/s
  STOCK_LEVEL     420             27344698602.2   0.02 txn/s
  STOCK_LEVEL     420             27046819537.2   0.02 txn/s
  STOCK_LEVEL     420             27855626843.2   0.02 txn/s
  STOCK_LEVEL     420             27971873627.9   0.02 txn/s
  STOCK_LEVEL     420             28007014046.4   0.01 txn/s
  STOCK_LEVEL     420             28445164626.1   0.01 txn/s
  STOCK_LEVEL     420             27902621006.5   0.02 txn/s
  STOCK_LEVEL     420             28282574433.3   0.01 txn/s
  STOCK_LEVEL     390             27161599608.7   0.01 txn/s

Using refault distance seriese:
  STOCK_LEVEL     2605            27120667462.8   0.10 txn/s
  STOCK_LEVEL     3000            27106854857.2   0.11 txn/s
  STOCK_LEVEL     2925            27066601064.4   0.11 txn/s
  STOCK_LEVEL     2757            27035248005.2   0.10 txn/s
  STOCK_LEVEL     1325            28053716046.8   0.05 txn/s
  STOCK_LEVEL     717             27455091366.3   0.03 txn/s
  STOCK_LEVEL     967             27404085208.2   0.04 txn/s
Refault stat here:
workingset_refault_anon 109337
workingset_refault_file 191249716
  STOCK_LEVEL     716             27448213557.2   0.03 txn/s
  STOCK_LEVEL     807             28607974517.8   0.03 txn/s
  STOCK_LEVEL     760             28081442513.2   0.03 txn/s
  STOCK_LEVEL     745             28594555797.6   0.03 txn/s
  STOCK_LEVEL     450             27999536348.3   0.02 txn/s
  STOCK_LEVEL     598             27095531895.4   0.02 txn/s
  STOCK_LEVEL     711             27623112841.1   0.03 txn/s
  STOCK_LEVEL     540             28358770820.6   0.02 txn/s
  STOCK_LEVEL     480             27734277554.5   0.02 txn/s
  STOCK_LEVEL     450             27313906125.3   0.02 txn/s
  STOCK_LEVEL     480             27487299100.4   0.02 txn/s
  STOCK_LEVEL     480             27804589683.5   0.02 txn/s
  STOCK_LEVEL     480             28242205820.8   0.02 txn/s
  STOCK_LEVEL     480             27540680102.3   0.02 txn/s
  STOCK_LEVEL     450             27428645816.8   0.02 txn/s
  STOCK_LEVEL     480             27946866129.2   0.02 txn/s
  STOCK_LEVEL     480             27266068262.3   0.02 txn/s
  STOCK_LEVEL     450             27267487051.5   0.02 txn/s
  STOCK_LEVEL     480             27896369224.8   0.02 txn/s
  STOCK_LEVEL     480             28784662706.1   0.02 txn/s
  STOCK_LEVEL     450             27179853217.8   0.02 txn/s
  STOCK_LEVEL     480             28170594101.7   0.02 txn/s
  STOCK_LEVEL     450             28084651341.0   0.02 txn/s
  STOCK_LEVEL     480             27901608868.6   0.02 txn/s
  STOCK_LEVEL     480             27323790886.6   0.02 txn/s
  STOCK_LEVEL     480             28891008895.4   0.02 txn/s
  STOCK_LEVEL     480             27964563148.0   0.02 txn/s
  STOCK_LEVEL     450             27942421198.4   0.02 txn/s
  STOCK_LEVEL     480             28833968825.8   0.02 txn/s
  STOCK_LEVEL     480             28090975437.9   0.02 txn/s
  STOCK_LEVEL     480             27915246877.4   0.02 txn/s

It seems the performance will drain as the test keep running (might be
caused by MongoDB anon usage rising or DB internal caching/logging),
that explains why for a long term test the performance gap seem to be
smaller. The VM have a poor IO performance so the test run speed is
much slower too, take a long time to warm up.

But I think it's clear that refault distance series will boost the
performance during warm up, and for long time workload it's also
looking better, especially for low IO performance machines.

I still can't explain about why workingset_refault is higher for the
better case in the VM environment... I can resetup/reboot/randomize
the test the the performance is same here. My guess is maybe related
to readahead or some kernel space IO path issue? The actual IO usage
is lower when refault distance series is applied.

I notices a slight performance regression (1 - 3%) for pure in-mem FIO
though, the "bulk series" I sent previous can help improve it.

There is a bug in my previous V3 that will cause PID controller to
lost control in long term (due to a bugged bit operation, my bad),
which I've fixed in link above, I can send out new series if you think
it's acceptable.

