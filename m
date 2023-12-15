Return-Path: <linux-kernel+bounces-1415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2571C814EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDFF21F25890
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7428C45C16;
	Fri, 15 Dec 2023 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDPnlf4P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B384645BE4;
	Fri, 15 Dec 2023 17:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345F7C433C7;
	Fri, 15 Dec 2023 17:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702660920;
	bh=qHlE69A5ZqSdTjbhfbjtu8LRfzYX4fr0PCz9C4ujX+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lDPnlf4Pz6Ir6nG8/KAt90EdSCTqN4v7KxuCT308bOdGrlmfP/yxdiTjc0xozMMLv
	 2398VHu+4uucqB5PKMHWeDUZZh0envGdJjYaZx+xap1Iv8t5awUZcJ14BswJ753D9J
	 K2ObR8bqy03WfOvcMHqSH/JgUiKdVSGv8+IKUiedfdPj+E8KU99mNgQ97ijhYznG2u
	 dzGcKP3txh/0vLRMq9LH1lBMvasJtdRpe+7XONG11pjv5NB5+KCKyqGRc3770XRYjW
	 bT0NLv014/JRGDJtcs/bvvnrKUXrb9TdLIzhhP4TeEaAC5ZTWAA/WNdBHbneTSIS4H
	 ILB9sk5U16dIw==
Date: Fri, 15 Dec 2023 09:21:59 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Wang Jinchao <wangjinchao@xfusion.com>
Cc: Chandan Babu R <chandan.babu@oracle.com>, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, stone.xulei@xfusion.com
Subject: Re: [PATCH] xfs/health: cleanup, remove duplicated including
Message-ID: <20231215172159.GN361584@frogsfrogsfrogs>
References: <202312151823+0800-wangjinchao@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312151823+0800-wangjinchao@xfusion.com>

On Fri, Dec 15, 2023 at 06:24:34PM +0800, Wang Jinchao wrote:
> remove the second ones:
> \#include "xfs_trans_resv.h"
> \#include "xfs_mount.h"
> 
> Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/scrub/health.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/xfs/scrub/health.c b/fs/xfs/scrub/health.c
> index 5e2b09ed6e29..289f1d4ea6ef 100644
> --- a/fs/xfs/scrub/health.c
> +++ b/fs/xfs/scrub/health.c
> @@ -10,8 +10,6 @@
>  #include "xfs_trans_resv.h"
>  #include "xfs_mount.h"
>  #include "xfs_btree.h"
> -#include "xfs_trans_resv.h"
> -#include "xfs_mount.h"
>  #include "xfs_ag.h"
>  #include "xfs_health.h"
>  #include "scrub/scrub.h"
> -- 
> 2.40.0
> 
> 

