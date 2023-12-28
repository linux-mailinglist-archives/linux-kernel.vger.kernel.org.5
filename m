Return-Path: <linux-kernel+bounces-12742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF5D81F985
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC39C28127A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F35F4FA;
	Thu, 28 Dec 2023 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QC1JHDes"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419A0F4E7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2370535060so1266727166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 07:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703776440; x=1704381240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ahnv5X4nnAsn+nuTs2Z+3DG61SWJqLXeCYhMNSbZQT0=;
        b=QC1JHDes1OkS2rRmvwHx2pJgyMZs7Q+hwEVjf96SbNkXjnJZOhc1Pa2qsi0CbPl/+c
         bKrI3/0Kmmr8+orZQhOyBjQpQFzqPqAa4j8ITo6DCe/XwKuzRvPE1EDh+nofM6R1iMEV
         C/C2VWNcARXInnQNN6lqnVTpgBSm62BPGIfjr/R1LjSN9dRqyyF0z0WAr/gaPv8HWRXv
         GRFdqsKW3iQgZYh3AcL4DH07dKt1pceXdqNOHEsQ6o6ccs3lGfC3LJS6W9BYXhG+uyZL
         biWL1tsaJDFVXWTwnz7E9KJp6t+f8XMFiLHe2VIyo7vDTC1zkV8bYTmF6A3G0rrG5mBR
         XK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703776440; x=1704381240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ahnv5X4nnAsn+nuTs2Z+3DG61SWJqLXeCYhMNSbZQT0=;
        b=A2jv9FIbSLFNKLzpYJNppDVQPdbgsjtr55L1ZBl9c3/N0p31fGv8AFoAE5vW4O6zgl
         n5/mlZOLWRrcN2twreU7QUqt6mwczQqfSWLlysFEpe6jzHeQf+sNP7/YhMY+d3KU1OV9
         X+/GGGU4zwYEbilQSKTk4h2xhPnZowyvUkJqChGS3ZLSnVyXKl+s3XvN0aPHpfktYpof
         I9Okh3ssrSggutxwqLY6J9KwIXgacCXn7XYF+oAR1ZBR39ot7qyWbCMsr9uEGdbZNjLj
         ToVZQyYBSDlWP/aOoVvXCBZoPUbpQe5YAe2FtkE2PnXWCLhJ748cvDOd6x86sX4Kq0JX
         gZXg==
X-Gm-Message-State: AOJu0YxiObhjc//zMHBpD9lV1dBelj2uGHx+WFk5KjvhDf9IaNt8V0g9
	IV4I1OKSwFXfmBf+dOnlcv/80ae0dqi78viN7GGlT1jfp7Ww20n7oXM224NT1jJUXUg=
X-Google-Smtp-Source: AGHT+IEFHeLXb2+I4clZFSkOkMfyCaJGc/cfoOl0KPxpF81N+THYiqTo1FMe57UY8J4bOsW3G4BuIidohqBwB3Y4v94=
X-Received: by 2002:a17:906:2dd:b0:a23:1b07:5c1b with SMTP id
 29-20020a17090602dd00b00a231b075c1bmr10625948ejk.10.1703776440320; Thu, 28
 Dec 2023 07:14:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228073055.4046430-1-shakeelb@google.com>
In-Reply-To: <20231228073055.4046430-1-shakeelb@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 28 Dec 2023 07:13:23 -0800
Message-ID: <CAJD7tkbqtrJqD9=5f-ZZBcWyX9t-e=fenJdDU5U=GDpbbWrzrw@mail.gmail.com>
Subject: Re: [PATCH] mm: ratelimit stat flush from workingset shrinker
To: Shakeel Butt <shakeelb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 11:31=E2=80=AFPM Shakeel Butt <shakeelb@google.com>=
 wrote:
>
> One of our internal workload regressed on newer upstream kernel and on
> further investigation, it seems like the cause is the always synchronous
> rstat flush in the count_shadow_nodes() added by the commit f82e6bf9bb9b
> ("mm: memcg: use rstat for non-hierarchical stats"). On further
> inspection it seems like we don't really need accurate stats in this
> function as it was already approximating the amount of appropriate
> shadow entried to keep for maintaining the refault information. Since

s/entried/entries

> there is already 2 sec periodic rstat flush, we don't need exact stats
> here. Let's ratelimit the rstat flush in this code path.

Is the regression observed even with commit 7d7ef0a4686a ("mm: memcg:
restore subtree stats flushing")? I think the answer is yes based on
internal discussions, but this really surprises me.

Commit f82e6bf9bb9b removed the percpu loop in
lruvec_page_state_local(), and added a flush call. With  7d7ef0a4686a,
the flush call is only effective if there are pending updates in the
cgroup subtree exceeding MEMCG_CHARGE_BATCH * num_online_cpus(). IOW,
we should only be doing work when actually needed, whereas before we
used to have multiple percpu loops in count_shadow_nodes() regardless
of pending updates.

It seems like the cgroup subtree is very active that we continuously
need to flush in count_shadow_nodes()? If that's the case, do we still
think it's okay not to flush when we know there are pending updates? I
don't have enough background about the workingset heuristics to judge
this.

I am not objecting to this change, I am just trying to understand
what's happening.

Thanks!

>
> Fixes: f82e6bf9bb9b ("mm: memcg: use rstat for non-hierarchical stats")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>  mm/workingset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 2a2a34234df9..226012974328 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -680,7 +680,7 @@ static unsigned long count_shadow_nodes(struct shrink=
er *shrinker,
>                 struct lruvec *lruvec;
>                 int i;
>
> -               mem_cgroup_flush_stats(sc->memcg);
> +               mem_cgroup_flush_stats_ratelimited(sc->memcg);
>                 lruvec =3D mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid=
));
>                 for (pages =3D 0, i =3D 0; i < NR_LRU_LISTS; i++)
>                         pages +=3D lruvec_page_state_local(lruvec,
> --
> 2.43.0.472.g3155946c3a-goog
>

