Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A727E72AA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344965AbjKIUN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjKIUN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:13:27 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C4544B6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:13:24 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so17609a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 12:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699560803; x=1700165603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocUzg3FTzeoLXOisKd+4x7BoT7kOaFCafsophQHiPRo=;
        b=gB9+gqf4zFKcks3982Hlt21j0xm+Sv3In9ZFDJhrbDRWNxf+dHrKoQu/rTf61Gcwsj
         RAYzeF/H4p7neoBnGw11w1ufeIPq7Qngc+EGrQsPRLsXScFe75rz85fH0Trfpkvxr76u
         /Cl1Evq1lu+lvcI+yEIVpBHxrXLa89a0DWoJlrqC45KMUva2WN9aBoUTmOo4xzpK6cYy
         ZKYa+ymTEmQhCgwNkPu+B5h72rb/NEVr0jFI8Qfob1ieGAncL7h7JV5dxa+xYkf9DyCn
         KMQ7n462oCPUWCCYrfpd1Z/So0s4u1j+Pzqvjxwh7EWWP/FyY6lusGGq9a0Wm/caW5bV
         96Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699560803; x=1700165603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocUzg3FTzeoLXOisKd+4x7BoT7kOaFCafsophQHiPRo=;
        b=HD8Yi9R2BblAwmF5+/sYvAHUVp/FUKMf/yJNJVmJQ9xDSA4VyxDSZyLrm4JyIQ5cny
         RdwYFR56uDTzRtvnana9GlUL2NRnukMwGD8ELhdDZ9Bywg1O9fy9EphNm0Kt7yDEmPFI
         FVLcl+XzZJDcrhmzRqIZA40s44LevLpRlF0wNaHQqwzS9Sy2crDVZQF7Q9QotpByl7kj
         oEEcSWEEZlC+vlOj0BhrFuaNFhULIHZpCMPVStSaKyvrNOkfcOE6cDIkTJKJ0jTNcBcV
         Rl0DlAod6pADYTMwKWOJt7KrBbNAOSK8zRa2YYAunhBYETpIbEUaM+i0rEpLq+S/8Jfx
         sdBg==
X-Gm-Message-State: AOJu0YzqhErdjF6T5y99kjEAwEoLnpZtHbCW7UMaEpunzXOxTWU/WcJv
        p8CIzQrst9xjIxwYE+udWG9sA09QLZpq+VlOHIFaeQ==
X-Google-Smtp-Source: AGHT+IFl3f7I4jfsKcQ/FZf0kEtsWD15V5uxxnAkbhemH9QBkuW16e1KUvDsXvbC5KcxaO60TUay/oB5kkJSbVpYeBA=
X-Received: by 2002:a05:6402:2b8a:b0:544:e2b8:ba6a with SMTP id
 fj10-20020a0564022b8a00b00544e2b8ba6amr662601edb.3.1699560802749; Thu, 09 Nov
 2023 12:13:22 -0800 (PST)
MIME-Version: 1.0
References: <20231109180646.2963718-1-khorenko@virtuozzo.com> <20231109180646.2963718-2-khorenko@virtuozzo.com>
In-Reply-To: <20231109180646.2963718-2-khorenko@virtuozzo.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 9 Nov 2023 12:13:08 -0800
Message-ID: <CALMp9eRpq+vYDD7s9t54ZMOK6WaXTY_trKzSE3R2vWP9PeSCOA@mail.gmail.com>
Subject: Re: [PATCH 1/1] KVM: x86/vPMU: Check PMU is enabled for vCPU before
 searching for PMC
To:     Konstantin Khorenko <khorenko@virtuozzo.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Denis V. Lunev" <den@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 10:24=E2=80=AFAM Konstantin Khorenko
<khorenko@virtuozzo.com> wrote:
>
> The following 2 mainstream patches have introduced extra
> events accounting:
>
>   018d70ffcfec ("KVM: x86: Update vPMCs when retiring branch instructions=
")
>   9cd803d496e7 ("KVM: x86: Update vPMCs when retiring instructions")
>
> kvm_pmu_trigger_event() iterates over all PMCs looking for enabled and
> this appeared to be fast on Intel CPUs and quite expensive for AMD CPUs.
>
> kvm_pmu_trigger_event() can be optimized not to iterate over all PMCs in
> the following cases:
>
>   * if PMU is completely disabled for a VM, which is the default
>     configuration
>   * if PMU v2 is enabled, but no PMCs are configured
>
> For Intel CPUs:
>   * By default PMU is disabled for KVM VMs (<pmu state=3D'off'/> or absen=
t
>     in the VM config xml which results in "-cpu pmu=3Doff" qemu option).
>     In this case pmu->version is reported as 0 for the appropriate vCPU.
>
>   * According to Intel=C2=AE 64 and IA-32 Architectures Software Develope=
r=E2=80=99s
>     Manual PMU version 2 and higher provide IA32_PERF_GLOBAL_CTRL MSR
>     which in particular contains bits which can be used for efficient
>     detection which fixed-function performance and general-purpose
>     performance monitoring counters are enabled at the moment.
>
>   * Searching for enabled PMCs is fast and the optimization does not
>     bring noticeable performance increase.
>
> For AMD CPUs:
>   * For CPUs older than Zen 4 pmu->version is always reported as "1" for
>     the appropriate vCPU, no matter if PMU is disabled for KVM VMs
>     (<pmu state=3D'off'/>) or enabled.
>     So for "old" CPUs currently it's impossible to detect when PMU is
>     disabled for a VM and skip the iteration by PMCs efficiently.
>
>   * Since Zen 4 AMD CPUs support PMU v2 and in this case pmu->version
>     should be reported as "2" and IA32_PERF_GLOBAL_CTRL MSR is available
>     and can be used for fast and efficient check for enabled PMCs.
>     https://www.phoronix.com/news/AMD-PerfMonV2-Linux-Patches
>     https://www.phoronix.com/news/AMD-PerfMonV2-Guests-KVM
>
>   * Optimized preliminary check for enabled PMCs on AMD Zen 4 CPUs
>     should give quite noticeable performance improvement.
>
> AMD performance results:
> CPU: AMD Zen 3 (three!): AMD EPYC 7443P 24-Core Processor
>
>  * The test binary is run inside an AlmaLinux 9 VM with their stock kerne=
l
>    5.14.0-284.11.1.el9_2.x86_64.
>  * Test binary checks the CPUID instractions rate (instructions per sec).
>  * Default VM config (PMU is off, pmu->version is reported as 1).
>  * The Host runs the kernel under test.
>
>  # for i in 1 2 3 4 5 ; do ./at_cpu_cpuid.pub ; done | \
>    awk -e '{print $4;}' | \
>    cut -f1 --delimiter=3D'.' | \
>    ./avg.sh
>
> Measurements:
> 1. Host runs stock latest mainstream kernel commit 305230142ae0.
> 2. Host runs same mainstream kernel + current patch.
> 3. Host runs same mainstream kernel + current patch + force
>    guest_pmu_is_enabled() to always return "false" using following change=
:
>
>    -       if (pmu->version >=3D 2 && !(pmu->global_ctrl & ~pmu->global_c=
trl_mask))
>    +       if (pmu->version =3D=3D 1 && !(pmu->global_ctrl & ~pmu->global=
_ctrl_mask))
>
>    --------------------------------------
>    | Kernels    | CPUID rate            |
>    --------------------------------------
>    | 1.         | 1360250               |
>    | 2.         | 1365536 (+ 0.4%)      |
>    | 3.         | 1541850 (+13.4%)      |
>    --------------------------------------
>
> Measurement (2) gives some fluctuation, the performance is not increased
> because the test was done on a Zen 3 CPU, so we are unable to use fast
> check for active PMCs.
> Measurement (3) shows expected performance boost on a Zen 4 CPU under
> the same test.
>
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> ---
>  arch/x86/kvm/pmu.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 9ae07db6f0f6..290d407f339b 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -731,12 +731,38 @@ static inline bool cpl_is_matched(struct kvm_pmc *p=
mc)
>         return (static_call(kvm_x86_get_cpl)(pmc->vcpu) =3D=3D 0) ? selec=
t_os : select_user;
>  }
>
> +static inline bool guest_pmu_is_enabled(struct kvm_pmu *pmu)
> +{
> +       /*
> +        * Currently VMs do not have PMU settings in configs which defaul=
ts
> +        * to "pmu=3Doff".
> +        *
> +        * For Intel currently this means pmu->version will be 0.
> +        * For AMD currently PMU cannot be disabled:

Isn't that what KVM_PMU_CAP_DISABLE is for?
