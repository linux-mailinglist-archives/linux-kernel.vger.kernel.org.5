Return-Path: <linux-kernel+bounces-101106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEA287A27D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 05:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82C01F22C50
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E621170D;
	Wed, 13 Mar 2024 04:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPwQh8/D"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB32D2FF;
	Wed, 13 Mar 2024 04:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710305403; cv=none; b=ut4vdD+TIth9+mxNWEkwc9SIR4tzeP0BLFEvQnZoSGPSiuYjGKiofKs52zF6iGuhpylG6Cd9yQJos5rrYn5jLeXM4RqyTGJLtPtzW9Pz3oXQcnJmg+BxsG2BP91y9lOPI9Elhtf8jzgQeYApOnYQnTBtZ/5aKjBVL9EhPT382fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710305403; c=relaxed/simple;
	bh=WwxG/B0gshgsTKOw4me1Uj+A+gU2SI72ZWI+5GdfXWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gacNzcvZZWqrKZHDzA2vNMMc+TmHPl05YzLKN9AMyzHoDgrd20G+YyUMCMQU1/AXBZQeQwWV0nFHDzCVCphtG+Us0Cma6MBQxzyQp3UTKhEc0ItJonf8lBWQz4VESmlZa63XdKVK9I+kooK+Tuaa4rMv4ORiatNSmUzm1YfwQ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPwQh8/D; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29bc1c64a98so2986799a91.1;
        Tue, 12 Mar 2024 21:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710305402; x=1710910202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hdURf2+D6b6wN1i849F0qpjoi0tt6fdpM+XzqHCp8oQ=;
        b=VPwQh8/D3k9He+eRjw+YW1Bx8j6+UrCSebX7jYbXbWReV/KRxB4ZjAxOfomrwB4zd/
         YJKdINMNZKHRNHabz+rB3CvbiXKykdolu571kAv3h+fVCOfU4gKVHoMSB4puuEDPeXlB
         4Z+CpAxdrJM05TZxdUJ1bXte/T2FkEsr7xTljWgBkKAz7lK8ic+IuWTbzsu0wnX7nBJD
         pS59Bk9HELPLmZ7O/aSrOJ7CB1k2U/Ms38D3v4FtZfxllFBnkgoPO2ArGVzbDBjgEQfH
         UALJLMtzUSusgp9ryc3A23r+LteeUwQSGboDAWEhQ1RZwynM+rB7eS8s5WX6XQf5AClv
         3mIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710305402; x=1710910202;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hdURf2+D6b6wN1i849F0qpjoi0tt6fdpM+XzqHCp8oQ=;
        b=Gf9qytI3gsJ3DLSZ6quvtsv5exyN2DkoU1VBDQgMvRXGEYzIwLqI7SlvyTS/1INIxQ
         nvbzyT1zb1T/ZafTe30lapcee89IITLzuHv7I93+vnBwgbgpMLbk1EmXaorl3z1xrNPF
         IeniTjQSzhIXWImN6oRxDTLUUdqcmf148dQ2WpE5CDikDaAm+7FyEFgpV+L5nOlxOlJ5
         wbl3L8Z2gYjAp+6gaTQ60j3Bqtc9K8ECmQDBfuKSce8evy0IApGJyA9mV71b6RKdbGUD
         pl0pXHsxkjqgkmGVJL37qi3sxfw0Wqq4ihawPiFRCmaWqNoHM/gteVtPkdAHOS77NxHR
         dbEw==
X-Forwarded-Encrypted: i=1; AJvYcCWSJ3o/yZ4PTTXFSgZ1pfObflBtbIHXYhmle+m/DFBFClMQ+kBJlkMf9B3xZ4D4QHLCtfn/g7prHBrcdvJLgcB2N53/aaf7aU6lUFyA3QvN7mVl4Q5EvB5mG2CqyoiNmnKF
X-Gm-Message-State: AOJu0YykqGN3TyMwbV0M4YyipslgopuuKIFXU9YOG/MbrJLGp245FQb0
	pMcf3+kOUHbrsiX2OGk4qpfGHXtkN19YnzqOAhRKkwXFEh9oFwr0fmcTM0pxfkQM1I0t3h9KFBA
	Gl9atFntzoBkwELAStXnQjbdiRnc=
X-Google-Smtp-Source: AGHT+IG506P/qLUcAz+DzZjFYxO/4gbRN5Li8A7uheaDC8VCVvFieKNxM+qVYOypst3djy+I8ePeTFWhSMfeUcpyp4E=
X-Received: by 2002:a17:90a:ad82:b0:29b:cc7d:60cd with SMTP id
 s2-20020a17090aad8200b0029bcc7d60cdmr7650977pjq.32.1710305401722; Tue, 12 Mar
 2024 21:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312113524.7654-1-qiang.zhang1211@gmail.com> <d3762d8c-1996-4703-8fa2-f0b00febf2fb@paulmck-laptop>
In-Reply-To: <d3762d8c-1996-4703-8fa2-f0b00febf2fb@paulmck-laptop>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Wed, 13 Mar 2024 12:49:50 +0800
Message-ID: <CALm+0cVivqMsTi0P_4dSK5XSE1ZW_Xx=9_h61VapZTtuOoUwDw@mail.gmail.com>
Subject: Re: [PATCH] rcu-tasks: Remove unnecessary lazy_jiffies in call_rcu_tasks_generic_timer()
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Tue, Mar 12, 2024 at 07:35:24PM +0800, Zqiang wrote:
> > The rcu_tasks_percpu structure's->lazy_timer is queued only when
> > the rcu_tasks structure's->lazy_jiffies is not equal to zero in
> > call_rcu_tasks_generic(), if the lazy_timer callback is invoked,
> > that means the lazy_jiffes is not equal to zero, this commit
> > therefore remove lazy_jiffies check in call_rcu_tasks_generic_timer().
> >
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > ---
> >  kernel/rcu/tasks.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index b1254cf3c210..439e0b9a2656 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -299,7 +299,7 @@ static void call_rcu_tasks_generic_timer(struct timer_list *tlp)
> >
> >       rtp = rtpcp->rtpp;
> >       raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> > -     if (!rcu_segcblist_empty(&rtpcp->cblist) && rtp->lazy_jiffies) {
> > +     if (!rcu_segcblist_empty(&rtpcp->cblist)) {
>
> Good eyes!
>
> But did you test with something like a WARN_ON_ONCE(rtp->lazy_jiffies)?

Hi, Paul

+  if (!rcu_segcblist_empty(&rtpcp->cblist) &&
!WARN_ON_ONCE(!rtp->lazy_jiffies))

I've done tests like this:

1. runqemu nographic kvm slirp qemuparams="-smp 4 -m 2048M -drive
file=$PWD/share.img,if=virtio"
bootparams="rcupdate.rcu_tasks_trace_lazy_ms=0" -d

2.  insmod torture.ko
     insmod rcutorture.ko torture_type=tasks-tracing fwd_progress=4

3. bpftrace -e 't:timer:timer_expire_entry /args->function ==
kaddr("call_rcu_tasks_generic_timer")/
                                            {
printf("comm:%s,cpu:%d,stack:%s,func:%s\n", comm, cpu, kstack,
ksym(args->function)); }'

The call_rcu_tasks_generic_timer() has never been executed.

Thanks
Zqiang


>
>                                                 Thanx, Paul
>
> >               if (!rtpcp->urgent_gp)
> >                       rtpcp->urgent_gp = 1;
> >               needwake = true;
> > --
> > 2.17.1
> >

