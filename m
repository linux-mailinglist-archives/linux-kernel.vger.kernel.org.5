Return-Path: <linux-kernel+bounces-145282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F1F8A5206
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB9F285006
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A7073504;
	Mon, 15 Apr 2024 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="BlkE2F4m"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC346FE0D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188638; cv=none; b=dUQ9tSrZ566291iMRBzYrRRz19iPGZOcqOG+2OhhB/cDohqPj+RyqnIjaXTrpkoNvTEywJjRr48kcbXEKrXRiK5tYjO0x1i1edcAFyq414LPRvmc7Fjnkwd4z6zkmZ081T9Vb5cMq+Cvt/S9eu4cbZqHjsHGIT/qa+0BynUTdso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188638; c=relaxed/simple;
	bh=wiZZBUwFBfFJ8JX5HoSa5Tz8CCR776e4YmB5I1+UeZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZv75D8S/+ymnDwU3k/8hJMHcgvdIHYZuavbPSVd8+/BKLEMHNh6IAxxpmgWGpIt9u03V7PkmoEtM06GRsluJi2skirYuO5S9dPTWmeex8TAIwwrp4qrl6lpG9I/MC+SrLlXdxssJmIPFTmKzFpG7M87vkN+WlUqZDzvSY4xuFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=BlkE2F4m; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4181f9b4270so9994105e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713188634; x=1713793434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oBlw086cFKfVgD6m6+KXW8B1bVXOlMOqtJCrOvRcQ7k=;
        b=BlkE2F4mvYE9aCDGWQJCq1e+ryZ81EKAPTFDkAxYayjeRNzo75dUVLoH0VGTya9fuK
         iYTvKvlALY5I2jkDOoR7CZteAt0IJuKa4T/vZ5WkRDC3+bKSuI7Rai7zQhXyqd8Lc7vx
         M2EnmeznJCQgrbotEzfNICshcB1NqWJbp3y2skgEEa+TbgJi0PRzrP/nClihWctqa1iZ
         tVzdg+9z61thb1+AMc2v1/lqOS8qu9XQe3RA+tiPFGoVsEl9wMQG/5cZeqEnFSDIGM4X
         g1n/aaGI1zrQPqTvC0cFtkzOJ9j3XnOSY9CBHqtC3g3S0ulEVQGHMTh7TVOz9JfEERGP
         ZHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713188634; x=1713793434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBlw086cFKfVgD6m6+KXW8B1bVXOlMOqtJCrOvRcQ7k=;
        b=iU0lRXikQ9mrJZ8rSeEkK7zBEZFFZu9Ur5j3cJjTxW5a4dvXiSYRy7beIY8w3DYEH6
         gRdnQmDtL7ckn6I8pnYfKpGUbFUYiOIMdpywy7OUkEcy71ONQds2hg4dydudg06sXC3f
         sO6uF2PkjmEMThPtr3GAruDm1jdexBPYMJQ3bB5aLXHoBsT72biuY68qsEcaOCN0WRjb
         ZCJ5agIA6h8maYYDXpMWmZMU2r4HI6ck8OFtAxdOD/WlIwwVdCJvl1R3KvGu653aice4
         5U46fnx2axjS+450xhyfS9BKQmQXY8s0g5SVpt24Gws2vcqbseEa8rXzfCAqjPWg/UnL
         03Og==
X-Gm-Message-State: AOJu0YzQDkkgN14hCnff4gXYcP3U3BE3wDzJGEz5wCi9oHBdNEOmQwEj
	skpuKCIYocSB6cg+gqRkxwO5QeprFpZ8OIVjklJE4SVBF3QsCjiQXAw2EhLbcWw=
X-Google-Smtp-Source: AGHT+IFSJX/JAylOq7lyfTWV1n1rGtpOd6txYa80kvU3cra08zVigOgalF/jjTxDvlEfsaeWSmIeIQ==
X-Received: by 2002:a05:600c:4ecb:b0:418:2d69:d978 with SMTP id g11-20020a05600c4ecb00b004182d69d978mr4057431wmq.10.1713188633673;
        Mon, 15 Apr 2024 06:43:53 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c1d1700b004163ee3922csm19555595wms.38.2024.04.15.06.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 06:43:53 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:43:52 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Alexey Makhalov <alexey.amakhalov@broadcom.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, Will Deacon <will@kernel.org>, 
	x86@kernel.org
Subject: Re: [PATCH v6 24/24] KVM: riscv: selftests: Add commandline option
 for SBI PMU test
Message-ID: <20240415-8b9ad5a7e968b1808e99e3da@orel>
References: <20240411000752.955910-1-atishp@rivosinc.com>
 <20240411000752.955910-25-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411000752.955910-25-atishp@rivosinc.com>

On Wed, Apr 10, 2024 at 05:07:52PM -0700, Atish Patra wrote:
> SBI PMU test comprises of multiple tests and user may want to run
> only a subset depending on the platform. The most common case would
> be to run all to validate all the tests. However, some platform may
> not support all events or all ISA extensions.
> 
> The commandline option allows user to disable particular test if they
> want to.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  .../selftests/kvm/riscv/sbi_pmu_test.c        | 77 ++++++++++++++++---
>  1 file changed, 68 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> index 0fd9b76ae838..57025b07a403 100644
> --- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> @@ -33,6 +33,16 @@ static unsigned long counter_mask_available;
>  
>  static bool illegal_handler_invoked;
>  
> +enum sbi_pmu_test_id {
> +	SBI_PMU_TEST_BASIC = 0,
> +	SBI_PMU_TEST_EVENTS,
> +	SBI_PMU_TEST_SNAPSHOT,
> +	SBI_PMU_TEST_OVERFLOW,
> +	SBI_PMU_TEST_MAX,
> +};
> +
> +static int disabled_test_id = SBI_PMU_TEST_MAX;

I think we should allow specifying '-d' multiple times in case a user
wants to disable more than one type of test. So we should set a bit
in this variable instead of assigning it. We could also flip it
around. If the user uses '-e' to enable test type then only type
will be run, but then we'd probably want to allow multiple '-e'
too so it doesn't gain anything.

> +
>  unsigned long pmu_csr_read_num(int csr_num)
>  {
>  #define switchcase_csr_read(__csr_num, __val)		{\
> @@ -608,19 +618,68 @@ static void test_vm_events_overflow(void *guest_code)
>  	test_vm_destroy(vm);
>  }
>  
> -int main(void)
> +static void test_print_help(char *name)
>  {
> -	test_vm_basic_test(test_pmu_basic_sanity);
> -	pr_info("SBI PMU basic test : PASS\n");
> +	pr_info("Usage: %s [-h] [-d <test name>]\n", name);
> +	pr_info("\t-d: Test to disable. Available tests are 'basic', 'events', 'snapshot', 'overflow'\n");
> +	pr_info("\t-h: print this help screen\n");
> +}
>  
> -	test_vm_events_test(test_pmu_events);
> -	pr_info("SBI PMU event verification test : PASS\n");
> +static bool parse_args(int argc, char *argv[])
> +{
> +	int opt;
> +
> +	while ((opt = getopt(argc, argv, "hd:")) != -1) {
> +		switch (opt) {
> +		case 'd':
> +			if (!strncmp("basic", optarg, 5))
> +				disabled_test_id = SBI_PMU_TEST_BASIC;
> +			else if (!strncmp("events", optarg, 6))
> +				disabled_test_id = SBI_PMU_TEST_EVENTS;
> +			else if (!strncmp("snapshot", optarg, 8))
> +				disabled_test_id = SBI_PMU_TEST_SNAPSHOT;
> +			else if (!strncmp("overflow", optarg, 8))
> +				disabled_test_id = SBI_PMU_TEST_OVERFLOW;
> +			else
> +				goto done;
> +			break;
> +		break;

Extra 'break'

> +		case 'h':
> +		default:
> +			goto done;
> +		}
> +	}
>  
> -	test_vm_events_snapshot_test(test_pmu_events_snaphost);
> -	pr_info("SBI PMU event verification with snapshot test : PASS\n");
> +	return true;
> +done:
> +	test_print_help(argv[0]);
> +	return false;
> +}
>  
> -	test_vm_events_overflow(test_pmu_events_overflow);
> -	pr_info("SBI PMU event verification with overflow test : PASS\n");
> +int main(int argc, char *argv[])
> +{
> +	if (!parse_args(argc, argv))
> +		exit(KSFT_SKIP);
> +
> +	if (disabled_test_id != SBI_PMU_TEST_BASIC) {
> +		test_vm_basic_test(test_pmu_basic_sanity);
> +		pr_info("SBI PMU basic test : PASS\n");
> +	}
> +
> +	if (disabled_test_id != SBI_PMU_TEST_EVENTS) {
> +		test_vm_events_test(test_pmu_events);
> +		pr_info("SBI PMU event verification test : PASS\n");
> +	}
> +
> +	if (disabled_test_id != SBI_PMU_TEST_SNAPSHOT) {
> +		test_vm_events_snapshot_test(test_pmu_events_snaphost);
> +		pr_info("SBI PMU event verification with snapshot test : PASS\n");
> +	}
> +
> +	if (disabled_test_id != SBI_PMU_TEST_OVERFLOW) {
> +		test_vm_events_overflow(test_pmu_events_overflow);
> +		pr_info("SBI PMU event verification with overflow test : PASS\n");
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.34.1
>

Thanks,
drew

