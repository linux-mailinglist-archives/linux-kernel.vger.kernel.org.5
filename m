Return-Path: <linux-kernel+bounces-94169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E63873ADC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C191C22062
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F29B13664C;
	Wed,  6 Mar 2024 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2Cg0Ta0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ED112FF88;
	Wed,  6 Mar 2024 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739385; cv=none; b=u2tnpkXqoPTJ0nQ1U9p1Cq9Xs+PJKC8bO3WrfmmMGnG9+ByCkeFeMEIgRzHIhlKdKzun/zqvqTcofwlWeR5u9Q9qcXvq9CswfGSnkf6KOId2tJvLVnRVdljkwAAsyU9B9UJJ78IfOGz0dXRO5+zi9Nf2fl7Bov32WtNceQYQiqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739385; c=relaxed/simple;
	bh=Bh5Dp27/tqyItLKHwyKeEmWbTpge2ZVnRBPEZ8Itq3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mt39l8ByE56RL4zq72BfMfiPTYU44iEpjdqN8DQAOJooiaproJ4BvFfpNEy+1yXP+/++joCQSUD0wZt6oAiEbwokzKNhxJEDR05Mu95rdi7hav2YjveIf3bEvH04wOJn0NG747IdZW41Q69T3JLtlDjnUtP1cjhCi+Uwt5trPCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2Cg0Ta0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00797C433F1;
	Wed,  6 Mar 2024 15:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709739385;
	bh=Bh5Dp27/tqyItLKHwyKeEmWbTpge2ZVnRBPEZ8Itq3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T2Cg0Ta00yUrXeehc7UDXzl+DzKBdm5vDlhzNht5QdJaVU7PyLyIrNrFqrbDl2MLx
	 SATq9IeRmxZlSCFO5of0MlbhTUQwfK0zSiVp5PgppVoCKfHxXEBTppsWNNk7qncGr/
	 1teHZ8V9m3uKVTyXP22AdlgG/p8f7NjMecv+MucGbhRcMi7oXtIUjuOWFTXU2XIxmj
	 lojH5o8xY6MICDuZzBh/XPmtyWGe/oAujETOntqV4W9H9b426KfuQR9/nCtxYRlUzt
	 nyFZ28Aiiw3TT6bY076xIMvNHLO+1252ccj3jydeSBygCcw09QTAV9/kBdOTDIGO/E
	 j5GIskJh2KkDQ==
Date: Wed, 6 Mar 2024 07:36:24 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: chandan.babu@oracle.com, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2 2/2] xfs: Remove duplicate include
Message-ID: <20240306153624.GO1927156@frogsfrogsfrogs>
References: <20240305024009.52931-1-jiapeng.chong@linux.alibaba.com>
 <20240305024009.52931-2-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305024009.52931-2-jiapeng.chong@linux.alibaba.com>

On Tue, Mar 05, 2024 at 10:40:09AM +0800, Jiapeng Chong wrote:
> ./fs/xfs/xfs_trace.c: xfs_bmap.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8385
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
> Changes in v2:
>   -Remove the second #include.
> 
>  fs/xfs/xfs_trace.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_trace.c b/fs/xfs/xfs_trace.c
> index 1a963382e5e9..3f253884fe5b 100644
> --- a/fs/xfs/xfs_trace.c
> +++ b/fs/xfs/xfs_trace.c
> @@ -38,7 +38,6 @@
>  #include "xfs_iomap.h"
>  #include "xfs_buf_mem.h"
>  #include "xfs_btree_mem.h"
> -#include "xfs_bmap.h"
>  
>  /*
>   * We include this last to have the helpers above available for the trace
> -- 
> 2.20.1.7.g153144c
> 
> 

