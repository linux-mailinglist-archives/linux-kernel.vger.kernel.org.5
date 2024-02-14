Return-Path: <linux-kernel+bounces-64809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3CB854314
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2109D2881F0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B90111B0;
	Wed, 14 Feb 2024 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="It9aJZ4O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99AA10A2C;
	Wed, 14 Feb 2024 06:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707893465; cv=none; b=X2GV2bFiRutan8FGrip7FaHprvp01ovMy1L1USHug5JEw5XzP4PJ72513z4iAK/xa2knUn5cIZqRw6n0bVv7BNXb5VbDfCSrpUnxz8h0d262p+g6xeR3bvX51xLm/aj7d0I4dAnImxGApdjklgj0ua++bZxmQEHXcdk6V/FBcnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707893465; c=relaxed/simple;
	bh=aQ6hoQhEEktF2OuJ2Hoy8uVio86hfNxqjG4grkuZUmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UM0OEcp8ZYFdTsi69+ucZhGOeTP2ugFpa/qd+whV0lJEL4Czi61/0UqUtW0UPR6fC4VmadDuD3yJ10CEnUnTZZ3yFdqH2B9m2HfE7GKH/nXHqBXV7vMZDpH8vazL9VBS59pd18N12v7dp2LU2DMtqX8+vNSEAwNXXDnSoPQwr9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=It9aJZ4O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB39CC433C7;
	Wed, 14 Feb 2024 06:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707893464;
	bh=aQ6hoQhEEktF2OuJ2Hoy8uVio86hfNxqjG4grkuZUmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=It9aJZ4OqNistmpUNs7I0MWAeI45pneN/pklFDF+U543FgxU8x1SkjbUzVI/RpH5t
	 10dtsdv0t6sEhYlLtn7A5ZMNiY+RPA9/mnawbo0NRxU4aeMQmSy5cqHNiQe38ScYBU
	 CDxt0EwdAHEoEjaON9uj2QC5w/FqTnncI8ww6Ei8=
Date: Wed, 14 Feb 2024 07:51:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs stable updates for v6.7
Message-ID: <2024021419-tumbling-rewind-dd83@gregkh>
References: <6yl6zvu2pa3mz7irsaax5ivp6kh3dae5kaslvst7yafmg6672g@mskleu2vjfp2>
 <2024021307-reactive-woven-8543@gregkh>
 <2024021300-deck-duffel-5d2b@gregkh>
 <jhwinzfpw2xjjdwsgqsrtjnzcqdbfoqev3qrm65oaxktua4c7m@mes2iwvk2yep>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhwinzfpw2xjjdwsgqsrtjnzcqdbfoqev3qrm65oaxktua4c7m@mes2iwvk2yep>

On Tue, Feb 13, 2024 at 09:28:37PM -0500, Kent Overstreet wrote:
> On Tue, Feb 13, 2024 at 03:44:25PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Feb 13, 2024 at 03:38:10PM +0100, Greg Kroah-Hartman wrote:
> > > On Thu, Feb 08, 2024 at 08:14:39PM -0500, Kent Overstreet wrote:
> > > > Hi Greg, few stable updates for you -
> > > > 
> > > > Cheers,
> > > > Kent
> > > > 
> > > > The following changes since commit 0dd3ee31125508cd67f7e7172247f05b7fd1753a:
> > > > 
> > > >   Linux 6.7 (2024-01-07 12:18:38 -0800)
> > > > 
> > > > are available in the Git repository at:
> > > > 
> > > >   https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-for-v6.7-stable-20240208
> > > > 
> > > > for you to fetch changes up to f1582f4774ac7c30c5460a8c7a6e5a82b9ce5a6a:
> > > > 
> > > >   bcachefs: time_stats: Check for last_event == 0 when updating freq stats (2024-02-08 15:33:11 -0500)
> > > 
> > > This didn't work well :(
> > > 
> > > All of the original git commit ids are gone, and for me to look them up
> > > and add them back by hand is a pain.  I'll do it this time, but next
> > > time can you please include them in the commit somewhere (cherry-pick -x
> > > will do it automatically for you)
> > > 
> > > Let's see if I can figure it out...
> > 
> > I got all but 3 applied, can you please send an updated set of 3 patches
> > for the ones I couldn't just cherry-pick from Linus's tree?
> 
> New pull request work?
> 
> The following changes since commit 0dd3ee31125508cd67f7e7172247f05b7fd1753a:
> 
>   Linux 6.7 (2024-01-07 12:18:38 -0800)
> 
> are available in the Git repository at:
> 
>   https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-6.7-stable-2024-02-13

Thanks, I'll look at these after this round of -rc kernels are released,
which should have most of these in the release alraedy, but not all.

greg k-h

