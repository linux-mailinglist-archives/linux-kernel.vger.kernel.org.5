Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F16880AC53
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjLHSm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHSm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:42:26 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5139311F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:42:32 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c0a0d068bso24088555e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 10:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1702060951; x=1702665751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z9+wgiQYw9MwXmDGl7oIki00XhYRzJER6P4/V/uuv24=;
        b=V+osavE2ssMAdN7t0ZkmhmU5lk8CJLugoeoMe4xRjSFUig+HQm57QmfNzGLLD+ydos
         sqMeomDicaQaVdBMp+F94ahgoSTORU+u0NSLvXjwit9JrOkee/MdKLsfqi76dvp3mgCN
         EBh6WymwFYJdm7GmGnLGkwexCNvbVucHi+kq2D69yb9k7tkZhqQpgZyq4rT/srV5uHz8
         VGib50Ptf1mMQR01VgCDOAVSZl2K4MAfGgr6xXfakgDcD+xnR9qCSLVxq9uWav0qSWY7
         jJJmyPWM25qzJnZJcKAC4ElSaj9n1bZgIEceT57PhMmL+iS7+At0koI+yqySYW56WYXE
         J/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702060951; x=1702665751;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9+wgiQYw9MwXmDGl7oIki00XhYRzJER6P4/V/uuv24=;
        b=gi18cHrCT0GT7ZIfQ/sBfptiauU4r/3yuiZR8bOKUf1I8QVkCfgbB7PK7IN35BcREL
         1TFWKJrGnv6PtBLcaW6/3Nhi/N1ShxmLW5QBoPbESYtI8JVZE74jsi7N0RTJYFHpc4Ek
         jPxBksXHzfqpLk6atF3vWxMvufhxBs0CIv1sJNjgFgF/7BsmoiEw2K1jaqZA3ea+Zjtb
         a77DcSzCQxypJjvD72uWNM4EZtWmdXrXmzBNqHhDMYw3aQoVHCKHh5eYCU/4dMyQ5hAU
         +Aq4ZU96faaG1fPDKNIfCXmaqyVaTQkQ3OhEc2ApYcrpGC/9ucN//3T4paenlMqeG4hN
         kYVw==
X-Gm-Message-State: AOJu0YyrkYAPqBAWRdDE4mvm2PqnMYXCF3/5dXIosFIP867WAyOoQ1jh
        UlFkiPyiCdbRsuG+s6aawshg1dP6ul8v2gAyi7WRlA==
X-Google-Smtp-Source: AGHT+IEIGCxu6hDqM/0xD9X4x3SDlyJhwQVoy7VF2n4Xo91gKIPnq9lFOhR1LSzLJNZsER24f/UNKw==
X-Received: by 2002:a7b:c44f:0:b0:40b:5e22:963 with SMTP id l15-20020a7bc44f000000b0040b5e220963mr223153wmi.82.1702060950715;
        Fri, 08 Dec 2023 10:42:30 -0800 (PST)
Received: from ?IPV6:2a10:bac0:b000:731f:e6b0:e567:aab6:1db2? ([2a10:bac0:b000:731f:e6b0:e567:aab6:1db2])
        by smtp.gmail.com with ESMTPSA id bd19-20020a05600c1f1300b0040839fcb217sm3708041wmb.8.2023.12.08.10.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 10:42:30 -0800 (PST)
Message-ID: <4f232dfb-a112-4271-8f43-f85a02c4abeb@suse.com>
Date:   Fri, 8 Dec 2023 20:42:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v2] x86/ia32: State that IA32 emulation is disabled
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20231130155213.1407-1-bp@alien8.de>
 <20231130160903.GJZWizn+dPaaViFVKN@fat_crate.local>
 <20231206172022.GCZXCtVoZtt4t2TLpe@fat_crate.local>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20231206172022.GCZXCtVoZtt4t2TLpe@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.12.23 г. 19:20 ч., Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Thu, 30 Nov 2023 16:39:33 +0100
> 
> Issue a short message once, on the first try to load a 32-bit process to
> save people time when wondering why it won't load and trying to execute
> it, would say:
> 
>    -bash: ./strsep32: cannot execute binary file: Exec format error
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: Nikolay Borisov <nik.borisov@suse.com>

LGTM:

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>


> ---
>   arch/x86/include/asm/elf.h  |  2 +-
>   arch/x86/include/asm/ia32.h | 11 ++++++++++-
>   2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> index a0234dfd1031..1e16bd5ac781 100644
> --- a/arch/x86/include/asm/elf.h
> +++ b/arch/x86/include/asm/elf.h
> @@ -150,7 +150,7 @@ do {						\
>   	((x)->e_machine == EM_X86_64)
>   
>   #define compat_elf_check_arch(x)					\
> -	((elf_check_arch_ia32(x) && ia32_enabled()) ||			\
> +	((elf_check_arch_ia32(x) && ia32_enabled_verbose()) ||		\
>   	 (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine == EM_X86_64))
>   
>   static inline void elf_common_init(struct thread_struct *t,
> diff --git a/arch/x86/include/asm/ia32.h b/arch/x86/include/asm/ia32.h
> index 5a2ae24b1204..094886a8717e 100644
> --- a/arch/x86/include/asm/ia32.h
> +++ b/arch/x86/include/asm/ia32.h
> @@ -2,7 +2,6 @@
>   #ifndef _ASM_X86_IA32_H
>   #define _ASM_X86_IA32_H
>   
> -
>   #ifdef CONFIG_IA32_EMULATION
>   
>   #include <linux/compat.h>
> @@ -84,4 +83,14 @@ static inline bool ia32_enabled(void)
>   
>   #endif
>   
> +static inline bool ia32_enabled_verbose(void)
> +{
> +	bool enabled = ia32_enabled();
> +
> +	if (IS_ENABLED(CONFIG_IA32_EMULATION) && !enabled)

nit: But why check config_ia32_emulation explicitly, its state should 
already be accounted for in ia32_enabled's value? So this check can 
simply be 'if (!enabled)'

> +		pr_notice_once("32-bit emulation disabled. You can reenable with ia32_emulation=on\n");
> +
> +	return enabled;
> +}
> +
>   #endif /* _ASM_X86_IA32_H */
