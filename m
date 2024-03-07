Return-Path: <linux-kernel+bounces-95706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A659287518B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B68428287E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C6112D778;
	Thu,  7 Mar 2024 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="W9bCRbrm"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DAB18C3B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820681; cv=none; b=VJ/i6WOPDORYkm1lzWJPbxl6MslZ7U2pcjTOvol8EfYE80L9uHx85XzIQKMk5nXhp0isoo8VUzwNTGDNx+GAH3AioyP5LOsE5VcCZ1kskJI6SkNDimm91k/eGL4G22v76kR0Dglp4RsMC4pMX425/4bsr1KAG7LOXBQF1dgp7cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820681; c=relaxed/simple;
	bh=EwRL5pOEZWNHCxA3KH0usb1mykGmqJximXKWJHHGjso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9m5dpqhcUPKR4zS3V4zjTovwK8U4hu/sNKszFwPtSXkGdPFQk2BGT540vkZthumiFTvL4NwS3zejoYBtCOXi4Zw2zNmyxgVaz7WxcQMmVS5c89zzitaLIa3DQV1AUrhewog9uEesrGHddNwMRMInU7Jw+NVNHH9Wqmuwypf6yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=W9bCRbrm; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512f892500cso823914e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 06:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709820677; x=1710425477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhcWnAMlg8jrkk+pdzCxo2d92lAXboE71zeWOHmwhag=;
        b=W9bCRbrmeEiZMnvqAkfNDxgtkQeRVkRD9KA0aiBdnYIrDeJCfKdJc0S8/DjMTTD3w2
         vfXVWIsZ6OCFOHxrB0+LZRm7HIysUbOD9Hf5XRparIiP74E/MgFs0wsxDx/UToQ9trU7
         pgF6DYOcLbZ+0e/38Nv3dUK1b+Mve7X409lTnpte225xcGiNR0a56638HW1xGWwkr/zJ
         y/NhvXUaMhxgjaLO1DQCbhrqsynpaKfWxYhfUAkAYUU2ZpWr52+dAjx8HDNkdHglpE1l
         yFOjqpSX2uY9JpCnR8iTre912DJQaNaUQpRGucJuHPpp3RAvXUvtGLhtAL88qKuUgXD4
         Cmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709820677; x=1710425477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhcWnAMlg8jrkk+pdzCxo2d92lAXboE71zeWOHmwhag=;
        b=eBj01VfkgbF9Iq+TEM4F5iXYKKlMq0rJ/SV75fL7NIKeKyA+1hXw1LPWrPJ9jaVWuR
         BsVdfrgZuUiIHJAPVmVdzBaw78SB51kpOO5c+2cRujBgtSrwnkBgFN2OEP5+nIMYIBS4
         m4FiHyezzVlhw3Z8z2RMFmKjMKtGm8OYo0kKjExXtlYjfNEWKQZR3GQrF4IWeUopxRtK
         ZkNZexCrtleNsDM35Ynt4Qeg190F98crQYJmpzXxAQ9YTOhGWINjqxCsKn7cY8goj1Vg
         hcSCfMxMPFuxatcKInLBGRFEjZ5VKJRL9Yg+h5mjGiyPO5mq+rMmNUTmb6Jg/TgrOSWO
         ULiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvhvwY70fax7+M5g34VUpy625ekE6a6RF/Xkb0ysTwyQkcJUtSDsBD/O3U3FMxmxA8RGXH4Dr0K2lXZ8DUXoDoFFBNIZWec357rWUA
X-Gm-Message-State: AOJu0YxCKDdUR0Q9Sdd65CNk6zTGu4J3Qpc4LxXYAkqWLn1L9xiYQ5nT
	cmtH0OzFc4My7bJvvg8YedqNb0Dx+fkpQBNuiFd7mF9LyAw0tH73ALNSfHJbJoaNS6Rgajd0kx0
	w3ehfU3aVrf22IaYxpMNEKTDDPxRndKOOctArHQ==
X-Google-Smtp-Source: AGHT+IFex0TdjH6D3Y9aFVqYCpKaXwZVb/GIduSp972xCsvkmr53vdSBFCrsEq8LkUZBR5USsruLB4LcHClg3WGtfjs=
X-Received: by 2002:a05:6512:234f:b0:512:eeac:2463 with SMTP id
 p15-20020a056512234f00b00512eeac2463mr1988019lfu.14.1709820676896; Thu, 07
 Mar 2024 06:11:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307140307.646078-1-apatel@ventanamicro.com>
In-Reply-To: <20240307140307.646078-1-apatel@ventanamicro.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 7 Mar 2024 19:41:05 +0530
Message-ID: <CAK9=C2UHbcnUoVvQFQzqCvHLngFsAi=4vaxaMM2+C1GoVxRa-w@mail.gmail.com>
Subject: Re: [PATCH v16 0/9] Linux RISC-V AIA Support
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Atish Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Rob Herring <robh+dt@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>, 
	Saravana Kannan <saravanak@google.com>, Anup Patel <anup@brainfault.org>, 
	linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, 
	Conor Dooley <conor+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Thu, Mar 7, 2024 at 7:33=E2=80=AFPM Anup Patel <apatel@ventanamicro.com>=
 wrote:
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
> This series depends upon per-device MSI domain (and few other) patches me=
rged
> by Thomas (tglx) which are available in irq/msi branch at:
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>
> These patches can also be found in the riscv_aia_v16 branch at:
> https://github.com/avpatel/linux.git
>
> Changes since v15:
>  - Dropped PATCH1 since it is already merged by Thomas (tglx) and availab=
le in
>    his irq/msi branch at git://git.kernel.org/pub/scm/linux/kernel/git/ti=
p/tip.git
>  - Simplified aplic_msi_irq_eoi() in PATCH7 based on the section "4.9.2 S=
pecial
>    consideration for level-sensitive interrupt sources"  of the RISC-V AI=
A
>    specification and also provided handler name.
>
> Changes since v14:
>  - Dropped 9 patches which are already merged by Thomas (tglx) and availa=
ble in
>    his irq/msi branch at git://git.kernel.org/pub/scm/linux/kernel/git/ti=
p/tip.git
>  - Added new PATCH1 which adds changes missed out in merging AIA support =
for
>    RISC-V INTC.
>  - Added a separate cpuhp state for IMSIC driver in PATCH3 which ensures =
that
>    cpuhp notifiers of IMSIC are called as early as possible.
>  - Removed redundant barriers in PATCH3.
>  - Addressed few other nit comments.
>
> Changes since v13:
>  - Split PATCH1 into six granular patches
>  - Addressed nit comments from Thomas and Bjorn
>
> Changes since v12:
>  - Rebased on Linux-6.8-rc5
>  - Dropped per-device MSI domain patches which are already merged by Thom=
as (tglx)
>  - Addressed nit comments from Thomas and Clement
>  - Added a new patch2 to fix lock dependency warning
>  - Replaced local sync IPI in the IMSIC driver with per-CPU timer
>  - Simplified locking in the IMSIC driver to avoid lock dependency issues
>  - Added a dirty bitmap in the IMSIC driver to optimize per-CPU local syn=
c loop
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
>  - Dropped PATCH2 of v3 series instead we now set FWNODE_FLAG_BEST_EFFORT=
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
> Anup Patel (9):
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

Can this series be considered for Linux-6.9 ?

Regards,
Anup

>
>  .../interrupt-controller/riscv,aplic.yaml     | 172 ++++
>  .../interrupt-controller/riscv,imsics.yaml    | 172 ++++
>  MAINTAINERS                                   |  14 +
>  arch/riscv/Kconfig                            |   2 +
>  drivers/irqchip/Kconfig                       |  25 +
>  drivers/irqchip/Makefile                      |   3 +
>  drivers/irqchip/irq-riscv-aplic-direct.c      | 326 +++++++
>  drivers/irqchip/irq-riscv-aplic-main.c        | 211 +++++
>  drivers/irqchip/irq-riscv-aplic-main.h        |  52 ++
>  drivers/irqchip/irq-riscv-aplic-msi.c         | 257 ++++++
>  drivers/irqchip/irq-riscv-imsic-early.c       | 201 ++++
>  drivers/irqchip/irq-riscv-imsic-platform.c    | 374 ++++++++
>  drivers/irqchip/irq-riscv-imsic-state.c       | 865 ++++++++++++++++++
>  drivers/irqchip/irq-riscv-imsic-state.h       | 108 +++
>  include/linux/cpuhotplug.h                    |   1 +
>  include/linux/irqchip/riscv-aplic.h           | 145 +++
>  include/linux/irqchip/riscv-imsic.h           |  87 ++
>  17 files changed, 3015 insertions(+)
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

