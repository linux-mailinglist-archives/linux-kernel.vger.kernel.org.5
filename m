Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6BC78C277
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbjH2Klb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbjH2KlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:41:18 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1BA1AA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:41:13 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-44d60bb6aa5so1915516137.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693305672; x=1693910472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uq0twIbHfJhR39j1Okq5KqdBEmQgm7OtHD/B0a98m4o=;
        b=qIZwPKqtSRd5ATCAllPT8EV4T4gxGI6S6UYQ15dRIcyZxOwPfrBcbhOiCrToz+5fRy
         5k+LaqVKgen1ercePfiFJojKXuIMczxLfb43CdRWFcT4FgWsTJ0VU1CzsUci+p42hPp2
         kw6OG3uSSo4r2IFJj1Btn5o7ix96k+9ALUl2uJB/msb/N+5PkVfmTnc0m3gLUjQ1soXC
         m4TCDZfwPwb0mD5rCLe/7GICal3lbXWKZlaD6ehV+3avFymj4rybIf5b2f/y21Ez0o/5
         ++Kt7pFc9XaN0wYDAiwbYcr9xd/7yM8ymJgNYHSeNO5Ix/DDsr+Z0PUM6OpJAc9e57q+
         y3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693305672; x=1693910472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uq0twIbHfJhR39j1Okq5KqdBEmQgm7OtHD/B0a98m4o=;
        b=SPmMzLnX25xhvRue3emftNJa2ZkkcqX0UgEhzshLjZKUOm2G8tyrMf3SW5fHLvLVGr
         y2hSMHjZ0ui89JR+ZOhePy85FAIX7N3PjvxDaQ7Q3uQzg2SXCoxWAOyTJ5+CTeaep3Cp
         cJWh0N2IWbhOalTQhMWEzR5kFe2ZY4vKbM3FNvoSdSS6PodrwCA+VXBB0dvBAnGxTD3D
         W+jQebfWC8qBx+44JGRmuGbIrpRtL3Z1ll6O3uGEeJpHAsLun+7L/Z82Vqk7gV4oQ7R3
         kPmuAI/EI697brG4jnD06QS2xRBRGXKOJvaS0SotH+SkJuq/wu+teK9TaKFZ0OO4QHuC
         bUTQ==
X-Gm-Message-State: AOJu0Yzv1CyQn+dHJH3CY5sOx2iChuny/bNYJ3tnJH/SDC61QAHVLxMn
        PjrDyyvK975sWjX9tDStYJkW/YQ99Y5lBT4J1SRGEA==
X-Google-Smtp-Source: AGHT+IGH7wzy7FoFt53j1Wl8pOHg+HIIejrpPXYkORsQvwPy2CQYvDOVJGh+hxhV8WoG1gHRHPz9TAGqKsv7dZYykpA=
X-Received: by 2002:a05:6102:7cc:b0:44d:4e64:f175 with SMTP id
 y12-20020a05610207cc00b0044d4e64f175mr23582480vsg.5.1693305672186; Tue, 29
 Aug 2023 03:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230824153233.1006420-1-dianders@chromium.org> <20230824083012.v11.3.I7209db47ef8ec151d3de61f59005bbc59fe8f113@changeid>
In-Reply-To: <20230824083012.v11.3.I7209db47ef8ec151d3de61f59005bbc59fe8f113@changeid>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 29 Aug 2023 16:11:01 +0530
Message-ID: <CAFA6WYMJHr=r=3CvCq=nb1R_vt2jveJoyUXT4KsEtZea7wMF-w@mail.gmail.com>
Subject: Re: [PATCH v11 3/6] arm64: smp: Remove dedicated wakeup IPI
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kgdb-bugreport@lists.sourceforge.net,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-perf-users@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, ito-yuichi@fujitsu.com,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 at 21:03, Douglas Anderson <dianders@chromium.org> wrote:
>
> From: Mark Rutland <mark.rutland@arm.com>
>
> To enable NMI backtrace and KGDB's NMI cpu roundup, we need to free up
> at least one dedicated IPI.
>
> On arm64 the IPI_WAKEUP IPI is only used for the ACPI parking protocol,
> which itself is only used on some very early ARMv8 systems which
> couldn't implement PSCI.
>
> Remove the IPI_WAKEUP IPI, and rely on the IPI_RESCHEDULE IPI to wake
> CPUs from the parked state. This will cause a tiny amonut of redundant
> work to check the thread flags, but this is miniscule in relation to the
> cost of taking and handling the IPI in the first place. We can safely
> handle redundant IPI_RESCHEDULE IPIs, so there should be no functional
> impact as a result of this change.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Will Deacon <will@kernel.org>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> ---
> I have no idea how to test this. I just took Mark's patch and jammed
> it into my series. Logicially the patch seems reasonable to me.
>
> Changes in v11:
> - arch_send_wakeup_ipi() now takes an unsigned int.
>
> Changes in v10:
> - ("arm64: smp: Remove dedicated wakeup IPI") new for v10.
>
>  arch/arm64/include/asm/smp.h              |  4 ++--
>  arch/arm64/kernel/acpi_parking_protocol.c |  2 +-
>  arch/arm64/kernel/smp.c                   | 28 +++++++++--------------
>  3 files changed, 14 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
> index 9b31e6d0da17..efb13112b408 100644
> --- a/arch/arm64/include/asm/smp.h
> +++ b/arch/arm64/include/asm/smp.h
> @@ -89,9 +89,9 @@ extern void arch_send_call_function_single_ipi(int cpu);
>  extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
>
>  #ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
> -extern void arch_send_wakeup_ipi_mask(const struct cpumask *mask);
> +extern void arch_send_wakeup_ipi(unsigned int cpu);
>  #else
> -static inline void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
> +static inline void arch_send_wakeup_ipi(unsigned int cpu)
>  {
>         BUILD_BUG();
>  }
> diff --git a/arch/arm64/kernel/acpi_parking_protocol.c b/arch/arm64/kernel/acpi_parking_protocol.c
> index b1990e38aed0..e1be29e608b7 100644
> --- a/arch/arm64/kernel/acpi_parking_protocol.c
> +++ b/arch/arm64/kernel/acpi_parking_protocol.c
> @@ -103,7 +103,7 @@ static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
>                        &mailbox->entry_point);
>         writel_relaxed(cpu_entry->gic_cpu_id, &mailbox->cpu_id);
>
> -       arch_send_wakeup_ipi_mask(cpumask_of(cpu));
> +       arch_send_wakeup_ipi(cpu);
>
>         return 0;
>  }
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 960b98b43506..a5848f1ef817 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -72,7 +72,6 @@ enum ipi_msg_type {
>         IPI_CPU_CRASH_STOP,
>         IPI_TIMER,
>         IPI_IRQ_WORK,
> -       IPI_WAKEUP,
>         NR_IPI
>  };
>
> @@ -764,7 +763,6 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
>         [IPI_CPU_CRASH_STOP]    = "CPU stop (for crash dump) interrupts",
>         [IPI_TIMER]             = "Timer broadcast interrupts",
>         [IPI_IRQ_WORK]          = "IRQ work interrupts",
> -       [IPI_WAKEUP]            = "CPU wake-up interrupts",
>  };
>
>  static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
> @@ -797,13 +795,6 @@ void arch_send_call_function_single_ipi(int cpu)
>         smp_cross_call(cpumask_of(cpu), IPI_CALL_FUNC);
>  }
>
> -#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
> -void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
> -{
> -       smp_cross_call(mask, IPI_WAKEUP);
> -}
> -#endif
> -
>  #ifdef CONFIG_IRQ_WORK
>  void arch_irq_work_raise(void)
>  {
> @@ -897,14 +888,6 @@ static void do_handle_IPI(int ipinr)
>                 break;
>  #endif
>
> -#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
> -       case IPI_WAKEUP:
> -               WARN_ONCE(!acpi_parking_protocol_valid(cpu),
> -                         "CPU%u: Wake-up IPI outside the ACPI parking protocol\n",
> -                         cpu);
> -               break;
> -#endif
> -
>         default:
>                 pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
>                 break;
> @@ -979,6 +962,17 @@ void arch_smp_send_reschedule(int cpu)
>         smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
>  }
>
> +#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
> +void arch_send_wakeup_ipi(unsigned int cpu)
> +{
> +       /*
> +        * We use a scheduler IPI to wake the CPU as this avoids the need for a
> +        * dedicated IPI and we can safely handle spurious scheduler IPIs.
> +        */
> +       arch_smp_send_reschedule(cpu);
> +}
> +#endif
> +
>  #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
>  void tick_broadcast(const struct cpumask *mask)
>  {
> --
> 2.42.0.rc1.204.g551eb34607-goog
>
