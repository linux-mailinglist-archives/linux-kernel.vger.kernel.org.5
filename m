Return-Path: <linux-kernel+bounces-148909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4218A88D2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 900DDB215E1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67D8148FFB;
	Wed, 17 Apr 2024 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ykax38AL"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A5C1487D2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713371205; cv=none; b=gy+/MzrYjDrcTq3sc87fMaDaNb5k8Uo3o+cS9bPb7p2/sttZi5uz79H9ETYu0cMluFqbznN+4Lyt7wmrDtl10YnBxtFKbuagGzQNzvl0Qt6rZbxtvI5RHOiaBSnQc+MMd2TM2LiJlYebETkA4mFAykExWkY9rkSRJe6F77ZSqaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713371205; c=relaxed/simple;
	bh=vi6PLLS71URuA1xjxaHf5U6NQwm7wUQpu9Kos5MHRGU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kg8EOTP297fyqxQ2+oh2sQjQ7zrnEaC7nJ5uNYO307xT3jwA2ljOvhmDy7c7hVf6aDiX9eo/0relEEvlkFjBR/N2xWG92O1FgAoSKN87YYjlY9c6uUlNZmIyv+8IO77vDipVk8j6s/vE4GaBMtVYMMwHuM/I9dMGntf6F5HOFEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ykax38AL; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ed25ed4a5fso5548140b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713371201; x=1713976001; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UpiYLbF9nUsOKheKQ/CBFa6Q1CQe56BfIxvZY8oF++s=;
        b=Ykax38ALumt/Xm1h3Bhap6GXwBAAktte8367HPqLhzzjIjVh9aawCLXTuZ3OKtLkCr
         9dFhCIxl6arGdqQxMPTm2CooUD65TN0tppo6WIRamjCzgpmxQQ0nG8ckgyWo429DlfaS
         qRyo7ZUdZGfGeyiYGjAe6KEwCVuXy34xm9lD7jff25w9ejHdnV6Lt2ASumj3kao1ipk6
         WBJjKU3ul1cfCjAorBVOtflLG7JC9aXECBFbURX4bhratmx0/VM/GUJbubpRBpjjXDBH
         zVCZxusvstjBCVqFhB4+O/b3vipDwR4xN0vYuRvWYMElNPX2uo2XVejosLwjP8sPhj+C
         Tl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713371201; x=1713976001;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpiYLbF9nUsOKheKQ/CBFa6Q1CQe56BfIxvZY8oF++s=;
        b=Al5Ojf2JKoFEfJHBa0i2xMl3Kf/yF5UaUD3gc0+RRfGT6wCnQ6tARQMImM4BjfZ4ey
         Eg+q8s/VFFWBjOM7FCvkfSLC+LaNgBihVBS5i5wFcbR4SzqvV4wYpne4s9ziKNBSEsWD
         9AmXwoVEF+hfdB0hRvwGJopNU3xdbywvSMRv91gA80fKEgs2c+Z1pWBY4Iiacz4WROGw
         Wv4qduXA+ro/fDREt7HbNME/ZCDG/qoOz5UFkQ29ZdqZrYRBOJze/6ODYOcQrDuIkTZq
         vTDPEg/ga71Z06L7C2C7Ff/cf4x83N8uS8FZ+RAkLNWU9dmuD5GoL1PuT5QsJgK4qkg5
         K4WA==
X-Forwarded-Encrypted: i=1; AJvYcCW9hQZiVaL71yoPvPsKBhugdFsaYsi0WhSyCbOkFOUqDnTpK7j25uow4qVwXNoMuB/VWAT0Fo3b/A9rOgVoFaj/X1PmxXI5jUB+twGC
X-Gm-Message-State: AOJu0YxoCHmxxAXkOvnAiMqKJJXWvCEwSVKJMPMo1cp0YsXaI1+PHWlV
	MIb8pAfqwLvP8X/A+IPDQk0E7/opyJ3yVjw7KY8n2/5vRid31eioR69zWIqrew9RP0YPDdfH9MR
	f4A==
X-Google-Smtp-Source: AGHT+IERnb03u6LmnQ9yqPOnlXPGVvYun4H4EARUMiuwyKcMVtvlu3qZHrTcAj52uQytg3lQObKKttzKB8w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:17a4:b0:6ec:f5d2:f7f8 with SMTP id
 s36-20020a056a0017a400b006ecf5d2f7f8mr359pfg.2.1713371201431; Wed, 17 Apr
 2024 09:26:41 -0700 (PDT)
Date: Wed, 17 Apr 2024 09:26:40 -0700
In-Reply-To: <20240417150354.275353-1-wei.w.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240417150354.275353-1-wei.w.wang@intel.com>
Message-ID: <Zh_4QN7eFxyu9hgA@google.com>
Subject: Re: [RFC PATCH v1] KVM: x86: Introduce macros to simplify KVM_X86_OPS
 static calls
From: Sean Christopherson <seanjc@google.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 17, 2024, Wei Wang wrote:
> Introduces two new macros, KVM_X86_SC() and KVM_X86_SCC(), to streamline
> the usage of KVM_X86_OPS static calls. The current implementation of these
> calls is verbose and can lead to alignment challenges due to the two pairs
> of parentheses. This makes the code susceptible to exceeding the "80
> columns per single line of code" limit as defined in the coding-style
> document. The two macros are added to improve code readability and
> maintainability, while adhering to the coding style guidelines.

Heh, I've considered something similar on multiple occasionsi.  Not because
the verbosity bothers me, but because I often search for exact "word" matches
when looking for function usage and the kvm_x86_ prefix trips me up.
 
> Please note that this RFC only updated a few callsites for demonstration
> purposes. If the approach looks good, all callsites will be updated in
> the next version.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  3 +++
>  arch/x86/kvm/lapic.c            | 15 ++++++++-------
>  arch/x86/kvm/trace.h            |  3 ++-
>  arch/x86/kvm/x86.c              |  8 ++++----
>  4 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 6efd1497b026..42f6450c10ec 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1856,6 +1856,9 @@ extern struct kvm_x86_ops kvm_x86_ops;
>  	DECLARE_STATIC_CALL(kvm_x86_##func, *(((struct kvm_x86_ops *)0)->func));
>  #define KVM_X86_OP_OPTIONAL KVM_X86_OP
>  #define KVM_X86_OP_OPTIONAL_RET0 KVM_X86_OP
> +
> +#define KVM_X86_SC(func, ...) static_call(kvm_x86_##func)(__VA_ARGS__)
> +#define KVM_X86_SCC(func, ...) static_call_cond(kvm_x86_##func)(__VA_ARGS__)

IIRC, static_call_cond() is essentially dead code, i.e. it's the exact same as
static_call().  I believe there's details buried in a proposed series to remove
it[*].  And to not lead things astray, I verified that invoking a NULL kvm_x86_op
with static_call() does no harm (well, doesn't explode at least).

So if we add wrapper macros, I would be in favor in removing all static_call_cond()
as a prep patch so that we can have a single macro.  kvm_ops_update() already WARNs
if a mandatory hook isn't defined, so doing more checks at runtime wouldn't provide
any value.

As for the name, what about KVM_X86_CALL() instead of KVM_X86_SC()?  Two extra
characters, but should make it much more obvious what's going on for readers that
aren't familiar with the infrastructure.

And I bet we can get away with KVM_PMU_CALL() for the PMU hooks.

[*] https://lore.kernel.org/all/cover.1679456900.git.jpoimboe@kernel.org

