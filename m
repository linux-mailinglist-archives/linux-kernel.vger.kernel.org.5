Return-Path: <linux-kernel+bounces-76515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F2785F837
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB922878A1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E8164AA8;
	Thu, 22 Feb 2024 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQdmftJr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0460E6350F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605055; cv=none; b=qCxtq8afIT49LAT6rSYnCRk+FHDyLjYNn75/MJCYHPQ9vc/o7YQzXokaesFozIMVbLEYAlDEQsAj75O1b3hVK+e4PfN5B0NqxfCgeuzcb68gUfpsVSFcYCgsNXg/3iF9x0f7SznTn2Xe8Uxuy7ijyCCE/ZtNsk+a5+z1YucoiUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605055; c=relaxed/simple;
	bh=fjFY5/FC5nitX0I63+wFnRJqrTw9DhGxaj21oxxRA6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rl79nvXX5c0JgwZcpAvSeKKXaRkkoIx067PY2dx0WtUC+DyR6u6FT+rQ6QLqHbWz8w+u985iAi39eA3L8v61loPRq+k00pSVTZuAS+t/hVXaMRFYUV4GnAMyjVZXmajBqw4kIXgcaS5YeBcq5rANAmz2mpIBi8+p1tkS7YwpRXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQdmftJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2DFC433F1;
	Thu, 22 Feb 2024 12:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708605054;
	bh=fjFY5/FC5nitX0I63+wFnRJqrTw9DhGxaj21oxxRA6k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pQdmftJr/wI8M+MjCk6oa/xKtIn+Z2JnlE41xn26x+pmCWCtvEwc1hMOBXE/VQ6O3
	 szwW0onZEJIZBgKbuINcRFluorOpWBYi4h/lS/JXs6P/n7wWslO8BeHNSkwSuaOmH2
	 ogGGtmgmCB3ppdjk8olbzHmnLrOymmOKjuaIJz2yqD0XDgfnJKH4jxWReuwIj0yHVa
	 xThxcAjU5rg5e+pFiprjGwq1L9tIrsZsTFGnKW5IEW3YlqKI4DlJZkV/5Kq+ThBIuK
	 yCbo2H7hOiJy7Nh5EY8MZdLnemgIM+08l//WmQikn+0+vK5DeBszP+K6ouvufD6zuK
	 T44q9E5D8/ubQ==
Message-ID: <88459a22-a21c-4c3d-8371-31d7d713b536@kernel.org>
Date: Thu, 22 Feb 2024 20:30:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] f2fs: fix panic issue in small capacity device
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1707271264-5551-1-git-send-email-zhiguo.niu@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1707271264-5551-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/7 10:01, Zhiguo Niu wrote:
> A panic issue happened in a reboot test in small capacity device
> as following:
> 1.The device size is 64MB, and main area has 24 segments, and
> CONFIG_F2FS_CHECK_FS is not enabled.
> 2.There is no any free segments left shown in free_segmap_info,
> then another write request cause get_new_segment get a out-of-bound
> segment with segno 24.
> 3.panic happen in update_sit_entry because access invalid bitmap
> pointer.

Zhiguo,

Can you please try below patch to see whether it can fix your problem?

https://lore.kernel.org/linux-f2fs-devel/20240222121851.883141-3-chao@kernel.org

Thanks,

> 
> More detail shown in following patch sets.
> The three patches are splited here because the modifications are
> relatively independent and more readable.
> 
> ---
> Changes of v2: stop checkpoint when get a out-of-bound segment
> ---
> 
> Zhiguo Niu (4):
>    f2fs: correct counting methods of free_segments in __set_inuse
>    f2fs: fix panic issue in update_sit_entry
>    f2fs: enhance judgment conditions of GET_SEGNO
>    f2fs: stop checkpoint when get a out-of-bounds segment
> 
>   fs/f2fs/file.c          |  7 ++++++-
>   fs/f2fs/segment.c       | 21 ++++++++++++++++-----
>   fs/f2fs/segment.h       |  7 ++++---
>   include/linux/f2fs_fs.h |  1 +
>   4 files changed, 27 insertions(+), 9 deletions(-)
> 

