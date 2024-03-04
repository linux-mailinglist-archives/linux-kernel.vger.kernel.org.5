Return-Path: <linux-kernel+bounces-89985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DCF86F8A5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913331F21444
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE993D6D;
	Mon,  4 Mar 2024 02:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/CwAWrU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8689915B7;
	Mon,  4 Mar 2024 02:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709520286; cv=none; b=Arlc2788bRMNBNCDkFTmtke7tryCxJoph48RwmU6lcIOnsHfEtTg1whMhtFgU/Fa/8raNGClekCr3FdT1n1qM5JSJPpLQEua09uBFsqXq/Ov84QLSOLjt3S412jNsGwkqBVVGz+VxJN0h3qbwd6DAywWrcB/RE5MBDU43CaJeh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709520286; c=relaxed/simple;
	bh=jDhQjOmkoJqCTt9EzfOVxpQ6daRD3zhG+zsujgxXcJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utogpPafi95d5dHy7GkOG37ZZysQG6rqBJbkxpI3T9qOQv+mFZ06mGeUy1laKgPjYDGoXze08SpXq40tlbuzRITHb6Ib/a/NGmtBYJqEAh852cDNkE+k00SyO8QOb/OYJRDpXVHsszfgWyyOpDg3YPIKRlVEzHT7sW0vRrl/QPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/CwAWrU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D20C433C7;
	Mon,  4 Mar 2024 02:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709520286;
	bh=jDhQjOmkoJqCTt9EzfOVxpQ6daRD3zhG+zsujgxXcJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X/CwAWrURCjhk5UXT/9z6c1QIWOCEw7k2lwOQOk8MRcZnwpHACa6NBAp7eFEdRJK0
	 la/5RroHDFlqs24/w6lpOMYorlLQqmSNXq7RCRhq7ocBEwwfO71hBuygfW4T4542fi
	 +62fOdrqniamsdZSNhK2bJ1jPcjET/wCDvqczlY+bT3rhRYVK0JXsbPNhiGinbxIvw
	 sd5NPZKzlI2KgzX2iFCVvgIf9tAVXmgoj6LDTDEPkFrGGbefpJZMQDvMD1bxh2QSgQ
	 vjMzHp008WhjpY7LKhgUcF/+DcGb8XEwfL2OhUlEAiSW4bq7myoblJCXSKKIwcXcjl
	 X9+/DFjesh8FA==
Date: Sun, 3 Mar 2024 18:44:45 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: chandan.babu@oracle.com, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] xfs: Remove unused function is_rt_data_fork
Message-ID: <20240304024445.GM1927156@frogsfrogsfrogs>
References: <20240304022408.111558-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304022408.111558-1-jiapeng.chong@linux.alibaba.com>

On Mon, Mar 04, 2024 at 10:24:08AM +0800, Jiapeng Chong wrote:
> The function are defined in the rmap_repair.c file, but not called
> elsewhere, so delete the unused function.
> 
> fs/xfs/scrub/rmap_repair.c:436:1: warning: unused function 'is_rt_data_fork'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8425
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Oh hey, that really /is/ unused, even in djwong-wtf.  Good catch!

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/scrub/rmap_repair.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/fs/xfs/scrub/rmap_repair.c b/fs/xfs/scrub/rmap_repair.c
> index e8e07b683eab..7e73ddfb3d44 100644
> --- a/fs/xfs/scrub/rmap_repair.c
> +++ b/fs/xfs/scrub/rmap_repair.c
> @@ -432,14 +432,6 @@ xrep_rmap_scan_iroot_btree(
>  	return error;
>  }
>  
> -static inline bool
> -is_rt_data_fork(
> -	struct xfs_inode	*ip,
> -	int			whichfork)
> -{
> -	return XFS_IS_REALTIME_INODE(ip) && whichfork == XFS_DATA_FORK;
> -}
> -
>  /*
>   * Iterate the block mapping btree to collect rmap records for anything in this
>   * fork that matches the AG.  Sets @mappings_done to true if we've scanned the
> -- 
> 2.20.1.7.g153144c
> 
> 

