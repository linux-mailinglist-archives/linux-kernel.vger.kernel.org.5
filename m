Return-Path: <linux-kernel+bounces-10775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C93081DBAA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 18:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B9E1C21247
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 17:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08693CA7C;
	Sun, 24 Dec 2023 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlGmpu6D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46241C8C4
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 17:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D18C433CA
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 17:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703438099;
	bh=sUtCX9BT+hLGHE76Vf5GNGPKRofN6whsC0oBi+gGX5A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VlGmpu6DZnJkISsA1AJaq6693WmCVAlu3dANfFSz3B86OlMtQcsPaz3HN6ijeQoXd
	 zBMvQfLvGYM0eR7Enl5APLYft1AbNDvhcDwZTMkOiP1XPmkQo2+kukrXQ7ZS6Pvs9n
	 +tk/5tCFxJJI9Lc8L0YaXL37wkwvgMBH8QDVsMEnoEAyG/PIbGnfeLRvAn7jd8eTGX
	 qi7nZ4wPYz+cF80OZGT34jZu/+Fq3K1PGlY1s0f2y1d2e7gRpJ/bX7mWjZMfgNg2/I
	 scTAnd1u9JLhUjFDGu6Pd4Q9E0u2KabwHYIFALi9I9sh+DC4Fz6us5qfdtR1CejzwZ
	 BxwUZKibSDsQA==
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7ba87489f97so132943639f.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 09:14:59 -0800 (PST)
X-Gm-Message-State: AOJu0Yy/adsNBYzt2TKUPokyoWIheA+vqVvQojHaj0chm6pXksDVo/aZ
	F5jtB76LIEffnxc6byHf7EUQEmDnVRFXNyDGuGTwMgixHkt9
X-Google-Smtp-Source: AGHT+IEO6q1FQ8VwDr8zmcOqSXXv7BmjQaVSMyiriY6QrNu/ufURkhTeW1w35vDQpv6nCx35oLFc7ejrJCa2fsnqf2s=
X-Received: by 2002:a6b:7014:0:b0:7ba:965b:fde6 with SMTP id
 l20-20020a6b7014000000b007ba965bfde6mr4539184ioc.33.1703438098913; Sun, 24
 Dec 2023 09:14:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220152653.3273778-1-schatzberg.dan@gmail.com> <20231220152653.3273778-2-schatzberg.dan@gmail.com>
In-Reply-To: <20231220152653.3273778-2-schatzberg.dan@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sun, 24 Dec 2023 09:14:47 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOybADVVnHZYxf+aMBF2EzURn1PRGhPu8Lx=5aDeas6VQ@mail.gmail.com>
Message-ID: <CAF8kJuOybADVVnHZYxf+aMBF2EzURn1PRGhPu8Lx=5aDeas6VQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] mm: add defines for min/max swappiness
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Jonathan Corbet <corbet@lwn.net>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, SeongJae Park <sj@kernel.org>, 
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Nhat Pham <nphamcs@gmail.com>, 
	Yue Zhao <findns94@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

Acked-by: Chris Li <chrisl@kernel.org>

Chris

On Wed, Dec 20, 2023 at 7:27=E2=80=AFAM Dan Schatzberg <schatzberg.dan@gmai=
l.com> wrote:
>
> We use the constants 0 and 200 in a few places in the mm code when
> referring to the min and max swappiness. This patch adds MIN_SWAPPINESS
> and MAX_SWAPPINESS #defines to improve clarity. There are no functional
> changes.
>
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> ---
>  include/linux/swap.h |  2 ++
>  mm/memcontrol.c      |  2 +-
>  mm/vmscan.c          | 14 +++++++-------
>  3 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index f6dd6575b905..e2ab76c25b4a 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -407,6 +407,8 @@ extern unsigned long try_to_free_pages(struct zonelis=
t *zonelist, int order,
>
>  #define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
>  #define MEMCG_RECLAIM_PROACTIVE (1 << 2)
> +#define MIN_SWAPPINESS 0
> +#define MAX_SWAPPINESS 200
>  extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *mem=
cg,
>                                                   unsigned long nr_pages,
>                                                   gfp_t gfp_mask,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b226090fd906..fbe9f02dd206 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4337,7 +4337,7 @@ static int mem_cgroup_swappiness_write(struct cgrou=
p_subsys_state *css,
>  {
>         struct mem_cgroup *memcg =3D mem_cgroup_from_css(css);
>
> -       if (val > 200)
> +       if (val > MAX_SWAPPINESS)
>                 return -EINVAL;
>
>         if (!mem_cgroup_is_root(memcg))
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9dd8977de5a2..d91963e2d47f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -183,7 +183,7 @@ struct scan_control {
>  #endif
>
>  /*
> - * From 0 .. 200.  Higher means more swappy.
> + * From 0 .. MAX_SWAPPINESS.  Higher means more swappy.
>   */
>  int vm_swappiness =3D 60;
>
> @@ -2403,7 +2403,7 @@ static void get_scan_count(struct lruvec *lruvec, s=
truct scan_control *sc,
>         ap =3D swappiness * (total_cost + 1);
>         ap /=3D anon_cost + 1;
>
> -       fp =3D (200 - swappiness) * (total_cost + 1);
> +       fp =3D (MAX_SWAPPINESS - swappiness) * (total_cost + 1);
>         fp /=3D file_cost + 1;
>
>         fraction[0] =3D ap;
> @@ -4400,7 +4400,7 @@ static int get_type_to_scan(struct lruvec *lruvec, =
int swappiness, int *tier_idx
>  {
>         int type, tier;
>         struct ctrl_pos sp, pv;
> -       int gain[ANON_AND_FILE] =3D { swappiness, 200 - swappiness };
> +       int gain[ANON_AND_FILE] =3D { swappiness, MAX_SWAPPINESS - swappi=
ness };
>
>         /*
>          * Compare the first tier of anon with that of file to determine =
which
> @@ -4436,7 +4436,7 @@ static int isolate_folios(struct lruvec *lruvec, st=
ruct scan_control *sc, int sw
>         /*
>          * Try to make the obvious choice first. When anon and file are b=
oth
>          * available from the same generation, interpret swappiness 1 as =
file
> -        * first and 200 as anon first.
> +        * first and MAX_SWAPPINESS as anon first.
>          */
>         if (!swappiness)
>                 type =3D LRU_GEN_FILE;
> @@ -4444,7 +4444,7 @@ static int isolate_folios(struct lruvec *lruvec, st=
ruct scan_control *sc, int sw
>                 type =3D LRU_GEN_ANON;
>         else if (swappiness =3D=3D 1)
>                 type =3D LRU_GEN_FILE;
> -       else if (swappiness =3D=3D 200)
> +       else if (swappiness =3D=3D MAX_SWAPPINESS)
>                 type =3D LRU_GEN_ANON;
>         else
>                 type =3D get_type_to_scan(lruvec, swappiness, &tier);
> @@ -5398,9 +5398,9 @@ static int run_cmd(char cmd, int memcg_id, int nid,=
 unsigned long seq,
>
>         lruvec =3D get_lruvec(memcg, nid);
>
> -       if (swappiness < 0)
> +       if (swappiness < MIN_SWAPPINESS)
>                 swappiness =3D get_swappiness(lruvec, sc);
> -       else if (swappiness > 200)
> +       else if (swappiness > MAX_SWAPPINESS)
>                 goto done;
>
>         switch (cmd) {
> --
> 2.39.3
>
>

