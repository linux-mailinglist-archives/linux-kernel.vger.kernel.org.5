Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A115758657
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjGRU4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjGRU4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:56:45 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36553198C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:56:44 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 46e09a7af769-6b9ad292819so4944382a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689713803; x=1692305803;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s97tEr+Yr2ZXFbk9cEJRa0CCfZ19DYvI4BO8yDRKDsY=;
        b=mRKXbr6Glsi8VBQYVptpWfg3xtc95oVpxwcldhADhXDa3CpOObfBQ+DPczxIZ7GjFp
         /9eLhXadWP6WG1j6ARFKLTsdRr0YlhqojF7jWw2Kry9DbBGmzraywAojjNwpPv3AaSho
         OAhARHFg6PqbQ+b+xmCpFJ+eqHIQvmROmKWHxB7+veU0CP/ivhXqoF0nbLFgiYUGHBza
         uULa3J2fvjQ3zxdCkNG8kjC8aZpD6bM39bAacpJFd1K91LQAdEBHaKSSSEsLn8hxZn18
         3UWJiz6crj7855/U2FykVFU8azSVajIp7GNkYX0K+VI9Hzv3w/bamac5pucC/5lRH7vk
         RCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689713803; x=1692305803;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s97tEr+Yr2ZXFbk9cEJRa0CCfZ19DYvI4BO8yDRKDsY=;
        b=Cm4FDho+BkSYxL8ksOF/zX9IQIGl9jfyENQSa/m2PURdENWzvMiQbUXy1cX92oPPXf
         ebHsHnphfEyir93GNQGRjLCuJAhIwH5YNt4tWeVdrtt6eiy2rQyCejWj5OPxLtsZ5lUV
         Vsavg8zxr6oJOFQCprGobmw0cmtEGs1QQ/i6+GZhRarJJdQQfSLciSPPIC2H2BaHXr1v
         BkvDoDx5J15r24eF+L30c9lQAbvmaS4zBtNTe76XngFsrEuTH5TAuAKOPgO8u2ncUuki
         WyY2uyWMOitH32OEoTyYKWo4d7LtOuvSNg0TlWRrN4oWLKa81Y090sipXnfrbIBHBgiI
         YIXQ==
X-Gm-Message-State: ABy/qLZjcKcOuijE/aJXlfsK0CGKFZg0lF57YjF2jMZWN9tppviEH+0P
        xggCFX1TKKTaaWUuOfZT5dI=
X-Google-Smtp-Source: APBJJlG1nhVunFoHnJqGi17dy87SbRr3QVG4ZQdEEF+untHwhWMyp70xCdPykYjSIuz44YdOSZelhg==
X-Received: by 2002:a05:6358:8aa:b0:135:acfd:8786 with SMTP id m42-20020a05635808aa00b00135acfd8786mr5761394rwj.3.1689713803369;
        Tue, 18 Jul 2023 13:56:43 -0700 (PDT)
Received: from [127.0.0.1] ([212.107.28.53])
        by smtp.gmail.com with ESMTPSA id y22-20020a63b516000000b0055b6eb635f2sm2105500pge.65.2023.07.18.13.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 13:56:42 -0700 (PDT)
From:   Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <c62f16cd-8405-9b05-1c1d-5c776716622d@gmail.com>
Date:   Wed, 19 Jul 2023 04:56:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: entry: set a0 prior to
 syscall_enter_from_user_mode
Content-Language: en-GB-large
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Felix Yan <felixonmars@archlinux.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
References: <20230718162940.226118-1-CoelacanthusHex@gmail.com>
 <87pm4p2et2.fsf@all.your.base.are.belong.to.us>
 <03206759-8d6a-a410-a8f9-d4678236bdbf@gmail.com>
 <87r0p5kkpw.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87r0p5kkpw.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/7/19 04:50, Björn Töpel wrote:
> Celeste Liu <coelacanthushex@gmail.com> writes:
> 
>> On 2023/7/19 03:35, Björn Töpel wrote:
>>> Celeste Liu <coelacanthushex@gmail.com> writes:
>>>
>>>> When we test seccomp with 6.4 kernel, we found errno has wrong value.
>>>> If we deny NETLINK_AUDIT with EAFNOSUPPORT, after f0bddf50586d, we will
>>>> get ENOSYS instead. We got same result with 9c2598d43510 ("riscv: entry: Save a0
>>>> prior syscall_enter_from_user_mode()").
>>>>
>>>> After analysing code, we think that regs->a0 = -ENOSYS should be advanced before
>>>> syscall_enter_from_user_mode to fix this problem. In __seccomp_filter, when
>>>> seccomp rejected this syscall with specified errno, they will set a0 to return
>>>> number as syscall ABI, and then return -1. This return number is finally pass
>>>> as return number of syscall_enter_from_user_mode, and then is compared
>>>> with NR_syscalls after converted to ulong (so it will be ULONG_MAX).
>>>> The condition syscall < NR_syscalls will always be false, so regs->a0 = -ENOSYS
>>>> is always executable. It covered a0 set by seccomp, so we always get
>>>> ENOSYS when match seccomp RET_ERRNO rule.
>>>
>>> Isn't something like...
>>>
>>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>>> index f910dfccbf5d..15a8b4898a6c 100644
>>> --- a/arch/riscv/kernel/traps.c
>>> +++ b/arch/riscv/kernel/traps.c
>>> @@ -297,7 +297,7 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
>>>  asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>>>  {
>>>  	if (user_mode(regs)) {
>>> -		ulong syscall = regs->a7;
>>> +		long syscall = regs->a7;
>>>  
>>>  		regs->epc += 4;
>>>  		regs->orig_a0 = regs->a0;
>>> @@ -306,7 +306,7 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>>>  
>>>  		syscall = syscall_enter_from_user_mode(regs, syscall);
>>>  
>>> -		if (syscall < NR_syscalls)
>>> +		if (syscall > -1 && syscall < NR_syscalls)
>>>  			syscall_handler(regs, syscall);
>>>  		else
>>>  			regs->a0 = -ENOSYS;
>>>
>>>
>>> ...easier to read?
>>>
>>>
>>> Björn
>>
>> It seems that your change turn it back to the beginning. If syscall == -1,
>> it is supposed to go neither first nor else branch. It should do NOTHING.
>> However it was still a great idea. It may be better to use a set of if-statement
>> to clarify the logic.
> 
> Ah, gotcha! (Notice that arch/x86/entry/common.c has
> 
>   | 	if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
> 
> and in do_syscall_x64()
> 
>   | 	/*
>   | 	 * Convert negative numbers to very high and thus out of range
>   | 	 * numbers for comparisons.
>   | 	 */
>   | 	unsigned int unr = nr;
> 
> 
>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> index f910dfccbf5d2..d0bd725244594 100644
>> --- a/arch/riscv/kernel/traps.c
>> +++ b/arch/riscv/kernel/traps.c
>> @@ -306,7 +306,9 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>>  
>>  		syscall = syscall_enter_from_user_mode(regs, syscall);
>>  
>> -		if (syscall < NR_syscalls)
>> +		if (syscall == -1)
>> +			// Do nothing
>> +		else if (syscall < NR_syscalls)
>>  			syscall_handler(regs, syscall);
>>  		else
>>  			regs->a0 = -ENOSYS;
> 
> Maybe something a bit more explicit?
> 
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index f910dfccbf5d..5cef72874542 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -297,6 +297,10 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
>  asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>  {
>  	if (user_mode(regs)) {
> +		/*
> +		 * Convert negative numbers to very high and thus out of range
> +		 * numbers for comparisons.
> +		 */
>  		ulong syscall = regs->a7;
>  
>  		regs->epc += 4;
> @@ -308,7 +312,7 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>  
>  		if (syscall < NR_syscalls)
>  			syscall_handler(regs, syscall);
> -		else
> +		else if ((long)syscall != -1L)
>  			regs->a0 = -ENOSYS;
>  
>  		syscall_exit_to_user_mode(regs);
> 
> 
> Björn

Ok, I will send v3.
