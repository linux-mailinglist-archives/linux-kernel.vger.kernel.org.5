Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A927681285D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443236AbjLNGoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 01:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjLNGo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:44:28 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD56A6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 22:44:34 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6d9f879f784so4636993a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 22:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702536274; x=1703141074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxtiy01D8WpTYbLcMD+XHOmT3EOIKEJTAtmXTdX58vM=;
        b=lhFWUWZ/M5A9H75XVqXeeaRQLoxE1agNv2KgPpbL7X8QG2cJY446sqLefE9oRtcoEJ
         kHKBwWDECGK1Y8cdZOizt0NAN3I3iaI0liL8RFPGG/yuDgySlhINBzDF5joPmdzOjgEn
         BXrWnJn1ln9EtyZgDwqDyNZb9I5KtqVkF5XKV2Bgli90TXVFKzwS+N9HBy/Ylr/v0iLL
         hZXo/WErCLavzHhToLrZLCHh10LLOk9O5NXJeQfCicNu3XS+koQn4PpNY6Kq96hV5G9Q
         WYnIKACI3nt/ONIvahrFKdGVZp6MdWCrj9wnsTYNl91Q5WO5QOP0De15l83SCug/gdL5
         WdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702536274; x=1703141074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxtiy01D8WpTYbLcMD+XHOmT3EOIKEJTAtmXTdX58vM=;
        b=I6zs3xjJTsLeIgdaQnhzct5sq5yswxYk52fkxA6ot73WUDLZlfsPen6i4fAi2d97Ce
         CDOn+qnGO+ZjLMnA5pSsLpWcpiDnnOMk5rVVbfwMR0Og8qBC6CKIrxB4GFPpX99A/+Tk
         A1oF+okaiP1NtQJoMSPUWAErU++dN1nR5KmD3AXj6M4gPU5r6roZY6q4Gy3ukYApA4dI
         Fro0Bitejg3bsve3AY4OjCThpB3kbqTjYWXLdqhDmOUcAVnFc0X9+AsnSqq9PK7nSwMn
         H+rRw0PqhJFxHQpCNdwdrfjvF1PXTZdp1TlmolI1wIhOnkPPTvUCzy9nTV87lBaIHtfj
         txog==
X-Gm-Message-State: AOJu0Yznxmbq7RPEMUVhVbIACgrcmA4kK4YriDftvALtkAzfw/5V7WSL
        k7dn8+8nwyKPGdPF7hl9ypoL8XKhzacwZ1DeXwQ1qg==
X-Google-Smtp-Source: AGHT+IEPsCwgVMN/5iD2oOj8vwOEPOEacEvG4g4lr9eVc/vyryWU5/8R+8uC7/Gdwf/ytphMPl6gKCzWeBK6P1MjHrE=
X-Received: by 2002:a05:6808:13c4:b0:3b9:dea6:f336 with SMTP id
 d4-20020a05680813c400b003b9dea6f336mr11212909oiw.50.1702536273720; Wed, 13
 Dec 2023 22:44:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1702371136.git.haibo1.xu@intel.com> <0343a9e4bfa8011fbb6bca0286cee7eab1f17d5d.1702371136.git.haibo1.xu@intel.com>
In-Reply-To: <0343a9e4bfa8011fbb6bca0286cee7eab1f17d5d.1702371136.git.haibo1.xu@intel.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 14 Dec 2023 12:14:22 +0530
Message-ID: <CAAhSdy3hXNvGiSL0VToDp2GbWcaPveg8SoMeGFeGL=MmuCpsCg@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] KVM: selftests: Enable tunning of err_margin_us
 in arch timer test
To:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>
Cc:     xiaobo55x@gmail.com, haibo1.xu@intel.com, ajones@ventanamicro.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc, Hi Oliver,

On Tue, Dec 12, 2023 at 2:52=E2=80=AFPM Haibo Xu <haibo1.xu@intel.com> wrot=
e:
>
> There are intermittent failures occured when stressing the
> arch-timer test in a Qemu VM:
>
>  Guest assert failed,  vcpu 0; stage; 4; iter: 3
>  =3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D
>    aarch64/arch_timer.c:196: config_iter + 1 =3D=3D irq_iter
>    pid=3D4048 tid=3D4049 errno=3D4 - Interrupted system call
>       1  0x000000000040253b: test_vcpu_run at arch_timer.c:248
>       2  0x0000ffffb60dd5c7: ?? ??:0
>       3  0x0000ffffb6145d1b: ?? ??:0
>    0x3 !=3D 0x2 (config_iter + 1 !=3D irq_iter)e
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

Can you please review this patch ?

We want to take this entire series through the KVM RISC-V tree.

Regards,
Anup

> ---
>  .../selftests/kvm/aarch64/arch_timer.c        |  8 +++++--
>  tools/testing/selftests/kvm/arch_timer.c      | 22 +++++++++++++------
>  .../selftests/kvm/include/timer_test.h        |  1 +
>  .../testing/selftests/kvm/riscv/arch_timer.c  |  8 +++++--
>  4 files changed, 28 insertions(+), 11 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/tes=
ting/selftests/kvm/aarch64/arch_timer.c
> index 4b421d421c3f..139eecbf77e7 100644
> --- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
> +++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> @@ -131,10 +131,14 @@ static void guest_run_stage(struct test_vcpu_shared=
_data *shared_data,
>
>                 /* Setup a timeout for the interrupt to arrive */
>                 udelay(msecs_to_usecs(test_args.timer_period_ms) +
> -                       TIMER_TEST_ERR_MARGIN_US);
> +                       test_args.timer_err_margin_us);
>
>                 irq_iter =3D READ_ONCE(shared_data->nr_iter);
> -               GUEST_ASSERT_EQ(config_iter + 1, irq_iter);
> +               __GUEST_ASSERT(config_iter + 1 =3D=3D irq_iter,
> +                       "config_iter + 1 =3D 0x%lx, irq_iter =3D 0x%lx.\n=
"
> +                       "  Guest timer interrupt was not trigged within t=
he specified\n"
> +                       "  interval, try to increase the error margin by =
[-e] option.\n",
> +                       config_iter + 1, irq_iter);
>         }
>  }
>
> diff --git a/tools/testing/selftests/kvm/arch_timer.c b/tools/testing/sel=
ftests/kvm/arch_timer.c
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
>   * On the other hand, upon receipt of an interrupt, the guest's interrup=
t
>   * handler validates the interrupt by checking if the architectural stat=
e
>   * is in compliance with the specifications.
>   *
>   * The test provides command-line options to configure the timer's
> - * period (-p), number of vCPUs (-n), and iterations per stage (-i).
> - * To stress-test the timer stack even more, an option to migrate the
> - * vCPUs across pCPUs (-m), at a particular rate, is also provided.
> + * period (-p), number of vCPUs (-n), iterations per stage (-i), and tim=
er
> + * interrupt arrival error margin (-e). To stress-test the timer stack e=
ven
> + * more, an option to migrate the vCPUs across pCPUs (-m), at a particul=
ar
> + * rate, is also provided.
>   *
>   * Copyright (c) 2021, Google LLC.
>   */
> @@ -34,6 +35,7 @@ struct test_args test_args =3D {
>         .nr_iter =3D NR_TEST_ITERS_DEF,
>         .timer_period_ms =3D TIMER_TEST_PERIOD_MS_DEF,
>         .migration_freq_ms =3D TIMER_TEST_MIGRATION_FREQ_MS,
> +       .timer_err_margin_us =3D TIMER_TEST_ERR_MARGIN_US,
>         .reserved =3D 1,
>  };
>
> @@ -179,8 +181,9 @@ static void test_run(struct kvm_vm *vm)
>
>  static void test_print_help(char *name)
>  {
> -       pr_info("Usage: %s [-h] [-n nr_vcpus] [-i iterations] [-p timer_p=
eriod_ms]\n",
> -               name);
> +       pr_info("Usage: %s [-h] [-n nr_vcpus] [-i iterations] [-p timer_p=
eriod_ms]\n"
> +               "\t\t    [-m migration_freq_ms] [-o counter_offset]\n"
> +               "\t\t    [-e timer_err_margin_us]\n", name);
>         pr_info("\t-n: Number of vCPUs to configure (default: %u; max: %u=
)\n",
>                 NR_VCPUS_DEF, KVM_MAX_VCPUS);
>         pr_info("\t-i: Number of iterations per stage (default: %u)\n",
> @@ -190,6 +193,8 @@ static void test_print_help(char *name)
>         pr_info("\t-m: Frequency (in ms) of vCPUs to migrate to different=
 pCPU. 0 to turn off (default: %u)\n",
>                 TIMER_TEST_MIGRATION_FREQ_MS);
>         pr_info("\t-o: Counter offset (in counter cycles, default: 0) [aa=
rch64-only]\n");
> +       pr_info("\t-e: Interrupt arrival error margin(in us) of the guest=
 timer (default: %u)\n",
> +               TIMER_TEST_ERR_MARGIN_US);
>         pr_info("\t-h: print this help screen\n");
>  }
>
> @@ -197,7 +202,7 @@ static bool parse_args(int argc, char *argv[])
>  {
>         int opt;
>
> -       while ((opt =3D getopt(argc, argv, "hn:i:p:m:o:")) !=3D -1) {
> +       while ((opt =3D getopt(argc, argv, "hn:i:p:m:o:e:")) !=3D -1) {
>                 switch (opt) {
>                 case 'n':
>                         test_args.nr_vcpus =3D atoi_positive("Number of v=
CPUs", optarg);
> @@ -216,6 +221,9 @@ static bool parse_args(int argc, char *argv[])
>                 case 'm':
>                         test_args.migration_freq_ms =3D atoi_non_negative=
("Frequency", optarg);
>                         break;
> +               case 'e':
> +                       test_args.timer_err_margin_us =3D atoi_non_negati=
ve("Error Margin", optarg);
> +                       break;
>                 case 'o':
>                         test_args.counter_offset =3D strtol(optarg, NULL,=
 0);
>                         test_args.reserved =3D 0;
> diff --git a/tools/testing/selftests/kvm/include/timer_test.h b/tools/tes=
ting/selftests/kvm/include/timer_test.h
> index 968257b893a7..b1d405e7157d 100644
> --- a/tools/testing/selftests/kvm/include/timer_test.h
> +++ b/tools/testing/selftests/kvm/include/timer_test.h
> @@ -22,6 +22,7 @@ struct test_args {
>         int nr_iter;
>         int timer_period_ms;
>         int migration_freq_ms;
> +       int timer_err_margin_us;
>         /* Members of struct kvm_arm_counter_offset */
>         uint64_t counter_offset;
>         uint64_t reserved;
> diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/tools/testi=
ng/selftests/kvm/riscv/arch_timer.c
> index 13bf184d1ff5..45a139dc7ce3 100644
> --- a/tools/testing/selftests/kvm/riscv/arch_timer.c
> +++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
> @@ -55,10 +55,14 @@ static void guest_run(struct test_vcpu_shared_data *s=
hared_data)
>
>                 /* Setup a timeout for the interrupt to arrive */
>                 udelay(msecs_to_usecs(test_args.timer_period_ms) +
> -                       TIMER_TEST_ERR_MARGIN_US);
> +                       test_args.timer_err_margin_us);
>
>                 irq_iter =3D READ_ONCE(shared_data->nr_iter);
> -               GUEST_ASSERT_EQ(config_iter + 1, irq_iter);
> +               __GUEST_ASSERT(config_iter + 1 =3D=3D irq_iter,
> +                       "config_iter + 1 =3D 0x%lx, irq_iter =3D 0x%lx.\n=
"
> +                       "  Guest timer interrupt was not trigged within t=
he specified\n"
> +                       "  interval, try to increase the error margin by =
[-e] option.\n",
> +                       config_iter + 1, irq_iter);
>         }
>  }
>
> --
> 2.34.1
>
