Return-Path: <linux-kernel+bounces-86092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA1786BF75
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72BDC28712E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA98374DE;
	Thu, 29 Feb 2024 03:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="S3mhBtTV"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CEE37169
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 03:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709177207; cv=none; b=lruMqMka/Xsi5aWi0QcdfkGpm27ApS9RbtJSlxZYtVHQawBIkQ+yA368mE6rjEEXifhDIV0l8U2YBl94zbbdilLO2nGvuIRx7plXekAvNjo4i4WCsjPPnR9JOWiWaxpsfCyeNNEIV5nAz0iFEPG5BzFVIxgcPFWlj9b69dA4JGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709177207; c=relaxed/simple;
	bh=Nw6NLLnwA9HUVDQnXd3noo9BkuEledA01hC0D2Y5vNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8+8+eezzrQabLmV1Fk6lCR1eetWZEo6s+yUWerAgbtVegRu/hSMyYJgsVNI5YnRnZJOUUXZtL3deSAZHfUK6WI/pD1DTyKap7+aAuDzgG1XKm88a9AQpHeuoXyGESN51LLvURv8t9eSEJx0WN7eqsV0UpPODxUlzYvjJ9edOQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=S3mhBtTV; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709177197; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xlpZ40fyxUbubbTrqSw9nnznE3ry+hnF/QQY7Ns4xkk=;
	b=S3mhBtTVdn0z+wnOIVXE4sf5wSwu2nqW3dZr5mJVdowASbAYl+aSJwflbH9N0ypVsMohjj224Xm7P9C7AMSJahkWKbK1d/dNJ6ZIV6BstkWm65Y8iwYqZDsqD3N3yZKK6Qjr6cOJy2UyWtPMy4kfN8CTF1FqeEEYbapAa/piLCc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W1RUjY4_1709177194;
Received: from 30.240.97.87(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0W1RUjY4_1709177194)
          by smtp.aliyun-inc.com;
          Thu, 29 Feb 2024 11:26:36 +0800
Message-ID: <0e14358e-334c-4f7c-be36-7205ad2bb21d@linux.alibaba.com>
Date: Thu, 29 Feb 2024 11:26:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] support NUMA emulation for genertic arch
To: Pierre Gondois <pierre.gondois@arm.com>, Mike Rapoport <rppt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, akpm@linux-foundation.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com,
 luto@kernel.org, teng.ma@linux.alibaba.com
References: <20231012024842.99703-1-rongwei.wang@linux.alibaba.com>
 <20240220113602.6943-1-rongwei.wang@linux.alibaba.com>
 <ZdWUPlqsxC_y3YFM@kernel.org> <6843f6b2-4c41-4649-9885-88fde7215e3f@arm.com>
Content-Language: en-US
From: Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <6843f6b2-4c41-4649-9885-88fde7215e3f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/21/24 11:51 PM, Pierre Gondois wrote:
>
>
> On 2/21/24 07:12, Mike Rapoport wrote:
>> On Tue, Feb 20, 2024 at 07:36:00PM +0800, Rongwei Wang wrote:
>>> A brief introduction
>>> ====================
>>>
>>> The NUMA emulation can fake more node base on a single
>>> node system, e.g.
>>
>> ...
>>> Lastly, it seems not a good choice to realize x86 and other genertic
>>> archs separately. But it can indeed avoid some architecture related
>>> APIs adjustments and alleviate future maintenance.
>>
>> Why is it a good choice? Copying 1k lines from x86 to a new place and
>> having to maintain two copies does not sound like a good choice to me.
Hi Pierre
> I agree it would be better to avoid duplication and extract the common
> code from the original x86 implementation. The RFC seemed to go more
> in this direction.
> Also NITs:
> - genertic -> generic
Thanks, my fault, zhaoyu also found this (thanks).
> - there is a 'ifdef CONFIG_X86' in drivers/base/numa_emulation.c,
>   but the file should not be used by x86 as the arch doesn't set
>   CONFIG_GENERIC_ARCH_NUMA
>
Actually, I have not think about how to ask the question. I'm also try 
to original direction like RFC version, but found much APIs need to be 
updated, and there are many APIs are similar but a little difference. 
That seems much modification needed in more than one arch if go in 
original direction.

But if all think original method is right, I will continue it in RFC 
version.

Thanks for your time to review.
> Regards,
> Pierre
>
>>
>>> The previous RFC link see [1].
>>>
>>> Any advice are welcome, Thanks!
>>>
>>> Change log
>>> ==========
>>>
>>> RFC v1 -> v1
>>> * add new CONFIG_NUMA_FAKE for genertic archs.
>>> * keep x86 implementation, realize numa emulation in driver/base/ for
>>>    genertic arch, e.g, arm64.
>>>
>>> [1] RFC v1: 
>>> https://patchwork.kernel.org/project/linux-arm-kernel/cover/20231012024842.99703-1-rongwei.wang@linux.alibaba.com/
>>>
>>> Rongwei Wang (2):
>>>    arch_numa: remove __init for early_cpu_to_node
>>>    numa: introduce numa emulation for genertic arch
>>>
>>>   drivers/base/Kconfig          |   9 +
>>>   drivers/base/Makefile         |   1 +
>>>   drivers/base/arch_numa.c      |  32 +-
>>>   drivers/base/numa_emulation.c | 909 
>>> ++++++++++++++++++++++++++++++++++
>>>   drivers/base/numa_emulation.h |  41 ++
>>>   include/asm-generic/numa.h    |   2 +-
>>>   6 files changed, 992 insertions(+), 2 deletions(-)
>>>   create mode 100644 drivers/base/numa_emulation.c
>>>   create mode 100644 drivers/base/numa_emulation.h
>>>
>>> -- 
>>> 2.32.0.3.gf3a3e56d6
>>>
>>>
>>

-- 
Thanks,
-wrw


