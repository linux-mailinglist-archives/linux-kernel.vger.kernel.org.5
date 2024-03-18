Return-Path: <linux-kernel+bounces-105658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC35C87E22A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691B3282FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A7418E01;
	Mon, 18 Mar 2024 02:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCOizNUF"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5260B1FDA;
	Mon, 18 Mar 2024 02:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710729357; cv=none; b=QwHh5ZnZqC9DwcyMccmKK3HHEiWwE1ugZZQQh29zlIENQ/7TVyQzPOTRRxrHWEJ1JQF6zib8e0LuJQEVkbKmIzRa8DcOjNkPxXem7vdIGvN7MB011wvFwQAIFdAvzUJaVvI36XUMEQqp7hZSoos3FYUMJ468fkMvM+D9v5SBmi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710729357; c=relaxed/simple;
	bh=FnoOAYUOB6rqcTZNLh67mN2fPg76TscfNK+xU17Qvng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvsEFVAq87Nj5kA5xRF+igWFGhcca2YapCyiuk+wKXWxz/xbF/YuLmILnho33pwavHXX7KKR5fi4u6YHKbwDoIaSdCSkYao801WGkL/0M6SIsfr3ofNAdwGiMpIeP+5DcJoyLuFYarWtoOI/H82XP+9omXQ9R3uui8vNrvNu2Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCOizNUF; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so1895754a12.0;
        Sun, 17 Mar 2024 19:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710729355; x=1711334155; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=npf0p8XFV/u0mm7I1PVkpQOQUhK9i02/i/IuswXV1F8=;
        b=JCOizNUFP3YTXHS7FJ9AVMIPjhCxKjQov+U/rwjVH05SoAzKFgUlzfTo+MUj0qdciw
         Ii0IW+3MNK1r9bKtQFoBqNMdMHDxXRuExBCAxxCV9A5FpL4O7nTxOh5lhMMWe7UmF243
         2Q/m1TGy5cfgsjcvDpTHMfu98hiaZ55+Vj54qzBJZy/5juJorHhlOsmkpDlhfWVCygxF
         juU7VIPnCeWRoWz30+8FLSXC2ibfoQGs6oh8MT56SUa1R36sm0fq2XN+1sbp91AeKSUR
         nbEBidnNz8DrmEoadg98CFvGk3LdVWeK8RNt2PgIqQLcYt79KUMCjRrUjFKq2sflcOCE
         UZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710729355; x=1711334155;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=npf0p8XFV/u0mm7I1PVkpQOQUhK9i02/i/IuswXV1F8=;
        b=qOWNkGtQqYXA9TeGAmN4oxAl16IOF+w5f27+aak59DBJ/+8rXCOZrVDrZJdj9W+GkJ
         +sXTeEn7fK7YehzZjIj3e1ZNnAk06a6J5aqTYwI3tUiwnP8ccs7kikPrSc1Ywu2B7yaf
         UnBs83YpFHMLY0R7/WjwRycsPh8K/3PHgRYqhAE6Flk9NXtMwuO1gb121WClP2U0J+F4
         T3IHpRHwDwfn90UVqoY3W14EzI/rT4bMHbepo6OhMNQjKG3VBH2skYHw9kfPVkBTDe/e
         B0ZHTn9nnFWlARccR4KseEA+1bzNtCrXCYDDRL6HXVZmcDzlOaDt52aZ8b3m20TosSGc
         z7+w==
X-Forwarded-Encrypted: i=1; AJvYcCXUX92HzsWCh4bbP77at6FVpSZU/aEqQRCe4Y8NMVrp4mHhdNvtlBjVXzuSYciPFonzqVmgUfvDmSk8EDStf0J+veJMeIbqO+awYGw4G6tQUUnHzwFg7vMF1bEgvjfVCbGl
X-Gm-Message-State: AOJu0Yy0BjYRtdsJmKcUWiaGH+Ee7//ElDuqtcu9Z7kUM1xHpzk61PKS
	cBBnifEntpJKYdQlK+VwzQKYjoxVuv3Cz/QHf0JU0MixIr8xIYzpLvIhFepnwJHbA9KReAjfN55
	GbKMUm3Pn4L9lDJRg+bb6Ysv6Zf+IFAJ3atE=
X-Google-Smtp-Source: AGHT+IGCztcvOHGIP0/1SwF2d24lJChQA4ooc/Cxa3IbRtlK77eRBwJ+yrsYyaf1oEnxxZdyJC1DND7oKLuRToGo0ac=
X-Received: by 2002:a17:90a:a82:b0:29a:b982:bbe2 with SMTP id
 2-20020a17090a0a8200b0029ab982bbe2mr8478861pjw.11.1710729355481; Sun, 17 Mar
 2024 19:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312113524.7654-1-qiang.zhang1211@gmail.com>
 <d3762d8c-1996-4703-8fa2-f0b00febf2fb@paulmck-laptop> <CALm+0cVivqMsTi0P_4dSK5XSE1ZW_Xx=9_h61VapZTtuOoUwDw@mail.gmail.com>
 <986428d9-5d82-463c-908b-b88435d53e79@paulmck-laptop> <CALm+0cWf9ODsxodfm+3JHciuEAe4=0fA3R4n4rhjh7XZzHonNQ@mail.gmail.com>
 <ed220ce3-943f-4554-8f79-fd5da1dfb458@paulmck-laptop>
In-Reply-To: <ed220ce3-943f-4554-8f79-fd5da1dfb458@paulmck-laptop>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Mon, 18 Mar 2024 10:35:44 +0800
Message-ID: <CALm+0cVywbBNfzZBjcxJNvpeixkBrfPZu_4qSnOXQvqYTbjMyg@mail.gmail.com>
Subject: Re: [PATCH] rcu-tasks: Remove unnecessary lazy_jiffies in call_rcu_tasks_generic_timer()
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Sun, Mar 17, 2024 at 10:31:22PM +0800, Z qiang wrote:
> > > On Wed, Mar 13, 2024 at 12:49:50PM +0800, Z qiang wrote:
> > > > > On Tue, Mar 12, 2024 at 07:35:24PM +0800, Zqiang wrote:
> > > > > > The rcu_tasks_percpu structure's->lazy_timer is queued only when
> > > > > > the rcu_tasks structure's->lazy_jiffies is not equal to zero in
> > > > > > call_rcu_tasks_generic(), if the lazy_timer callback is invoked,
> > > > > > that means the lazy_jiffes is not equal to zero, this commit
> > > > > > therefore remove lazy_jiffies check in call_rcu_tasks_generic_timer().
> > > > > >
> > > > > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > > > > ---
> > > > > >  kernel/rcu/tasks.h | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > > > > index b1254cf3c210..439e0b9a2656 100644
> > > > > > --- a/kernel/rcu/tasks.h
> > > > > > +++ b/kernel/rcu/tasks.h
> > > > > > @@ -299,7 +299,7 @@ static void call_rcu_tasks_generic_timer(struct timer_list *tlp)
> > > > > >
> > > > > >       rtp = rtpcp->rtpp;
> > > > > >       raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> > > > > > -     if (!rcu_segcblist_empty(&rtpcp->cblist) && rtp->lazy_jiffies) {
> > > > > > +     if (!rcu_segcblist_empty(&rtpcp->cblist)) {
> > > > >
> > > > > Good eyes!
> > > > >
> > > > > But did you test with something like a WARN_ON_ONCE(rtp->lazy_jiffies)?
> > > >
> > > > Hi, Paul
> > > >
> > > > +  if (!rcu_segcblist_empty(&rtpcp->cblist) &&
> > > > !WARN_ON_ONCE(!rtp->lazy_jiffies))
> > > >
> > > > I've done tests like this:
> > > >
> > > > 1. runqemu nographic kvm slirp qemuparams="-smp 4 -m 2048M -drive
> > > > file=$PWD/share.img,if=virtio"
> > > > bootparams="rcupdate.rcu_tasks_trace_lazy_ms=0" -d
> > > >
> > > > 2.  insmod torture.ko
> > > >      insmod rcutorture.ko torture_type=tasks-tracing fwd_progress=4
> > > >
> > > > 3. bpftrace -e 't:timer:timer_expire_entry /args->function ==
> > > > kaddr("call_rcu_tasks_generic_timer")/
> > > >                                             {
> > > > printf("comm:%s,cpu:%d,stack:%s,func:%s\n", comm, cpu, kstack,
> > > > ksym(args->function)); }'
> > > >
> > > > The call_rcu_tasks_generic_timer() has never been executed.
> > >
> > > Very good!
> > >
> > > Then if we get a couple of acks or reviews from the others acknowledging
> > > that if they ever make ->lazy_jiffies be changeable at runtime, they
> > > will remember to do something to adjust this logic appropriately, I will
> > > take it.  ;-)
> > >
> >
> > Hi, Paul
> >
> > Would it be better to modify it as follows? set needwake not
> > depend on lazy_jiffies,  if  ->lazy_jiffies be changed at runtime,
> > and set it to zero, will miss the chance to wake up gp kthreads.
> >
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index e7ac9138a4fd..aea2b71af36c 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -299,11 +299,12 @@ static void call_rcu_tasks_generic_timer(struct
> > timer_list *tlp)
> >
> >         rtp = rtpcp->rtpp;
> >         raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> > -       if (!rcu_segcblist_empty(&rtpcp->cblist) && rtp->lazy_jiffies) {
> > +       if (!rcu_segcblist_empty(&rtpcp->cblist)) {
> >                 if (!rtpcp->urgent_gp)
> >                         rtpcp->urgent_gp = 1;
> >                 needwake = true;
> > -               mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
> > +               if (rtp->lazy_jiffies)
> > +                       mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));
> >         }
> >         raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> >         if (needwake)
>
> Interesting approach!
>
> But how does that avoid defeating laziness by doing the wakeup early?

Hello, Paul

Does this mean that if cblist is empty, we will miss the opportunity to
enqueue the timer again?  If so, we can move mod_timer() outside
the if condition.
or I didn't understand your question?

Thanks
Zqiang


>
>                                                         Thanx, Paul
>
> > Thanks
> > Zqiang
> >
> >
> > >                                                         Thanx, Paul
> > >
> > > > Thanks
> > > > Zqiang
> > > >
> > > >
> > > > >
> > > > >                                                 Thanx, Paul
> > > > >
> > > > > >               if (!rtpcp->urgent_gp)
> > > > > >                       rtpcp->urgent_gp = 1;
> > > > > >               needwake = true;
> > > > > > --
> > > > > > 2.17.1
> > > > > >

