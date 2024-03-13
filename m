Return-Path: <linux-kernel+bounces-100974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B5487A04D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC7B1F22668
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7617EBA2B;
	Wed, 13 Mar 2024 00:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RL/doPrK"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD44B654
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 00:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710291272; cv=none; b=MQ/BYb/YRs3Hvh3u5IIdwybcH4HVcRbutNPBiXgN8buDAuiMQFPXLQx/hNIfbAVNlrG64wosts5vl1/SdWO9URDSeCMy2THnSGZlf+4bVLyUhXtF2vtINYaLNHV94dW2ThTyJ5C16vtfp8CXyXTLw83OH2qfk4vsjvzWCOEJ7Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710291272; c=relaxed/simple;
	bh=3OXtApxekaIscO2m++ymiSGv67gkB+Zwjo+gBgcegT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF0zm2UfrcJvVDVZyCDKUeE0t5h7mUB3jFBpTpPv6kbWJZ2Bd5T3kLMe9O0P+hOOTt1uMZipCAuReuFdDxBY4MFYITA3S7G45MZX+7j1L9+04aP/ClMornMtHog8cj8tYPN3e0Ozcl1XURBjCntViHOdG3pJjnWgwGORWpeR4Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RL/doPrK; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 12 Mar 2024 20:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710291268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W2B6neHTWJ/PWEeWF+1cmU1FwUVfgcJjA26sfqvTOWM=;
	b=RL/doPrKbR+5zXYVyoT0KUCmYZYv8+189cZHauWaEWx1Jxi5bLgr0bBVY9crrTlzXi3nho
	29FY5FRwb7L90k2ewEuv6ZFTi7E6lYkaAtKI5e9RBhTEyiP0CF0PQ+PpgfUzircULAHhcc
	J6Fqv4vu5tGYnLHtlNhHmQnDMqPZZF0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.7.y
Message-ID: <zneppz2ohlalk2qeitdkzxvtexuqgfbhx6sxocgiasuuwsbopl@cr4d3wve2sot>
References: <2zaqetj6wlxgpbxgex643dnudgwhcrz23xgfuai3t3hgavjb2d@vwhyha3hlg5y>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2zaqetj6wlxgpbxgex643dnudgwhcrz23xgfuai3t3hgavjb2d@vwhyha3hlg5y>
X-Migadu-Flow: FLOW_OUT

On Sun, Mar 10, 2024 at 03:43:38PM -0400, Kent Overstreet wrote:
> The following changes since commit 2e7cdd29fc42c410eab52fffe5710bf656619222:
> 
>   Linux 6.7.9 (2024-03-06 14:54:01 +0000)
> 
> are available in the Git repository at:
> 
>   https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-for-v6.7-stable-20240310
> 
> for you to fetch changes up to 560ceb6a4d9e3bea57c29f5f3a7a1d671dfc7983:
> 
>   bcachefs: Fix BTREE_ITER_FILTER_SNAPSHOTS on inodes btree (2024-03-10 14:36:57 -0400)
> 
> ----------------------------------------------------------------
> bcachefs fixes for 6.7 stable
> 
> "bcachefs: fix simulateously upgrading & downgrading" is the important
> one here. This fixes a really nasty bug where in a rare situation we
> wouldn't downgrade; we'd write a superblock where the version number is
> higher than the currently supported version.
> 
> This caused total failure to mount multi device filesystems with the
> splitbrain checking in 6.8, since now we wouldn't be updating the member
> sequence numbers used for splitbrain checking, but the version number
> said we would be - and newer versions would attempt to kick every device
> out of the fs.
> 
> ----------------------------------------------------------------
> Helge Deller (1):
>       bcachefs: Fix build on parisc by avoiding __multi3()
> 
> Kent Overstreet (3):
>       bcachefs: check for failure to downgrade
>       bcachefs: fix simulateously upgrading & downgrading
>       bcachefs: Fix BTREE_ITER_FILTER_SNAPSHOTS on inodes btree
> 
> Mathias Krause (1):
>       bcachefs: install fd later to avoid race with close
> 
>  fs/bcachefs/btree_iter.c        |  4 +++-
>  fs/bcachefs/chardev.c           |  3 +--
>  fs/bcachefs/errcode.h           |  1 +
>  fs/bcachefs/mean_and_variance.h |  2 +-
>  fs/bcachefs/super-io.c          | 27 ++++++++++++++++++++++++---
>  5 files changed, 30 insertions(+), 7 deletions(-)

Why wasn't this applied?

