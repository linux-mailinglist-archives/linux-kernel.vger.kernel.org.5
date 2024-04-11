Return-Path: <linux-kernel+bounces-139898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE16D8A08F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CBA1B24F99
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6A113DDB4;
	Thu, 11 Apr 2024 06:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qy84Hba4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB33C13D89C;
	Thu, 11 Apr 2024 06:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818619; cv=none; b=nC3UYLaTKGTLsqGMPS6YTW082hIj/1QwSaqYe4lLiluX1LI9f5XV8qByrdiBUB08KdrgSAOjsSm137K9ba78aiAE4C7Ing9dsXlpPE9f40/iFCge1qYopNiFcCyJj7e+dR44qGeuOc9RXKejndkHFeE9PJ3PXn/G1MCaSbGm9kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818619; c=relaxed/simple;
	bh=yVqJ3A0xnmgb2uzbb/DoieZ74OGykytejpIxQdzl9Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAFtCmLU3/zCou5g0UicCHAZkoEFbb9sZURnYiyee/tEwXA4EsOFTsfgTz40BsNFPS3Z+R76o8VvVhF51OsXel9V0fF/JtKOyQL/y7gC2fiiSt8n8DC3NGJ70yG9AjCH8TBZjo+Dp1pFJTL+8U7F4omCgnGol5YG8MZP0//sJU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qy84Hba4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0123BC4163A;
	Thu, 11 Apr 2024 06:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712818618;
	bh=yVqJ3A0xnmgb2uzbb/DoieZ74OGykytejpIxQdzl9Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qy84Hba4HQsqQD67bhS+Rbn4Um+fuicRMAp8WrRu38cdqYlVmdZY8SbEgct4pFPRX
	 B0xpQC1jSI2/YqCHEmdcIo1Q2C+qfp6APrFt/5lhU/3fw9zgcogEbkvr00onB3nzYQ
	 jRqyoJqzxJ4oBGXpqikTHHB78gKnwJdLTk3Km/Bs=
Date: Thu, 11 Apr 2024 08:56:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] docs: stable-kernel-rules: call mainline by its
 name and change example
Message-ID: <2024041130-trickster-naturist-0448@gregkh>
References: <cover.1712812895.git.linux@leemhuis.info>
 <ec5dff37a62681beb74f89f8fcde41b6618152f0.1712812895.git.linux@leemhuis.info>
 <2024041156-nintendo-paddling-eaad@gregkh>
 <963811ba-6c12-47d1-942e-ba7bcf93a766@leemhuis.info>
 <2024041127-attach-removed-f9f0@gregkh>
 <898e813d-883c-4ccb-91ad-03aff40d59e3@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <898e813d-883c-4ccb-91ad-03aff40d59e3@leemhuis.info>

On Thu, Apr 11, 2024 at 08:50:19AM +0200, Thorsten Leemhuis wrote:
> On 11.04.24 08:10, Greg Kroah-Hartman wrote:
> > On Thu, Apr 11, 2024 at 07:50:29AM +0200, Thorsten Leemhuis wrote:
> >> On 11.04.24 07:30, Greg Kroah-Hartman wrote:
> >>> On Thu, Apr 11, 2024 at 07:25:05AM +0200, Thorsten Leemhuis wrote:
> >>>>  
> >>>> -     Cc: <stable@vger.kernel.org> # after 4 weeks in mainline
> >>>> +     Cc: <stable@vger.kernel.org> # after 6 weeks in a stable mainline release
> >>>
> >>> I do not know what "stable mainline release" means here, sorry.  "after
> >>> 4 weeks in mainline" means "after in Linus's tree for 4 weeks, but
> >>> Linus's tree is not "stable mainline".
> >>
> >> I meant a proper mainline release like 6.7 or 6.8 to make it obvious
> >> that this does not mean a "pre-release".
> >>
> >> I actually had used the term "proper mainline release" earlier in a
> >> draft, but a quick search on the net showed that this is not really used
> >> out there. "stable mainline release" is not popular either, but seemed
> >> to be a better match; I also considered "final mainline release", but
> >> that felt odd.
> >>
> >> It feels like there must be some better term my mind just stumbles to
> >> come up with. Please help. :-D
> > 
> > Well, what is the goal here?  Just put it in words, I have seen stuff
> > like:
> > 	Cc: <stable@vger.kernel.org> # wait until -rc3
> > 	Cc: <stable@vger.kernel.org> # wait until 6.1 is released
> > 	Cc: <stable@vger.kernel.org> # after -rc2
> > 
> > and so on.
> > 
> > Just pick a specific time/release might be better?  "after X weeks" is
> > assuming that we all know and remember how many weeks something
> > happened...
> 
> My reasoning was: a developer that submits a patch has no full control
> over when the patch mainlined -- and plans sometimes change, too.
> 
> So a patch that was meant to go into 6.1-rc with a tag like "# wait
> until 4 weeks after 6.1 is released" might only be mainlined for 6.2-rc1
> -- and then the tag does not express the developers intention.

I've normally seen patches end up in Linus's tree "too early" more often
(i.e. cc: stable for stuff that has never been in a stable tree yet),
but sure, I can see how changes can also take too long.

> But that might be a corner case that we could ignore. So maybe "# wait
> until 4 weeks after 6.1 is released" is the better example (from what
> I've heard something like that is what developer would like to have
> sometimes).

Yes, referencing off of a fixed point like a release is best as that's
much easier for humans to calculate.

Also because, the original "after 4 weeks", doesn't give me a reference
point to judge what the starting time is easily.  Yes, I have tools for
that, but most people don't.

So how about changing it to use the "fixed point" reference please?  The
phrasing "after -rc3" is probably what most people almost always want
anyway, given the huge churn that -rc1 is.

thanks,

greg k-h

