Return-Path: <linux-kernel+bounces-64612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0898540DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8959C1C27BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFCD2C9E;
	Wed, 14 Feb 2024 00:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUaWOQv8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014B17F;
	Wed, 14 Feb 2024 00:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707871196; cv=none; b=PkzRHk10rXtSz4XcgxgrDo3R1FrJL3tIrFEOm1zi26Vdaau9pYN4wb03F6z11b8vIDS9Lb+/mznyfkxit7MUczvP0P77I4CaRFurraTyjPSKZE5O28hadsBDrnULNFnXQkeq0h2Z2+rHAZBQLDJb4pijjEgpGjwsBjERF9fNnVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707871196; c=relaxed/simple;
	bh=n4grStWhx6sIbsdweml8Y5OC8BbyRVAwdUoHEkD7lhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNY2IQ9QgAsdvE/POCRz53uzBDviv947Yk1ipugm/+0tfJWAUPsyHjXFPq8QFdUa8QtjEgRdG1SZxytYDI/7p2AKvcZjVSSQ+vTNHG23w86GGxlbIeDRhTRcVZ2KuD9CNvDeJZUkhNkUja8CJ7oMQjA/o5DKl769SQKKI09c3WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUaWOQv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D36AC433F1;
	Wed, 14 Feb 2024 00:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707871195;
	bh=n4grStWhx6sIbsdweml8Y5OC8BbyRVAwdUoHEkD7lhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gUaWOQv8jvInARK0fm3hg9ya23bQ+v7ZV4at4vDDNBlfvhqnspM9VEZXRxBnxerZx
	 62u63i0DjB+bNGxwJc4e6NBptR4thuDB3+YteSXtVnVNwc+l9zPq/hYPiKeGp0mXXh
	 nOpmD9pe8JWT2YkBixNVhdVj7Gy3d40wQOLsucNFtR4UuJZeJdrwL3j5uUmYQW0blI
	 Cv7nTRoXJ+XZ8Sp0isy+bcmWGY+o4LtZ5eFZqYizE6L3Z6e+bGU7grGDXkEKH1wrnV
	 pTyNLBsO2tqQrqVpfrfb0fMjeaslobExO3ToOZWUiMq2p19Y0jYkQMj8gbPKxut1Xy
	 05mxYy9lFAGNA==
Date: Tue, 13 Feb 2024 16:39:54 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Kees Cook <keescook@chromium.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bcachefs tree
Message-ID: <20240214003954.GD6226@frogsfrogsfrogs>
References: <20240212105456.65194f29@canb.auug.org.au>
 <202402131606.A70D5347F3@keescook>
 <u6z6hyxhpjecbaw5zhevsd4hco253ec2pobijidj5bsd5ojbrw@mbu2r4o67nad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u6z6hyxhpjecbaw5zhevsd4hco253ec2pobijidj5bsd5ojbrw@mbu2r4o67nad>

On Tue, Feb 13, 2024 at 07:29:32PM -0500, Kent Overstreet wrote:
> On Tue, Feb 13, 2024 at 04:16:34PM -0800, Kees Cook wrote:
> > On Mon, Feb 12, 2024 at 10:54:56AM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > After merging the bcachefs tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > > 
> > > ERROR: modpost: missing MODULE_LICENSE() in lib/thread_with_file.o
> > > ERROR: modpost: "stdio_redirect_vprintf" [fs/bcachefs/bcachefs.ko] undefined!
> > > ERROR: modpost: "thread_with_file_exit" [fs/bcachefs/bcachefs.ko] undefined!
> > > ERROR: modpost: "run_thread_with_stdio" [fs/bcachefs/bcachefs.ko] undefined!
> > > ERROR: modpost: "__darray_resize_slowpath" [fs/bcachefs/bcachefs.ko] undefined!
> > > ERROR: modpost: "stdio_redirect_readline" [fs/bcachefs/bcachefs.ko] undefined!
> > > ERROR: modpost: "run_thread_with_file" [fs/bcachefs/bcachefs.ko] undefined!
> > > ERROR: modpost: "__darray_resize_slowpath" [lib/thread_with_file.ko] undefined!
> > > 
> > > Caused by commit
> > > 
> > >   f894f9e5f0ad ("thread_with_file: Lift from bcachefs")
> > > 
> > > I have used the version of bcachefs from next-20240206 again.
> > 
> > I've mentioned this before, but this patch (and I assume others) was not
> > posted to any mailing list before it appeared in -next. This process
> > failure really needs to be fixed. Please post _everything_ going into
> > your tree to at least linux-bcachefs mailing list, and for things that
> > toss stuff into lib/ it really needs to go to lkml too and CCed to some
> > subset of people who have touched lib/Kconfig, etc last.
> 
> thread_wih_file definitely was; the patch moving it to lib/ might not
> have, I'd have to check.
> 
> We're having ongoing discussions among us fs developers about how to do
> patch review, and the emerging consensus seems to be that we actually
> don't want to spam the list with every patch (because not every patch is
> interesting!) - we don't want the human-to-human interaction to be
> drowned out on the list.
> 
> That doesn't mean we're not doing code review, though! We're
> experimenting with different workflows, there's different thoughts out
> there right now.
> 
> Regarding CCing people who have touched lib/Kconfig - you sure that's
> the best way to get interested parties who'll do real review? I would
> think review from the people actively working with and using that code
> would be more valuable - that's Darrick, in this instance.

Heh, I hadn't realized that the twf lift had already gone to -next.

I just sent a bunch more fixes:
https://lore.kernel.org/linux-bcachefs/170785143225.984170.828418190611017982.stg-ugh@frogsfrogsfrogs/T/#u

Though I guess in the haze of ~700 patches I forgot that I'd added the
module annotations to one of Kent's patches:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=twf-cleanups&id=d980d2d451debda0e52868382fee32273e2946ae

--D

