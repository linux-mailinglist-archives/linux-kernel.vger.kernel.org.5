Return-Path: <linux-kernel+bounces-86043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF3D86BEE4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9053B24198
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C116E37149;
	Thu, 29 Feb 2024 02:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="OH+LSqhQ";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ihh1gmTk"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAED933CF1;
	Thu, 29 Feb 2024 02:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709173392; cv=none; b=MRIODshIR/7b3ocLPYc3dfqZ9Ru5WjsCBeDeBzAeeotbEaCqwC70vLnOc0At9cjR9O2YfGGM5nQUsLUn8IvYpQvTXwi4KvD7get22l60s5THUdZ0/6rR3MeY9N9CmNxKGApNZAGw4HDRhR1VS1BsrMeHu/DlT11aVkw2mW7Tlps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709173392; c=relaxed/simple;
	bh=0Fbi5ZAg7Uf7prUv2XS6xmsOLyEbnEHlNUw6NlOeY9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+ao2vRSsflGGgGeRuyL1DOjKddUxMP4M8Ak3eN0YP4ZUAHgHjFist89davhM/XaEpnyLkwCJYNs3oNAi6ADPQsugJ5NCXT4JhN5hKOJlg8kDMaZaNsgg88UXbBD4cqN2ssthMPjmFWrsRuneNJsJZhk291eLgQAFZkP1AsErSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=OH+LSqhQ; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=ihh1gmTk; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 6592AC01C; Thu, 29 Feb 2024 03:23:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709173382; bh=kHqYKpzkFMSrtvJ6fyOrRsaNmM72iJYg8f1LNIssPbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OH+LSqhQo7hIHUT3o7cRs7jCL9VUq6kbaz+k+0lj4eXEL7WYEcwokoXapW9o/ZJxt
	 iv1zOIE7Z0HDOr1sVWAWN07XBfa4ku5I4PTnQdzHCppek1r0mKZE24yrjCbOcg4FTv
	 aXiRQ8+VrrT4Deez/gyX4W5RlIjrNHcKTHcrWptw+LvPmm4/ZQ23qHB4CretMmljOy
	 nRMDO7jcjxQ6fvOQxGpBBqyYnTzCjq8X79/Z8GnoQPnjzAHOVn3T1Y238Yh/Y6MYdP
	 +clKQO0LrIlabv3AVH5X+05qmAPuRa5WmtYcrsNv593+vH1GWb8JYqoZgSqQnAXmvY
	 IxpZUAZT0eXug==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 5A98DC009;
	Thu, 29 Feb 2024 03:22:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709173380; bh=kHqYKpzkFMSrtvJ6fyOrRsaNmM72iJYg8f1LNIssPbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ihh1gmTk1f1wUHyWQLFRPjxL+nUJBOK893eWBUjJzucPyOEL09wCcsxKMjptcWAq8
	 WhkmwHMjNxlUiuxvnVxFw4VAuQgKghZ+PjjxcbM3YGoy5BDMm30uteyuRiFdxdHFte
	 haCy2l5YJdduAelXfHpUtJ4w6eVlUXlevXw9aG65HtzOhupWtT/5V/K5vY+s+1IOtH
	 S2g4gjVgA7nzpV7qBs2fbKqSbzRd2DfWl/4iaUH/ViVtFQX5LVQpPAOTHs3K6PXuPk
	 4uesdBoLkdalD2QD0kz1U24Ea9+HUSKTbXn+DGLNtbAQZAZgJ5RLcvNFK4c0P/E5BH
	 8ku6nkWBGqzyA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id f503bea0;
	Thu, 29 Feb 2024 02:22:50 +0000 (UTC)
Date: Thu, 29 Feb 2024 11:22:35 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 000/122] 5.10.211-rc1 review
Message-ID: <Zd_qaxKc9V6dMkOA@codewreck.org>
References: <20240227131558.694096204@linuxfoundation.org>
 <Zd53aNc1aFrCYxFd@codewreck.org>
 <2024022804-askew-stung-cba8@gregkh>
 <202402281231.F7A20FCE@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202402281231.F7A20FCE@keescook>

Kees Cook wrote on Wed, Feb 28, 2024 at 12:39:42PM -0800:
> > > This commit breaks build of some 3rd party wireless module we use here
> > > (because sizeof(sa->sa_data) no longer works and needs to use
> > > sa_data_min)
> 
> Just FYI, it's possible that things using sizeof(sa->sa_data) were buggy
> to begin with since the struct size isn't actually dictated by that size
> (it's only the minimum possible size).

Yes, I definitely agree with this.
As it's "vendor stuff" I just replaced with sa_data_min because that
preserves the values, but it ought to get a second look.
I'd love to pretend that driver's upstream will do the right thing and
use proper values here on newer kernel but upon checking its >6.2 tree
support now they apparently did the same instead of getting the size
properly.

> > We NEVER preserve in-kernel APIs for any out-of-tree code as obviously,
> > we have no idea what out-of-tree code is actually using, so it would be
> > impossible to do so.

Right, I just don't see much "common struct" changes in stable tree
patches -- stuff like livepatches or weak modules and whatsnot don't
like these so some downstreams (redhat to name them) try very hard to
keep these constants for the lifetime of a given stable release... iirc
they go as far as adding some padding fields to some structs that are
likely to need fiddling so they can do this while preserving binary
compatibility.

I understand the upstream stable kernels don't make such promise (and
given the amount of work that probably goes into it, rightfully so! I
wouldn't exect you or anyone to do this here), just pointed it out
as part of my usual test round for anyone else who'd care.

> Out of curiosity, which drivers broke and what's needed to get them into
> upstream (or at least staging)?

Sure, it was NXP's wifi chips driver:
https://github.com/nxp-imx/mwifiex/

It's mostly based on drivers/net/wireless/marvell/mwifiex but has since
been quite extensively modified, so it'd take quite a bit of effort to
upstream as a separate entity (changing a few names to avoid conflcts so
both can be built together... Add to that the requirement for a
compatible firmware with a restrictive license... And that NXP isn't
exactly focused on upstreaming); I have little hope of seeing it
upstream at this point unfortunately and gave up on it as part of
maintaining an embedded kernel "port" as it's sadly far from being
only one :/

(I especially don't get it as I consider maintaining a bunch of
spaghetti ifdef on kernel versions to be much more work than getting the
driver upstream once, but I guess I'm barking at the wrong tree here)


Thanks,
-- 
Dominique Martinet | Asmadeus

