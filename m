Return-Path: <linux-kernel+bounces-39133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ED383CB3D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6891F27093
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6662133991;
	Thu, 25 Jan 2024 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="RycUwXwz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ElM0XVZM"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95D779C7;
	Thu, 25 Jan 2024 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706207817; cv=none; b=ixgJ/UebfuGXPAs4snDJnCKxgi+B7B6oSDCnVFjPIDniDfiKA6Ct5Br/YMLSkR0Xol4PgEH0A69A+KjfgOnBewbKlPNFKOop+X3jYbRLNm/uRY7KQhKYKKq7RM/F97M90AKVp0QAtgZjNgnZU2iNpfrPGvSF8oZC2W0+GIQqamU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706207817; c=relaxed/simple;
	bh=UF54OoPnWhCHjd4YHoCkTUMl9/peohQTDd90vfCnJDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8pjlGxG6+wyWtB1j2kd8Pw3KRGAVhZS+R8kq+uVQz3v0g2mxiurPDFJmSPiM1m1WAMabrESHapxDqVDf1fPrOrlPlUM2Kw8ahDwdWzHVRgwu1h7VfQom0yUW8PDbBAURjbGNxJuVQ2FXFEDP9Yo+fYcAJPuPwY/y2uIGsGu3Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=RycUwXwz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ElM0XVZM; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id AB4EE5C00D7;
	Thu, 25 Jan 2024 13:36:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 25 Jan 2024 13:36:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706207813; x=1706294213; bh=CfjLibIYa5
	BzwhBwoi4+HVAjuBeEwvxGVOrZM+/ntKI=; b=RycUwXwzL+doy0qtLxNp1VU07y
	SwLS1WBJ1YLm0mJ/p+6EVVWg0yBUpq5tzR/ofmG6Cx57dgNu31HHxZSQMPxMKxv0
	uEynQonjsyl5J9oaPIoNi+MEVgnSBzUCwckX7zxLDZILn9y+4giy3c38SjHd6Xzs
	USgCpLeVnqkdFzDVWFw6VaSxd/FaMP9pIc32dM2RUZnAdC9Sg9Mv13sFwnXaro1n
	3b7nJNzdrKkuv6wxXkuCPsQDYTjk6dZBEnEHuZg3IkmTINrp4/BkX89M0+TxzRB7
	fjL4TOfN/Mr58CEdQqp+ZKqVgs5RqGcMelYXmY4CMK6KD+77y344JP4cA2Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706207813; x=1706294213; bh=CfjLibIYa5BzwhBwoi4+HVAjuBeE
	wvxGVOrZM+/ntKI=; b=ElM0XVZMzc6Ho5C5QpHT9YZQAny2m3zqD0CJ9+INRgcZ
	DDy6ltqdsporXE+mjPVFJzR8gXWZq3v1Y5B485Yp32g70Tf//IRPFXLHDQdTfJLr
	ekDlidYHqwTudhyHOBEb1mOgmUYmgqtb+Q7sobkXvZdPWQUikPMeKZ0WcAJMTjOL
	WSr6sJAiNUfRXCVwh1Vbh7CXXzri4qNDHJ6ch/mqGRL7j04RtHdjtTcWRh9wZW6z
	AvXAMBisgvEHv1dqZORUltSVJaXpZn8gDRkR0Tk4d/H2rcwMVyAeWAJDZO3qGNSD
	KpWjqGEKTx+Jue/DU7oBDIz75U2kOXh48NQtuSRzPQ==
X-ME-Sender: <xms:RaqyZVeJl9tjNILUUoOSrwclJT2IPDfwjYHo1FJv2JGEXEFBIuraSw>
    <xme:RaqyZTPAE_vnNvEhhDOagimsTMhyAtJweB0kKlEQXyGgq55vdR38s_NEWPXikRM1u
    b6RmCIOlbYPXb2GbDk>
X-ME-Received: <xmr:RaqyZej_egbs6xNPlQyHlaqElEAeYFd9FAA4rT-AM3EXjvqDayXQHV7zPVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelhedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:RaqyZe_RDKMnFLhmhBxR31lIhkF0zKhPT5CT-2py3ol0a7n3VNA3yg>
    <xmx:RaqyZRvhqfd0ffWDwMQyfstGZAKD6y4nEwJSuS-v1rDxJo3JgEMixg>
    <xmx:RaqyZdG2XYOKcnqzykI4eB--rJJSfBuxiEWxP283e9Aw25YqfLMtbQ>
    <xmx:RaqyZfXP5c2UBntKNCJ--PfX2MoyGz4Dt4s46fpMlKbJaal4TkE6SQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jan 2024 13:36:52 -0500 (EST)
Date: Thu, 25 Jan 2024 11:36:50 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <ZbKqQl39WlqX8dgp@tycho.pizza>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
 <20240125140830.GA5513@redhat.com>
 <20240125-tricksen-baugrube-3f78c487a23a@brauner>
 <20240125175113.GC5513@redhat.com>
 <ZbKigMNQM0Yklc/5@tycho.pizza>
 <20240125182505.GD5513@redhat.com>
 <20240125183045.GE5513@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125183045.GE5513@redhat.com>

On Thu, Jan 25, 2024 at 07:30:46PM +0100, Oleg Nesterov wrote:
> On 01/25, Oleg Nesterov wrote:
> >
> > On 01/25, Tycho Andersen wrote:
> > >
> > > One of the things I don't like about PIDFD_THREAD is that it's hard to
> > > tell whether an arbitrary thread is a leader or not. Right now we do
> > > it by parsing /proc/pid/status, which shows all the stuff from
> > > do_task_stat() that we don't care about but which is quite expensive
> > > to compute. (Maybe there's a better way?)
> > >
> > > With PIDFD_THREAD we could could do it twice, once with the flag, get
> > > EINVAL, and then do it again. But ideally we wouldn't have to.
> >
> > Too late for me, most probably I misunderstood.
> >
> > If you want the PIDFD_THREAD behaviour, you can always use this flag
> > without any check...

Sorry, I hadn't read the patch. If it's ok to use PIDFD_THREAD on a
leader, then we can just always specify it. (We don't care about the
behavior of pidfd_poll().)

> > Could you spell?
> 
> Just in case, we can even add PIDFD_AUTO (modulo naming) which acts as
> PIDFD_THREAD if the target task is not a leader or 0 (current behaviour)
> otherwise. Trivial.

Yep, or given the above, maybe it'll work as-is, thank you.

Tycho

