Return-Path: <linux-kernel+bounces-130068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 533C78973C5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E5C28F6E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342A114A63F;
	Wed,  3 Apr 2024 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qXBK7svH"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7528814A4FF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712157249; cv=none; b=h5Z3qrXYqR8STZXE3tLtD8yKP/heLzPQjWlfW8u/yzPgfMO/kcFNXf2lRHRsbxEgspRc5XxmFb8aAAjfe3slDkOAUATzfoFYdH0/ZS5WnliOyx1sjuDjS0h5XxPO0vX4Y53je5msDqmbk3w59GPGw1ctUJR10RrizP3HMFN1oi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712157249; c=relaxed/simple;
	bh=W6tEz6Zwd/3V0AalPwql2eDmQ/JYHtwljJr2Uh2Zm/A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tqAw+p5ENyof8SZRXyvfr2GALPsDQVVyMHF7no5pwf7AGddKoTjGbRTrSFPfjp+HZXoFPIq0IN4bzm33REVKHAls6YAcs5G3aWoAQU9JbfEGDMgIGOlt0UUeCg6X2Gad6qLzQej8AEN14WrlkJ2QLwY/8T/s5MDJp3Qnl4Ztw3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qXBK7svH; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cc8d4e1a4so117280877b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 08:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712157246; x=1712762046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RERRULEGqmQXPtZTcd/mEGQQNqydbJ8WRO6RWf+KLek=;
        b=qXBK7svHDvvteHAx6b7gDQlPoakWDN5rEqtG8eCbj4bmlUtyJTBftY1cszauaBtfUw
         5Oshf3j/WicRyOgxelet21mr93kHtmzu8+fNpqcN21YBSbONutG7eDYKQfIPdXML1VcT
         ovcDJQ5Hpm0LQ2yA+mrEqZnm5rvA99gs7TcZCxnwFp38qzU+RM3Lu99O6KWnnEoZ4OuB
         ZY9d0pePNZt4ibQsC56Jgmh3sERl1DmvbuJG98gwbt9zgHe79Y2kWpaRoieVZlpG7CYk
         qjyEg/Ode2iK8KYhus3znLaa4J8Ro32+CR9u4ru1cOWZNgsXuV3NSIV9BcfHcXb8argO
         oVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712157246; x=1712762046;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RERRULEGqmQXPtZTcd/mEGQQNqydbJ8WRO6RWf+KLek=;
        b=TO8aJgwM8KA9HsFfAjI8x0/X7UvT3XNcpfRiKIoqomLfCxZLFoJrW6iuyWHWuibM3b
         p8Ohb8QdWhh3XYeL+HFpIl+UyyCC5gR0pr55A7/bnN3+ww459tDg45HQ6HUwmP+vAWd2
         OP/EOVWLlVTEorCE3zo43xPmUPH73D+f3lNHU0HsecIATZOKXv4yKOck3U4BLjKft2bZ
         t5C5ZU2wvObB5wqcSoHkRwZMIgV9wFuBTuploXnbKQRo3M0UsrKCvxH3CMdLBAAK8FMn
         1xRX4gmMNjPDzaC9nafG8zTldpcJ6omIcd3h9xddicpNN1/BG3AfSjdVycW/DheS3jbM
         8rvg==
X-Forwarded-Encrypted: i=1; AJvYcCV5RMlZDwolwn43DCxhSCfE30YKNR2ubpHYjS82W406XVYD3G1yYFZG76zi4tKRlHotE+3w8iBeIzGEdPHnRhPPzSnfjZlf8XtElhdt
X-Gm-Message-State: AOJu0Yw2LkU4DnRpBK39KEV42A4t4YjIwjjQMPaQOAnGUWOhFTKwJj4G
	iZyYfvdfucHgpH2Bbv/nx0JiQZZVVHPXZr0neHHfCWr7IzOpvAC+Qymq65c/4kcSrxuIPg4TrwY
	CFw==
X-Google-Smtp-Source: AGHT+IGmfLK0wH6vXigEvfjeTOgWqVBdPAJCvhT6SwqLPJkCtrIm6w6lz8yIYj/1nevhClSMuSxyy2oCynE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:eb82:0:b0:615:378a:73ed with SMTP id
 u124-20020a0deb82000000b00615378a73edmr979932ywe.8.1712157246357; Wed, 03 Apr
 2024 08:14:06 -0700 (PDT)
Date: Wed, 3 Apr 2024 08:14:04 -0700
In-Reply-To: <62f8890cb90e49a3e0b0d5946318c0267b80c540.1708933498.git.isaku.yamahata@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1708933498.git.isaku.yamahata@intel.com> <62f8890cb90e49a3e0b0d5946318c0267b80c540.1708933498.git.isaku.yamahata@intel.com>
Message-ID: <Zg1yPIV6cVJrwGxX@google.com>
Subject: Re: [PATCH v19 111/130] KVM: TDX: Implement callbacks for MSR
 operations for TDX
From: Sean Christopherson <seanjc@google.com>
To: isaku.yamahata@intel.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com, 
	Sagi Shahar <sagis@google.com>, Kai Huang <kai.huang@intel.com>, chen.bo@intel.com, 
	hang.yuan@intel.com, tina.zhang@intel.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 26, 2024, isaku.yamahata@intel.com wrote:
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 389bb95d2af0..c8f991b69720 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -1877,6 +1877,76 @@ void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
>  	*error_code = 0;
>  }
>  
> +static bool tdx_is_emulated_kvm_msr(u32 index, bool write)
> +{
> +	switch (index) {
> +	case MSR_KVM_POLL_CONTROL:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +bool tdx_has_emulated_msr(u32 index, bool write)
> +{
> +	switch (index) {
> +	case MSR_IA32_UCODE_REV:
> +	case MSR_IA32_ARCH_CAPABILITIES:
> +	case MSR_IA32_POWER_CTL:
> +	case MSR_IA32_CR_PAT:
> +	case MSR_IA32_TSC_DEADLINE:
> +	case MSR_IA32_MISC_ENABLE:
> +	case MSR_PLATFORM_INFO:
> +	case MSR_MISC_FEATURES_ENABLES:
> +	case MSR_IA32_MCG_CAP:
> +	case MSR_IA32_MCG_STATUS:
> +	case MSR_IA32_MCG_CTL:
> +	case MSR_IA32_MCG_EXT_CTL:
> +	case MSR_IA32_MC0_CTL ... MSR_IA32_MCx_CTL(KVM_MAX_MCE_BANKS) - 1:
> +	case MSR_IA32_MC0_CTL2 ... MSR_IA32_MCx_CTL2(KVM_MAX_MCE_BANKS) - 1:
> +		/* MSR_IA32_MCx_{CTL, STATUS, ADDR, MISC, CTL2} */
> +		return true;
> +	case APIC_BASE_MSR ... APIC_BASE_MSR + 0xff:
> +		/*
> +		 * x2APIC registers that are virtualized by the CPU can't be
> +		 * emulated, KVM doesn't have access to the virtual APIC page.
> +		 */
> +		switch (index) {
> +		case X2APIC_MSR(APIC_TASKPRI):
> +		case X2APIC_MSR(APIC_PROCPRI):
> +		case X2APIC_MSR(APIC_EOI):
> +		case X2APIC_MSR(APIC_ISR) ... X2APIC_MSR(APIC_ISR + APIC_ISR_NR):
> +		case X2APIC_MSR(APIC_TMR) ... X2APIC_MSR(APIC_TMR + APIC_ISR_NR):
> +		case X2APIC_MSR(APIC_IRR) ... X2APIC_MSR(APIC_IRR + APIC_ISR_NR):
> +			return false;
> +		default:
> +			return true;
> +		}
> +	case MSR_IA32_APICBASE:
> +	case MSR_EFER:
> +		return !write;

Meh, for literally two MSRs, just open code them in tdx_set_msr() and drop the
@write param.  Or alternatively add:

static bool tdx_is_read_only_msr(u32 msr){
{
	return msr == MSR_IA32_APICBASE || msr == MSR_EFER;
}

> +	case 0x4b564d00 ... 0x4b564dff:

This is silly, just do

	case MSR_KVM_POLL_CONTROL:
		return false;

and let everything else go through the default statement, no?

> +		/* KVM custom MSRs */
> +		return tdx_is_emulated_kvm_msr(index, write);
> +	default:
> +		return false;
> +	}
> +}
> +
> +int tdx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
> +{
> +	if (tdx_has_emulated_msr(msr->index, false))
> +		return kvm_get_msr_common(vcpu, msr);
> +	return 1;

Please invert these and make the happy path the not-taken path, i.e.

	if (!tdx_has_emulated_msr(msr->index))
		return 1;

	return kvm_get_msr_common(vcpu, msr);

The standard kernel pattern is

	if (error)
		return <error thingie>

	return <happy thingie>

> +}
> +
> +int tdx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
> +{
> +	if (tdx_has_emulated_msr(msr->index, true))

As above:

	if (tdx_is_read_only_msr(msr->index))
		return 1;

	if (!tdx_has_emulated_msr(msr->index))
		return 1;

	return kvm_set_msr_common(vcpu, msr);

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d5b18cad9dcd..0e1d3853eeb4 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -90,7 +90,6 @@
>  #include "trace.h"
>  
>  #define MAX_IO_MSRS 256
> -#define KVM_MAX_MCE_BANKS 32
>  
>  struct kvm_caps kvm_caps __read_mostly = {
>  	.supported_mce_cap = MCG_CTL_P | MCG_SER_P,
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 4e40c23d66ed..c87b7a777b67 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -9,6 +9,8 @@
>  #include "kvm_cache_regs.h"
>  #include "kvm_emulate.h"
>  
> +#define KVM_MAX_MCE_BANKS 32

Split this to a separate.  Yes, it's trivial, but that's _exactly_ why it should
be in a separate patch.  The more trivial refactoring you split out, the more we
can apply _now_ and take off your hands.

