Return-Path: <linux-kernel+bounces-156568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B078B04A2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556B7282AFB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ADC1581E0;
	Wed, 24 Apr 2024 08:44:39 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7584D157A58
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713948279; cv=none; b=uAjyeft7tmk2kr5Gbfcu3FezQMgVmpK0NQdL3kMNoDkEORzcRGB1AD9Jd5x9IfsIGNCbLDHLz+icDOAClJarMppnqNuPLxvMctZnT1zD9icJx44G6WubRswF/IBUrN6ZQSQfmi8yuHCT0UZs9Bl9fB0JEa0bB4v7FoqagcWbwZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713948279; c=relaxed/simple;
	bh=72dDQb35D/K5zmdkRcjY1p0LRwj9rmLZqtpNP1gcwqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q2Y4bA2fCmw+zk34QQJHKq1YMZv9jtrDVT93Rp9Owb3WixDPNn7NPlkDTS51Ibw4uQB1Pq08ZjSKba+7QsHtIzhTmVFLS3f7NYmmnPyEK7Azlq3iDFXBN91Cd02FytohK0wOeimbNYmGo9/VXnR5MYzlONc+TwQ9LR71g3Nc7eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VPXWx2KVVzwSZg;
	Wed, 24 Apr 2024 16:41:17 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 041921800C2;
	Wed, 24 Apr 2024 16:44:28 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 16:44:27 +0800
Message-ID: <7ae4a071-56b3-410b-9c95-d6677dc46f25@huawei.com>
Date: Wed, 24 Apr 2024 16:44:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] erofs: modify the error message when
 prepare_ondemand_read failed
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <xiang@kernel.org>,
	<chao@kernel.org>
CC: <huyue2@coolpad.com>, <jefflexu@linux.alibaba.com>, <dhavale@google.com>,
	linux-erofs mailing list <linux-erofs@lists.ozlabs.org>, LKML
	<linux-kernel@vger.kernel.org>
References: <20240424023945.420828-1-lihongbo22@huawei.com>
 <871467f7-1218-4c13-ae47-13e89bbbe0cc@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <871467f7-1218-4c13-ae47-13e89bbbe0cc@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)

ok, thanks!

On 2024/4/24 11:29, Gao Xiang wrote:
> 
> (+cc linux-erofs & LKML)
> 
> On 2024/4/24 10:39, Hongbo Li wrote:
>> When prepare_ondemand_read failed, wrong error message is printed.
>> The prepare_read is also implemented in cachefiles, so we amend it.
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Could you resend the patch with proper mailing list cced with my
> "reviewed-by:" tag?  So I could apply with "b4" tool.
> 
> Thanks,
> Gao Xiang
> 
>> ---
>>   fs/erofs/fscache.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
>> index 8aff1a724805..62da538d91cb 100644
>> --- a/fs/erofs/fscache.c
>> +++ b/fs/erofs/fscache.c
>> @@ -151,7 +151,7 @@ static int erofs_fscache_read_io_async(struct 
>> fscache_cookie *cookie,
>>           if (WARN_ON(len == 0))
>>               source = NETFS_INVALID_READ;
>>           if (source != NETFS_READ_FROM_CACHE) {
>> -            erofs_err(NULL, "prepare_read failed (source %d)", source);
>> +            erofs_err(NULL, "prepare_ondemand_read failed (source 
>> %d)", source);
>>               return -EIO;
>>           }

