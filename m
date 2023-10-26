Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1907D89DE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 22:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjJZUyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 16:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjJZUyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 16:54:08 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060F31BB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 13:54:06 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a88f9a1cf7so12116907b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 13:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698353645; x=1698958445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fo5/qY0vqR1wKONntqCGvrCUUB79DWn29mU9GhYSua8=;
        b=WTs3Ck87NpiKPm8AhjiMyERmSWL7lP5pBN2tIY00BsSpcZFePEkdJQ/F6oJ0U4jiWE
         rkKbcpmqoIQaSgc82D5VjKtm2QDRFjlPTzwmhWC4II2+UUmm/aGvbgQ9B6a3glUTL9R8
         EQ90fShS8aZkofRPESZjzNYPM82Nuao864LF10GxZWPIakUQhF/9+xTj/0Ng4uf5YZpN
         G9A/nYyHEHBYMx1bJTRyVC82C6FMUoeFCUXUvMRQVxVlVPO7jV/JEnXZXKe0iwt8whCu
         K7XMYbxqmFDykaeCKwK9cmyIMfp0VVT4vtJcV8wSaoh6sa2A6/+tt3lkPxlpffojNP4O
         4EUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698353645; x=1698958445;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fo5/qY0vqR1wKONntqCGvrCUUB79DWn29mU9GhYSua8=;
        b=XGLcvmgLXc9UdHU7aM6ljAAUbhMcGTvtbdaAPeP4lwbqz7P1oJK6jaZCqaWTub10hz
         ccK0VN/TDaJiqtWdZbdBbZWss9O72cSNmwb0ro0TLmYXFzfo6Pe8MpDXF0FVJT7QN2Fp
         WBQapt1Qw09D07PUoIajVyLJfdNEtMJh///3UGGfD0nPAksmG+A+IoXiaPeRdlLXYWtw
         66aGk6pUSzDbzyun/S/jlQUsuAbYnTTpmIPl3kq27enfUc2ZTAExF1ZCMfgS85RNWwyl
         VRXzKx4HmgBNyZqaC2ZzPHaGHlK1Yv+L4jnzSTBgpZptRpmr8Uxp5AfBzG1MkTlhMQXO
         A2Sg==
X-Gm-Message-State: AOJu0YwSpkqDsHrDS/yjOYm+5eZ60mU/g7PqPNqp/1l/ZW0GfWfwULlv
        nO9wUzE4gKURNoY4ianIc4mYVULG6wc=
X-Google-Smtp-Source: AGHT+IESk3JfDN8J+syPC1kUngbT+HWNHKa8Pt0XsOsB+si3lm+4U5jGM+Ml1rLBxb/DaWnXqpFOsOFb2TU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1083:b0:da0:567d:f819 with SMTP id
 v3-20020a056902108300b00da0567df819mr14416ybu.10.1698353645162; Thu, 26 Oct
 2023 13:54:05 -0700 (PDT)
Date:   Thu, 26 Oct 2023 13:54:03 -0700
In-Reply-To: <ZTrOYztylSn7jNIE@google.com>
Mime-Version: 1.0
References: <20231024002633.2540714-1-seanjc@google.com> <20231024002633.2540714-9-seanjc@google.com>
 <ZTrOYztylSn7jNIE@google.com>
Message-ID: <ZTrR638_KyKOwLIz@google.com>
Subject: Re: [PATCH v5 08/13] KVM: selftests: Test Intel PMU architectural
 events on gp counters
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jinrong Liang <cloudliang@tencent.com>,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023, Mingwei Zhang wrote:
> > +static bool pmu_is_intel_event_stable(uint8_t idx)
> > +{
> > +	switch (idx) {
> > +	case INTEL_ARCH_CPU_CYCLES:
> > +	case INTEL_ARCH_INSTRUCTIONS_RETIRED:
> > +	case INTEL_ARCH_REFERENCE_CYCLES:
> > +	case INTEL_ARCH_BRANCHES_RETIRED:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> 
> Brief explanation on why other events are not stable please. Since there
> are only a few architecture events, maybe listing all of them with
> explanation in comments would work better.

Heh, I've already rewritten this logic to make 


> > +
> > +static void guest_measure_pmu_v1(struct kvm_x86_pmu_feature event,
> > +				 uint32_t counter_msr, uint32_t nr_gp_counters)
> > +{
> > +	uint8_t idx = event.f.bit;
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < nr_gp_counters; i++) {
> > +		wrmsr(counter_msr + i, 0);
> > +		wrmsr(MSR_P6_EVNTSEL0 + i, ARCH_PERFMON_EVENTSEL_OS |
> > +		      ARCH_PERFMON_EVENTSEL_ENABLE | intel_pmu_arch_events[idx]);
> > +		__asm__ __volatile__("loop ." : "+c"((int){NUM_BRANCHES}));
> 
> Some comment might be needed for readability. Abuptly inserting inline
> assembly code in C destroys the readability.
> 
> I wonder do we need add 'clobber' here for the above line, since it
> takes away ecx?

It's already there.  You can't directly clobber a register that is used as an
input constraint.  The workaround is to make the register both an input and an
output, hense the "+c" in the outputs section instead of just "c" in the inputs
section.  The extra bit of cleverness is to use an intermediate anonymous variable
so that NUM_BRANCHES can effectively be passed in (#defines won't work as output
constraints).

> Also, I wonder if we need to disable IRQ here? This code might be
> intercepted and resumed. If so, then the test will get a different
> number?

This is guest code, disabling IRQs is pointless.  There are no guest virtual IRQs,
guarding aginst host IRQs is impossible, unnecessary, and actualy undesirable,
i.e. the guest vPMU shouldn't be counting host instructions and whatnot.

> > +
> > +		if (pmu_is_intel_event_stable(idx))
> > +			GUEST_ASSERT_EQ(this_pmu_has(event), !!_rdpmc(i));
> 
> Okay, just the counter value is non-zero means we pass the test ?!

FWIW, I've updated 

> hmm, I wonder other than IRQ stuff, what else may affect the result? NMI
> watchdog or what?

This is the beauty of selftests.  There _so_ simple that there are very few
surprises.  E.g. there are no events of any kind unless the test explicitly
generates them.  The downside is that doing anything complex in selftests requires
writing a fair bit of code.

> > +
> > +		wrmsr(MSR_P6_EVNTSEL0 + i, ARCH_PERFMON_EVENTSEL_OS |
> > +		      !ARCH_PERFMON_EVENTSEL_ENABLE |
> > +		      intel_pmu_arch_events[idx]);
> > +		wrmsr(counter_msr + i, 0);
> > +		__asm__ __volatile__("loop ." : "+c"((int){NUM_BRANCHES}));
> ditto for readability. Please consider using a macro to avoid repeated
> explanation.

Heh, already did this too.  Though I'm not entirely sure it's more readable.  It's
definitely more precise and featured :-)

#define GUEST_MEASURE_EVENT(_msr, _value, clflush, FEP)				\
do {										\
	__asm__ __volatile__("wrmsr\n\t"					\
			     clflush "\n\t"					\
			     "mfence\n\t"					\
			     "1: mov $" __stringify(NUM_BRANCHES) ", %%ecx\n\t"	\
			     FEP "loop .\n\t"					\
			     FEP "mov %%edi, %%ecx\n\t"				\
			     FEP "xor %%eax, %%eax\n\t"				\
			     FEP "xor %%edx, %%edx\n\t"				\
			     "wrmsr\n\t"					\
			     : "+c"((int){_msr})				\
			     : "a"((uint32_t)_value), "d"(_value >> 32),	\
			       "D"(_msr)					\
	);									\
} while (0)


> > +int main(int argc, char *argv[])
> > +{
> > +	TEST_REQUIRE(get_kvm_param_bool("enable_pmu"));
> > +
> > +	TEST_REQUIRE(host_cpu_is_intel);
> > +	TEST_REQUIRE(kvm_cpu_has_p(X86_PROPERTY_PMU_VERSION));
> > +	TEST_REQUIRE(kvm_cpu_property(X86_PROPERTY_PMU_VERSION) > 0);
> > +	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_PDCM));
> 
> hmm, this means we cannot run this in nested if X86_FEATURE_PDCM is
> missing. It only affects full-width counter, right?

Ah, yeah, good call.  It won't be too much trouble to have the test play nice
with !PDCM.
