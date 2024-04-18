Return-Path: <linux-kernel+bounces-149437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DADC8A9124
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A0AB21155
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2790D4E1BE;
	Thu, 18 Apr 2024 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tuX5plZ+"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75E2481A7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406803; cv=none; b=YNAkTw3tqlMTn1LEb598z0qsoBu9nQS+7u394pbS6W/vDLnvHMnEZaOSOmj/g16poliEh4/PabRz7M1/y2Y5Xvsku8le1tgcfIo8TunVkPNHD/H6huKj/DstwJHjbFOXAEMU3d0kHPQx+CHd/p5ddETppcGKg+fX/8c/u7qWcOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406803; c=relaxed/simple;
	bh=RdX3hBeambhUwtUbPCfKYg0ONGhQHhSOOXYxifTN1XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0bOsEIJjjcSnTg+0uOQ5J5FKEdCNd3pgOgxnfa32ytrDjQ+nQwZczfDUgjWYdxAM9nulg9n771rACDq5jSg0alAJ7I2c/+hsgeuwFimfndheo/87CZ+T1W2rPDMN1Mg+b4/0G8K92oCAdNtwCgGI72h7xXxZSmocJ+0MR1Y5Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tuX5plZ+; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516dc51bb72so365409e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 19:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713406800; x=1714011600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZUBtcOuh4tZX+VBSdand1Gk2+djVxkGCB8r1DIsuKU=;
        b=tuX5plZ+AKIMXhKV/NkHIFlySyfxyt4RErMFQxmj5Yk8cYbswgg337kRsADp2bE8wW
         Z4tscTZ8507MEtGjgXNR00i1aOkqGuzPK26cyJhinfiKSJrAQI1rBS27w5uxcS9j6sHS
         71Kg7UkFJxXagxs9Qcng5z+l+WmYAmpTImrfvwWSS+Si5CN2Zic5swU319Pxr76lMeEP
         1tDg5nv86u5c2LO78g7ItmISvz3uExnvfW2SeX9xfgOOXKqAgOgAWIAfsCMJbWie/KuD
         4Emk7KBGqoc5keKzL26QPRcypENMlD2DvBvMWyckAG2+35KCYTYpqktGfgcroqOQdILb
         Wz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713406800; x=1714011600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZUBtcOuh4tZX+VBSdand1Gk2+djVxkGCB8r1DIsuKU=;
        b=n6r44Wc19R/ZKX11ikGxDLAFcy8uSuijSdBTa3OGiZUzbSZjtbtsZvGSwEimRbacbn
         pFIjZOYnoUU8rClKU+Vr0hQAEWrHzETL8pIjBJ/Mh59mQMm+lKRVGt93ZMQU3wAOfi/a
         Z3vDNKgroW+JFaojQJUoEgyFQJvvddP1h40namh0tHlHtTHGBp1oUisEW+8l1Wu33OGR
         yjrlNaVlq+4fwqxk2Ji3q0gClAcUKvSrmswFKvbsMVz4uQzNICvkddYG8bOcOw1e3nZ7
         F8BIYaSke6XVU73va4Xhp08rksgvyiPFTiZBCm9jncWzLXXBe/DPIRPDDSCF3+Ck4yy6
         ckrw==
X-Forwarded-Encrypted: i=1; AJvYcCXIL6aYP9uxX/NCvc+01lLe/1RPvon6vCn8bh2jbsIPpxO+XJQhkjVNQUemcD9eF4vkYiqMInXfBduMVYROt7zIUDRf0XvIZMAY5td2
X-Gm-Message-State: AOJu0Yynoq0U5xcpU94Dvb8TZ+220eLvV6H7fdWfbKEMG5JcfNec69lO
	PKOe0Bt+eQTGAYYsWF3hqoTDdbqOa61b870dY48sEuEYPsSiPA88k2vH88KYnCDeSq1te5lLXdC
	104VmjrRKYTuPPRY7KDb1D5GDNkL81nCgUAzBN8l/S2latm//tRG1CIg=
X-Google-Smtp-Source: AGHT+IGcsMlJFNtz4Wb4Xe1MH6eieW6vX+0//7/qp2kTOMG+G32KLjSuQdOumHYhlT0kb5Kfe4k+6rHp4QdNpVzW9z8=
X-Received: by 2002:ac2:4356:0:b0:516:7739:354c with SMTP id
 o22-20020ac24356000000b005167739354cmr487518lfl.58.1713406799629; Wed, 17 Apr
 2024 19:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171328983017.3930751.9484082608778623495.stgit@firesoul> <171328989335.3930751.3091577850420501533.stgit@firesoul>
In-Reply-To: <171328989335.3930751.3091577850420501533.stgit@firesoul>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Apr 2024 19:19:23 -0700
Message-ID: <CAJD7tkZFnQK9CFofp5rxa7Mv9wYH2vWF=Bb28Dchupm8LRt7Aw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] cgroup/rstat: convert cgroup_rstat_lock back to mutex
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
	cgroups@vger.kernel.org, longman@redhat.com, netdev@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, shakeel.butt@linux.dev, 
	kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 10:51=E2=80=AFAM Jesper Dangaard Brouer <hawk@kerne=
l.org> wrote:
>
> Since kernel v4.18, cgroup_rstat_lock has been an IRQ-disabling spinlock,
> as introduced by commit 0fa294fb1985 ("cgroup: Replace cgroup_rstat_mutex
> with a spinlock").
>
> Despite efforts in cgroup_rstat_flush_locked() to yield the lock when
> necessary during the collection of per-CPU stats, this approach has led
> to several scaling issues observed in production environments. Holding
> this IRQ lock has caused starvation of other critical kernel functions,
> such as softirq (e.g., timers and netstack). Although kernel v6.8
> introduced optimizations in this area, we continue to observe instances
> where the spin_lock is held for 64-128 ms in production.
>
> This patch converts cgroup_rstat_lock back to being a mutex lock. This
> change is made possible thanks to the significant effort by Yosry Ahmed
> to eliminate all atomic context use-cases through multiple commits,
> ending in 0a2dc6ac3329 ("cgroup: removecgroup_rstat_flush_atomic()"),
> included in kernel v6.5.
>
> After this patch lock contention will be less obvious, as converting this
> to a mutex avoids multiple CPUs spinning while waiting for the lock, but
> it doesn't remove the lock contention. It is recommended to use the
> tracepoints to diagnose this.

I will keep the high-level conversation about using the mutex here in
the cover letter thread, but I am wondering why we are keeping the
lock dropping logic here with the mutex?

If this is to reduce lock contention, why does it depend on
need_resched()? spin_needbreak() is a good indicator for lock
contention, but need_resched() isn't, right?

Also, how was this tested?

When I did previous changes to the flushing logic I used to make sure
that userspace read latency was not impacted, as well as in-kernel
flushers (e.g. reclaim). We should make sure there are no regressions
on both fronts.

>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>  kernel/cgroup/rstat.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index ff68c904e647..a90d68a7c27f 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -9,7 +9,7 @@
>
>  #include <trace/events/cgroup.h>
>
> -static DEFINE_SPINLOCK(cgroup_rstat_lock);
> +static DEFINE_MUTEX(cgroup_rstat_lock);
>  static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
>
>  static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
> @@ -238,10 +238,10 @@ static inline void __cgroup_rstat_lock(struct cgrou=
p *cgrp, int cpu_in_loop)
>  {
>         bool contended;
>
> -       contended =3D !spin_trylock_irq(&cgroup_rstat_lock);
> +       contended =3D !mutex_trylock(&cgroup_rstat_lock);
>         if (contended) {
>                 trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, cont=
ended);
> -               spin_lock_irq(&cgroup_rstat_lock);
> +               mutex_lock(&cgroup_rstat_lock);
>         }
>         trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
>  }
> @@ -250,7 +250,7 @@ static inline void __cgroup_rstat_unlock(struct cgrou=
p *cgrp, int cpu_in_loop)
>         __releases(&cgroup_rstat_lock)
>  {
>         trace_cgroup_rstat_unlock(cgrp, cpu_in_loop, false);
> -       spin_unlock_irq(&cgroup_rstat_lock);
> +       mutex_unlock(&cgroup_rstat_lock);
>  }
>
>  /* see cgroup_rstat_flush() */
> @@ -278,7 +278,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *=
cgrp)
>                 }
>
>                 /* play nice and yield if necessary */
> -               if (need_resched() || spin_needbreak(&cgroup_rstat_lock))=
 {
> +               if (need_resched()) {
>                         __cgroup_rstat_unlock(cgrp, cpu);
>                         if (!cond_resched())
>                                 cpu_relax();

