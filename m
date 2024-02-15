Return-Path: <linux-kernel+bounces-66858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6F6856280
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B4E1C21825
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3944F12BF12;
	Thu, 15 Feb 2024 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ygrUK4A3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA3112AADA;
	Thu, 15 Feb 2024 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998700; cv=none; b=FMufZBYuJZEbGG253xqiKXqufSnZpG0wE5158GemUb3cBO0FFmr9+orj1c9Y6SrJOIhpLQxlIfVQt9QRjTm0lepJrxVuECjR3fGVuAF8E+MWrJnihc6zAzb6PsBvP49rIAwAWvDlrexYfky9Gc0SOfqIdjLwcKhYlfPtn3W4GcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998700; c=relaxed/simple;
	bh=cZl60GmlbJhBSZCYwJlYsOtY8adqP10k5drAGwjUVK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ejq1EpGH0M1anN3KvZRqfaI/DZ2PqLyg/1/zZNp9xy/opHoK55899IeKSj60TqhSkDAnN2HOiMg6gCpyDK6UzMUR9WWJFGYSRzHQSL3pROGrDTHx4152HGg2gYOiIR+0HpDLf7yN+58+N0NfsMR1urNYiFQAU9jkmebzTAUxF2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ygrUK4A3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D00BC433C7;
	Thu, 15 Feb 2024 12:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707998699;
	bh=cZl60GmlbJhBSZCYwJlYsOtY8adqP10k5drAGwjUVK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ygrUK4A3mOQUlv++GGIUP1LXGDLWlToiiyi8mPnsaFhJhU7o83QJYgBRrnGmm8ddW
	 AFtuPkYh6FCqO0vxkF3Rz713xpf1Ts5IUBjdQDJNzj1dLAKDuUsdwWsE9jW3EScmll
	 LJ5XnbvzeGDcoIrTAFY2vmTUtyOcc/Ualj3Nq6AE=
Date: Thu, 15 Feb 2024 13:04:56 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Message-ID: <2024021532-commode-knickers-3895@gregkh>
References: <2024021430-blanching-spotter-c7c8@gregkh>
 <CAKXUXMw-xZ_w6prrdTG5Vs=QL1EDvwGv1M9r2PT14LE+HxWUHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKXUXMw-xZ_w6prrdTG5Vs=QL1EDvwGv1M9r2PT14LE+HxWUHQ@mail.gmail.com>

On Wed, Feb 14, 2024 at 09:34:38AM +0100, Lukas Bulwahn wrote:
> On Wed, Feb 14, 2024 at 9:01 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > The Linux kernel project now has the ability to assign CVEs to fixed
> > issues, so document the process and how individual developers can get a
> > CVE if one is not automatically assigned for their fixes.
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> > v3: fix up wording in security-bugs.rst based on the changes to the cve
> >     assignment process from v1, thanks to a private reviewer for
> >     pointing that out.
> > v2: Grammer fixes based on review from Randy
> >     Updated paragraph about how CVE identifiers will be assigned
> >     (automatically when added to stable trees, or ask us for one
> >     directly before that happens if so desired)
> >
> 
> Hi Greg, Sasha, Lee,
> 
> Generally, I think this is a great step forward on the whole "security
> vulnerability mess" and this will certainly help me and others in the
> embedded space to argue to update to recent stable kernel versions.
> This can then finally put the practice of shipping multiple-year-old
> kernel versions to an end. Often this was just done with the argument
> that there is not a recent CVE and fix assigned to some recent stable
> kernel version---and integrators think updates to recent kernel stable
> versions are not needed and not recommended.
> 
> I am looking forward to seeing what and how many stable commits are
> going to get CVEs assigned. If Greg's policy from the Kernel Recipes
> 2019 presentation comes into play, every git kernel hash (GKH)---at
> least in the stable tree---could get a CVE identifier (just to be on
> the safe side). But I assume you are going to use some expert
> knowledge, heuristics or some machine-learning AI to make some commits
> in the stable tree carrying a CVE identifier and some others not.

Yes, that "expert knowledge" will be "review all patches by hand" just
like we do today for all that are included in the stable trees.

> Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks for the review.

> > +Common Vulnerabilities and Exposure (CVE®) numbers were developed as an
> > +unambiguous way to identify, define, and catalog publicly disclosed
> > +security vulnerabilities.  Over time, their usefulness has declined with
> > +regards to the kernel project, and CVE numbers were very often assigned
> > +in inappropriate ways and for inappropriate reasons.  Because of this,
> > +the kernel development community has tended to avoid them.  However, the
> > +combination of continuing pressure to assign CVEs and other forms of
> > +security identifiers, and ongoing abuses by community members outside of
> > +the kernel community has made it clear that the kernel community should
> > +have control over those assignments.
> > +
> 
> Though, I get what is meant with "the community members outside of the
> kernel community", it still feels strange when reading.
> 
> Here are some alternatives I could come up with:
> 
> "reporters outside the kernel community"
> "reporters beyond the actively contributing/engaged kernel community members"
> "individuals not engaged with the kernel community"

"community members" is a strange wording, you are right, I've replaced
it with "individuals and companies" as it has been both abusing the
system (and "individuals at companies", but that's just nit-picking...)

> > +The Linux kernel developer team does have the ability to assign CVEs for
> > +potential Linux kernel security issues.  This assignment is independent
> > +of the :doc:`normal Linux kernel security bug reporting
> > +process<../process/security_bugs>`.
> > +
> > +A list of all assigned CVEs for the Linux kernel can be found in the
> > +archives of the linux-cve mailing list, as seen on
> > +https://lore.kernel.org/linux-cve-announce/.  To get notice of the
> > +assigned CVEs, please subscribe to that mailing list.
> > +
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
> 
> Just a nit: but I would say: a kernel bug is compromising the
> "security of the system"; the kernel bug just happens to allow anyone
> to run any code on their hardware... in some systems that is a
> security issue, but in my previous MSDOS system that was the default
> behaviour ;)

Good change, made, thanks!

greg k-h

