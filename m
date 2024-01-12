Return-Path: <linux-kernel+bounces-25046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED93382C6A5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51E5EB24539
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 21:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1916168D0;
	Fri, 12 Jan 2024 21:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="DqOmpaSf"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D0915E9B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 21:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3ea8d0f9dso6375ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 13:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705094886; x=1705699686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulXxKHR6+R96Ym936Wr/tcnuVWt4HjQnt79btAUo6a0=;
        b=DqOmpaSf/B1pXGXUqfS3pKupk9Wld7SexcnXm/77qKem3y5KONGoZJYkjuWR/PVeri
         v09eOUWkkfqDjHhqjwdZwJTGXssy9BR3RseUfcGG550Dp21t7JGectP8tvgbiofs9ZcA
         McQMWmsX7Er8A1+FB2IDsP0yG35NKjUtax0gRkhuP47zWFtZVuKPGQWREYUGP4c8OX9n
         KBxjXzUfJRdeVsHNza3HgxvGyOW56vyweKJKPFw10T9i/u2Ei8iVs6efeGp2vUzOzpiw
         /xweuYCzF8+6sNRTRGT2h05CUbAwKZkTYDoij+vTPZ+X34fPjlP8N9JHaeSUECpiKQf5
         MB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705094886; x=1705699686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulXxKHR6+R96Ym936Wr/tcnuVWt4HjQnt79btAUo6a0=;
        b=Ku6H0bHI1N6rWXQjTnytitL0NJP/FI6XhuoRqOw4bIZ+chntOAPB67bNh7boUdtV4K
         XYZXkR8UofUeTH+FKvXVG//Nyqs16YdJia6iNaF9/fLJuPtub+wk5IyLDPKzo84yzWyJ
         Atgq1sClBDoHukC7zi4EWBfC5+1FgZxhiV3fP+66AKMZxaj4k8OyXweqGDIIIK6jh/rG
         zMXyM/Dn/gWdeFAgbVp60LOofD9tNdV4y+ar05o+85Mgl0c1cO2NUCOtIaDzHkvCnKTk
         drOGY1HJy2THa8eAIQggdsl98eTcrqQ/3Af1jNHu9LtijB3j06eEA5rQhXVeb+oBCD4A
         xq+A==
X-Gm-Message-State: AOJu0YzqqtkYzVLjNZd9muIKKb1cm7jd+u2f+IkLwplN6iS1AGFH7Kpf
	0WfQ6Gr6ujjNSYi0bGqUv3wsOPtZpzebWg3SwuNAMHwF5MDd
X-Google-Smtp-Source: AGHT+IHTke8Gkj+PF60nPCJXSujK1CjK+FPxEcsD43yT9XaiGsxSwmhN8j5WvcvtGmrPhj7ZMJslu5DxyXB0dGIAeOY=
X-Received: by 2002:a17:902:e54b:b0:1d3:c36b:4833 with SMTP id
 n11-20020a170902e54b00b001d3c36b4833mr460116plf.27.1705094885609; Fri, 12 Jan
 2024 13:28:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111132902.389862-1-hannes@cmpxchg.org> <ZaAsbwFP-ttYNwIe@P9FQF9L96D>
 <20240111192807.GA424308@cmpxchg.org> <CALvZod6eb2uPPW+y=CnB_KumOW-MJjqJK=zOqfzwwJ-JX9eP0g@mail.gmail.com>
 <ZaGoSdNpouolFHdT@P9FQF9L96D.corp.robot.car>
In-Reply-To: <ZaGoSdNpouolFHdT@P9FQF9L96D.corp.robot.car>
From: Shakeel Butt <shakeelb@google.com>
Date: Fri, 12 Jan 2024 13:27:54 -0800
Message-ID: <CALvZod5nLdpLgweBU0MtsMzBK=vTnJnRgr5FAhku3d=Atw1Cow@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: don't throttle dying tasks on memory.high
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Dan Schatzberg <schatzberg.dan@gmail.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 1:00=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Fri, Jan 12, 2024 at 11:04:06AM -0800, Shakeel Butt wrote:
> > On Thu, Jan 11, 2024 at 11:28=E2=80=AFAM Johannes Weiner <hannes@cmpxch=
g.org> wrote:
> > >
> > [...]
> > >
> > > From 6124a13cb073f5ff06b9c1309505bc937d65d6e5 Mon Sep 17 00:00:00 200=
1
> > > From: Johannes Weiner <hannes@cmpxchg.org>
> > > Date: Thu, 11 Jan 2024 07:18:47 -0500
> > > Subject: [PATCH] mm: memcontrol: don't throttle dying tasks on memory=
high
> > >
> > > While investigating hosts with high cgroup memory pressures, Tejun
> > > found culprit zombie tasks that had were holding on to a lot of
> > > memory, had SIGKILL pending, but were stuck in memory.high reclaim.
> > >
> > > In the past, we used to always force-charge allocations from tasks
> > > that were exiting in order to accelerate them dying and freeing up
> > > their rss. This changed for memory.max in a4ebf1b6ca1e ("memcg:
> > > prohibit unconditional exceeding the limit of dying tasks"); it noted
> > > that this can cause (userspace inducable) containment failures, so it
> > > added a mandatory reclaim and OOM kill cycle before forcing charges.
> > > At the time, memory.high enforcement was handled in the userspace
> > > return path, which isn't reached by dying tasks, and so memory.high
> > > was still never enforced by dying tasks.
> > >
> > > When c9afe31ec443 ("memcg: synchronously enforce memory.high for larg=
e
> > > overcharges") added synchronous reclaim for memory.high, it added
> > > unconditional memory.high enforcement for dying tasks as well. The
> > > callstack shows that this path is where the zombie is stuck in.
> > >
> > > We need to accelerate dying tasks getting past memory.high, but we
> > > cannot do it quite the same way as we do for memory.max: memory.max i=
s
> > > enforced strictly, and tasks aren't allowed to move past it without
> > > FIRST reclaiming and OOM killing if necessary. This ensures very smal=
l
> > > levels of excess. With memory.high, though, enforcement happens lazil=
y
> > > after the charge, and OOM killing is never triggered. A lot of
> > > concurrent threads could have pushed, or could actively be pushing,
> > > the cgroup into excess. The dying task will enter reclaim on every
> > > allocation attempt, with little hope of restoring balance.
> > >
> > > To fix this, skip synchronous memory.high enforcement on dying tasks
> > > altogether again. Update memory.high path documentation while at it.
> > >
> > > Fixes: c9afe31ec443 ("memcg: synchronously enforce memory.high for la=
rge overcharges")
> > > Reported-by: Tejun Heo <tj@kernel.org>
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> >
> > Acked-by: Shakeel Butt <shakeelb@google.com>
> >
> > I am wondering if you have seen or suspected a similar issue but for
> > remote memcg charging. For example pageout on a global reclaim which
> > has to allocate buffers for some other memcg.
>
> You mean dying tasks entering a direct reclaim mode?
> Or kswapd being stuck in the reclaim path?

No, a normal task (not dying and not kswapd) doing global reclaim and
may have to do pageout which may trigger allocation of buffer head in
folio_alloc_buffers(). We increase current->memcg_nr_pages_over_high
irrespective of current in target memcg or not. Basically I just want
to know if this is a real concern or can be ignored for now.

