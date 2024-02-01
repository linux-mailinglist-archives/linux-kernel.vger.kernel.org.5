Return-Path: <linux-kernel+bounces-47549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE486844F3E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E919B25D81
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433B439AFE;
	Thu,  1 Feb 2024 02:52:56 +0000 (UTC)
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 95D531E89B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 02:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706755975; cv=none; b=oHh7Ej2jvSnnNiGZI/rO15gct14LQsfNBahc0nyyAZRH6UKJMjcDC2ZUar2d1ZYGlDOWJzpEpXnhLxgnqkFHqyMhLphXD+xsnuJIruPVhH75bhRVKJdqXN0kXp2bdCJYPucMGQglRhiLR+lbF1b5AR9mThq2os9oa/ybrOZlnKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706755975; c=relaxed/simple;
	bh=M9s+Wv4rdw7a0i7+ZTyNHuRaQaFyBoxaKf72Yw3ZR50=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:From:In-Reply-To:
	 Content-Type; b=iHbjGz4thT1AgHUIKx2+fcQJU6WioPgDrhcmcqssu57uDZmvO62MU0eFuJQXWBAMVL0LjLHYNckwT+sYN+kzzgdbDUjSKJZUKZ+9xFOk3UNWH4digjXA3hy4jxwGlVLDXa2g/1RXUfhCZK45F4ifqfvmIvNY/SH4aFWB4w0ZGOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=didichuxing.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=didichuxing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.64.13])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id E47E018A0053BB;
	Thu,  1 Feb 2024 10:52:48 +0800 (CST)
Received: from [172.24.140.10] (10.79.71.101) by
 ZJY01-ACTMBX-03.didichuxing.com (10.79.64.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 10:52:48 +0800
Message-ID: <c8a1b948-4e03-418b-94b9-c35045b8f886@didichuxing.com>
Date: Thu, 1 Feb 2024 10:52:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [sched/eevdf] 2227a957e1:
 BUG:kernel_NULL_pointer_dereference,address
Content-Language: en-US
To: Oliver Sang <oliver.sang@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, <aubrey.li@linux.intel.com>,
	<yu.c.chen@intel.com>, Tiwei Bie <tiwei.btw@antgroup.com>, Abel Wu
	<wuyun.abel@bytedance.com>
X-MD-Sfrom: wanghonglei@didiglobal.com
X-MD-SrcIP: 10.79.64.13
From: Honglei Wang <wanghonglei@didichuxing.com>
In-Reply-To: <Zbr51SNYUpH2J+3z@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZJY02-PUBMBX-01.didichuxing.com (10.79.65.31) To
 ZJY01-ACTMBX-03.didichuxing.com (10.79.64.13)



On 2024/2/1 09:54, Oliver Sang wrote:
> hi, Honglei,
> 
> On Thu, Feb 01, 2024 at 09:29:30AM +0800, Honglei Wang wrote:
>>
>>
>> On 2024/1/30 22:09, Oliver Sang wrote:
>>> hi, Abel,
>>>
>>> On Tue, Jan 30, 2024 at 06:13:32PM +0800, Abel Wu wrote:
>>>> On 1/30/24 3:24 PM, kernel test robot Wrote:
>>>>>
>>>>>
>>>>> Hello,
>>>>>
>>>>> (besides a previous performance report),
>>>>> kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
>>>>>
>>>>> commit: 2227a957e1d5b1941be4e4207879ec74f4bb37f8 ("sched/eevdf: Sort the rbtree by virtual deadline")
>>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>>>
>>>>> [test failed on linus/master 3a5879d495b226d0404098e3564462d5f1daa33b]
>>>>> [test failed on linux-next/master 01af33cc9894b4489fb68fa35c40e9fe85df63dc]
>>>>>
>>>>> in testcase: trinity
>>>>> version: trinity-i386-abe9de86-1_20230429
>>
>> Hi Oliver,
>>
>> I'm a bit curious, did the problem happen on i386 only? Did you hit it on
>> x86_64 or other platform with the same trinity testcases?
> 
> we did not observe same issue on x86_64 so far.
> 
> we can run performance tests with this commit on x86_64 (compiled with gcc-12).
> FYI, we sent out a performance report before this crash one.
> 
> https://lore.kernel.org/all/202401292151.829b01b0-oliver.sang@intel.com/
> 

Thanks for the feedback. The performance improvement is as expected. I 
assume the panic is not introduced by 2227a957e1. We don't know where 
the "EEVDF scheduling fail, picking leftmost" messages come from even 
before this patch.

It would be great if we can find a way to reproduce the problem. Seems 
it's worth a try on VM with fewer cpus and a bit more syscall workload 
like testcase trinity.

>>
>> Thanks,
>> Honglei

