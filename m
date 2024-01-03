Return-Path: <linux-kernel+bounces-15060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E718226C6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BA59B223F4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77EB4A27;
	Wed,  3 Jan 2024 02:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CT63txv5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921FF4A13
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 02:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=UX067oc02QDIU9lFdARVeeJs/ixm6qZ2B6Eg730Gc/A=; b=CT63txv5IW7iwImvLLydxpE8Nn
	01Hx2r6QecPzXtVTDulJmT+GjFxLdTUJIDFosAtjY8sAltMpih4PDIf/Ox/zzRqodTwjrfgshy168
	U69STW5WzjBzhfqRlJslsaT5qeeaq2K10gBbzRJC7PeFy4tE9x2o1Kl9MZKL+7K9BYJ4b56HGRSLU
	5NXlVgsC0OAatCJB6WFugBOJgsj9/IEYv3BO6me3fjuiqjVRDBRwxbO9wF9pqL6mv8gjJV1HsH1/I
	63PAu9hljX/8/iKsXU/gOGSaDrunFjLc9GAtHCWdXKTaflqdxkJc4FYSdTrM6bT1Bv1P9zuxKQlxW
	vh9o6r/w==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rKqfZ-009Xfj-2T;
	Wed, 03 Jan 2024 02:07:45 +0000
Message-ID: <fc7f44bd-e4e9-42db-abbe-c55469d43506@infradead.org>
Date: Tue, 2 Jan 2024 18:07:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch/x86: Fix typos
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20240103004011.1758650-1-helgaas@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240103004011.1758650-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/2/24 16:40, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos, most reported by "codespell arch/x86".  Only touches comments,
> no code changes.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/x86/boot/compressed/Makefile            | 2 +-
>  arch/x86/boot/compressed/mem.c               | 2 +-
>  arch/x86/coco/tdx/tdx.c                      | 2 +-
>  arch/x86/crypto/aesni-intel_asm.S            | 2 +-
>  arch/x86/crypto/aesni-intel_avx-x86_64.S     | 2 +-
>  arch/x86/crypto/crc32c-pcl-intel-asm_64.S    | 2 +-
>  arch/x86/crypto/sha512-avx-asm.S             | 2 +-
>  arch/x86/crypto/sha512-ssse3-asm.S           | 2 +-
>  arch/x86/events/amd/brs.c                    | 2 +-
>  arch/x86/events/amd/core.c                   | 2 +-
>  arch/x86/events/intel/core.c                 | 2 +-
>  arch/x86/hyperv/hv_apic.c                    | 2 +-
>  arch/x86/hyperv/irqdomain.c                  | 2 +-
>  arch/x86/hyperv/ivm.c                        | 2 +-
>  arch/x86/include/asm/amd_nb.h                | 2 +-
>  arch/x86/include/asm/extable_fixup_types.h   | 2 +-
>  arch/x86/include/asm/fpu/types.h             | 2 +-
>  arch/x86/include/asm/iosf_mbi.h              | 2 +-
>  arch/x86/include/asm/kvm_host.h              | 2 +-
>  arch/x86/include/asm/nospec-branch.h         | 4 ++--
>  arch/x86/include/asm/pgtable_64.h            | 2 +-
>  arch/x86/include/asm/uv/uv_hub.h             | 2 +-
>  arch/x86/include/asm/vdso/gettimeofday.h     | 2 +-
>  arch/x86/include/asm/xen/interface_64.h      | 2 +-
>  arch/x86/include/uapi/asm/amd_hsmp.h         | 2 +-
>  arch/x86/kernel/alternative.c                | 2 +-
>  arch/x86/kernel/amd_gart_64.c                | 2 +-
>  arch/x86/kernel/apic/Makefile                | 2 +-
>  arch/x86/kernel/apic/apic.c                  | 2 +-
>  arch/x86/kernel/apic/vector.c                | 2 +-
>  arch/x86/kernel/cpu/sgx/ioctl.c              | 2 +-
>  arch/x86/kernel/fpu/core.c                   | 2 +-
>  arch/x86/kernel/head_64.S                    | 4 ++--
>  arch/x86/kernel/hpet.c                       | 4 ++--
>  arch/x86/kernel/kvm.c                        | 2 +-
>  arch/x86/kernel/kvmclock.c                   | 2 +-
>  arch/x86/kernel/ldt.c                        | 6 +++---
>  arch/x86/kernel/process.c                    | 2 +-
>  arch/x86/kernel/sev-shared.c                 | 2 +-
>  arch/x86/kvm/cpuid.c                         | 2 +-
>  arch/x86/kvm/mmu/mmu.c                       | 4 ++--
>  arch/x86/kvm/mmu/tdp_iter.c                  | 2 +-
>  arch/x86/kvm/svm/svm.c                       | 2 +-
>  arch/x86/kvm/vmx/nested.c                    | 2 +-
>  arch/x86/kvm/vmx/vmx.c                       | 2 +-
>  arch/x86/kvm/x86.c                           | 6 +++---
>  arch/x86/lib/delay.c                         | 2 +-
>  arch/x86/mm/init_64.c                        | 6 +++---
>  arch/x86/mm/pat/memtype.c                    | 2 +-
>  arch/x86/mm/pat/set_memory.c                 | 4 ++--
>  arch/x86/mm/pti.c                            | 2 +-
>  arch/x86/mm/tlb.c                            | 2 +-
>  arch/x86/net/bpf_jit_comp.c                  | 2 +-
>  arch/x86/net/bpf_jit_comp32.c                | 2 +-
>  arch/x86/platform/intel-quark/imr_selftest.c | 2 +-
>  arch/x86/platform/pvh/head.S                 | 2 +-
>  arch/x86/platform/uv/uv_nmi.c                | 2 +-
>  arch/x86/platform/uv/uv_time.c               | 2 +-
>  arch/x86/realmode/init.c                     | 2 +-
>  arch/x86/xen/mmu_pv.c                        | 2 +-
>  60 files changed, 71 insertions(+), 71 deletions(-)
> 
> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
> index 319448d87b99..dbd15a67e9df 100644
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -738,7 +738,7 @@ int __init arch_probe_nr_irqs(void)
>  void lapic_assign_legacy_vector(unsigned int irq, bool replace)
>  {
>  	/*
> -	 * Use assign system here so it wont get accounted as allocated
> +	 * Use assign system here so it won't get accounted as allocated
>  	 * and moveable in the cpu hotplug check and it prevents managed

OK, but        movable      is preferred.

>  	 * irq reservation from touching it.
>  	 */

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
#Randy

