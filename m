Return-Path: <linux-kernel+bounces-41298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C9183EE85
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D6A1F23E22
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86AA605B2;
	Sat, 27 Jan 2024 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="XEAIN9Xc"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADD5605AB
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372432; cv=none; b=NA7Od3kZcC3Mcu5uVqXRMpsjcKD4UvEYuXI66pmOAoUDOGqSrj8zwVCOVXmgL3ZH4oibE2/zeHFXQ5ZLeMLbZOhcM+Phh2g4vcZq8rVBgPLa96Re30UJknF1p6dsc95ipPqHzM0H64ge5f6tnzwqvQUIRbw55acDTd1x+27nVJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372432; c=relaxed/simple;
	bh=qrbJ651XdJENdBe3aEpsMlLqPeGFNjAOY16+iFWQTOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khqXmoEjkJ3ssxxDcY7wZKog9qR0+ZCjpZ8dsPlwxHElTFjhpmpC0xlwC+tqy+HEQY2vCof0AzqIfBss2ySkeOgaiDzJIUWc6IthzbJU1Rz+QfLHMtCJxLy87LXvmX4I67tePtp4C9cPle6vvAwnEGHFXD1UliRDk33vNUPt4A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=XEAIN9Xc; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cfad2c62daso1412631fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 08:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1706372428; x=1706977228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cs22FUCSh/QKVUEnHbkZdHK+B7Cwzv+8TU0ghWB1nTI=;
        b=XEAIN9Xc8x48JgFPVHHEeb2q/v+IAGTGeX69Re0fM4/td5SQG/2lAVYelUpdixB2Ce
         npU5IX00ik6cYQ9SX3AqtZjzlmCv6i2ZFUCqrUT/B5oj/4EhIH6gKcU3Jf07sfAH36jb
         ZLa9g+7R169tHkQ8ad3UpPrvAuDBDd6SHyAGPPIgKLSmDHwbGsEZHYeQSJHHfmPs7tX4
         b/hXvtKlOMj9xuxifY/2GY1dhh3/0drdFS+sX0qnxVkQmX0fjVgDbJ2KUaOHF2Hng39r
         n2B88iWS+z8duKM2Wd+WyZDz2mzXfCPF4cPnWpgemvG6Ax6jIw4T0Az+Ip3xFMmgiNlx
         wFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706372428; x=1706977228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cs22FUCSh/QKVUEnHbkZdHK+B7Cwzv+8TU0ghWB1nTI=;
        b=oJhEg8pOyVI2/IPqG54Ho8Df+k4suLURS/pD1EAwTVxoJm3N8HnsRjC6i8/sjVmQuf
         8Fac0Hl8ZDZ2hTgM9H4cnJbHwuuYKoUhj8GdeSBk0QkszKRtwCmhjA18cQdEvAgmC7jn
         YF2Mn6Dpd5mtl+yr7EuiyoMVBrkPKFXRb2O61hL3G8rqF6WtIcW9FLlQ6KQhrFSbJS3v
         8gmm1IjqbBhVvNjmhl759/4IW4cfSVtJGzBqCqJaSFS5nlxIBwuJG9KE04X3tfZXYGsy
         D2sZXEPZXgiiOzPaf37J0cwCwDzPYr1wLw1Dp1uVc47IlaYBP+EV2fd691YyX1wCIoGu
         Dwjw==
X-Gm-Message-State: AOJu0YwFKC/Vm7l4f+pLMUqO+zRnxuyq0JxyoEGonzsx7wrkfyHu0kKF
	DfNv0CFvkybXv3/85IOGz0El7LJ8L7OOnVAEqEqTthUAywzTIx2+0ZPRDpGeMgay9CEE3omZL4K
	l9bVgUVLmibRsaX5fGffVvvZLFjCQCnUHLdkK7g==
X-Google-Smtp-Source: AGHT+IGF6Sch5alDMQDKFPphLYwHjJnDfls8OumK/Oo1CumL91mn384i/BuE4WD1qUPncRKGuTcHHFFkt/3bd4Ldd/o=
X-Received: by 2002:a19:750f:0:b0:50e:fe09:6597 with SMTP id
 y15-20020a19750f000000b0050efe096597mr1061774lfe.69.1706372428170; Sat, 27
 Jan 2024 08:20:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127161753.114685-1-apatel@ventanamicro.com>
In-Reply-To: <20240127161753.114685-1-apatel@ventanamicro.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Sat, 27 Jan 2024 21:50:15 +0530
Message-ID: <CAK9=C2Vwtj2gZg-P73yLMxu0rPXQ3YrRRuxq6HcpHMXgs-jHaw@mail.gmail.com>
Subject: Re: [PATCH v12 00/25] Linux RISC-V AIA Support
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Marc Zyngier <maz@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Atish Patra <atishp@atishpatra.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Saravana Kannan <saravanak@google.com>, Anup Patel <anup@brainfault.org>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Sat, Jan 27, 2024 at 9:48=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> The RISC-V AIA specification is ratified as-per the RISC-V international
> process. The latest ratified AIA specifcation can be found at:
> https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-interrupts=
-1.0.pdf
>
> At a high-level, the AIA specification adds three things:
> 1) AIA CSRs
>    - Improved local interrupt support
> 2) Incoming Message Signaled Interrupt Controller (IMSIC)
>    - Per-HART MSI controller
>    - Support MSI virtualization
>    - Support IPI along with virtualization
> 3) Advanced Platform-Level Interrupt Controller (APLIC)
>    - Wired interrupt controller
>    - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI generator)
>    - In Direct-mode, injects external interrupts directly into HARTs
>
> For an overview of the AIA specification, refer the AIA virtualization
> talk at KVM Forum 2022:
> https://static.sched.com/hosted_files/kvmforum2022/a1/AIA_Virtualization_=
in_KVM_RISCV_final.pdf
> https://www.youtube.com/watch?v=3Dr071dL8Z0yo
>
> To test this series, use QEMU v7.2 (or higher) and OpenSBI v1.2 (or highe=
r).
>
> These patches can also be found in the riscv_aia_v12 branch at:
> https://github.com/avpatel/linux.git
>
> Changes since v11:
>  - Rebased on Linux-6.8-rc1
>  - Included kernel/irq related patches from "genirq, irqchip: Convert ARM
>    MSI handling to per device MSI domains" series by Thomas.
>    (PATCH7, PATCH8, PATCH9, PATCH14, PATCH16, PATCH17, PATCH18, PATCH19,
>     PATCH20, PATCH21, PATCH22, PATCH23, and PATCH32 of
>     https://lore.kernel.org/linux-arm-kernel/20221121135653.208611233@lin=
utronix.de/)
>  - Updated APLIC MSI-mode driver to use the new WIRED_TO_MSI mechanism.
>  - Updated IMSIC driver to support per-device MSI domains for PCI and
>    platform devices.
>
> Changes since v10:
>  - Rebased on Linux-6.6-rc7
>  - Dropped PATCH3 of v10 series since this has been merged by MarcZ
>    for Linux-6.6-rc7
>  - Changed the IMSIC ID management strategy from 1-n approach to
>    x86-style 1-1 approach
>
> Changes since v9:
>  - Rebased on Linux-6.6-rc4
>  - Use builtin_platform_driver() in PATCH5, PATCH9, and PATCH12
>
> Changes since v8:
>  - Rebased on Linux-6.6-rc3
>  - Dropped PATCH2 of v8 series since we won't be requiring
>    riscv_get_intc_hartid() based on Marc Z's comments on ACPI AIA support=
.
>  - Addressed Saravana's comments in PATCH3 of v8 series
>  - Update PATCH9 and PATCH13 of v8 series based on comments from Sunil
>
> Changes since v7:
>  - Rebased on Linux-6.6-rc1
>  - Addressed comments on PATCH1 of v7 series and split it into two PATCHe=
s
>  - Use DEFINE_SIMPLE_PROP() in PATCH2 of v7 series
>
> Changes since v6:
>  - Rebased on Linux-6.5-rc4
>  - Updated PATCH2 to use IS_ENABLED(CONFIG_SPARC) instead of
>    !IS_ENABLED(CONFIG_OF_IRQ)
>  - Added new PATCH4 to fix syscore registration in PLIC driver
>  - Update PATCH5 to convert PLIC driver into full-blown platform driver
>    with a re-written probe function.
>
> Changes since v5:
>  - Rebased on Linux-6.5-rc2
>  - Updated the overall series to ensure that only IPI, timer, and
>    INTC drivers are probed very early whereas rest of the interrupt
>    controllers (such as PLIC, APLIC, and IMISC) are probed as
>    regular platform drivers.
>  - Renamed riscv_fw_parent_hartid() to riscv_get_intc_hartid()
>  - New PATCH1 to add fw_devlink support for msi-parent DT property
>  - New PATCH2 to ensure all INTC suppliers are initialized which in-turn
>    fixes the probing issue for PLIC, APLIC and IMSIC as platform driver
>  - New PATCH3 to use platform driver probing for PLIC
>  - Re-structured the IMSIC driver into two separate drivers: early and
>    platform. The IMSIC early driver (PATCH7) only initialized IMSIC state
>    and provides IPIs whereas the IMSIC platform driver (PATCH8) is probed
>    provides MSI domain for platform devices.
>  - Re-structure the APLIC platform driver into three separe sources: main=
,
>    direct mode, and MSI mode.
>
> Changes since v4:
>  - Rebased on Linux-6.5-rc1
>  - Added "Dependencies" in the APLIC bindings (PATCH6 in v4)
>  - Dropped the PATCH6 which was changing the IOMMU DMA domain APIs
>  - Dropped use of IOMMU DMA APIs in the IMSIC driver (PATCH4)
>
> Changes since v3:
>  - Rebased on Linux-6.4-rc6
>  - Droped PATCH2 of v3 series instead we now set FWNODE_FLAG_BEST_EFFORT =
via
>    IRQCHIP_DECLARE()
>  - Extend riscv_fw_parent_hartid() to support both DT and ACPI in PATCH1
>  - Extend iommu_dma_compose_msi_msg() instead of adding iommu_dma_select_=
msi()
>    in PATCH6
>  - Addressed Conor's comments in PATCH3
>  - Addressed Conor's and Rob's comments in PATCH7
>
> Changes since v2:
>  - Rebased on Linux-6.4-rc1
>  - Addressed Rob's comments on DT bindings patches 4 and 8.
>  - Addessed Marc's comments on IMSIC driver PATCH5
>  - Replaced use of OF apis in APLIC and IMSIC drivers with FWNODE apis
>    this makes both drivers easily portable for ACPI support. This also
>    removes unnecessary indirection from the APLIC and IMSIC drivers.
>  - PATCH1 is a new patch for portability with ACPI support
>  - PATCH2 is a new patch to fix probing in APLIC drivers for APLIC-only s=
ystems.
>  - PATCH7 is a new patch which addresses the IOMMU DMA domain issues poin=
ted
>    out by SiFive
>
> Changes since v1:
>  - Rebased on Linux-6.2-rc2
>  - Addressed comments on IMSIC DT bindings for PATCH4
>  - Use raw_spin_lock_irqsave() on ids_lock for PATCH5
>  - Improved MMIO alignment checks in PATCH5 to allow MMIO regions
>    with holes.
>  - Addressed comments on APLIC DT bindings for PATCH6
>  - Fixed warning splat in aplic_msi_write_msg() caused by
>    zeroed MSI message in PATCH7
>  - Dropped DT property riscv,slow-ipi instead will have module
>    parameter in future.
>
> Anup Patel (11):
>   irqchip/sifive-plic: Convert PLIC driver into a platform driver
>   irqchip/riscv-intc: Add support for RISC-V AIA
>   dt-bindings: interrupt-controller: Add RISC-V incoming MSI controller
>   irqchip: Add RISC-V incoming MSI controller early driver
>   irqchip/riscv-imsic: Add device MSI domain support for platform
>     devices
>   irqchip/riscv-imsic: Add device MSI domain support for PCI devices
>   dt-bindings: interrupt-controller: Add RISC-V advanced PLIC
>   irqchip: Add RISC-V advanced PLIC driver for direct-mode
>   irqchip/riscv-aplic: Add support for MSI-mode
>   RISC-V: Select APLIC and IMSIC drivers
>   MAINTAINERS: Add entry for RISC-V AIA drivers
>
> Bj=C3=B6rn T=C3=B6pel (1):
>   genirq/matrix: Dynamic bitmap allocation
>
> Thomas Gleixner (13):
>   irqchip/gic-v3: Make gic_irq_domain_select() robust for zero parameter
>     count
>   genirq/irqdomain: Remove the param count restriction from select()
>   genirq/msi: Extend msi_parent_ops
>   genirq/irqdomain: Add DOMAIN_BUS_DEVICE_IMS
>   platform-msi: Prepare for real per device domains
>   irqchip: Convert all platform MSI users to the new API
>   genirq/msi: Provide optional translation op
>   genirq/msi: Split msi_domain_alloc_irq_at()
>   genirq/msi: Provide DOMAIN_BUS_WIRED_TO_MSI
>   genirq/msi: Optionally use dev->fwnode for device domain
>   genirq/msi: Provide allocation/free functions for "wired" MSI
>     interrupts
>   genirq/irqdomain: Reroute device MSI create_mapping
>   genirq/msi: Provide MSI_FLAG_PARENT_PM_DEV

I have rebased and included 13 patches (which add per-device MSI domain
infrastructure) from your series [1]. In this series, the IMSIC driver
implements the msi_parent_ops and APLIC driver implements wired-to-msi
bridge using your new infrastructure.

The remaining 27 patches of your series [1] requires testing on ARM
platforms which I don't have. I suggest these remaining patches to
go as separate series.

I hope you are okay with this approach.

Best Regards,
Anup

[1] https://lore.kernel.org/linux-arm-kernel/20221121135653.208611233@linut=
ronix.de/


>
>  .../interrupt-controller/riscv,aplic.yaml     | 172 ++++
>  .../interrupt-controller/riscv,imsics.yaml    | 172 ++++
>  MAINTAINERS                                   |  14 +
>  arch/riscv/Kconfig                            |   2 +
>  arch/x86/include/asm/hw_irq.h                 |   2 -
>  drivers/base/platform-msi.c                   |  97 ++
>  drivers/dma/mv_xor_v2.c                       |   8 +-
>  drivers/dma/qcom/hidma.c                      |   6 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   5 +-
>  drivers/irqchip/Kconfig                       |  25 +
>  drivers/irqchip/Makefile                      |   3 +
>  drivers/irqchip/irq-gic-v3.c                  |   6 +-
>  drivers/irqchip/irq-riscv-aplic-direct.c      | 343 +++++++
>  drivers/irqchip/irq-riscv-aplic-main.c        | 232 +++++
>  drivers/irqchip/irq-riscv-aplic-main.h        |  53 ++
>  drivers/irqchip/irq-riscv-aplic-msi.c         | 256 +++++
>  drivers/irqchip/irq-riscv-imsic-early.c       | 241 +++++
>  drivers/irqchip/irq-riscv-imsic-platform.c    | 403 ++++++++
>  drivers/irqchip/irq-riscv-imsic-state.c       | 887 ++++++++++++++++++
>  drivers/irqchip/irq-riscv-imsic-state.h       | 105 +++
>  drivers/irqchip/irq-riscv-intc.c              |  34 +-
>  drivers/irqchip/irq-sifive-plic.c             | 239 +++--
>  drivers/mailbox/bcm-flexrm-mailbox.c          |   8 +-
>  drivers/perf/arm_smmuv3_pmu.c                 |   4 +-
>  drivers/ufs/host/ufs-qcom.c                   |   8 +-
>  include/linux/irqchip/riscv-aplic.h           | 119 +++
>  include/linux/irqchip/riscv-imsic.h           |  87 ++
>  include/linux/irqdomain.h                     |  17 +
>  include/linux/irqdomain_defs.h                |   2 +
>  include/linux/msi.h                           |  21 +
>  kernel/irq/irqdomain.c                        |  28 +-
>  kernel/irq/matrix.c                           |  28 +-
>  kernel/irq/msi.c                              | 184 +++-
>  33 files changed, 3636 insertions(+), 175 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controlle=
r/riscv,aplic.yaml
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controlle=
r/riscv,imsics.yaml
>  create mode 100644 drivers/irqchip/irq-riscv-aplic-direct.c
>  create mode 100644 drivers/irqchip/irq-riscv-aplic-main.c
>  create mode 100644 drivers/irqchip/irq-riscv-aplic-main.h
>  create mode 100644 drivers/irqchip/irq-riscv-aplic-msi.c
>  create mode 100644 drivers/irqchip/irq-riscv-imsic-early.c
>  create mode 100644 drivers/irqchip/irq-riscv-imsic-platform.c
>  create mode 100644 drivers/irqchip/irq-riscv-imsic-state.c
>  create mode 100644 drivers/irqchip/irq-riscv-imsic-state.h
>  create mode 100644 include/linux/irqchip/riscv-aplic.h
>  create mode 100644 include/linux/irqchip/riscv-imsic.h
>
> --
> 2.34.1
>

