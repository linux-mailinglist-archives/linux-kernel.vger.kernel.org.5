Return-Path: <linux-kernel+bounces-156211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB608AFFA8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776CA285072
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CD0139CEB;
	Wed, 24 Apr 2024 03:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LxxRC0n0"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440508627C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 03:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713929376; cv=none; b=OuCkunvFeLsd+Pr4clT3E1Bg2hRCP9QHWCZwlpithX9wsbAYHOkXO5XpEdnyRBDsyapYQb1mNH8KW4NyeP/Zdv7mBzTuleyP0IyZlwc51l9E4QhSARYuFZwfb31S9ZZjzarjPZQQmJGfyGARfJ2ZJVSYjqAU7OZeK+qT3gKwSbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713929376; c=relaxed/simple;
	bh=IXrYvzj2ENQ3Q3iwFGC5oWcuhFxJU5EHiAiIWa60SKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=puoojhwhC0OEG6IqtYkRFbOSSqCHEgJiyJG65cMVGR77GmwZCH43LvLijjFuNu6n59I84NW11oWOo16Yz9A6Myi12M/srEPU89+WGZw9iZJRq3K1JogV020RUNT4cVo1aX7PsCHQNmjeVxNo20fvmiYytqiutzHMbg6ipYuSnyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LxxRC0n0; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713929371; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6+3vy5RW94Ou/P4a51UJp53U0IfxqdYqVf/uzowYFLE=;
	b=LxxRC0n03NUBvT9tQlIeXfPIHiA3Ps/KzlyRLBHznHnmEDTJbRRLBpN0UzJ0f+4HwSRv2BpED8VsnoYErOf9wI8p3Fya2Qr6lOSb63a6FlVqY73yXBCvYx8x4xMQ7gC230TRFRdopXKanFt7lkYhA4sSVD1HOTTHTWpfYMAZ5Fo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W5Alj4X_1713929369;
Received: from 30.97.48.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5Alj4X_1713929369)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 11:29:30 +0800
Message-ID: <871467f7-1218-4c13-ae47-13e89bbbe0cc@linux.alibaba.com>
Date: Wed, 24 Apr 2024 11:29:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] erofs: modify the error message when
 prepare_ondemand_read failed
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, chao@kernel.org
Cc: huyue2@coolpad.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20240424023945.420828-1-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240424023945.420828-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


(+cc linux-erofs & LKML)

On 2024/4/24 10:39, Hongbo Li wrote:
> When prepare_ondemand_read failed, wrong error message is printed.
> The prepare_read is also implemented in cachefiles, so we amend it.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Could you resend the patch with proper mailing list cced with my
"reviewed-by:" tag?  So I could apply with "b4" tool.

Thanks,
Gao Xiang

> ---
>   fs/erofs/fscache.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 8aff1a724805..62da538d91cb 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -151,7 +151,7 @@ static int erofs_fscache_read_io_async(struct fscache_cookie *cookie,
>   		if (WARN_ON(len == 0))
>   			source = NETFS_INVALID_READ;
>   		if (source != NETFS_READ_FROM_CACHE) {
> -			erofs_err(NULL, "prepare_read failed (source %d)", source);
> +			erofs_err(NULL, "prepare_ondemand_read failed (source %d)", source);
>   			return -EIO;
>   		}
>   

