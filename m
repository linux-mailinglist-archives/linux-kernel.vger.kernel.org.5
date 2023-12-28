Return-Path: <linux-kernel+bounces-12504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A21B81F5CF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45EA01C21CB6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEC25235;
	Thu, 28 Dec 2023 08:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SknIFCUj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44044409
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d5097150fso197025e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 00:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703750550; x=1704355350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eB61PJ6bXuOFc4kAwo732pceo1OINco0DG5E/GPGo0=;
        b=SknIFCUjfuYWoiXQTrMrepV/aaR0GecE3Xb9wYQXW/6ggHzsCtww1ShjGXR7JHKGAe
         JTL7QWq5dcjq6u0u4YM8DzsfGdIM1JxfmKoFRbFsq7sBw9JOqLvowifBDCjHa4qs2Cmt
         IRG9RFbcfJ4t1o34d9Z1ZZBXmSc9MkYQtxjC0JyyxoZ0WbqOw5fouKUCYiwSk+Jb2Erp
         83/YmMp6PFiMTfUOffiIUONajT4Aa7vEHUUe1+2UEdlBy9z4pc5jA2z9Q69yFMbUsfAK
         wkcUwjcmQ69ogxKh6fs/vyhYFmZWRwsFjTx3vCi32txkS7F0FFOAm6kbQpFOfSD9Y5AI
         PK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703750550; x=1704355350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eB61PJ6bXuOFc4kAwo732pceo1OINco0DG5E/GPGo0=;
        b=S3S5EHFztdIftGw+UyiLvd1MRIC7IT9O+u3yJr/BC3EJPDH9GNMu5J2eMqWe1KeFlV
         2J3Zi3KLi21JLXMV1HGhZ2ilAMct1WFqUZNizidB9EytRKvWOs1r7WGwQfZQKnjLUc7E
         YAX90OsC9ch3iq6rL8VNUx5cGkV9ja+EHLLqTlCWMAObOrooJoVxtmPssUx31xcJXxHc
         kSOkA98YFPRWicL/UZXfW1JyrG5Hh95kUZ3Himb/hF+0+ypqWlXma8LcsRnJ5RVvGMUR
         tSkdf66ORbHK9yOeiyq1FYm+qbtdhaTA7cPPUcsKFa/9q1Pu1ImLmarRvL8FFDNw+KMF
         YgKQ==
X-Gm-Message-State: AOJu0YxGwhQBafZIVvl3UgU2jBV7gGG5Iet6MoGq1uX6uZRdeP8V0zNB
	JQwpGCJZC7hq/QgMEhFhaXbNHKYEPgkMDuSCrTKNDrsto6I4
X-Google-Smtp-Source: AGHT+IFQHW+Q/Yt6QyxXEHRjzz2VaaoY833C1iYaqV5n3v5D+8xiTWxjXWzG8tMdhUTve9fmyAGq1ZODhJiCWlOdRAQ=
X-Received: by 2002:a05:600c:450e:b0:40d:2bc7:e9b with SMTP id
 t14-20020a05600c450e00b0040d2bc70e9bmr689916wmo.4.1703750549687; Thu, 28 Dec
 2023 00:02:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228073055.4046430-1-shakeelb@google.com>
In-Reply-To: <20231228073055.4046430-1-shakeelb@google.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 28 Dec 2023 01:01:51 -0700
Message-ID: <CAOUHufZFZgT70mcnCV8tpLpxhF5D1aNYe0nLAVJs_fDX0EMH5A@mail.gmail.com>
Subject: Re: [PATCH] mm: ratelimit stat flush from workingset shrinker
To: Shakeel Butt <shakeelb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 12:31=E2=80=AFAM Shakeel Butt <shakeelb@google.com>=
 wrote:
>
> One of our internal workload regressed on newer upstream kernel

Not really internal -- it's Postgres 14 + sysbench OLTP.

> and on
> further investigation, it seems like the cause is the always synchronous
> rstat flush in the count_shadow_nodes() added by the commit f82e6bf9bb9b
> ("mm: memcg: use rstat for non-hierarchical stats"). On further
> inspection it seems like we don't really need accurate stats in this
> function as it was already approximating the amount of appropriate
> shadow entried to keep for maintaining the refault information. Since
> there is already 2 sec periodic rstat flush, we don't need exact stats
> here. Let's ratelimit the rstat flush in this code path.
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

LGTM.

