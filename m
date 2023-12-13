Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994F8811494
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441928AbjLMO15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441915AbjLMO14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:27:56 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC6DEB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:28:01 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3363e9240b4so356671f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702477680; x=1703082480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BNBKKpdkcV+DWdI5qHghcJ1sc4cC3NPDWZMmK3clSqQ=;
        b=GWq71PmVvUKq8qkycBdckO4JE/vWenKJ9iEUl2CzYP8qtGR81XmWJHla7bcoo6kGT6
         Z0TAoEjJ87C40TxHsfQS/WAEJOZdcYpIDhemROM3H+ni3/Je8HUYXqvoZi+LVe5prHgM
         1EqA/tEZfUWVtgUsCruLL16ZQ7F5l9AqHA/AHGTINHDSf56jUa5e+Bve3eOF3j4sHCNs
         mgfczFv7PFO6CgQLFbiQUAGnXpizwLrCxv0SPp+XF0I8jvvvgJnaCh4O2Eu9JbvOykCz
         5BVMMlyg7ge+MYHi66KGCizCfsNNpCVITPh5oCzWpvoOSs764zWQZxHDASdzqWjNFf3I
         Sysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702477680; x=1703082480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNBKKpdkcV+DWdI5qHghcJ1sc4cC3NPDWZMmK3clSqQ=;
        b=dtKFm61sALn6G9YRfksvd5jMBIzCiaZPCnewL0IKhYLI8S+80JRNHm8TxBb3hSOpXr
         0yPoTFgoH5UGiBtvaZ54eBJAkW5PI5kxlVLudS1Gz0PCzvnaXugucV+5hRBzVceVIEnH
         beUvolglzVUoN8WnJBv9KAzUXTKs6mh4aWaaW/bxbQDG7FMOHTwKiLeWvJkPTIXfAJS5
         06vBtzGJCYMiUBf3BZMEiXGKOy3XcgwW+fNa17VymaFgypVxlW+UtAHb/NMSsqpxOGnM
         gWdjRAr5DnCr805+kOFxWtLYMJ6YzEb1YhVG6QNQEuGD7L06FaGRKqBSbDahGarTD1b/
         /8Ug==
X-Gm-Message-State: AOJu0YzWYsIyFGYYVBi5ZE2ztWguKaMgGbhqETUIS9ZuVHxG1D8bz3oi
        ZpT9/idnqwiTtvTvdloSkKj8Bw==
X-Google-Smtp-Source: AGHT+IESrcYW1zLn88so6PPi/w2TK6eJ4zzs7Zy4OWB48vOb0ysA2lcJnRlPw1rsdBQFtDNlOBH5BQ==
X-Received: by 2002:a05:6000:b42:b0:336:4322:a428 with SMTP id dk2-20020a0560000b4200b003364322a428mr150689wrb.35.1702477679716;
        Wed, 13 Dec 2023 06:27:59 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id t4-20020adff044000000b0033340937da6sm13364422wro.95.2023.12.13.06.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:27:59 -0800 (PST)
Date:   Wed, 13 Dec 2023 15:27:53 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        wchen <waylingii@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Minda Chen <minda.chen@starfivetech.com>,
        Samuel Holland <samuel@sholland.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Peter Xu <peterx@redhat.com>, Like Xu <likexu@tencent.com>,
        Vipin Sharma <vipinsh@google.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v4 11/11] KVM: selftests: Enable tunning of err_margin_us
 in arch timer test
Message-ID: <20231213-e11bcfdf39a34099bbc48cea@orel>
References: <cover.1702371136.git.haibo1.xu@intel.com>
 <0343a9e4bfa8011fbb6bca0286cee7eab1f17d5d.1702371136.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0343a9e4bfa8011fbb6bca0286cee7eab1f17d5d.1702371136.git.haibo1.xu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 05:31:20PM +0800, Haibo Xu wrote:
> There are intermittent failures occured when stressing the
> arch-timer test in a Qemu VM:
> 
>  Guest assert failed,  vcpu 0; stage; 4; iter: 3
>  ==== Test Assertion Failure ====
>    aarch64/arch_timer.c:196: config_iter + 1 == irq_iter
>    pid=4048 tid=4049 errno=4 - Interrupted system call
>       1  0x000000000040253b: test_vcpu_run at arch_timer.c:248
>       2  0x0000ffffb60dd5c7: ?? ??:0
>       3  0x0000ffffb6145d1b: ?? ??:0
>    0x3 != 0x2 (config_iter + 1 != irq_iter)e
> 
> Further test and debug show that the timeout for an interrupt
> to arrive do have random high fluctuation, espectially when
> testing in an virtual environment.
> 
> To alleviate this issue, just expose the timeout value as user
> configurable and print some hint message to increase the value
> when hitting the failure..
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  .../selftests/kvm/aarch64/arch_timer.c        |  8 +++++--
>  tools/testing/selftests/kvm/arch_timer.c      | 22 +++++++++++++------
>  .../selftests/kvm/include/timer_test.h        |  1 +
>  .../testing/selftests/kvm/riscv/arch_timer.c  |  8 +++++--
>  4 files changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> index 4b421d421c3f..139eecbf77e7 100644
> --- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
> +++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> @@ -131,10 +131,14 @@ static void guest_run_stage(struct test_vcpu_shared_data *shared_data,
>  
>  		/* Setup a timeout for the interrupt to arrive */
>  		udelay(msecs_to_usecs(test_args.timer_period_ms) +
> -			TIMER_TEST_ERR_MARGIN_US);
> +			test_args.timer_err_margin_us);
>  
>  		irq_iter = READ_ONCE(shared_data->nr_iter);
> -		GUEST_ASSERT_EQ(config_iter + 1, irq_iter);
> +		__GUEST_ASSERT(config_iter + 1 == irq_iter,
> +			"config_iter + 1 = 0x%lx, irq_iter = 0x%lx.\n"
> +			"  Guest timer interrupt was not trigged within the specified\n"
> +			"  interval, try to increase the error margin by [-e] option.\n",
> +			config_iter + 1, irq_iter);
>  	}
>  }
>  
> diff --git a/tools/testing/selftests/kvm/arch_timer.c b/tools/testing/selftests/kvm/arch_timer.c
> index 60963fce16f2..5050022fd345 100644
> --- a/tools/testing/selftests/kvm/arch_timer.c
> +++ b/tools/testing/selftests/kvm/arch_timer.c
> @@ -5,16 +5,17 @@
>   * The guest's main thread configures the timer interrupt and waits
>   * for it to fire, with a timeout equal to the timer period.
>   * It asserts that the timeout doesn't exceed the timer period plus
> - * an error margin of 100us.
> + * an user configurable error margin(default to 100us).
>   *
>   * On the other hand, upon receipt of an interrupt, the guest's interrupt
>   * handler validates the interrupt by checking if the architectural state
>   * is in compliance with the specifications.
>   *
>   * The test provides command-line options to configure the timer's
> - * period (-p), number of vCPUs (-n), and iterations per stage (-i).
> - * To stress-test the timer stack even more, an option to migrate the
> - * vCPUs across pCPUs (-m), at a particular rate, is also provided.
> + * period (-p), number of vCPUs (-n), iterations per stage (-i), and timer
> + * interrupt arrival error margin (-e). To stress-test the timer stack even
> + * more, an option to migrate the vCPUs across pCPUs (-m), at a particular
> + * rate, is also provided.
>   *
>   * Copyright (c) 2021, Google LLC.
>   */
> @@ -34,6 +35,7 @@ struct test_args test_args = {
>  	.nr_iter = NR_TEST_ITERS_DEF,
>  	.timer_period_ms = TIMER_TEST_PERIOD_MS_DEF,
>  	.migration_freq_ms = TIMER_TEST_MIGRATION_FREQ_MS,
> +	.timer_err_margin_us = TIMER_TEST_ERR_MARGIN_US,
>  	.reserved = 1,
>  };
>  
> @@ -179,8 +181,9 @@ static void test_run(struct kvm_vm *vm)
>  
>  static void test_print_help(char *name)
>  {
> -	pr_info("Usage: %s [-h] [-n nr_vcpus] [-i iterations] [-p timer_period_ms]\n",
> -		name);
> +	pr_info("Usage: %s [-h] [-n nr_vcpus] [-i iterations] [-p timer_period_ms]\n"
> +	        "\t\t    [-m migration_freq_ms] [-o counter_offset]\n"
> +	        "\t\t    [-e timer_err_margin_us]\n", name);
>  	pr_info("\t-n: Number of vCPUs to configure (default: %u; max: %u)\n",
>  		NR_VCPUS_DEF, KVM_MAX_VCPUS);
>  	pr_info("\t-i: Number of iterations per stage (default: %u)\n",
> @@ -190,6 +193,8 @@ static void test_print_help(char *name)
>  	pr_info("\t-m: Frequency (in ms) of vCPUs to migrate to different pCPU. 0 to turn off (default: %u)\n",
>  		TIMER_TEST_MIGRATION_FREQ_MS);
>  	pr_info("\t-o: Counter offset (in counter cycles, default: 0) [aarch64-only]\n");
> +	pr_info("\t-e: Interrupt arrival error margin(in us) of the guest timer (default: %u)\n",
                                                     ^ need space here

> +		TIMER_TEST_ERR_MARGIN_US);
>  	pr_info("\t-h: print this help screen\n");
>  }
>  
> @@ -197,7 +202,7 @@ static bool parse_args(int argc, char *argv[])
>  {
>  	int opt;
>  
> -	while ((opt = getopt(argc, argv, "hn:i:p:m:o:")) != -1) {
> +	while ((opt = getopt(argc, argv, "hn:i:p:m:o:e:")) != -1) {
>  		switch (opt) {
>  		case 'n':
>  			test_args.nr_vcpus = atoi_positive("Number of vCPUs", optarg);
> @@ -216,6 +221,9 @@ static bool parse_args(int argc, char *argv[])
>  		case 'm':
>  			test_args.migration_freq_ms = atoi_non_negative("Frequency", optarg);
>  			break;
> +		case 'e':
> +			test_args.timer_err_margin_us = atoi_non_negative("Error Margin", optarg);
> +			break;
>  		case 'o':
>  			test_args.counter_offset = strtol(optarg, NULL, 0);
>  			test_args.reserved = 0;
> diff --git a/tools/testing/selftests/kvm/include/timer_test.h b/tools/testing/selftests/kvm/include/timer_test.h
> index 968257b893a7..b1d405e7157d 100644
> --- a/tools/testing/selftests/kvm/include/timer_test.h
> +++ b/tools/testing/selftests/kvm/include/timer_test.h
> @@ -22,6 +22,7 @@ struct test_args {
>  	int nr_iter;
>  	int timer_period_ms;
>  	int migration_freq_ms;
> +	int timer_err_margin_us;
>  	/* Members of struct kvm_arm_counter_offset */
>  	uint64_t counter_offset;
>  	uint64_t reserved;
> diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/tools/testing/selftests/kvm/riscv/arch_timer.c
> index 13bf184d1ff5..45a139dc7ce3 100644
> --- a/tools/testing/selftests/kvm/riscv/arch_timer.c
> +++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
> @@ -55,10 +55,14 @@ static void guest_run(struct test_vcpu_shared_data *shared_data)
>  
>  		/* Setup a timeout for the interrupt to arrive */
>  		udelay(msecs_to_usecs(test_args.timer_period_ms) +
> -			TIMER_TEST_ERR_MARGIN_US);
> +			test_args.timer_err_margin_us);
>  
>  		irq_iter = READ_ONCE(shared_data->nr_iter);
> -		GUEST_ASSERT_EQ(config_iter + 1, irq_iter);
> +		__GUEST_ASSERT(config_iter + 1 == irq_iter,
> +			"config_iter + 1 = 0x%lx, irq_iter = 0x%lx.\n"
> +			"  Guest timer interrupt was not trigged within the specified\n"
> +			"  interval, try to increase the error margin by [-e] option.\n",
> +			config_iter + 1, irq_iter);
>  	}
>  }
>  
> -- 
> 2.34.1
>

I probably would have started the series with this patch since you said
you could reproduce the problem on aarch64. Starting the series with
this patch would allow just this patch to get picked up to fix aarch64,
if that's necessary, and also avoids touching a couple places twice
with the code split for riscv.

But anyway, other than the missing space in the help text,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
