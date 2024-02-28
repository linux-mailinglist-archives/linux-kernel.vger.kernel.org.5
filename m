Return-Path: <linux-kernel+bounces-84496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A8586A772
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96C251C230C4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCD9208B2;
	Wed, 28 Feb 2024 04:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHNNbhya"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3934B20322;
	Wed, 28 Feb 2024 04:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709092926; cv=none; b=AfyPXYpOC7keRbtmSK08MkixsfvXRLz55D5Ze6UQ5TJ0xd2bV3e1+Qn29h/Srfw7/NpMFo+aD25yTGuymBVPzia2KSqTwQVaxz/vqsy40sAhFyAxE4cINROQd1XymjFiEiODkYFXKHPlSeTLeRlP3Rgf5v1Qx5En53QE0aUE/jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709092926; c=relaxed/simple;
	bh=MMnrA9LsWr/JDUw77Vki+bexWuFRqrJSWcaPPWJXiN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7x5LiZCWEZ/A7bVaYnvsITdteQe2jcrZc5vjo8c9h4vysyRjVFMnhRZVkMpKpTjByYtftOg3PxxcaWpS7U1fzD/j88pvGdBgd6XkASMJF28Go3dqwkubBcdt2PqAziYLVAltV5S1zz5fUTfO12vJjNwiueRdwxv/sbWR6JbAZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHNNbhya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBA7C433C7;
	Wed, 28 Feb 2024 04:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709092925;
	bh=MMnrA9LsWr/JDUw77Vki+bexWuFRqrJSWcaPPWJXiN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gHNNbhyaAptSDeJckMCX76hNJtGKXzDtjy0bvjKasGQMb2jb949WxJyCQmfuSuLER
	 SMLS2mBcb1ydUc7lEZRisoHrPWsU6IkWg8WZl5NYF9+7soVx/KldzMedzoGTQ+0JDK
	 O+ZgDU+Tqnp+ucAoqy0Z9Kl82InzQKKw6/sR43Y8yE6Zkc9EC1ZrQvY9xhTs82MWTa
	 p8gfjw6CXXLcK6driG5XpDBSVcUT6ui+1wlZ8qom0H+vBWyI8lOihkiHegOoYsT5X1
	 O0W8il4fX6AkpJi/r2Fj65AvCFpoDwTE8LXfBL9cIrwQ7EockISHOvoAoTfAj4CYIB
	 1YGEejsUwDQHg==
Date: Tue, 27 Feb 2024 20:02:05 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: chandan.babu@oracle.com, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH 2/2] xfs: Remove duplicate include
Message-ID: <20240228040205.GC1927156@frogsfrogsfrogs>
References: <20240228035612.25396-1-jiapeng.chong@linux.alibaba.com>
 <20240228035612.25396-2-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228035612.25396-2-jiapeng.chong@linux.alibaba.com>

On Wed, Feb 28, 2024 at 11:56:12AM +0800, Jiapeng Chong wrote:
> ./fs/xfs/xfs_trace.c: xfs_bmap.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8385
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  fs/xfs/xfs_trace.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_trace.c b/fs/xfs/xfs_trace.c
> index 1a963382e5e9..23e906b60f21 100644
> --- a/fs/xfs/xfs_trace.c
> +++ b/fs/xfs/xfs_trace.c
> @@ -17,7 +17,6 @@
>  #include "xfs_btree.h"
>  #include "xfs_da_btree.h"
>  #include "xfs_alloc.h"
> -#include "xfs_bmap.h"

Shouldn't this remove the second #include?

--D

>  #include "xfs_attr.h"
>  #include "xfs_trans.h"
>  #include "xfs_log.h"
> -- 
> 2.20.1.7.g153144c
> 
> 

