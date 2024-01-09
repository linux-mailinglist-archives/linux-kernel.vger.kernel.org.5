Return-Path: <linux-kernel+bounces-21556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C510829119
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCEA31F264B2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729AA3E483;
	Tue,  9 Jan 2024 23:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HXgeRiua"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE8D3E47B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 23:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e43e55b87so24005e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 15:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704844705; x=1705449505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TbM8AUIgVHEHSPyXQawjQZn1xoKY8+QruQ6ShVahao=;
        b=HXgeRiuapsx3bAgHsqfSjzwUR/dp1E1w7Ofd1949Ng56ao2utcdd+r5OrwKIkHFqtK
         osJ2jNRxouZiqjrwiKmz48nUCndnY9JfzEjZx3uxJc9p1RpsoznJSdRfvBF8zGwGX9dZ
         exYKWXFPO5M0t4mkGcs1t02xGOvtRga33n1p4J/q+Vfqmf+bGK9oOmbZ+z1LysNN6Hq+
         wpAspA4cakimhTP9gCZGakd1FL5LQgUxhMJyR4N+x+13xoDYh2yixDZN4kUA/E3vbqwx
         9kudYkVSdZetD997BzpdAsq0mewL2oaFhVWvnv56Gdeg42ffSp1wBqGSZlx/B5BYm6yx
         7wwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704844705; x=1705449505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TbM8AUIgVHEHSPyXQawjQZn1xoKY8+QruQ6ShVahao=;
        b=siQ7ks5dKJHbEIC2g4mVj6nVMXNqr0cCqzbEmRA6lrAk1bS1HFiXVnPgrInH13TKF/
         6qtH+1SwV6RezVAaybsYrA6A/qaIQlnDZ0BRvjUb6+v2Rl9a3X56Zhat8A6SaNTUW8n/
         pc21Tg2Wu0g6nYYmtlbbdcEdanaeHfggZXRtzyz4/rMUZznENxecoeEU6pqlrZNss+Oo
         rmmV/PVdp0GL4JsK3JO0JnF8yjzI5j4k3m2WC22MhmQfmqW+1rcn/AsbgqjsRi5B/Azl
         L3Eqdo1qEIiH4bBPmK19GWeEnH2FdPBV8WqvYqzj7CdeM4s+JOeNhUgkvzEc1K8ntIc9
         XMeA==
X-Gm-Message-State: AOJu0YwTslFACDKVeocgtAP6Ijlla08bnUUSDZLQYesR72E86bVCzVoe
	h0Cy+bGqdP1q0hipKUa8LlFsRh0cyAGI4O72A9nFoFp+rJEfpRkXwlyVMvL1lB95
X-Google-Smtp-Source: AGHT+IG71+3cRooAKrqxm1VJWVGzbnaAqyLyBFYdVbiOZ8yx1Z+1XoVoTpDoxpSli0ie7XCw/qJW5RRnS4Yy3b4RU88=
X-Received: by 2002:a05:600c:3c82:b0:40e:5274:e2ba with SMTP id
 bg2-20020a05600c3c8200b0040e5274e2bamr103211wmb.4.1704844705267; Tue, 09 Jan
 2024 15:58:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103164841.2800183-1-schatzberg.dan@gmail.com>
 <20240103164841.2800183-3-schatzberg.dan@gmail.com> <ZZaDw1Fak_q9BnW-@tiehlicka>
In-Reply-To: <ZZaDw1Fak_q9BnW-@tiehlicka>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 9 Jan 2024 16:57:49 -0700
Message-ID: <CAOUHufZsf0WYQcUyMz7EcyvFYpaL4wLDZBW8oz9CgB5qZqSGAQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] mm: add swapiness= arg to memory.reclaim
To: Michal Hocko <mhocko@suse.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	Yosry Ahmed <yosryahmed@google.com>, David Rientjes <rientjes@google.com>, 
	Chris Li <chrisl@kernel.org>, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 3:09=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Wed 03-01-24 08:48:37, Dan Schatzberg wrote:
> [...]
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index d91963e2d47f..394e0dd46b2e 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -92,6 +92,11 @@ struct scan_control {
> >       unsigned long   anon_cost;
> >       unsigned long   file_cost;
> >
> > +#ifdef CONFIG_MEMCG
> > +     /* Swappiness value for proactive reclaim. Always use sc_swappine=
ss()! */
> > +     int *proactive_swappiness;
> > +#endif
> > +
> >       /* Can active folios be deactivated as part of reclaim? */
> >  #define DEACTIVATE_ANON 1
> >  #define DEACTIVATE_FILE 2
> > @@ -227,6 +232,13 @@ static bool writeback_throttling_sane(struct scan_=
control *sc)
> >  #endif
> >       return false;
> >  }
> > +
> > +static int sc_swappiness(struct scan_control *sc, struct mem_cgroup *m=
emcg)
> > +{
> > +     if (sc->proactive && sc->proactive_swappiness)
> > +             return *sc->proactive_swappiness;
> > +     return mem_cgroup_swappiness(memcg);
> > +}
>
> If you really want to make this sc->proactive bound then do not use
> CONFIG_MEMCG as sc->proactive is not guarded either.
>
> I do not think that sc->proactive check is really necessary. A pure NULL
> check is sufficient to have a valid and self evident code that is future
> proof. But TBH this is not the most important aspect of the patch to
> spend much more time discussing. Either go with sc->proactive but make
> it config space consistent or simply rely on NULL check (with or without
> MEMCG guard as both are valid options).

Now you see why I replied. That "hybrid" if statement is just neither
of what was suggested.

