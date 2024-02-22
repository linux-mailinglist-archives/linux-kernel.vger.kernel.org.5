Return-Path: <linux-kernel+bounces-77545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B856D86071E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6261C21BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE6913BAE4;
	Thu, 22 Feb 2024 23:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="FSbouayq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H1FMMH0I"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E0732C84;
	Thu, 22 Feb 2024 23:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708645774; cv=none; b=Hcb49pO1+/gQMke+H3HyUWtKhnPqbhUHlxWvYXJVC0LcYbi6KORw3qlK+n3YuRH+KUVvo7PWmqT2b22Q3mdN/FEldvLOn/teGoZcmUfsD51TfKUVHaUFLqYMI0ibF0YNkhSeieNUHekCSH4yQNjX8NzVlCWtZ0sOmIwCMvbeeJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708645774; c=relaxed/simple;
	bh=Rf4YFZGCoDZ1bCrs/37WDyG/DW+iNIONt5UEqAWkVq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hP7Bc5rBd4Y6QrEFCmV10A1+wU0tOEmR6bys0bnljFdcue9IHfY02qPh+7OBWgXUVZVwex98B8AD62u7p5ZZ5pG1DpAWVLbbADhSW+gs//X7rZ8P/tvOeklGE4KilAQZ5lWnQXCRV9iS5PLQg3Akiz9qwE34V7o+16eKS3sALMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=FSbouayq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H1FMMH0I; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id B8262180011D;
	Thu, 22 Feb 2024 18:49:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 22 Feb 2024 18:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708645769; x=1708732169; bh=ILw8Lb9NRg
	Vjbv3d3fgqIKL7GVVXnpquofQj0VHt3qc=; b=FSbouayqr83HDce0dLvghbHifh
	fg7AEv+KzCVmVsK1bHQgMVZN1LMw2AS68mtxAg+tJWGqU9QydknKVDhKLfOz4SM7
	laOAwGxsLxKJjJXeA5IS9/CadvmnOmyprAFcEIzv/Jwe26hui4y8jl7c4gzF7eHZ
	fTCrip5I9n3/mzctP5MCjuzZV6bSi+WKXiWV++jpBCtCsXb7mCMszAb/6Oamz4cd
	S+yzbg1vXkHROpgE8spmFIWdSPiVk/1Kr4BtgAXG0kFa0sz+HErvq1CGhtd6TTX/
	xZqixqVMsK7nVWMMlg177P1PmMIuFiIKtxFmCUkYGDLbS2nwvbs169NUPRtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708645769; x=1708732169; bh=ILw8Lb9NRgVjbv3d3fgqIKL7GVVX
	npquofQj0VHt3qc=; b=H1FMMH0If/yP9lEBc2BZCSuNCo4ZS+ao8n+tCJstsGSj
	cuu7GImKal3QF7hc7CupvyNqMBISdHevjoJIezleCourEcNKL6iIN5m/5MRktttf
	RltUIoQn+qzl/YdLkTVgNklNnhsSa5Xb1WuHqtoGnJPK1cUTUfagS9x4ivqBAUDm
	DP1uHkWsslrSLREyTcaDrGdImLu3MBVTUHtAoCJfTdQrqpwlmneLnzbpQ75eq9Bx
	mK8fQvl/kT3teltV2APibNCu1hBd9rJ3PLld+h9g7iXTaZ9HDKbLLi7Q3JTw1sH9
	3IMXzFUd4B6ukfjszpslg3S3abviB6YH9rBbcv1o3w==
X-ME-Sender: <xms:id3XZcZIvU7jIzS28dgRu5tKrfITPfG0q7l6N4HnS3J3zY4uiijq4Q>
    <xme:id3XZXb8d6jAfCWgzbGzKyV3a9CFtPBTiI4lPG4N4TRhp4Zh9NmKlDLdgqPdwDZWg
    Kc-FSrBWMlmjUZmENE>
X-ME-Received: <xmr:id3XZW_aEJB_xo0vM1L1XOOX3RizcIo1iYkGGUAfghuLl1mwsv2HvIrq7EM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeehgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteeklefh
    leelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:id3XZWonpGDQDkQZmXmuVXQKRIO65y08sA4Eql24Curs0f1-Vt0lpA>
    <xmx:id3XZXrISR8H6_awCtDYWS6041JEMWvIpA9fWzlYSV3G1BwvNMoUNQ>
    <xmx:id3XZUSU5rldCwqj-GVWqit2JMV-dp1JQnaF-CsMzHyJz2vCLeR4iA>
    <xmx:id3XZYdrxl3TeIMTKa36i6-yJEQQTYUIgOxfVxJmmMtweCEqLnWXLY6E7wc>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Feb 2024 18:49:27 -0500 (EST)
Date: Thu, 22 Feb 2024 16:49:26 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Kees Cook <keescook@chromium.org>
Cc: "Tobin C. Harding" <me@tobin.cc>, Greg KH <gregkh@linuxfoundation.org>,
	Guixiong Wei <guixiongwei@gmail.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leaking_addresses: Provide mechanism to scan binary files
Message-ID: <Zdfdhl78xgBuZdXu@tycho.pizza>
References: <20240218173809.work.286-kees@kernel.org>
 <ZddnEtnxhJsafdcF@tycho.pizza>
 <202402221249.FA17A8940@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402221249.FA17A8940@keescook>

On Thu, Feb 22, 2024 at 01:00:40PM -0800, Kees Cook wrote:
> > This does bring up some interesting questions. From off-list
> > discussions with Tobin, I believe he is not particularly interested in
> > maintaining this script any more. I was never set up to do the PRs
> > myself, I agreed to be a reviewer to help Tobin out. I'm happy to
> > adopt it if that makes sense, but I'm curious about the future of the
> > script:
> > 
> > 1. is it useful? (seems like yes if you're adding features)
> 
> Yes, LKP runs it as part of 0-day, and it's found leaks in the past[1].
> (Though its usage could be improved.)

Oh! That is good news :)

> > 2. does it make sense to live here as a separate thing? should we
> >    perhaps run it as part of kselftests or similar? I think that e.g.
> >    681ff0181bbf ("x86/mm/init/32: Stop printing the virtual memory
> >    layout") was not discovered with this script, but maybe if we put it
> >    inline with some other stuff people regularly run more of these would
> >    fall out? Maybe it makes sense to live somewhere else entirely
> >    (syzkaller)? I can probably set up some x86/arm64 infra to run it
> >    regularly, but that won't catch other less popular arches.
> 
> We could certainly do that. It would need some work to clean it up,
> though -- it seems like it wasn't designed to run as root (which is how
> LKP runs it, and likely how at least some CIs would run it).
> 
> > 3. perl. I'm mostly not a perl programmer, but would be happy to
> >    rewrite it in python pending the outcome of discussion above.
> 
> I am not a Perl fan either. It does work as-is, though. Address leaks,
> while worth fixing, are relatively low priority over all, so I wouldn't
> prioritize a rewrite very highly.

Yep, fair enough.

Tycho

