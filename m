Return-Path: <linux-kernel+bounces-65384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD54854C32
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65461285196
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D065C5F4;
	Wed, 14 Feb 2024 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uE4CD0oT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638D55B69A;
	Wed, 14 Feb 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923381; cv=none; b=l2d3GR6/oxnLNbWDM77SpMRniQyggD4WhuXaBKvKW1HaZyHzima7aU/mEUn5C+9btr1uj8r7jv8LstV2CGG9aje0XEm1yH2QmUv6b1pbuDKek9HTwVYNhi+vJNl7Q/WLcTdgLT6h8dOXgvwsGeWQK6hhmBG6dOBv8zYV/3P2zv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923381; c=relaxed/simple;
	bh=ujpFZPB5S110yiOOEykya0//53jcoU7Y6JWGXFOWTBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6mz8568NaBhPOCfMHf3BZhqT4iGAoanUKXTlLNVRvlHG2U/woWBuKICfgqDdSgGbqeY/762jh9k+aE53tDw5brY15c/wEjMvLTJZejiQ1ESJuAHRfaRbAlnXK7ml6KSFToB5Z1kU8lRr/u7XPaE5vrmmvkmUrfpw8o0G+j5Iq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uE4CD0oT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727FAC433F1;
	Wed, 14 Feb 2024 15:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707923380;
	bh=ujpFZPB5S110yiOOEykya0//53jcoU7Y6JWGXFOWTBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uE4CD0oTGpT1vxAAjZoHf7uAaI5HYKsZMiiUzqoRZpX6a40BWyEKQHJFUdmHEixiK
	 UMhtBZOS0SowgmyL35K9XXaCyD/oKwNc6d5NYrUVqi0UxIXNJTk5OmAscBCzfw4OZE
	 ATV6woFi8+pWnLJoTkhap+uV5XYASLf2jaSTQehw=
Date: Wed, 14 Feb 2024 16:09:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Message-ID: <2024021447-fastball-twilight-5389@gregkh>
References: <2024021430-blanching-spotter-c7c8@gregkh>
 <nycvar.YFH.7.76.2402141433560.21798@cbobk.fhfr.pm>
 <2024021459-trimness-bolt-7185@gregkh>
 <nycvar.YFH.7.76.2402141535380.21798@cbobk.fhfr.pm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2402141535380.21798@cbobk.fhfr.pm>

On Wed, Feb 14, 2024 at 03:38:52PM +0100, Jiri Kosina wrote:
> On Wed, 14 Feb 2024, Greg Kroah-Hartman wrote:
> 
> > The people that make up the current team, Lee, Sasha, and I, have a LONG
> > history of fixing and triaging and managing security bugs for the
> > kernel, in the community and in corporate environments.  We know how to
> > do this as we have been doing it for decades already.  
> 
> Thanks for clarifying. Maybe the wording could use some more verbosity 
> then; one of my potential readings of it was "everything that gets picked 
> for -stable will get a CVE assigned".

CVE has a very specific definition already, as per cve.org:

	 CVE Record is the descriptive data about a vulnerability
	 associated with a CVE ID, provided by a CVE Numbering Authority
	 (CNA). This data is provided in multiple human and
	 machine-readable formats.

And they define "vulnerability" as:

	An instance of one or more weaknesses in a Product that can be
	exploited, causing a negative impact to confidentiality,
	integrity, or availability; a set of conditions or behaviors
	that allows the violation of an explicit or implicit security
	policy.

and as a CNA we must follow that definition.  No need to restate the CVE
rules in our own document, I am sure that if we don't follow them, lots
of people will be quick to point it out and we will revoke those ids
that we mess up on.

thanks,

greg k-h

