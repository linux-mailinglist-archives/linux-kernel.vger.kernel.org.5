Return-Path: <linux-kernel+bounces-76237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B6785F4A0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E02DDB23FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BC2381D5;
	Thu, 22 Feb 2024 09:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="aY7TzLrs"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0C43717C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594822; cv=none; b=IF94E2kB6dNqW2vzt95BYRWpHsQbAsDUDiyfcWfi42ZJaHdpM15QJ9oHUxOHcQrgNhygC0vXRU+uqfYalCt9+VRGalLSM5babZAdajCVllhDVLLpvmx5CH/rV2dRNSDNz2qAVIPCZDULVYQE1YfEiyDhOTePux9pKZR7CbmEDzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594822; c=relaxed/simple;
	bh=sxkFgfX1J1dlHF8XYh5iD680OfopOEbs+7puD9BsSMc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=U4S/7Z/3c1go902WtuovR7zZ6TbJrJiWyZOmVYeE+Sn1+kE2pyYtwd647NngVhdqd+fjcMaOTuiSjP/5RedUPUKXqUX7kzEGA2tUkVTpvXoE6Wdg6e+G0L8Bq8TSPSfYrV2OY+j5ohnchpDWv4J7GAE4nX080A9yiO2KMw51l/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=aY7TzLrs; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c031c24fbeso1094402b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708594820; x=1709199620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JILf6PMObqFr5GyvnIqPuLsPaQ/duKmYH3sSJO+WbmQ=;
        b=aY7TzLrs3l4bpOHvCeik5LtyhH1dCanTtRQCvCE2ADyI6zc7GIcCumgZOAzYxYEJIo
         NsAjuVmZfIb1tsFcdVCw1mKg6qooREatiTPlhbCL6jD0tDWUHePc2Qv8gjDBguyRssd3
         zsV/svKDU+TlK02nvlmMhamgrrs6h63ard5pVC0H6VX/8Uzrr6PlrmfpUOYbBwPqFyhN
         NDPh7+h/rwwersJa9J2eIMySYNxOG1Js1FptBsmx8ZiiRozHDkECWdi0Wp89qreQF5CV
         2RoEl7cuNNpV1bD/xKenlA+SX/uYZVLinxH6uLAIBvHyRL12XjfyHAqwXgoHv8vOThro
         uqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708594820; x=1709199620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JILf6PMObqFr5GyvnIqPuLsPaQ/duKmYH3sSJO+WbmQ=;
        b=JlTzwB3UeniyzrSTzJ91z+5W/c0DhCRxrZs5L/nkEEmQgyv4eXIdF6TeJrB+kT9gNB
         ++OmzwM9zDu0efkMEoc9ZdkIksJTAU7Wrv4OrEHsoEpoFwyWtoblqCTct0cy5li1CF4s
         JO1WIB4PDo2jukIutp7TPqqv1K0poRdfKXuJvMwb+WA12VnzAh4d3yAKD7TdTdLwb59x
         u7zRR2sDtunWxIKN0+PU/Q1NnEWDncTTsY44wVrcXgsjwHpJibsL0pW/NZPNxfTds5zQ
         i6z5RYGsoocYn1HUdtp2bzWuQr9gNW1Fv2YMaYrmPAOQvaRQHygNSXiF4kgtZDvpYioP
         FYRg==
X-Forwarded-Encrypted: i=1; AJvYcCUJeKIemi/Ox82rrK4kXPnRYgx/0NIygBFpqYgsha9lwm9BozuJyGJmUjPmH92Dn3RDNM0hjpetB5TRnWzAPP6+ubG4MUSO7dFT+KXC
X-Gm-Message-State: AOJu0YwbYV77+x6PyM+N5OMxwylwPjPMzkQLeX0lJl0OH/LKiJeWTrlp
	l6ck9/s6fMenA0OTguP7oLiLtU1cPlmv99XpRlqyDiIIy+OakELKwxbLYiux1Lc=
X-Google-Smtp-Source: AGHT+IGYO9j42eUUiUXwi1vhsPjN6/HLaOTVseTggTORI5FXMgdX+Jt5qOLI/bu40Zopn71dqNNx1w==
X-Received: by 2002:a05:6808:d53:b0:3c1:55ba:7d42 with SMTP id w19-20020a0568080d5300b003c155ba7d42mr13331984oik.11.1708594819666;
        Thu, 22 Feb 2024 01:40:19 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id n15-20020a05680803af00b003c17c2b8d09sm130699oie.31.2024.02.22.01.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 01:40:19 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Saravana Kannan <saravanak@google.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v14 00/18] Linux RISC-V AIA Support
Date: Thu, 22 Feb 2024 15:09:48 +0530
Message-Id: <20240222094006.1030709-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The RISC-V AIA specification is ratified as-per the RISC-V international
process. The latest ratified AIA specifcation can be found at:
https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-interrupts-1.0.pdf

At a high-level, the AIA specification adds three things:
1) AIA CSRs
   - Improved local interrupt support
2) Incoming Message Signaled Interrupt Controller (IMSIC)
   - Per-HART MSI controller
   - Support MSI virtualization
   - Support IPI along with virtualization
3) Advanced Platform-Level Interrupt Controller (APLIC)
   - Wired interrupt controller
   - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI generator)
   - In Direct-mode, injects external interrupts directly into HARTs

For an overview of the AIA specification, refer the AIA virtualization
talk at KVM Forum 2022:
https://static.sched.com/hosted_files/kvmforum2022/a1/AIA_Virtualization_in_KVM_RISCV_final.pdf
https://www.youtube.com/watch?v=r071dL8Z0yo

To test this series, use QEMU v7.2 (or higher) and OpenSBI v1.2 (or higher).

This series depends upon per-device MSI domain patches merged by Thomas (tglx)
which are available in irq/msi branch at:
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

These patches can also be found in the riscv_aia_v14 branch at:
https://github.com/avpatel/linux.git

Changes since v13:
 - Split PATCH1 into six granular patches
 - Addressed nit comments from Thomas and Bjorn

Changes since v12:
 - Rebased on Linux-6.8-rc5
 - Dropped per-device MSI domain patches which are already merged by Thomas (tglx)
 - Addressed nit comments from Thomas and Clement
 - Added a new patch2 to fix lock dependency warning
 - Replaced local sync IPI in the IMSIC driver with per-CPU timer
 - Simplified locking in the IMSIC driver to avoid lock dependency issues
 - Added a dirty bitmap in the IMSIC driver to optimize per-CPU local sync loop

Changes since v11:
 - Rebased on Linux-6.8-rc1
 - Included kernel/irq related patches from "genirq, irqchip: Convert ARM
   MSI handling to per device MSI domains" series by Thomas.
   (PATCH7, PATCH8, PATCH9, PATCH14, PATCH16, PATCH17, PATCH18, PATCH19,
    PATCH20, PATCH21, PATCH22, PATCH23, and PATCH32 of
    https://lore.kernel.org/linux-arm-kernel/20221121135653.208611233@linutronix.de/)
 - Updated APLIC MSI-mode driver to use the new WIRED_TO_MSI mechanism.
 - Updated IMSIC driver to support per-device MSI domains for PCI and
   platform devices.

Changes since v10:
 - Rebased on Linux-6.6-rc7
 - Dropped PATCH3 of v10 series since this has been merged by MarcZ
   for Linux-6.6-rc7
 - Changed the IMSIC ID management strategy from 1-n approach to
   x86-style 1-1 approach

Changes since v9:
 - Rebased on Linux-6.6-rc4
 - Use builtin_platform_driver() in PATCH5, PATCH9, and PATCH12

Changes since v8:
 - Rebased on Linux-6.6-rc3
 - Dropped PATCH2 of v8 series since we won't be requiring
   riscv_get_intc_hartid() based on Marc Z's comments on ACPI AIA support.
 - Addressed Saravana's comments in PATCH3 of v8 series
 - Update PATCH9 and PATCH13 of v8 series based on comments from Sunil

Changes since v7:
 - Rebased on Linux-6.6-rc1
 - Addressed comments on PATCH1 of v7 series and split it into two PATCHes
 - Use DEFINE_SIMPLE_PROP() in PATCH2 of v7 series

Changes since v6:
 - Rebased on Linux-6.5-rc4
 - Updated PATCH2 to use IS_ENABLED(CONFIG_SPARC) instead of
   !IS_ENABLED(CONFIG_OF_IRQ)
 - Added new PATCH4 to fix syscore registration in PLIC driver
 - Update PATCH5 to convert PLIC driver into full-blown platform driver
   with a re-written probe function.

Changes since v5:
 - Rebased on Linux-6.5-rc2
 - Updated the overall series to ensure that only IPI, timer, and
   INTC drivers are probed very early whereas rest of the interrupt
   controllers (such as PLIC, APLIC, and IMISC) are probed as
   regular platform drivers.
 - Renamed riscv_fw_parent_hartid() to riscv_get_intc_hartid()
 - New PATCH1 to add fw_devlink support for msi-parent DT property
 - New PATCH2 to ensure all INTC suppliers are initialized which in-turn
   fixes the probing issue for PLIC, APLIC and IMSIC as platform driver
 - New PATCH3 to use platform driver probing for PLIC
 - Re-structured the IMSIC driver into two separate drivers: early and
   platform. The IMSIC early driver (PATCH7) only initialized IMSIC state
   and provides IPIs whereas the IMSIC platform driver (PATCH8) is probed
   provides MSI domain for platform devices.
 - Re-structure the APLIC platform driver into three separe sources: main,
   direct mode, and MSI mode.

Changes since v4:
 - Rebased on Linux-6.5-rc1
 - Added "Dependencies" in the APLIC bindings (PATCH6 in v4)
 - Dropped the PATCH6 which was changing the IOMMU DMA domain APIs
 - Dropped use of IOMMU DMA APIs in the IMSIC driver (PATCH4)

Changes since v3:
 - Rebased on Linux-6.4-rc6
 - Dropped PATCH2 of v3 series instead we now set FWNODE_FLAG_BEST_EFFORT via
   IRQCHIP_DECLARE()
 - Extend riscv_fw_parent_hartid() to support both DT and ACPI in PATCH1
 - Extend iommu_dma_compose_msi_msg() instead of adding iommu_dma_select_msi()
   in PATCH6
 - Addressed Conor's comments in PATCH3
 - Addressed Conor's and Rob's comments in PATCH7

Changes since v2:
 - Rebased on Linux-6.4-rc1
 - Addressed Rob's comments on DT bindings patches 4 and 8.
 - Addessed Marc's comments on IMSIC driver PATCH5
 - Replaced use of OF apis in APLIC and IMSIC drivers with FWNODE apis
   this makes both drivers easily portable for ACPI support. This also
   removes unnecessary indirection from the APLIC and IMSIC drivers.
 - PATCH1 is a new patch for portability with ACPI support
 - PATCH2 is a new patch to fix probing in APLIC drivers for APLIC-only systems.
 - PATCH7 is a new patch which addresses the IOMMU DMA domain issues pointed
   out by SiFive

Changes since v1:
 - Rebased on Linux-6.2-rc2
 - Addressed comments on IMSIC DT bindings for PATCH4
 - Use raw_spin_lock_irqsave() on ids_lock for PATCH5
 - Improved MMIO alignment checks in PATCH5 to allow MMIO regions
   with holes.
 - Addressed comments on APLIC DT bindings for PATCH6
 - Fixed warning splat in aplic_msi_write_msg() caused by
   zeroed MSI message in PATCH7
 - Dropped DT property riscv,slow-ipi instead will have module
   parameter in future.

Anup Patel (17):
  irqchip/sifive-plic: Convert PLIC driver into a platform driver
  irqchip/sifive-plic: Use dev_xyz() in-place of pr_xyz()
  irqchip/sifive-plic: Use devm_xyz() for managed allocation
  irqchip/sifive-plic: Use riscv_get_intc_hwnode() to get parent fwnode
  irqchip/sifive-plic: Cleanup PLIC contexts upon irqdomain creation
    failure
  irqchip/sifive-plic: Parse number of irqs and contexts early in
    plic_probe
  irqchip/sifive-plic: Improve locking safety by using
    irqsave/irqrestore
  irqchip/riscv-intc: Add support for RISC-V AIA
  dt-bindings: interrupt-controller: Add RISC-V incoming MSI controller
  irqchip: Add RISC-V incoming MSI controller early driver
  irqchip/riscv-imsic: Add device MSI domain support for platform
    devices
  irqchip/riscv-imsic: Add device MSI domain support for PCI devices
  dt-bindings: interrupt-controller: Add RISC-V advanced PLIC
  irqchip: Add RISC-V advanced PLIC driver for direct-mode
  irqchip/riscv-aplic: Add support for MSI-mode
  RISC-V: Select APLIC and IMSIC drivers
  MAINTAINERS: Add entry for RISC-V AIA drivers

Björn Töpel (1):
  genirq/matrix: Dynamic bitmap allocation

 .../interrupt-controller/riscv,aplic.yaml     | 172 ++++
 .../interrupt-controller/riscv,imsics.yaml    | 172 ++++
 MAINTAINERS                                   |  14 +
 arch/riscv/Kconfig                            |   2 +
 arch/x86/include/asm/hw_irq.h                 |   2 -
 drivers/irqchip/Kconfig                       |  25 +
 drivers/irqchip/Makefile                      |   3 +
 drivers/irqchip/irq-riscv-aplic-direct.c      | 326 +++++++
 drivers/irqchip/irq-riscv-aplic-main.c        | 211 +++++
 drivers/irqchip/irq-riscv-aplic-main.h        |  52 ++
 drivers/irqchip/irq-riscv-aplic-msi.c         | 263 ++++++
 drivers/irqchip/irq-riscv-imsic-early.c       | 201 ++++
 drivers/irqchip/irq-riscv-imsic-platform.c    | 375 ++++++++
 drivers/irqchip/irq-riscv-imsic-state.c       | 870 ++++++++++++++++++
 drivers/irqchip/irq-riscv-imsic-state.h       | 108 +++
 drivers/irqchip/irq-riscv-intc.c              |  32 +-
 drivers/irqchip/irq-sifive-plic.c             | 269 ++++--
 include/linux/irqchip/riscv-aplic.h           | 145 +++
 include/linux/irqchip/riscv-imsic.h           |  87 ++
 kernel/irq/matrix.c                           |  28 +-
 20 files changed, 3235 insertions(+), 122 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
 create mode 100644 drivers/irqchip/irq-riscv-aplic-direct.c
 create mode 100644 drivers/irqchip/irq-riscv-aplic-main.c
 create mode 100644 drivers/irqchip/irq-riscv-aplic-main.h
 create mode 100644 drivers/irqchip/irq-riscv-aplic-msi.c
 create mode 100644 drivers/irqchip/irq-riscv-imsic-early.c
 create mode 100644 drivers/irqchip/irq-riscv-imsic-platform.c
 create mode 100644 drivers/irqchip/irq-riscv-imsic-state.c
 create mode 100644 drivers/irqchip/irq-riscv-imsic-state.h
 create mode 100644 include/linux/irqchip/riscv-aplic.h
 create mode 100644 include/linux/irqchip/riscv-imsic.h

-- 
2.34.1


