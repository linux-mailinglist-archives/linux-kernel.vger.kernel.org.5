Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E397D4A5E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjJXIg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbjJXIgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:36:12 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EDF1706;
        Tue, 24 Oct 2023 01:36:09 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9be1ee3dc86so603233866b.1;
        Tue, 24 Oct 2023 01:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698136567; x=1698741367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOL8OCLqjFGqywLwDSWAmh+dAQIlEiXw7hC0l8+jRxo=;
        b=JOUk6tPJAEn/j07VqQxgRMH/FWm6l/WKdEpsfobgOO3+cpk6keAhA9C3P388tUmUl6
         BiqbWpUVHKU/siLx3Y/cFeZgOA5EyJ27GqeXvE+iKIrDyizVr5I3UtGXQEbAFdDZqZkZ
         1SS67B9qnyL+Fv8njR6nmmQ22EGDnhudtTqntyBh6235I1f86choi5jb69ITZcI6HeiT
         BpDGQtLH5A4zIPXEIgbfoG73CK+aHIVuZZN+MePteS8pNYGSfyPUp1gDw0nRRMBp09dA
         KTmTJbrSYlGlKJTzY9JjBEH3faY+CHoIFgpRe+jM8yjbhf1bd91w8luUjrhsKOTJerd8
         l6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698136567; x=1698741367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOL8OCLqjFGqywLwDSWAmh+dAQIlEiXw7hC0l8+jRxo=;
        b=Mgj9hRyhivh/FJG/TAdovuY+wMawns72URmntXhEuqbspwshXJvAg4celWjZLnK2cd
         o7xKSQpobfZ2IR48s7TtpOnKq5fOyRMWVB3d/a2LzrtsK+GIyt+NFKqRB5pAiNE3P4sO
         +raAQ4XjZgMkBuueYsQJtOFm5NwzJoPZHEr5Jn1BNs904PtBoAmpd7lWLkhrx14/khcK
         u43zC9ZXFZG+RJHSRmZPiPC1ryq3ZOmJEQiIDFm9y+ZXRQhlBYlyHiVdKBHytHJ1cyW8
         WAmxM3KNK+imBz15TUyDdjkJz1U0I0+kTUsMl/lXPCe+vuljjHOyYLuI67KhPeETWPGa
         9YCg==
X-Gm-Message-State: AOJu0YxJHoD9eBzUCVWqUT2Zlr80fSLJxiunWHXmJ1BX3XhvCrUEinav
        /4ZX4UFTnhbCh88NFAb34JE=
X-Google-Smtp-Source: AGHT+IE/+goi/QlzSPGPwR+JAiu6ej3sLV3ACqYSpeOyeVBjBfuuH3B887h/XwfSfKD/8SsfgKyMuw==
X-Received: by 2002:a17:907:1ca4:b0:9bf:5696:9155 with SMTP id nb36-20020a1709071ca400b009bf56969155mr9120278ejc.8.1698136567548;
        Tue, 24 Oct 2023 01:36:07 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id n13-20020a17090673cd00b009b65a834dd6sm7950738ejl.215.2023.10.24.01.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 01:36:07 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 24 Oct 2023 10:36:04 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org,
        pavel@ucw.cz, linux-perf-users@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/2] x86: Enable x2apic during resume from suspend if
 used previously
Message-ID: <ZTeB9K4NYu1sRiZ1@gmail.com>
References: <20231023160018.164054-1-mario.limonciello@amd.com>
 <20231023160018.164054-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023160018.164054-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mario Limonciello <mario.limonciello@amd.com> wrote:

> If x2apic was enabled during boot with parallel startup
> it will be needed during resume from suspend to ram as well.
> 
> Store whether to enable into the smpboot_control global variable
> and during startup re-enable it if necessary.
> 
> Cc: stable@vger.kernel.org # 6.5+
> Fixes: 0c7ffa32dbd6 ("x86/smpboot/64: Implement arch_cpuhp_init_parallel_bringup() and enable it")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/include/asm/smp.h   |  1 +
>  arch/x86/kernel/acpi/sleep.c | 12 ++++++++----
>  arch/x86/kernel/head_64.S    | 15 +++++++++++++++
>  3 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index c31c633419fe..86584ffaebc3 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -190,6 +190,7 @@ extern unsigned long apic_mmio_base;
>  #endif /* !__ASSEMBLY__ */
>  
>  /* Control bits for startup_64 */
> +#define STARTUP_ENABLE_X2APIC	0x40000000
>  #define STARTUP_READ_APICID	0x80000000
>  
>  /* Top 8 bits are reserved for control */
> diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
> index 6dfecb27b846..29734a1299f6 100644
> --- a/arch/x86/kernel/acpi/sleep.c
> +++ b/arch/x86/kernel/acpi/sleep.c
> @@ -11,6 +11,7 @@
>  #include <linux/dmi.h>
>  #include <linux/cpumask.h>
>  #include <linux/pgtable.h>
> +#include <asm/apic.h>
>  #include <asm/segment.h>
>  #include <asm/desc.h>
>  #include <asm/cacheflush.h>
> @@ -129,11 +130,14 @@ int x86_acpi_suspend_lowlevel(void)
>  	 */
>  	current->thread.sp = (unsigned long)temp_stack + sizeof(temp_stack);
>  	/*
> -	 * Ensure the CPU knows which one it is when it comes back, if
> -	 * it isn't in parallel mode and expected to work that out for
> -	 * itself.
> +	 * Ensure x2apic is re-enabled if necessary and the CPU knows which
> +	 * one it is when it comes back, if it isn't in parallel mode and
> +	 * expected to work that out for itself.
>  	 */
> -	if (!(smpboot_control & STARTUP_PARALLEL_MASK))
> +	if (smpboot_control & STARTUP_PARALLEL_MASK) {
> +		if (x2apic_enabled())
> +			smpboot_control |= STARTUP_ENABLE_X2APIC;
> +	} else
>  		smpboot_control = smp_processor_id();

Yeah, so instead of adding further kludges to the 'parallel bringup is 
possible' code path, which is arguably a functional feature that shouldn't 
have hardware-management coupled to it, would it be possible to fix 
parallel bringup to AMD-SEV systems, so that this code path isn't a 
quirk-dependent "parallel boot" codepath, but simply the "x86 SMP boot 
codepath", where all SMP x86 systems do a parallel bootup?

The original commit by Thomas says:

  0c7ffa32dbd6 ("x86/smpboot/64: Implement arch_cpuhp_init_parallel_bringup() and enable it")

  | Unfortunately there is no RDMSR GHCB protocol at the moment, so enabling 
  | AMD-SEV guests for parallel startup needs some more thought.

But that was half a year ago, isn't there RDMSR GHCB access code available now?

This code would all read a lot more natural if it was the regular x86 SMP 
bootup path - which it is 'almost' today already, modulo quirk.

Obviously coupling functional features with hardware quirks is fragile, for 
example your patch extending x86 SMP parallel bringup doesn't extend the 
AMD-SEV case, which may or may not matter in practice.

So, if it's possible, it would be nice to fix AMD-SEV systems as well and 
remove this artificial coupling.

Also, side note #1: curly braces should be balanced.

>  #endif
>  	initial_code = (unsigned long)wakeup_long64;
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index ea6995920b7a..fcfa79105928 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -236,10 +236,15 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>  	 * used to look up the CPU number.  For booting a single CPU, the
>  	 * CPU number is encoded in smpboot_control.
>  	 *
> +	 * Bit 30	STARTUP_ENABLE_X2APIC (Enable X2APIC mode)
>  	 * Bit 31	STARTUP_READ_APICID (Read APICID from APIC)
>  	 * Bit 0-23	CPU# if STARTUP_xx flags are not set

Side note #2: you mixed up the comment ordering here.

Thanks,

	Ingo
