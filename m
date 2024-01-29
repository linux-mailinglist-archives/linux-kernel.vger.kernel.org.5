Return-Path: <linux-kernel+bounces-42908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7161084085A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14B09B26199
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAD214A0AA;
	Mon, 29 Jan 2024 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="IRYT/Zcs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u44/savz"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A27148FF8;
	Mon, 29 Jan 2024 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538702; cv=none; b=LsajUqyJSswNgqFdz/FmBFt8cHiYIl3QFeJCKjru6eoB71US7SIZOEzBCOoLGrgT7w1iPDNpRRyJMYFA9fDdZBbikf49Yp1HRZdVUVn0VzKwIr6sMU4FIOcJ5+8eXKN4lnKxn31G/rSW43D/hx3cjK+zzV9vJHmn9jsaGcQHE94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538702; c=relaxed/simple;
	bh=RizKcmX3RRLlgUG/ugjzq4ScN+Mw8mbriMNFmh8enxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONBVnLh0o3Gi7ZRQrEwDZaqy90d2X7mB9BuHsEXSTNYAxtN+QgkzRuJNHDllqUlP7JzIUeJVacqiM8yrv13Ga5QCsHLenfJUQxCzGWlnELz6HuVA8WXkx/tUbkdzEYy5sbNL5zuY1Z4mGsIJNydDLFv67sXdLNhC00YJssrzZ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=IRYT/Zcs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u44/savz; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 9CBFB5C0140;
	Mon, 29 Jan 2024 09:31:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 29 Jan 2024 09:31:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706538698; x=1706625098; bh=B4pNIPUED5
	e8/0rG6KTfg7B2imzrt3EK7wCNXBQ9N68=; b=IRYT/Zcs6PYprK1iWpOsU2VzBk
	TslIQkVJQT9LxvrAJaPlNSUzUi/8CaBLdQCiM26bn2kyRhZfrRvjzwDOPpZJ1DCM
	QoN9TjnyOXhd649b3bCh+hIEh2qR8PR4xvMQpiViLLUeJEW6YLQw+DP72SY1SDSd
	jI4prNKUSxpCrV2777oUcMdnoc3vNcV3h5j1wrl04RHdfgYuM4AF8LGvYba/nTIE
	4tzEtX/+L2asEPn0tEaa0o+QtwueTKDQ2wacTfj2+Jx9kUuSON44Cu85ihy6GK5T
	ReqdecmTZPARZFyC86X/JJ/WbvOHnRT46oczemdveC0Clwg7Vm/fbtzpe0VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706538698; x=1706625098; bh=B4pNIPUED5e8/0rG6KTfg7B2imzr
	t3EK7wCNXBQ9N68=; b=u44/savz0unPS7y0N5xrioUI4Cxd1N1aPBZbBm+j+n12
	qvN4XcwjJCi9ilJqC2JBZLNhws0oAQ0vW+up5o9fDcXdHaFeRSbGVOnofUiLoQDF
	RcHchMet0eE+oMWSyrYxHBd+T9fCPlkoryF5uUWFGx4tWod8RUhN1/t+4O4JKArZ
	ozdj+l8uGkmK9rpdEODB59zQ0BHctoBlpn73duuE5nZhjs8jnlMCHl70XZAUrBP4
	/oG9qu+4evjxv8bwDlmeb3O+mHvtHAVI+5tH3P+WkW1ILtCmKGss3N9kyUYFtgP6
	hYRwXTCWIfsXmXQsqwbbKjzzQlVL+POUrU4OubbRFA==
X-ME-Sender: <xms:yra3ZdV1gsg_pVamSpA4-LtoqVN2H4ria7dIolDj7zgSLAtxkYhc0A>
    <xme:yra3ZdmluzNukBcMeNZvP5NAaC2ThgFnTsuP0a1t_K5q1DUHYcEBC327uhZ4UkXSk
    cEqd1DxtlWm8wZT_G8>
X-ME-Received: <xmr:yra3ZZbrUqdmVBca6i62oeGpvbTKbkI8ngx4BWM85d-F4XKxK0S6OXLBhDtKTozSKDTJSIFWReKnwY0pDqVb0pnHQEXv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:yra3ZQV_IkUkZlJy8saaoFq_Jn6ryzoUwJrkSL8sf4TRi9UIosT4Xw>
    <xmx:yra3ZXlXrhhmCtcMItaTgknnHUx98osIkJ07LJgdZbXUckqzdZLGyg>
    <xmx:yra3ZdeQRDfgKYsOwgcnPrMkNRhWCwZjzzujdLteV_eLngi2SuO7iA>
    <xmx:yra3ZSvRfR0Zqr-sL3lENBOeC7LZ0nTzC6x0y8Cxrl-edqRe-K-wbQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 09:31:37 -0500 (EST)
Date: Mon, 29 Jan 2024 07:31:35 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC PATCH] pidfd: implement PIDFD_THREAD flag for pidfd_open()
Message-ID: <Zbe2x+M8tDBotSNZ@tycho.pizza>
References: <ZbQpPknTTCyiyxrP@tycho.pizza>
 <20240127105410.GA13787@redhat.com>
 <ZbUngjQMg+YUBAME@tycho.pizza>
 <20240127163117.GB13787@redhat.com>
 <ZbU7d0dpTY08JgIl@tycho.pizza>
 <20240127193127.GC13787@redhat.com>
 <ZbVrRgIvudX242ZU@tycho.pizza>
 <20240127210634.GE13787@redhat.com>
 <20240129112313.GA11635@redhat.com>
 <20240129-plakat-einlud-4903633a5410@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129-plakat-einlud-4903633a5410@brauner>

On Mon, Jan 29, 2024 at 02:41:11PM +0100, Christian Brauner wrote:
> On Mon, Jan 29, 2024 at 12:23:15PM +0100, Oleg Nesterov wrote:
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -2051,7 +2051,8 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
> >  	WARN_ON_ONCE(!tsk->ptrace &&
> >  	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
> >  	/*
> > -	 * tsk is a group leader and has no threads, wake up the pidfd waiters.
> > +	 * tsk is a group leader and has no threads, wake up the !PIDFD_THREAD
> > +	 * waiters.
> >  	 */
> >  	if (thread_group_empty(tsk))
> >  		do_notify_pidfd(tsk);
> > @@ -3926,6 +3927,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
> >  		prepare_kill_siginfo(sig, &kinfo);
> >  	}
> >  
> > +	/* TODO: respect PIDFD_THREAD */
> 
> So I've been thinking about this at the end of last week. Do we need to
> give userspace a way to send a thread-group wide signal even when a
> PIDFD_THREAD pidfd is passed? Or should we just not worry about this
> right now and wait until someone needs this?

I don't need it currently, but it would have been handy for some of
the tests I wrote.

Should I fix those up and send them too on top of Oleg's v2?

Tycho

