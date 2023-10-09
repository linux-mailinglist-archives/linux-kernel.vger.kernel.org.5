Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193917BD917
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346151AbjJIK6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346159AbjJIK6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:58:42 -0400
Received: from out-190.mta0.migadu.com (out-190.mta0.migadu.com [91.218.175.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DE4EB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:58:40 -0700 (PDT)
Message-ID: <078f662d-a73f-766b-3a07-c82cd37026c5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696849118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Av797t4dNKwG+wqfE+a/y9KCDOqvnvEdbCJ5Vx3i870=;
        b=a0E96JbiIRUyr8kY6MLTFtyZD2JisWG5Z99r291YdCB/sA+9C95xpPHYIAFDuYrAKHxVw/
        VBzt4GQCWFGkGwPFJgpHq/brUy2mq0076TvrN4TuHPx++JScChCtAhUqLG0DnxsA3r92tT
        QK54+aT2duzdyTkkS3ijpXRVZm7O0r0=
Date:   Mon, 9 Oct 2023 18:58:27 +0800
MIME-Version: 1.0
Subject: Re: [PATCH net-next v7] net/core: Introduce netdev_core_stats_inc()
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, mark.rutland@arm.com,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231007050621.1706331-1-yajun.deng@linux.dev>
 <917708b5-cb86-f233-e878-9233c4e6c707@linux.dev>
 <CANn89i+navyRe8-AV=ehM3qFce2hmnOEKBqvK5Xnev7KTaS5Lg@mail.gmail.com>
 <a53a3ff6-8c66-07c4-0163-e582d88843dd@linux.dev>
 <CANn89i+u5dXdYm_0_LwhXg5Nw+gHXx+nPUmbYhvT=k9P4+9JRQ@mail.gmail.com>
 <9f4fb613-d63f-9b86-fe92-11bf4dfb7275@linux.dev>
 <CANn89iK7bvQtGD=p+fHaWiiaNn=u8vWrt0YQ26pGQY=kZTdfJw@mail.gmail.com>
 <4a747fda-2bb9-4231-66d6-31306184eec2@linux.dev>
 <814b5598-5284-9558-8f56-12a6f7a67187@linux.dev>
 <CANn89iJCTgWTu0mzwj-8_-HiWm4uErY=VASDHoYaod9Nq-ayPA@mail.gmail.com>
 <508b33f7-3dc0-4536-21f6-4a5e7ade2b5c@linux.dev>
 <CANn89i+r-pQGpen1mUhybmj+6ybhxSsuoaB07NFzOWyHUMFDNw@mail.gmail.com>
 <296ca17d-cff0-2d19-f620-eedab004ddde@linux.dev>
 <CANn89iL=W3fyuH_KawfhKvLyw2Cw=qhHbEZtbKgQEYhHJChy3Q@mail.gmail.com>
 <68eb65c5-1870-0776-0878-694a8b002a6d@linux.dev>
 <CANn89iJHtYJjp6zPc2PVLAWuN88BQc5OntjrAf7f6QOcqP+B=g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <CANn89iJHtYJjp6zPc2PVLAWuN88BQc5OntjrAf7f6QOcqP+B=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/9 18:16, Eric Dumazet wrote:
> On Mon, Oct 9, 2023 at 11:43 AM Yajun Deng <yajun.deng@linux.dev> wrote:
>>
>> On 2023/10/9 17:30, Eric Dumazet wrote:
>>> On Mon, Oct 9, 2023 at 10:36 AM Yajun Deng <yajun.deng@linux.dev> wrote:
>>>> On 2023/10/9 16:20, Eric Dumazet wrote:
>>>>> On Mon, Oct 9, 2023 at 10:14 AM Yajun Deng <yajun.deng@linux.dev> wrote:
>>>>>> On 2023/10/9 15:53, Eric Dumazet wrote:
>>>>>>> On Mon, Oct 9, 2023 at 5:07 AM Yajun Deng <yajun.deng@linux.dev> wrote:
>>>>>>>
>>>>>>>> 'this_cpu_read + this_cpu_write' and 'pr_info + this_cpu_inc' will make
>>>>>>>> the trace work well.
>>>>>>>>
>>>>>>>> They all have 'pop' instructions in them. This may be the key to making
>>>>>>>> the trace work well.
>>>>>>>>
>>>>>>>> Hi all,
>>>>>>>>
>>>>>>>> I need your help on percpu and ftrace.
>>>>>>>>
>>>>>>> I do not think you made sure netdev_core_stats_inc() was never inlined.
>>>>>>>
>>>>>>> Adding more code in it is simply changing how the compiler decides to
>>>>>>> inline or not.
>>>>>> Yes, you are right. It needs to add the 'noinline' prefix. The
>>>>>> disassembly code will have 'pop'
>>>>>>
>>>>>> instruction.
>>>>>>
>>>>> The function was fine, you do not need anything like push or pop.
>>>>>
>>>>> The only needed stuff was the call __fentry__.
>>>>>
>>>>> The fact that the function was inlined for some invocations was the
>>>>> issue, because the trace point
>>>>> is only planted in the out of line function.
>>>> But somehow the following code isn't inline? They didn't need to add the
>>>> 'noinline' prefix.
>>>>
>>>> +               field = (unsigned long *)((void *)this_cpu_ptr(p) + offset);
>>>> +               WRITE_ONCE(*field, READ_ONCE(*field) + 1);
>>>>
>>>> Or
>>>> +               (*(unsigned long *)((void *)this_cpu_ptr(p) + offset))++;
>>>>
>>> I think you are very confused.
>>>
>>> You only want to trace netdev_core_stats_inc() entry point, not
>>> arbitrary pieces of it.
>>
>> Yes, I will trace netdev_core_stats_inc() entry point. I mean to replace
>>
>> +                                       field = (__force unsigned long
>> __percpu *)((__force void *)p + offset);
>> +                                       this_cpu_inc(*field);
>>
>> with
>>
>> +               field = (unsigned long *)((void *)this_cpu_ptr(p) + offset);
>> +               WRITE_ONCE(*field, READ_ONCE(*field) + 1);
>>
>> Or
>> +               (*(unsigned long *)((void *)this_cpu_ptr(p) + offset))++;
>>
>> The netdev_core_stats_inc() entry point will work fine even if it doesn't
>> have 'noinline' prefix.
>>
>> I don't know why this code needs to add 'noinline' prefix.
>> +               field = (__force unsigned long __percpu *)((__force void *)p + offset);
>> +               this_cpu_inc(*field);
>>
> C compiler decides to inline or not, depending on various factors.
>
> The most efficient (and small) code is generated by this_cpu_inc()
> version, allowing the compiler to inline it.
>
> If you copy/paste this_cpu_inc()  twenty times, then the compiler
> would  not inline the function anymore.


Got it. Thank you.

