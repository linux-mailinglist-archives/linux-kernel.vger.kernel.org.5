Return-Path: <linux-kernel+bounces-131632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1D1898A43
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4621F2D75A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12861BC4F;
	Thu,  4 Apr 2024 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S++2bp6D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D58B125B9;
	Thu,  4 Apr 2024 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241332; cv=none; b=TRZd3uzo1NY31aKsdEXB42jAFrmlhHUWan3GA5izUeDNDjtYhLEOxfG24/mHIFcWajP2Y5UxhebSuhxM8rMPT7xBnMQsvH9eTjo5ejAKg1rgkrn/L0KfsTkSXTYuNFWKOQK3nDGSP4zlV/AlQ7xDQdn7f743U3Y9FX5PPr5brKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241332; c=relaxed/simple;
	bh=NZx1I63oNrCCRgTh1WGwcqdsT/vYXP2yWaeyWMgIu9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlGNctU4UKFlXbkXr1CO4C/5e+SkoRMZPkKT9tE+ybdw/fRfj/fagxU8dH0PFIr5Y5DCoJXuqJiBJuGPQokymUYp7CUByiQrnYVvXA9xnZtAVO3AgWiLIJG5JahRBQI3Ol9zo8EAnsjFPCttfyeyWRc3AtNZnEYWJ2ah/g9nLkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S++2bp6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89446C433F1;
	Thu,  4 Apr 2024 14:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712241331;
	bh=NZx1I63oNrCCRgTh1WGwcqdsT/vYXP2yWaeyWMgIu9E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=S++2bp6DA0bmPBZgSiYww0ednM9kkx9mMWzLaE7YKhFhBeyDgKOJVE1kH57PjwhD4
	 2PP3NWywSciY/WwXiLgmIvQLpew2WFKGzRjujjR7mTcKJDOvZpuDqFQlgwf0IETz+I
	 9hN0mzwhgtosWBYtEE1UDhSBO1MMaBgDSJZ9lBgepsoCCyCG01U85oREPCVELpWC+N
	 MrGtVFwiSWMAZyBfe4Nxa0yqG+l4UjH7T7RpxdaVSLviR7+whhC9LTjVb/pUPbGcXu
	 PYqStUuGhHc/UAlB3mm1U/31S9kdN4uPtmYRT3Ttdlh1zOj2USp0mx31dE4vOjFGfL
	 yxls6zqfKkE2A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2EF28CE0417; Thu,  4 Apr 2024 07:35:31 -0700 (PDT)
Date: Thu, 4 Apr 2024 07:35:31 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the rcu tree
Message-ID: <73bf08df-3edd-4948-bea1-3962063d673e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240404083923.358c23da@canb.auug.org.au>
 <Zg6Zs76UDYQsJTWM@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg6Zs76UDYQsJTWM@pc636>

On Thu, Apr 04, 2024 at 02:14:43PM +0200, Uladzislau Rezki wrote:
> Hello!
> 
> > Hi all,
> > 
> > In commit
> > 
> >   a55be9aacc45 ("rcu: Do not release a wait-head from a GP kthread")
> > 
> > Fixes tag
> > 
> >   Fixes: 05a10b921000 ("rcu: Support direct wake-up of synchronize_rcu() users")
> > 
> > has these problem(s):
> > 
> >   - Target SHA1 does not exist
> > 
> > Maybe you meant
> > 
> > Fixes: 654f59c6bc95 ("rcu: Support direct wake-up of synchronize_rcu() users")
> > 
> I have a question. Could you please clarify why those commits are in the linux-next?
> Those commits have to go over RCU tree. It looks like i am missing something but
> please elaborate.

Stephen pulls the -rcu "rcu/next" tag into -next, and does similarly for
a large number of other trees.  This serves to pre-test the commits that
are likely to show up in the upcoming merge window.  The pre-testing
includes the build testing that Stephen does directly and additional
testing that others do on the -next tree (for example, I occasionally
run rcutorture on it).

So these commits are in -next because I told Stephen to include them.

But if you would like, I would be happy to pull your series out of the
portion covered by rcu/next for the time being.

							Thanx, Paul

