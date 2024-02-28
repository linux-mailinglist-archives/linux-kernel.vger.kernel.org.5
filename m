Return-Path: <linux-kernel+bounces-84495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748AE86A770
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3DA51C22FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846F0208A8;
	Wed, 28 Feb 2024 04:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwBmJGAV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61451CFB9;
	Wed, 28 Feb 2024 04:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709092894; cv=none; b=bx0F/lF/rBoeUgfN3ZkBoDkWOX3l70BeFbm60SCmfqawAvtxJtPO5+sxzHbi60NHyRcfUJ4oiwST4GghaK1MkKWZe/RtJUWP6iXw5yfEla8wu73rhsmfvzFTK4+JkoMUkrCk7aSPMu7+tQCWxtMkgOvQgpiTrf5kwL6cJwW17cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709092894; c=relaxed/simple;
	bh=bEiSUdZ0yLtJqiyPtup3v09A64wGKC5VExBh4WuM/KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RH4HE4ed0rA67iXecWtPc3/I6wZELzPJywp9hhKkE44OTUJjXW867fbrU9zocmM2o2DLQn32LDBefHb6460vI4b9+z9K73OOCb7kpnJKT8Urib+QMLZuZRN54RN2+r1nMtX41Hi/iioWauVfyrD+FLKdKjc4eR8t7vvLbpRk0YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwBmJGAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF6CC433F1;
	Wed, 28 Feb 2024 04:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709092894;
	bh=bEiSUdZ0yLtJqiyPtup3v09A64wGKC5VExBh4WuM/KY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwBmJGAVbXARTE+qdBq+C9WS7sscwUrCt+nf+AwRcM4YWnVtBu2fVpi3uwN8b9ZhA
	 uuZr6dycHiwX4U/FVfG7GI4A1nbA6n8q+eEGyja/zZoVTOVL7Flxr1pF21YBFl0Ul4
	 VyJHrD0LRI0zEwZPH7hBKypJhwVV2KZ0eFHomNkKDT7slLaZfNBho1dqD7tppmSZmz
	 sMbamoWkBCGFfnGGRtAX/lQeq5ebrmKV+R3mTs3bXSGdJcpB+rJebgkQHV3RbOhGtp
	 1phBoqBFT4heSFtlZm7XKG0OEcioBF3joBrvBib0q50h3gWt3DvDUWUyehrH89ibrh
	 KNDglKNDe4mtA==
Date: Tue, 27 Feb 2024 20:01:33 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: chandan.babu@oracle.com, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH 1/2] xfs: Remove duplicate include
Message-ID: <20240228040133.GB1927156@frogsfrogsfrogs>
References: <20240228035612.25396-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228035612.25396-1-jiapeng.chong@linux.alibaba.com>

On Wed, Feb 28, 2024 at 11:56:11AM +0800, Jiapeng Chong wrote:
> ./fs/xfs/xfs_qm_bhv.c: xfs_mount.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8386
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_qm_bhv.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_qm_bhv.c b/fs/xfs/xfs_qm_bhv.c
> index 271c1021c733..a11436579877 100644
> --- a/fs/xfs/xfs_qm_bhv.c
> +++ b/fs/xfs/xfs_qm_bhv.c
> @@ -11,7 +11,6 @@
>  #include "xfs_trans_resv.h"
>  #include "xfs_mount.h"
>  #include "xfs_quota.h"
> -#include "xfs_mount.h"
>  #include "xfs_inode.h"
>  #include "xfs_trans.h"
>  #include "xfs_qm.h"
> -- 
> 2.20.1.7.g153144c
> 
> 

