Return-Path: <linux-kernel+bounces-102386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F395787B179
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDEA1F26630
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603E765BB0;
	Wed, 13 Mar 2024 18:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bas1vNSp"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FD04F88A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355984; cv=none; b=nD7spFMdR1ph7pwWr9LyIub2MlHQ/j27xesfpfnN1NXUAZCrkyss6L26bv2+6QaNSN9kgbhKQ9JXHlNVq3c/RXTxmk9S7FXo5HG+ckjQJfgTngP9cxx8ZSYZntg/Mxs/raUHSBz4+yZ/CZnww/GW15SVVzSm2/ik7PFCjhGJq/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355984; c=relaxed/simple;
	bh=YVcQq+dmsP/qAi9rtaqS5+Tz53AiNYC2GGqYJEr+tZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaEFVN5rclROEZ/CTgCRQItyG3CfsNWdq9YsvYc2JqIdO3yDmB+rUCq/AuEI8lYOx5CVCTFEPZI947/JuBRmIkpEpqM2pZ914UJJRNT977iJtNQ+4o5lbr0fySV/1pGd1ObZPL0Q7RqQlSvP3ixiG/dI00+xA0cC6SVRyMtAwSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bas1vNSp; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 13 Mar 2024 14:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710355980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GXEAy3+toOLXEJR1J0N7Y1UVgbk2sOpxJGCRr43PliU=;
	b=bas1vNSp4Dz15sjAd2Ox31F6Q6ohP/hMPu8I8x8i7ykp8w3hvyVMAVewpjnHpW6gXe6hps
	4JCUFLi3ps16cs+jJFFJZp3lUYffsq20Mlv17kZJGot0kNQFeq/AqqZOpL1/QmYKzX07BV
	hNWXMqaA09b1DtCqhqecV1zuMsxD7c0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.7.y
Message-ID: <qffolwx7uqvvmvjy6ga37fp2xcefqhtqmavgy2olkoi7kzgpdc@w2awisbf6unk>
References: <2zaqetj6wlxgpbxgex643dnudgwhcrz23xgfuai3t3hgavjb2d@vwhyha3hlg5y>
 <zneppz2ohlalk2qeitdkzxvtexuqgfbhx6sxocgiasuuwsbopl@cr4d3wve2sot>
 <2024031352-valuables-handling-cec3@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024031352-valuables-handling-cec3@gregkh>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 13, 2024 at 07:20:44PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 12, 2024 at 08:54:24PM -0400, Kent Overstreet wrote:
> > On Sun, Mar 10, 2024 at 03:43:38PM -0400, Kent Overstreet wrote:
> > > The following changes since commit 2e7cdd29fc42c410eab52fffe5710bf656619222:
> > > 
> > >   Linux 6.7.9 (2024-03-06 14:54:01 +0000)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-for-v6.7-stable-20240310
> > > 
> > > for you to fetch changes up to 560ceb6a4d9e3bea57c29f5f3a7a1d671dfc7983:
> > > 
> > >   bcachefs: Fix BTREE_ITER_FILTER_SNAPSHOTS on inodes btree (2024-03-10 14:36:57 -0400)
> > > 
> > > ----------------------------------------------------------------
> > > bcachefs fixes for 6.7 stable
> > > 
> > > "bcachefs: fix simulateously upgrading & downgrading" is the important
> > > one here. This fixes a really nasty bug where in a rare situation we
> > > wouldn't downgrade; we'd write a superblock where the version number is
> > > higher than the currently supported version.
> > > 
> > > This caused total failure to mount multi device filesystems with the
> > > splitbrain checking in 6.8, since now we wouldn't be updating the member
> > > sequence numbers used for splitbrain checking, but the version number
> > > said we would be - and newer versions would attempt to kick every device
> > > out of the fs.
> > > 
> > > ----------------------------------------------------------------
> > > Helge Deller (1):
> > >       bcachefs: Fix build on parisc by avoiding __multi3()
> > > 
> > > Kent Overstreet (3):
> > >       bcachefs: check for failure to downgrade
> > >       bcachefs: fix simulateously upgrading & downgrading
> > >       bcachefs: Fix BTREE_ITER_FILTER_SNAPSHOTS on inodes btree
> > > 
> > > Mathias Krause (1):
> > >       bcachefs: install fd later to avoid race with close
> > > 
> > >  fs/bcachefs/btree_iter.c        |  4 +++-
> > >  fs/bcachefs/chardev.c           |  3 +--
> > >  fs/bcachefs/errcode.h           |  1 +
> > >  fs/bcachefs/mean_and_variance.h |  2 +-
> > >  fs/bcachefs/super-io.c          | 27 ++++++++++++++++++++++++---
> > >  5 files changed, 30 insertions(+), 7 deletions(-)
> > 
> > Why wasn't this applied?
> 
> Because our queue is huge and 1/2 of the stable team is finally taking
> his first vacation in years (and regretting reading email during it
> right now)?  Relax, it will get there, backport requests like this not
> being handled in 48 hours seems like a big ask, don't you think?

Ok - sorry for bothering you then :)

