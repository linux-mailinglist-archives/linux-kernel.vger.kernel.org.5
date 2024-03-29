Return-Path: <linux-kernel+bounces-125218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89156892265
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29902B2209A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3BF1353E1;
	Fri, 29 Mar 2024 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QigFNj+8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D69985654;
	Fri, 29 Mar 2024 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711731925; cv=none; b=GrPWCEz1w4w9PCiauK/+saDOGMv2vdlqhNK9biNMfAOHRQBPc/obIz/JtPfzqeYXTzdFDU0hZhTQtz+3JTvABzlEKPpsVwxTNg/bEgG9xLVEhl1f+E/5gvXoWbJW/nrbh3TWr2eQaiXnOGxSNssp4UceeYM+e+AEqx6Ze9xdJFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711731925; c=relaxed/simple;
	bh=ORB8eEw68b3v0cYkRkKE/w3KyARnn+J+bFMPjYmJwW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvM9QLTDjjrMeYLgax+4cYwZBuov2ngTuZafGLD9qUQhJYil/utsZxLwrKHi6iKjejXxW34f9lGYparpFMMcrgBaYVXZcFDY+c0TRdsQocITHtWzCrL81RBV7Hy18CC+uP1M2Q0bq7aMJt9c7rtKSaq179mqOELdhHZHwMBr9ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QigFNj+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3062C433C7;
	Fri, 29 Mar 2024 17:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711731924;
	bh=ORB8eEw68b3v0cYkRkKE/w3KyARnn+J+bFMPjYmJwW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QigFNj+8xwtlSe6OnR3TBpoDTQ7JD1iCNMAws4eWGv5AIzERTgPt2k1GvEB7iLBWs
	 iTMh+4yAoDaMkFrSMUDWDIrXG9R7nFAd3y67E+h3RjXN7GP1ObPSy6vA95DvPg5rLt
	 yoQewHoPDIo+qfnaTQwMONM4FCFdx+/S7AHGSWoY=
Date: Fri, 29 Mar 2024 18:05:20 +0100
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
Message-ID: <2024032959-ladies-circling-3a5e@gregkh>
References: <20240327122125.2836828-1-sashal@kernel.org>
 <ZgQowqqGf-E7Cpcz@casper.infradead.org>
 <2024032935-antsy-imitation-1453@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024032935-antsy-imitation-1453@gregkh>

On Fri, Mar 29, 2024 at 02:34:43PM +0100, Greg KH wrote:
> On Wed, Mar 27, 2024 at 02:10:10PM +0000, Matthew Wilcox wrote:
> > On Wed, Mar 27, 2024 at 08:21:25AM -0400, Sasha Levin wrote:
> > > The patch below does not apply to the 5.4-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git commit
> > > id to <stable@vger.kernel.org>.
> > 
> > Looks like you just need a little more fuzz on the patch.
> > 
> > diff --git a/kernel/bounds.c b/kernel/bounds.c
> > index 9795d75b09b2..a94e3769347e 100644
> > --- a/kernel/bounds.c
> > +++ b/kernel/bounds.c
> > @@ -19,7 +19,7 @@ int main(void)
> >  	DEFINE(NR_PAGEFLAGS, __NR_PAGEFLAGS);
> >  	DEFINE(MAX_NR_ZONES, __MAX_NR_ZONES);
> >  #ifdef CONFIG_SMP
> > -	DEFINE(NR_CPUS_BITS, ilog2(CONFIG_NR_CPUS));
> > +	DEFINE(NR_CPUS_BITS, bits_per(CONFIG_NR_CPUS));
> >  #endif
> >  	DEFINE(SPINLOCK_SIZE, sizeof(spinlock_t));
> >  	/* End of constants */
> 
> Now fuzzed, thanks.

But it breaks the build on 4.19.y, so I'll go drop it from there.  If
you want it added there, please provide a working fix.

thanks,

greg k-h

