Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C611768AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 06:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjGaERL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 00:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjGaERE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 00:17:04 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A60119;
        Sun, 30 Jul 2023 21:17:02 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686b91c2744so2864901b3a.0;
        Sun, 30 Jul 2023 21:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690777022; x=1691381822;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=InO4fB71UppySdmBaFe7IJBmYOMGORvt2/2z9f7w8Mo=;
        b=WDP0Jj/72CwoAduZqkX03b85dhAPk5h0OFjQ0w2iKJnTY5cqgURnS6BbD3pTlMfyES
         RI32KKl+Oo6XtnJIAxbxKl9/xJMIq5sXVBr99uaesy48VChj2vrVnO1ZAzkM/BP/gu9D
         Bcl45NfCpDEHN0zpd8v5/hR3xoLavO0GWjcOonKW6vgPIGy8CBXggPwmDspZZvxnEpNE
         oqRciRXdI1PxAHyWx9TFSRrLI1lVM1oLFeaK2HtauY/eTEd3bG1iw1yL1Qi79VL9pAEe
         VY1m5HIFRBHdRyUVNR2zGAwOOOr+cZwBa8SvxrbEjuTeJCSckn/B9w7f7kLLKyM0RjIv
         I/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690777022; x=1691381822;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=InO4fB71UppySdmBaFe7IJBmYOMGORvt2/2z9f7w8Mo=;
        b=c2jqVYwGFbhAHwfDiy/h6zybm1z/HacmNKxjbNqBMwXsF0ixGRrWCm4yLEu+/n7c8j
         hCDV0EGY/ruV9xOLMVhwwmaReui8iwvxirg0o7YK3FhdVkDtJFWq/2qvYDPSMBt+mabn
         9McS2ea/jmGI82OvEGSfFaPHE626pU6d30uVZS91nzJasnzUbqKC04hrN/dhbL2EN38Q
         uCxM+SrtPf+noXAiQZRTNkj/RwrLxHfzqNususMTUcmn4VSv4bGe2BR9wXsUiyad9faC
         tJB5662BUICAxZaGowImW6FJ0zw6zrQptZi8k+kHHbIs1kYBOnbXoEXtjjOp1zGBqd1T
         wssg==
X-Gm-Message-State: ABy/qLYadRQGokM1eWUBzX3HkT2sN9ByKcBw24/Qk44hS/QhmieQw9D6
        iYU45JGfmFagzSTvDjCon/w=
X-Google-Smtp-Source: APBJJlHCKP6JrqL7v8nAHmmKHENRxl+XH/aY87MHs8R2HMC1XY+gkjsGpAxlhGUtJHy6fzP3Kq5KnQ==
X-Received: by 2002:a05:6a00:1147:b0:66a:6339:e8f9 with SMTP id b7-20020a056a00114700b0066a6339e8f9mr9671743pfm.0.1690777021642;
        Sun, 30 Jul 2023 21:17:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e3-20020aa78c43000000b00682562bf477sm6588959pfd.82.2023.07.30.21.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 21:17:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0a07880d-1e6a-25d5-18c7-cf0bfa58cee9@roeck-us.net>
Date:   Sun, 30 Jul 2023 21:16:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org
References: <ZMJWet00+9yIl/9c@duo.ucw.cz>
 <78722041-D1F7-45FA-BA1C-41B92209BA6C@joelfernandes.org>
 <0751f5a8-2727-4a08-8bb8-50bbd4244c9c@paulmck-laptop>
 <67eba84a-ae24-2983-a756-463f39f3ca71@roeck-us.net>
 <ebe4a969-8a24-4bb8-8dbe-f77db89f65c9@paulmck-laptop>
 <2f4b012e-1f95-30aa-3f43-c31e84cb2c42@roeck-us.net>
 <2cfc68cc-3a2f-4350-a711-ef0c0d8385fd@paulmck-laptop>
 <6d45f1d0-25e5-8603-0fbb-73374be00503@roeck-us.net>
 <bfa768e7-fc4f-4511-ad3a-67772f41d50c@paulmck-laptop>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 6.4 000/227] 6.4.7-rc1 review
In-Reply-To: <bfa768e7-fc4f-4511-ad3a-67772f41d50c@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/23 20:54, Paul E. McKenney wrote:
> On Thu, Jul 27, 2023 at 09:22:52PM -0700, Guenter Roeck wrote:
>> On 7/27/23 13:33, Paul E. McKenney wrote:
>> [ ... ]
>>
>>> So which of the following Kconfig options is defined in your .config?
>>> CONFIG_TASKS_RCU, CONFIG_TASKS_RUDE_RCU, and CONFIG_TASKS_TRACE_RCU.
>>>
>>
>> Only CONFIG_TASKS_RCU. I added another log message after call_rcu_tasks().
>> It never returns from that function.
>>
>> [    1.168993] Running RCU synchronous self tests
>> [    1.169219] Running RCU synchronous self tests
>> [    1.285795] smpboot: CPU0: Intel Xeon Processor (Cascadelake) (family: 0x6, model: 0x55, stepping: 0x6)
>> [    1.302827] RCU Tasks: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1.
>> [    1.304526] Running RCU Tasks wait API self tests
>>
>> ... and then nothing for at least 10 minutes (then I gave up and stopped the test).
>>
>> Qemu command line:
>>
>> qemu-system-x86_64 -kernel \
>>       arch/x86/boot/bzImage -M q35 -cpu Cascadelake-Server -no-reboot \
>>       -snapshot -device e1000e,netdev=net0 -netdev user,id=net0 -m 256 \
>>       -drive file=rootfs.iso,format=raw,if=ide,media=cdrom \
>>       --append "earlycon=uart8250,io,0x3f8,9600n8 panic=-1 slub_debug=FZPUA root=/dev/sr0 rootwait console=ttyS0 noreboot" \
>>       -d unimp,guest_errors -nographic -monitor none
>>
>> Again, this doesn't happen all the time. With Cascadelake-Server
>> I see it maybe once every 5 boot attempts. I tried with qemu v8.0
>> and v8.1. Note that it does seem to happen with various CPU types,
>> only for some it seems to me more likely to happen (so maybe the
>> CPU type was a red herring). It does seem to depend on the system
>> load, and happen more often if the system is under heavy load.
> 
> Hmmm...  What kernel are you using as your qemu/KVM hypervisor?
> 

Not sure I understand the question. KVM is disabled in my systems.
The host CPUs are Ryzen 3900X and 5900X, but I don't really see why
that would matter.

> And I echo Joel's requests for your .config file.
> 

Did you see the e-mail I sent about this problem earlier today ?

https://lore.kernel.org/lkml/3da81a5c-700b-8e21-1bde-27dd3a0b8945@roeck-us.net/

I think I'll declare this to be a problem with my test environment and disable
RCU debugging.

Thanks,
Guenter

