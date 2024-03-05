Return-Path: <linux-kernel+bounces-92299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA03871E16
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7EC28748B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA1B57333;
	Tue,  5 Mar 2024 11:38:56 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A667854905;
	Tue,  5 Mar 2024 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638736; cv=none; b=g2ElHneyd0WLpYAnTjb9umqQd+DesWRCdS0lQuH2FoTa3zUTmSFPzMEzYpi5tJYpKbpmVu271A0HJTt2/g3mdTVBnkHaxWzff3GkgEN8+37qReyq3ep6WPqJ9eJBH9vkKnQBcFMfub/p6xbQPlRrFhvpe/7sZFHswhlF0w14NuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638736; c=relaxed/simple;
	bh=ESIQQK1CBZ0tuFJ0FmUUdt0XhpiOl/97OyiFWo+h6g0=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=o3h8EAVUDw5UYhpNuyujdGmHOoeJEQCRdrby7EccHhuAODwGjxRlN+5oPillHXms4ckP4OMQ+Q8P3iOiOyhbp6zI3aANeqcDEVJHKV2riwIzzSV9Zv+q01dTarwx9Dpcj/SF8ozSlVx/SlTySjqBLBlo/iwdRvF3LSF4okO1Azk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TptnG4ZB0zwPDy;
	Tue,  5 Mar 2024 19:36:34 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C24F1400C8;
	Tue,  5 Mar 2024 19:38:51 +0800 (CST)
Received: from [10.67.111.82] (10.67.111.82) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 5 Mar
 2024 19:38:50 +0800
Subject: Re: [PATCH] usercopy: delete __noreturn from usercopy_abort
To: Kees Cook <keescook@chromium.org>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <CAG48ez1h9X7Qv-5OR6hAhwnSOng6_PSXBaR6cT7xrk2Wzu39Yg@mail.gmail.com>
 <202403040938.D770633@keescook>
 <77bb0d81-f496-7726-9495-57088a4c0bfc@huawei.com>
 <202403050129.5B72ACAA0D@keescook>
CC: Jann Horn <jannh@google.com>, <gustavoars@kernel.org>,
	<akpm@linux-foundation.org>, <jpoimboe@kernel.org>, <peterz@infradead.org>,
	<dave.hansen@linux.intel.com>, <kirill.shutemov@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	<linux-mm@kvack.org>, <nixiaoming@huawei.com>, <kepler.chenxin@huawei.com>,
	<wangbing6@huawei.com>, <wangfangpeng1@huawei.com>, <douzhaolei@huawei.com>
From: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Message-ID: <b274b545-9439-7ff8-e3ed-604a9ac81f65@huawei.com>
Date: Tue, 5 Mar 2024 19:38:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202403050129.5B72ACAA0D@keescook>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)



On 2024/3/5 17:32, Kees Cook wrote:
> On Tue, Mar 05, 2024 at 11:31:06AM +0800, Jiangfeng Xiao wrote:
>>
>>
>> On 2024/3/5 1:40, Kees Cook wrote:
>>> On Mon, Mar 04, 2024 at 04:15:07PM +0100, Jann Horn wrote:
>>>> On Mon, Mar 4, 2024 at 3:02 AM Jiangfeng Xiao <xiaojiangfeng@huawei.com> wrote:
>>>>> When the last instruction of a noreturn function is a call
>>>>> to another function, the return address falls outside
>>>>> of the function boundary. This seems to cause kernel
>>>>> to interrupt the backtrace.
>>>
>>> FWIW, all email from huawei.com continues to get eaten by anti-spam
>>> checking. I've reported this a few times -- it'd be really nice if the
>>> domain configuration could get fixed.
>>>
>>>> [...]
>>>>> Delete __noreturn from usercopy_abort,
>>>>
>>>> This sounds like the actual bug is in the backtracing logic? I don't
>>>> think removing __noreturn annotations from an individual function is a
>>>> good fix, since the same thing can happen with other __noreturn
>>>> functions depending on what choices the compiler makes.
>>>
>>> Yeah, NAK. usercopy_abort() doesn't return. It ends with BUG().
>>>
>> When the user directly or indirectly calls usercopy_abort,
>> the final call stack is incorrect, and the
>> code where the problem occurs cannot be located.
>> In this case, the user will be frustrated.
> 
> Can you please give an example of this?

The main configurations of my kernel are as follows:

CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is enabled.
(This config uses the compilation parameter -O2.)

CONFIG_RELOCATABLE is disabled.
(This config uses the compilation option -fpic.)

You can use the following kernel module testcase
to reproduce this problem on the ARM32 platform.

```
#include <linux/module.h>
#include <linux/sched.h>

static volatile size_t unconst = 0;
/*
check_object_size
    __check_object_size
        check_kernel_text_object
            usercopy_abort("kernel text", ...)
*/
void test_usercopy_kernel(void)
{
        check_object_size(schedule, unconst + PAGE_SIZE, 1);
}

static int __init test_usercopy_init(void)
{
        test_usercopy_kernel();
        return 0;
}

static void __exit test_usercopy_exit(void)
{
}

module_init(test_usercopy_init);
module_exit(test_usercopy_exit);
MODULE_LICENSE("GPL");
```

> 
>> For the usercopy_abort function, whether '__noreturn' is added
>> does not affect the internal behavior of the usercopy_abort function.
>> Therefore, it is recommended that '__noreturn' be deleted
>> so that backtrace can work properly.
> 
> This isn't acceptable. Removing __noreturn this will break
> objtool's processing of execution flow for livepatching, IBT, and
> KCFI instrumentation. These all depend on an accurate control flow
> descriptions, and usercopy_abort is correctly marked __noreturn.
> 

Thank you for providing this information.
I'll go back to further understand how __noreturn is used
in features such as KCFI and livepatching.

