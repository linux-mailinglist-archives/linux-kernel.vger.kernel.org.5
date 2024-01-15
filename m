Return-Path: <linux-kernel+bounces-26013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE7382D9E8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABDE4281129
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B3D171A2;
	Mon, 15 Jan 2024 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bCwzKauS"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C229915AF6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e8004629bso2593005e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 05:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705324785; x=1705929585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q0v/N0kXAbnUMy0XtXE3gHSioK80yxhIhWRK0FxbIKw=;
        b=bCwzKauSqoUAHcrWeskUkjjC1uVaGrYEfkD+QwbJa7by8Ws7H7SzY+RlmkgqfPpvpn
         xjwe6U69enKFSbdBLzk014iiza9a2tGlMO7bi+VFz//bs4B43YDB3ZL//G+aGoJ/ofjh
         ZDRZvPYM8muX3M1zd2+nVq0UY20vKm181YpXxUv90QBz0RRsAuBj/pBYiNxlSg3pphpK
         7sUkA8L9A89QtaZhkheGyIdPOZxXiFP7+EeT6SQ77SY9/aBQDsCoMrD1PY08p8tHtUyM
         GSzRKFd7BsK5gwVtBLzNdMBoDkZAlk2YT/q2XxENb59UFcYTrLL51KjjmqH5o1EbGWSx
         bE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705324785; x=1705929585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0v/N0kXAbnUMy0XtXE3gHSioK80yxhIhWRK0FxbIKw=;
        b=f7qmoZ2RELAh0nZBhopYjvCiPM825V/ns8VQvWpf++hpL3jUbIymlPqN9OHg1Vww0E
         9l+Co2JpEepIN8JusWVdSM+7aCpZoi68k7FOSSICBQyct02UnBZhXC3o59mL7TwjvlgO
         Uxv7UUH1CbplbH0ek6q0Z9cgoKG6+s01aVL2Jc11Q6VoV6nuKDTz7/jSigi5u0VoXG51
         4eAbr4EdtNZPiIo/kLVymfoRZZ+Z0BAbVQ6GVG+2LBMnodIqejI2kvyfUXM8bXbZc0I3
         l6P/VA4LIBE3D4W4VIqFBtZnQlm6ywzYvI0iPDn8d8szXkeIzPc4lmMXmnaKZu/2Bs8x
         NSIw==
X-Gm-Message-State: AOJu0YwxFv93RQ3cefW2Dxd/6+KvwVk6SN0pNAnhCpeoBjgptUboVPwT
	RD4vbwa/i/kUk/mNom/iBKzh1jCTpUtoEg==
X-Google-Smtp-Source: AGHT+IEmfou+SJJzbucaZzJYGOu0aKAR3E1mpvl8rhNlPReIy38XcB//GKFyZHBfkSGj9VIw/SMfNQ==
X-Received: by 2002:a05:600c:295:b0:40e:5f22:3d1b with SMTP id 21-20020a05600c029500b0040e5f223d1bmr1871631wmk.72.1705324785015;
        Mon, 15 Jan 2024 05:19:45 -0800 (PST)
Received: from ?IPV6:2a10:bac0:b000:7588:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7588:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c470400b0040e5945307esm16032865wmo.40.2024.01.15.05.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 05:19:44 -0800 (PST)
Message-ID: <fa1e3873-6218-461b-85fa-1ff353380532@suse.com>
Date: Mon, 15 Jan 2024 15:19:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 16/16] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
 <20231222235209.32143-17-kirill.shutemov@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20231222235209.32143-17-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23.12.23 г. 1:52 ч., Kirill A. Shutemov wrote:
> MADT Multiprocessor Wakeup structure version 1 brings support of CPU
> offlining: BIOS provides a reset vector where the CPU has to jump to
> for offlining itself. The new TEST mailbox command can be used to test
> whether the CPU offlined itself which means the BIOS has control over
> the CPU and can online it again via the ACPI MADT wakeup method.
> 
> Add CPU offling support for the ACPI MADT wakeup method by implementing
> custom cpu_die(), play_dead() and stop_this_cpu() SMP operations.
> 
> CPU offlining makes is possible to hand over secondary CPUs over kexec,
> not limiting the second kernel to a single CPU.
> 
> The change conforms to the approved ACPI spec change proposal. See the
> Link.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Link: https://lore.kernel.org/all/13356251.uLZWGnKmhe@kreacher
> ---
>   arch/x86/include/asm/acpi.h          |   2 +
>   arch/x86/kernel/acpi/Makefile        |   2 +-
>   arch/x86/kernel/acpi/madt_playdead.S |  29 +++++
>   arch/x86/kernel/acpi/madt_wakeup.c   | 184 ++++++++++++++++++++++++++-
>   include/acpi/actbl2.h                |  15 ++-
>   5 files changed, 228 insertions(+), 4 deletions(-)
>   create mode 100644 arch/x86/kernel/acpi/madt_playdead.S
> 
> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> index 2625b915ae7f..021cafa214c2 100644
> --- a/arch/x86/include/asm/acpi.h
> +++ b/arch/x86/include/asm/acpi.h
> @@ -81,6 +81,8 @@ union acpi_subtable_headers;
>   int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
>   			      const unsigned long end);
>   
> +void asm_acpi_mp_play_dead(u64 reset_vector, u64 pgd_pa);
> +
>   /*
>    * Check if the CPU can handle C2 and deeper
>    */
> diff --git a/arch/x86/kernel/acpi/Makefile b/arch/x86/kernel/acpi/Makefile
> index 8c7329c88a75..37b1f28846de 100644
> --- a/arch/x86/kernel/acpi/Makefile
> +++ b/arch/x86/kernel/acpi/Makefile
> @@ -4,7 +4,7 @@ obj-$(CONFIG_ACPI)			+= boot.o
>   obj-$(CONFIG_ACPI_SLEEP)		+= sleep.o wakeup_$(BITS).o
>   obj-$(CONFIG_ACPI_APEI)			+= apei.o
>   obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
> -obj-$(CONFIG_X86_ACPI_MADT_WAKEUP)	+= madt_wakeup.o
> +obj-$(CONFIG_X86_ACPI_MADT_WAKEUP)	+= madt_wakeup.o madt_playdead.o
>   
>   ifneq ($(CONFIG_ACPI_PROCESSOR),)
>   obj-y					+= cstate.o
> diff --git a/arch/x86/kernel/acpi/madt_playdead.S b/arch/x86/kernel/acpi/madt_playdead.S
> new file mode 100644
> index 000000000000..e48049959513
> --- /dev/null
> +++ b/arch/x86/kernel/acpi/madt_playdead.S
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <linux/linkage.h>
> +#include <asm/nospec-branch.h>
> +#include <asm/page_types.h>
> +#include <asm/processor-flags.h>
> +
> +	.text
> +	.align PAGE_SIZE
> +
> +/*
> + * asm_acpi_mp_play_dead() - Hand over control of the CPU to the BIOS
> + *
> + * rdi: Address of the ACPI MADT MPWK ResetVector
> + * rsi: PGD of the identity mapping
> + */
> +SYM_FUNC_START(asm_acpi_mp_play_dead)
> +	/* Turn off global entries. Following CR3 write will flush them. */
> +	movq	%cr4, %rdx
> +	andq	$~(X86_CR4_PGE), %rdx
> +	movq	%rdx, %cr4
> +
> +	/* Switch to identity mapping */
> +	movq	%rsi, %rax
> +	movq	%rax, %cr3

nit: Can't you move directly to cr3

> +
> +	/* Jump to reset vector */
> +	ANNOTATE_RETPOLINE_SAFE
> +	jmp	*%rdi
> +SYM_FUNC_END(asm_acpi_mp_play_dead)

<snip>

