Return-Path: <linux-kernel+bounces-68517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8DB857B92
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C001B1C23C51
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3527763F;
	Fri, 16 Feb 2024 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ptvT6S4h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16811BF50;
	Fri, 16 Feb 2024 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082749; cv=none; b=b9j0IVfxxDsqm2JMC56uy701+hxAdJPlU7hTSPMfM7HhJv9OH3rxQTG8+bHrDkWZWEZEydRhZ24n+E2eH4i3ItvYWgDRbxrFt8Xi/VLxZivXpEiwnkE54dIPmlOcfshTB7KZ+48n4n+f1hQxKsP97reJrz15MxrkihBsy/8u/Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082749; c=relaxed/simple;
	bh=wfbfOHYhEUqJ5TM9ErRyjUT3fqX1apAxNMoim8z9BUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uW5kE3lTib4fZ+PA7HhPig/Y6rBeHQDM2pqEdiFrD/AbojB/s6Al2OZx53WAWIjjbIB3BIWFxO1blVkgS3XoalMIds8o90JbpOSu3LXaTnITxLTQfy5S+dw2HNlOi/GqzuiXxGzRS5rD/GMp+Hg10hePOeum9Nx2v4gRma8qwHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ptvT6S4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25C7C433A6;
	Fri, 16 Feb 2024 11:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708082749;
	bh=wfbfOHYhEUqJ5TM9ErRyjUT3fqX1apAxNMoim8z9BUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ptvT6S4hmck8T7DfBXRWhMMZxiHU57Z8VJqMdWvNXkfKaME3DHHbwj4VIdDOdWZ0C
	 Jf57sH9v4pUaq+j3IgTU9q9aptsU3j80t4C/XSPPw46JeBwy4gsuORjAcb+3YUg07e
	 MIzmcBxJ9ZGrFcmKjdb0IewJG5kkqec/lSLTqzEQ=
Date: Fri, 16 Feb 2024 12:25:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Message-ID: <2024021646-procedure-faceted-ea87@gregkh>
References: <2024021430-blanching-spotter-c7c8@gregkh>
 <Zc5PycMenLBYECAn@tiehlicka>
 <2024021518-stature-frightful-e7fc@gregkh>
 <Zc5ZpB6jsuTKmhv5@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc5ZpB6jsuTKmhv5@tiehlicka>

On Thu, Feb 15, 2024 at 07:36:20PM +0100, Michal Hocko wrote:
> On Thu 15-02-24 19:20:09, Greg KH wrote:
> > On Thu, Feb 15, 2024 at 06:54:17PM +0100, Michal Hocko wrote:
> > > On Wed 14-02-24 09:00:30, Greg KH wrote:
> > > [...]
> > > > +Process
> > > > +-------
> > > > +
> > > > +As part of the normal stable release process, kernel changes that are
> > > > +potentially security issues are identified by the developers responsible
> > > > +for CVE number assignments and have CVE numbers automatically assigned
> > > > +to them.  These assignments are published on the linux-cve-announce
> > > > +mailing list as announcements on a frequent basis.
> > > > +
> > > > +Note, due to the layer at which the Linux kernel is in a system, almost
> > > > +any bug might be exploitable to compromise the security of the kernel,
> > > > +but the possibility of exploitation is often not evident when the bug is
> > > > +fixed.  Because of this, the CVE assignment team is overly cautious and
> > > > +assign CVE numbers to any bugfix that they identify.  This
> > > > +explains the seemingly large number of CVEs that are issued by the Linux
> > > > +kernel team.
> > > 
> > > Does the process focus only on assigning CVE numbers to a given upstream
> > > commit(s) withou any specifics of the actual security threat covered by
> > > the said CVE?
> > 
> > Outside of the git commit text, no, we are not going to be adding
> > anything additional to the report, UNLESS someone wants to add
> > additional text to it, and then we will be glad to update a CVE entry
> > with the additional information.
> 
> OK, so what is the point of having CVE assigned to such a commit without
> any addional information which is already referenced by the kernel sha?
> What is the actual added value of that CVE?

It provides the proper signal to others that "hey, this is a
vulnerability that you might want to take if it affects you".  Right now
we are fixing lots and lots of things and no one notices as their
"traditional" path of only looking at CVEs for the kernel is totally
incorrect.

> > Here's an example of what the CVE announcement is going to look like for
> > a "test" that we have been doing for our scripts
> > 	https://lore.kernel.org/linux-cve-announce/2024021353-drainage-unstuffed-a7c0@gregkh/T/#u
> 
> Thanks this gave me some idea. One worrying part is
> : Please note that only supported kernel versions have fixes applied to
> : them.  For a full list of currently supported kernel versions, please
> : see https://www.kernel.org/
> 
> >From the above it is not really clear "supported by _whom_". Because I
> am pretty sure there are _fully_ supported kernels outside of that list
> which are actively maintained.

Very true, how about this wording change:
	For a full list of currently supported kernel versions by the
	kernel developer community, please see https://www.kernel.org/

I added "by the kernel developer community", is that ok?

And as you're here, I have no objection to adding the vulnerable/fixes
info from various distros that are curently based on these same
kernel.org versions if you wish to provide them to me.  Give us a few
more days to nail down the version reporting format and then take a look
at it to see if you all can tie into that.

thanks,

greg k-h

