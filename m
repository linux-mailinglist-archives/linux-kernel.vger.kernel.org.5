Return-Path: <linux-kernel+bounces-141659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E378A218C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985C61F2301B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23173BB43;
	Thu, 11 Apr 2024 22:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mTapYdtW"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AD43F9CB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 22:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712873001; cv=none; b=NZy5KdKmR/nKdvl+Gfi9i+r1Ir3H/eQlj8/UI0SdLStJmO59ln4cGfpLt2960ZShSHOrSzW8thGANH5h1Enb0MZ84QwG4kL8W0aB3ZAa+IwuYNREJr0VwZzYeg6ewu/7gmsJRdnwT65HV/6MiqO8qvBrYd5qP5DldeMzn8NO/ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712873001; c=relaxed/simple;
	bh=r3S1D7D1d5u7lgkAMt1Th9wNRtELr7qcxpz5RqhzGs0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pLKUGpMqGyJrcLe5E/4TQxPt1QTRvt5O6bGdtcqVbjv2XTzfcUDmGuYUqUTrKYfSqXGN90CdkVmC2T3jK0VHOXk8AFM4inWNnhLvTmslxOkxMKj0zrbB34EZw5zvERcJbc6iN82bm5Tze0pPHKOt1WNh3anbZM6mm2ZAx+ocM+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mTapYdtW; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2a482a2360aso1018734a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712872999; x=1713477799; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jmy317IqZY3AD7OCatKfL9RjqB6+hhlcNYc+DoqXhi8=;
        b=mTapYdtWdm3i434LgU4hFhF2wiCjOtJiPIcPZnTVPCRFnPVUrPEwXohKZ2X9vEH+i7
         EywWDGnh6kVMl2a0gwyESAfNzJRTtluJRIwcsFT8/mlL4c/PJ89MjWDt+4H6+Eac1Y4x
         AIVJsyx98fbmt21kVIx/IiDBJVov8pP4IsOhDDhCuyyqa6jpqfuxy0LgUTvFMtAUm8oD
         r10cAB7GOKVjM9ryzXM22X2SEMRJQogHa1YEltDnUK98I2bvd8sq4dO4iGSS6kSWE8ud
         TJbf85zscaPIRaPJoSveYAT2hI3E4HnVbNludHHN+MdRqqwARYPzdMZwM+MSOHk9NBO3
         e/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712872999; x=1713477799;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jmy317IqZY3AD7OCatKfL9RjqB6+hhlcNYc+DoqXhi8=;
        b=WcDLuyCxjew4wosaFmKKGeCKHaIgkSWbLLZZG+tyxQHcNniSSugEn4nEq7iwyUwEZ7
         M1s917olnOyvysGyTFovSH/a2wDewndDmMPYk5CQg+bxmZMOYsQJWm/zIzexJ8dAcflM
         IcyB6T6AQ1gVC3eTrSB0dMvsBqNPbSyS4ki4CtfVrbTUEbd4h9fUQt04JHB7c9Uka41m
         gf3h/QGckvsxS4OEUcOFUND3RrrtBprZr7nknS2AolX/a9n2HL/8reO/431Iy3uu3IJ7
         jxt172Jja7zqHqx/jwiLijZFFkLPTjB24E47X6WJAkyfOBkwJijPAJfScaJ8btCIxlqw
         cBBw==
X-Forwarded-Encrypted: i=1; AJvYcCXy9+j+2gvHQPC9Rhdr5QsaLXRh2fmKSvlyjtxg7j+MXB3psyQXWBsHJPYaycYsj/s09gODmuiVwKtXtLgi8hzNJUZkwZCYPpKhZDT0
X-Gm-Message-State: AOJu0Ywp5XN6pmMzVGfwpy9TtRbNPI2+BhUP8Ixetw/oaup7YW5t4PIJ
	TnxbPfO3NDGYXGZSQqKCnEMy2oVjZM2p5OU7um9cn96b+5MwU5TacArgvwdtbND/Mr6756uk+kl
	FGA==
X-Google-Smtp-Source: AGHT+IF9RN5OfQ3beoF3WDDZ3ue3mGb491uf8WF4DGDBox30e34jVKBmA/PdiWN/+r4zc3Csa8hJIU6BeT4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:90:b0:2a6:dbca:b80f with SMTP id
 bb16-20020a17090b009000b002a6dbcab80fmr1287pjb.0.1712872999220; Thu, 11 Apr
 2024 15:03:19 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:03:17 -0700
In-Reply-To: <20240126085444.324918-38-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-38-xiong.y.zhang@linux.intel.com>
Message-ID: <ZhheJUWRhCmmYa_F@google.com>
Subject: Re: [RFC PATCH 37/41] KVM: x86/pmu: Allow writing to fixed counter
 selector if counter is exposed
From: Sean Christopherson <seanjc@google.com>
To: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Cc: pbonzini@redhat.com, peterz@infradead.org, mizhang@google.com, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 26, 2024, Xiong Zhang wrote:
> From: Mingwei Zhang <mizhang@google.com>
> 
> Allow writing to fixed counter selector if counter is exposed. If this
> fixed counter is filtered out, this counter won't be enabled on HW.
> 
> Passthrough PMU implements the context switch at VM Enter/Exit boundary the
> guest value cannot be directly written to HW since the HW PMU is owned by
> the host. Introduce a new field fixed_ctr_ctrl_hw in kvm_pmu to cache the
> guest value.  which will be assigne to HW at PMU context restore.
> 
> Since passthrough PMU intercept writes to fixed counter selector, there is
> no need to read the value at pmu context save, but still clear the fix
> counter ctrl MSR and counters when switching out to host PMU.
> 
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/vmx/pmu_intel.c    | 28 ++++++++++++++++++++++++----
>  2 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index fd1c69371dbf..b02688ed74f7 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -527,6 +527,7 @@ struct kvm_pmu {
>  	unsigned nr_arch_fixed_counters;
>  	unsigned available_event_types;
>  	u64 fixed_ctr_ctrl;
> +	u64 fixed_ctr_ctrl_hw;
>  	u64 fixed_ctr_ctrl_mask;

Before introduce more fields, can someone please send a patch/series to rename
the _mask fields?  AFAIK, they all should be e.g. fixed_ctr_ctrl_rsvd, or something
to that effect.

Because I think we should avoid reinventing the naming wheel, and use "shadow"
instead of "hw", because KVM developers already know what "shadow" means.  But
"mask" also has very specific meaning for shadowed fields.  That, and "mask" is
a freaking awful name in the first place.

>  	u64 global_ctrl;
>  	u64 global_status;
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 713c2a7c7f07..93cfb86c1292 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -68,6 +68,25 @@ static int fixed_pmc_events[] = {
>  	[2] = PSEUDO_ARCH_REFERENCE_CYCLES,
>  };
>  
> +static void reprogram_fixed_counters_in_passthrough_pmu(struct kvm_pmu *pmu, u64 data)

We need to come up with shorter names, this ain't Java.  :-)  Heh, that can be
another argument for "mediated", it saves three characters.

And somewhat related, kernel style is <scope>_<blah>, i.e.

static void mediated_pmu_reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)

