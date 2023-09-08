Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0534799148
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242173AbjIHUwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbjIHUwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:52:12 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A0B1FE0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 13:52:08 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68c0d4cc3a4so2201514b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 13:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694206327; x=1694811127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VDbHt9ZjxbWg0OnwI6q2vK5uaDqhBGdPDoTGYH2kvhs=;
        b=iPGzDLQb4z8fmv6qaVAu9JkFZv6kgtWc6fgkOyQA3hiaUWuG8tADPGWTlVU+qJvJwA
         A+iOuhGH2A3ZKoOaqHqceF1fwUwnumlH66pnQVQXmZ21a4w0chAuY2SM9vjJ+Qol4J5F
         BqZepDzHnqtZ2zW8Qdfa7QdJ3Eh+buiGfK6D0bCJUUnugkOkzl1Fk/e1WU1RofwdV/Bb
         P4dx6XrePBv/zuGT7oeFlkZouVB36jDGws4kML/RcKnlkgWkZMksIiW+f/8HP/CdNkkB
         5PIxzfi58h674DIXjsfEgP6J6H5DKkZi/bzKmJhrqirIAUhlEgMr4fiByFigFQZlBAtu
         w7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694206327; x=1694811127;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDbHt9ZjxbWg0OnwI6q2vK5uaDqhBGdPDoTGYH2kvhs=;
        b=bu1ECf3CnbN9YGxkKC9oInBkV4HTpQ+cyw1Q8t//fagSfqgBMGCij19mDZxtGsn8hQ
         3+trWXMREPntr7p8TCKwpfQeVr0AH1QGJuwzNzzU6t6H5P/qtN4zjCsrlCYa7hLf5sLO
         2Xb36O4oNrbjdukpih8j5rgR1KoUt0S0IcrjBH/SMFzlMHIGhBeiN1G1zZe+iBAILfvo
         vl1T7MFZ1K48nx2ItLigZdB3MjfNy0tQZ5RHmH9IkYqyGjxRE53NECdGUIFFfH8GP/mi
         RqGdOAf2q4LDgA72Oo1bMamhkJX8PwsTm4Z67gc2REFkte85GI74b5RQO8s7G7u7rcRm
         v34g==
X-Gm-Message-State: AOJu0YyT+KkRvADySSEKYE8mklWZSzel661xthqVyOW83l7UZH3ceMOZ
        7aToC1/VY9JmoGNCoLk5WC4=
X-Google-Smtp-Source: AGHT+IE3hfS2KA7c98Htv9+NTlTCBJzkYRjkcPnycGW13NYWt9fF/InbMS0k6WcKTOaP72T/K0kq5w==
X-Received: by 2002:a05:6a21:60f:b0:153:beda:863 with SMTP id ll15-20020a056a21060f00b00153beda0863mr3012237pzb.45.1694206327330;
        Fri, 08 Sep 2023 13:52:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m11-20020aa78a0b000000b0068a53ac9d46sm1667577pfa.100.2023.09.08.13.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 13:52:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e7965d97-48cd-b2ed-328f-c1947121c8e7@roeck-us.net>
Date:   Fri, 8 Sep 2023 13:52:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] lockdep: Fix static memory detection even more
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <ZNep5EcYskP9HtGD@p100>
 <b7526bf6-886f-457a-beba-84ae9f75bc77@roeck-us.net> <ZPT2cINsHd+sWJQU@ls3530>
 <78473084-d4d5-685f-9778-4bbe8878a43e@roeck-us.net> <ZPgnslFTlwImJ+Aq@ls3530>
 <081537c0-0d74-0242-451a-e6bd6f71cdd9@roeck-us.net> <ZPl+Y2vRYUnWtTQc@ls3530>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ZPl+Y2vRYUnWtTQc@ls3530>
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

On 9/7/23 00:40, Helge Deller wrote:
> * Guenter Roeck <linux@roeck-us.net>:
>> On 9/6/23 00:18, Helge Deller wrote:
>>> * Guenter Roeck <linux@roeck-us.net>:
>>>> On 9/3/23 14:11, Helge Deller wrote:
>>>>> * Guenter Roeck <linux@roeck-us.net>:
>>>>>> Hi,
>>>>>>
>>>>>> On Sat, Aug 12, 2023 at 05:48:52PM +0200, Helge Deller wrote:
>>>>>>> On the parisc architecture, lockdep reports for all static objects which
>>>>>>> are in the __initdata section (e.g. "setup_done" in devtmpfs,
>>>>>>> "kthreadd_done" in init/main.c) this warning:
>>>>>>>
>>>>>>> 	INFO: trying to register non-static key.
>>>>>>>
>>>>>>> The warning itself is wrong, because those objects are in the __initdata
>>>>>>> section, but the section itself is on parisc outside of range from
>>>>>>> _stext to _end, which is why the static_obj() functions returns a wrong
>>>>>>> answer.
>>>>>>>
>>>>>>> While fixing this issue, I noticed that the whole existing check can
>>>>>>> be simplified a lot.
>>>>>>> Instead of checking against the _stext and _end symbols (which include
>>>>>>> code areas too) just check for the .data and .bss segments (since we check a
>>>>>>> data object). This can be done with the existing is_kernel_core_data()
>>>>>>> macro.
>>>>>>>
>>>>>>> In addition objects in the __initdata section can be checked with
>>>>>>> init_section_contains().
>>>>>>>
>>>>>>> This partly reverts and simplifies commit bac59d18c701 ("x86/setup: Fix static
>>>>>>> memory detection").
>>>>>>>
>>>>>>> Tested on x86-64 and parisc.
>>>>>>>
>>>>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>>>>> Fixes: bac59d18c701 ("x86/setup: Fix static memory detection")
>>>>>>
>>>>>> On loongarch, this patch results in the following backtrace.
>>>>>>
>>>>>> EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
>>>>>> EFI stub: Exiting boot services
>>>>>> [    0.000000] INFO: trying to register non-static key.
>>>>>> [    0.000000] The code is fine but needs lockdep annotation, or maybe
>>>>>> [    0.000000] you didn't initialize this object before use?
>>>>>> [    0.000000] turning off the locking correctness validator.
>>>>>> [    0.000000]         ...
>>>>>> [    0.000000] Call Trace:
>>>>>> [    0.000000] [<9000000000223d84>] show_stack+0x5c/0x180
>>>>>> [    0.000000] [<900000000153e0b4>] dump_stack_lvl+0x88/0xd0
>>>>>> [    0.000000] [<90000000002bc548>] register_lock_class+0x768/0x770
>>>>>> [    0.000000] [<90000000002bc710>] __lock_acquire+0xb0/0x2a18
>>>>>> [    0.000000] [<90000000002bba1c>] lock_acquire+0x11c/0x328
>>>>>> [    0.000000] [<9000000000b34a60>] __debug_object_init+0x60/0x244
>>>>>> [    0.000000] [<9000000000337f94>] init_cgroup_housekeeping+0xe8/0x144
>>>>>> [    0.000000] [<900000000033e364>] init_cgroup_root+0x38/0xa0
>>>>>> [    0.000000] [<90000000017801ac>] cgroup_init_early+0x44/0x16c
>>>>>> [    0.000000] [<9000000001770758>] start_kernel+0x50/0x624
>>>>>> [    0.000000] [<90000000015410b4>] kernel_entry+0xb4/0xc4
>>>>>>
>>>>>> Reverting it fixes the problem. Bisect log attached.
>>>>>>
>>>>>> This is also seen in v6.5.y and v6.4.y since the patch has been applied
>>>>>> to those branches.
>>>>>
>>>>> Does this happens with CONFIG_SMP=n ?
>>>>> If so, I think the untested patch below might fix the issue.
>>>>>
>>>>
>>>> No, this is loongarch:defconfig with various debug options enabled.
>>>> That has CONFIG_SMP=y.
>>>
>>> Could you apply below patch and verify with the contents of the
>>> System.map file where the lock is located ?
>>>
>>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>>> index e85b5ad3e206..db0a301f9740 100644
>>> --- a/kernel/locking/lockdep.c
>>> +++ b/kernel/locking/lockdep.c
>>> @@ -969,7 +969,7 @@ static bool assign_lock_key(struct lockdep_map *lock)
>>>    	else {
>>>    		/* Debug-check: all keys must be persistent! */
>>>    		debug_locks_off();
>>> -		pr_err("INFO: trying to register non-static key.\n");
>>> +		pr_err("INFO: trying to register non-static key at %08lx.\n", addr);
>>>    		pr_err("The code is fine but needs lockdep annotation, or maybe\n");
>>>    		pr_err("you didn't initialize this object before use?\n");
>>>    		pr_err("turning off the locking correctness validator.\n");
>>
>> 90000000015602d0 D __la_abs_end
>> ...
>> 90000000016815c0 d fill_pool_map.3  <--- lock pointer
>> ...
>> 9000000001770000 T __init_begin
> 
> The problem is, that loongarch's  vmlinux.lds.S file puts data into
> areas which are not marked "data" or "code".
> 
> can you try below patch?
> The relevant part is here the move of ".data.rel : { *(.data.rel*) }"
> into the data section.
> The other parts are suggestions.
> 

The patch below fixes the problem for me.

Guenter

> Helge
> 
> 
> diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
> index b1686afcf876..bb2ec86f37a8 100644
> --- a/arch/loongarch/kernel/vmlinux.lds.S
> +++ b/arch/loongarch/kernel/vmlinux.lds.S
> @@ -53,33 +53,6 @@ SECTIONS
>   	. = ALIGN(PECOFF_SEGMENT_ALIGN);
>   	_etext = .;
>   
> -	/*
> -	 * struct alt_inst entries. From the header (alternative.h):
> -	 * "Alternative instructions for different CPU types or capabilities"
> -	 * Think locking instructions on spinlocks.
> -	 */
> -	. = ALIGN(4);
> -	.altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
> -		__alt_instructions = .;
> -		*(.altinstructions)
> -		__alt_instructions_end = .;
> -	}
> -
> -#ifdef CONFIG_RELOCATABLE
> -	. = ALIGN(8);
> -	.la_abs : AT(ADDR(.la_abs) - LOAD_OFFSET) {
> -		__la_abs_begin = .;
> -		*(.la_abs)
> -		__la_abs_end = .;
> -	}
> -#endif
> -
> -	.got : ALIGN(16) { *(.got) }
> -	.plt : ALIGN(16) { *(.plt) }
> -	.got.plt : ALIGN(16) { *(.got.plt) }
> -
> -	.data.rel : { *(.data.rel*) }
> -
>   	. = ALIGN(PECOFF_SEGMENT_ALIGN);
>   	__init_begin = .;
>   	__inittext_begin = .;
> @@ -94,6 +67,18 @@ SECTIONS
>   
>   	__initdata_begin = .;
>   
> +	/*
> +	 * struct alt_inst entries. From the header (alternative.h):
> +	 * "Alternative instructions for different CPU types or capabilities"
> +	 * Think locking instructions on spinlocks.
> +	 */
> +	. = ALIGN(4);
> +	.altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
> +		__alt_instructions = .;
> +		*(.altinstructions)
> +		__alt_instructions_end = .;
> +	}
> +
>   	INIT_DATA_SECTION(16)
>   	.exit.data : {
>   		EXIT_DATA
> @@ -113,6 +98,11 @@ SECTIONS
>   
>   	_sdata = .;
>   	RO_DATA(4096)
> +
> +	.got : ALIGN(16) { *(.got) }
> +	.plt : ALIGN(16) { *(.plt) }
> +	.got.plt : ALIGN(16) { *(.got.plt) }
> +
>   	RW_DATA(1 << CONFIG_L1_CACHE_SHIFT, PAGE_SIZE, THREAD_SIZE)
>   
>   	.rela.dyn : ALIGN(8) {
> @@ -121,6 +111,17 @@ SECTIONS
>   		__rela_dyn_end = .;
>   	}
>   
> +	.data.rel : { *(.data.rel*) }
> +
> +#ifdef CONFIG_RELOCATABLE
> +	. = ALIGN(8);
> +	.la_abs : AT(ADDR(.la_abs) - LOAD_OFFSET) {
> +		__la_abs_begin = .;
> +		*(.la_abs)
> +		__la_abs_end = .;
> +	}
> +#endif
> +
>   	.sdata : {
>   		*(.sdata)
>   	}
> 

