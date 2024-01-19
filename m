Return-Path: <linux-kernel+bounces-30684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3989832303
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DB21F2209C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3841113;
	Fri, 19 Jan 2024 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnmxjqCf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27ADEC7;
	Fri, 19 Jan 2024 01:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705628159; cv=none; b=i4zLdUSB+WYuD00CRiDVragI/07jHK0wJcfH/YTOyIXve0cFkBfEgmj0AKKMaX94Hj8heYE9+cjyOOyR5iTZot6nWUmoAlVXvOADDgBRMB2cRc1Z+tThp92iv/pHi1yY1SJJ7h1kkpUcuV/31/k8LJIK2OC26wwYI+LxrLLsgEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705628159; c=relaxed/simple;
	bh=/ZfBCWmKyNYBScnBAqemNsyShCkWcxOBncpAtpEWVpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQRU4X09LdTHYLrTa4wwpuqWa1wloYnSGwBIw5lXN+cAzkzOa0206IwYlsnjJg1DwIFdhvQw73PcjqKj6ukTPjvIte8cMWmsjOWdgeifLs3bQZVAtMOHqKe2UluYw4up4lJ400NALb0AQcyqz83awPA5b789YseGnUa4zYjb0fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnmxjqCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61ACAC433C7;
	Fri, 19 Jan 2024 01:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705628157;
	bh=/ZfBCWmKyNYBScnBAqemNsyShCkWcxOBncpAtpEWVpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pnmxjqCfMbdtcQd4B/aZ9FYiMlXjDpLoOG5if9v8CV8fFE2+Ckq1ZKGT0saqx8VE3
	 Rl6gCUzJVaF2ufyuLQR0lu9WDrcW/buZCPitTWDfs+vLE2xDRz79W2O1L9JINJyUnU
	 LimS0XUSQ7FgR3fXW/L6sGaPlbZRCQCJ8StLrTXPe98HbBJNw63HKKyXv2cHcaPtyK
	 HA3yD/hG61bInR4Iqp7+mVZ4WMxLmOm/sTYxhup5HfgNhCjUWE3E6TWYvU2A6FafCQ
	 +ksYWfTKzyTWFQJhNsqh96iha2FSaWOrUd5D2shSOi50ilKgXEJNSLAXRF7NyT+1Jl
	 +xspb4K52Rtxg==
Date: Thu, 18 Jan 2024 17:35:56 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
	linux-xfs@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au, mingo@kernel.org, peterz@infradead.org,
	chandan.babu@oracle.com, anton@tuxera.com
Subject: Re: [RFC PATCH 2/3] fs: remove duplicate ifdefs
Message-ID: <20240119013556.GT674499@frogsfrogsfrogs>
References: <20240118080326.13137-1-sshegde@linux.ibm.com>
 <20240118080326.13137-3-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118080326.13137-3-sshegde@linux.ibm.com>

On Thu, Jan 18, 2024 at 01:33:25PM +0530, Shrikanth Hegde wrote:
> when a ifdef is used in the below manner, second one could be considered as
> duplicate.
> 
> ifdef DEFINE_A
> ...code block...
> ifdef DEFINE_A
> ...code block...
> endif
> ...code block...
> endif
> 
> There are few places in fs code where above pattern was seen.
> No functional change is intended here. It only aims to improve code
> readability.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  fs/ntfs/inode.c    | 2 --
>  fs/xfs/xfs_sysfs.c | 4 ----
>  2 files changed, 6 deletions(-)
> 
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index aba1e22db4e9..d2c8622d53d1 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -2859,11 +2859,9 @@ int ntfs_truncate(struct inode *vi)
>   *
>   * See ntfs_truncate() description above for details.
>   */
> -#ifdef NTFS_RW
>  void ntfs_truncate_vfs(struct inode *vi) {
>  	ntfs_truncate(vi);
>  }
> -#endif
> 
>  /**
>   * ntfs_setattr - called from notify_change() when an attribute is being changed
> diff --git a/fs/xfs/xfs_sysfs.c b/fs/xfs/xfs_sysfs.c
> index 17485666b672..d2391eec37fe 100644
> --- a/fs/xfs/xfs_sysfs.c
> +++ b/fs/xfs/xfs_sysfs.c
> @@ -193,7 +193,6 @@ always_cow_show(
>  }
>  XFS_SYSFS_ATTR_RW(always_cow);
> 
> -#ifdef DEBUG
>  /*
>   * Override how many threads the parallel work queue is allowed to create.
>   * This has to be a debug-only global (instead of an errortag) because one of
> @@ -260,7 +259,6 @@ larp_show(
>  	return snprintf(buf, PAGE_SIZE, "%d\n", xfs_globals.larp);
>  }
>  XFS_SYSFS_ATTR_RW(larp);
> -#endif /* DEBUG */
> 
>  STATIC ssize_t
>  bload_leaf_slack_store(
> @@ -319,10 +317,8 @@ static struct attribute *xfs_dbg_attrs[] = {
>  	ATTR_LIST(log_recovery_delay),
>  	ATTR_LIST(mount_delay),
>  	ATTR_LIST(always_cow),
> -#ifdef DEBUG
>  	ATTR_LIST(pwork_threads),
>  	ATTR_LIST(larp),
> -#endif

The xfs part seems fine to me bcause I think some bot already
complained about this...

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  	ATTR_LIST(bload_leaf_slack),
>  	ATTR_LIST(bload_node_slack),
>  	NULL,
> --
> 2.39.3
> 
> 

