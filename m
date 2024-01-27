Return-Path: <linux-kernel+bounces-41332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5C483EEF8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 18:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6BB2B2281E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE9A2CCDF;
	Sat, 27 Jan 2024 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="SC+dZn2h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NxWMip8R"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1B125742;
	Sat, 27 Jan 2024 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706376060; cv=none; b=QFIuiQvFT3/eh4z0Od67ohYwcd7P7/pUVbS80+HTA7RowjSqZ5WkWkGy4W0ZK3ubbtImihksH3/bDWZ4cxBKgj5Kz/+3sIdnro3IVdFdboBolr3Rmgco6QO2RCN95Jg8nL9vbdmgAbvUwgVG/4qBhZnkdo3f2byTGUwDQVvj2u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706376060; c=relaxed/simple;
	bh=MrNZ0lsmC4nCokdcaCbB8U2uhplRv26LJunDX8l5hpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8us701yeWIcp/HSK+McfViLclBVCzAcJAO8Frewf1edDvI7LKeFDe8QLcFm3Qc4cQ5CCq8G/hGHUInwkzW+Fj5P6LhtpgUWm+grEkPZDYtYU3VDoA6jVKJ/f2RD7mRn99oR5s5jduYP+/TbT7M0346YFrEOu+U5WK4iNr9Ip+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=SC+dZn2h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NxWMip8R; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 089025C0138;
	Sat, 27 Jan 2024 12:20:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 27 Jan 2024 12:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706376057; x=1706462457; bh=nbMwIMY1jG
	fYgh8XC3jiMM9wMXebNHMQl7ZiJ95g1ag=; b=SC+dZn2hd+qu+IaizJiimC7JGl
	x57cN2ayq45ToA6d1EsYX1iJe7NTmjBrQmu+3oAdti1DHodiwWOMS23DoZpPUUQC
	ZnVu0wsw2F+MPBPd1OLpmynmrOWesR9rkknYGapgUAqKVoHbOFOzS6hUU+yx1KIC
	HQJnm+lJ5s15/s/ngFR6xcZ64p/m+EmseSSvJ3s8kXv87HwottLr0ONBo+aECJNm
	tPpjDmGD/u017JYCiNOce2NCxQ5dGTcK+PhaTq1Y91sPYAzy7SU+O5bSTHooVUuO
	9clcFNZQ50ZYPs3Y7KnpIByHoTWJJlXrH+8SjmM+cOB4M4qig7K29cyKqeaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706376057; x=1706462457; bh=nbMwIMY1jGfYgh8XC3jiMM9wMXeb
	NHMQl7ZiJ95g1ag=; b=NxWMip8RWAraEgg2cDzGghSCLHZ+7yMehJO5lR93N2PU
	62PinYpyuLBV8yuFDsTvouE4ZTdQm4eJGvOgn+e4CbpxuXuLf1t6MgIKPlAJlTqm
	mwFPHQE38CXxLUp0jKLIjCybr2tLXk7DaffLJILEyURgQG1JxuSHL8jP4CoKehEQ
	GrSUmhXtTKnXN3GTqoreIsczSP98GadB2G5QH/IBZRMHDWU4LfU8TDbHIEeXgVxz
	4qRwvdbF7au6w8+QCohJsWcarN+Cl1FFHSfpVLrWA0Oy0O63Kx7BoFK49IcSUays
	OxYRKRYzP7RfeP0AjMBRka5vyCmrkcEOxXFEaiDagA==
X-ME-Sender: <xms:eDu1ZWDteRXlYVBvrjKjhX3rs-oYDtaLvXWtukaByHGC46AB2kYr6Q>
    <xme:eDu1ZQhupAzqi-gLKqRY58KIxuYQ_toTxQxkN_HCyf_QUWTSgB0Uxl-yh20kj8Av6
    iZBSYmz4W0MkUmA5rw>
X-ME-Received: <xmr:eDu1ZZlhnnP68hrHtdYGInc1njpQAaalpf96nCT03jP8uykJ-odRNPheaCqGS5G8XpP67mNNcJqTjWE_fXOJaYanooif>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelledgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:eDu1ZUxwDnLjQoLz75X1klFBcZn1x8-x6dXyjPSN6KZ6hRHTm7tGhA>
    <xmx:eDu1ZbTcXTMFv0rEY6bIoYaEnrVZ3seFKbiqhUE_7s0HaPLfqnPeKw>
    <xmx:eDu1ZfZMF0LQgYL_K8GgqQ7MxRJ1YfMzrDTRrtzZVc8Vm5MYN4lChg>
    <xmx:eTu1ZcKvOLogZ5GUDjdDfTSya4HozTQpY7weH91ZtlK3Ax7U-98xEg>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Jan 2024 12:20:56 -0500 (EST)
Date: Sat, 27 Jan 2024 10:20:55 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <ZbU7d0dpTY08JgIl@tycho.pizza>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
 <20240125140830.GA5513@redhat.com>
 <ZbQpPknTTCyiyxrP@tycho.pizza>
 <20240127105410.GA13787@redhat.com>
 <ZbUngjQMg+YUBAME@tycho.pizza>
 <20240127163117.GB13787@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127163117.GB13787@redhat.com>

On Sat, Jan 27, 2024 at 05:31:39PM +0100, Oleg Nesterov wrote:
> On 01/27, Tycho Andersen wrote:
> >
> > It seems like (and the current pidfd_test enforces for some cases)
> 
> Which pidfd_test ?

I was thinking of poll_pidfd() in pidfd_test.c, but,

> > we
> > want exactly one notification for a task dying.
> 
> This can't be right. EVERY user of poll_wait() or wait_event/etc
> must handle/tolerate the false wakeups.

you're right, it doesn't enforce exactly once.

> > I don't understand
> > how we guarantee this now, with all of these calls.
> 
> I don't understand why do we need or even want to guarantee this.
> 
> The extra wakeup must be always fine correctness-wise. Sure, it
> would be nice to avoid the unnecessary wakeups, and perhaps we
> can change wake_up_all() to pass a key to, say, only wake_up the
> PIDFD_THREAD waiters from exit_notify(). But certainly this is
> outside the scope of PIDFD_THREAD change we discuss.
> 
> The changes in do_notify_parent() (I have already sent the patch) and
> in exit_notify() (proposed in my previous email) just ensure that,
> with the minimal changes, we avoid 2 do_notify_pidfd's from the same
> exit_notify() path.

Sounds good.

> > > exit_notify() is called after exit_files(). pidfd_getfd() returns
> > > ESRCH if the exiting thread completes release_task(), otherwise it
> > > returns EBADF because ->files == NULL. This too doesn't really
> > > depend on PIDFD_THREAD.
> >
> > Yup, understood. It just seems like an inconsistency we might want to
> > fix.
> 
> Not sure this worth "fixing"...

Yep, maybe not. Just wanted to point it out.

Tycho

