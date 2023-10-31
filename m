Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758F27DCEAF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjJaOGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343903AbjJaOE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:04:27 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB804F1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:04:24 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4084b0223ccso44213945e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698761063; x=1699365863;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/iBDemj5iD48Dwp+0TNRzwUY7I+bvfnQkaiGrk0dhI=;
        b=CJQgs8FM85Td+rJe+UW5ejy+qUfRTmIJfleFxppSlhQ7WAW50OkOXimkALCLh/3bNR
         0Ew5HWmoKA+kekEkj3ZwJXOlUIGs1TBDtiDX3jjsA2SO2Ohh0rUzD2MHPusLLh6JDXtC
         CWxDGxzaOyG4MDE2KNFyKz8qftiOdAmJFmpw7moPJx7hMZtSgXH05B+IPE2CtltrpLA1
         +8+I/mZRAQxHU/pY0GZ8ReedqNmU7Lw11D1Xr1pA00dqrDzLunDqWw9WOwSfWAQpnN+d
         L+4/k+vTcUbGf4EfSkNwPfB8rEaeVpK5n3bER3RtUWA2StxrPOQVfzs+sflvqzWK90Kk
         PnQA==
X-Gm-Message-State: AOJu0YyZqcCp3yTWaTvvNmnViCyw1SSBHjrzq2wFPi0DaEw7iqTywSS7
        bnAYu/2rDR540CJUkVxjTHVi6ooPvkw=
X-Google-Smtp-Source: AGHT+IH3vhsEQPso/0UPi/G9Yl4n2dQoFPeMsnwgOJNDqxaG95uRdR8zYxz3TdOh3KrGsoWSiNYPWQ==
X-Received: by 2002:a05:600c:4750:b0:408:3d91:8251 with SMTP id w16-20020a05600c475000b004083d918251mr10364781wmo.5.1698761063137;
        Tue, 31 Oct 2023 07:04:23 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c475500b00403b63e87f2sm1864176wmo.32.2023.10.31.07.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 07:04:22 -0700 (PDT)
Message-ID: <786d3451-e3ac-4868-8d8b-28f106e13407@kernel.org>
Date:   Tue, 31 Oct 2023 15:04:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: Let AS_WRUSS depend on X86_64
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, bp@alien8.de
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
References: <20231031102111.32142-1-jirislaby@kernel.org>
 <2b345b1c-73ce-4719-812f-ce638f665f77@intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <2b345b1c-73ce-4719-812f-ce638f665f77@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31. 10. 23, 14:53, Dave Hansen wrote:
> On 10/31/23 03:21, Jiri Slaby (SUSE) wrote:
> ...
>> Provided the wruss instruction is 64-bit only (and used in pure 64-bit
>> X86_USER_SHADOW_STACK), it has little sense to have AS_WRUSS=y set on
>> 32-bit.
>>
>> Therefore, make the whole test dependent on X86_64 to ensure it's set
>> only on 64-bit.
> ...
>>   config AS_WRUSS
>>   	def_bool $(as-instr,wrussq %rax$(comma)(%rbx))
>> +	depends on X86_64
>>   	help
>>   	  Supported by binutils >= 2.31 and LLVM integrated assembler
> 
> What's the downside to just leaving this alone?
> 
> This patch just seems wrong logically.  Suppose some deranged person
> wanted 32-bit shadow stack support.  They'd have to go hunt this down
> via trial and error instead of just enabling X86_USER_SHADOW_STACK.

All wrussq, rax, rbx can never be right on 32-bit anyway...

> Granted, that would take one crazy person five minutes to figure out why
> their .config is broken, but it still seems wrong.  It's especially
> wrong without a comment because it logically reads something along the
> lines of "WRUSS is only available on x86_64 configs".

Which is right, or what am I missing?

> A better way to do this would be:
> 
> config HAS_SHADOW_STACKS
> 	depends on X86_64
> 
> config AS_WRUSS
> 	...
> 	# Avoid setting AS_WRUSS on configs that don't need it:
> 	depends on HAS_SHADOW_STACKS
> 
> config X86_USER_SHADOW_STACK
>          bool "X86 userspace shadow stack"
>          depends on AS_WRUSS
>          depends on HAS_SHADOW_STACKS
> 
> But that honestly doesn't seem worth it because (circling back to the
> first thing I wrote...) I don't really know what the benefit is to doing
> this in the first place.

Again, to avoid nonsense in 32bit configs produced by oldconfig (as I 
noted in the commit log).

thanks,
-- 
js
suse labs

