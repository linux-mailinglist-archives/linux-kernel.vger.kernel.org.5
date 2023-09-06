Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4677936EC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbjIFILs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjIFILq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:11:46 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591EA12A;
        Wed,  6 Sep 2023 01:11:42 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34f2d7c1bc8so3603765ab.1;
        Wed, 06 Sep 2023 01:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693987901; x=1694592701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IhhoVlvKUxA8fynkdsG8I8qeZV+Vy1d1rJq/QPqmrYo=;
        b=gqV2v+QMJH0TzHprSPz20sidz30yN6tBXvqdjK9EfM2HVzbVaqMfsbZgtjOvZ1/QE+
         pQ7ggKdvByNkSOG5u9BlPFEH7dwL/24VLUHBVMVq8eHC4ayvvC0XRK4vJe7pS8g0Niu2
         uI/H5vQBEuedKgjxTwOAkfWxzIBNJ4kyVCE+7F9IH3UjZqirY4TuzLgaRucidq0s4JwN
         1k/TaPXo3pgPxHlHao/TR8slHV+VzURtBKUEC79JNDo33KmtKQTZJGLZ3j8X8d0aFSQu
         KceEbBB/s11LIgGCMmYybNYo0v7sJxqUN/honZZZKZLuMynVcyAJxPJFNxueVGa39HEJ
         Jc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693987901; x=1694592701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IhhoVlvKUxA8fynkdsG8I8qeZV+Vy1d1rJq/QPqmrYo=;
        b=NFJXJ5dA8kbAZVwBLUOglIww1Uj4uJYL7DW6z70wOngqa/NmYLYhlsj6tKQejepw02
         A+Cvpcsd8VMHDV/9/SM/vfYEZwXEdsQ5iAWaLYCARutO9q+R/vzDAL8Oq5EoaFaKsxD0
         aVkAb010Q5dpP5Y1t/trBxvz2zMBhrDaPUG+/y/bvIIZ10vsMjt3w6W3mtbi02jwYtDl
         pMLuaCN98R4AvYY38Q8ZSNOy0hT2s1iiI5SN6Rx13DSKrHs5Z8IIT2rM0MDE6tvQuGYx
         tvQAilnqo70w2QdSeyKFAToOJV9fDWny3AucNjlnR67GZYxj5De4GlGAQdHFP2Yojem1
         UYDQ==
X-Gm-Message-State: AOJu0YyC7a44Nt3XWuQY6DfXiVaZTHTnDeHzFVmJEbPeUf+4vCKN1pEL
        Hm4sFCJvd4LiuhaizijLttI=
X-Google-Smtp-Source: AGHT+IG5nXCsjWaR4AsUEv0RKaF7zFUYcGHnpQ+SqkUjFGSRHZlNHvOI3aha9sg5lEdUewtBLKisZQ==
X-Received: by 2002:a05:6e02:1c08:b0:34f:3651:9c74 with SMTP id l8-20020a056e021c0800b0034f36519c74mr940900ilh.0.1693987901497;
        Wed, 06 Sep 2023 01:11:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c8-20020a92cf08000000b0034bad471d1fsm4723496ilo.3.2023.09.06.01.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 01:11:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <081537c0-0d74-0242-451a-e6bd6f71cdd9@roeck-us.net>
Date:   Wed, 6 Sep 2023 01:11:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] lockdep: Fix static memory detection even more
To:     Helge Deller <deller@gmx.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-parisc@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <ZNep5EcYskP9HtGD@p100>
 <b7526bf6-886f-457a-beba-84ae9f75bc77@roeck-us.net> <ZPT2cINsHd+sWJQU@ls3530>
 <78473084-d4d5-685f-9778-4bbe8878a43e@roeck-us.net> <ZPgnslFTlwImJ+Aq@ls3530>
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ZPgnslFTlwImJ+Aq@ls3530>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 00:18, Helge Deller wrote:
> * Guenter Roeck <linux@roeck-us.net>:
>> On 9/3/23 14:11, Helge Deller wrote:
>>> * Guenter Roeck <linux@roeck-us.net>:
>>>> Hi,
>>>>
>>>> On Sat, Aug 12, 2023 at 05:48:52PM +0200, Helge Deller wrote:
>>>>> On the parisc architecture, lockdep reports for all static objects which
>>>>> are in the __initdata section (e.g. "setup_done" in devtmpfs,
>>>>> "kthreadd_done" in init/main.c) this warning:
>>>>>
>>>>> 	INFO: trying to register non-static key.
>>>>>
>>>>> The warning itself is wrong, because those objects are in the __initdata
>>>>> section, but the section itself is on parisc outside of range from
>>>>> _stext to _end, which is why the static_obj() functions returns a wrong
>>>>> answer.
>>>>>
>>>>> While fixing this issue, I noticed that the whole existing check can
>>>>> be simplified a lot.
>>>>> Instead of checking against the _stext and _end symbols (which include
>>>>> code areas too) just check for the .data and .bss segments (since we check a
>>>>> data object). This can be done with the existing is_kernel_core_data()
>>>>> macro.
>>>>>
>>>>> In addition objects in the __initdata section can be checked with
>>>>> init_section_contains().
>>>>>
>>>>> This partly reverts and simplifies commit bac59d18c701 ("x86/setup: Fix static
>>>>> memory detection").
>>>>>
>>>>> Tested on x86-64 and parisc.
>>>>>
>>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>>> Fixes: bac59d18c701 ("x86/setup: Fix static memory detection")
>>>>
>>>> On loongarch, this patch results in the following backtrace.
>>>>
>>>> EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
>>>> EFI stub: Exiting boot services
>>>> [    0.000000] INFO: trying to register non-static key.
>>>> [    0.000000] The code is fine but needs lockdep annotation, or maybe
>>>> [    0.000000] you didn't initialize this object before use?
>>>> [    0.000000] turning off the locking correctness validator.
>>>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.5.0+ #1
>>>> [    0.000000] Stack : 0000000000000000 0000000000000000 9000000000223d6c 9000000001df0000
>>>> [    0.000000]         9000000001df39a0 9000000001df39a8 0000000000000000 0000000000000000
>>>> [    0.000000]         9000000001df39a8 0000000000000001 0000000000000000 900000000154b910
>>>> [    0.000000]         fffffffffffffffe 9000000001df39a8 0000000000000000 0000000000000000
>>>> [    0.000000]         0000000000000001 0000000000000003 0000000000000010 0000000000000030
>>>> [    0.000000]         0000000000000063 0000000000000001 0000000000000000 0000000000000000
>>>> [    0.000000]         0000000000000000 0000000000000000 9000000001c60650 9000000001e12000
>>>> [    0.000000]         0000000000000000 9000000001560bc0 0000000000000000 9000000002ee6000
>>>> [    0.000000]         0000000000000000 0000000000000000 9000000000223d84 0000000000000000
>>>> [    0.000000]         00000000000000b0 0000000000000004 0000000000000000 0000000000000800
>>>> [    0.000000]         ...
>>>> [    0.000000] Call Trace:
>>>> [    0.000000] [<9000000000223d84>] show_stack+0x5c/0x180
>>>> [    0.000000] [<900000000153e0b4>] dump_stack_lvl+0x88/0xd0
>>>> [    0.000000] [<90000000002bc548>] register_lock_class+0x768/0x770
>>>> [    0.000000] [<90000000002bc710>] __lock_acquire+0xb0/0x2a18
>>>> [    0.000000] [<90000000002bba1c>] lock_acquire+0x11c/0x328
>>>> [    0.000000] [<9000000000b34a60>] __debug_object_init+0x60/0x244
>>>> [    0.000000] [<9000000000337f94>] init_cgroup_housekeeping+0xe8/0x144
>>>> [    0.000000] [<900000000033e364>] init_cgroup_root+0x38/0xa0
>>>> [    0.000000] [<90000000017801ac>] cgroup_init_early+0x44/0x16c
>>>> [    0.000000] [<9000000001770758>] start_kernel+0x50/0x624
>>>> [    0.000000] [<90000000015410b4>] kernel_entry+0xb4/0xc4
>>>>
>>>> Reverting it fixes the problem. Bisect log attached.
>>>>
>>>> This is also seen in v6.5.y and v6.4.y since the patch has been applied
>>>> to those branches.
>>>
>>> Does this happens with CONFIG_SMP=n ?
>>> If so, I think the untested patch below might fix the issue.
>>>
>>
>> No, this is loongarch:defconfig with various debug options enabled.
>> That has CONFIG_SMP=y.
> 
> Could you apply below patch and verify with the contents of the
> System.map file where the lock is located ?
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index e85b5ad3e206..db0a301f9740 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -969,7 +969,7 @@ static bool assign_lock_key(struct lockdep_map *lock)
>   	else {
>   		/* Debug-check: all keys must be persistent! */
>   		debug_locks_off();
> -		pr_err("INFO: trying to register non-static key.\n");
> +		pr_err("INFO: trying to register non-static key at %08lx.\n", addr);
>   		pr_err("The code is fine but needs lockdep annotation, or maybe\n");
>   		pr_err("you didn't initialize this object before use?\n");
>   		pr_err("turning off the locking correctness validator.\n");

90000000015602d0 D __la_abs_end
...
90000000016815c0 d fill_pool_map.3  <--- lock pointer
...
9000000001770000 T __init_begin

Guenter

