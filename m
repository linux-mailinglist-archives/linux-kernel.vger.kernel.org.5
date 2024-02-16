Return-Path: <linux-kernel+bounces-68181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C179B8576E6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61A7AB21604
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5EF1758E;
	Fri, 16 Feb 2024 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0ilIx92O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D65917551;
	Fri, 16 Feb 2024 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708069295; cv=none; b=R3PC6oFl4F92XAgwH+nL2m9nTDrOdJBznXgPJ3crZGQg6MRbkVdUfIU78Jf2K3o+KgjGYjGoemmSG8fjGVI1dDaw6NZy5BkiulU8UpVgiQ4u+9ox6iP8IZfo2DXFw7yOtiSLB2K8ZoxpAVJjGmfBKSL+CcCN+v1nfiqb+xNPAwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708069295; c=relaxed/simple;
	bh=kBgEifnOBd5WS8QqGZDsoOCrv5jBLpPxzLkbMJcn2T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQVSV2ME8dL1iJGlBWNucC7gYBZBs3fptmOa0iruOUQHXl3lE2DZgjCQMayA90ua9yD1N6V0wjTSKmN1GPz+uXUUsRs9H8jXXmYY8j+LGbdwfrP0DTebuYBsjXfs1Z+ceAqpocZJ/cWcaVU1dy6XkmN3YlevOBrD4ongYG+cnBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0ilIx92O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1C2C433C7;
	Fri, 16 Feb 2024 07:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708069294;
	bh=kBgEifnOBd5WS8QqGZDsoOCrv5jBLpPxzLkbMJcn2T4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0ilIx92Ol4iY6E3blji6S4zhbB75LwliRAulBz0pZaRPnHwgylxHu2cSMbmV9L8vZ
	 qZXg8T2aimYdHdXeluh4wCl2k9gb/X42vQz2OzWTzb77OuubhOa+6/qhAhEbEtD7VQ
	 79JqOK5qaDVCOVNm/dzNoDqtjiUOsHRYIsICdtM8=
Date: Fri, 16 Feb 2024 08:41:31 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: Michal Hocko <mhocko@suse.com>, corbet@lwn.net,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Sasha Levin <sashal@kernel.org>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Message-ID: <2024021602-unaudited-consoling-be37@gregkh>
References: <2024021430-blanching-spotter-c7c8@gregkh>
 <Zc5PycMenLBYECAn@tiehlicka>
 <2024021518-stature-frightful-e7fc@gregkh>
 <202402151134.4ED3C9070@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402151134.4ED3C9070@keescook>

On Thu, Feb 15, 2024 at 11:40:43AM -0800, Kees Cook wrote:
> On Thu, Feb 15, 2024 at 07:20:09PM +0100, Greg Kroah-Hartman wrote:
> > Here's an example of what the CVE announcement is going to look like for
> > a "test" that we have been doing for our scripts
> > 	https://lore.kernel.org/linux-cve-announce/2024021353-drainage-unstuffed-a7c0@gregkh/T/#u
> > ...
> > the latest release is impossible, the individual change to resolve this
> > issue can be found at:
> > 	https://git.kernel.org/stable/linux/c/f08adf5add9a071160c68bb2a61d697f39ab0758
> 
> This is the "original fix", a v5.16 commit, which was backported to all
> the stables. For this case, that seems fine (it's pretty easy to grep
> the stable trees for the SHA).
> 
> In the case of a fix only being in -stable, what will be listed for
> SHAs here? Each stable SHA? Something else?

I think listing all of the SHA values, stable and mainline, would be
best, right?  No need for everyone to try to grep the trees, and bonus,
the json format has a specific field just for this as well.  That's on
my todo list for today...

thanks,

greg k-h

