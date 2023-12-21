Return-Path: <linux-kernel+bounces-8868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A45381BD69
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3665283D14
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD6D6280D;
	Thu, 21 Dec 2023 17:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZlJtQv9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D853362804
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703180326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=juVK00ddSooe55Wxw0xrmMZR0SUwFjF9BwCfKHEAVkA=;
	b=TZlJtQv9Ca6X3wjAUudhQvSlgoOE2oxR8wELG8atcdBwrJZNHO5qlZXaL6pbEXxVF0fkhk
	4m68TgjlNSV6WNpiGhD1yl6uzuALe+uarOvV8InwaaDolhKl9lhGeJGevoF9f+Fxm3VnIQ
	NvT0dR+TywlTV/98SN6ghNIKlCh56j8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-KjLEusJkNtis1a1FOpAJcQ-1; Thu, 21 Dec 2023 12:38:45 -0500
X-MC-Unique: KjLEusJkNtis1a1FOpAJcQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2cca7b80b20so303011fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:38:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703180324; x=1703785124;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=juVK00ddSooe55Wxw0xrmMZR0SUwFjF9BwCfKHEAVkA=;
        b=tSWVndj90/Y3MSFJ0FTEXU4+3V+yfMFw5Mh8WZwCkV/3TG0ht2ge3uIsV+rDdqSTZl
         GbGQpi16bvL2kf0yBF4+lAbHERMzG4R+X/KNcauUQDBU+V8twYI6VW2A3DBXEL4hHgBK
         g/fZLNy+UYra9DO4A9G784gVy+R3M6vCGjsW/3exqlU57VZ0e78sL6Kab9+YGhZAqSkh
         m6Ip1cI9j8wrGokFY65BMocnL+MjrJ3Kus9J5bbSiFKiA7aco1ywsQtQnDadP2uXIAs5
         fF/A6pL720IvNV2ybwpA0Jsg5Z0cdlRZPZN8fLbFzpiTXfT9zdFElgfGgsgunw1bq6aT
         06sg==
X-Gm-Message-State: AOJu0YwaTowwOGvHrKnINC4zNMFQUht69Mp3s4Rj+K2Wj6LQstuy9amD
	/mLeSFuWHzRGksFSmPBcQZssMxrW7oJnPpom1eRsin33DHJAPAohC2gqvJKrJhrJHwnTmOhcGcF
	jbSQNSorMe4yqNueokIUkt353
X-Received: by 2002:a05:651c:198b:b0:2cc:a6a4:ec with SMTP id bx11-20020a05651c198b00b002cca6a400ecmr148342ljb.21.1703180323708;
        Thu, 21 Dec 2023 09:38:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnweRe91tHmInwNUi/xnrrP6CH2qZagS31A4zsvAsC2eiha3LOwPVqxwx9Co0G4mdUQnTUjA==
X-Received: by 2002:a05:651c:198b:b0:2cc:a6a4:ec with SMTP id bx11-20020a05651c198b00b002cca6a400ecmr148339ljb.21.1703180323308;
        Thu, 21 Dec 2023 09:38:43 -0800 (PST)
Received: from starship ([77.137.131.62])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7c786000000b0054c9df4317dsm1443322eds.7.2023.12.21.09.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:38:42 -0800 (PST)
Message-ID: <9dd04b84f0d37a44e07add77f62c931cba7743a7.camel@redhat.com>
Subject: Re: [PATCH v3 4/4] KVM: selftests: Add test case for x86
 apic_bus_clock_frequency
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Isaku Yamahata <isaku.yamahata@intel.com>, kvm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
 erdemaktas@google.com, Sean Christopherson <seanjc@google.com>, Vishal
 Annapurve <vannapurve@google.com>, Jim Mattson <jmattson@google.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Cc: isaku.yamahata@gmail.com
Date: Thu, 21 Dec 2023 19:38:40 +0200
In-Reply-To: <f738cb171c6d47b72b5e608777cf64fa3958183a.1702974319.git.isaku.yamahata@intel.com>
References: <cover.1702974319.git.isaku.yamahata@intel.com>
	 <f738cb171c6d47b72b5e608777cf64fa3958183a.1702974319.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2023-12-19 at 00:34 -0800, Isaku Yamahata wrote:
> Test if the apic bus clock frequency is exptected to the configured value.
Typo.
> Set APIC TMICT to the maximum value and busy wait for 100 msec (any value
> is okay) with tsc value, and read TMCCT. Calculate apic bus clock frequency
> based on TSC frequency.
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
> Changes v3:
> - Use 1.5GHz instead of 1GHz as frequency.
> 
> Changes v2:
> - Newly added.
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/include/x86_64/apic.h       |   7 +
>  .../kvm/x86_64/apic_bus_clock_test.c          | 135 ++++++++++++++++++
>  3 files changed, 143 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/apic_bus_clock_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 963435959a92..e07ec9c1dbd1 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -116,6 +116,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/vmx_invalid_nested_guest_state
>  TEST_GEN_PROGS_x86_64 += x86_64/vmx_set_nested_state_test
>  TEST_GEN_PROGS_x86_64 += x86_64/vmx_tsc_adjust_test
>  TEST_GEN_PROGS_x86_64 += x86_64/vmx_nested_tsc_scaling_test
> +TEST_GEN_PROGS_x86_64 += x86_64/apic_bus_clock_test
>  TEST_GEN_PROGS_x86_64 += x86_64/xapic_ipi_test
>  TEST_GEN_PROGS_x86_64 += x86_64/xapic_state_test
>  TEST_GEN_PROGS_x86_64 += x86_64/xcr0_cpuid_test
> diff --git a/tools/testing/selftests/kvm/include/x86_64/apic.h b/tools/testing/selftests/kvm/include/x86_64/apic.h
> index bed316fdecd5..866a58d5fa11 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/apic.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/apic.h
> @@ -60,6 +60,13 @@
>  #define		APIC_VECTOR_MASK	0x000FF
>  #define	APIC_ICR2	0x310
>  #define		SET_APIC_DEST_FIELD(x)	((x) << 24)
> +#define APIC_LVT0       0x350
> +#define         APIC_LVT_TIMER_ONESHOT          (0 << 17)
> +#define         APIC_LVT_TIMER_PERIODIC         (1 << 17)
> +#define         APIC_LVT_TIMER_TSCDEADLINE      (2 << 17)
> +#define APIC_TMICT	0x380
> +#define APIC_TMCCT	0x390
> +#define APIC_TDCR	0x3E0
>  
>  void apic_disable(void);
>  void xapic_enable(void);
> diff --git a/tools/testing/selftests/kvm/x86_64/apic_bus_clock_test.c b/tools/testing/selftests/kvm/x86_64/apic_bus_clock_test.c
> new file mode 100644
> index 000000000000..e7896d703e7d
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/apic_bus_clock_test.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#define _GNU_SOURCE /* for program_invocation_short_name */
> +
> +#include "apic.h"
> +#include "test_util.h"
> +
> +/*
> + * Pick one convenient value, 1.5Ghz.  No special meaning and different from
> + * the default value, 1Ghz.
> + */
> +#define TSC_HZ			(1500 * 1000 * 1000ULL)
> +
> +/* Wait for 100 msec, not too long, not too short value. */
> +#define LOOP_MSEC		100ULL
> +#define TSC_WAIT_DELTA		(TSC_HZ / 1000 * LOOP_MSEC)
> +
> +/* Pick up typical value.  Different enough from the default value, 1GHz.  */
> +#define APIC_BUS_CLOCK_FREQ	(25 * 1000 * 1000ULL)
> +
> +static void guest_code(void)
> +{
> +	/* Possible tdcr values and its divide count. */
> +	struct {
> +		u32 tdcr;
> +		u32 divide_count;
> +	} tdcrs[] = {
> +		{0x0, 2},
> +		{0x1, 4},
> +		{0x2, 8},
> +		{0x3, 16},
> +		{0x8, 32},
> +		{0x9, 64},
> +		{0xa, 128},
> +		{0xb, 1},
> +	};
> +
> +	u32 tmict, tmcct;
> +	u64 tsc0, tsc1;
> +	int i;
> +
> +	asm volatile("cli");
> +
> +	xapic_enable();
> +
> +	/*
> +	 * Setup one-shot timer.  Because we don't fire the interrupt, the
> +	 * vector doesn't matter.
> +	 */
> +	xapic_write_reg(APIC_LVT0, APIC_LVT_TIMER_ONESHOT);
> +
> +	for (i = 0; i < ARRAY_SIZE(tdcrs); i++) {
> +		xapic_write_reg(APIC_TDCR, tdcrs[i].tdcr);
> +
> +		/* Set the largest value to not trigger the interrupt. */
> +		tmict = ~0;
> +		xapic_write_reg(APIC_TMICT, tmict);
> +
> +		/* Busy wait for LOOP_MSEC */
> +		tsc0 = rdtsc();
> +		tsc1 = tsc0;
> +		while (tsc1 - tsc0 < TSC_WAIT_DELTA)
> +			tsc1 = rdtsc();
> +
> +		/* Read apic timer and tsc */
> +		tmcct = xapic_read_reg(APIC_TMCCT);
> +		tsc1 = rdtsc();
> +
> +		/* Stop timer */
> +		xapic_write_reg(APIC_TMICT, 0);
> +
> +		/* Report it. */
> +		GUEST_SYNC_ARGS(tdcrs[i].divide_count, tmict - tmcct,
> +				tsc1 - tsc0, 0, 0);
> +	}
> +
> +	GUEST_DONE();
> +}
> +
> +void test_apic_bus_clock(struct kvm_vcpu *vcpu)
> +{
> +	bool done = false;
> +	struct ucall uc;
> +
> +	while (!done) {
> +		vcpu_run(vcpu);
> +		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> +
> +		switch (get_ucall(vcpu, &uc)) {
> +		case UCALL_DONE:
> +			done = true;
> +			break;
> +		case UCALL_ABORT:
> +			REPORT_GUEST_ASSERT(uc);
> +			break;
> +		case UCALL_SYNC: {
> +			u32 divide_counter = uc.args[1];
> +			u32 apic_cycles = uc.args[2];
> +			u64 tsc_cycles = uc.args[3];
> +			u64 freq;
> +
> +			TEST_ASSERT(tsc_cycles > 0,
> +				    "tsc cycles must not be zero.");
> +
> +			/* Allow 1% slack. */
> +			freq = apic_cycles * divide_counter * TSC_HZ / tsc_cycles;
> +			TEST_ASSERT(freq < APIC_BUS_CLOCK_FREQ * 101 / 100,
> +				    "APIC bus clock frequency is too large");
> +			TEST_ASSERT(freq > APIC_BUS_CLOCK_FREQ * 99 / 100,
> +				    "APIC bus clock frequency is too small");
> +			break;
> +		}
> +		default:
> +			TEST_FAIL("Unknown ucall %lu", uc.cmd);
> +			break;
> +		}
> +	}
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	vm = __vm_create(VM_MODE_DEFAULT, 1, 0);
> +	vm_ioctl(vm, KVM_SET_TSC_KHZ, (void *) (TSC_HZ / 1000));
> +	/*  KVM_CAP_X86_BUS_FREQUENCY_CONTROL requires that no vcpu is created. */
> +	vm_enable_cap(vm, KVM_CAP_X86_BUS_FREQUENCY_CONTROL,
> +		      APIC_BUS_CLOCK_FREQ);
> +	vcpu = vm_vcpu_add(vm, 0, guest_code);
> +
> +	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
> +
> +	test_apic_bus_clock(vcpu);
> +	kvm_vm_free(vm);
> +}



Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



