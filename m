Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522D97526F7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjGMP3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjGMP2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:28:43 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0703A92
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:28:15 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id e9e14a558f8ab-34637e55d8dso3386315ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689262092; x=1691854092;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b4KxDrl04bf0Vf57I6E3B3+mq1oEi/sn9+KisK/u73Q=;
        b=UbNyGklqJq2M8+EImiMKPQWNKj6HO29Kj9yUByexUx7kAoYJrrJayKs7IquHsbiAdy
         ZVyhlqlZsrKvgXKcIpIJ1xy4CPBGWlGMkuhppj6R0OaRRoYIwLtyigd8GhgEco89XysF
         c5LjBy4Z8gVIKLRygFXJV4z0DBCnV6tom7mC1p5X3fOh+W2C6I2m00i28irrD7/DqiWY
         at4hAjwXhy6aAUat72v9YbVSMpMYHOxqNaAqhqc/fms+WySRASOttZmnMJgl3L4u8Wrr
         xGO4oYYKn+FdM0TF31gltCF/ffLW2uewY1OZSsOEdLl5t+/1XQQ+rmw2mnA8us63q6gp
         m0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689262092; x=1691854092;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4KxDrl04bf0Vf57I6E3B3+mq1oEi/sn9+KisK/u73Q=;
        b=J00/hyh5E6agAo+R8mnB4Q7AF9EfTciA5owDsGNXSgxzh6q93Wjmc1nbP9Z9byWF+u
         6YuiePaMFd6MfgYMINOGuxeOd/zxLcV4lcychwlH6Iup29B3/7uDEQfEZjIJMfP8iviT
         U3lVvdxy/GTC2mW2WofYBUn2IE0uCYT9K+rMQ7uRdJM8Sej1/XPa08UKwYXg4Necv2xG
         zDd7gttArPku+rnySC46vilGMr+fN0Xh1KbLGN2soDyuMpp8+OlF0PuVHICW6f9G4az6
         Wdds8A2Gvz/3hmO+RqZ9JnFqhVHw3xy1kjIEFjQCV7//vEjisFxy2ctsTR6+TjVyhIOk
         pOqA==
X-Gm-Message-State: ABy/qLaUHX97b+GrGePx/0/1u0HuugHi27sUPhs0xxEoecXmHY1ygTi5
        latt6054EWKRJZkIh8o+UG8=
X-Google-Smtp-Source: APBJJlF2QcMLC68E0jTaKDGDw322opVqtbAdk8Ama3TnEa2h2rTqres/nmIlO/C+HZGpxc5XZc6L/w==
X-Received: by 2002:a92:c907:0:b0:346:f14:86ba with SMTP id t7-20020a92c907000000b003460f1486bamr1722729ilp.2.1689262092386;
        Thu, 13 Jul 2023 08:28:12 -0700 (PDT)
Received: from [127.0.0.1] ([212.107.28.53])
        by smtp.gmail.com with ESMTPSA id h4-20020a17090adb8400b00262d662c9adsm11946904pjv.53.2023.07.13.08.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 08:28:11 -0700 (PDT)
From:   Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <37a22693-e33c-f64a-e3d7-febed8e9f195@gmail.com>
Date:   Thu, 13 Jul 2023 23:28:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: entry: set a0 prior to syscall_handler
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Felix Yan <felixonmars@archlinux.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
References: <20230711062202.3542367-1-CoelacanthusHex@gmail.com>
 <CAJF2gTRgXbEfQWiWtZtVNBDhpY2miG_ByHrVZF2fbfu60hCHcQ@mail.gmail.com>
Content-Language: en-GB-large
In-Reply-To: <CAJF2gTRgXbEfQWiWtZtVNBDhpY2miG_ByHrVZF2fbfu60hCHcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/7/13 08:00, Guo Ren wrote:
> On Tue, Jul 11, 2023 at 2:22 AM Celeste Liu <coelacanthushex@gmail.com> wrote:
>>
>> When we test seccomp with 6.4 kernel, we found errno has wrong value.
>> If we deny NETLINK_AUDIT with EAFNOSUPPORT, after f0bddf50586d, we will
>> get ENOSYS. We got same result with 9c2598d43510 ("riscv: entry: Save a0
>> prior syscall_enter_from_user_mode()").
>>
>> Compared with x86 and loongarch's implementation of this part of the
>> function, we think that regs->a0 = -ENOSYS should be advanced before
>> syscall_handler to fix this problem. We have written the following patch,
>> which can fix this problem after testing. But we don't know enough about
>> this part of the code to explain the root cause. Hope someone can find
>> a reasonable explanation. And we'd like to reword this commit message
>> according to the explanation in v2
>>
>> Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
>> Reported-by: Felix Yan <felixonmars@archlinux.org>
>> Co-developed-by: Ruizhe Pan <c141028@gmail.com>
>> Signed-off-by: Ruizhe Pan <c141028@gmail.com>
>> Co-developed-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
>> Signed-off-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
>> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
>> Tested-by: Felix Yan <felixonmars@archlinux.org>
>> ---
>>  arch/riscv/kernel/traps.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> index f910dfccbf5d2..ccadb5ffd063c 100644
>> --- a/arch/riscv/kernel/traps.c
>> +++ b/arch/riscv/kernel/traps.c
>> @@ -301,6 +301,7 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>>
>>                 regs->epc += 4;
>>                 regs->orig_a0 = regs->a0;
>> +               regs->a0 = -ENOSYS;
> Oh, no. You destroyed the a0 for syscall_handler, right? It's not
> reasonable. Let's see which syscall_handler needs a0=-ENOSYS.

syscall_handler always use orig_a0, not a0.
And I have a mistake in original email, corret one is
syscall_enter_from_user_mode not syscall_handler.

> Could you give out more detail on your test case?
> 
>>
>>                 riscv_v_vstate_discard(regs);
>>
>> @@ -308,8 +309,6 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>>
>>                 if (syscall < NR_syscalls)
>>                         syscall_handler(regs, syscall);
>> -               else
>> -                       regs->a0 = -ENOSYS;
>>
>>                 syscall_exit_to_user_mode(regs);
>>         } else {
>> --
>> 2.41.0
>>
> 
> 

