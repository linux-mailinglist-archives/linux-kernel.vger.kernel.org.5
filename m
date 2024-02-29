Return-Path: <linux-kernel+bounces-86120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B19CD86BFED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD991F25A51
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65823A1BA;
	Thu, 29 Feb 2024 04:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="gisNlChB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SqDaG4uE"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A436839FD4;
	Thu, 29 Feb 2024 04:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709181623; cv=none; b=aV/ngS5pNDePt/E28ceHooDJz42cAY7Czybl4NH1bnkwIkAjiz04uh8LAwFn+0CMhzcY3MEUdHTmVM79CD1/KkWMbSIJZEJVNYtYDFbQ4FPntW1j+aJU/kp7rSbMMKo+5k8sa15g1LEQZ/MOnu8bEeS+jMwrpxHIXlim2blYNyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709181623; c=relaxed/simple;
	bh=szJ84fJbfmfGtyzKzfYOOgsGiLvXLfYNchtRidS/T7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTuDP0bKxaqtQXpR873xbNarR8HQxuSgZ2k80sjuU5VYG4DdnVeqcAGWwyp5GcsN/wFLGcasPp99n5JZzMvAecQaEAgCgSoIobTWPw5PRAP52/Qg9dnwsoxLJCvVvkoMdIK3tDIyey/wd1YZvnVzBM16UFPyrvlgGET75DE72kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tobin.cc; spf=pass smtp.mailfrom=tobin.cc; dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b=gisNlChB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SqDaG4uE; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tobin.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tobin.cc
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 90AC513800D8;
	Wed, 28 Feb 2024 23:40:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 28 Feb 2024 23:40:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709181620; x=1709268020; bh=fS/c/ZoonG
	R+k1lBVOKCFEwZ3lR/L/2XgX7PcaDFUPw=; b=gisNlChBYYG56Fgi5jQ/ze/izp
	VrOpArBYlgO8yFcOKu3eudQQIr4ElpapbXfO+Frp4KR4tDcxsStDq9k+524oMkkH
	PZN0fLzMa5wFGADgclaBlBmb4gt/g3TFj9brXxNRtCWYuBzT2eYGqCe9MWxeh24V
	2wD/7fkbVVaF7ZxLDJJ8oU8nycGFFdc8xi0rKF+LgxDMyeoKcIR8FWcxV8W+9CFg
	rTzNZ2nu4bnS5RHapDjAs9O+HXxvhxYRNZUhz8BqGK3nyu0IxhlYsppH7+wBTzmi
	2THF1C2GniUvsd3VCdZUlyKWlPcuMCrlgZZ+5WE1qBzXtX1FRWokjEniijyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709181620; x=1709268020; bh=fS/c/ZoonGR+k1lBVOKCFEwZ3lR/
	L/2XgX7PcaDFUPw=; b=SqDaG4uEip3mnvB58lpMQE9NEqiiU/WTaljXHP3ppmXH
	SOpyLHOAcLXQWHTlaUSJMuUy75CQyCRPfu+6nmxrRbGVNMplcrhZ2BK1d3ZZxwX/
	bohp4U6muWVN5ExjwspVUtgfsDHUVKA/Do0U9j2G9LY87gSLFaDo+ngVndUY9mO4
	dF62iWHkxithzsXKNL1J4tCSWhxFbPUrbpjw0RzPDCjvgc2lkGMepLDwZH79dbaI
	Otk/K603NfS5c2o+74Kun/4fQMGgE5v9fDLvF5doocwkMYQLkWdWSPHuTMO3ZaFQ
	4UvAWH/S2qFKILJNlW04d0xdULthynhtu1priS4+iA==
X-ME-Sender: <xms:tArgZbFPsC5xC-ulOZqGwKkg0aKBOWhydea5ArYFsUGAUJ_UTeRjYg>
    <xme:tArgZYUQzYVAH5E4V09KfxrXoXJz3BOVAqlLxUykUWRPWnL83rAk39M2pol_GNdpW
    CWLLUtF73tZ75HAaQ>
X-ME-Received: <xmr:tArgZdLeI70RUzvqt38l8CgtMiPSOVMrqAaGL70nSwjJ0ognMfdR1_TGaTIiyFSCKwNgS3Hbtt-pOePEQ2H8zo1zxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeekgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeftddmnecujfgurhepfffhvfevuffkfhggtggujgfosehttdertder
    tddvnecuhfhrohhmpefvohgsihhnucfjrghrughinhhguceomhgvsehtohgsihhnrdgttg
    eqnecuggftrfgrthhtvghrnhepfeeitedugfevtdelffdtheeftdfhhfehledvieetieei
    heevteehjeelhfelvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepmhgvsehtohgsihhnrdgttg
X-ME-Proxy: <xmx:tArgZZH38YwZ4cM5JUp1y7Pndsxz0xtT3aZmeF34WeTSc20iL-PKUQ>
    <xmx:tArgZRVzYpvhBNUgU3d7LbqPN9HLvVvkQTzPsuq4CKLk-8eutnBlLg>
    <xmx:tArgZUN6kmoeF9y69sAc8h9qA3XUqOLIRDSLcFCptu2oo7S7bKubBA>
    <xmx:tArgZTIDBWMG4oxEwUYXW8-6NPNCRo1rCak81jmwScvzN2ViqteDmw>
Feedback-ID: i05c0407e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Feb 2024 23:40:18 -0500 (EST)
Date: Thu, 29 Feb 2024 15:40:13 +1100
From: Tobin Harding <me@tobin.cc>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Kees Cook <keescook@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
	Guixiong Wei <guixiongwei@gmail.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leaking_addresses: Provide mechanism to scan binary files
Message-ID: <ZeAKrU9IfcNpIURB@alke>
References: <20240218173809.work.286-kees@kernel.org>
 <ZddnEtnxhJsafdcF@tycho.pizza>
 <202402221249.FA17A8940@keescook>
 <Zdfdhl78xgBuZdXu@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdfdhl78xgBuZdXu@tycho.pizza>
X-Mailer: Mutt 2.1.4 (2021-12-11)

On Thu, Feb 22, 2024 at 04:49:26PM -0700, Tycho Andersen wrote:
> On Thu, Feb 22, 2024 at 01:00:40PM -0800, Kees Cook wrote:
> > > This does bring up some interesting questions. From off-list
> > > discussions with Tobin, I believe he is not particularly interested in
> > > maintaining this script any more. I was never set up to do the PRs
> > > myself, I agreed to be a reviewer to help Tobin out. I'm happy to
> > > adopt it if that makes sense, but I'm curious about the future of the
> > > script:
> > > 
> > > 1. is it useful? (seems like yes if you're adding features)
> > 
> > Yes, LKP runs it as part of 0-day, and it's found leaks in the past[1].
> > (Though its usage could be improved.)
> 
> Oh! That is good news :)
> 
> > > 2. does it make sense to live here as a separate thing? should we
> > >    perhaps run it as part of kselftests or similar? I think that e.g.
> > >    681ff0181bbf ("x86/mm/init/32: Stop printing the virtual memory
> > >    layout") was not discovered with this script, but maybe if we put it
> > >    inline with some other stuff people regularly run more of these would
> > >    fall out? Maybe it makes sense to live somewhere else entirely
> > >    (syzkaller)? I can probably set up some x86/arm64 infra to run it
> > >    regularly, but that won't catch other less popular arches.
> > 
> > We could certainly do that. It would need some work to clean it up,
> > though -- it seems like it wasn't designed to run as root (which is how
> > LKP runs it, and likely how at least some CIs would run it).
> > 
> > > 3. perl. I'm mostly not a perl programmer, but would be happy to
> > >    rewrite it in python pending the outcome of discussion above.
> > 
> > I am not a Perl fan either. It does work as-is, though. Address leaks,
> > while worth fixing, are relatively low priority over all, so I wouldn't
> > prioritize a rewrite very highly.
> 
> Yep, fair enough.

Thanks for taking this in through your tree Kees! And Tycho for
picking up the pieces I dropped :)

I can help review a re-write if it helps though I don't write Python
daily and I am long way away from kernel work these days so I doubt
I'd be all that much help.

I originally wrote it in Perl because I figured it would be easier to
get past the old guys, six moths later I regretted the decision when I
tried to re-read it.

Thanks for ping'ing me.

All the best,
Tobin.

