Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57207758643
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjGRUsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGRUsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:48:10 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49D9C0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:48:08 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1b8ad356f03so36986995ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689713288; x=1692305288;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vqOdktV4CNBtKn+gnmv6biZuC3rq/Zlio3rN/V4PHOU=;
        b=rqCnJR32zTs5TqdKS1/Ufs1UUVAwzfTnwTIjTAvcFtONsiHlD252ljFOl90S2cYvgM
         ZLKSITp2+G5AW40qtJIZ+MQTegHRta341lU9Ygr4VZgxyk1KYPwQR6YP3ITcdON1PH6N
         nBkBxfCUyC9q7D1dCyEMqJOIPPFvDDFnHoE/GaSpiTrmftxOUnNcIoIdLQmi/NX0vqTm
         AASkqHAt5oOw1i09CcjHgfcGXe8UqqaQ9OfNrLp5B4dJnWN/+7yMU3bMeRYukKDthIMc
         WUh4nLPLLkhH8dJP2dA8ii7XW93gNrkr34MWCYt3URAgyPIY7x7UCH9CUr06dktAzbJs
         YqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689713288; x=1692305288;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vqOdktV4CNBtKn+gnmv6biZuC3rq/Zlio3rN/V4PHOU=;
        b=cLooBqXQFLgkeaFZCjiobLwKnmYQwu0Xp7qmuA3RNG4EbpPUuXW9g9Ng1kH3iAg+oW
         u3SNSDWiKXGAN6nLGhljNTiIumdWLdG1fgZeNOI/54VZKdflMn7Rolszv3hs7seycxRd
         DmHu+pNJQF8hkiQookmI9N+2P7XqbzMVGmHcNu//kiUfrwlCsfVM3IgTl9k0NC20Zfih
         WJV+pwkLNyHlHKt+rBjfvVTxaMNfb95eJtLsSBA09I4w/BjYlWB+mjnWicHmEGsZ4CNJ
         JnyfVus4XIi9jXLJv68Kz8VaUYr2i+LPlvKh7ZKPCXKfG9lXZbf8qstRnFBaYnpV8Coq
         ytTA==
X-Gm-Message-State: ABy/qLZRLZMJ+3yNg4RO7bHjI3/0/KyRytV/0NoPaR0N8peXzRnu2IHs
        DRyqg/ztV1pnrfNxIGoKGkE=
X-Google-Smtp-Source: APBJJlHOdEC0qdKIljueqvKhAnIWEgKV9mUStxkY1rPzoLUZoY9sN7ahxjF2EtVckZx/noMv3LRlhw==
X-Received: by 2002:a17:903:110d:b0:1b0:3637:384e with SMTP id n13-20020a170903110d00b001b03637384emr888660plh.25.1689713288277;
        Tue, 18 Jul 2023 13:48:08 -0700 (PDT)
Received: from [127.0.0.1] ([212.107.28.53])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902d48100b001b896d0eb3dsm2321333plg.8.2023.07.18.13.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 13:48:07 -0700 (PDT)
From:   Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <cd53e03b-c574-dc05-f9c0-1c8271c5a607@gmail.com>
Date:   Wed, 19 Jul 2023 04:48:02 +0800
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
In-Reply-To: <03206759-8d6a-a410-a8f9-d4678236bdbf@gmail.com>
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


On 2023/7/19 04:35, Celeste Liu wrote:
> 
> On 2023/7/19 03:35, Björn Töpel wrote:
>> Celeste Liu <coelacanthushex@gmail.com> writes:
>>
>>> When we test seccomp with 6.4 kernel, we found errno has wrong value.
>>> If we deny NETLINK_AUDIT with EAFNOSUPPORT, after f0bddf50586d, we will
>>> get ENOSYS instead. We got same result with 9c2598d43510 ("riscv: entry: Save a0
>>> prior syscall_enter_from_user_mode()").
>>>
>>> After analysing code, we think that regs->a0 = -ENOSYS should be advanced before
>>> syscall_enter_from_user_mode to fix this problem. In __seccomp_filter, when
>>> seccomp rejected this syscall with specified errno, they will set a0 to return
>>> number as syscall ABI, and then return -1. This return number is finally pass
>>> as return number of syscall_enter_from_user_mode, and then is compared
>>> with NR_syscalls after converted to ulong (so it will be ULONG_MAX).
>>> The condition syscall < NR_syscalls will always be false, so regs->a0 = -ENOSYS
>>> is always executable. It covered a0 set by seccomp, so we always get
>>> ENOSYS when match seccomp RET_ERRNO rule.
>>
>> Isn't something like...
>>
>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> index f910dfccbf5d..15a8b4898a6c 100644
>> --- a/arch/riscv/kernel/traps.c
>> +++ b/arch/riscv/kernel/traps.c
>> @@ -297,7 +297,7 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
>>  asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>>  {
>>  	if (user_mode(regs)) {
>> -		ulong syscall = regs->a7;
>> +		long syscall = regs->a7;
>>  
>>  		regs->epc += 4;
>>  		regs->orig_a0 = regs->a0;
>> @@ -306,7 +306,7 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>>  
>>  		syscall = syscall_enter_from_user_mode(regs, syscall);
>>  
>> -		if (syscall < NR_syscalls)
>> +		if (syscall > -1 && syscall < NR_syscalls)
>>  			syscall_handler(regs, syscall);
>>  		else
>>  			regs->a0 = -ENOSYS;
>>
>>
>> ...easier to read?
>>
>>
>> Björn
> 
> It seems that your change turn it back to the beginning. If syscall == -1,
> it is supposed to go neither first nor else branch. It should do NOTHING.
> However it was still a great idea. It may be better to use a set of if-statement
> to clarify the logic.
> 
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index f910dfccbf5d2..d0bd725244594 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -306,7 +306,9 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>  
>  		syscall = syscall_enter_from_user_mode(regs, syscall);
>  
> -		if (syscall < NR_syscalls)
> +		if (syscall == -1)
> +			// Do nothing
> +		else if (syscall < NR_syscalls)
>  			syscall_handler(regs, syscall);
>  		else
>  			regs->a0 = -ENOSYS;
> 

Oh, it's better to reorder to:

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f910dfccbf5d2..932814e34ac37 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -308,7 +308,7 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
 
 		if (syscall < NR_syscalls)
 			syscall_handler(regs, syscall);
-		else
+		else if (syscall != -1)
 			regs->a0 = -ENOSYS;
 
 		syscall_exit_to_user_mode(regs);


I will send v3 later.
