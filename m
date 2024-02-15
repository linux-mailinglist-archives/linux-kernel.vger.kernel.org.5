Return-Path: <linux-kernel+bounces-67486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5DE856C51
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079A4284440
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBFB1386A7;
	Thu, 15 Feb 2024 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ChKhQcmg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94AA138494;
	Thu, 15 Feb 2024 18:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021213; cv=none; b=SoJfdTkUtEb7d+j9XC566Zw4NF4LHaCMNFp2xOMPOQ/0iXQa8ehlMU/cs/5M/IBmvB4TzF7UcCWuPjm6Ksj78wBwGAFiPD+3MRRYWdUi95jVBiukpWux9QowVGxDDR6kn0hLGiLEBupcSgWxgOEEZGVfDgPrHjYwvOR8hV23n0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021213; c=relaxed/simple;
	bh=MRpnfen0ZWzFE1XgOJl3rOhrZAuKnsTO4m98xqLleB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhS9mkpksi7/bJzeqqMssnQv/3scNh5q+lvZA/CG4DMCrNFSL4Oun5al+neq3SO0ShRfBg6Bx6WjAvuPS6z1Dvo8o5GHB5X2DLxTh8C7OR44aXQvm5OGmeY4em8WCBcO+jDPhu/VO+qMsONEVR/dOpc/6JEs6VQjCKtAv4Mx2OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ChKhQcmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BD6C433F1;
	Thu, 15 Feb 2024 18:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708021212;
	bh=MRpnfen0ZWzFE1XgOJl3rOhrZAuKnsTO4m98xqLleB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ChKhQcmgGqA6GFHftkDnUBYu6M7+wQHviAPSGU/IFcTDAMb1OhJOZQQzR5dzuV6mA
	 gIv+WZ03dRCVJYSNF3+4/WMls04NKNb6AlgKcKUiDMZSFO1M9FaoiY5xY7YvwkpkT3
	 khAin5KoLw3zBv1AFV3eVlHzHP68V6JGbPdFxsVc=
Date: Thu, 15 Feb 2024 19:20:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Message-ID: <2024021518-stature-frightful-e7fc@gregkh>
References: <2024021430-blanching-spotter-c7c8@gregkh>
 <Zc5PycMenLBYECAn@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc5PycMenLBYECAn@tiehlicka>

On Thu, Feb 15, 2024 at 06:54:17PM +0100, Michal Hocko wrote:
> On Wed 14-02-24 09:00:30, Greg KH wrote:
> [...]
> > +Process
> > +-------
> > +
> > +As part of the normal stable release process, kernel changes that are
> > +potentially security issues are identified by the developers responsible
> > +for CVE number assignments and have CVE numbers automatically assigned
> > +to them.  These assignments are published on the linux-cve-announce
> > +mailing list as announcements on a frequent basis.
> > +
> > +Note, due to the layer at which the Linux kernel is in a system, almost
> > +any bug might be exploitable to compromise the security of the kernel,
> > +but the possibility of exploitation is often not evident when the bug is
> > +fixed.  Because of this, the CVE assignment team is overly cautious and
> > +assign CVE numbers to any bugfix that they identify.  This
> > +explains the seemingly large number of CVEs that are issued by the Linux
> > +kernel team.
> 
> Does the process focus only on assigning CVE numbers to a given upstream
> commit(s) withou any specifics of the actual security threat covered by
> the said CVE?

Outside of the git commit text, no, we are not going to be adding
anything additional to the report, UNLESS someone wants to add
additional text to it, and then we will be glad to update a CVE entry
with the additional information.

Here's an example of what the CVE announcement is going to look like for
a "test" that we have been doing for our scripts
	https://lore.kernel.org/linux-cve-announce/2024021353-drainage-unstuffed-a7c0@gregkh/T/#u

Note, I am NOT saying this is a valid CVE-like commit, I only chose it
because it is a type of entry that our tools need to handle properly
(one where the fix was for a commit that was only in a stable tree, and
mainline never saw the problem.)  There are many different "styles" of
fixes that we need to handle when it comes to version information.

It will also be in JSON format on the cve.org site if you wish to parse
it automatically with tools.  We are still working out the proper format
of the JSON entries of the version information and should hopefully have
an agreement of how to do this early next week, as the logic there isn't
exactly "simple".

If the announcement format needs additional work, please let us know.

thanks,

greg k-h

