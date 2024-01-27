Return-Path: <linux-kernel+bounces-41259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D046383EE1D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C87DB2194F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D436B29422;
	Sat, 27 Jan 2024 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="lVxB7mZj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f7pxCGsB"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110051DFCF;
	Sat, 27 Jan 2024 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706370952; cv=none; b=pN0VUjvaHLlLQ3ckf3S19lQ0QxjMOIReiENjPOfKai6nUDYkYdzJld4c2dvKvHM8avR82vCwwmqkqc0umM+qO5n8RXYTPNvEPC6gwG54nNLP2FnS10BBjWC/iIm/tIZBqTAaklOOf1bviz1xhvT4Rhi2tji4F9PgC2Yk49pnziY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706370952; c=relaxed/simple;
	bh=6pSCSML+JZghD5BCwhywGlyJjYkC36czSX7oYgXB6kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwLTvQIFjFp7yoHKg4G6fSe+eZk7pHHVgHTgaVAGgfK9kqRXEZd/BSWmU68R3rkwBsbskh698bb4FGY/8PDUaJOb0bgSIwMldXuRhnwgZDH7uphCd2V0WgJR2Z0OnfInh0VEes/mvgipeqqoCR4SeSMN4sVacWK8jaIJZnRfO/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=lVxB7mZj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f7pxCGsB; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id E1D4D138005D;
	Sat, 27 Jan 2024 10:55:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sat, 27 Jan 2024 10:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706370948; x=1706457348; bh=XfDO2zRIy9
	wsN7s/nMkXYnVjBmeZXSXaD7ior0H/odU=; b=lVxB7mZjA6tJNRWp3txpcXiHnh
	FHpbqi1YB7ihEvndA27XeZudZmGvQT20qo0cfSfV2PDGYRPrcONjySGDwg+NRLAe
	HH161jTvi1GZgm8i6bLcCAs0TajaGLgiqqloJWpOVhOCJzTE141AB8S5dV945wTx
	RFbO7m5m5T4cCXE8R1Hnb2F7H8ELpOH/jflbqVj/JtEmCFu5REuVfqa52bwGXGFZ
	DLWf4yPFNTcOmmlhfEnoYssQoNVmzJSy86Ws9n5++kCUNyqG4XEfZ0av4hM8vWFR
	mSCdFgch1ABMs5Eb5CtumWzXgNL47YazthIZVPFybEvDK5ZtjjHdLVJr4eZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706370948; x=1706457348; bh=XfDO2zRIy9wsN7s/nMkXYnVjBmeZ
	XSXaD7ior0H/odU=; b=f7pxCGsBi50yamg5NRNINORKpelSWzECMMUqPIyC6J6E
	f2kOTL/u+dXKhVz6PEPARiVw6Tp0f2jUSrQvCSCFfkdUcp8IS33SQG/zSbv7NOQu
	i+x43Gh4ZQuduk+2nI0QY1q9PqL1pWrlvKA9e+dnXVzkIrFl2DRaIW6hwrEI/HA+
	PrOW8FUbjgeAjl9HhJjJhjU4Jt2InI85mCHeSSLH+m6JwF2eDHM4ROgCDd/UYPMJ
	hbOcV2CpnFT/x0pWl2ZCcDMjCGdedTeyFumQw4v/7fj8BDxZ8rHNzgmqT0m9rTI+
	GCEdAfYKxWhkZ5e06iQw90igFl8K8w6gm5V+G0mw+w==
X-ME-Sender: <xms:hCe1ZTCocb6So8Ov_ro8422rLodtAp71dm9PiUnZqbOCLenuyi-Neg>
    <xme:hCe1ZZjYtSd2uZ4g1AK9wypDDIHSbNpZHNXMkOppJ-10tKOEf0bEx6HyzaDhBh6_d
    7wppt9Bb7std298TsI>
X-ME-Received: <xmr:hCe1Zekghrzq4gOu0y00E8Q2rkc5BljEUrWOFnbnUrUXtjaBAUfls8kIzhG-PQaxSOsciBwxQe45Ob2T0FiJ9RqWlVqa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelledgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:hCe1ZVzFXHD-SDgov7xNej7ntQBKG0cHcM8QBOK_7ehM0wQhyPSuQA>
    <xmx:hCe1ZYR05CV5UHHGhW_0Ao6M0tbaC2Tf3LE0GNa8qy42PL2911AOSA>
    <xmx:hCe1ZYbQisX4Hcfffk3vQkhT5OnOJdG6QGfWqEPuKluaolGw6YtSLQ>
    <xmx:hCe1ZXF5WR8zoRqSBVEcH7aJOaFpRrrdKFsqjjfSTnNC1M5u_xHRlQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Jan 2024 10:55:47 -0500 (EST)
Date: Sat, 27 Jan 2024 08:55:46 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <ZbUngjQMg+YUBAME@tycho.pizza>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
 <20240125140830.GA5513@redhat.com>
 <ZbQpPknTTCyiyxrP@tycho.pizza>
 <20240127105410.GA13787@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127105410.GA13787@redhat.com>

On Sat, Jan 27, 2024 at 11:54:32AM +0100, Oleg Nesterov wrote:
> Hi Tycho,
> 
> On 01/26, Tycho Andersen wrote:
> >
> > On Thu, Jan 25, 2024 at 03:08:31PM +0100, Oleg Nesterov wrote:
> > > What do you think?
> >
> > Thank you, it passes all my tests.
> 
> Great, thanks!
> 
> OK, I'll make v2 on top of the recent
> "pidfd: cleanup the usage of __pidfd_prepare's flags"
> 
> but we need to finish our discussion with Christian about the
> usage of O_EXCL.
> 
> As for clone(CLONE_PIDFD | CLONE_THREAD), this is trivial but
> I think this needs another discussion too, lets do this later.
> 
> > > +	/* unnecessary if do_notify_parent() was already called,
> > > +	   we can do better */
> > > +	do_notify_pidfd(tsk);
> >
> > "do better" here could be something like,
> >
> > [...snip...]
> 
> No, no, please see below.
> 
> For the moment, please forget about PIDFD_THREAD, lets discuss
> the current behaviour.
> 
> > but even with that, there's other calls in the tree to
> > do_notify_parent() that might double notify.
> 
> Yes, and we can't avoid this. Well, perhaps do_notify_parent()
> can do something like
> 
> 	if (ptrace_reparented())
> 		do_notify_pidfd();
> 
> so that only the "final" do_notify_parent() does do_notify_pidfd()
> but this needs another discussion and in fact I don't think this
> would be right or make much sense. Lets forget this for now.

It seems like (and the current pidfd_test enforces for some cases) we
want exactly one notification for a task dying. I don't understand
how we guarantee this now, with all of these calls.

> > This brings up another interesting behavior that I noticed while
> > testing this, if you do a poll() on pidfd, followed quickly by a
> > pidfd_getfd() on the same thread you just got an event on, you can
> > sometimes get an EBADF from __pidfd_fget() instead of the more
> > expected ESRCH higher up the stack.
> 
> exit_notify() is called after exit_files(). pidfd_getfd() returns
> ESRCH if the exiting thread completes release_task(), otherwise it
> returns EBADF because ->files == NULL. This too doesn't really
> depend on PIDFD_THREAD.

Yup, understood. It just seems like an inconsistency we might want to
fix.

> > I wonder if it makes sense to abuse ->f_flags to add a PIDFD_NOTIFIED?
> > Then we can refuse further pidfd syscall operations in a sane way, and
> 
> But how? We only have "struct pid *", how can we find all files
> "attached" to this pid?

Yeah, we'd need some other linkage as Christian points out. But if
there is a predicate we can write that says whether this task has been
notified or not, it's not necessary. I just don't understand what that
is. But maybe your patch will make it clearer.

Tycho

