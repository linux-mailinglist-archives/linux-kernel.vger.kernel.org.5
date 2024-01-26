Return-Path: <linux-kernel+bounces-39552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2B483D2BA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D256AB21A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B508F77;
	Fri, 26 Jan 2024 02:49:49 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D911B8F45
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 02:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706237389; cv=none; b=NJS6dJd1tMMajTuQdNzv/aPoNSyj03oR6VdG6SYN2DKL6iflrzR3eaadAhl8gnUqe4mOnGx3/oZh0yIo2PtWSaphSLqghs4v5YtCCplaZ8vAHI/d+vxOZg5T8XfalXeHoYBthY1RGn8oovWu/FwZDspkxRqNqnr5jXYeyYXvb8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706237389; c=relaxed/simple;
	bh=Bs/eMtfZNuJUb/6D00nv0xPSiBetdR2DPhJ0aIVoNJs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Gf25ZPoFJnjL7OP66zb7Xdk/EIxQD+Sv0RnlY1URDjDv6wbx1MjJt7Dk/RFkHKGNJyfaL7ad/NBrpxJT8QaNivUmN4+k1jmFcVAaq5UR/I3N3AwcZq5hP+zEshFEewv8So3MkuWqvMJun9NuZU/EWeAEVNqOJSfrtPH5MCzNGlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TLhvZ2D9mzvTqW;
	Fri, 26 Jan 2024 10:48:10 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 5634E18007A;
	Fri, 26 Jan 2024 10:49:44 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 10:49:43 +0800
Message-ID: <b98dc776-99cd-4514-80e6-bdd4dbeb0e50@huawei.com>
Date: Fri, 26 Jan 2024 10:49:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next,V2] cachefiles: support to disable assert macro
From: Zizhi Wo <wozizhi@huawei.com>
To: <dhowells@redhat.com>
CC: <linux-cachefs@redhat.com>, <linux-kernel@vger.kernel.org>,
	<yangerkun@huawei.com>, <hsiangkao@linux.alibaba.com>
References: <20231101163431.2108688-1-wozizhi@huawei.com>
 <029f5c1c-6251-4112-8ce0-ef3d46596089@huawei.com>
 <9f954701-62e0-4815-8e28-3ed75be07337@huawei.com>
In-Reply-To: <9f954701-62e0-4815-8e28-3ed75be07337@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500020.china.huawei.com (7.185.36.49)

friendly ping

在 2023/11/30 10:49, Zizhi Wo 写道:
> friendly ping
> 
> 在 2023/11/7 18:17, Zizhi Wo 写道:
>> friendly ping
>>
>> 在 2023/11/2 0:34, WoZ1zh1 写道:
>>> In fs/cachefiles/internal.h, ASSERT macro is enabled by default and can
>>> not be disabled, then assert failure will crash the kernel as the BUG()
>>> is included in the ASSERT macro. Therefore, add CACHEFILES_ASSERT to
>>> control it.
>>>
>>> Signed-off-by: WoZ1zh1 <wozizhi@huawei.com>
>>> ---
>>>   fs/cachefiles/Kconfig    | 11 +++++++++++
>>>   fs/cachefiles/internal.h |  2 +-
>>>   2 files changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/cachefiles/Kconfig b/fs/cachefiles/Kconfig
>>> index 8df715640a48..83d8ec3ba2d8 100644
>>> --- a/fs/cachefiles/Kconfig
>>> +++ b/fs/cachefiles/Kconfig
>>> @@ -38,3 +38,14 @@ config CACHEFILES_ONDEMAND
>>>         and is delegated to userspace.
>>>         If unsure, say N.
>>> +
>>> +config CACHEFILES_ASSERT
>>> +    bool "CACHEFILES asserts"
>>> +    default n
>>> +    depends on CACHEFILES
>>> +    help
>>> +      Support the ASSERT mode for failure behavior.
>>> +      Say N here to disable the ASSERT by default.
>>> +      Say Y to add assertion checks in some places. But the assertion
>>> +      failure will result in fatal errors that BUG() the kernel.
>>> +
>>> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
>>> index 2ad58c465208..263b1f13e943 100644
>>> --- a/fs/cachefiles/internal.h
>>> +++ b/fs/cachefiles/internal.h
>>> @@ -425,7 +425,7 @@ do {                            \
>>>   #define _debug(FMT, ...) no_printk(FMT, ##__VA_ARGS__)
>>>   #endif
>>> -#if 1 /* defined(__KDEBUGALL) */
>>> +#ifdef CONFIG_CACHEFILES_ASSERT
>>>   #define ASSERT(X)                            \
>>>   do {                                    \

