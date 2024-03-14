Return-Path: <linux-kernel+bounces-102781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CA087B736
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789CE1C21973
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0937C15D;
	Thu, 14 Mar 2024 05:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OYFMtQhq"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919B59441;
	Thu, 14 Mar 2024 05:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710392856; cv=none; b=cEMO5gv8uI2KGozxGaFQsw8vCrKOP4WpsYTS3tmlON6wnXTmd8huEDLA5aE3wQKf7GEjEhZBZXKJ2pijcAgOkDUmEobSVMCy9bw7iHEHQqRHVHatP2jfsQ+dQ6OdCnarUzu0iiaRkg05jxWshhqmhpFnHTaE3Kar1HTyj6/UnB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710392856; c=relaxed/simple;
	bh=ZowHIVW3QkXC1C1Z/cQ4jYvH8ba7kRd92ESJzCw61cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RVtNjOggas6DsTC104yoIqpieB14LnG5qrfYu4VVfmuuLW6E1nil0D9aIyKDB6QtmVZtw6iFk/goBJbrDlCne2shXYe00TXwVnOOEAaFk9ofJVR9LddEiLX9dvA96U/CvS9imPzJvAFHgJ2KS7r4e+Y86meOx3yjbwI0oRniRb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OYFMtQhq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ggBkA1/GqjbdiDwXY3xwpMij5+YapJ5cC246DeMX0so=; b=OYFMtQhqd76EfYUStAU+qj8XFh
	HIjHJvIESVI5TOrNqGnmZW0Ho/s9RZGsRMrax4HaWHQ36m5fKHQb1OjgOVtXPdTv7HxXjHoKGx00o
	QuaZpCOUVpYc8oVeLHnPHqioRSb64WSMNX9Dvt5T1l0UIVYHnOWOJWqOY5UhyfYo2yJgJgHagx+Ay
	SRolDczeM9E0eVEORKOPZMKTMmk96IPmfxO4ZjzryOMFgYkAE90mPmpu2ckxY2z/AwIV32XAB6h6t
	vgc9Vd+V36VqvyieH9CqX2fvnMDFWDEyGm2AsI0xTjBCnFnQP2Gls1AqYPxNgVYkTdlwVvwB8sVF2
	ld517gRA==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkdJT-0000000Czvx-0fpY;
	Thu, 14 Mar 2024 05:07:31 +0000
Message-ID: <84db1c85-dcf2-450d-a4a1-75a2900ddde6@infradead.org>
Date: Wed, 13 Mar 2024 22:07:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Modify mismatched function name
Content-Language: en-US
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>
References: <20240314025615.71269-1-jiapeng.chong@linux.alibaba.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240314025615.71269-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/13/24 19:56, Jiapeng Chong wrote:
> No functional modification involved.
> 
> block/blk-settings.c:281: warning: expecting prototype for queue_limits_commit_set(). Prototype was for queue_limits_set() instead.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8539
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  block/blk-settings.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index e160d56e8eda..3c7d8d638ab5 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -267,7 +267,7 @@ int queue_limits_commit_update(struct request_queue *q,
>  EXPORT_SYMBOL_GPL(queue_limits_commit_update);
>  
>  /**
> - * queue_limits_commit_set - apply queue limits to queue
> + * queue_limits_set - apply queue limits to queue
>   * @q:		queue to update
>   * @lim:	limits to apply
>   *

-- 
#Randy

