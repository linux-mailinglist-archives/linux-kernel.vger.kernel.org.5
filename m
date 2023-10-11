Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A514E7C5F3E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344605AbjJKVmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjJKVms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:42:48 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E64AF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:42:46 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7a24c86aae3so5585539f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697060566; x=1697665366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aAaorYPiY+kMdNHIq5KySTKeO7NTcjq7Qa68NYXDN9Q=;
        b=NqBf/CY5Eyvdt/kLIa3f6kRVA8/bp32hFTbFxOD9aqjJwwywOLNTeqKdw6n+SzMB76
         pj612Wf9eg14FrzsYMYScvGPvHQ1dhNinrJZOSGI2AFUH+veIo9Ip7MGxitnscGbItpV
         68BS4ZoI4aGkmCkmzQp37Ov/AXEhX9nVfHsTTWx/W6fxg38icc0MGtjQWHXZpj0kBtf4
         ZKP55yyLg1zT2bNKJaa/aIradhElPVt6uiHQoF0lgFHI+Z5NcZorjbn6FaTqk/o/z3TQ
         mvD0Vv4rrjIkfxkZtM6t/eFYZ3vlN0Ju6bm8s0Mu06gZiP0MlxYSiyLu3DCFO5LNycgs
         Mtag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697060566; x=1697665366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAaorYPiY+kMdNHIq5KySTKeO7NTcjq7Qa68NYXDN9Q=;
        b=ZYIaa+l1YbTDQBdoyX10ZkxwBD4bMDKsspQIfT8m36Hk6y5lZXAwg5wMddf1rn0LTT
         9YxToynBJX5CB1QsF7v6lKbQJgFTsDiaaaYM6PPX1RabzB8qSdR0tXaQQ4G6DOd3c1t8
         jw/WKFqwPGwaLeaEvv5i60Ty4Q7NcBBEA9ONSM4ZjncWa3vZOrq7/pAIpd7J/KZS8QOM
         cczJxGVrxSTSpHDV8pRc27/OY4wBK5YB7u47BT+UkDHbsTN7GyOX/iX+ulfyUS2PKuWR
         G8XEHktOhdseYhH412YQwqwDAjpV8aowD+ObEHbwAa3qpQvQo/tB2O1Ouh99nyhcFmON
         JNrg==
X-Gm-Message-State: AOJu0Yy40yjBSWX0l3AaiLrJCGyHg1qhcC6hIhNjKp++9HphLK6ngv5B
        wE4qQX94hboulvQ1Rjs3poSgtw==
X-Google-Smtp-Source: AGHT+IHV47WAnU++jAQHreME1kKzpHpjX212kFUVkAUN88b6f+mH6cOyt6ZnhRyxeh+YTDsISO3k3w==
X-Received: by 2002:a05:6602:140c:b0:79f:a8c2:290d with SMTP id t12-20020a056602140c00b0079fa8c2290dmr29516543iov.0.1697060565937;
        Wed, 11 Oct 2023 14:42:45 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id o15-20020a6bf80f000000b0079187c8524asm3671196ioh.3.2023.10.11.14.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 14:42:45 -0700 (PDT)
Message-ID: <bf5ecd2d-06a7-4c51-a762-6fe3753044b6@kernel.dk>
Date:   Wed, 11 Oct 2023 15:42:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the block tree with the asm-generic
 tree
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        Sohil Mehta <sohil.mehta@intel.com>
References: <20231009123118.4487a0e1@canb.auug.org.au>
 <20231009084812.GB14330@noisy.programming.kicks-ass.net>
 <cb4bb8e2-7dfe-4ca4-aa70-060f7b2f8f95@app.fastmail.com>
 <20231009141351.GD14330@noisy.programming.kicks-ass.net>
 <b7c57f03-4606-4190-98c5-344c49656f9c@kernel.dk>
 <66e09ad5-2dcf-4159-9c98-f37ac739a445@kernel.dk>
 <20231011175407.GG6307@noisy.programming.kicks-ass.net>
 <ZScUhud9eqKIQJjC@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZScUhud9eqKIQJjC@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/23 3:32 PM, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> On Wed, Oct 11, 2023 at 10:21:06AM -0600, Jens Axboe wrote:
>>> On 10/9/23 8:16 AM, Jens Axboe wrote:
>>>> On 10/9/23 8:13 AM, Peter Zijlstra wrote:
>>>>> On Mon, Oct 09, 2023 at 11:00:19AM +0200, Arnd Bergmann wrote:
>>>>>> On Mon, Oct 9, 2023, at 10:48, Peter Zijlstra wrote:
>>>>>>> On Mon, Oct 09, 2023 at 12:31:18PM +1100, Stephen Rothwell wrote:
>>>>>>>> diff --cc arch/alpha/kernel/syscalls/syscall.tbl
>>>>>>>> index 5d05ab716a74,b1865f9bb31e..000000000000
>>>>>>>> --- a/arch/alpha/kernel/syscalls/syscall.tbl
>>>>>>>> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
>>>>>>>> @@@ -492,4 -492,6 +492,7 @@@
>>>>>>>>   560	common	set_mempolicy_home_node		sys_ni_syscall
>>>>>>>>   561	common	cachestat			sys_cachestat
>>>>>>>>   562	common	fchmodat2			sys_fchmodat2
>>>>>>>>  -563	common	futex_wake			sys_futex_wake
>>>>>>>>  -564	common	futex_wait			sys_futex_wait
>>>>>>>>  -565	common	futex_requeue			sys_futex_requeue
>>>>>>>>  +563	common	map_shadow_stack		sys_map_shadow_stack
>>>>>>>> ++564	common	futex_wake			sys_futex_wake
>>>>>>>> ++565	common	futex_wait			sys_futex_wait
>>>>>>>> ++566	common	futex_requeue			sys_futex_requeue
>>>>>>>
>>>>>>> So this renumbers the (futex) stuff on Alpha, does anybody care? AFAICT
>>>>>>> Alpha does not follow the unistd order and meh.
>>>>>>
>>>>>> Let's not make it worse for now. All the numbers since the
>>>>>> introduction of the time64 syscalls are offset by exactly 120
>>>>>> on alpha, and I'd prefer to keep it that way for the moment.
>>>>>>
>>>>>> I still hope to eventually finish the conversion of all architectures
>>>>>> to a single syscall.tbl for numbers >400, and if that happens before
>>>>>> the end of alpha, a different ordering would just be extra pain.
>>>>>
>>>>> Fair enough; should we look at rebase those futex patches for this? (bit
>>>>> of a pain as that would also mean rebasing block)
>>>>
>>>> From my point of view, this isn't a huge problem if we do it now. The
>>>> io_uring-futex branch is a separate branch and I have nothing on top of
>>>> it, so I could easily just re-pull your updated branch and rebase my
>>>> changes on top.
>>>>
>>>>> Or do we want to keep this fixup in the merge resolution and make sure
>>>>> Linus is aware?
>>>>
>>>> If you're OK with it, I'd say let's rebase and save ourselves the
>>>> trouble at merge time.
>>>
>>> Peter, what's the verdict - do you want to rebase it, or leave it as-is?
>>
>> Ah, I looked into doing this, but tip/locking/core has since grown a
>> bunch of patches and has a merge commit -- I talked to Ingo yesterday
>> and he proposed just queueing a fix on top instead of doing a full
>> rebase.
>>
>> Ingo, that still your preferred solution?
> 
> Yeah, that would be the best solution IMO - it's not like there's any real 
> prospect of someone bisecting futex2 patch-enablement commits on Alpha ... 
> and the bisection distance isn't particularly large either in any case.

OK, works for me. I'll keep my branch as-is, and just ensure it gets
sent out after locking/core has been pulled by Linus.

-- 
Jens Axboe

