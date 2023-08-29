Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F6378C25E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjH2Kiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjH2KiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:38:21 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F8719F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:38:18 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-44dbd5011beso1926359137.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693305497; x=1693910297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+S+OFM/SaIRDO4CZ1HS1+M3zY1M1wtDfmawa09i8kOs=;
        b=k18WsEYTY3SR8erQgVThbNFJcwf6j8oip5Wo2DTgEhMok+WoxDTppiV+l9fB+Qjtpj
         pKaRjzpqn2phfhYnEwLwTcGUwZk6w1lIytKg5ddmpvEH5d3EkDzXtiLyLb38TkhYcRHn
         CILIMjU98/jqzJ/2XadrR6NCYfEI+xleJpQWoaQEWcLE+6nDsWv6Lm4k5htDoK60R6xk
         9QB9V1rmeKNQEC3ofe+B+01SF7rER2vxsy59W5aTIDD/j77mkw/mV2tz/+eLzXmDBkqh
         cUtAAHMKSShlmJQ33CR6wnfFU3uWjdDUgCui+pzf5S5A+fZ/8Cd6AdHqGA+ShNF7rdBA
         bXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693305497; x=1693910297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+S+OFM/SaIRDO4CZ1HS1+M3zY1M1wtDfmawa09i8kOs=;
        b=dLq6I3j268zWjfX+a3f0XwVob1cQuZeFUZ1gP54GIvkf4j++/3xXFKJcfZ8KGQ7Ave
         BRJsVPQYFViwisCmnEnk3BNsQVtK4ZdEaDqchd7KL2iV4h4kjfi00ntbieLX64yehbOU
         HA24wBiEjVx9KGUVr9AYdxxNMu9wlI2BhaIpwQZMGhRCrR0YYGPvhjijeI1e0WoMj6DU
         aEZSX5jEPB0bL9H9baqTGyhjYfNNfUPRcSypMGIzybBDzUr+Yofk1W+Oa2iSLbuvfoiS
         8vEB/otEIrWn9zci20Saot/dzyqXFyoOo+iR10TSb2rpw064WalNcedbYCjUM7oDbRaS
         WyEA==
X-Gm-Message-State: AOJu0Yxa4NA+jUjcZBgpDjRwyPtKBEu9oQEREsGLtOx0rQ9uKB7AdC49
        T12L4LQ6rDDxNAXei0Q3ayN8PElVuKkM8vKRJ7Vy2A==
X-Google-Smtp-Source: AGHT+IG4F5FrbB4LuavW+U011p9kyW0QyLMMxVW2gdfWcMm62cCwqrvaWq+v3KTsnGiFNLdYRP1OcPJsbCnuHRxqABU=
X-Received: by 2002:a67:eb0b:0:b0:44d:4904:e080 with SMTP id
 a11-20020a67eb0b000000b0044d4904e080mr21530579vso.31.1693305497289; Tue, 29
 Aug 2023 03:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230824153233.1006420-1-dianders@chromium.org> <20230824083012.v11.2.I4baba13e220bdd24d11400c67f137c35f07f82c7@changeid>
In-Reply-To: <20230824083012.v11.2.I4baba13e220bdd24d11400c67f137c35f07f82c7@changeid>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 29 Aug 2023 16:08:06 +0530
Message-ID: <CAFA6WYM2xTxBaNf8fjg3n0HotTaHezsB_e+eNgXK3PsSfWKx4A@mail.gmail.com>
Subject: Re: [PATCH v11 2/6] arm64: idle: Tag the arm64 idle functions as __cpuidle
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
        Frederic Weisbecker <frederic@kernel.org>,
        Guo Ren <guoren@kernel.org>, Ingo Molnar <mingo@kernel.org>,
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
> As per the (somewhat recent) comment before the definition of
> `__cpuidle`, the tag is like `noinstr` but also marks a function so it
> can be identified by cpu_in_idle(). Let's add these markings to arm64
> cpuidle functions
>
> With this change we get useful backtraces like:
>
>   NMI backtrace for cpu N skipped: idling at cpu_do_idle+0x94/0x98
>
> instead of useless backtraces when dumping all processors using
> nmi_cpu_backtrace().
>
> NOTE: this patch won't make cpu_in_idle() work perfectly for arm64,
> but it doesn't hurt and does catch some cases. Specifically an example
> that wasn't caught in my testing looked like this:
>
>  gic_cpu_sys_reg_init+0x1f8/0x314
>  gic_cpu_pm_notifier+0x40/0x78
>  raw_notifier_call_chain+0x5c/0x134
>  cpu_pm_notify+0x38/0x64
>  cpu_pm_exit+0x20/0x2c
>  psci_enter_idle_state+0x48/0x70
>  cpuidle_enter_state+0xb8/0x260
>  cpuidle_enter+0x44/0x5c
>  do_idle+0x188/0x30c
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> Changes in v11:
> - Updated commit message as per Stephen.
>
> Changes in v9:
> - Added to commit message that this doesn't catch all cases.
>
> Changes in v8:
> - "Tag the arm64 idle functions as __cpuidle" new for v8
>
>  arch/arm64/kernel/idle.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/idle.c b/arch/arm64/kernel/idle.c
> index c1125753fe9b..05cfb347ec26 100644
> --- a/arch/arm64/kernel/idle.c
> +++ b/arch/arm64/kernel/idle.c
> @@ -20,7 +20,7 @@
>   *     ensure that interrupts are not masked at the PMR (because the core will
>   *     not wake up if we block the wake up signal in the interrupt controller).
>   */
> -void noinstr cpu_do_idle(void)
> +void __cpuidle cpu_do_idle(void)
>  {
>         struct arm_cpuidle_irq_context context;
>
> @@ -35,7 +35,7 @@ void noinstr cpu_do_idle(void)
>  /*
>   * This is our default idle handler.
>   */
> -void noinstr arch_cpu_idle(void)
> +void __cpuidle arch_cpu_idle(void)
>  {
>         /*
>          * This should do all the clock switching and wait for interrupt
> --
> 2.42.0.rc1.204.g551eb34607-goog
>
