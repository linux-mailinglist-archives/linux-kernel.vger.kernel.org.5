Return-Path: <linux-kernel+bounces-156199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE5C8AFF20
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F901F2396A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDFE86277;
	Wed, 24 Apr 2024 03:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYfXxw3p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEB6339A1;
	Wed, 24 Apr 2024 03:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713928017; cv=none; b=sqFoxDToICWEETc1pk8/HpyDCrmN+IJvTdS6a2uwsrOzctv+Osbmkl9C/IwoTdRripE49B1NDitUZsRnY8rGoeFtH+2xUixBGusoNL5uBF0sEg038++NmPLOuaR1LpTVaQktrcKH3yK3OYpZBLH7de1r8+1dD0L2cSrI4HVkGn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713928017; c=relaxed/simple;
	bh=HAm8npkjU9W9knreApov7ysuQwghSu0sfaePTT/qFdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYm87SehUo5Jpxw3rGYAlhy+qBn4EDy/GSPaMcYefbaYUZJB05Hq5V4QbfkSdm8RVcgMHinfNkd3MnnB49apRwi9O+tmU+gBMh1N6P1muOiEvR2gz7Wl043VTPjYeCtFmv/qslGwtCmPjdoWAZJsU9ca7Aa7d8TOrYCi4cDfWW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYfXxw3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AED8C116B1;
	Wed, 24 Apr 2024 03:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713928016;
	bh=HAm8npkjU9W9knreApov7ysuQwghSu0sfaePTT/qFdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LYfXxw3p4wmKieHARFTBzsmHd7aZLi/XmBIFSyRdmgBtB9/1KsRNKMXYtkwmWDczJ
	 WgXdVF7y7GPi8iK+q/qIdEP5v8Gsak1sml73TpWMoXjdbKrHU6RntqsOVbS9/Nzu80
	 2VjASi+6BRpmo1iKP/fL4A7yiRhu4l2EepmtyORboMix6Udl+Yj2hEsCYqHgdlfCY8
	 /TR/UCjZfjIp0zNyMflTpeQB1Igx7pOpdVfyPupT2aOZ/+wG/UvAXQ0ag4Asxihi9X
	 XV7ctIpglPk+qIle93BDb59IvJi+gEJOIp8bihRNVLlTKUYUxddDWq8KwMq4A4gA4O
	 sGlPFPkDBbXXA==
Date: Tue, 23 Apr 2024 20:06:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: chandan.babu@oracle.com, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] xfs: Remove unused function xrep_dir_self_parent
Message-ID: <20240424030656.GC360919@frogsfrogsfrogs>
References: <20240424020638.81487-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424020638.81487-1-jiapeng.chong@linux.alibaba.com>

On Wed, Apr 24, 2024 at 10:06:38AM +0800, Jiapeng Chong wrote:
> The function are defined in the dir_repair.c file, but not called
> elsewhere, so delete the unused function.
> 
> fs/xfs/scrub/dir_repair.c:186:1: warning: unused function 'xrep_dir_self_parent'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8867
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Yep, not used anywhere in my patchsets.  Thank you for catching this and
cleaning it up.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/scrub/dir_repair.c | 21 ---------------------
>  1 file changed, 21 deletions(-)
> 
> diff --git a/fs/xfs/scrub/dir_repair.c b/fs/xfs/scrub/dir_repair.c
> index 38957da26b94..f8450c7f99f4 100644
> --- a/fs/xfs/scrub/dir_repair.c
> +++ b/fs/xfs/scrub/dir_repair.c
> @@ -176,27 +176,6 @@ xrep_setup_directory(
>  	return 0;
>  }
>  
> -/*
> - * If we're the root of a directory tree, we are our own parent.  If we're an
> - * unlinked directory, the parent /won't/ have a link to us.  Set the parent
> - * directory to the root for both cases.  Returns NULLFSINO if we don't know
> - * what to do.
> - */
> -static inline xfs_ino_t
> -xrep_dir_self_parent(
> -	struct xrep_dir		*rd)
> -{
> -	struct xfs_scrub	*sc = rd->sc;
> -
> -	if (sc->ip->i_ino == sc->mp->m_sb.sb_rootino)
> -		return sc->mp->m_sb.sb_rootino;
> -
> -	if (VFS_I(sc->ip)->i_nlink == 0)
> -		return sc->mp->m_sb.sb_rootino;
> -
> -	return NULLFSINO;
> -}
> -
>  /*
>   * Look up the dotdot entry and confirm that it's really the parent.
>   * Returns NULLFSINO if we don't know what to do.
> -- 
> 2.20.1.7.g153144c
> 
> 

