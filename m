Return-Path: <linux-kernel+bounces-39554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FEF83D2BC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607141C217B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5FEB654;
	Fri, 26 Jan 2024 02:51:11 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D06621
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 02:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706237471; cv=none; b=oiW8AGqUa064ZbkjsktNf8EwUpjPqWVtPBaq1Pq5pzpJjL4qtkziDl2cn1UdWwkMTZO0bFwbcpGt/GZXOr0W2Qh+vHH0e6B8AlEjKyHuaLmb1k2a7LBBN/TqOqL75vvswJ9lCZqJxTZyLy6gfedPWEUO7fMRpXdGQ/NV4nYT5Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706237471; c=relaxed/simple;
	bh=tBnqUuzbN6YNo6B9G6/pBrgRAMFtLwfmTO0uI0aiWbM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=g1NLiav6i5ZEIzL4ynNiW69G5SyqOxIpsfEAC4QtMIV2s5DnJaGgoVcAgOAGVqis+2AdutOyPcGps4DV1hqH7+rFjMZ1jiPNPXSmWmXOwr3tRf2t8JCizbY5CvHizsuZiGYv5Low8I7/5ciUxcj/0bGjFNRly2nMBfV953dljvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TLhxV5WbGzXgty;
	Fri, 26 Jan 2024 10:49:50 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 941761402CD;
	Fri, 26 Jan 2024 10:51:05 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 10:51:04 +0800
Message-ID: <b0eb44fb-43a7-4582-bc1c-cb8c4b6722e2@huawei.com>
Date: Fri, 26 Jan 2024 10:51:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next,V2] fscache: support to disable assert macro
From: Zizhi Wo <wozizhi@huawei.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <dhowells@redhat.com>
CC: <linux-cachefs@redhat.com>, <linux-kernel@vger.kernel.org>,
	<yangerkun@huawei.com>
References: <20231101163414.2105727-1-wozizhi@huawei.com>
 <d3a50c46-93c9-4b60-8609-9465e1605f77@huawei.com>
 <32abf57d-d3bc-d812-c70f-bba8356162ff@linux.alibaba.com>
 <53ec0dd3-a873-455e-b4df-652ef2cf381b@huawei.com>
 <9388f5fd-569e-41ea-9065-035baaa6c75f@huawei.com>
In-Reply-To: <9388f5fd-569e-41ea-9065-035baaa6c75f@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500020.china.huawei.com (7.185.36.49)

friendly ping

在 2023/11/30 10:50, Zizhi Wo 写道:
> friendly ping
> 
> 在 2023/11/8 10:25, Zizhi Wo 写道:
>>
>>
>> 在 2023/11/7 20:39, Gao Xiang 写道:
>>>
>>>
>>> On 2023/11/7 18:16, Zizhi Wo wrote:
>>>> friendly ping
>>>>
>>>> 在 2023/11/2 0:34, WoZ1zh1 写道:
>>>>> In fs/fscache/internal.h, ASSERT macro is enabled by default and 
>>>>> can not
>>>>> be disabled, then assert failure will crash the kernel as the BUG() is
>>>>> included in the ASSERT macro. Therefore, add FSCACHE_ASSERT to 
>>>>> control it.
>>>
>>> Personally it looks good to me, yet we could also turn
>>> them into WARN_ON_ONCE case by case? Anyway, it depends
>>> on how David thinks...
>>>
>> Thank you for your recognition!
>>
>> Thanks,
>> Zizhi Wo
>>
>>> Thanks,
>>> Gao Xiang
>>>
>>>>>
>>>>> Signed-off-by: WoZ1zh1 <wozizhi@huawei.com>
>>>>> ---
>>>>>   fs/fscache/Kconfig    | 10 ++++++++++
>>>>>   fs/fscache/internal.h |  2 +-
>>>>>   2 files changed, 11 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/fscache/Kconfig b/fs/fscache/Kconfig
>>>>> index b313a978ae0a..7ff844038bc3 100644
>>>>> --- a/fs/fscache/Kconfig
>>>>> +++ b/fs/fscache/Kconfig
>>>>> @@ -38,3 +38,13 @@ config FSCACHE_DEBUG
>>>>>         enabled by setting bits in 
>>>>> /sys/modules/fscache/parameter/debug.
>>>>>         See Documentation/filesystems/caching/fscache.rst for more 
>>>>> information.
>>>>> +
>>>>> +config FSCACHE_ASSERT
>>>>> +    bool "FSCACHE asserts"
>>>>> +    default n
>>>>> +    depends on FSCACHE
>>>>> +    help
>>>>> +      Support the ASSERT mode for failure behavior.
>>>>> +      Say N here to disable the ASSERT by default.
>>>>> +      Say Y to add assertion checks in some places. But the assertion
>>>>> +      failure will result in fatal errors that BUG() the kernel.
>>>>> diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
>>>>> index 1336f517e9b1..951166ed772f 100644
>>>>> --- a/fs/fscache/internal.h
>>>>> +++ b/fs/fscache/internal.h
>>>>> @@ -225,7 +225,7 @@ do {                        \
>>>>>   /*
>>>>>    * assertions
>>>>>    */
>>>>> -#if 1 /* defined(__KDEBUGALL) */
>>>>> +#ifdef CONFIG_FSCACHE_ASSERT
>>>>>   #define ASSERT(X)                            \
>>>>>   do {                                    \
>>>

