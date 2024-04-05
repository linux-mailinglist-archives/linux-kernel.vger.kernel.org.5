Return-Path: <linux-kernel+bounces-133094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51736899EBB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0605E285112
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1156A16D9C8;
	Fri,  5 Apr 2024 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fxWS8vfT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vRvQnvnW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5AB2E401;
	Fri,  5 Apr 2024 13:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324992; cv=none; b=q99gJXGBkXYpAkYsXC5wDFNH3Pv3QJ7JBsXDqCtFCfc204p1B7JbSC2541QLiLoXindvbFOrdrjVucf/xHnpv5ShAXRMoQAa35t9rbsfnP5Sn5bYGDX5NWng8CZeiDEk23JKsgUXMq0A1E4Bq+1AbIzSv5/jYh81AGaV8NFyLdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324992; c=relaxed/simple;
	bh=Yh6tb71zvPKChuofRzQ+jAmdGm2HUzLM6pFKbvX9nEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBG+UqTPMsAEThxWMVEa18hWt5dXBTZ/UxZ1pppQZvmVXGCqiHCqjdC/eq+hAlLKjs0yDhuHjxjM+7VddA6a6IS1BB4JZ9CPpp1YTgBp3X1SUHA9EjzKUJhzOIDfPWJ/teahKPuMKnbm9KiSZp4yCWxeMJ1S1LQTiUXDn8f5NZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fxWS8vfT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vRvQnvnW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 5 Apr 2024 15:49:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712324988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KfinOOmRqv4TiYT3J4ii30g+NwwcvO6ie7kv9r4otrM=;
	b=fxWS8vfThFgtVfNVrfxto+hy2vU3Cc4H2eBhmROJ8OHw+DRog7DYb4i7coSwQZSsWFAxGV
	nETxmsR3lByOyCUdHItK90a5yxTqjf4c+oeJ9+ZNchI1mZind/YjdakyGsxiUZ6sC0VtC1
	H7jw9BoKFT1R+Wio6Q4Etn+Vn+rQDrVDBwlvVEzAVBT9+cclOXSSIWoEQae/+c7VUF3e+g
	vI/Up8UoJc8AryokLQfkgNfTf7IVy5UrHEVKppi3Py58a1/1I8AnoHyN1GWWAf8n5S3+uU
	2Al7UE1uKNg+Au4lwPCiO3WfAeXMH++x9C6zr8Lo7KtdPAwHLLp3P6jDe7cDSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712324988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KfinOOmRqv4TiYT3J4ii30g+NwwcvO6ie7kv9r4otrM=;
	b=vRvQnvnWLH1+h/yHjM4QKU6SVZhlNolDRNjj2oV+ctzgEuZeHyDtIuhBzZOmm8soM0eN16
	6oPDnpSlQq2c3wDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yan Zhai <yan@cloudflare.com>
Cc: paulmck@kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Joel Fernandes <joel@joelfernandes.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 net 1/3] rcu: add a helper to report consolidated
 flavor QS
Message-ID: <20240405134946.NzqmEyX1@linutronix.de>
References: <cover.1710877680.git.yan@cloudflare.com>
 <90431d46ee112d2b0af04dbfe936faaca11810a5.1710877680.git.yan@cloudflare.com>
 <20240322112413.1UZFdBq5@linutronix.de>
 <123ca494-dc8c-47cc-a6d5-3c529bc7f549@paulmck-laptop>
 <CAO3-PbqRztEC1JFg3SrgUi9a404Xpou_Xx9_mxXoZVY-KVkyGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAO3-PbqRztEC1JFg3SrgUi9a404Xpou_Xx9_mxXoZVY-KVkyGg@mail.gmail.com>

On 2024-03-22 21:02:02 [-0500], Yan Zhai wrote:
> On Fri, Mar 22, 2024 at 4:31=E2=80=AFPM Paul E. McKenney <paulmck@kernel.=
org> wrote:
> >
> > On Fri, Mar 22, 2024 at 12:24:13PM +0100, Sebastian Andrzej Siewior wro=
te:
> > > On 2024-03-19 13:44:34 [-0700], Yan Zhai wrote:
> > > > + * The macro is not needed when CONFIG_PREEMPT_RT is defined. RT k=
ernels would
> > > > + * have more chance to invoke schedule() calls and provide necessa=
ry quiescent
> > > > + * states. As a contrast, calling cond_resched() only won't achiev=
e the same
> > > > + * effect because cond_resched() does not provide RCU-Tasks quiesc=
ent states.
> > > > + */
> > >
> > > Paul, so CONFIG_PREEMPTION is affected but CONFIG_PREEMPT_RT is not.
> > > Why does RT have more scheduling points?
> >
> > In RT, isn't BH-disabled code preemptible?  But yes, this would not help
> > RCU Tasks.
Yes, it is but why does it matter? This is used in the NAPI thread which
fully preemptible and does cond_resched(). This should be enough.

> By "more chance to invoke schedule()", my thought was that
> cond_resched becomes no op on RT or PREEMPT kernel. So it will not
> call __schedule(SM_PEREEMPT), which clears the NEED_RESCHED flag. On a
It will nop cond_resched(), correct. However once something sends
NEED_RESCHED then the receiver of this flag will __schedule(SM_PEREEMPT)
as soon as possible. That is either because the scheduler sends an IPI
and the CPU will do it in the irq-exit path _or_ the thread does
preempt_enable() (which includes local_bh_enable()) and the counter hits
zero at which point the same context switch happens.

Therefore I don't see a difference between CONFIG_PREEMPT and
CONFIG_PREEMPT_RT.

> normal irq exit like timer, when NEED_RESCHED is on,
> schedule()/__schedule(0) can be called time by time then.

This I can not parse. __schedule(0) means the task gives up on its own
and goes to sleep. This does not happen for the NAPI-thread loop,
kworker loop or any other loop that consumes one work item after the
other and relies on cond_resched() in between.

> __schedule(0) is good for RCU tasks, __schedule(SM_PREEMPT) is not.
Okay and that is why? This means you expect that every thread gives up
on its own which may take some time depending on the workload. This
should not matter.

If I see this right, the only difference is rcu_tasks_classic_qs() and I
didn't figure out yet what it does.

> But I think this code comment does not take into account frequent
> preempt_schedule and irqentry_exit_cond_resched on a PREEMPT kernel.
> When returning to these busy kthreads, irqentry_exit_cond_resched is
> in fact called now, not schedule(). So likely __schedule(PREEMPT) is
> still called frequently, or even more frequently. So the code comment
> looks incorrect on the RT argument part. We probably should remove the
> "IS_ENABLED" condition really. Paul and Sebastian, does this sound
> reasonable to you?

Can you walk me through it? Why is it so important for a task to give up
voluntary? There is something wrong here with how RCU tasks works.
We want to get rid of the sprinkled cond_resched(). This looks like a
another variant of it that might be required in places with no
explanation except it takes too long.=20

> Yan

Sebastian

