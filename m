Return-Path: <linux-kernel+bounces-94168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0317B873ADA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B275D2885B0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFFA135A4A;
	Wed,  6 Mar 2024 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkjBnEqz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35CF131E4B;
	Wed,  6 Mar 2024 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739376; cv=none; b=Y+v0mbSZ+Z/iv3huY+VYiqBRBmxiI1l5ALjzV2WsU/1Q9YMlO8jkYVTrJjlsX/JO66m8LC+6j8ZGctN+XO7/RFHgk7JquCE/fHJ/wlveBoDZKXyZGor70IjwGLR5JzbC2tTAhWc1KbLZzteAS3nBmFZXgCyLXnDMKIj22Tr2/Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739376; c=relaxed/simple;
	bh=8VLcXR+jG4hJ5Ep8CpH16PpBp78fHR8nnu1PwOGWd28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsXk3ar1t52MZaC5wtR4++6/4szT7qMU3wPkhD2TMmBogE3gsz31xNiw2nonND1rOQOydzbjIvqqoFnmFAa4+vSDP7jo7EIn44gwplVSDOEwTdspwgFJ/Ub1E8MNtynQLz1KPke9gctSjGXRlLU7yaRSReCdWLYj0k1xA3fOLwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkjBnEqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3669FC433C7;
	Wed,  6 Mar 2024 15:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709739376;
	bh=8VLcXR+jG4hJ5Ep8CpH16PpBp78fHR8nnu1PwOGWd28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DkjBnEqz3qWpAmjEq8itGuwqU/UL0ZZWLzEE95rgPnZMbj6trlsg+6ODqL1kxm9HT
	 yLkS2UEMQYqCOeHcgVD+WXooIk16Zfuih2NDmRQP3skGDg3UWtJBuXG+jxRkMweZiW
	 5Pfur0hAr1FjoT7er3292OOHFuidKGWqhGobe1uavNP3qXQNFi8C/0I6TW/aalCx+Z
	 LUcuHrxGtIIRoGCpFi3+07fV8/GUfN6kzp0Mw6/hJBpuzIvni91MgBuWcrZ1qVBfOG
	 2TL4l2Wq/juXglUjmj7q81vm3jj5fa6rzdEmtJhftL3Xtjk0VRaAEkxShEw4N1UPlc
	 tQv+5AqPYrLQA==
Date: Wed, 6 Mar 2024 07:36:15 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: chandan.babu@oracle.com, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2 1/2] xfs: Remove duplicate include
Message-ID: <20240306153615.GN1927156@frogsfrogsfrogs>
References: <20240305024009.52931-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305024009.52931-1-jiapeng.chong@linux.alibaba.com>

On Tue, Mar 05, 2024 at 10:40:08AM +0800, Jiapeng Chong wrote:
> ./fs/xfs/xfs_qm_bhv.c: xfs_mount.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8386
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

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

