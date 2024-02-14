Return-Path: <linux-kernel+bounces-64844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A749E854398
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C433B2296D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7F911739;
	Wed, 14 Feb 2024 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="chfbmIup"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CA11170A;
	Wed, 14 Feb 2024 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896728; cv=none; b=GwPhTaVgIc2/ABa4Dc98JWsIU/3u8g02HZWoApgl0punJwlJqExogmo6jP4REm7G3gqfFD5PfrqlsTwASB+liOAXN7INPsRscrn8KlCT+fczRcscClz7uvbLjEk6Hjz0R2SbikM8jobLulU3xwhQ7TR/pxvMcP42zcBd+n0fDo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896728; c=relaxed/simple;
	bh=RUCeVlrQV5heBUvtRcv+69N3Xim0F2S3fhlK0hOwa/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2+oxiHyeWQLNVv4Ojam54HXgSGqfMtJussl90nqferiv5X6kLQ6yMMmsAs64cS3iqtlnWdumRLZxsEnps3PVajW/igs3CyV13qGENvVuelPkHn5VEVB95V5q8d8YcSwAUkFm+nwkcXAjrfFInb1kpr3p6fZ9VIu/KA3Awl4ud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=chfbmIup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDA7C433C7;
	Wed, 14 Feb 2024 07:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707896728;
	bh=RUCeVlrQV5heBUvtRcv+69N3Xim0F2S3fhlK0hOwa/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=chfbmIupt9FkhnnyqBa+PYg4aiV3qwWx1RzrWbQuMhkDwup/+G53uzu21wijz4Z4l
	 Bx28yKyO1CIAcfO0p97lpb5/JwYnZlHKnwWri6stJ1ysqwSsNCy56Kfxo4wFzbiaul
	 jRcCMNzr9CqkTHn+Tj8i9TJeLtq6IqrxYGI4LjAU=
Date: Wed, 14 Feb 2024 08:45:19 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Sasha Levin <sashal@kernel.org>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH] Documentation: Document the Linux Kernel CVE process
Message-ID: <2024021446-rosy-citation-0a80@gregkh>
References: <2024021314-unwelcome-shrill-690e@gregkh>
 <202402131429.A604440C6@keescook>
 <2024021445-emporium-tightwad-3c35@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021445-emporium-tightwad-3c35@gregkh>

On Wed, Feb 14, 2024 at 07:43:32AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 13, 2024 at 02:35:24PM -0800, Kees Cook wrote:
> > On Tue, Feb 13, 2024 at 07:48:12PM +0100, Greg Kroah-Hartman wrote:
> > > +No CVEs will be assigned for unfixed security issues in the Linux
> > > +kernel, assignment will only happen after a fix is available as it can
> > > +be properly tracked that way by the git commit id of the original fix.
> > 
> > This seems at odds with the literal definition of what CVEs are:
> > _vulnerability_ enumeration. This is used especially during the
> > coordination of fixes; how is this meant to interact with embargoed
> > vulnerability fixing?
> 
> Yes, this is totally wrong, it was the original first draft of the
> document, that I did on my workstation, and then went on the road for 3+
> weeks and I never sycned up when I got home with the updated version
> that is on my laptop.  The updated version addresses this, as it was
> rightly pointed out by the CVE group that this is not how a CNA is
> supposed to only work.
> 
> Yet another reason why keeping changes private is a major pain, not only
> for security ones!  :(
> 
> Let me send out the proper one after my morning coffee has kicked in and
> I resolve the differences, and make the grammer fixes that Randy pointed
> out...

To make it more obvious here, as others have pointed this out to me as
well, here's the updated paragraph that will be in my v2 patch, with
proper ';' usage:

	No CVEs will be automatically assigned for unfixed security issues in
	the Linux kernel; assignment will only automatically happen after a fix
	is available and applied to a stable kernel tree, and it will be tracked
	that way by the git commit id of the original fix.  If anyone wishes to
	have a CVE assigned before an issue is resolved with a commit, please
	contact the kernel CVE assignment team at <cve@kernel.org> to get an
	identifier assigned from their batch of reserved identifiers.

Does that help explain the process better?

thanks,

greg k-h

