Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6DE8127CB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443191AbjLNGN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 01:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjLNGN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:13:57 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CEB107
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 22:14:02 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3ba2dd905f9so566313b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 22:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702534442; x=1703139242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3sMkRAMQECWLiukPZgPf+GGB55ddSK20MJ/gjXWD1s=;
        b=OyVCbntoESf3PuDmZz/t5WlC3rcPv1BiSso5hvDiLnGK7Dbjzx8dQPW3Wo73nxo+vS
         C5q28PKjbo8c4K1GE6Hjy7INqx6QAl1Ij4isbGgSsXYYJzSBf15H64MevWcYseE777ui
         HlZUlv/JsRTXIW7bCQXcJ7HWjKoMFajXiMyN+O609x6yqm6lRYJuOlBZ7ynKObBAAlJX
         mtazflA1hk/0P5Xuji/tZAbuRU7JR46A9d+HhmEaKrRkRMN4L8aZKCe2tCQcpMR5MO5M
         nv4aEDLXL7rsAyuxf3TG8EF0lhDSE9sPH+oVvZcj47YBzD+wa4XMq9ssrflavBuMDDWm
         aKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702534442; x=1703139242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3sMkRAMQECWLiukPZgPf+GGB55ddSK20MJ/gjXWD1s=;
        b=nnKvGjMAaXbcGTZh+rJ3DtZc4tnqI1LHqbiCtVeoMN7bhdZeJL+9KrgBQ76VvNI0tF
         KVMQS43fqynOKxSvGLMOuDDJbgL28fTOWhRPDsbPkOJdDEqzw4S6pP57NYdIsa0FdSKM
         kwm/eFrLeXBOzoawLzXH6GfM3S1HD63snrvwsOaySRSDeq+70Fw4dIKdBbxY50AS6aca
         exsI8141hSLq6kt9/bnxv0YgZLxyGT2N55ZrBjBbllNZ03fktELoIxxfbi7GJkDDXMvS
         AIYRRSXgEIvn0K4YEGRwI9sDv4Bh8RUrnHUqMmTGcTDb7AzNJvhJT7jsjTN3UqmWG6hA
         9wGQ==
X-Gm-Message-State: AOJu0Yw5B3XwhLT8ZS1NW/yisR2cAjyU4zamqZhutKWWSVVo5rcNA2z0
        E21gD6nC7eDg30xZyqfi0Z30DY85Afzn4kt3y5p2zg==
X-Google-Smtp-Source: AGHT+IHQd+GqK3y5tlwO2tTpsax7aS81PVJh1PsMGIYAkqaLtpj/3C4S2vBn648Rccq1W4+OEQ+fJWJGTJEaydQwxew=
X-Received: by 2002:a05:6808:2e85:b0:3ba:8d5:4009 with SMTP id
 gt5-20020a0568082e8500b003ba08d54009mr11288098oib.110.1702534442120; Wed, 13
 Dec 2023 22:14:02 -0800 (PST)
MIME-Version: 1.0
References: <20230916003118.2540661-1-seanjc@google.com> <20230916003118.2540661-23-seanjc@google.com>
In-Reply-To: <20230916003118.2540661-23-seanjc@google.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 14 Dec 2023 11:43:50 +0530
Message-ID: <CAAhSdy2N8PmP2+-8sFVpgduED0HU9D3dqg7sk3+R9f2wRgZ7KA@mail.gmail.com>
Subject: Re: [PATCH 22/26] entry/kvm: KVM: Move KVM details related to
 signal/-EINTR into KVM proper
To:     Sean Christopherson <seanjc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Anish Ghulati <aghulati@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>,
        Andrew Thornton <andrewth@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2023 at 6:02=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Move KVM's morphing of pending signals into exits to userspace into KVM
> proper, and drop the @vcpu param from xfer_to_guest_mode_handle_work().
> How KVM responds to -EINTR is a detail that really belongs in KVM itself,
> and removing the non-KVM call to kvm_handle_signal_exit() will allow
> hiding said API and the definition of "struct kvm_vcpu" from the kernel.
>
> Alternatively, entry/kvm.c could be treated as part of KVM, i.e. be given
> access to KVM internals, but that's not obviously better than having KVM
> react to -EINTR (though it's not obviously worse either).
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

For KVM RISC-V:
Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/arm64/kvm/arm.c      |  3 +--
>  arch/riscv/kvm/vcpu.c     |  2 +-
>  arch/x86/kvm/vmx/vmx.c    |  1 -
>  arch/x86/kvm/x86.c        |  3 +--
>  include/linux/entry-kvm.h |  3 +--
>  include/linux/kvm_host.h  | 13 ++++++++++++-
>  kernel/entry/kvm.c        | 11 ++++-------
>  7 files changed, 20 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 6480628197b4..641df091e46b 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -6,7 +6,6 @@
>
>  #include <linux/bug.h>
>  #include <linux/cpu_pm.h>
> -#include <linux/entry-kvm.h>
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/kvm_host.h>
> @@ -929,7 +928,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>                 /*
>                  * Check conditions before entering the guest
>                  */
> -               ret =3D xfer_to_guest_mode_handle_work(vcpu);
> +               ret =3D kvm_xfer_to_guest_mode_handle_work(vcpu);
>                 if (!ret)
>                         ret =3D 1;
>
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 82229db1ce73..c313f4e90e70 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -667,7 +667,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>         run->exit_reason =3D KVM_EXIT_UNKNOWN;
>         while (ret > 0) {
>                 /* Check conditions before entering the guest */
> -               ret =3D xfer_to_guest_mode_handle_work(vcpu);
> +               ret =3D kvm_xfer_to_guest_mode_handle_work(vcpu);
>                 if (ret)
>                         continue;
>                 ret =3D 1;
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index faf0071566ef..43b87ad5fde8 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -28,7 +28,6 @@
>  #include <linux/slab.h>
>  #include <linux/tboot.h>
>  #include <linux/trace_events.h>
> -#include <linux/entry-kvm.h>
>
>  #include <asm/apic.h>
>  #include <asm/asm.h>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 6c9c81e82e65..aab095f89d9e 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -59,7 +59,6 @@
>  #include <linux/sched/stat.h>
>  #include <linux/sched/isolation.h>
>  #include <linux/mem_encrypt.h>
> -#include <linux/entry-kvm.h>
>  #include <linux/suspend.h>
>  #include <linux/smp.h>
>
> @@ -10987,7 +10986,7 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
>
>                 if (__xfer_to_guest_mode_work_pending()) {
>                         kvm_vcpu_srcu_read_unlock(vcpu);
> -                       r =3D xfer_to_guest_mode_handle_work(vcpu);
> +                       r =3D kvm_xfer_to_guest_mode_handle_work(vcpu);
>                         kvm_vcpu_srcu_read_lock(vcpu);
>                         if (r)
>                                 return r;
> diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
> index e7d90d06e566..e235a91d28fc 100644
> --- a/include/linux/entry-kvm.h
> +++ b/include/linux/entry-kvm.h
> @@ -42,11 +42,10 @@ static inline int arch_xfer_to_guest_mode_handle_work=
(unsigned long ti_work)
>  /**
>   * xfer_to_guest_mode_handle_work - Check and handle pending work which =
needs
>   *                                 to be handled before going to guest m=
ode
> - * @vcpu:      Pointer to current's VCPU data
>   *
>   * Returns: 0 or an error code
>   */
> -int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu);
> +int xfer_to_guest_mode_handle_work(void);
>
>  /**
>   * xfer_to_guest_mode_prepare - Perform last minute preparation work tha=
t
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index fb6c6109fdca..d520d6801070 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2,7 +2,7 @@
>  #ifndef __KVM_HOST_H
>  #define __KVM_HOST_H
>
> -
> +#include <linux/entry-kvm.h>
>  #include <linux/types.h>
>  #include <linux/hardirq.h>
>  #include <linux/list.h>
> @@ -2293,6 +2293,17 @@ static inline void kvm_handle_signal_exit(struct k=
vm_vcpu *vcpu)
>         vcpu->run->exit_reason =3D KVM_EXIT_INTR;
>         vcpu->stat.signal_exits++;
>  }
> +
> +static inline int kvm_xfer_to_guest_mode_handle_work(struct kvm_vcpu *vc=
pu)
> +{
> +       int r =3D xfer_to_guest_mode_handle_work();
> +
> +       if (r) {
> +               WARN_ON_ONCE(r !=3D -EINTR);
> +               kvm_handle_signal_exit(vcpu);
> +       }
> +       return r;
> +}
>  #endif /* CONFIG_KVM_XFER_TO_GUEST_WORK */
>
>  /*
> diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
> index c2fc39824157..872617468b4a 100644
> --- a/kernel/entry/kvm.c
> +++ b/kernel/entry/kvm.c
> @@ -1,17 +1,14 @@
>  // SPDX-License-Identifier: GPL-2.0
>
>  #include <linux/entry-kvm.h>
> -#include <linux/kvm_host.h>
>
> -static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long =
ti_work)
> +static int xfer_to_guest_mode_work(unsigned long ti_work)
>  {
>         do {
>                 int ret;
>
> -               if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL)) {
> -                       kvm_handle_signal_exit(vcpu);
> +               if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
>                         return -EINTR;
> -               }
>
>                 if (ti_work & _TIF_NEED_RESCHED)
>                         schedule();
> @@ -28,7 +25,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcp=
u, unsigned long ti_work)
>         return 0;
>  }
>
> -int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu)
> +int xfer_to_guest_mode_handle_work(void)
>  {
>         unsigned long ti_work;
>
> @@ -44,6 +41,6 @@ int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcp=
u)
>         if (!(ti_work & XFER_TO_GUEST_MODE_WORK))
>                 return 0;
>
> -       return xfer_to_guest_mode_work(vcpu, ti_work);
> +       return xfer_to_guest_mode_work(ti_work);
>  }
>  EXPORT_SYMBOL_GPL(xfer_to_guest_mode_handle_work);
> --
> 2.42.0.459.ge4e396fd5e-goog
>
