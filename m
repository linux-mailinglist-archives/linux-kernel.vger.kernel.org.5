Return-Path: <linux-kernel+bounces-39067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62EB83CA7B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64585296A00
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A48E13399A;
	Thu, 25 Jan 2024 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="ta8Visxu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U3o8CtD8"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB74113341F;
	Thu, 25 Jan 2024 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706205830; cv=none; b=CK4U/S4m3Yw/2D47FndUtKkl6dmXxWjyDbzMWh3BUkCsjaOX4U+WPW5sJOXqoFOPIVI1aL0qtxA5l8V2lNLpjpDU8KCxvxcrVNNQe5M59njkAaU7t/73iS7K3Rl3VEw2b8B4vb3PVvi19Lk6n8/xyBSshxp8NGpET05Tcd+Fbrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706205830; c=relaxed/simple;
	bh=wsA/pEbjjWxjJ+Y0kwdnw8qFFmvMR8i9bVwg0fNwqSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMnCoNz0ijd9+qlVrNM3CdLmnLKo4AM2e0tqD53O1g5ahvZKRtE7LptPKuVeej3Bh4fK4Y0GT5jY+5ErFV9nbnw5q8XikVY6uEjxfh5JB/lwqFR35AYPzkl4ce+HKx6nTTY8xORibxYyOFDNcKH1WeDvWHmd1YOUPcYkGmaizpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=ta8Visxu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U3o8CtD8; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 8DC935C00D7;
	Thu, 25 Jan 2024 13:03:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 25 Jan 2024 13:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706205826; x=1706292226; bh=yrY2IkwLzx
	BfhNIelLxl43lXg19vkXvv5g6WiWDN+uU=; b=ta8Visxuu8J6JoyplXQ7qX+4KO
	LLuYtKnvTFLWy9Pfo9G+VQkHhj5PHRHsbexyiQPHoziiyK3+9rHNFY+DuRbidM76
	1tWkrBa8820m/V9y8zhJYzJV6d+66rvi4WsGOgqetFM8dikmUKCxB8aa7Ockdo9h
	HqjcjoPCOCZ2Anwy4EZo6C7zPDXFkZaFRNbmeC9stKxAh4tkI4k1gn+7cuqUXP4P
	lA/sVV6ZPfv8gjBUHbcDMKB3FrOK3PEDyTpLvaCUqbpz7q/pG7LVlUS7VUge7+bB
	uTnqHvdjiDu5ggcjTOpnNGakx/WRtx6jyzqyyAdBJpGo7aammIFYmkJShCqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706205826; x=1706292226; bh=yrY2IkwLzxBfhNIelLxl43lXg19v
	kXvv5g6WiWDN+uU=; b=U3o8CtD80boxtYPtbsUBPJ8H6k9cefBgPPtN7+2tlVpa
	BdZCbendFnVo45KaKNKofQG9VgfFaEwazN94P7MXqTtD3VsXQDaXoet0f+nXARZ+
	y1d6WN8UcSA6AoRAqa4KBR/fmluF5zEunbxfM884raqU91Zx7Zkd4BcsdKVe3Bfb
	zoksngt6yCqnmFJiZeZvGQzpvetbQEmehodA40GxC6OyyKGAaobGsUZWz82LWtZX
	/cf4sS136F1rI+fscycDju39Ku7mHTxUmHAokKSBNQWTefk+l87D+ayq1EFyPkWX
	coSOd5y3MGmhHv0GXa7SiJXZGqQbq6dYSmRKb4EHCg==
X-ME-Sender: <xms:gaKyZSmTvr7FzmDIxtqiS4BDMrK8OFSHjrc7mQGCHzKOmVhZQqaVrQ>
    <xme:gaKyZZ2aHe8wi6YKY5hqkAWKiBEi-OiXz7MRAvylXYRQtS1l8y7rX9GYctQpQF5x0
    gdW5V9bbGjVQjEhzss>
X-ME-Received: <xmr:gaKyZQo7oA43WVNjmvindWmrAoOLJSTRb9Rr2bbLk3oK6ZqUiKPeWIC1_dHm8hWjfHsadRcqAnI1tF_QVz8WySTXUX_C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelhedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:gaKyZWmLX42TNSteBRq9T0wteKWJlhCT8jTocvdTb1XmerfqvALv9w>
    <xmx:gaKyZQ12_teluqQQDVSu9oGaUWHXmdHgShFsoRLrlLbwKVgTvRJgbA>
    <xmx:gaKyZduNSjANDs_VMp7KLK6kgfHq2SboyhQKMK2tn-IPG2Kwz0cAJg>
    <xmx:gqKyZU9wHiHQ6z8Mp3lVSciiE_aQD_FmbCZkt9Ndk94EpdH3ClpwCA>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jan 2024 13:03:45 -0500 (EST)
Date: Thu, 25 Jan 2024 11:03:44 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <ZbKigMNQM0Yklc/5@tycho.pizza>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
 <20240123195608.GB9978@redhat.com>
 <ZbArN3EYRfhrNs3o@tycho.pizza>
 <20240125140830.GA5513@redhat.com>
 <20240125-tricksen-baugrube-3f78c487a23a@brauner>
 <20240125175113.GC5513@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125175113.GC5513@redhat.com>

On Thu, Jan 25, 2024 at 06:51:14PM +0100, Oleg Nesterov wrote:
> > > What if we add the new PIDFD_THREAD flag? With this flag
> > >
> > > 	- sys_pidfd_open() doesn't require the must be a group leader
> >
> > Yes.
> >
> > >
> > > 	- pidfd_poll() succeeds when the task passes exit_notify() and
> > > 	  becomes a zombie, even if it is a leader and has other threads.
> >
> > Iiuc, if an existing user creates a pidfd for a thread-group leader and
> > then polls that pidfd they would currently only get notified if the
> > thread-group is empty and the leader has exited.
> >
> > If we now start notifying when the thread-group leader exits but the
> > thread-group isn't empty then this would be a fairly big api change
> 
> Hmm... again, this patch doesn't (shouldn't) change the current behavior.
> 
> Please note "with this flag" above. If sys_pidfd_open() was called
> without PIDFD_THREAD, then sys_pidfd_open() still requires that the
> target task must be a group leader, and pidfd_poll() won't succeed
> until the leader exits and thread_group_empty() is true.

Thanks for sending your patch, I'll take a look at it (probably
tomorrow at this rate).

One of the things I don't like about PIDFD_THREAD is that it's hard to
tell whether an arbitrary thread is a leader or not. Right now we do
it by parsing /proc/pid/status, which shows all the stuff from
do_task_stat() that we don't care about but which is quite expensive
to compute. (Maybe there's a better way?)

With PIDFD_THREAD we could could do it twice, once with the flag, get
EINVAL, and then do it again. But ideally we wouldn't have to.

Still, if that's the only way that makes sense, that's fine.

Tycho

