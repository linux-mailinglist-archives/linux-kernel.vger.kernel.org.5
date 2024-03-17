Return-Path: <linux-kernel+bounces-105401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6370187DD69
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A24281415
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 14:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEBFD304;
	Sun, 17 Mar 2024 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1xjF1ih"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5531367;
	Sun, 17 Mar 2024 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710685896; cv=none; b=Z2KukYCAUydeGPeJeU9/fjCpRUz3I5A09Ya/5KfZ77MZdkd3FbQxCK26lzoyQVhmPIrvmIwhWFtIn1xjKmIpbHMzZ+DqHGn50gKMM5XRB1ysDvV5yDoLqkq4n23rTqg2ziS/Akski86sDyD94z2WhrqnTSgaMlT7SsmgpUvHnGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710685896; c=relaxed/simple;
	bh=4qtfH+7TI3C8v+2lQMgpX7BD1L9BxcTm8n2lOGhUO8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MC7QHmH3rhuXAqr1wGuV6x0GgGXWYbututr0vsTsuBrofmZZ/6bfHeGbU0v0k8qS7mwr9+OB4dCjoHooB4HUK7UCNZoEnltXmTauC+iZvRsVK0YRQ+qhvcaRgnMgL0jgN4XkA/LRTklw1nxvIyy35APt7QiVeDWmwiLAfYGSiEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1xjF1ih; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6082eab17so3185827b3a.1;
        Sun, 17 Mar 2024 07:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710685894; x=1711290694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=03voW317BoL2q72KgiafRj9pewXFvRIQF0YvYjeYXSo=;
        b=T1xjF1ihvGUQVUZc5KrBDo31KQVw3dx6mkRghDD0gcgYT8pnQ3HWWvmMbE0CarpQRK
         DATOm18/MOHERH+kR6BnTJztS6p8ytGfM8QzC/2vTGzw5uS0dn1ZY7hcCLRGC3UBq27g
         YenoD8QOeSGlZV7anBs26gdlY6KPn5WcwxOUv97/D1scD07XipLMFLEVSKGhqZZbimUv
         elAESmf1sEzVbXr34Vk3J/fYRbrXpThxtCIkUygugmc1Ql1ZtUS4PkQODgwChD2T6Shq
         T4yH2kBgcg+7956TKFGnDgHafP8IElVRRyFjJaTdW74ANXMwtAqobxnAsOL0QE0Tr4fn
         73/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710685894; x=1711290694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03voW317BoL2q72KgiafRj9pewXFvRIQF0YvYjeYXSo=;
        b=aIw6COcSRIBTRH4EoD3NYSCxom3itmfDKTe5ClM3tb2yd2/0MIUPvP5z/G+2nXT1LF
         waReS4uatO/2I9qtK37hzUKboLNCsJekfKzJz+froX1Y2l4spSv3dAPabVc+R950TgHz
         8OzV1vUIxqoiMe9py+/JH2q13V6CeOWyT61YGq1Mw1QEVzBveuvviBog7q5eRtBJ1tQr
         hrdhbjloEzR4UvNoCd5t742U26dK3yHySQaCynEiOnT2iFC9pYLh+m9J3fD/ieEEaEGQ
         VNzEI3y2jnMtWxmjFAZdMYNy0OWsKzA9rBzx6qx3Cxm8Kdely+k9cIKsDCh93DLgjIOH
         /SSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUukWLYcrHKOkfuZ1H6kPYnRDm8N4YW7o6c9p5EbAF90gSN+IoHU8w8fS2RGDJ1ri0+n47zkNUxmbKjCOJzJonlTFLapP9FZHvLnYSZuqrwuRVinoYQzE1FvIrhVtIrW9qd
X-Gm-Message-State: AOJu0YxZF1nRwEaDZpX2w1ItN+jvBH1dKvjdICHCAzkFZiaaVSRap1rs
	K78tUXz2M3N6h5WM9I9fbQaW+MAJLJaX7fgZffEIP2DmOL3ImxnKhx05mBn8kfElEmI+zLwz6/8
	9CVC/0nduNtkRH8VpA93RnxtqeIuWKICq+J8=
X-Google-Smtp-Source: AGHT+IFwvgD4cg/hb+9NbZRNMf36dSepv7dAKi7hkB3B4K3BxIC/tB+a2EFlTICzZBSNMUa+HODWmYtL8jH35UWmsE4=
X-Received: by 2002:a05:6a20:9f4f:b0:1a3:115b:acb5 with SMTP id
 ml15-20020a056a209f4f00b001a3115bacb5mr10339657pzb.21.1710685893763; Sun, 17
 Mar 2024 07:31:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312113524.7654-1-qiang.zhang1211@gmail.com>
 <d3762d8c-1996-4703-8fa2-f0b00febf2fb@paulmck-laptop> <CALm+0cVivqMsTi0P_4dSK5XSE1ZW_Xx=9_h61VapZTtuOoUwDw@mail.gmail.com>
 <986428d9-5d82-463c-908b-b88435d53e79@paulmck-laptop>
In-Reply-To: <986428d9-5d82-463c-908b-b88435d53e79@paulmck-laptop>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Sun, 17 Mar 2024 22:31:22 +0800
Message-ID: <CALm+0cWf9ODsxodfm+3JHciuEAe4=0fA3R4n4rhjh7XZzHonNQ@mail.gmail.com>
Subject: Re: [PATCH] rcu-tasks: Remove unnecessary lazy_jiffies in call_rcu_tasks_generic_timer()
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Wed, Mar 13, 2024 at 12:49:50PM +0800, Z qiang wrote:
> > >
> > > On Tue, Mar 12, 2024 at 07:35:24PM +0800, Zqiang wrote:
> > > > The rcu_tasks_percpu structure's->lazy_timer is queued only when
> > > > the rcu_tasks structure's->lazy_jiffies is not equal to zero in
> > > > call_rcu_tasks_generic(), if the lazy_timer callback is invoked,
> > > > that means the lazy_jiffes is not equal to zero, this commit
> > > > therefore remove lazy_jiffies check in call_rcu_tasks_generic_timer().
> > > >
> > > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > > ---
> > > >  kernel/rcu/tasks.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > > index b1254cf3c210..439e0b9a2656 100644
> > > > --- a/kernel/rcu/tasks.h
> > > > +++ b/kernel/rcu/tasks.h
> > > > @@ -299,7 +299,7 @@ static void call_rcu_tasks_generic_timer(struct timer_list *tlp)
> > > >
> > > >       rtp = rtpcp->rtpp;
> > > >       raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> > > > -     if (!rcu_segcblist_empty(&rtpcp->cblist) && rtp->lazy_jiffies) {
> > > > +     if (!rcu_segcblist_empty(&rtpcp->cblist)) {
> > >
> > > Good eyes!
> > >
> > > But did you test with something like a WARN_ON_ONCE(rtp->lazy_jiffies)?
> >
> > Hi, Paul
> >
> > +  if (!rcu_segcblist_empty(&rtpcp->cblist) &&
> > !WARN_ON_ONCE(!rtp->lazy_jiffies))
> >
> > I've done tests like this:
> >
> > 1. runqemu nographic kvm slirp qemuparams="-smp 4 -m 2048M -drive
> > file=$PWD/share.img,if=virtio"
> > bootparams="rcupdate.rcu_tasks_trace_lazy_ms=0" -d
> >
> > 2.  insmod torture.ko
> >      insmod rcutorture.ko torture_type=tasks-tracing fwd_progress=4
> >
> > 3. bpftrace -e 't:timer:timer_expire_entry /args->function ==
> > kaddr("call_rcu_tasks_generic_timer")/
> >                                             {
> > printf("comm:%s,cpu:%d,stack:%s,func:%s\n", comm, cpu, kstack,
> > ksym(args->function)); }'
> >
> > The call_rcu_tasks_generic_timer() has never been executed.
>
> Very good!
>
> Then if we get a couple of acks or reviews from the others acknowledging
> that if they ever make ->lazy_jiffies be changeable at runtime, they
> will remember to do something to adjust this logic appropriately, I will
> take it.  ;-)
>

Hi, Paul

Would it be better to modify it as follows? set needwake not
depend on lazy_jiffies,  if  ->lazy_jiffies be changed at runtime,
and set it to zero, will miss the chance to wake up gp kthreads.

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index e7ac9138a4fd..aea2b71af36c 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -299,11 +299,12 @@ static void call_rcu_tasks_generic_timer(struct
timer_list *tlp)

        rtp = rtpcp->rtpp;
        raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
-       if (!rcu_segcblist_empty(&rtpcp->cblist) && rtp->lazy_jiffies) {
+       if (!rcu_segcblist_empty(&rtpcp->cblist)) {
                if (!rtpcp->urgent_gp)
                        rtpcp->urgent_gp = 1;
                needwake = true;
-               mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
+               if (rtp->lazy_jiffies)
+                       mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
        }
        raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
        if (needwake)

Thanks
Zqiang


>                                                         Thanx, Paul
>
> > Thanks
> > Zqiang
> >
> >
> > >
> > >                                                 Thanx, Paul
> > >
> > > >               if (!rtpcp->urgent_gp)
> > > >                       rtpcp->urgent_gp = 1;
> > > >               needwake = true;
> > > > --
> > > > 2.17.1
> > > >

