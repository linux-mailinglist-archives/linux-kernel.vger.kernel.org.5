Return-Path: <linux-kernel+bounces-36061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DC4839AE0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFCE4B23572
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06062C1A7;
	Tue, 23 Jan 2024 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="sEpcPcLh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cUq4dazu"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F91729434;
	Tue, 23 Jan 2024 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706044228; cv=none; b=ufqiJkhBNBvr7w57j/bAUoC5WceiXxPDt8wRJF+xm/S07YDf+HQ9oPr9M85Re6vYkNagHIMOteCKK42PuDEHLjbmyoSiEyxbrZ7lZ7pv3O2yLCXkG8GvXI1OO5ON3MnS67Dff6w5i8dry9wjlLwZUUS/5+B9trIvKOHH5/74/oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706044228; c=relaxed/simple;
	bh=dYvXX13fIYIhM9hpmdKZ+G8LhU/8/Fw9vf+MJ02McGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/z/DWqFpvV64BumnRtulinw6+glSotT1ERgbxa1EGdiEZJhsg2CIrzZf1gsm0uWLcxvo2oUdWyvnaIS5CgtYb1nquSUYRVLqcFmmmbmMQwTGvPT/DMNC7KO9XqSgojGSckW+FGfXOE3QOTPYj/bb/IEFTPFlvUH/gMh7BoXcAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=sEpcPcLh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cUq4dazu; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 73F975C0191;
	Tue, 23 Jan 2024 16:10:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 23 Jan 2024 16:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706044225; x=1706130625; bh=3s+NYKmSwd
	36BsjF0J4/1gUDj3DMNYT/x588dQ9rC4Y=; b=sEpcPcLhtFfPpPOkJfDXMOfwIa
	a0qNyRNYbATGRyIQ7k3r9aKBzWt5RMniCyN2/88XOqgz38bd+JNvTYuhbpqoF6t3
	ALkeUYA2upmkeqA+A/t8bVwwFEGzS6nDiefBdWftpxR6umOiNy3qvx6cS8btaYlt
	XAS+fO0TtOmyW8Wz3bcHwxBNlGjT9ej/R15jPGuvIMQrkApDvDMs6VzSAZCkHr8d
	ohNHoLf4akahRm9aPNz9JNLtVql+TQAGsnpYEdhD8Fp9axuOc/rIb6sFc3+f7Ezi
	wMRoW3U5fLyBuehSsTDi4/qUseXBPAfDC0iY1cRc47cM4JPrQnRrQC4GmtFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706044225; x=1706130625; bh=3s+NYKmSwd36BsjF0J4/1gUDj3DM
	NYT/x588dQ9rC4Y=; b=cUq4dazu13nOLFBr9VvPcgQMODY1DgLrZkR84WT1RVnJ
	TaxMO4CHhfyxyRfAHnvGHNf+uv2BPabdlxoIRczOGnjaXzDGUGOqTFcD1US7r7up
	qb9dA2akbZxdNTS1y15EqaM4F5uD1HOlOMiQQzI3jE5g2h7FhenTyRHbcJ1Neabf
	MFX77X7uK/dF5ZIw1tRlOot2TL4OlChAdiO1uHV+xJzdadD5iojN4kc0kiTjnSmJ
	oOJTyrlP3ocYbQcLonZPsG4xvxaw83XqNyQrecdmcvelAehyFGUEBlQlIV4LDtSG
	44kcBiZAdI2bqLg3VXmWMHeAkeM+W6Qh6PaLZglDFQ==
X-ME-Sender: <xms:QSuwZfWTuY8hZUygS_6z-EohVpPofLgB0cv2iIBuDd1YkHvEHWd-Qw>
    <xme:QSuwZXk5xBB8vBoowIq8eON88vQ9hYVd_FWvJvkpoiJq4SpLiZfk9eoYDBC3Fo9XN
    uekF6XIdlL6qDfnS9s>
X-ME-Received: <xmr:QSuwZbaGG1BDlUImahpP13Q4o8iieSInqCjPCEiUvlSgp2Fe1LyYOrB3D9_j3UHk8dpl_ck0zEBi2LI7gtkTGfme>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekkedgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigt
    hhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtf
    frrghtthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteek
    lefhleelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:QSuwZaVLax97mIITnZD5FrjpvPqGbbDhPJ8FI5dH2ijEHyXlEOVDEA>
    <xmx:QSuwZZk3BdWAYHm_bi9MyfR2srxnlpt6vStvpvSFV5yj2ndGieGn2w>
    <xmx:QSuwZXe-HtPp1O_kfctY40nfshQ2ZZleXJsKcEItVqxdk0p7fXyVxQ>
    <xmx:QSuwZSAYi9Ll_IOg01eTsY3vpI3RoWxMEOLu5nNIcP0evREWBkyqLQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jan 2024 16:10:21 -0500 (EST)
Date: Tue, 23 Jan 2024 14:10:15 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <ZbArN3EYRfhrNs3o@tycho.pizza>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123195608.GB9978@redhat.com>

On Tue, Jan 23, 2024 at 08:56:08PM +0100, Oleg Nesterov wrote:
> Too late for me, but I don't understand this patch after a quick glance.
> perhaps I missed something...

Thanks for taking a look.

> On 01/23, Tycho Andersen wrote:
> >
> > @@ -256,6 +256,17 @@ void release_task(struct task_struct *p)
> >  	write_lock_irq(&tasklist_lock);
> >  	ptrace_release_task(p);
> >  	thread_pid = get_pid(p->thread_pid);
> > +
> > +	/*
> > +	 * If we're not the leader, notify any waiters on our pidfds. Note that
> > +	 * we don't want to notify the leader until /everyone/ in the thread
> > +	 * group is dead, viz. the condition below.
> > +	 *
> > +	 * We have to do this here, since __exit_signal() will
> > +	 * __unhash_processes(), and break do_notify_pidfd()'s lookup.
> > +	 */
> > +	if (!thread_group_leader(p))
> > +		do_notify_pidfd(p);
> 
> This doesn't look consistent.
> 
> If the task is a group leader do_notify_pidfd() is called by exit_notify()
> when it becomes a zombie (if no other threads), before it is reaped by its
> parent (unless autoreap).

There is another path, also in release_task(), that I was trying to
mirror since it deals explicitly with sub-threads but,

> If it is a sub-thread, it is called by release_task() above. Note that a
> sub-thread can become a zombie too if it is traced.

I didn't know about this.

> >  	__exit_signal(p);
> 
> and,  do_notify_pidfd() is called before __exit_signal() which does
> __unhash_process() -> detach_pid(PIDTYPE_PID).
> 
> Doesn't this mean that pidfd_poll() can hang? thread_group_exited()
> won't return true after do_notify_pidfd() above, not to mention that
> thread_group_empty() is not possible if !thread_group_leader().

I was wondering about this too, but the test_non_tgl_poll_exit test in
the next patch tests exactly this and works as expected.

> So. When do we want to do do_notify_pidfd() ? Whe the task (leader or not)
> becomes a zombie (passes exit_notify) or when it is reaped by release_task?

It seems like we'd want it when exit_notify() is called in principle,
since that's when the pid actually dies. When it is reaped is "mostly
unrelated". Something like,

1. in the "normal" exit_notify() paths via do_notify_parent()
2. if none of those cases are true (aka the final else in
   exit_notify()) and the thread is not ptraced
3. via release_task() finally if this was the thread group leader and
   it died before some sub-thread

then in pidfd_poll(), we can do:

    if (!tsk || (tsk->exit_state >= 0) || thread_group_exited())
        do_notify_pidfd();

?

> Either way pidfd_poll() needs more changes with this patch and it can't
> use thread_group_exited(). If do_notify_pidfd() is called by release_task()
> after __exit_signal(), it can just check pid_has_task(PIDTYPE_PID).

I suppose this is why my test works, since pid_task(PIDTYPE_PID) is null
after release_task(). But if we want it to happen earlier, we'll have
to do something like the above.

Tycho

