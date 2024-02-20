Return-Path: <linux-kernel+bounces-73484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9D485C341
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ADA52887DB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC4377A04;
	Tue, 20 Feb 2024 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NSV7awZJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BF177A05;
	Tue, 20 Feb 2024 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452176; cv=none; b=I5VP1YZ6U6ElCvTuQmEJjH9t4z7+kk0vhJcBasf6LDkrCQyGK8izJjEut8TekE4DRi/ZJxKgc9+b3wXcmgguOOkWZywg+NOxRYur2A9M+4Qv4X9m2IL0EWHPglTiiq3ourgBLtxZAB1rqi3ntXKpeFi+agrt1N2WlQ7UqGLP308=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452176; c=relaxed/simple;
	bh=BMyqIl/eB/+ZAKAKzt3NGsgAh4nUveaFQMaEtuLaNz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOT+aVZwYfaITH1QDRbfSFjDvmTSepIk2/Cu5jMkWKntikVIfmMxnCQSoGXXTQ2taorw1BybalPg2vAQhFaYUtUTU4Nak5bya/ZT65qJvwlySEDx/AupmpY6yTWQqxULiUYH/UeAHM9/5m0thfU7MeJxLC24l7fQcVLegBcxlvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NSV7awZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DCDC43390;
	Tue, 20 Feb 2024 18:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708452175;
	bh=BMyqIl/eB/+ZAKAKzt3NGsgAh4nUveaFQMaEtuLaNz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NSV7awZJ7kcIeGdViN3DZSHwhTuyoBLTOfW8HJlAeQXKWmr5OOZ0PlJwSRhMJRhYY
	 /QjDtrwMVDDw/FuNAb74a/xH1KWrWNTqgZshwc5IDVuAJRaBSWMmED725hf+LikSw7
	 2He2XkhToIJKJZPVTU59AySkUyC0y+af9CzSAdnI=
Date: Tue, 20 Feb 2024 19:02:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs stable updates for v6.7
Message-ID: <2024022041-vantage-ranking-2a62@gregkh>
References: <6yl6zvu2pa3mz7irsaax5ivp6kh3dae5kaslvst7yafmg6672g@mskleu2vjfp2>
 <2024021307-reactive-woven-8543@gregkh>
 <2024021300-deck-duffel-5d2b@gregkh>
 <jhwinzfpw2xjjdwsgqsrtjnzcqdbfoqev3qrm65oaxktua4c7m@mes2iwvk2yep>
 <2024021419-tumbling-rewind-dd83@gregkh>
 <2024022024-plywood-energize-f059@gregkh>
 <pkearorf3vty5zqui6souxaesd57e4oef2ds45da7sb4mfqij3@5l3r6f7uwgwe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pkearorf3vty5zqui6souxaesd57e4oef2ds45da7sb4mfqij3@5l3r6f7uwgwe>

On Tue, Feb 20, 2024 at 12:25:25PM -0500, Kent Overstreet wrote:
> On Tue, Feb 20, 2024 at 03:34:52PM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Feb 14, 2024 at 07:51:01AM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Feb 13, 2024 at 09:28:37PM -0500, Kent Overstreet wrote:
> > > > On Tue, Feb 13, 2024 at 03:44:25PM +0100, Greg Kroah-Hartman wrote:
> > > > > On Tue, Feb 13, 2024 at 03:38:10PM +0100, Greg Kroah-Hartman wrote:
> > > > > > On Thu, Feb 08, 2024 at 08:14:39PM -0500, Kent Overstreet wrote:
> > > > > > > Hi Greg, few stable updates for you -
> > > > > > > 
> > > > > > > Cheers,
> > > > > > > Kent
> > > > > > > 
> > > > > > > The following changes since commit 0dd3ee31125508cd67f7e7172247f05b7fd1753a:
> > > > > > > 
> > > > > > >   Linux 6.7 (2024-01-07 12:18:38 -0800)
> > > > > > > 
> > > > > > > are available in the Git repository at:
> > > > > > > 
> > > > > > >   https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-for-v6.7-stable-20240208
> > > > > > > 
> > > > > > > for you to fetch changes up to f1582f4774ac7c30c5460a8c7a6e5a82b9ce5a6a:
> > > > > > > 
> > > > > > >   bcachefs: time_stats: Check for last_event == 0 when updating freq stats (2024-02-08 15:33:11 -0500)
> > > > > > 
> > > > > > This didn't work well :(
> > > > > > 
> > > > > > All of the original git commit ids are gone, and for me to look them up
> > > > > > and add them back by hand is a pain.  I'll do it this time, but next
> > > > > > time can you please include them in the commit somewhere (cherry-pick -x
> > > > > > will do it automatically for you)
> > > > > > 
> > > > > > Let's see if I can figure it out...
> > > > > 
> > > > > I got all but 3 applied, can you please send an updated set of 3 patches
> > > > > for the ones I couldn't just cherry-pick from Linus's tree?
> > > > 
> > > > New pull request work?
> > > > 
> > > > The following changes since commit 0dd3ee31125508cd67f7e7172247f05b7fd1753a:
> > > > 
> > > >   Linux 6.7 (2024-01-07 12:18:38 -0800)
> > > > 
> > > > are available in the Git repository at:
> > > > 
> > > >   https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-6.7-stable-2024-02-13
> > > 
> > > Thanks, I'll look at these after this round of -rc kernels are released,
> > > which should have most of these in the release alraedy, but not all.
> > 
> > Didn't work, can you rebase on 6.7.5 please?  I tried to rebase the tree
> > here, but it gave me rejects that I didn't know how to resolve.
> 
> Because sasha cherry picked some of those fixes himself, despite an
> explicit ack that he wouldn't.

No, I rebased on a "clean" 6.7.5 that had no changes on top of it at
all.  It had nothing to do with anything in the queue right now.

> And one of the fixes had a locking bug, and he missed the fix for that.
> 
> You're going to have to revert all that if you want my pull request to
> apply.

I'll go drop those, sorry for them getting added, but again, this had
nothing to do with your pull request failing.

thanks,

greg k-h

