Return-Path: <linux-kernel+bounces-67441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC3F856B91
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E072C2854FC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1752B137C3D;
	Thu, 15 Feb 2024 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uOe3plOE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FB5132C04;
	Thu, 15 Feb 2024 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019403; cv=none; b=BeRHgq8h/b2P6WLOe3saNfRtuZc+YFCizSXk4nA5OCIEFMAfhz+yR3lWb+xJY3TipJjcGh0KegdOo3hP5kYySco1Xk8m4u7NkmzHdm/rB95Z9j5SHI3rw/jluHD7i2r/+76E8PStzPw5YFUIB2mDb4ONQrhe90OHnPpVYCPHY5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019403; c=relaxed/simple;
	bh=6iQEyzYwkfviCF0e55aaTe03PfZ0ULlRw8Re/HVfXG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxRnF6QcBZ+VtCu7Fitb0xRl99d0m0wVSDNLTbvKmbnKJjr5DwQv7RAMPruKNwHSgAFFhF3FMBbGLE37X/3f2+JvVQcy+FUs4/kYB5i3e6bLtOv0RJJ4Vh5BpWt/9gVRIOMsSW16jPKJGk/RoO/wZME1a5ZuDs46q00jIlThlvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uOe3plOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDCDC433C7;
	Thu, 15 Feb 2024 17:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708019402;
	bh=6iQEyzYwkfviCF0e55aaTe03PfZ0ULlRw8Re/HVfXG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uOe3plOEdv4hi0f9UwZO1CKVPuo7vyj8zfyB/Vcjs79ilrzKx2dCW7wkj2WIW6xRp
	 lY4lvr+dDPR+87ZGwsahxBrziCUjClG3S8DwVGeKSu6YdjdWM1Ci8VcdQTppTwQ5yF
	 YdbPga9Kf9il4NVPS7eqyfAuJhpRcgkbZhFLQfFU=
Date: Thu, 15 Feb 2024 18:49:59 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>, corbet@lwn.net,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Message-ID: <2024021518-repressed-sinless-7111@gregkh>
References: <2024021430-blanching-spotter-c7c8@gregkh>
 <CAKXUXMw-xZ_w6prrdTG5Vs=QL1EDvwGv1M9r2PT14LE+HxWUHQ@mail.gmail.com>
 <2024021532-commode-knickers-3895@gregkh>
 <12454500.O9o76ZdvQC@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12454500.O9o76ZdvQC@natalenko.name>

On Thu, Feb 15, 2024 at 05:10:50PM +0100, Oleksandr Natalenko wrote:
> Hello.
> 
> On čtvrtek 15. února 2024 13:04:56 CET Greg Kroah-Hartman wrote:
> > On Wed, Feb 14, 2024 at 09:34:38AM +0100, Lukas Bulwahn wrote:
> > > On Wed, Feb 14, 2024 at 9:01 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > The Linux kernel project now has the ability to assign CVEs to fixed
> > > > issues, so document the process and how individual developers can get a
> > > > CVE if one is not automatically assigned for their fixes.
> > > >
> > > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > > ---
> > > > v3: fix up wording in security-bugs.rst based on the changes to the cve
> > > >     assignment process from v1, thanks to a private reviewer for
> > > >     pointing that out.
> > > > v2: Grammer fixes based on review from Randy
> > > >     Updated paragraph about how CVE identifiers will be assigned
> > > >     (automatically when added to stable trees, or ask us for one
> > > >     directly before that happens if so desired)
> > > >
> > > 
> > > Hi Greg, Sasha, Lee,
> > > 
> > > Generally, I think this is a great step forward on the whole "security
> > > vulnerability mess" and this will certainly help me and others in the
> > > embedded space to argue to update to recent stable kernel versions.
> > > This can then finally put the practice of shipping multiple-year-old
> > > kernel versions to an end. Often this was just done with the argument
> > > that there is not a recent CVE and fix assigned to some recent stable
> > > kernel version---and integrators think updates to recent kernel stable
> > > versions are not needed and not recommended.
> > > 
> > > I am looking forward to seeing what and how many stable commits are
> > > going to get CVEs assigned. If Greg's policy from the Kernel Recipes
> > > 2019 presentation comes into play, every git kernel hash (GKH)---at
> > > least in the stable tree---could get a CVE identifier (just to be on
> > > the safe side). But I assume you are going to use some expert
> > > knowledge, heuristics or some machine-learning AI to make some commits
> > > in the stable tree carrying a CVE identifier and some others not.
> > 
> > Yes, that "expert knowledge" will be "review all patches by hand" just
> > like we do today for all that are included in the stable trees.
> 
> Not undermining your efforts in any way, but I'd like to get an honest answer: is this really true? For instance,
> 
> $ git log --oneline v6.7.1..v6.7.2 | wc -l
> 641
> 
> Is it physically possible to actually review all these backports in just five days?

I did, yes.  And have been doing so for 15+ years, practice makes it
easier :)

thanks,

greg k-h

