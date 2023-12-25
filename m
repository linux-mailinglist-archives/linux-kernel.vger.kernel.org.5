Return-Path: <linux-kernel+bounces-10907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DBE81DEA3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 07:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9224281695
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 06:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBD015C9;
	Mon, 25 Dec 2023 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xt7Hs/ic"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0425A15A8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 06:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d41a32effso143035e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 22:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703486528; x=1704091328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrGG/yhOTC4gewhDUIIieGQ+ifhBWe6O8VJ8zkxhJjw=;
        b=Xt7Hs/icVW/EqOnkRHQydXc8qeXfprnoBXdzKnxq+uen1/typIGF4x4YCLZipofdKp
         CxuzGAe40qL1UklsQspcdyIWTGRI12mJ7reqMSt+8muJHSKnSxUMdHxsfuyWqDc3CqIf
         +YQGYPfxZYaQLG9/AMT1OC9vxSSaCOhbXNvNsDuNIs0iZ03QBWch4/P7kJ0ET4ISX1VN
         sl4uQhihhq0BzOmQODSKVyrgNJgvvyZJPeBeUfFTq/9tst6fzPKvK12Ng+6dx3yZ5WJw
         kR1xJW/KJPhv8qINf2nQOTxym+dSLhOy7iqVBDijpDUu0z92C4uF540ZpxVMJlvP4vBf
         7CSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703486528; x=1704091328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrGG/yhOTC4gewhDUIIieGQ+ifhBWe6O8VJ8zkxhJjw=;
        b=Wfvgw+JuGp+XqFFtR1z9Ys3Ie0SNl2lvQBABpFeR5wq2FdRY4rRHzScc33GG6LlQb1
         3gr+kvwoRiO1V6/u7MY9HUvxq6gXYotZfS+dXrP21vHOh2/lhcs/6ye1yWvVyYOR6NWU
         9x8m233nh/zhCw6/tPSxuBb1M8h2a6W20vTk4gDsEVgADVFnOFsiZvC1jO0a1mvhA9Zd
         vlW5MNoXonLjcOxeHud46YMLCmNk4ESU5amvv4vTzM1kMNwcyYqHlmiradUISD83fxPU
         kb1A/IydDy2++HMqQa+Jhr8aMM2OzAHosGq+jCcdf5zafCHb/cnt8vvgabIjcpMLlpeq
         ueQg==
X-Gm-Message-State: AOJu0Yxn/3KFZCN90xzQxcsP8zHBLIyp3aqCWAwKXD0AWQc+MDdw0nE9
	zI8xMiGnUVSpGZpvhkKsKyupq/X61QmZpi6ylupZjM189xX7qHRGeuPGLpKxKbaz
X-Google-Smtp-Source: AGHT+IEjMrsUEkgLxf08ttjkfA8zBFu5sI1QVA+XAQDYQNh5fEG84p2rzjjbHmu778yJP+QQYjzA0+S25ak6mIWM7js=
X-Received: by 2002:a05:600c:1c29:b0:40d:3bec:55a with SMTP id
 j41-20020a05600c1c2900b0040d3bec055amr333083wms.5.1703486528047; Sun, 24 Dec
 2023 22:42:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222102255.56993-1-ryncsn@gmail.com> <20231222102255.56993-4-ryncsn@gmail.com>
In-Reply-To: <20231222102255.56993-4-ryncsn@gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Sun, 24 Dec 2023 23:41:31 -0700
Message-ID: <CAOUHufYrzw7dDbchNkrrXnSqpeYasnfPh6qFoMNgAmbK9GXNaQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm, lru_gen: try to prefetch next page when canning LRU
To: Kairui Song <kasong@tencent.com>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 3:24=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> Prefetch for inactive/active LRU have been long exiting, apply the same
> optimization for MGLRU.

I seriously doubt that prefetch helps in this case.

Willy, any thoughts on this? Thanks.

> Tested in a 4G memcg on a EPYC 7K62 with:
>
>   memcached -u nobody -m 16384 -s /tmp/memcached.socket \
>     -a 0766 -t 16 -B binary &
>
>   memtier_benchmark -S /tmp/memcached.socket \
>     -P memcache_binary -n allkeys \
>     --key-minimum=3D1 --key-maximum=3D16000000 -d 1024 \
>     --ratio=3D1:0 --key-pattern=3DP:P -c 2 -t 16 --pipeline 8 -x 6
>
> Average result of 18 test runs:
>
> Before:           44017.78 Ops/sec
> After patch 1-3:  44890.50 Ops/sec (+1.8%)
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/vmscan.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index af1266129c1b..1e9d69e18443 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3764,10 +3764,12 @@ static bool inc_min_seq(struct lruvec *lruvec, in=
t type, bool can_swap)
>                         VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) !=
=3D type, folio);
>                         VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) !=3D z=
one, folio);
>
> -                       if (unlikely(list_is_first(&folio->lru, head)))
> +                       if (unlikely(list_is_first(&folio->lru, head))) {
>                                 prev =3D NULL;
> -                       else
> +                       } else {
>                                 prev =3D lru_to_folio(&folio->lru);
> +                               prefetchw(&prev->flags);
> +                       }
>
>                         new_gen =3D folio_inc_gen(lruvec, folio, false, &=
batch);
>                         lru_gen_try_inc_bulk(lrugen, folio, bulk_gen, new=
_gen, type, zone, &batch);
> @@ -4434,10 +4436,12 @@ static int scan_folios(struct lruvec *lruvec, str=
uct scan_control *sc,
>                         VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) !=3D z=
one, folio);
>
>                         scanned +=3D delta;
> -                       if (unlikely(list_is_first(&folio->lru, head)))
> +                       if (unlikely(list_is_first(&folio->lru, head))) {
>                                 prev =3D NULL;
> -                       else
> +                       } else {
>                                 prev =3D lru_to_folio(&folio->lru);
> +                               prefetchw(&prev->flags);
> +                       }
>
>                         if (sort_folio(lruvec, folio, sc, tier, bulk_gen,=
 &batch))
>                                 sorted +=3D delta;
> --
> 2.43.0
>

