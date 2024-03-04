Return-Path: <linux-kernel+bounces-90029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB6986F910
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB551F20F9C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1EA539E;
	Mon,  4 Mar 2024 03:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MYYwUZT7"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89A34A34
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 03:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709523806; cv=none; b=d3DKW63zs+qPui/JPtYWUxRIOgnxq/l2bibi7B/PFvvBWz0ceZ68aUh9ALIMU8wYtXIM5cv+y0BOMyRIwQ0AWXhjRV5xkBSvABZBkTHeugGq1UV40OEUuWpirGfZh10k1gionT7Pixws82QZOkD+cGlXu+PgicSkvmCZ+uJzG4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709523806; c=relaxed/simple;
	bh=WQdAjRAvd8yoUf68adlmp9MGoVa20z28kX5tHVe7lqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pt4zr3wN3GSftv7KGxP4AhJsny2SN3Pw4py22raXbo95uONoxxKRlIwW5INkeQanrC4CVBkxLrh69ZbG/SHtLnA6+f4Wp+Gy7aFUgDKpwgFVn8b/uQ6M3WoJCn4Nvs/pWUNTfioxarQ7uq2p2iqjVkom1UJrWY44nqgITWFqJWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=MYYwUZT7; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.187] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4243gVoE348953
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 3 Mar 2024 19:42:31 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4243gVoE348953
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024021201; t=1709523752;
	bh=kxK3n3B02k0LufS4sQ2boXcylT29zMPGAu21KJsxq+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MYYwUZT7OL67/hxy3KZBJ31D6Hai+1BwyQP3xEzwDmx33eOA05S5wkQIhYo94FiyX
	 MH3Fldufn0+SFQkhyL8MYA31pVXi8Fa7gnr0/jEyJP7iGehmJmk1C91ZIpKEabUPLE
	 UJme0Gyvn5ZfBylOYTBWk4TsoooBQpNmnHHzpuWSO50HPAtQ/ISWCUrpjmNyMVv7DM
	 fsMyxw4WWe+J61faEY2QBOKl4Tr7KRc/FMEM4vyggGza2qo/LRyPEAn6xsd1iNuvjT
	 uhXrb6IxmOJD8SyQIcxzaBOeLvZgOd6sZJC4SzrsOdRkpL7A0HEFM4Ql9ySOcGvlyt
	 6uyR5BhdVNrsA==
Message-ID: <382e966b-4cac-4e28-a230-53ac52f91bf9@zytor.com>
Date: Sun, 3 Mar 2024 19:42:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] x86/fred: Fix init_task thread stack pointer
 initialization
Content-Language: en-US
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com
References: <20240301084046.3370376-1-xin@zytor.com>
 <CAMzpN2j7xKcGx=+z8mu_2z2RsqjB-mpODdrOH7N1J2_OzuyEUQ@mail.gmail.com>
 <c4fb7c39-c99c-4e4c-bd85-470f5d0dc4dd@zytor.com>
 <CAMzpN2jpRov_zVp+8qXybS6dtm57uk1pfvRUUKeFGVGnC2G_Wg@mail.gmail.com>
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <CAMzpN2jpRov_zVp+8qXybS6dtm57uk1pfvRUUKeFGVGnC2G_Wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/2/2024 5:20 AM, Brian Gerst wrote:
> On Fri, Mar 1, 2024 at 11:18 PM Xin Li <xin@zytor.com> wrote:
>>
>> On 3/1/2024 5:15 AM, Brian Gerst wrote:
>>> On Fri, Mar 1, 2024 at 3:41 AM Xin Li (Intel) <xin@zytor.com> wrote:
>>> There is another spot in head_64.S that also needs this offset:
>>
>> I checked all references to __end_init_task before sending out this
>> patch, and I doubt we need to make more similar changes.
>>
>> First of all, "movq    TASK_threadsp(%rcx), %rsp" you added in
>> 3adee777ad0d ("x86/smpboot: Remove initial_stack on 64-bit") is exactly
>> what we need to set up %rsp for the init task.
>>
>>> /* Set up the stack for verify_cpu() */
>>> leaq (__end_init_task - PTREGS_SIZE)(%rip), %rsp
>>
>> As the comment says, it's a _temporary_ stack for calling verify_cpu()
>> (but only for BSP, as APs use a different bring up stack), at which
>> stage the concept of "task" has not formed. I'm thinking maybe it's
>> better to do:
>>
>> /* Set up the stack for verify_cpu() */
>> leaq __end_init_task(%rip), %rsp
>>
>> Previously it was "leaq    (__end_init_task - FRAME_SIZE)(%rip), %rsp",
>> but the kernel unwinder goes up only to secondary_startup_64_no_verify()
>> after the new way you introduced to set up %rsp for the init task, and
>> it seems to me that there is no point to subtract FRAME_SIZE or
>> PTREGS_SIZE.
>>
>> On the other hand, TOP_OF_KERNEL_STACK_PADDING is required for x86_32,
>> but probably not for x86_64 (defined as 0 before FRED). The most
>> important usage of TOP_OF_KERNEL_STACK_PADDING is to get the pt_regs
>> pointer for a task, i.e., task_pt_regs(task), which assumes a fixed
>> offset from the top of a task stack, but also limits the space that
>> could be used by future hardware above the pt_regs structure. Thus I
>> prefer to limit the usage of TOP_OF_KERNEL_STACK_PADDING on x86_64.
> 
> The point is to keep consistency with other kernel threads, which have
> the pt_regs area cleared (see copy_thread()).  In particular, the CS
> field can't have junk in it or else user_mode(regs) could return the
> wrong result.  So the stack needs to start below pt_regs, or we need
> to explicitly zero pt_regs later.

Okay, I will add TOP_OF_KERNEL_STACK_PADDING to the spot in
arch/x86/kernel/head_64.S, plus another spot in arch/x86/xen/xen-head.S.

However, I still think it would be better to not have
TOP_OF_KERNEL_STACK_PADDING in these spots, instead we should explicitly
zero pt_regs later;  any *implicit* protocol is NOT welcome. I will find
a timer later to check with the x86 maintainers :)


> Ideally, the load from thread->sp should just shift RSP by phys_base,
> pointing to the same memory location in the virtual mapping.

I prefer to do this explicitly as what's done now; it may be easier to
understand for future kernel developers.

Thanks!
     Xin

