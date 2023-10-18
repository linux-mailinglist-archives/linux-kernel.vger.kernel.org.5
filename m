Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6393F7CDB8B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjJRM0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjJRM0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:26:42 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF201A3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:26:40 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6ba8eb7e581so1029930b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697632000; x=1698236800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aZdIDg1uk+mrpxscqst75VrD7yEmNFKRl+XP6ji4o3g=;
        b=JKmDg6pfucnhXZqQj4Djuxrq4lQSMVT+aUq89Pc8vLWJ6QMevgxWSGKTpAi9LxMtU5
         ZdgUx7BWPea3YvqAArgFmTQAE2C388Hg7zuFWNE3L4wkxthiJqN8TSrENwS12j7lxF9A
         0TEmlHwKhC2+HeQLzslooyH9zj2Fpm1340K8P8v67znkZw40LhjGglCSdkwIUjr9JB1i
         aBBkzWiRg5xqYlrhylKH4DS2cCmGBhCAoiCV+WCI5jsKm/XYzRrdVN1Zfw0+nvMMIJC7
         xCI/n4ukEL/zxQsnjymkuoR4eixMu13cf6Q/uq/Bir4t+C/HwZczrzmzL3AqlZSvMnfL
         z6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632000; x=1698236800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aZdIDg1uk+mrpxscqst75VrD7yEmNFKRl+XP6ji4o3g=;
        b=Tk++NZlTfNjXni9Tjql7tBQlL1TkyPE55NrlsWVzmOdLqlVKPap63sUBR/ETYv1mJr
         j60HHgHbERFuIyZof46nNyAjT3fyZ00NbLnBSzPpEUsNes99+AQwc6Ad3AZpXHlOuznf
         41IiVu9Qlvlfn3wu7SGOgsPwKijssvDUhPELjcyTB/q5V/vJ6HvL7wm9bN0/TXPQQf1n
         XxZgk8QPSFTwIEiT28sAJhrhzcjKLVyMpo3KKQg31yUnpsctUMgkLv1XYjDsNEWJZrdX
         HD3qQOq6tfdikbOEiXE6w1TUiESBny/poLTja3BJugtFb3Bd/smc+Nhuqz1X0kvTyUZD
         FTnA==
X-Gm-Message-State: AOJu0YxZNa/LdihA94ZbsL12WI1KaDHdoe7S1ft1hcWuLDzNwibl/TGj
        XADfr0jkYUnxcBDq9jQQ5nYueQ==
X-Google-Smtp-Source: AGHT+IFbq99pKP3vQECYPULdpzMOKLMJaET5wq8NDg7QLtnUkjybSD0w+808CEgKHJtcxeLbUyLrMg==
X-Received: by 2002:a05:6a20:d80d:b0:163:ab09:193e with SMTP id iv13-20020a056a20d80d00b00163ab09193emr4983608pzb.1.1697632000162;
        Wed, 18 Oct 2023 05:26:40 -0700 (PDT)
Received: from [10.84.155.153] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id m10-20020a654c8a000000b005acd5d7e11bsm1409852pgt.35.2023.10.18.05.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 05:26:39 -0700 (PDT)
Message-ID: <605cc166-e731-e7d1-25d7-b6797a802e6f@bytedance.com>
Date:   Wed, 18 Oct 2023 20:26:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2] x86/mm: Drop 4MB restriction on minimal NUMA node
 memory size
To:     Ingo Molnar <mingo@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231017062215.171670-1-rppt@kernel.org>
 <ZS+2qqjEO5/867br@gmail.com>
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <ZS+2qqjEO5/867br@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 2023/10/18 18:42, Ingo Molnar wrote:
> 
> * Mike Rapoport <rppt@kernel.org> wrote:
> 
>> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>>
>> Qi Zheng reports crashes in a production environment and provides a
>> simplified example as a reproducer:
>>
>>    For example, if we use qemu to start a two NUMA node kernel,
>>    one of the nodes has 2M memory (less than NODE_MIN_SIZE),
>>    and the other node has 2G, then we will encounter the
>>    following panic:
>>
>>    [    0.149844] BUG: kernel NULL pointer dereference, address: 0000000000000000
>>    [    0.150783] #PF: supervisor write access in kernel mode
>>    [    0.151488] #PF: error_code(0x0002) - not-present page
>>    <...>
>>    [    0.156056] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
>>    <...>
>>    [    0.169781] Call Trace:
>>    [    0.170159]  <TASK>
>>    [    0.170448]  deactivate_slab+0x187/0x3c0
>>    [    0.171031]  ? bootstrap+0x1b/0x10e
>>    [    0.171559]  ? preempt_count_sub+0x9/0xa0
>>    [    0.172145]  ? kmem_cache_alloc+0x12c/0x440
>>    [    0.172735]  ? bootstrap+0x1b/0x10e
>>    [    0.173236]  bootstrap+0x6b/0x10e
>>    [    0.173720]  kmem_cache_init+0x10a/0x188
>>    [    0.174240]  start_kernel+0x415/0x6ac
>>    [    0.174738]  secondary_startup_64_no_verify+0xe0/0xeb
>>    [    0.175417]  </TASK>
>>    [    0.175713] Modules linked in:
>>    [    0.176117] CR2: 0000000000000000
>>
>> The crashes happen because of inconsistency between nodemask that has
>> nodes with less than 4MB as memoryless and the actual memory fed into
>> core mm.
> 
> Presumably the core MM got fixed too to not just crash, but provide some
> sort of warning?
> 
>> The commit 9391a3f9c7f1 ("[PATCH] x86_64: Clear more state when ignoring
>> empty node in SRAT parsing") that introduced minimal size of a NUMA node
>> does not explain why a node size cannot be less than 4MB and what boot
>> failures this restriction might fix.
>>
>> Since then a lot has changed and core mm won't confuse badly about small
>> node sizes.
> 
> Core MM won't get confused ... other than by the above weird Qemu topology,
> to which it responds with a ... NULL pointer dereference?
> 
> Seems quite close to the literal definition of 'get confused badly' to me,
> and doesn't give me the warm fuzzy feeling that giving the core MM even
> *more* weird topologies is super safe ... :-/
> 
>> Drop the limitation for the minimal node size.
> 
> While I agree with dropping the limitation, and I agree that 9391a3f9c7f1
> should have provided more of a justification, I believe a core MM fix is in
> order as well, for it to not crash. [ If it's fixed upstream already,
> please reference the relevant commit ID. ]

Agree. I posted a fixed patchset[1] before, maybe we can reconsider
it. :)

[1]. 
https://lore.kernel.org/lkml/20230215152412.13368-1-zhengqi.arch@bytedance.com/

For memoryless node, this patchset skip it and fallback to other nodes
when build its zonelists.

Say we have node0 and node1, and node0 is memoryless, then:

[    0.102400] Fallback order for Node 0: 1
[    0.102931] Fallback order for Node 1: 1

In this way, we will not allocate pages from memoryless node0. Then
the crash problem under the weird Qemu topology will be fixed.

Thanks,
Qi

> 
> Also, the changelog spelling & general presentation were quite low quality
> - I've fixed it up a bit below, please carry this version going forward.
> Please spell-check your patches before sending out Nth versions of it,
> maybe maintainers are skipping them for a reason!
> 
> Thanks,
> 
> 	Ingo
> 
> =================>
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> Date: Tue, 17 Oct 2023 09:22:15 +0300
> Subject: [PATCH] x86/mm: Drop 4MB restriction on minimal NUMA node memory size
> 
> Qi Zheng reported crashes in a production environment and provided a
> simplified example as a reproducer:
> 
>   |  For example, if we use qemu to start a two NUMA node kernel,
>   |  one of the nodes has 2M memory (less than NODE_MIN_SIZE),
>   |  and the other node has 2G, then we will encounter the
>   |  following panic:
>   |
>   |    BUG: kernel NULL pointer dereference, address: 0000000000000000
>   |    <...>
>   |    RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
>   |    <...>
>   |    Call Trace:
>   |      <TASK>
>   |      deactivate_slab()
>   |      bootstrap()
>   |      kmem_cache_init()
>   |      start_kernel()
>   |      secondary_startup_64_no_verify()
> 
> The crashes happen because of inconsistency between the nodemask that
> has nodes with less than 4MB as memoryless, and the actual memory fed
> into the core mm.
> 
> The commit:
> 
>    9391a3f9c7f1 ("[PATCH] x86_64: Clear more state when ignoring empty node in SRAT parsing")
> 
> ... that introduced minimal size of a NUMA node does not explain why
> a node size cannot be less than 4MB and what boot failures this
> restriction might fix.
> 
> In the 17 years since then a lot has changed and core mm won't get
> confused about small node sizes.
> 
> Drop the limitation for the minimal node size.
> 
> [ mingo: Improved changelog clarity. ]
> 
> Reported-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Not-Yet-Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Link: https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/
> ---
>   arch/x86/include/asm/numa.h | 7 -------
>   arch/x86/mm/numa.c          | 7 -------
>   2 files changed, 14 deletions(-)
> 
> diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
> index e3bae2b60a0d..ef2844d69173 100644
> --- a/arch/x86/include/asm/numa.h
> +++ b/arch/x86/include/asm/numa.h
> @@ -12,13 +12,6 @@
>   
>   #define NR_NODE_MEMBLKS		(MAX_NUMNODES*2)
>   
> -/*
> - * Too small node sizes may confuse the VM badly. Usually they
> - * result from BIOS bugs. So dont recognize nodes as standalone
> - * NUMA entities that have less than this amount of RAM listed:
> - */
> -#define NODE_MIN_SIZE (4*1024*1024)
> -
>   extern int numa_off;
>   
>   /*
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index c01c5506fd4a..aa39d678fe81 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -602,13 +602,6 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
>   		if (start >= end)
>   			continue;
>   
> -		/*
> -		 * Don't confuse VM with a node that doesn't have the
> -		 * minimum amount of memory:
> -		 */
> -		if (end && (end - start) < NODE_MIN_SIZE)
> -			continue;
> -
>   		alloc_node_data(nid);
>   	}
>   
