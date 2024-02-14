Return-Path: <linux-kernel+bounces-65302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD3C854AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D91D1C22D02
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1904354FA4;
	Wed, 14 Feb 2024 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PKuP9pDv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4856054BD8;
	Wed, 14 Feb 2024 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919113; cv=none; b=ktpdYu2uJCVjAMlQ6161N55oYT7ZOn61nF4+mvSO7cb0bDD4I3fl29LRn6zCuBSH1lcwyFLyNlEmXzD9wAe6s2qiDr+aRNTgFyX4UrM8mSJRlt6wbgcbtClCLpZCBq8yysXHFiBI+bseWO+q4SrIIjv3vSV75MIPBnWzr3oftKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919113; c=relaxed/simple;
	bh=C50n4gchmAkHROV+lhcLCSqTzdKXPWHKdyrMpACSx7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udrXFrr3LuLICAEwS7M/QulFMK0pkHx76iU675dknVOaeVPvGhEhuGIR8//cI/wj2uq2TsGHX1beKU5TyaWB3pUGlMHEk6xPYxLVxPqxil+3GfZyiYgHangsvAVNajh5eC5mYfnY78F5UJX/by5a0RyRlXSEZxv22CyKdtSIXQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PKuP9pDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64ACAC433F1;
	Wed, 14 Feb 2024 13:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707919112;
	bh=C50n4gchmAkHROV+lhcLCSqTzdKXPWHKdyrMpACSx7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PKuP9pDv1Hqlp/upP1M3Zsfuwtu9epu7PykUTU0rQi2OXBfRvVKq2NB32P/QPgs6d
	 bHhwGgMfozUQkbQnEJJ2bTnCAcEv2ovSNTn8n/1dox1EiNLcXPd/LoAs+A782M9rra
	 FKEkY7IYOafH3xvA2nh6yV7i6uKknHcl8z7wTXxk=
Date: Wed, 14 Feb 2024 14:58:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Message-ID: <2024021459-trimness-bolt-7185@gregkh>
References: <2024021430-blanching-spotter-c7c8@gregkh>
 <nycvar.YFH.7.76.2402141433560.21798@cbobk.fhfr.pm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2402141433560.21798@cbobk.fhfr.pm>

On Wed, Feb 14, 2024 at 02:43:48PM +0100, Jiri Kosina wrote:
> On Wed, 14 Feb 2024, Greg Kroah-Hartman wrote:
> 
> > +No CVEs will be automatically assigned for unfixed security issues in
> > +the Linux kernel; assignment will only automatically happen after a fix
> > +is available and applied to a stable kernel tree, and it will be tracked
> > +that way by the git commit id of the original fix. 
> 
> I think this needs way more clarification .. how exactly is this going to 
> work?
> 
> Do I read this correctly that *everything* that lands in -stable will 
> automatically get CVE assigned? If so, that's just plain crazy. Just took 
> a random peek on the topmost -stable changelog ...
> 
> 	ASoC: codecs: wsa883x: fix PA volume control
> 	ASoC: codecs: lpass-wsa-macro: fix compander volume hack
> 	ASoC: codecs: wcd938x: fix headphones volume controls
> 	ASoC: qcom: sc8280xp: limit speaker volumes
> 	drm/amdgpu: Fix missing error code in 'gmc_v6/7/8/9_0_hw_init()'
> 
> Only the last one can *potentially* be considered a CVE candidate, but 
> someone would actually have to take a *deep* look. Most likely it'll be a 
> functional issue, but not a security issue by any measures.
> 
> So I hope it's not the case, and someone will actually be doing some 
> triage. If that's the case -- is this process described anywhere?

It's described as "we know it when we see it" :)

Seriously, this is something that Sasha has already been doing
successfully for 3+ years now with the GSD project, so look at the
commits that have been assigned there for an example of what will be
picked.  Also we will probably go back in time for a few years and use
that data to populate the CVE database for older releases as long as
they are still in currently supported releases as this is something that
the CVE group has asked us to do already.

As for your list above, I doubt any of those would be a CVE, give us
some credit here.  Let's see how it goes and if people complain we are
picking things that we shouldn't be picking, OR if we aren't picking
enough, they will then be asked to join the team doing the work :)

The people that make up the current team, Lee, Sasha, and I, have a LONG
history of fixing and triaging and managing security bugs for the
kernel, in the community and in corporate environments.  We know how to
do this as we have been doing it for decades already.  If you or anyone
else wishes to help us out with this classification, we can gladly use
the help.

> Also, how are the CVSS-like scores going to be assigned? There are no 
> details whatsoever about that in the document.

We will not be doing any CVSS scoring as that is outside the scope of a
CVE entry and not required at all, and the CVE board agrees with this
decision.  As you well know, doing something like this for the kernel
where we have no idea what your use case is, is almost impossible on the
best days.

There are external groups that suck in the CVE entries and attempt to
assign CVSS-like scores to issues.  It will be "interesting" to see how
they classify things, but if the history of how well they have done this
in the past is any indication, their tools need a lot of work and
hopefully people stop relying on them and do the evaluation of their own
use cases instead.

> In any case, by making this change we are going to make security theathre 
> industry super-happy (they will have a lot of expensive nothing going on), 
> and all the distros not basing on -stable very unhappy (we're already 
> drowning because everybody and his grandma wants to become famous by 
> publishing a CVE for something completely irrelevant). If this is the 
> intention, it should be spelled out loud and clear.

As we are not allowed to credit anyone in the publication of a CVE, I
doubt the "I want a CVE!" group will get any louder than they currently
are.  And if it generates these people to actually submit bug fixes with
their reports, all the better for us!

I can't speak to the "security theatre industry" but right now, we have
a real problem of external groups assigning random CVEs to the kernel
with absolutely no input from us and no accountability, which is causing
a lot of us real problems.  This will take away the ability for those
groups to continue to abuse our project just because of their broken
engineering rules, and properly integrate them into our development
process if they so desire to join in.

thanks,

greg k-h

