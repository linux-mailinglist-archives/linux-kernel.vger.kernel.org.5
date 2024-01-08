Return-Path: <linux-kernel+bounces-20171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752FA827B51
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1002628508B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 23:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C1253E3F;
	Mon,  8 Jan 2024 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4VUg1IKo"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200712EB12
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 23:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a28ee72913aso587167066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 15:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704755602; x=1705360402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fecCiAR481SWOqpFkPJSiF/c70aAk78xZ2uswrvKLww=;
        b=4VUg1IKo3IWKor1hKqJhlqLqOiP87mquqNU6c9FG5aHfrMJRGEfxkTP6v0GIqR/60l
         OxEMG2GUxZzqCR3wDlD5F8ilXnC82XwdnKWP2uLRiuvR3gjcFzxMi11FjqPA8OPPrMxL
         NuRcW4Pa6LBz2EtoSyR2qFZv5YSJ2tI21c5K9KYbkIJQ1iirohxONsnrdAJabur0loyX
         PXX6XLXnNs9XfAQJRaJKYYyEzqMAEcs5BuKh4ZkzjDMi9XQLe8nd5BsFP/yd4dngMehR
         E1iFXIstuiQmyQcMksHUPdeMqivijxC8dKVoSY3zvSj9XlUL4wXq3FZnT10Vu8vqZH4Q
         hGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704755602; x=1705360402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fecCiAR481SWOqpFkPJSiF/c70aAk78xZ2uswrvKLww=;
        b=JbqyShYu6EJ/LGGDNo8lHeg/tqD8XXGwWqVvQizph7Kv1dzswGnUxObi8U8qXPdH3m
         sHOVP9vNaZ7hypWzDC5SMJY47KVMJCv1leceFp90ayBtzLo/VGICTQIMryO9avWC012a
         SDmuv+3FPS/HlMZDgWlK7L4uBAyan2ReD59S+4aeL2acPAGYL4hNt9DbqfhYOi+BjPqZ
         0fimsh8p3vpBtXr5s6DqF1OKiY9Ft5NQnksLo0PjuPlBGQiQ/1gA0o5wrf0qet5k89FW
         29rP0srPy7R2vm/hyJ50uCA8Isk3CJkmVEpz5XpLhJg7uUYx7qybUo8LwPRCcT3zU+ig
         g+Ng==
X-Gm-Message-State: AOJu0Ywlxrqscw06rVa1XjeV0NpeLn1s8QX5TWZ51vHKo5SezTj/fErJ
	CelSeBnzdLtUANfdESX66M1IFxYD6o6noa7wW2X59UduT6Xb
X-Google-Smtp-Source: AGHT+IG9FZliAE8ycwaVIJMrC1FRCDl1rIILVQHoDAQ2lQ0DPsbMkwQgzFpd6F5F+y2lmeGdKKadoIEf1q5ihv/vjaY=
X-Received: by 2002:a17:906:1dd:b0:a28:c04e:315b with SMTP id
 29-20020a17090601dd00b00a28c04e315bmr131634ejj.13.1704755602122; Mon, 08 Jan
 2024 15:13:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024142706.195517-1-hezhongkun.hzk@bytedance.com>
 <CAKEwX=OiNB+pPhb-3Tf7O=F7psKE3EOpwmbPSeLSOyuHpj3i+Q@mail.gmail.com>
 <CACSyD1P6HmH9tSvONnNxYv8P+am_hH2dK3UJQd9_+o6EWkPsXA@mail.gmail.com>
 <CAKEwX=PC3C-PrWAH3XiYGyR4ujqBJQBBX6uRa2jXKCy9VMyRCQ@mail.gmail.com>
 <CACSyD1O7t0+BXUujJ81RAdEys3MUnmpu0sRADLazoyvayx5DLA@mail.gmail.com>
 <CAKEwX=P5AC+ubnunnZr5vMiC6fFU+E_E7jg_FZztWwZRYSxTWQ@mail.gmail.com>
 <CACSyD1Nnc_w3epbt6+EMt7a-4pAzgW1hbE=G5Fy5Tc5R5+uxKw@mail.gmail.com>
 <CAKEwX=NuXR9Ot1eRFsp9n-3Tq9yhjD9up+jyvXeOzQ4xK9kEPA@mail.gmail.com> <CAKEwX=Oj2dR6a4-DeccvcVdJ-J7b=83uCWQAf5u7U0sySudnkw@mail.gmail.com>
In-Reply-To: <CAKEwX=Oj2dR6a4-DeccvcVdJ-J7b=83uCWQAf5u7U0sySudnkw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 8 Jan 2024 15:12:45 -0800
Message-ID: <CAJD7tkb2oda=4f0s8w8xn+t_TM1b2Q_otbb86VPQ9R1m2uqDTA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Nhat Pham <nphamcs@gmail.com>
Cc: Zhongkun He <hezhongkun.hzk@bytedance.com>, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, sjenning@redhat.com, ddstreet@ieee.org, 
	vitaly.wool@konsulko.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>, weijie.yang@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 7, 2024 at 1:59=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Sun, Jan 7, 2024 at 1:29=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> >
> > On Fri, Jan 5, 2024 at 6:10=E2=80=AFAM Zhongkun He <hezhongkun.hzk@byte=
dance.com> wrote:
> > >
> > > > > There is another option here, which is not to move the page to th=
e
> > > > > tail of the inactive
> > > > > list after end_writeback and delete the following code in
> > > > > zswap_writeback_entry(),
> > > > > which did not work properly. But the pages will not be released f=
irst.
> > > > >
> > > > > /* move it to the tail of the inactive list after end_writeback *=
/
> > > > > SetPageReclaim(page);
> >
> >
> > Ok, so I took a look at the patch that originally introduced this
> > piece of logic:
> >
> > https://github.com/torvalds/linux/commit/b349acc76b7f65400b85abd09a5379=
ddd6fa5a97
> >
> > Looks like it's not for the sake of correctness, but only as a
> > best-effort optimization (reducing page scanning). If it doesn't bring
> > any benefit (i.e due to the newly allocated page still on the cpu
> > batch), then we can consider removing it. After all, if you're right
> > and it's not really doing anything here - why bother. Perhaps we can
> > replace this with some other mechanism to avoid it being scanned for
> > reclaim.
>
> For instance, we can grab the local lock, look for the folio in the
> add batch and take the folio off it, then add it to the rotate batch
> instead? Not sure if this is doable within folio_rotate_reclaimable(),
> or you'll have to manually perform this yourself (and remove the
> PG_reclaim flag set here so that folio_end_writeback() doesn't try to
> handle it).
>
> There is still some overhead with this, but at least we don't have to
> *drain everything* (which looks like what's lru_add_drain() ->
> lru_add_drain_cpu() is doing). The latter sounds expensive and
> unnecessary, whereas this is just one element addition and one element
> removal - and if IIUC the size of the per-cpu add batch is capped at
> 15, so lookup + removal (if possible) shouldn't be too expensive?
>
> Just throwing ideas out there :)

Sorry for being late to the party. It seems to me that all of this
hassle can be avoided if lru_add_fn() did the right thing in this case
and added the folio to the tail of the lru directly. I am no expert in
how the page flags work here, but it seems like we can do something
like this in lru_add_fn():

if (folio_test_reclaim(folio))
    lruvec_add_folio_tail(lruvec, folio);
else
    lruvec_add_folio(lruvec, folio);

I think the main problem with this is that PG_reclaim is an alias to
PG_readahead, so readahead pages will also go to the tail of the lru,
which is probably not good.

A more intrusive alternative is to introduce a folio_lru_add_tail()
variant that always adds pages to the tail, and optionally call that
from __read_swap_cache_async() instead of folio_lru_add() based on a
new boolean argument. The zswap code can set that boolean argument
during writeback to make sure newly allocated folios are always added
to the tail of the lru.

