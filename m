Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D368127CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443159AbjLNGOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 01:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbjLNGOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:14:41 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9BF1730
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 22:05:01 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cedc988cf6so3500945b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 22:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702533901; x=1703138701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvVjokEhJRkgiYQ+o9OaV0HA0xI9C7Xt69a6c2d+FcQ=;
        b=wlkm2bV4t3Xww/AbxwzNROFizoefh2kCfL1aFhPEZCnBwErS+aI/37qTiU2eESjObN
         UnUvaGpOG1gaBiCzAAwJ8wsykjb7agAdbtPuRIy9mdjwWC8GpRNUXuDR2i4KfqxjOK0i
         Bzno6jIim8o6C0ADmoCtL74ySuIEUmQ2z5s5b7uMqV3UXEW0H+72GnFgOFEBmRuY0s39
         KZ1PLeznneFm+EwNpZrp042KGH/RyHSSHHabK8LtjLMPoa1MtYLeHqdHVvlqxAT2y3Nb
         tRKml/9gY9BKT2AMjCrFmsFHAzi8KWHpNiHUNtjKakrLpjcie22db2ZolJTU+KzihLCn
         O/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702533901; x=1703138701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvVjokEhJRkgiYQ+o9OaV0HA0xI9C7Xt69a6c2d+FcQ=;
        b=MYPyPTfdhSQLJsahxy64T26gmEFJS7g1tDhnNoL8O7YkINyGU8/UHXy24JNZYAOnux
         VPIuUp2U0JIBTUX3iVgHB2wy7Ryhmr4kJo5ZYebx793wzbn7+76OlLb00wVtbtB0ptst
         kGw1REl9nIZf3wzBmSEMSfScW47hhwR4d9Cz5AefjwYNXgV77xoohIa5aCUIBEG6WWjq
         WV3fWCVSJ86JnE4s5ic9CbDbhBlJornyBte7VnfWP25DlaG9/TJJBzPTSTHwHKH0OSYs
         A4kl55GU6rKraIVmB2qQ6MDExbPLTs0Nj/CnoQth5lsOTgZr/dAe7yQ7xNIuOk7xIFGY
         GHGw==
X-Gm-Message-State: AOJu0YzVL3q9+Sr6FtVlQBlzdeRxCV52DIFAUtrD4A8UwKiOb8deJFfr
        OiBKUCYln0ehw3jZJGJ0upC8V2o4t1FZQ+rJXGHOaQ==
X-Google-Smtp-Source: AGHT+IHIasKoIhsfkj7Yu+FMUSkaxjPll3cuawBTpXD75vrutVj6NpINC37M3K8JiCCZ1y7ffegWrPb57ZwkbEZ9v2I=
X-Received: by 2002:a17:90a:e395:b0:286:bfed:6f55 with SMTP id
 b21-20020a17090ae39500b00286bfed6f55mr4390822pjz.38.1702533901140; Wed, 13
 Dec 2023 22:05:01 -0800 (PST)
MIME-Version: 1.0
References: <20230916003118.2540661-1-seanjc@google.com> <20230916003118.2540661-20-seanjc@google.com>
In-Reply-To: <20230916003118.2540661-20-seanjc@google.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 14 Dec 2023 11:34:49 +0530
Message-ID: <CAAhSdy1bzQ2mxOew0iw-OuLWxzOhk3LtO+908TYw2gw+5yN3RA@mail.gmail.com>
Subject: Re: [PATCH 19/26] KVM: Standardize include paths across all architectures
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2023 at 6:01=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Standardize KVM's include paths across all architectures by declaring
> the KVM-specific includes in the common Makefile.kvm.  Having common KVM
> "own" the included paths reduces the temptation to unnecessarily add
> virt/kvm to arch include paths, and conversely if allowing arch code to
> grab headers from virt/kvm becomes desirable, virt/kvm can be added to
> all architecture's include path with a single line update.
>
> Having the common KVM makefile append to ccflags also provides a
> convenient location to append other things, e.g. KVM-specific #defines.
>
> Note, this changes the behavior of s390 and PPC, as s390 and PPC
> previously overwrote ccflags-y instead of adding on.  There is no evidenc=
e
> that overwriting ccflags-y was necessary or even deliberate, as both s390
> and PPC switched to the overwrite behavior without so much as a passing
> mention when EXTRA_CFLAGS was replaced with ccflags-y (commit c73028a0288=
7
> ("s390: change to new flag variable") and commit 4108d9ba9091
> ("powerpc/Makefiles: Change to new flag variables")).
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

For KVM RISC-V:
Acked-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/arm64/kvm/Makefile   | 2 --
>  arch/mips/kvm/Makefile    | 2 --
>  arch/powerpc/kvm/Makefile | 2 --
>  arch/riscv/kvm/Makefile   | 2 --
>  arch/s390/kvm/Makefile    | 2 --
>  arch/x86/kvm/Makefile     | 1 -
>  virt/kvm/Makefile.kvm     | 2 ++
>  7 files changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> index c0c050e53157..3996489baeef 100644
> --- a/arch/arm64/kvm/Makefile
> +++ b/arch/arm64/kvm/Makefile
> @@ -3,8 +3,6 @@
>  # Makefile for Kernel-based Virtual Machine module
>  #
>
> -ccflags-y +=3D -I $(srctree)/$(src)
> -
>  include $(srctree)/virt/kvm/Makefile.kvm
>
>  obj-$(CONFIG_KVM) +=3D kvm.o
> diff --git a/arch/mips/kvm/Makefile b/arch/mips/kvm/Makefile
> index 96a7cd21b140..d198e1addea7 100644
> --- a/arch/mips/kvm/Makefile
> +++ b/arch/mips/kvm/Makefile
> @@ -4,8 +4,6 @@
>
>  include $(srctree)/virt/kvm/Makefile.kvm
>
> -ccflags-y +=3D -Iarch/mips/kvm
> -
>  kvm-$(CONFIG_CPU_HAS_MSA) +=3D msa.o
>
>  kvm-y +=3D    mips.o emulate.o entry.o \
> diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
> index 08a0e53d58c7..d6c6678ddf65 100644
> --- a/arch/powerpc/kvm/Makefile
> +++ b/arch/powerpc/kvm/Makefile
> @@ -3,8 +3,6 @@
>  # Makefile for Kernel-based Virtual Machine module
>  #
>
> -ccflags-y :=3D -Iarch/powerpc/kvm
> -
>  include $(srctree)/virt/kvm/Makefile.kvm
>
>  common-objs-y +=3D powerpc.o emulate_loadstore.o
> diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
> index 4c2067fc59fc..ff7d5f67e229 100644
> --- a/arch/riscv/kvm/Makefile
> +++ b/arch/riscv/kvm/Makefile
> @@ -3,8 +3,6 @@
>  # Makefile for RISC-V KVM support
>  #
>
> -ccflags-y +=3D -I $(srctree)/$(src)
> -
>  include $(srctree)/virt/kvm/Makefile.kvm
>
>  obj-$(CONFIG_KVM) +=3D kvm.o
> diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
> index f17249ab2a72..f8153189e003 100644
> --- a/arch/s390/kvm/Makefile
> +++ b/arch/s390/kvm/Makefile
> @@ -5,8 +5,6 @@
>
>  include $(srctree)/virt/kvm/Makefile.kvm
>
> -ccflags-y :=3D -Iarch/s390/kvm
> -
>  kvm-y +=3D kvm-s390.o intercept.o interrupt.o priv.o sigp.o
>  kvm-y +=3D diag.o gaccess.o guestdbg.o vsie.o pv.o
>
> diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
> index 80e3fe184d17..d13f1a7b7b3d 100644
> --- a/arch/x86/kvm/Makefile
> +++ b/arch/x86/kvm/Makefile
> @@ -1,6 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> -ccflags-y +=3D -I $(srctree)/arch/x86/kvm
>  ccflags-$(CONFIG_KVM_WERROR) +=3D -Werror
>
>  ifeq ($(CONFIG_FRAME_POINTER),y)
> diff --git a/virt/kvm/Makefile.kvm b/virt/kvm/Makefile.kvm
> index 29373b59d89a..e85079ad245d 100644
> --- a/virt/kvm/Makefile.kvm
> +++ b/virt/kvm/Makefile.kvm
> @@ -3,6 +3,8 @@
>  # Makefile for Kernel-based Virtual Machine module
>  #
>
> +ccflags-y +=3D -I$(srctree)/$(src)
> +
>  KVM ?=3D ../../../virt/kvm
>
>  kvm-y :=3D $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
> --
> 2.42.0.459.ge4e396fd5e-goog
>
