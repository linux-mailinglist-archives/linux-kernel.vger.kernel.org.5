Return-Path: <linux-kernel+bounces-54243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C1884ACC1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A321C22BBE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE3F73195;
	Tue,  6 Feb 2024 03:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUt6WHfJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4DB3FC7
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 03:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707189353; cv=none; b=c4nvXvUBnQxcn5yBYf84iUmWwSbmZ55pOd7+UtLvc6dhjdX/AWk638AOWeBwE5+G24CtLTvILYUoIYhGJcY37w+WxUIRus0NhEWGtQ6Rwkhb/mQrfnd6IbPSM4NJobTViJcVciV3J33PVr14bcUnAJB+KqKVMzdTLNuQ1mqb740=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707189353; c=relaxed/simple;
	bh=ZyYwGOE43v5bqv5SSEQtS2xBP8aZCZp/iRGVX0g5PWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvVwrsh+/i6A5ysnfFqGAQOVFYFGhtAhF+xr4ahvQt04zcZlY7mqDhQzjTJTrcVDtsj2lWvxO4LJp9eCEoVGZMWr/EO7wM8bRt6KoDYnr51ekVwVwQgl6YcJhEdDAe6M6Qan/I+8Sh4jJiP8S/xpFoJLADw5QBXbjJ2EzbSIqCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUt6WHfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C69C433F1;
	Tue,  6 Feb 2024 03:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707189352;
	bh=ZyYwGOE43v5bqv5SSEQtS2xBP8aZCZp/iRGVX0g5PWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lUt6WHfJxWiOVqLa2xhNkZifpLXNDCndlkbeZaQlBBSOkDPEkbxy1PHuyJfCoNhFv
	 MqYlAOy35Jk+KI/lZCicpehE4CqxsO5B8vO7h9I9kbQVu4XxSIFsWNhPBD0AvV96bK
	 lDxv4gAAEaok0JiyEf9/WqN/A3yBE8MV4d9CbbyN/muH0QyQoVC6PjZdpWUAs4VC1Z
	 z/xiUAPtSkaB6TWTMS04sRFO376eKWSZPaHsIWgMorwig3zMrHg0a1d5fJlm1pHmev
	 CyMOuSFV6y9jjWsbFNMENZD3hPCgmtaIvMtz6mD3IP3/r37ugkCUoDTOqeOEdq+raU
	 BXl7hWOJrDSDQ==
Date: Mon, 5 Feb 2024 19:15:50 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com,
	ke.wang@unisoc.com, hongyu.jin@unisoc.com
Subject: Re: [PATCH 0/3] f2fs: fix panic issue in small capacity device
Message-ID: <ZcGkZslfFLP8wqUr@google.com>
References: <1706523684-24540-1-git-send-email-zhiguo.niu@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1706523684-24540-1-git-send-email-zhiguo.niu@unisoc.com>

On 01/29, Zhiguo Niu wrote:
> A panic issue happened in a reboot test in small capacity device
> as following:
> 1.The device size is 64MB, and main area has 24 segments, and
> CONFIG_F2FS_CHECK_FS is not enabled.
> 2.There is no any free segments left shown in free_segmap_info,
> then another write request cause get_new_segment get a out-of-bound
> segment with segno 24.
> 3.panic happen in update_sit_entry because access invalid bitmap
> pointer.

The goal here is to stop f2fs when it hits no space to write anymore?
And, we need f2fs_stop_checkpoint() at the end?

> 
> More detail shown in following three patches.
> The three patches are splited here because the modifications are
> relatively independent and more readable.
> 
> Zhiguo Niu (3):
>   f2fs: correct counting methods of free_segments in __set_inuse
>   f2fs: fix panic issue in update_sit_entry
>   f2fs: enhance judgment conditions of GET_SEGNO
> 
>  fs/f2fs/file.c    | 7 ++++++-
>  fs/f2fs/segment.c | 9 ++++++---
>  fs/f2fs/segment.h | 7 ++++---
>  3 files changed, 16 insertions(+), 7 deletions(-)
> 
> -- 
> 1.9.1

