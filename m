Return-Path: <linux-kernel+bounces-23887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 108E782B335
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFDC91C268C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C96350267;
	Thu, 11 Jan 2024 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XLFKwGH6"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9062250250
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6d9b8ff5643so3219854b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704991515; x=1705596315; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X3a/8dzRGzGQbYICPGv6PuVABrUUIpNjNThOnReQ0ZI=;
        b=XLFKwGH6N6dD8NmTG1o07sFcyLwc6XSuqVkhRsmi3mlaM0m2FO4wuLcEyrheP/4tRT
         GhqMIszxjsGvfj4kRi80bjUIRVqoHKPU+ccPflrkrKHuHh/yhUWI51s8UHd3o3pIxDjO
         DB5N/hORE/S4DOOoIq0hsfAzj7hAnWAdPeQYzaxGiIYetQkrqyzYadIN6O/wKXmQTpHD
         4BkqWc+QRBN3duk4tOdC/+NAQY9NwuHB9fuzQc4YwFjRuD9aZscQkRopCtFgcr1DxVZz
         POArObcIrnz62jvCsGgsTQzlnfs5je4jup2WpYeXC+xYQILCPfyuk6k2HOQFwM2EtfN5
         UAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704991515; x=1705596315;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3a/8dzRGzGQbYICPGv6PuVABrUUIpNjNThOnReQ0ZI=;
        b=mYKwFyfChvfA1wP1EObl8gJMaMpJNhh13sRHoVt6aXL31dOfS+4CDVm1ZrqFUyr+wk
         hUSCsqy65BI7nD40EJHNNZmvA/O2K508qGPl+XCsrOfgnWg36jU3ZM86wYXLRQ9L2Eza
         6b9U8AIuw8dE2+NHrwr0o9EuNe8evFlTHKRq2XAI2r1G1o+t3AQeii7MDuirxW6uDUBo
         waW9mPDacp/SlokH4xU3WNdmD7dSI5F2wx4txv4d/D5h6J/xJaDw7UOlsPg0bLZUci+g
         UbK/mJO0L3I7blFJIiAHM+dcvDfdRKZtPZPu2qadu0OPPdUy6sJKyItwMZY3Wfa3WzTj
         2MbA==
X-Gm-Message-State: AOJu0Yyyqf/tuCYoIhpCuBaMY+1ChA3uU13zpAjSGK6OcAsiL7fESgxR
	DQcPng0lnxUiL8d4J4gD1clqLa9tqipg1dskKQ==
X-Google-Smtp-Source: AGHT+IG2qKhuxADLHLULVl08q1kzqk8hzzdyklLmMAIhQSW6HtOJbi3k59IN0IlWDxnxRbBzk9xsbsI4HtU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2d29:b0:6d9:975e:b360 with SMTP id
 fa41-20020a056a002d2900b006d9975eb360mr191082pfb.4.1704991514780; Thu, 11 Jan
 2024 08:45:14 -0800 (PST)
Date: Thu, 11 Jan 2024 08:45:13 -0800
In-Reply-To: <20240111-delay-verw-v5-6-a3b234933ea6@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240111-delay-verw-v5-0-a3b234933ea6@linux.intel.com> <20240111-delay-verw-v5-6-a3b234933ea6@linux.intel.com>
Message-ID: <ZaAbGWFEfUt1PX66@google.com>
Subject: Re: [PATCH  v5 6/6] KVM: VMX: Move VERW closer to VMentry for MDS mitigation
From: Sean Christopherson <seanjc@google.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Andy Lutomirski <luto@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Paolo Bonzini <pbonzini@redhat.com>, tony.luck@intel.com, ak@linux.intel.com, 
	tim.c.chen@linux.intel.com, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	Alyssa Milburn <alyssa.milburn@linux.intel.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, antonio.gomez.iglesias@linux.intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Jan 11, 2024, Pawan Gupta wrote:
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index bdcf2c041e0c..8defba8e417b 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -387,6 +387,17 @@ static __always_inline void vmx_enable_fb_clear(struct vcpu_vmx *vmx)
>  
>  static void vmx_update_fb_clear_dis(struct kvm_vcpu *vcpu, struct vcpu_vmx *vmx)
>  {
> +	/*
> +	 * FB_CLEAR_CTRL is to optimize VERW latency in guests when host is
> +	 * affected by MMIO Stale Data, but not by MDS/TAA. When
> +	 * X86_FEATURE_CLEAR_CPU_BUF is enabled, system is likely affected by
> +	 * MDS/TAA. Skip the optimization for such a case.

This is unnecessary speculation (ha!), and it'll also be confusing for many readers
as the code below explicitly checks for MDS/TAA.  We have no idea why the host
admin forced the mitigation to be enabled, and it doesn't matter.  The important
thing to capture is that the intent is to keep the mitigation enabled when it
was forcefully enabled, that should be self-explanatory and doesn't require
speculating on _why_ the mitigation was forced on.

> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_CLEAR_CPU_BUF)) {
> +		vmx->disable_fb_clear = false;
> +		return;
> +	}
> +
>  	vmx->disable_fb_clear = (host_arch_capabilities & ARCH_CAP_FB_CLEAR_CTRL) &&
>  				!boot_cpu_has_bug(X86_BUG_MDS) &&
>  				!boot_cpu_has_bug(X86_BUG_TAA);

I would rather include the X86_FEATURE_CLEAR_CPU_BUF check along with all the
other checks, and then add a common early return. E.g.

	/*
	 * Disable VERW's behavior of clearing CPU buffers for the guest if the
	 * CPU isn't affected MDS/TAA, and the host hasn't forcefully enabled
	 * the mitigation.  Disabing the clearing provides a performance boost
	 * for guests that aren't aware that manually clearing CPU buffers is
	 * unnecessary, at the cost of MSR accesses on VM-Entry and VM-Exit.
	 */
	vmx->disable_fb_clear = !cpu_feature_enabled(X86_FEATURE_CLEAR_CPU_BUF) &&
				(host_arch_capabilities & ARCH_CAP_FB_CLEAR_CTRL) &&
				!boot_cpu_has_bug(X86_BUG_MDS) &&
				!boot_cpu_has_bug(X86_BUG_TAA);

	if (!vmx->disable_fb_clear)
		return;

