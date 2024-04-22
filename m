Return-Path: <linux-kernel+bounces-153929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 321DE8AD502
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B3E2841E0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1683155349;
	Mon, 22 Apr 2024 19:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IbmlU1jN"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D766A155310
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815014; cv=none; b=aeVna1NiShJGEVOSc94Uh3iq5Qt9aLmefGxKwL+UhEbO2wmNpaGV6dDNa7zKfrGEWR+4k7BK6N+pjc+gVqpP/q1FBhMoXuUBcJTT87txtAqJq6Hs/ssO3tj78V1CmCmNrSFZMjIBfn8wfehHWHi0yxeYi9RVtlhbSHCaL4Tdae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815014; c=relaxed/simple;
	bh=rqo5kZsuhsjRzcG6r7op5qGRZLLQPYMPvIRMLhlGAEE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ss1mbYwj9l5fs+MTfcGb+ddd47C9wT6oyYMIl83E4Hc0qUyE+DV+rzpYWE3ocN95Z09tcKb+vdRsydod410Dnfw6+ja7NedsLD5FGYSSnXX8JLCqYUlRYC9HN+OG98r/6QgRtRAW9Nzm8z0G2rENQNE0vmQQaGJ8egKM/avuV9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IbmlU1jN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so10260688276.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713815012; x=1714419812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JyzTdSdQlZjPTKTajFwL+PTG8n8RFsaCQ17y36xG4qs=;
        b=IbmlU1jNa25HgJG7LFHg/CU7wk5LcFKccUL8gSqZqnW2DNdF4xak+i8F/DGBy9cYqC
         inskTDcvuoqCG9pSqB2uIxlXoCLUr7xUSFHNANlviS44qAeYK9vWiDR6Fnr6RSlBNyjV
         HmzGCppHmz+wIObLpAAt+QnbfzKev3q3eioqNkHGTyjp9L8bmo4PGSNeiC47XxATdEqA
         XfncL4Lywu9+NlWPykewxxVJnBRKKpmSfSJrH6K4bNTkF1ABFSbIjZjTGqw352RsUDtj
         BfA6iD73ZtGCF5Qlo4lKmKWxnhYGpPm6glk+8POwC/vKmgZEbwMRYDKTATB2WgGJC+5D
         Fi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713815012; x=1714419812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JyzTdSdQlZjPTKTajFwL+PTG8n8RFsaCQ17y36xG4qs=;
        b=Aa8pIgz+SpeTSnf6bW+LUknSvA3T6plwju+1DMS4/0Ae5/EHWX0Bd/XnZ0GV6A+eXE
         D3dcl5/d5T+dqzxUrvk0gNYAWGr90bor4ZEeSpOgh0S78UJ1Ij2x1byQksQrrl035Lmk
         ljH/R2LvYCl3vV3RYaqRDz4b4laYmRz7k2SRQoZWz2Jqw/c9XtkjRpB140h8gLWMLySN
         2pmZsKVzBuNJ1Og7inyqSPWYFFMJ+nhtdt1liegBts6W7nezHfN/sMZ5+JPXIbiYvYlW
         WbAL94/ibN3XkwmbnFOKF8Y/LbBIFQHpFGXRJOIgrTYVKgY2bZ8hrp9IOR6uLEgw8qcl
         T1qw==
X-Forwarded-Encrypted: i=1; AJvYcCVUwAIg9wG/yAZtVzAuT6ZtX93of2cgFC4DL9ZgE/VCeUyEob7nkuWbwDM4rPmQ6fcQ+g0HMnuj6C1MtjM+eRqILf48ULkGjejDdLkD
X-Gm-Message-State: AOJu0YyO5Dw5IF37nLqH4zY8YKmHOvXrgDWvuVKiu4j7PcorLhizoXyT
	UFnmkdV3SQPyrMvuqjPKae5edyRUfQeiL2mu5o8PN6zydR7vsmvNWXp/tU7UWWChft2C/L0FVcw
	+Kw==
X-Google-Smtp-Source: AGHT+IEBAZmsWiF9Oef4bJqyhQc/VsZSMs3v5FKxK9dwBp2DXeyyqSS3hoEpcVGzDdsfeq32Lj2jvxWrGM8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:10c3:b0:de5:2325:72a1 with SMTP id
 w3-20020a05690210c300b00de5232572a1mr1265614ybu.4.1713815011856; Mon, 22 Apr
 2024 12:43:31 -0700 (PDT)
Date: Mon, 22 Apr 2024 12:43:30 -0700
In-Reply-To: <20240422130558.86965-1-wei.w.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240422130558.86965-1-wei.w.wang@intel.com>
Message-ID: <Zia94vbLD-DF1GEw@google.com>
Subject: Re: [PATCH v1] KVM: x86: Validate values set to guest's MSR_IA32_ARCH_CAPABILITIES
From: Sean Christopherson <seanjc@google.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 22, 2024, Wei Wang wrote:
> If the bits set by userspace to the guest's MSR_IA32_ARCH_CAPABILITIES
> are not supported by KVM, fails the write. This safeguards against the
> launch of a guest with a feature set, enumerated via
> MSR_IA32_ARCH_CAPABILITIES, that surpasses the capabilities supported by
> KVM.

I'm not entirely certain KVM cares.  Similar to guest CPUID, advertising features
to the guest that are unbeknownst may actually make sense in some scenarios, e.g.
if userspace learns of yet another "NO" bit that says a CPU isn't vulnerable to
some flaw.

ARCH_CAPABILITIES is read-only, i.e. KVM _can't_ shove it into hardware.  So as
long as KVM treats the value as "untrusted", like KVM does for guest CPUID, I
think the current behavior is actually ok.

> Fixes: 0cf9135b773b ("KVM: x86: Emulate MSR_IA32_ARCH_CAPABILITIES on AMD hosts")

This goes all the way back to:

  28c1c9fabf48 ("KVM/VMX: Emulate MSR_IA32_ARCH_CAPABILITIES")

the above just moved the logic from vmx.c to x86.c.

> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  arch/x86/kvm/x86.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ebcc12d1e1de..21d476e8e4b0 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3808,6 +3808,9 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_IA32_ARCH_CAPABILITIES:
>  		if (!msr_info->host_initiated)
>  			return 1;
> +		if (data & ~kvm_get_arch_capabilities())
> +			return 1;
> +
>  		vcpu->arch.arch_capabilities = data;
>  		break;
>  	case MSR_IA32_PERF_CAPABILITIES:

