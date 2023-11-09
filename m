Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50427E6E61
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjKIQOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjKIQOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:14:39 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C21C358E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 08:14:37 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so1101231b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 08:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699546477; x=1700151277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FpX1aRY4vi6s1ovpKy5aAzsogTxkJiL9H8TF/8fc0Rs=;
        b=Zn30N0JPMvp2QTr0PTDv9ojU2bp5WUlUVP04VyZ9t/6+m4JwkjumWtLOPRTpYJuVA+
         fpUNR65la5sDZPr4FtCZhx1XIegi01Q8kBDng1AAl/8jz94cieSz97H4LNOKyJEVuv0X
         ZkJnsB7SMMdmb1+fMPHIfU+pZEkTWE3BRaO0rLdChOiAn2/9uOhbH6BO628fMW3Rlvuo
         BLYt7JONR3RopbTt2tVRVxTHi1vh4WnnBwTFdai9L0SGBWfjBswSs4TAQ9xJwZSELDDe
         h75Pt2QUb3TijyfozK+Qe8WgnCJ46XblvT+zL/PcYpcT68Puz6YkplGvhHlAPhO+D3WI
         RJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699546477; x=1700151277;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpX1aRY4vi6s1ovpKy5aAzsogTxkJiL9H8TF/8fc0Rs=;
        b=rxJOSkhDDYCm9fZp7Y/Wlq6II5vdT7Cl0pDWVdmcn9ORCYirnGgQWCFhoxdVJSR7HA
         RMxaETG7UBPOqhfbevUybNf4sKIGmal+Ie+4DsHde4/SKU+Vjm4U4mruZt7nGRtCXnHf
         Os0h68dDX4HLUDUsXMFl64Om61bwRVn9Maf34azkZMZEAbNfd0AZXz+Jcsy9Epm90mqB
         Uv5oaBWH/apKzFUw7QmOcv+vlD0v1A8fA5K2S7nuGfMGWhmEqaB+VbeCn9F+Ri+R6Z05
         RUbDTdpg1Up2mnz7SNNZKCCscpSZDAYl2KS0tniObVDJR7YaWqgTrq7hI1HhUgQihtm1
         8aTg==
X-Gm-Message-State: AOJu0YxBm5bMRdw/VT9DHVYFcaF+bBwch3kXGcir5xCkCspbuYbpKYgZ
        iNq4iL4Pp8qjrftG3T3lR6ED4mIK+P5luQiAekU=
X-Google-Smtp-Source: AGHT+IE/xIO7qQexPmOKuC2AIQgSt9BeoUEWxOwwA0LYfrVy3WHpFcBMtceSUjydZKSVKBFenn10SQ==
X-Received: by 2002:a05:6300:808d:b0:181:9b30:89d6 with SMTP id ap13-20020a056300808d00b001819b3089d6mr5697084pzc.27.1699546476860;
        Thu, 09 Nov 2023 08:14:36 -0800 (PST)
Received: from localhost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id i6-20020aa787c6000000b006c0328b2440sm10905229pfo.150.2023.11.09.08.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 08:14:36 -0800 (PST)
Date:   Thu, 09 Nov 2023 08:14:36 -0800 (PST)
X-Google-Original-Date: Thu, 09 Nov 2023 08:14:34 PST (-0800)
Subject:     Re: [PATCH] selftests: sud_test: return correct emulated syscall value on RISC-V
In-Reply-To: <ef980c24-6901-4bb3-8a1b-5902675e7851@rivosinc.com>
CC:     shuah@kernel.org, krisman@collabora.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     cleger@rivosinc.com, tglx@linutronix.de
Message-ID: <mhng-9af5865a-9208-4308-9eb6-4ec07a4b4cb2@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Nov 2023 00:22:46 PST (-0800), cleger@rivosinc.com wrote:
>
>
> On 09/11/2023 04:26, Palmer Dabbelt wrote:
>> On Wed, 13 Sep 2023 07:07:11 PDT (-0700), cleger@rivosinc.com wrote:
>>> Currently, the sud_test expects the emulated syscall to return the
>>> emulated syscall number. This assumption only works on architectures
>>> were the syscall calling convention use the same register for syscall
>>> number/syscall return value. This is not the case for RISC-V and thus
>>> the return value must be also emulated using the provided ucontext.
>>>
>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>> ---
>>>  tools/testing/selftests/syscall_user_dispatch/sud_test.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
>>> b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
>>> index b5d592d4099e..1b5553c19700 100644
>>> --- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
>>> +++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
>>> @@ -158,6 +158,14 @@ static void handle_sigsys(int sig, siginfo_t
>>> *info, void *ucontext)
>>>
>>>      /* In preparation for sigreturn. */
>>>      SYSCALL_DISPATCH_OFF(glob_sel);
>>> +
>>> +    /*
>>> +     * Modify interrupted context returned value according to syscall
>>> +     * calling convention
>>> +     */
>>> +#if defined(__riscv)
>>> +    ((ucontext_t*)ucontext)->uc_mcontext.__gregs[REG_A0] =
>>> MAGIC_SYSCALL_1;
>>> +#endif
>>>  }
>>>
>>>  TEST(dispatch_and_return)
>>
>> I'm not sure if I'm just tired, but it took me a while to figure out why
>> this was necessary.  I think this is a better explanation:
>
> I think it's because this mechanism does not behave like other syscalls
> at all and the classic calling convention does not really apply...

Yep.  I also got tripped up because I mis-read the docs and though 
SIGSYS was only for some error case (where it's actually for all the 
intercepted syscalls).

>>    diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
>> b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
>>    index b5d592d4099e..a913fd90cfa3 100644
>>    --- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
>>    +++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
>>    @@ -158,6 +158,16 @@ static void handle_sigsys(int sig, siginfo_t
>> *info, void *ucontext)
>>            /* In preparation for sigreturn. */
>>         SYSCALL_DISPATCH_OFF(glob_sel);
>>    +    /*
>>    +     * The tests for argument handling assume that `syscall(x) ==
>> x`.  This
>>    +     * is a NOP on x86 because the syscall number is passed in %rax,
>> which
>>    +     * happens to also be the function ABI return register.  Other
>>    +     * architectures may need to swizzle the arguments around.
>>    +     */
>
> Indeed, that is more clear. Should I send a v2 ?

I would, but +Thomas as it looks like he's the one taking patches for 
this.

>
>>    +#if defined(__riscv)
>>    +    (ucontext_t*)ucontext)->uc_mcontext.__gregs[REG_A0] =
>>    +        (ucontext_t*)ucontext)->uc_mcontext.__gregs[REG_A7];
>>    +#endif
>>     }
>>        TEST(dispatch_and_return)
>>
>> but also
>>
>> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> as I agree this is correct.
>>
>> also: wouldn't arm64 also need to move x8 into x0 here, for essentially
>> the same reason as we do?
>
> Yes, as well as for a bunch of other architectures. I suspect this has
> only been tested on x86. AFAIK, this feature is mainly for wine usage
> which then makes sense for x86 and games.

Ya, makes sense -- I'd just looked at Arm to double-check my 
understanding here, as we usually don't find bugs in generic code before 
Arm does.

>
> Thanks,
>
> Clément
