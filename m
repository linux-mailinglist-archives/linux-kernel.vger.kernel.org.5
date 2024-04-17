Return-Path: <linux-kernel+bounces-148987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 591068A8A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C9A2841E6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB76171E6D;
	Wed, 17 Apr 2024 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IzYJ8H9/"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710F1171065
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374544; cv=none; b=tE1QJo2T3OpvK8yaBDDKjZOzk07fjQnzxSCPJqDcTWUktL2plRQ1ijxFz9beQoJG57U3xb3MUYEdEkYgYboy5MLiSomEpP8PbcPCTDEfQfHF3jKgM2OjkcBY+Lt7AM+15roFfnKISQONepu9scNKGWIPUnwGBYZLhZxnaMR0vkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374544; c=relaxed/simple;
	bh=tLRtMi9r2i1h39kQd9vETDobB4gCES9yT4inm+DKJuM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kcycO4Ak6EEUYLA3A+vrns+KVGac9iFIj89KxNWG2h9Ht63vL/E4kvF6aUBeUcC1twVy5d/fznBxiAhcrk9VfAqXKpGqf2YO35VxzqYIeUwvATLh6lMq+iaKmdprnPgjMzoK3YFF8MBjaJT2oiEBBz+EILIg5XRNKYNeCSpXhyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IzYJ8H9/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61aecbcb990so37591987b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713374540; x=1713979340; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GpN2EoQmT6H5WU6J9NoAPDgtZu4AduZcdc3lBItN25E=;
        b=IzYJ8H9/KWQ8chqSNw06L7SgZhNVfvgZsMFT56INWihfMdx2yy/eH3IR009iUizPOC
         Yxhgzt0GeMvBikI85RVsRPXE4Dkq5Gf1EY4a39nQAQIY9jZwlSi6qiZQbZAAtwMSvEVw
         2ckGk3iN/DajXp91SyZlt/Y1KgfDwFb7r2a6UAD8lc7dVixt/h6EWfSMGkTuX8sUN9hO
         MgIME8BLIM4ItnMVvH/zI0jNAdSP8MvFaF6Ji1ACzO8HbXqaTvoypiTf469hgobcL9lj
         c0Hz8WI3INOBUxfN/6aakF0gdbmEQqXOtPe/9KizQ/lZ5VHsBR2BOWDtcwJ8A36koAnS
         9JKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713374540; x=1713979340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GpN2EoQmT6H5WU6J9NoAPDgtZu4AduZcdc3lBItN25E=;
        b=mLfdcdUflhGZAWWPB/o9/P8JUyXTRq1kg+a+EoMhjBQn1w1SY1OZ+aAXk6cSm8yGuJ
         9mTNAqqCEe85ysrOANXnrUIB6eMcDpVZv1kNMiRIOZ6O00BaDRv7WY6dyIT1cRYh08iK
         q3YzAk+lvwzKM1t9ccunvy8OdhXlsGwhWdaJVNV0YQakKQjbaE3r/gKwOrR694biHKVE
         BC679vynZbkD/69v+Q3k+juOZya4I/EFImZ/92PooDHjr0hywCOAly1/VVxXTnERpEHE
         WmZliSqj2XFGsUcuaK+E2+k9QJV8UNNEduh7eliCz6JWeF0jZyJA+ojAN9yGEgjGr7MK
         sOGA==
X-Forwarded-Encrypted: i=1; AJvYcCXcDGQPs/HwxvTDduMbv6eEqNZqArhWQ5SJ5DGK6I5sroWDOGzAoTX9g1XSiLFC+qE/Szr3on812OCMm7Dxxq8HcMdKKr4nAv2m3Xge
X-Gm-Message-State: AOJu0YxLn2EuV42RYZqd2fz7ZkIUOc9fxIcexdSeKPmWjLwqEdMl1p2x
	Ksj386a+uxXRLQZGuJ5Rq2qmEduxDtPDdbwv/MTlS2Zyib/AD6VCZZZhrqsQxPvneyixsXl6UOD
	lAw==
X-Google-Smtp-Source: AGHT+IEye8Qm8OFniBt/LlnNLGzLn36JW6PPwXAo8xHrMsXB8z1c0kHHX+2lxxZoS7SeiBzadDSZ9Hy/Tdw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:8407:0:b0:ddd:6bde:6c82 with SMTP id
 u7-20020a258407000000b00ddd6bde6c82mr4523853ybk.12.1713374540488; Wed, 17 Apr
 2024 10:22:20 -0700 (PDT)
Date: Wed, 17 Apr 2024 10:22:18 -0700
In-Reply-To: <Zh/1U8MtPWQ/yN2T@tpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZgsXRUTj40LmXVS4@google.com> <ZhAAg8KNd8qHEGcO@tpad>
 <ZhAN28BcMsfl4gm-@google.com> <a7398da4-a72c-4933-bb8b-5bc8965d96d0@paulmck-laptop>
 <ZhQmaEXPCqmx1rTW@google.com> <Zh2EQVj5bC0z5R90@tpad> <Zh2cPJ-5xh72ojzu@google.com>
 <Zh5w6rAWL+08a5lj@tpad> <Zh6GC0NRonCpzpV4@google.com> <Zh/1U8MtPWQ/yN2T@tpad>
Message-ID: <ZiAFSlZwxyKzOTRL@google.com>
Subject: Re: [RFC PATCH v1 0/2] Avoid rcu_core() if CPU just left guest vcpu
From: Sean Christopherson <seanjc@google.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Leonardo Bras <leobras@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 17, 2024, Marcelo Tosatti wrote:
> On Tue, Apr 16, 2024 at 07:07:32AM -0700, Sean Christopherson wrote:
> > On Tue, Apr 16, 2024, Marcelo Tosatti wrote:
> > > > Why not have
> > > > KVM provide a "this task is in KVM_RUN" flag, and then let the existing timeout
> > > > handle the (hopefully rare) case where KVM doesn't "immediately" re-enter the guest?
> > > 
> > > Do you mean something like:
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index d9642dd06c25..0ca5a6a45025 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3938,7 +3938,7 @@ static int rcu_pending(int user)
> > >                 return 1;
> > >  
> > >         /* Is this a nohz_full CPU in userspace or idle?  (Ignore RCU if so.) */
> > > -       if ((user || rcu_is_cpu_rrupt_from_idle()) && rcu_nohz_full_cpu())
> > > +       if ((user || rcu_is_cpu_rrupt_from_idle() || this_cpu->in_kvm_run) && rcu_nohz_full_cpu())
> > >                 return 0;
> > 
> > Yes.  This, https://lore.kernel.org/all/ZhAN28BcMsfl4gm-@google.com, plus logic
> > in kvm_sched_{in,out}().
> 
> Question: where is vcpu->wants_to_run set? (or, where is the full series
> again?).

Precisely around the call to kvm_arch_vcpu_ioctl_run().  I am planning on applying
the patch that introduces the code for 6.10[*], I just haven't yet for a variety
of reasons.

[*] https://lore.kernel.org/all/20240307163541.92138-1-dmatlack@google.com

> So for guest HLT emulation, there is a window between
> 
> kvm_vcpu_block -> fire_sched_out_preempt_notifiers -> vcpu_put 
> and the idle's task call to ct_cpuidle_enter, where 
> 
> ct_dynticks_nesting() != 0 and vcpu_put has already executed.
> 
> Even for idle=poll, the race exists.

Is waking rcuc actually problematic?  I agree it's not ideal, but it's a smallish
window, i.e. is unlikely to happen frequently, and if rcuc is awakened, it will
effectively steal cycles from the idle thread, not the vCPU thread.  If the vCPU
gets a wake event before rcuc completes, then the vCPU could experience jitter,
but that could also happen if the CPU ends up in a deep C-state.

And that race exists in general, i.e. any IRQ that arrives just as the idle task
is being scheduled in will unnecessarily wakeup rcuc.

> > >         /* Is the RCU core waiting for a quiescent state from this CPU? */
> > > 
> > > The problem is:
> > > 
> > > 1) You should only set that flag, in the VM-entry path, after the point
> > > where no use of RCU is made: close to guest_state_enter_irqoff call.
> > 
> > Why?  As established above, KVM essentially has 1 second to enter the guest after
> > setting in_guest_run_loop (or whatever we call it).  In the vast majority of cases,
> > the time before KVM enters the guest can probably be measured in microseconds.
> 
> OK.
> 
> > Snapshotting the exit time has the exact same problem of depending on KVM to
> > re-enter the guest soon-ish, so I don't understand why this would be considered
> > a problem with a flag to note the CPU is in KVM's run loop, but not with a
> > snapshot to say the CPU recently exited a KVM guest.
> 
> See the race above.

Ya, but if kvm_last_guest_exit is zeroed in kvm_sched_out(), then the snapshot
approach ends up with the same race.  And not zeroing kvm_last_guest_exit is
arguably much more problematic as encountering a false positive doesn't require
hitting a small window.

> > > 2) While handling a VM-exit, a host timer interrupt can occur before that,
> > > or after the point where "this_cpu->in_kvm_run" is set to false.
> > >
> > > And a host timer interrupt calls rcu_sched_clock_irq which is going to
> > > wake up rcuc.
> > 
> > If in_kvm_run is false when the IRQ is handled, then either KVM exited to userspace
> > or the vCPU was scheduled out.  In the former case, rcuc won't be woken up if the
> > CPU is in userspace.  And in the latter case, waking up rcuc is absolutely the
> > correct thing to do as VM-Enter is not imminent.
> > 
> > For exits to userspace, there would be a small window where an IRQ could arrive
> > between KVM putting the vCPU and the CPU actually returning to userspace, but
> > unless that's problematic in practice, I think it's a reasonable tradeoff.
> 
> OK, your proposal looks alright except these races.
> 
> We don't want those races to occur in production (and they likely will).
> 
> Is there any way to fix the races? Perhaps cmpxchg?

I don't think an atomic switch from the vCPU task to the idle task is feasible,
e.g. KVM would somehow have to know that the idle task is going to run next.
This seems like something that needs a generic solution, e.g. to prevent waking
rcuc if the idle task is in the process of being scheduled in.

