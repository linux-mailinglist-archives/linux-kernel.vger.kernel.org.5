Return-Path: <linux-kernel+bounces-37100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D54083AB88
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0534B2830B0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5EB7A724;
	Wed, 24 Jan 2024 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9fhaF0j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B258B77641;
	Wed, 24 Jan 2024 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106043; cv=none; b=ltsZ8Pksd3bJ1yrreE7QIUGEuG+flwF1geYNZb6qLX2kpYDU9Rdvlc++JVI3/pUBEIzTPZiJPVp1qB9jh8kS+0eC79DxpzTDh/4sEs5iU4bCqSJrzH427pSphhNsIyuXNnfuAgh/+HCiF9kf1j8fwwFMxhl/Ef8xUgC7kFc4omI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106043; c=relaxed/simple;
	bh=cZwooKZYY+5BxcC/oTMQ6fPAMp5nU8PfPmstszDkUQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZcKNz5TyM1Wwl1ham5WvUgKDzNv1TOROYM+qqFrc2jptXHsvzaqoXAIjb9zfxfS6XSOisZPmOXgfVs9e+sQ46kPxLWwVV2c+iqA3LGfsCNoawP+MCc1p3cKiWLMVHzrliVFaLIQDWha+BxFUbDki+iJF1GKo8eENSv6ROi4D0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9fhaF0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3BFC433F1;
	Wed, 24 Jan 2024 14:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106043;
	bh=cZwooKZYY+5BxcC/oTMQ6fPAMp5nU8PfPmstszDkUQw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=j9fhaF0jRiU4dn2ygpxvyPiRkUv1hD3E8jANrC8fc+AdPMBxjRgorSZ75Uh4dPxkb
	 EPhxfsYtbxPof0WQH3kooCzZODEqCjBAuQqaEORiN3vsik91a/WOkAvT4Tci5YqBhB
	 Pkm9YYXgbmWRW83bJdQ4xplrXSItNmej84/n+Q6LWFoomXfrQAtvUhyWcuVmwtRbDm
	 fPbyR3yC+Dqb/8M5XNOF8Vh+WtEjRSChu8wbQ/l9JxMkpAngXIGxoHEVqGSFkRpoZY
	 WWuFDWg/waOnx4BMuVTbPPL5yj5Ji6xcpGCwqdDE+JgmQCzXfyhHSvLZaJ761/AUT6
	 qws8JAbw1XLkQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CADFECE0E8B; Wed, 24 Jan 2024 06:20:42 -0800 (PST)
Date: Wed, 24 Jan 2024 06:20:42 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jiri Wiesner <jwiesner@suse.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the rcu tree
Message-ID: <f9225eac-7ed9-4abe-8ffc-94936ece0238@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240124151743.052082af@canb.auug.org.au>
 <20240124094954.GL3303@incl>
 <6b5c4acc-f184-4ad9-9029-dd7967fe4a04@paulmck-laptop>
 <20240124133105.GM3303@incl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124133105.GM3303@incl>

On Wed, Jan 24, 2024 at 02:31:05PM +0100, Jiri Wiesner wrote:
> On Wed, Jan 24, 2024 at 04:12:23AM -0800, Paul E. McKenney wrote:
> > On Wed, Jan 24, 2024 at 10:49:54AM +0100, Jiri Wiesner wrote:
> > > On Wed, Jan 24, 2024 at 03:17:43PM +1100, Stephen Rothwell wrote:
> > > > After merging the rcu tree, today's linux-next build (i386 defconfig)
> > > > failed like this:
> > > > In file included from include/linux/dev_printk.h:14,
> > > >                  from include/linux/device.h:15,
> > > >                  from kernel/time/clocksource.c:10:
> > > > kernel/time/clocksource.c: In function 'clocksource_watchdog':
> > > > kernel/time/clocksource.c:103:34: error: integer overflow in expression of type 'long int' results in '-1619276800' [-Werror=overflow]
> > > >   103 |                                  * NSEC_PER_SEC / HZ)
> > > >       |                                  ^
> > > > Caused by commit
> > > >   1a4545025600 ("clocksource: Skip watchdog check for large watchdog intervals")
> > > > I have used the rcu tree from next-20240123 for today.
> > > 
> > > This particular patch is still beging discussed on the LKML. This is the 
> > > latest submission with improved variable naming, increased threshold and 
> > > changes to the log and the warning message (as proposed by tglx):
> > > https://lore.kernel.org/lkml/20240122172350.GA740@incl/
> > > Especially the change to the message is important. I think this message 
> > > will be commonplace on 8 NUMA node (and larger) machines. If there is 
> > > anything else I can do to assist please let me know.
> > 
> > Here is the offending #define:
> > 
> > #define WATCHDOG_INTR_MAX_NS	((WATCHDOG_INTERVAL + (WATCHDOG_INTERVAL >> 1))\
> > 				 * NSEC_PER_SEC / HZ)
> > 
> > The problem is that these things are int or long, and on i386, that
> > is only 32 bits.  NSEC_PER_SEC is one billion, and WATCHDOG_INTERVAL
> > is often 1000, which overflows.  The division by HZ gets this back in
> > range at about 1.5x10^9.
> 
> Exactly.
> 
> > So this computation must be done in 64 bits even on 32-bit systems.
> > My thought would be a cast to u64, then back to long for the result.
> 
> This will be a more precise solution than enclosing NSEC_PER_SEC / HZ in 
> brackets, which I chose to do in the v2 of this patch.
> 
> > Whatever approach, Jiri, would you like to send an updated patch?
> 
> Yes, I can incorporate the casting to u64 and back to long into the patch. 
> At this point, I am not sure which version to use. There are:
> * v1 (submitted to the LKML on Jan 3rd): the patch that got merged into linux-next
> * v2 (submitted to the LKML on Jan 10th): that has an alternative fix for the interger overflow
> * v3 (submitted to the LKML on Jan 22nd): that incoporates suggestions by Thomas Gleixner
> 
> I could update the v3 of this patch with casting to u64 and back to long. 
> WATCHDOG_INTERVAL_MAX_NS got set to 2 * WATCHDOG_INTERVAL in v3 - a change 
> I do not entirely agree with. I think WATCHDOG_INTERVAL_MAX_NS should be 
> kept narrow so as not to impose a limit on time skew that is too strict 
> for readout intervals approaching 2 * WATCHDOG_INTERVAL in their length. 
> The question is what is too strict.

Please accept my apologies!  I should have caught your updates.

I will drop my current version of your patch and queue your v3 for review
and testing.

							Thanx, Paul

