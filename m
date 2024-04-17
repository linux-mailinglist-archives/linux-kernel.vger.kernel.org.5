Return-Path: <linux-kernel+bounces-149262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB548A8E22
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9B11C20DA8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D97F7D410;
	Wed, 17 Apr 2024 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WXN7M5M+"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D381E484
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713389854; cv=none; b=MoWWQ+mOL26p4sVADTmiYPdSAZRim1TFZLWGJGNyeDiU056+9K2xFZoZ/BcV6HdlmOiE9GGRTekBnuvQVhZ5OMsNXI62VYAfrhMaJS/rQKQAI/QgYC6Q7NgDcGb6psVGx7t17Mwvm+4q6DjDyolHcO5m+MrZ+lWJU/rD+5a6GbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713389854; c=relaxed/simple;
	bh=nn33NO0vEfsJIxR+M6dCBKuem1fZfqeN+leQ6+GMqn8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZJp5JMAxcAN7L/yBDJLZDwdPtVynFUrtUPM1boz4oGB40xM4khWWvKDlhQ80kuVdWkN+icCJfFBq39V/ssjuTz41y//PjI+5GSh2MoPkSdG7aaWKH7W+sMmCCbpz1bLptAQ+rFxc0of7wOH1gMX58YD7vPoDMP51WDOlOLZimi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WXN7M5M+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1e4c75eb382so2593425ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713389853; x=1713994653; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fDcspz+C6ifhdGMDDcdB7ozwr1bJZha/kocmf7aabJM=;
        b=WXN7M5M+7oBlRHNGmPWpmvSPvQRrHBtLoRrD3q7U5rb/8fEd3ZqyQu3NnzcqCWyIkQ
         UdVHr/wzoZk3Kv84r3NQywzPDHU4ZC0NQmL27gxHKBBHYFGXgghzPZzhIbAKtWminYRi
         oWvmU90bxe6r33O+C2/60yL8hLpXWyPgW79VjhaOxKVi1wieMPylRibH4eMC2rjzlFax
         cegpTYwfFNFKZvSBSub0z78JkIs+1K5iB2YL5/03pGFMVih+oAJwhAXR8vPGH88H0NKK
         Z5r/+Qfyk9RLgdbXp5d2wg62mBepoHdnxP60nO80RcUFsNXPH068hJHZVTFk77CDN1k9
         VT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713389853; x=1713994653;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDcspz+C6ifhdGMDDcdB7ozwr1bJZha/kocmf7aabJM=;
        b=As8lWGaD31yS8TaJabUmXZkPOZLDpCp64LDFbKmKKGb6Z7aEJdg5kJhH65EfiEZ3Ep
         JGTXNGSg49+PcJHeDozlhm6mX0F+50BlSFXGh9oFKaAP25y0lTG0wCEGANhJ/uCVS3bV
         TVFdmkwKfmFgH3yEvZ3KLH05xlygTqkDwxNU+2q2IqZiOLkaL26j4flbjrJS9CvIL2PR
         753I6o/Es5IoBQNqNjKn2V3w6cmJfNpmiuSFhmbOzfwSUku9OaJ68gTYA1gMWeRNCrJS
         niGWN+HpUVfTYnHgFjrxfV9xN8/iV6v1uqXNm1DXe8LIh0pos5/427QDcUEWaD1zx+Qs
         PNew==
X-Gm-Message-State: AOJu0YwY/sSGqpgkPjN3cMnrnAcOOzS0Whuup2U/SO1WP4ub4+F/dXeX
	5sI2/nMAkpTUhWSmtxA+KStaiRDRY1o92saQzd8RCRtBf2On+qnWre+H5LQi0EPt98XF0bUc9nF
	r/A==
X-Google-Smtp-Source: AGHT+IF9Q4fEJUyr/1itOzhDqm63veoLvbK+K/Plq3exmr9ccO1IwYClhicEEoCjgjq7VvCeED1KEeBaE7U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d4d0:b0:1e4:32ec:ce5d with SMTP id
 o16-20020a170902d4d000b001e432ecce5dmr6688plg.0.1713389852830; Wed, 17 Apr
 2024 14:37:32 -0700 (PDT)
Date: Wed, 17 Apr 2024 14:37:31 -0700
In-Reply-To: <20240417153450.3608097-7-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240417153450.3608097-1-pbonzini@redhat.com> <20240417153450.3608097-7-pbonzini@redhat.com>
Message-ID: <ZiBBGwErRUX1_OWu@google.com>
Subject: Re: [PATCH 6/7] KVM: x86: Implement kvm_arch_vcpu_map_memory()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	isaku.yamahata@intel.com, xiaoyao.li@intel.com, binbin.wu@linux.intel.com, 
	rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 17, 2024, Paolo Bonzini wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Wire KVM_MAP_MEMORY ioctl to kvm_mmu_map_tdp_page() to populate guest
> memory.  When KVM_CREATE_VCPU creates vCPU, it initializes the x86
> KVM MMU part by kvm_mmu_create() and kvm_init_mmu().  vCPU is ready to
> invoke the KVM page fault handler.
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Message-ID: <7138a3bc00ea8d3cbe0e59df15f8c22027005b59.1712785629.git.isaku.yamahata@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/Kconfig |  1 +
>  arch/x86/kvm/x86.c   | 43 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 7632fe6e4db9..e58360d368ec 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -44,6 +44,7 @@ config KVM
>  	select KVM_VFIO
>  	select HAVE_KVM_PM_NOTIFIER if PM
>  	select KVM_GENERIC_HARDWARE_ENABLING
> +	select KVM_GENERIC_MAP_MEMORY
>  	help
>  	  Support hosting fully virtualized guest machines using hardware
>  	  virtualization extensions.  You will need a fairly recent
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 83b8260443a3..f84c75c2a47f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4715,6 +4715,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_MEMORY_FAULT_INFO:
>  		r = 1;
>  		break;
> +	case KVM_CAP_MAP_MEMORY:
> +		r = tdp_enabled;
> +		break;
>  	case KVM_CAP_EXIT_HYPERCALL:
>  		r = KVM_EXIT_HYPERCALL_VALID_MASK;
>  		break;
> @@ -5867,6 +5870,46 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
>  	}
>  }
>  
> +int kvm_arch_vcpu_map_memory(struct kvm_vcpu *vcpu,
> +			     struct kvm_map_memory *mapping)
> +{
> +	u64 mapped, end, error_code = 0;

Maybe add PFERR_GUEST_FINAL_MASK to the error code?  KVM doesn't currently consume
that except in svm_check_emulate_instruction(), which isn't reachable, but it
seems logical?

> +	u8 level = PG_LEVEL_4K;
> +	int r;
> +
> +	/*
> +	 * Shadow paging uses GVA for kvm page fault.  The first implementation
> +	 * supports GPA only to avoid confusion.
> +	 */
> +	if (!tdp_enabled)

Eh, I'd omit this explicit check since kvm_tdp_map_page() has a more complete
check.

Actually, why is this a separate function and a separate patch?  Just implement
kvm_arch_vcpu_map_memory() in mmu.c, in a single patch, e.g.

int kvm_arch_vcpu_map_memory(struct kvm_vcpu *vcpu,
			     struct kvm_map_memory *mapping)
{
	u64 mapped, end, error_code = 0;
	u8 level = PG_LEVEL_4K;
	int r;

	if (vcpu->arch.mmu->page_fault != kvm_tdp_page_fault)
		return -EOPNOTSUPP;

	kvm_mmu_reload(vcpu);

	if (kvm_arch_has_private_mem(vcpu->kvm) &&
	    kvm_mem_is_private(vcpu->kvm, gpa_to_gfn(mapping->base_address)))
		error_code |= PFERR_PRIVATE_ACCESS;

	r = __kvm_mmu_do_page_fault(vcpu, mapping->gpa, error_code, true, NULL, &level);
	if (r < 0)
		return r;

	switch (r) {
	case RET_PF_RETRY:
		return -EAGAIN;
	case RET_PF_FIXED:
	case RET_PF_SPURIOUS:
		break;
	case RET_PF_EMULATE:
		return -EBUSY;
	case RET_PF_CONTINUE:
	case RET_PF_INVALID:
	default:
		WARN_ON_ONCE(r);
		return -EIO;
	}

	/*
	 * Adjust the GPA down when accounting for the page size, as KVM could
	 * have created a hugepage that covers @gpa, but doesn't start at @gpa.
	 */
	end = (mapping->gpa & KVM_HPAGE_MASK(level)) + KVM_HPAGE_SIZE(level);
	return min(mapping->size, end - mapping->gpa);
}

