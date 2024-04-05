Return-Path: <linux-kernel+bounces-132477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EDE899590
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEAFBB20A85
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC694224CC;
	Fri,  5 Apr 2024 06:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DGZ39aBW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8DD1BF27;
	Fri,  5 Apr 2024 06:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298967; cv=none; b=uVpdI5G2UhRD1lDqr+O3SPY/sF6UthhPk8Whmk5fs0PY0SIwDFRkk3cwH0ojYsMqlNz1JQL8an3sLvwVRyC8IYKHpy58LFrII5ACZ7vC7wDkprOSf6nF+srtcyR3AEaC5MvX1QCCvtPPdwlZvxCWFg7u1HuV3172iBf9q6GhBDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298967; c=relaxed/simple;
	bh=rCXu4epE+VTWM+HBe7qOASe0JtrD/GpcjyADbon9iVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0VW+TLvSl3K2aWKUk3yQG+y5Ms9r7MXGwOtkCQnXwiefKfvUGiWgXV3Tz5klq38YOSPSBVYbkMGdg7ZNcXJ1ON/E+qGGOAusupjvROoCnogGweGtM9zK+qQe8r8QKHO/Wd3rMzXMJ3utpkXlfOYkh3sOIvLIjBgFyGGqlfmoq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DGZ39aBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CC8C433F1;
	Fri,  5 Apr 2024 06:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712298966;
	bh=rCXu4epE+VTWM+HBe7qOASe0JtrD/GpcjyADbon9iVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DGZ39aBWy9/eqltVfphM20ylODyQHL41s0ElfcCxmn4adpCjvZ8Ao3elLDEF1XZ33
	 knS88Iz28eXrQVzqaBl2Y7wZ9ONDhQQu94OtFzIz+57OEfLAVrXTMBQWe7agDYzwRy
	 Niw4LIgk39SLdroDUEAdr3Ctyif8EynxXv3DimyU=
Date: Fri, 5 Apr 2024 08:36:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Rik van Riel <riel@surriel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: FAILED: Patch "bounds: support non-power-of-two CONFIG_NR_CPUS"
 failed to apply to 5.4-stable tree
Message-ID: <2024040545-diligence-suffrage-d430@gregkh>
References: <20240327122125.2836828-1-sashal@kernel.org>
 <ZgQowqqGf-E7Cpcz@casper.infradead.org>
 <2024032935-antsy-imitation-1453@gregkh>
 <2024032959-ladies-circling-3a5e@gregkh>
 <ZguYw9Dke_uq5UZU@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZguYw9Dke_uq5UZU@casper.infradead.org>

On Tue, Apr 02, 2024 at 06:33:55AM +0100, Matthew Wilcox wrote:
> On Fri, Mar 29, 2024 at 06:05:20PM +0100, Greg KH wrote:
> > On Fri, Mar 29, 2024 at 02:34:43PM +0100, Greg KH wrote:
> > > On Wed, Mar 27, 2024 at 02:10:10PM +0000, Matthew Wilcox wrote:
> > > > On Wed, Mar 27, 2024 at 08:21:25AM -0400, Sasha Levin wrote:
> > > > > The patch below does not apply to the 5.4-stable tree.
> > > > > If someone wants it applied there, or to any other stable or longterm
> > > > > tree, then please email the backport, including the original git commit
> > > > > id to <stable@vger.kernel.org>.
> > > > 
> > > > Looks like you just need a little more fuzz on the patch.
> > > > 
> > > > diff --git a/kernel/bounds.c b/kernel/bounds.c
> > > > index 9795d75b09b2..a94e3769347e 100644
> > > > --- a/kernel/bounds.c
> > > > +++ b/kernel/bounds.c
> > > > @@ -19,7 +19,7 @@ int main(void)
> > > >  	DEFINE(NR_PAGEFLAGS, __NR_PAGEFLAGS);
> > > >  	DEFINE(MAX_NR_ZONES, __MAX_NR_ZONES);
> > > >  #ifdef CONFIG_SMP
> > > > -	DEFINE(NR_CPUS_BITS, ilog2(CONFIG_NR_CPUS));
> > > > +	DEFINE(NR_CPUS_BITS, bits_per(CONFIG_NR_CPUS));
> > > >  #endif
> > > >  	DEFINE(SPINLOCK_SIZE, sizeof(spinlock_t));
> > > >  	/* End of constants */
> > > 
> > > Now fuzzed, thanks.
> > 
> > But it breaks the build on 4.19.y, so I'll go drop it from there.  If
> > you want it added there, please provide a working fix.
> 
> Looks like bits_per() didn't exist in 4.19.  It was added as part of commit 69842cba9ace84849bb9b8edcdf2cefccd97901c
> Author: Patrick Bellasi <patrick.bellasi@arm.com>
> Date:   Fri Jun 21 09:42:02 2019 +0100
> 
>     sched/uclamp: Add CPU's clamp buckets refcounting
> 
> Up to you; I can provide bits_per() to 4.19 which will aid backporting
> other fixes (we currently have 17 uses of bits_per() in 6.9), or we can
> just drop this whole thing for 4.19.
> 

At this point in time for 4.19, unless it's really criticial, I would
just say drop it.

thanks,

greg k-h

