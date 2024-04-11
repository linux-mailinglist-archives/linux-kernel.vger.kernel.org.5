Return-Path: <linux-kernel+bounces-140003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2648A0A35
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF6B1C20F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC401422C3;
	Thu, 11 Apr 2024 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ncCaGgNz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DE113D623;
	Thu, 11 Apr 2024 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821229; cv=none; b=X0odJb+e77JUe2QiFhM0oKOmUJqJeSKoXotpbaHDPnVpEQZII8BKRMHgurwI/8leUP+BGwC3sjH6t1/gDoAcYd1lFomETQBSmyMLT9VQE+vhuI8gKAJBErSfs0WEY17xr558fjz1iGLyMyFKfTofTiOydVOBoTYTFxTC8fewmwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821229; c=relaxed/simple;
	bh=gU83pKVxE28bT28SwDUVpbrEVoqeK57hhHrjjTx/m/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWBck0JeUwBMHqCV1FglwDh3jK0cWjFO2UnTnXSCrkBHT6Q1v1CbJIcZy6uGth7xAFxoWOAtAnawgYikAMXiqeaNEP+16TMg3H63SvpbM/Il3CR1decYvpeNdt2l46DPQsrsuAaXAPFAHbopg7G4kujqlVe4XY6EC6BtPsN5vf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ncCaGgNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6FDC433C7;
	Thu, 11 Apr 2024 07:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712821228;
	bh=gU83pKVxE28bT28SwDUVpbrEVoqeK57hhHrjjTx/m/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ncCaGgNzsedv/lqUFjuTRvttWoSfT7U5LpQoQN0Lp2zOYTaOW7o99yR2NoxR9DcTl
	 J9pF+ARn4Wzpgc9UXrLqDjC4p9dbntLiNKVSk8n7YyxPnCIcY3VB7ZN4RwLC9WeEDo
	 ClgkTXb2mUx3pgTq0VHo4lxi8QfxXqXF39AhD6cg=
Date: Thu, 11 Apr 2024 09:40:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] docs: stable-kernel-rules: mention "no
 semi-automatic backport"
Message-ID: <2024041123-earthling-primarily-4656@gregkh>
References: <cover.1712812895.git.linux@leemhuis.info>
 <c0a08b160b286e8c98549eedb37404c6e784cf8a.1712812895.git.linux@leemhuis.info>
 <2024041156-backache-dolly-a420@gregkh>
 <3f395eca-fc24-469b-b5fc-de47ab2a6861@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f395eca-fc24-469b-b5fc-de47ab2a6861@leemhuis.info>

On Thu, Apr 11, 2024 at 08:59:39AM +0200, Thorsten Leemhuis wrote:
> On 11.04.24 07:29, Greg Kroah-Hartman wrote:
> > On Thu, Apr 11, 2024 at 07:25:04AM +0200, Thorsten Leemhuis wrote:
> >> Some developers deliberately steer clear of 'Fixes:' tags to prevent
> >> changes from being backported semi-automatically by the stable team.
> >> That somewhat undermines the reason for the existence of the Fixes: tag,
> >> hence point out there is an alternative to reach the same effect.
> >>
> >> Link: https://lore.kernel.org/all/dfd87673-c581-4b4b-b37a-1cf5c817240d@leemhuis.info/
> >> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> >> ---
> >>  Documentation/process/stable-kernel-rules.rst | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
> >> index 7bb16d42a51833..ebd57cb9277f7b 100644
> >> --- a/Documentation/process/stable-kernel-rules.rst
> >> +++ b/Documentation/process/stable-kernel-rules.rst
> >> @@ -117,6 +117,12 @@ comment to pass arbitrary or predefined notes:
> >>     Note, such tagging is unnecessary if the stable team can derive the
> >>     appropriate versions from Fixes: tags.
> >>  
> >> + * Prevent semi-automatic backporting of changes carrying a 'Fixes:' tag:
> >> +
> >> +   .. code-block:: none
> >> +
> >> +     Cc: <stable@vger.kernel.org> # no semi-automatic backport
> > 
> > I do not understand, why are you saying "cc: stable" here if you do NOT
> > want it backported?
> 
> Because the only alternative the developers have to make the stable team
> not pick a single patch[1] is to deliberately omit a Fixes: tag even if
> the patch normally should have one. Like it was done here:
> https://lore.kernel.org/all/cover.1712226175.git.antony.antony@secunet.com/

That feels odd, but ok I now see the need for this for some minor set of
changes (i.e. this has rarely come up in the past 15+ years)

> And that somehow felt wrong to me, as discussed earlier in
> https://lore.kernel.org/all/dfd87673-c581-4b4b-b37a-1cf5c817240d@leemhuis.info/
> 
> [1] e.g. if they don't have or want their whole subsystem marked as
> 'ignore for the AUTOSEL and the "Fixes tag only" tools'
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/ignore_list
> 
> > And what do you mean by "semi-automatic"?
> 
> E.g. 'ignore for the AUTOSEL and the "Fixes tag only" tools'. That was
> the best term I came up with.

Thinking about it more, I think we need to be much more explicit, and
provide the reason why.

How about:
	cc: <do-not-apply-to-stable@kernel.org> # Reason goes here, and must be present

and we can make that address be routed to /dev/null just like
<stable@kernel.org> is?

thanks,

greg k-h

