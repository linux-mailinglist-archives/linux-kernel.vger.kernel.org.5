Return-Path: <linux-kernel+bounces-67439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F58856B8B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695131C23C7C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC71137C59;
	Thu, 15 Feb 2024 17:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f5Tm25vQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8614D133988;
	Thu, 15 Feb 2024 17:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019347; cv=none; b=DbUJ6QrY8YqXtcf6dOBI8L+p5SNbFbe3SCE8Zf1bdW0Wm5//P4Pjg8HqQkJKW//G6r+Wg1nncAeB9Si/lZwtHHOoD+fL7/RmAfZo7KdmK13d+tpDZm3ZBgxAYYu5zt0xHTbDrcbU2zupDsdIyjYQ4s5ENtF+YvOPzZIpeRA3Sg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019347; c=relaxed/simple;
	bh=7JEy5F54LuMwGEU+GzxGkPlRz7RhAe1o97Rr8H5dzFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfvtxZxamEEpAUC8LCYT5W1rFoVpoMG4qIZ5fdro728e8d8Hflu2fNHOG3QhSY9GJdBbThLdG2kFllVfjPjHzOqTo7R6MPiNwZZGxM3s+JyX5/x2XUdJX/p94XQ8J98CuqiUmRE40FvmJ58JpMagu11oTRZIlkob8HklucfmKoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f5Tm25vQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C5BC433F1;
	Thu, 15 Feb 2024 17:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708019347;
	bh=7JEy5F54LuMwGEU+GzxGkPlRz7RhAe1o97Rr8H5dzFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5Tm25vQEI0KvL/k7Tv4L0pgCVysl/nwoegE2LaBse87ULU+dmlK9z2tJfhxLsyAj
	 u8nXB2vCb3ERVR73iMW8pOCFOS3LfN533JFexagDISzfifEbsbTqOwVF3/d0DSwuhN
	 hpF8g+EjoVwXAxaCZmcU4ZXdn3rYS3eGuk/3exoY=
Date: Thu, 15 Feb 2024 18:49:04 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	linux@leemhuis.info, Kees Cook <keescook@chromium.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Sasha Levin <sashal@kernel.org>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v4] Documentation: Document the Linux Kernel CVE process
Message-ID: <2024021557-remedial-mutilated-63c6@gregkh>
References: <2024021500-laziness-grimace-ed80@gregkh>
 <0bd8c620-7f80-44c4-ade3-b3d7951b48d8@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0bd8c620-7f80-44c4-ade3-b3d7951b48d8@suse.com>

On Thu, Feb 15, 2024 at 04:03:02PM +0100, Jürgen Groß wrote:
> On 15.02.24 13:10, Greg Kroah-Hartman wrote:
> > The Linux kernel project now has the ability to assign CVEs to fixed
> > issues, so document the process and how individual developers can get a
> > CVE if one is not automatically assigned for their fixes.
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> > v4: Add MAINTAINER entry
> >      Lots of tiny wording changes based on many reviews
> >      Collected some Reviewed-by: tags
> >      Fixed documenation build by properly referencing the security
> >      process documentation file.
> > v3: fix up wording in security-bugs.rst based on the changes to the cve
> >      assignment process from v1, thanks to a private reviewer for
> >      pointing that out.
> > v2: Grammer fixes based on review from Randy
> >      Updated paragraph about how CVE identifiers will be assigned
> >      (automatically when added to stable trees, or ask us for one
> >      directly before that happens if so desired)
> > 
> >   Documentation/process/cve.rst           | 120 ++++++++++++++++++++++++
> >   Documentation/process/index.rst         |   1 +
> >   Documentation/process/security-bugs.rst |   5 +-
> >   MAINTAINERS                             |   5 +
> >   4 files changed, 128 insertions(+), 3 deletions(-)
> >   create mode 100644 Documentation/process/cve.rst
> > 
> > diff --git a/Documentation/process/cve.rst b/Documentation/process/cve.rst
> > new file mode 100644
> > index 000000000000..6b244d938694
> > --- /dev/null
> > +++ b/Documentation/process/cve.rst
> > @@ -0,0 +1,120 @@
> 
> ...
> 
> > +Invalid CVEs
> > +------------
> > +
> > +If a security issue is found in a Linux kernel that is only supported by
> > +a Linux distribution due to the changes that have been made by that
> > +distribution, or due to the distribution supporting a kernel version
> > +that is no longer one of the kernel.org supported releases, then a CVE
> > +can not be assigned by the Linux kernel CVE team, and must be asked for
> > +from that Linux distribution itself.
> > +
> > +Any CVE that is assigned against the Linux kernel for an actively
> > +supported kernel version, by any group other than the kernel assignment
> > +CVE team should not be treated as a valid CVE.  Please notify the
> > +kernel CVE assignment team at <cve@kernel.org> so that they can work to
> > +invalidate such entries through the CNA remediation process.
> 
> Today we (the Xen security team) are allocating CVEs for Xen-related
> kernel security bugs.
> 
> Does this mean we should do that via cve@kernel.org in future, or are
> you happy us continuing our process as today? If the latter, I think
> this should be noted somehow in this document in order to avoid complaints
> regarding CVEs allocated by us.
> 
> 
> Juergen (on behalf of the Xen security team)

That's a good question, and from what I can tell for the "rules" here,
yes, we need to coordinate somehow for anything that is Linux
kernel-only.  Just email us and ask us for an id and our tools can take
it from there for the submission and other stuff, so hopefully this will
make things easier.

For stuff that crosses both sides (Xen and Linux), you are free to
create your own CVE and then use that identifier in the kernel patch
like you have in the past as I would consider Xen being the "primary"
CNA, don't you?

Is that ok?  We want to make this as easy as possible, so I don't want
to get in the way of your existing process if at all possible.

thanks,

greg k-h

