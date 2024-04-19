Return-Path: <linux-kernel+bounces-151505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD238AAFC1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7698282377
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE62112C53F;
	Fri, 19 Apr 2024 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JqhLbwga"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A010712AAF4
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534766; cv=none; b=A7eccbxqnkuRvNG5XonlefvUdCMeJdpDXtItUmiXrBsYu8uTN5rzEWKcxnQHXsDnOgiuZuAGYdMtoStGqyyG7YWK8ohW2kl3JO9Hi3KpoEGWlH+hpqCm+9b/lAypgeib9boGv5G6JE2a0RhPcBG27GFj2Hyl4uxziAryCvT4wjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534766; c=relaxed/simple;
	bh=0bMqhizXXBRsHgH7B8q96FVF9b/L6f85+o0VoS7OMWs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UtXfjpTgYf+ewmx6sLQ3+5lDjBm/W2BDsPoCSFgSUZTGcVQ/AeGSiaZJyxa+01/VbUu6Hvzf80lRPCQ2ts6ZdxO3yuR+zHx2VYLs4JS903Spb4sh9L/Dab1SaJ2SyvBtJYbl69mqpl0PTX4VKyI3+XW+csfz3iSdNsQhNx2Nzj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JqhLbwga; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5c670f70a37so2174470a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713534764; x=1714139564; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gHnn4b/aF0vLLT3VFQPmMbPoN7WtL6sG78+6CFhfUU0=;
        b=JqhLbwgaCHJykhghjgEVhqE7Xtvo9O50qeZTNWc77MBxI/BxRpo66JP3OY4k41Q+OW
         rIQ+pbtm+5Gd/QgKha17SFH+4QaGeAEXSnNzeo5gLwYKa3YQWozzBgtJYrzZPNzgvSln
         VI4LID5//WzaeEwSaKHdz0fIODL1boGHITbkFwSkw2mchhOw09KDo5/nMx0IBbj3WXEY
         aWHXK8XB+oxfNCiNkGUyqXyNR+oomrIQB6i4A4vvkzgg00cgIEDqPQbufF8sGqEURlBA
         8tEBuS/vs99SJBGrIn+u7bfmQFjKcrbSoZS3yW0/1YtzsGLYYtvbsmcuwoI4WXIcFyCX
         DF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713534764; x=1714139564;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHnn4b/aF0vLLT3VFQPmMbPoN7WtL6sG78+6CFhfUU0=;
        b=k228NUySjPC7x1LicleteBFJCUAZ6MYZ1Ajwnj5QjCUfI5GCMQ+iIQz7N/E07vSH1t
         23UT2eBqWcLnlMmTkj7Y1/G98MK9QdJqENCdpYwBqCD6XyjEZorzk20+lwyvdEUi5R3r
         0G5gNiUCMVlNS7HgJdpuPHd9yow1+TiKIdd2hDVlvyT8uy8x1ck3RSZcIH/kqqPCBKFs
         9/XMmBkvNNFHPUKuFgRuEC5VucUbNLKA5uN8+M8Rk7idR9SVhATgYBc49IvJxF8HXsf9
         AnSNAZEmwsXaCStBXvdAVYqUPRPfCO0c0xMgIgfurVCetDa63AHD/1+EIjXr9yGq26qc
         mKQw==
X-Forwarded-Encrypted: i=1; AJvYcCXXUlyPdOL34A3kB1KlYB+9q/spA2+i2h4ShszDvO6fG/d5QesS0h1xRFt2vooGDnfYQAkkIAsVaxukEac2EN4kuhafyECvo74gwQys
X-Gm-Message-State: AOJu0YyPzKYrosf2qHJ+yXyGNAdZyDeOwQfWQTD8YWiMf6d2YQJnTQLr
	gLUlN1L0iyPKIQ00YmTgn8bp1gdz5bdMN4TgwqWSQI1lRHpr1QTBacUijtd5UI7PKpsrkgrf0zS
	Unw==
X-Google-Smtp-Source: AGHT+IHMaFLJaIHnJp+yayT00gxYtI6WKpnrTGbbpd/oLNHLKcimeJFzp727fGJB27ck/U1xPqmyiYTVDMc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:fca:b0:5dc:af76:660 with SMTP id
 dr10-20020a056a020fca00b005dcaf760660mr75766pgb.10.1713534763747; Fri, 19 Apr
 2024 06:52:43 -0700 (PDT)
Date: Fri, 19 Apr 2024 06:52:42 -0700
In-Reply-To: <9c4547ea234a2ba09ebe05219f180f08ac6fc2e3.1708933498.git.isaku.yamahata@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1708933498.git.isaku.yamahata@intel.com> <9c4547ea234a2ba09ebe05219f180f08ac6fc2e3.1708933498.git.isaku.yamahata@intel.com>
Message-ID: <ZiJ3Krs_HoqdfyWN@google.com>
Subject: Re: [PATCH v19 116/130] KVM: TDX: Silently discard SMI request
From: Sean Christopherson <seanjc@google.com>
To: isaku.yamahata@intel.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com, 
	Sagi Shahar <sagis@google.com>, Kai Huang <kai.huang@intel.com>, chen.bo@intel.com, 
	hang.yuan@intel.com, tina.zhang@intel.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 26, 2024, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> TDX doesn't support system-management mode (SMM) and system-management
> interrupt (SMI) in guest TDs.  Because guest state (vcpu state, memory
> state) is protected, it must go through the TDX module APIs to change guest
> state, injecting SMI and changing vcpu mode into SMM.  The TDX module
> doesn't provide a way for VMM to inject SMI into guest TD and a way for VMM
> to switch guest vcpu mode into SMM.
> 
> We have two options in KVM when handling SMM or SMI in the guest TD or the
> device model (e.g. QEMU): 1) silently ignore the request or 2) return a
> meaningful error.
> 
> For simplicity, we implemented the option 1).
>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>  arch/x86/kvm/smm.h         |  7 +++++-
>  arch/x86/kvm/vmx/main.c    | 45 ++++++++++++++++++++++++++++++++++----
>  arch/x86/kvm/vmx/tdx.c     | 29 ++++++++++++++++++++++++
>  arch/x86/kvm/vmx/x86_ops.h | 12 ++++++++++
>  4 files changed, 88 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/smm.h b/arch/x86/kvm/smm.h
> index a1cf2ac5bd78..bc77902f5c18 100644
> --- a/arch/x86/kvm/smm.h
> +++ b/arch/x86/kvm/smm.h
> @@ -142,7 +142,12 @@ union kvm_smram {
>  
>  static inline int kvm_inject_smi(struct kvm_vcpu *vcpu)
>  {
> -	kvm_make_request(KVM_REQ_SMI, vcpu);
> +	/*
> +	 * If SMM isn't supported (e.g. TDX), silently discard SMI request.
> +	 * Assume that SMM supported = MSR_IA32_SMBASE supported.
> +	 */
> +	if (static_call(kvm_x86_has_emulated_msr)(vcpu->kvm, MSR_IA32_SMBASE))
> +		kvm_make_request(KVM_REQ_SMI, vcpu);
>  	return 0;

No, just do what KVM already does for CONFIG_KVM_SMM=n, and return -ENOTTY.  The
*entire* point of have a return code is to handle setups that don't support SMM.

	if (!static_call(kvm_x86_has_emulated_msr)(vcpu->kvm, MSR_IA32_SMBASE)))
		return -ENOTTY;

And with that, I would drop the comment, it's pretty darn clear what "assumption"
is being made.  In quotes because it's not an assumption, it's literally KVM's
implementation.

And then the changelog can say "do what KVM does for CONFIG_KVM_SMM=n" without
having to explain why we decided to do something completely arbitrary for TDX.

>  }
>  
> diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
> index ed46e7e57c18..4f3b872cd401 100644
> --- a/arch/x86/kvm/vmx/main.c
> +++ b/arch/x86/kvm/vmx/main.c
> @@ -283,6 +283,43 @@ static void vt_msr_filter_changed(struct kvm_vcpu *vcpu)
>  	vmx_msr_filter_changed(vcpu);
>  }
>  
> +#ifdef CONFIG_KVM_SMM
> +static int vt_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
> +{
> +	if (is_td_vcpu(vcpu))
> +		return tdx_smi_allowed(vcpu, for_injection);

Adding stubs for something that TDX will never support is silly.  Bug the VM and
return an error.

	if (KVM_BUG_ON(is_td_vcpu(vcpu)))
		return -EIO;

And I wouldn't even bother with vt_* wrappers, just put that right in vmx_*().
Same thing for everything below.

