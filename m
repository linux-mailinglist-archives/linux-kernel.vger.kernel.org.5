Return-Path: <linux-kernel+bounces-156898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6BC8B0A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F31B1C220D0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43E815B0ED;
	Wed, 24 Apr 2024 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFZAxALT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D56B15957A;
	Wed, 24 Apr 2024 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963093; cv=none; b=sQo9XT7eGDLoUbRmYKyNYVOQThsaDiB28Ml/JqrWC/eT3uro7zTrWO8HhbZloUx1Yev1jDDqZYl9FxjFiLoKO0enCZD9G1hwDVwFDYfs9rwL2gr3xdmTDAqMj5gqqteY4VyQhJOuHwFdJD+ru04VVZZ0wttx+GZUyx8RDcjUF/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963093; c=relaxed/simple;
	bh=z47SpzM46Bqm5lQ8MXfVZDdF7fCIq46acP7kKmBwNYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkiRlxGA/5nEYQhwBeoIG40mpx0iJwXUke/NPW34yxHpZn0cO2rmyBSrBR9pX6SuKQZrWT9LwcPdOQE93QvMA97/2YTFQq6GCXXFgYqBi643qV7W+cg+V8cENb2XuoKqy+Gey2gfJH5k1zk95nTVXQlQ1U4Z6kNjdeYo+GXPAl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFZAxALT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84B9C32782;
	Wed, 24 Apr 2024 12:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713963092;
	bh=z47SpzM46Bqm5lQ8MXfVZDdF7fCIq46acP7kKmBwNYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gFZAxALTrRDbCzI4MplqUdtffaSeEwoI9IKRfvf3QuaHjqK2u0Ig02XALeP0b1a0e
	 el0u0sgBadmD37GWA+Db2Ps6xicK0pB4BsSWvR7OcRjgAAP7VocBu16DHUcQ9lTd25
	 wyKBH/7HCSBSdTT5HL1hKLFqW/VAnJQwpmHEwiHzVmdsFII/bk2ycRuwNJckr42YfB
	 PnqLe0Sfw6t2F5SF3rCssTSkL81JJTLyXVPWTS0VmMSIVZwvt411vg7eewqKZ/gVNw
	 j19KbXajHQBW1CIoRNF9RVrEEvYVobGlqojbQ47JWF0scMvohEnsyMtucnnoXsesJw
	 Ku5Te6BaY3AMQ==
Date: Wed, 24 Apr 2024 14:51:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Baokun Li <libaokun@huaweicloud.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Gao Xiang <xiang@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the
 erofs-fixes tree
Message-ID: <20240424-enklave-umgezogen-93524415ee92@brauner>
References: <20240424102445.53ba5ba2@canb.auug.org.au>
 <b7332fb7-4c49-3af2-7095-e728a6af8ff7@huaweicloud.com>
 <0dbf63ba-026c-41a7-93fa-55a7a216e627@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0dbf63ba-026c-41a7-93fa-55a7a216e627@linux.alibaba.com>

On Wed, Apr 24, 2024 at 10:13:43AM +0800, Gao Xiang wrote:
> Hi Stephen,
> 
> On 2024/4/24 09:26, Baokun Li wrote:
> > Hi Stephen,
> > 
> > On 2024/4/24 8:24, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Today's linux-next merge of the vfs-brauner tree got a conflict in:
> > > 
> > >    fs/erofs/super.c
> > > 
> > > between commits:
> > > 
> > >    ab1bbc1735ff ("erofs: get rid of erofs_fs_context")
> > >    569a48fed355 ("erofs: reliably distinguish block based and fscache mode")
> > > 
> > > from the erofs-fixes tree and commit:
> > > 
> > >    e4f586a41748 ("erofs: reliably distinguish block based and fscache mode")
> > > 
> > > from the vfs-brauner tree.
> > > 
> > > I fixed it up (I think - I used the former version) and can carry the
> > > fix as necessary. This is now fixed as far as linux-next is concerned,
> > > but any non trivial conflicts should be mentioned to your upstream
> > > maintainer when your tree is submitted for merging.  You may also want
> > > to consider cooperating with the maintainer of the conflicting tree to
> > > minimise any particularly complex conflicts.
> > > 
> > Christian previously mentioned that the fix from the vfs-brauner tree
> > was an accident:
> > 
> > "An an accident on my part as I left it in the vfs.fixes branch."
> > 
> > So the two commits from the erofs-fixes tree are the final fixes.
> > 
> > I'm very sorry for any inconvenience caused.
> 
> Yeah, Christian was picked this fix by accident as mentioned in,
> https://lore.kernel.org/r/20240419-tundra-komodowaran-5c3758d496e4@brauner
> 
> I guest that was due to his local work at that time since the
> original idea to fix this issue was from him (thanks again!).

Yeah, sorry about that. I dropped it a few days ago but was on the road
for a bit. I'll push a new version by eod.

