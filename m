Return-Path: <linux-kernel+bounces-36440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 726C783A0C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66951C2191A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D44AC2D3;
	Wed, 24 Jan 2024 04:51:32 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EA410795
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 04:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706071892; cv=none; b=bTVNEmWvl1KzViVgY7oEgovDoEe4flcE4oWMNZKvvU2ZTCH7rkozDxHJLKp4wDVc7/XEcrYtv6CwyCweeuUb7X9NQIRjUr9VRHjWF/2BmNWwqiO7CJ5Y5dtfK2Ypw7sR9+N/nCYBX3MwefOr7eslvxjSCjNGx56wI7Gl8KgHTqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706071892; c=relaxed/simple;
	bh=/nJ97u1y71tzYAhLXVwuT8L2GMSTKVyVRPds488gH0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dx6L+kDvn9w30wUtA6zpus9zNKIT7FHAiqPOVoY2kSQJJ57Iz0Qfoht/fRmefvYzhNO7gW9jZQJa9gUoIll7BSNRcK38csjw9X3D8gpane520tqt2HY098iK9aeiyxHyMb9aURW+/tM2lP8ZUv/DPi43GJAxEbIH79YzFaxrFP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.EnCAx_1706071885;
Received: from 30.97.48.250(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W.EnCAx_1706071885)
          by smtp.aliyun-inc.com;
          Wed, 24 Jan 2024 12:51:26 +0800
Message-ID: <658f0470-891f-48bc-a4b9-bdb01f24ebd1@linux.alibaba.com>
Date: Wed, 24 Jan 2024 12:51:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: get rid of unneeded GFP_NOFS
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
References: <20240124031945.130782-1-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240124031945.130782-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/1/24 11:19, Jingbo Xu wrote:
> Clean up some leftovers since there is no way for EROFS to be called
> again from a reclaim context.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Looks good to me, will test this later:

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

