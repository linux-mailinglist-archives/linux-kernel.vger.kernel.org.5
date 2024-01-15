Return-Path: <linux-kernel+bounces-25904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9598D82D7D8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD59DB213E5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05DB1E86D;
	Mon, 15 Jan 2024 10:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZQtVH8T6"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D3418E00
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3377d45c178so3751702f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 02:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705316025; x=1705920825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9pR96MCcFBbAOBcPEV4qXfMgedzTlkO8zl1DrKszMlM=;
        b=ZQtVH8T6f0SeHWPggv/s0QSbOH2+rtYFo5yg/+mk0PyRchb1egHYBY5Dh2jIeanWfQ
         QaxCiBLsMeWtqkfVPKp4WZv/yCOwWZ7XUxo/ATRGh/lHjJhuia60v6dQXkN36EjAAXzU
         7SuoZeZF2uqUrAXQlg32FQgMdQ9jjSqelzY/e/RnrK+apt05BiwEK7M671Vh4fvVxDuh
         fdAgYq8irQ67Xjen2LU6k9F2ZS7W/MiANgaBYA/zSXeXZRAVAD91ZW38l1sKULbzWnMB
         m/wRihOXZ1zSgAT43hqmCUq3LDvqcdFu7+jWuv93cXksgI1qfHK6Nfgjvc5bzd2VHH0S
         1hxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705316025; x=1705920825;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9pR96MCcFBbAOBcPEV4qXfMgedzTlkO8zl1DrKszMlM=;
        b=mzc9GszVxEXfv5CrjjSzlqkiZlwRWJQqkljlueQ4B2WkTXvqcJ7XuzYFI+4zbUEaau
         NHqbnR9vDia6FA1jWFIjdh2xY2wyvPfP0y1aCIhNJqlhfPuv2veG3ekChgmDzfwIqnAx
         iOkeBXmR4LF5NQfk4Sl9TnZI6WlbY55uO7VQba29Fivk7AcViSkUa9WYqEDEa/qOV81v
         AL5FsoIed6Tsb78PwpycGJjYL4ErjppmR4yVbXoyo2p8ApWpzm+FORBY2j4hhyMNB9VH
         YVdHmXNaWkRj1lincLN63UTTWKIryMnP2Z6VbcavduvBxe1a8e+16EU2Ul/00Oxy1qKO
         Gipg==
X-Gm-Message-State: AOJu0YysVXOOwW6L9QxdxVzdWz5gfCZbH9IJPFLQ6lXLXycmzUnUCb5A
	93sFblfylhzwRadsg1E6BsaTu7yMfpG7ZA==
X-Google-Smtp-Source: AGHT+IEWE40Myl6wet6SyKd3nOM1KtbkgYXbne0nQwhV6e6E13uytwtXotiT8hRihtXjCQ7aqzpVHg==
X-Received: by 2002:a05:6000:1567:b0:337:8da4:efde with SMTP id 7-20020a056000156700b003378da4efdemr4174920wrz.80.1705316025082;
        Mon, 15 Jan 2024 02:53:45 -0800 (PST)
Received: from ?IPV6:2a10:bac0:b000:7588:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7588:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id d16-20020adf9c90000000b003366c058509sm11529791wre.23.2024.01.15.02.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 02:53:44 -0800 (PST)
Message-ID: <89e8722b-661b-4319-8018-06705b366c62@suse.com>
Date: Mon, 15 Jan 2024 12:53:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 10/16] x86/tdx: Convert shared memory back to private on
 kexec
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
 <20231222235209.32143-11-kirill.shutemov@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20231222235209.32143-11-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23.12.23 г. 1:52 ч., Kirill A. Shutemov wrote:
> TDX guests allocate shared buffers to perform I/O. It is done by
> allocating pages normally from the buddy allocator and converting them
> to shared with set_memory_decrypted().
> 
> The second kernel has no idea what memory is converted this way. It only
> sees E820_TYPE_RAM.
> 
> Accessing shared memory via private mapping is fatal. It leads to
> unrecoverable TD exit.
> 
> On kexec walk direct mapping and convert all shared memory back to
> private. It makes all RAM private again and second kernel may use it
> normally.
> 
> The conversion occurs in two steps: stopping new conversions and
> unsharing all memory. In the case of normal kexec, the stopping of
> conversions takes place while scheduling is still functioning. This
> allows for waiting until any ongoing conversions are finished. The
> second step is carried out when all CPUs except one are inactive and
> interrupts are disabled. This prevents any conflicts with code that may
> access shared memory.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>   arch/x86/coco/tdx/tdx.c         | 119 +++++++++++++++++++++++++++++++-
>   arch/x86/include/asm/x86_init.h |   2 +
>   arch/x86/kernel/crash.c         |   6 ++
>   arch/x86/kernel/reboot.c        |  13 ++++
>   4 files changed, 138 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 8a49484a2917..5c64db168edd 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -6,8 +6,10 @@
>   
>   #include <linux/cpufeature.h>
>   #include <linux/debugfs.h>
> +#include <linux/delay.h>
>   #include <linux/export.h>
>   #include <linux/io.h>
> +#include <linux/kexec.h>
>   #include <asm/coco.h>
>   #include <asm/tdx.h>
>   #include <asm/vmx.h>
> @@ -15,6 +17,7 @@
>   #include <asm/insn.h>
>   #include <asm/insn-eval.h>
>   #include <asm/pgtable.h>
> +#include <asm/set_memory.h>
>   
>   /* MMIO direction */
>   #define EPT_READ	0
> @@ -41,6 +44,9 @@
>   
>   static atomic_long_t nr_shared;
>   
> +static atomic_t conversions_in_progress;
> +static bool conversion_allowed = true;

Given the usage model of this variable, shouldn't it be simply accessed 
via READ/WRITE_ONCE macros?

> +
>   static inline bool pte_decrypted(pte_t pte)
>   {
>   	return cc_mkdec(pte_val(pte)) == pte_val(pte);
> @@ -726,6 +732,14 @@ static bool tdx_tlb_flush_required(bool private)
>   
>   static bool tdx_cache_flush_required(void)
>   {
> +	/*
> +	 * Avoid issuing CLFLUSH on set_memory_decrypted() if conversions
> +	 * stopped. Otherwise it can race with unshare_all_memory() and trigger
> +	 * implicit conversion to shared.
> +	 */
> +	if (!conversion_allowed)
> +		return false;
> +
>   	/*
>   	 * AMD SME/SEV can avoid cache flushing if HW enforces cache coherence.
>   	 * TDX doesn't have such capability.
> @@ -809,12 +823,25 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
>   static int tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
>   					 bool enc)
>   {
> +	atomic_inc(&conversions_in_progress);
> +
> +	/*
> +	 * Check after bumping conversions_in_progress to serialize
> +	 * against tdx_shutdown().
> +	 */
> +	if (!conversion_allowed) {
> +		atomic_dec(&conversions_in_progress);
> +		return -EBUSY;
> +	}

nit: Can you make the inc of conversions_in_progress be done here, this 
eliminated the atomic_dec in case they aren't. Somewhat simplifies the 
logic.
> +
>   	/*
>   	 * Only handle shared->private conversion here.
>   	 * See the comment in tdx_early_init().
>   	 */
> -	if (enc && !tdx_enc_status_changed(vaddr, numpages, enc))
> +	if (enc && !tdx_enc_status_changed(vaddr, numpages, enc)) {
> +		atomic_dec(&conversions_in_progress);
>   		return -EIO;
> +	}
>   
>   	return 0;
>   }
> @@ -826,17 +853,102 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
>   	 * Only handle private->shared conversion here.
>   	 * See the comment in tdx_early_init().
>   	 */
> -	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc))
> +	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc)) {
> +		atomic_dec(&conversions_in_progress);
>   		return -EIO;
> +	}
>   
>   	if (enc)
>   		atomic_long_sub(numpages, &nr_shared);
>   	else
>   		atomic_long_add(numpages, &nr_shared);
>   
> +	atomic_dec(&conversions_in_progress);
> +
>   	return 0;
>   }
>   
> +static void tdx_kexec_stop_conversion(bool crash)
> +{
> +	/* Stop new private<->shared conversions */
> +	conversion_allowed = false;

What's the logic behind this compiler barrier?

> +	barrier();
> +
> +	/*
> +	 * Crash kernel reaches here with interrupts disabled: can't wait for
> +	 * conversions to finish.
> +	 *
> +	 * If race happened, just report and proceed.
> +	 */
> +	if (!crash) {
> +		unsigned long timeout;
> +
> +		/*
> +		 * Wait for in-flight conversions to complete.
> +		 *
> +		 * Do not wait more than 30 seconds.
> +		 */
> +		timeout = 30 * USEC_PER_SEC;
> +		while (atomic_read(&conversions_in_progress) && timeout--)
> +			udelay(1);
> +	}
> +
> +	if (atomic_read(&conversions_in_progress))
> +		pr_warn("Failed to finish shared<->private conversions\n");
> +}
> +

<snip>

> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
> index c9503fe2d13a..3196ff20a29e 100644
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -154,6 +154,8 @@ struct x86_guest {
>   	int (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
>   	bool (*enc_tlb_flush_required)(bool enc);
>   	bool (*enc_cache_flush_required)(void);
> +	void (*enc_kexec_stop_conversion)(bool crash);
> +	void (*enc_kexec_unshare_mem)(void);

These are only being initialized in the TDX case, but called in all 
cases when CC_ATTR_GUEST_MEM_ENCRYPT is true, which includes AMD. So it 
would cause a crash, no ? Shouldn't you also introduce noop handlers 
initialized in the default x86_platform struct in 
arch/x86/kernel/x86_init.c ?

>   };
>   
>   /**
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index c92d88680dbf..b99bd28ad22f 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -40,6 +40,7 @@
>   #include <asm/intel_pt.h>
>   #include <asm/crash.h>
>   #include <asm/cmdline.h>
> +#include <asm/tdx.h>
>   
>   /* Used while preparing memory map entries for second kernel */
>   struct crash_memmap_data {
> @@ -107,6 +108,11 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>   
>   	crash_smp_send_stop();
>   
> +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
> +		x86_platform.guest.enc_kexec_stop_conversion(true);
> +		x86_platform.guest.enc_kexec_unshare_mem();
> +	}
> +
>   	cpu_emergency_disable_virtualization();
>   
>   	/*
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index 830425e6d38e..16dde83df49a 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -12,6 +12,7 @@
>   #include <linux/delay.h>
>   #include <linux/objtool.h>
>   #include <linux/pgtable.h>
> +#include <linux/kexec.h>
>   #include <acpi/reboot.h>
>   #include <asm/io.h>
>   #include <asm/apic.h>
> @@ -31,6 +32,7 @@
>   #include <asm/realmode.h>
>   #include <asm/x86_init.h>
>   #include <asm/efi.h>
> +#include <asm/tdx.h>
>   
>   /*
>    * Power off function, if any
> @@ -716,6 +718,14 @@ static void native_machine_emergency_restart(void)
>   
>   void native_machine_shutdown(void)
>   {
> +	/*
> +	 * Call enc_kexec_stop_conversion() while all CPUs are still active and
> +	 * interrupts are enabled. This will allow all in-flight memory
> +	 * conversions to finish cleanly.
> +	 */
> +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) && kexec_in_progress)
> +		x86_platform.guest.enc_kexec_stop_conversion(false);
> +
>   	/* Stop the cpus and apics */
>   #ifdef CONFIG_X86_IO_APIC
>   	/*
> @@ -752,6 +762,9 @@ void native_machine_shutdown(void)
>   #ifdef CONFIG_X86_64
>   	x86_platform.iommu_shutdown();
>   #endif
> +
> +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) && kexec_in_progress)
> +		x86_platform.guest.enc_kexec_unshare_mem();
>   }
>   
>   static void __machine_emergency_restart(int emergency)

