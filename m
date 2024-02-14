Return-Path: <linux-kernel+bounces-64692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C882985418D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072AE1C288D0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29EF8F56;
	Wed, 14 Feb 2024 02:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k+y8Hwll"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86EC53BE
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 02:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707877754; cv=none; b=VhlovRR+ApPooAiQB+a65zWnsmW3VVZ5abNKd0V7TChtUFgJK1XwbuTx/sqzE7+/8da1mXT/OI9YsG2RpS/tNNloKBURdDwLVnPf1i7vMtTV2EzLe7p7zN6EhCrZTAUZiL0Y1t6euzD8t8VwpiYoC8pmw0Z+gZ1VpR95Amt5qIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707877754; c=relaxed/simple;
	bh=qnMXIzAsvwbg9RdPvS3yVDUsbE7YmK9K5gnzIv7DBfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/f/8lgRbaJEIb/G/GtUDA4W5NQgymJUtXaBOJ5jOWthHpymCfmsAVWvtKgdvCa1QIlPw9a/mI2bQDJpUWNczQ9XjV1V6Xx7aqgxiyEY0+289E7LQTK3aDfofW+fbm5n5tmNjI5LaghmKe3GYGQdEKUJlEWIYIFvosp2OmckuYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k+y8Hwll; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 13 Feb 2024 21:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707877750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh748CJKLC8xvLfwlnns4OR7wyB9t3Vax7RM1Ml7NJM=;
	b=k+y8HwllTEJkXP1GNY0NZLbw388OpCwxLx7tXyNC7iE5VZmjzj1ISGEwkoehdqMz3OoPA9
	jTAgAeuEymJPjQZ6ebnnRCkk6FEdfJo2YQ+LN7P8QuEdQ2n+E5y+zKV1vFWzlq42RMO5As
	tjTHAIcg3kJ657Lhyb9cZ8V5BCW63eE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs stable updates for v6.7
Message-ID: <jhwinzfpw2xjjdwsgqsrtjnzcqdbfoqev3qrm65oaxktua4c7m@mes2iwvk2yep>
References: <6yl6zvu2pa3mz7irsaax5ivp6kh3dae5kaslvst7yafmg6672g@mskleu2vjfp2>
 <2024021307-reactive-woven-8543@gregkh>
 <2024021300-deck-duffel-5d2b@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021300-deck-duffel-5d2b@gregkh>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 13, 2024 at 03:44:25PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 13, 2024 at 03:38:10PM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Feb 08, 2024 at 08:14:39PM -0500, Kent Overstreet wrote:
> > > Hi Greg, few stable updates for you -
> > > 
> > > Cheers,
> > > Kent
> > > 
> > > The following changes since commit 0dd3ee31125508cd67f7e7172247f05b7fd1753a:
> > > 
> > >   Linux 6.7 (2024-01-07 12:18:38 -0800)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-for-v6.7-stable-20240208
> > > 
> > > for you to fetch changes up to f1582f4774ac7c30c5460a8c7a6e5a82b9ce5a6a:
> > > 
> > >   bcachefs: time_stats: Check for last_event == 0 when updating freq stats (2024-02-08 15:33:11 -0500)
> > 
> > This didn't work well :(
> > 
> > All of the original git commit ids are gone, and for me to look them up
> > and add them back by hand is a pain.  I'll do it this time, but next
> > time can you please include them in the commit somewhere (cherry-pick -x
> > will do it automatically for you)
> > 
> > Let's see if I can figure it out...
> 
> I got all but 3 applied, can you please send an updated set of 3 patches
> for the ones I couldn't just cherry-pick from Linus's tree?

New pull request work?

The following changes since commit 0dd3ee31125508cd67f7e7172247f05b7fd1753a:

  Linux 6.7 (2024-01-07 12:18:38 -0800)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-6.7-stable-2024-02-13

for you to fetch changes up to b291ceeb4faa9ee34d1704116fe393d66ff1f221:

  bcachefs: time_stats: Check for last_event == 0 when updating freq stats (2024-02-13 21:22:41 -0500)

----------------------------------------------------------------
bcachefs fixes for 6.7 stable

----------------------------------------------------------------
Al Viro (2):
      new helper: user_path_locked_at()
      bch2_ioctl_subvolume_destroy(): fix locking

Christoph Hellwig (1):
      bcachefs: fix incorrect usage of REQ_OP_FLUSH

Daniel Hill (1):
      bcachefs: rebalance should wakeup on shutdown if disabled

Guoyu Ou (1):
      bcachefs: unlock parent dir if entry is not found in subvolume deletion

Helge Deller (1):
      bcachefs: Fix build on parisc by avoiding __multi3()

Kent Overstreet (4):
      bcachefs: Don't pass memcmp() as a pointer
      bcachefs: Add missing bch2_moving_ctxt_flush_all()
      bcachefs: bch2_kthread_io_clock_wait() no longer sleeps until full amount
      bcachefs: time_stats: Check for last_event == 0 when updating freq stats

Mathias Krause (1):
      bcachefs: install fd later to avoid race with close

Su Yue (2):
      bcachefs: kvfree bch_fs::snapshots in bch2_fs_snapshots_exit
      bcachefs: grab s_umount only if snapshotting

 fs/bcachefs/chardev.c           |  3 +--
 fs/bcachefs/clock.c             |  4 ++--
 fs/bcachefs/fs-io.c             |  2 +-
 fs/bcachefs/fs-ioctl.c          | 42 +++++++++++++++++++++--------------------
 fs/bcachefs/journal_io.c        |  3 ++-
 fs/bcachefs/mean_and_variance.h |  2 +-
 fs/bcachefs/move.c              |  2 +-
 fs/bcachefs/move.h              |  1 +
 fs/bcachefs/rebalance.c         | 13 +++++++++++--
 fs/bcachefs/replicas.c          | 10 ++++++++--
 fs/bcachefs/snapshot.c          |  2 +-
 fs/bcachefs/util.c              |  5 +++--
 fs/namei.c                      | 16 +++++++++++++---
 include/linux/namei.h           |  1 +
 14 files changed, 68 insertions(+), 38 deletions(-)

