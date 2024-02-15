Return-Path: <linux-kernel+bounces-66438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E049D855CB8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74BB11F21BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D0C13AC2;
	Thu, 15 Feb 2024 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qUSeNpJP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C14E11190;
	Thu, 15 Feb 2024 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707986630; cv=none; b=iO0qVJUdI3WYFvlYdir/VjnBNqsSq1gI5ddWdt/x8F6uwBsuhATNFuUNuByVbBv1nTrlzpT4ZUR7gb/QUtngtdvGFQ6jP/agNquFF+USsirUx4JrFUhE4SMDI/bpZ/6z9Ow602tpL620Ide9Nm9lKGfFloZfEy8haKcyw3UXMng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707986630; c=relaxed/simple;
	bh=GuwbsmOtHo+Flr8Y2Vo03gk1oxMx2L+OAUobFiOEuug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQcYsbq+T0sNs4Xjzz2bOGm6M0ZRtACTnPMi9tOPvoQkrcwz6fEvUtrXzEhWzOdYc7BHeLu/Xv1VU/rd/zhRPxpL5RSLpzAFdxF32KZhtrq3zhUVxk9OmBmf7ePgwFPZnqJm0YwqWSZqlTH1/DgiBfis5ta6SNNHvmdH4AjAe+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qUSeNpJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F207C433C7;
	Thu, 15 Feb 2024 08:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707986629;
	bh=GuwbsmOtHo+Flr8Y2Vo03gk1oxMx2L+OAUobFiOEuug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qUSeNpJPsk0OcAa6uYWbcG5xIrhxjnrEFcNoKP2HRc18SFKH6f7YgbkuluRSHSyJC
	 7Wrs4FsptmVf/9fQaliqk9gaCFMJ0+qd/XfMFWpkyFe+792M3RbXXzptP7kQAMJxVb
	 qzIw0GFL8Q5jekXpys7MdHBsEkVhDFqvVDzHWQe4=
Date: Thu, 15 Feb 2024 09:43:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Message-ID: <2024021521-bannister-unlaced-ba2b@gregkh>
References: <2024021430-blanching-spotter-c7c8@gregkh>
 <11248961-9180-4330-8537-1cd0037edb85@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11248961-9180-4330-8537-1cd0037edb85@leemhuis.info>

On Thu, Feb 15, 2024 at 09:17:59AM +0100, Thorsten Leemhuis wrote:
> On 14.02.24 09:00, Greg Kroah-Hartman wrote:
> > The Linux kernel project now has the ability to assign CVEs to fixed
> > issues, so document the process and how individual developers can get a
> > CVE if one is not automatically assigned for their fixes.
> > [...]
> 
> This following is just nitpicking, hence feel free to ignore.
> 
> > +As always, it is best to take all released kernel changes, as they are
> > +tested together in a unified whole by many community members, and not as
> > +individual cherry-picked changes.  Also note that for many bugs, the
> > +solution to the overall problem is not found in a single change, but by
> > +the sum of many fixes on top of each other.  Ideally CVEs will be
> > +assigned to all fixes for all issues, but sometimes we do not notice
> > +fixes in released kernels, so do not assume that because a specific
> > +change does not have a CVE assigned to it, that it is not relevant to
> > +take.
> 
> There are a four "not" in the last pretty long sentence which makes it
> kinda hard to parse. Avoiding that could look like this:
> 
> Ideally CVEs will be assigned to all fixes for all issues -- but
> sometimes we will fail to notice fixes, therefore assume that some
> changes without an assigned CVE might still be relevant to take.
> 
> Or like this:
> 
> Ideally CVEs will be assigned to all fixes for all issues, but sometimes
> we will overlook fixes -- therefore assume that some changes that lack
> an assigned CVE might still be relevant to take.
> 
> Not sure if that really makes it better, I guess you as a native speaker
> are a better judge here.

I like the wording change here, thanks, I'll take it for the next
revision.  It is ackward as I wrote it and your update makes it simpler
and more obvious.

> Ciao, Thorsten (who also wondered what "to all fixes for all issues"
> exactly means, but whatever)

Meaning "we will miss things" so don't assume that because we don't call
it out here, it's not important to take.  Yeah, again, ackward wording,
language is "fun"...

thanks for the review!

greg k-h

