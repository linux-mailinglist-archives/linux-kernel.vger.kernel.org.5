Return-Path: <linux-kernel+bounces-39056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FABC83CA50
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64ECE1C221AE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7B3131755;
	Thu, 25 Jan 2024 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOdaBr8p"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E0C745C6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706205126; cv=none; b=iCVuYtEC+tCyE9GulPhRd14Ntb5SSu/MEKtU7V/jPPCr1ib9Fdp+TaHDq3Kt/3S3QwdNz/KJ3P+veAT1xdNn3d+ZG4eIJrYyRi6/8al1coNvdBk3rqHttndwqxBIjs31fkXahDAJgCNu9L+JHy8BYW6QL2PxIrr4b33wCUvKXnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706205126; c=relaxed/simple;
	bh=vr/AyOXBh/PfRIcVKSypP8o7xVRseNU4jwIKCJkd2Vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1SvhVMJr43EXaWhvjZbyGhCyjEYuRMM2tLdilpilI47YN5mY/vTpOT+eXJ8T/nto326IQm4c5H+QRuJSYsWQIACfLTcnWMB5vOlq1gpDvpuIn+RRWiJZ0bARZxp2e6y0jJqv0bBcNiO3CGtLa8NdKCY1QGRZQvHhdDfQPu8ceM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOdaBr8p; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cf205dc075so25418831fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706205122; x=1706809922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58AAw59QVEkmC52O5LxYTi+CX/9Jh0etyAUz49wdjuc=;
        b=GOdaBr8pn9Cvvp48n+QQzlcK+1xC+KjSZtVQ9F91vBfbqCVFN99u8fWGUTYnfqCWSU
         nRzNwGLYl43d2W+5gFDjcIs6HjiBLA/b1Nk45LBfsZtoMv8ok3wWx5JlAT981xLCxpFa
         GvQB6oab+kocg3efoEIZpycrHY041xM7foYASjJ02fsCTkaRmRyA6IhPHeSLW5AyIDf4
         zhkOW2JB40YJFiEbgHrLOCDjE8oMo0jGp6eQrEn5ARHi+VfFdPsVKM599M3bTvhQEj1j
         AGzL59PlgzkD9sRW7oTQQhOSA7n+5emqBSNODUA/kF3j/uucH6Srxi4V4NadkegUv2Nr
         2iSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706205122; x=1706809922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58AAw59QVEkmC52O5LxYTi+CX/9Jh0etyAUz49wdjuc=;
        b=wNUrKtXRkLYaqe2IKyB1j5eioSfIqWixYtFC09SJ2MqCTsw8ulRBEtBHIvSZNsUwGs
         NtxLZEgkeFMKosgAAbVmzxatA8xFqPVLvi5xKXOQk7PW3/aRnUbYrm6UWu8RwRSh5mYg
         H59c0O9FHv99HcTIItzAo6II2q+4gRwQQr7S5RPDRGkrD1Roxtk4HEso0ORPk2RcPRIo
         jBM1I9mD9WES9pvHdPX4YRS8pFbmWrffi0loeZSHbrbE+WKf9/uVKpO8zhKHlkAbECIS
         FauYhwpZyryk8Ile4k4ip+PGcl2qciLxb+EguncG98ym0EaN3q3Pb5IVMw+Aaa/nYgJa
         Aqrg==
X-Gm-Message-State: AOJu0YxOglbKC6FJR8wrGg/U0MS8iTJ/jdLrwbHwqQFTdsYcfBdVnoF3
	me1plQ46rCLknXsSynRw9NK87XmsBMo+t9KTo7hUNIqwOXNX2zis+sshGPGgCLVh0Vtusg/guy1
	6yMcfziRcscxg+LECxTOOd69goBXCP7pgfVUkxQ==
X-Google-Smtp-Source: AGHT+IFP7hSPNsDELqXhfc1DSi7wbXwIL00Bvghzh+3rAURSjCAW/OBnfRxEQ2loTtaioTmHEBnCcZGQf0VdPLQbOyM=
X-Received: by 2002:a2e:9092:0:b0:2cf:433c:b3e with SMTP id
 l18-20020a2e9092000000b002cf433c0b3emr28412ljg.8.1706205121921; Thu, 25 Jan
 2024 09:52:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123184552.59758-1-ryncsn@gmail.com> <20240123184552.59758-2-ryncsn@gmail.com>
 <CAF8kJuNZP-uvsSshVrEY0bPsYLB+5Oi-bQKsEQ3RV6yOW+RgNA@mail.gmail.com>
In-Reply-To: <CAF8kJuNZP-uvsSshVrEY0bPsYLB+5Oi-bQKsEQ3RV6yOW+RgNA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 26 Jan 2024 01:51:44 +0800
Message-ID: <CAMgjq7CbxZQ2CmWNjsNjJajBEVkZ839_X5twwLfiiv0-ZgN32A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm, lru_gen: try to prefetch next page when
 scanning LRU
To: Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Yu Zhao <yuzhao@google.com>, Wei Xu <weixugc@google.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 3:33=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Tue, Jan 23, 2024 at 10:46=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Prefetch for inactive/active LRU have been long exiting, apply the same
> > optimization for MGLRU.
> >
> > Test 1: Ramdisk fio ro test in a 4G memcg on a EPYC 7K62:
> >   fio -name=3Dmglru --numjobs=3D16 --directory=3D/mnt --size=3D960m \
> >     --buffered=3D1 --ioengine=3Dio_uring --iodepth=3D128 \
> >     --iodepth_batch_submit=3D32 --iodepth_batch_complete=3D32 \
> >     --rw=3Drandread --random_distribution=3Dzipf:0.5 --norandommap \
> >     --time_based --ramp_time=3D1m --runtime=3D6m --group_reporting
> >
> > Before this patch:
> > bw (  MiB/s): min=3D 7758, max=3D 9239, per=3D100.00%, avg=3D8747.59, s=
tdev=3D16.51, samples=3D11488
> > iops        : min=3D1986251, max=3D2365323, avg=3D2239380.87, stdev=3D4=
225.93, samples=3D11488
> >
> > After this patch (+7.2%):
> > bw (  MiB/s): min=3D 8360, max=3D 9771, per=3D100.00%, avg=3D9381.31, s=
tdev=3D15.67, samples=3D11488
> > iops        : min=3D2140296, max=3D2501385, avg=3D2401613.91, stdev=3D4=
010.41, samples=3D11488
> >
> > Test 2: Ramdisk fio hybrid test for 30m in a 4G memcg on a EPYC 7K62 (3=
 times):
> >   fio --buffered=3D1 --numjobs=3D8 --size=3D960m --directory=3D/mnt \
> >     --time_based --ramp_time=3D1m --runtime=3D30m \
> >     --ioengine=3Dio_uring --iodepth=3D128 --iodepth_batch_submit=3D32 \
> >     --iodepth_batch_complete=3D32 --norandommap \
> >     --name=3Dmglru-ro --rw=3Drandread --random_distribution=3Dzipf:0.7 =
\
> >     --name=3Dmglru-rw --rw=3Drandrw --random_distribution=3Dzipf:0.7
> >
> > Before this patch:
> >  READ: 6622.0 MiB/s. Stdev: 22.090722
> > WRITE: 1256.3 MiB/s. Stdev: 5.249339
> >
> > After this patch (+4.6%, +3.3%):
> >  READ: 6926.6 MiB/s, Stdev: 37.950260
> > WRITE: 1297.3 MiB/s, Stdev: 7.408704
> >
> > Test 3: 30m of MySQL test in 6G memcg (12 times):
> >   echo 'set GLOBAL innodb_buffer_pool_size=3D16106127360;' | \
> >     mysql -u USER -h localhost --password=3DPASS
> >
> >   sysbench /usr/share/sysbench/oltp_read_only.lua \
> >     --mysql-user=3DUSER --mysql-password=3DPASS --mysql-db=3DDB \
> >     --tables=3D48 --table-size=3D2000000 --threads=3D16 --time=3D1800 r=
un
> >
> > Before this patch
> > Avg: 134743.714545 qps. Stdev: 582.242189
> >
> > After this patch (+0.2%):
> > Avg: 135005.779091 qps. Stdev: 295.299027
> >
> > Test 4: Build linux kernel in 2G memcg with make -j48 with SSD swap
> >         (for memory stress, 18 times):
> >
> > Before this patch:
> > Avg: 1456.768899 s. Stdev: 20.106973
> >
> > After this patch (+0.0%):
> > Avg: 1455.659254 s. Stdev: 15.274481
> >
> > Test 5: Memtier test in a 4G cgroup using brd as swap (18 times):
> >   memcached -u nobody -m 16384 -s /tmp/memcached.socket \
> >     -a 0766 -t 16 -B binary &
> >   memtier_benchmark -S /tmp/memcached.socket \
> >     -P memcache_binary -n allkeys \
> >     --key-minimum=3D1 --key-maximum=3D16000000 -d 1024 \
> >     --ratio=3D1:0 --key-pattern=3DP:P -c 1 -t 16 --pipeline 8 -x 3
> >
> > Before this patch:
> > Avg: 50317.984000 Ops/sec. Stdev: 2568.965458
> >
> > After this patch (-5.7%):
> > Avg: 47691.343500 Ops/sec. Stdev: 3925.772473
> >
> > It seems prefetch is helpful in most cases, but the memtier test is
> > either hitting a case where prefetch causes higher cache miss or it's
> > just too noisy (high stdev).
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/vmscan.c | 30 ++++++++++++++++++++++++++----
> >  1 file changed, 26 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 4f9c854ce6cc..03631cedb3ab 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3681,15 +3681,26 @@ static bool inc_min_seq(struct lruvec *lruvec, =
int type, bool can_swap)
> >         /* prevent cold/hot inversion if force_scan is true */
> >         for (zone =3D 0; zone < MAX_NR_ZONES; zone++) {
> >                 struct list_head *head =3D &lrugen->folios[old_gen][typ=
e][zone];
> > +               struct folio *prev =3D NULL;
> >
> > -               while (!list_empty(head)) {
> > -                       struct folio *folio =3D lru_to_folio(head);
> > +               if (!list_empty(head))
> > +                       prev =3D lru_to_folio(head);
> > +
> > +               while (prev) {
> > +                       struct folio *folio =3D prev;
> >
> >                         VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(fo=
lio), folio);
> >                         VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio),=
 folio);
> >                         VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) =
!=3D type, folio);
> >                         VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) !=3D=
 zone, folio);
> >
> > +                       if (unlikely(list_is_first(&folio->lru, head)))=
 {
> > +                               prev =3D NULL;
> > +                       } else {
> > +                               prev =3D lru_to_folio(&folio->lru);
> > +                               prefetchw(&prev->flags);
> > +                       }
>
> This makes the code flow much harder to follow. Also for architecture
> that does not support prefetch, this will be a net loss.
>
> Can you use refetchw_prev_lru_folio() instead? It will make the code
> much easier to follow. It also turns into no-op when prefetch is not
> supported.
>
> Chris
>

Hi Chris,

Thanks for the suggestion.

Yes, that's doable, I made it this way because in previous series (V1
& V2) I applied the bulk move patch first which needed and introduced
the `prev` variable here, so the prefetch logic just used it.
For V3 I did a rebase and moved the prefetch commit to be the first
one, since it seems to be the most effective one, and just kept the
code style to avoid redundant change between patches.

I can update in V4 to make this individual patch better with your suggestio=
n.

