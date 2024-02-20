Return-Path: <linux-kernel+bounces-73184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237E785BEE0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCDAD1F21900
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B218F6BB29;
	Tue, 20 Feb 2024 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kGZONTFi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D172C1B4;
	Tue, 20 Feb 2024 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708439696; cv=none; b=Kg+xqKe9hJbxumxSe1mrNrhWZbz0zqCY23zCAtVFEyfP/RFZsgVDjWHW10kr02iZF1TY4UF7bLJV426TlofOdGdl/OBBVdEq8r4fEmTYqs+v/GG2EbJE07kOwmvrmnjRTrXYClmL6xBdKnbDf8ODHn6j93KfAEF179vOdwL0BI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708439696; c=relaxed/simple;
	bh=Zm4FiKS0GKnnFjndQk5yHkZ33NUBNrF/XBWSB77HHog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNVxeQt4bK5E8MYpXVxJTBLw+sUimO/x0uTMe48uMPEkTF0VJTRSe01eiqb7rP/kbLMkRHCI6GKocJrrQUioO9p+qo7E4q67YDHY4rNkd6az69l0goLKU3AwD6cT6MtFEF3r3GPKibLpP1JAlyHRFDuXyzGPesmSJ4VwTlUDcSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kGZONTFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066CAC433F1;
	Tue, 20 Feb 2024 14:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708439695;
	bh=Zm4FiKS0GKnnFjndQk5yHkZ33NUBNrF/XBWSB77HHog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kGZONTFi/7HxtlarTlgZH194IC6dt25awhmMUqVfQ9w4bny/o8qmKSF3lbsX+4+7C
	 Q7AB6IsvFBSfAORwXfbVqylkRWnOhqZwIH+092OVJa3TCCsXi3es1fozqZPj2TDFSr
	 xcAg8M9guUjZ74JknNn/umfdJ+YQMkEhgjSw7DKs=
Date: Tue, 20 Feb 2024 15:34:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs stable updates for v6.7
Message-ID: <2024022024-plywood-energize-f059@gregkh>
References: <6yl6zvu2pa3mz7irsaax5ivp6kh3dae5kaslvst7yafmg6672g@mskleu2vjfp2>
 <2024021307-reactive-woven-8543@gregkh>
 <2024021300-deck-duffel-5d2b@gregkh>
 <jhwinzfpw2xjjdwsgqsrtjnzcqdbfoqev3qrm65oaxktua4c7m@mes2iwvk2yep>
 <2024021419-tumbling-rewind-dd83@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021419-tumbling-rewind-dd83@gregkh>

On Wed, Feb 14, 2024 at 07:51:01AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 13, 2024 at 09:28:37PM -0500, Kent Overstreet wrote:
> > On Tue, Feb 13, 2024 at 03:44:25PM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Feb 13, 2024 at 03:38:10PM +0100, Greg Kroah-Hartman wrote:
> > > > On Thu, Feb 08, 2024 at 08:14:39PM -0500, Kent Overstreet wrote:
> > > > > Hi Greg, few stable updates for you -
> > > > > 
> > > > > Cheers,
> > > > > Kent
> > > > > 
> > > > > The following changes since commit 0dd3ee31125508cd67f7e7172247f05b7fd1753a:
> > > > > 
> > > > >   Linux 6.7 (2024-01-07 12:18:38 -0800)
> > > > > 
> > > > > are available in the Git repository at:
> > > > > 
> > > > >   https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-for-v6.7-stable-20240208
> > > > > 
> > > > > for you to fetch changes up to f1582f4774ac7c30c5460a8c7a6e5a82b9ce5a6a:
> > > > > 
> > > > >   bcachefs: time_stats: Check for last_event == 0 when updating freq stats (2024-02-08 15:33:11 -0500)
> > > > 
> > > > This didn't work well :(
> > > > 
> > > > All of the original git commit ids are gone, and for me to look them up
> > > > and add them back by hand is a pain.  I'll do it this time, but next
> > > > time can you please include them in the commit somewhere (cherry-pick -x
> > > > will do it automatically for you)
> > > > 
> > > > Let's see if I can figure it out...
> > > 
> > > I got all but 3 applied, can you please send an updated set of 3 patches
> > > for the ones I couldn't just cherry-pick from Linus's tree?
> > 
> > New pull request work?
> > 
> > The following changes since commit 0dd3ee31125508cd67f7e7172247f05b7fd1753a:
> > 
> >   Linux 6.7 (2024-01-07 12:18:38 -0800)
> > 
> > are available in the Git repository at:
> > 
> >   https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-6.7-stable-2024-02-13
> 
> Thanks, I'll look at these after this round of -rc kernels are released,
> which should have most of these in the release alraedy, but not all.

Didn't work, can you rebase on 6.7.5 please?  I tried to rebase the tree
here, but it gave me rejects that I didn't know how to resolve.

thanks,

greg k-h

