Return-Path: <linux-kernel+bounces-67490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2F6856C62
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73C61F22C60
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B9C1386B7;
	Thu, 15 Feb 2024 18:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jKWelaQu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE5E1384BE;
	Thu, 15 Feb 2024 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021467; cv=none; b=XJTE4ym2YvqQq0XR/bQdnv75OuUwTXIWiTLbaHygPtZhr/QuC2IedumJxV09lWcmuRcdplE0TJsM5F5M0clUz5v0CwGethQfDbeT49F0YjDtx46p+0kSInp7WJBXyfbFBmNvw+hw+KhE+IIPu8cRiIBy15dkoX3MmGmkWuBF2fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021467; c=relaxed/simple;
	bh=2T1+tvt60SNf30Xn2WusR7S21+ZI/B1zECY9WVy1KOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4Y3je2bRlzHD9ILDuwqv+nNkNhZm+hq0fwnei1CM/mCA6qhgrNtrEPJ+wMrOHnRdm4ami18eFcY21Jbal+JlP1X8aZxqSh8FAqYo794fXW/Hw5mkir9FZHbcurkZPY9zTc8Ax+gynGuzkl6ezX97whHD4R9GkpdmJ0a3mVVIiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jKWelaQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1D4C433C7;
	Thu, 15 Feb 2024 18:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708021466;
	bh=2T1+tvt60SNf30Xn2WusR7S21+ZI/B1zECY9WVy1KOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jKWelaQu2i9X85eLTdggrei6BKe1RVOeFvagBnpBABHBGiej8YsSNf/0uM9/aVlD1
	 AwMfgHfocQWRExmyxe9wh00/v/w7jmE9AtW4fPsZXrnNibH2Vq4SbkQSCV/7sGwssY
	 YzpC6X1qf1OInyZjZwWXeaBpmVDPnCXTWO/w1L7c=
Date: Thu, 15 Feb 2024 19:24:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	linux@leemhuis.info, Kees Cook <keescook@chromium.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Sasha Levin <sashal@kernel.org>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v4] Documentation: Document the Linux Kernel CVE process
Message-ID: <2024021527-shove-bodacious-e624@gregkh>
References: <2024021500-laziness-grimace-ed80@gregkh>
 <nycvar.YFH.7.76.2402151817440.21798@cbobk.fhfr.pm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2402151817440.21798@cbobk.fhfr.pm>

On Thu, Feb 15, 2024 at 06:38:05PM +0100, Jiri Kosina wrote:
> On Thu, 15 Feb 2024, Greg Kroah-Hartman wrote:
> 
> > The Linux kernel project now has the ability to assign CVEs to fixed
> > issues, so document the process and how individual developers can get a
> > CVE if one is not automatically assigned for their fixes.
> 
> There is still one thing that's not clear to me with this new process, and 
> that's how embargos are going to be handled.
> 
> Currently, the process is broken as well, but at least understood by 
> everybody.
> 
> - issues are reported to security@kernel.org. No CVE assigned, 7days 
>   embargo, then fix gets pushed out
> 
> - at some point (in parallel, before, or after the above), the issue gets 
>   reported to linux-distros@. CVE gets assigned, and downstreams start 
>   integrating the fix (once available) to their codebase.

linux-distros is not allowed to assign a CVE id for a Linux kernel fix,
so this will not happen here anymore.  They HAVE to contact
cve@kernel.org in order to do this as no one else is allowed to create a
CVE entry for Linux unless some very extreem things happen that I do not
plan on ever having happen to us (see the CNA rules for details.)

> - embargo is lifted, fixes are released with proper CVE reference
> 
> How is the new process going to look like? Please keep in mind that 
> linux-stable is (by far!) *not* the only downstream of Linux Kernel 
> project.

I agree, and again, linux-distros will not be assigning CVEs for issues
that affect the currently supported kernels as listed on kernel.org, nor
will any other group, so this shouldn't be an issue as we can coordinate
properly if the above senario happens.

> We've had this discussion in other contexts already, but I whole-heartedly 
> believe that it's in no way in the Linux Kernel project's interest to kill 
> those other downstreams (read: Linux distros) (*) ... or is it?

I have no interest in doing anything about linux-distros, just that they
are not allowed to assign a new CVE for Linux anymore as of Tuesday this
week, and neither is any other CNA, just like they are not allowed to
assign a CVE for Windows today, no difference at all.

thanks,

greg k-h

