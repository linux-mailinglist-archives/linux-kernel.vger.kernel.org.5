Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF65B7FFA7B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376257AbjK3S4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjK3S4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:56:15 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1387D10DF;
        Thu, 30 Nov 2023 10:56:21 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d00689f5c8so12237725ad.3;
        Thu, 30 Nov 2023 10:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701370580; x=1701975380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BkR4U0LOrjI0uCcnrqeS4MFl1XYrS3U+0IqGlxvW8PY=;
        b=FN4dsmJO3Ryko4yJ9ZZQNeDGTHYLJP9E3TUKJNNOHMfK1ilN/EgckCm3MrsMjNifVe
         jrSPGalnAlasJ6LOrkr9gBFU5ohKaPRUPo3OmjimTdc5/jBut4cwrrU0eIagwoGb3Vqq
         MeD/Gt63Xu5xWTKelUJ+sCmr/usApaGqZhEsk5F2t5MUUFEWR5N7TzjvGHPkmca6C+oS
         /RFnW0S9NWNEo0cBH2EdTS+04zQnzQIDKiS8qQk5b4szbP6lU6mMjn27FV2KNeNw4pbQ
         TrHRe0tum4Q8ndMnJq+tRzhxiHfW0Lv7b4yTdXjRdkCHO7RoGXxoPFSGsZfWN7lPIjX4
         90oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701370580; x=1701975380;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BkR4U0LOrjI0uCcnrqeS4MFl1XYrS3U+0IqGlxvW8PY=;
        b=ZI77j9oN3WIQp+qp0yPlcFWV4L9Fo3xdzCL3guESwP15DD6sipkG57PMm70DKL4+ER
         kMqaL/KzdJjUgwgOLxSp/GeAkZZPIVLKMEoWMcfyvIKFExlfJmbTLBBWDu6W1aoRf2f1
         JdM63GOdV8PafOrbXQKvWxs9aqdtXtqviIftcdiLWPiQhnDwtk18itB85IyfjRzzA2Xl
         XBpoxM23tFOlpN/SFDzozsEjyeYqrEt/unNY+eZxHNI3aLpUaGBgSQlftyXUMhSWtUJp
         gjOS9lBWLpGKCRtU56kG+h6RROVeO9hV1cl/CifAETVcAvmDnTKBs+Xn8VFxqVJrymPs
         QjDA==
X-Gm-Message-State: AOJu0Yz4UiwlxlyU9ot29VrSe/WBUlpyZjQisHQ5gPl9laS4rYU84KZQ
        kR0rR33b5NIv7SZaPBBKBX8=
X-Google-Smtp-Source: AGHT+IG3+EA8oN5IjPawIuZUJOAi57HvUEEmy9KJ1mW/WKxoThl01VgBm/NDOBFff1xZ3+zlmQ1HJw==
X-Received: by 2002:a17:902:d303:b0:1cc:4e81:36a4 with SMTP id b3-20020a170902d30300b001cc4e8136a4mr25390609plc.5.1701370580379;
        Thu, 30 Nov 2023 10:56:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p14-20020a1709028a8e00b001cfc3f73927sm1746173plo.9.2023.11.30.10.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 10:56:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <06deae26-c59c-4746-867d-ab6f5852b0af@roeck-us.net>
Date:   Thu, 30 Nov 2023 10:56:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/69] 5.15.141-rc1 review
Content-Language: en-US
To:     =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, flaniel@linux.microsoft.com
References: <20231130162133.035359406@linuxfoundation.org>
 <CAEUSe7-yhmQkr1iK-82+Sc_YpVtWUQhuKoazoXHF_3oP9XTt4Q@mail.gmail.com>
 <e2e50813-79ba-4c84-b6ae-6885cbef54ab@roeck-us.net>
 <CAEUSe78tYPTFuauB7cxZzvAeMhzB_25Q8DqLUfF7Nro9WsUhNw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAEUSe78tYPTFuauB7cxZzvAeMhzB_25Q8DqLUfF7Nro9WsUhNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/23 10:11, Daniel Díaz wrote:
> Hello!
> 
> On Thu, 30 Nov 2023 at 11:44, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 11/30/23 09:21, Daniel Díaz wrote:
>>> Hello!
>>>
>>> Lots of failures everywhere:
>>> * clang-17-lkftconfig                 arm64
>>> * clang-17-lkftconfig                 arm64
>>> * clang-17-lkftconfig                 arm64
>>> * clang-lkftconfig                    arm64
>>> * clang-lkftconfig                    arm
>>> * clang-lkftconfig                    i386
>>> * clang-lkftconfig                    x86_64
>>> * gcc-12-lkftconfig                   arm64
>>> * gcc-12-lkftconfig                   arm
>>> * gcc-12-lkftconfig                   i386
>>> * gcc-12-lkftconfig                   x86_64
>>> * gcc-12-lkftconfig-64k_page_size     arm64
>>> * gcc-12-lkftconfig-64k_page_size     arm64
>>> * gcc-12-lkftconfig-armv8_features    arm64
>>> * gcc-12-lkftconfig-debug             arm64
>>> * gcc-12-lkftconfig-debug             arm64
>>> * gcc-12-lkftconfig-debug             arm
>>> * gcc-12-lkftconfig-debug             i386
>>> * gcc-12-lkftconfig-debug             x86_64
>>> * gcc-12-lkftconfig-debug-kmemleak    arm64
>>> * gcc-12-lkftconfig-debug-kmemleak    arm
>>> * gcc-12-lkftconfig-debug-kmemleak    i386
>>> * gcc-12-lkftconfig-debug-kmemleak    x86_64
>>> * gcc-12-lkftconfig-devicetree        arm64
>>> * gcc-12-lkftconfig-kasan             arm64
>>> * gcc-12-lkftconfig-kasan             arm64
>>> * gcc-12-lkftconfig-kasan             x86_64
>>> * gcc-12-lkftconfig-kselftest         arm64
>>> * gcc-12-lkftconfig-kselftest-kernel  arm64
>>> * gcc-12-lkftconfig-kselftest-kernel  arm
>>> * gcc-12-lkftconfig-kselftest-kernel  i386
>>> * gcc-12-lkftconfig-kunit             arm64
>>> * gcc-12-lkftconfig-kunit             arm64
>>> * gcc-12-lkftconfig-kunit             arm
>>> * gcc-12-lkftconfig-kunit             i386
>>> * gcc-12-lkftconfig-kunit             x86_64
>>> * gcc-12-lkftconfig-libgpiod          arm64
>>> * gcc-12-lkftconfig-libgpiod          arm
>>> * gcc-12-lkftconfig-libgpiod          i386
>>> * gcc-12-lkftconfig-libgpiod          x86_64
>>> * gcc-12-lkftconfig-perf              arm64
>>> * gcc-12-lkftconfig-perf-kernel       arm64
>>> * gcc-12-lkftconfig-perf-kernel       arm
>>> * gcc-12-lkftconfig-perf-kernel       i386
>>> * gcc-12-lkftconfig-perf-kernel       x86_64
>>> * gcc-12-lkftconfig-rcutorture        arm64
>>> * gcc-12-lkftconfig-rcutorture        arm64
>>> * gcc-12-lkftconfig-rcutorture        arm
>>> * gcc-12-lkftconfig-rcutorture        i386
>>> * gcc-12-lkftconfig-rcutorture        x86_64
>>>
>>> It's essentially this:
>>>
>>> -----8<-----
>>>     make --silent --keep-going --jobs=8
>>> O=/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=x86_64 SRCARCH=x86
>>> CROSS_COMPILE=x86_64-linux-gnu- 'CC=sccache x86_64-linux-gnu-gcc'
>>> 'HOSTCC=sccache gcc'
>>>     arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x51:
>>> unreachable instruction
>>>     x86_64-linux-gnu-ld: kernel/trace/trace_kprobe.o: in function
>>> `__trace_kprobe_create':
>>>     trace_kprobe.c:(.text+0x2f39): undefined reference to
>>> `kallsyms_on_each_symbol'
>>>     x86_64-linux-gnu-ld: kernel/trace/trace_kprobe.o: in function
>>> `create_local_trace_kprobe':
>>>     trace_kprobe.c:(.text+0x384b): undefined reference to
>>> `kallsyms_on_each_symbol'
>>>     make[1]: *** [/builds/linux/Makefile:1227: vmlinux] Error 1
>>>     make[1]: Target '__all' not remade because of errors.
>>>     make: *** [Makefile:226: __sub-make] Error 2
>>>     make: Target '__all' not remade because of errors.
>>> ----->8-----
>>>
>>> It only affects 5.15. Bisection in progress.
>>
>> I guess it will point to
>>
>>>> Francis Laniel <flaniel@linux.microsoft.com>
>>>>       tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols
> 
> It sure did!:
> 
>    commit 7b4375c36a4c0e1b4b97ccbcdd427db5a460e04f
>    Author: Francis Laniel <flaniel@linux.microsoft.com>
>    Date:   Fri Oct 20 13:42:49 2023 +0300
> 
>        tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols
> 
>        commit b022f0c7e404887a7c5229788fc99eff9f9a80d5 upstream.
> 
> Reverting that commit made the build pass again.
> 

It looks like it depends on commit d721def7392a ("kallsyms: Make kallsyms_on_each_symbol
generally available"), but that doesn't apply cleanly.

Guenter

