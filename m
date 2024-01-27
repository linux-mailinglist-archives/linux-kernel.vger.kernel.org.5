Return-Path: <linux-kernel+bounces-41273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B1683EE50
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0202DB21304
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDAB2C19A;
	Sat, 27 Jan 2024 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="GhCTZj5l"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CB829438
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372299; cv=none; b=kBL37wCtEcswJW6IU/Iszm9fKpiSICAAkGZcbrwnChaZp93AUAtjVRtI3blE/WhU7q4W1CZbI6ML40h+XIBtgvNhuy2NRURzoJJX8HGvu4x3y1TlnnfrgoBH/Ch0Lh104S6JnTKtnk9oXGjE2iHCLvhRTizLkCGREEZPQbvCvZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372299; c=relaxed/simple;
	bh=00uUoZJjpJfudGGaK0CWiwEIWHPRoBr4LV8Tc9IGtCo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Z8GCs/+JdoeHGH+ZxLUXle12Hzt/ihqEP0umXRMbltXc/J3Hrt+vyyvv5JMUicY3f1avHdN7v/LYK3AHdYKVwqafLL8k0fRj82h9h/TVFMS4T0XwpqCWDpbTY0jA3xhHLNp2w/Hyy1ZMwuCeDrEQkxxxBUCQJl50/fVcaVlzeYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=GhCTZj5l; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6db0fdd2b8fso663304b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 08:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1706372297; x=1706977097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h7hx93RMzOG3i+4WQOwQzVSRRqOO7TKXa/DZQGj85K0=;
        b=GhCTZj5lLxxYtn+D3zEFdypu1GYfIxBUL45LeD1cItN6v2xbXqR/rP+sO6a+1o+Ekl
         mcSWtIAxWg2vCMkBWQUCOcIjHwvEDf3K0XYX+fl0YyDHrWSM9CB1KJh/NsoaGExZis4A
         rL7k165nC3YIGmlkMkeGdf2/Wx8GCxOe4mbQIHbhoH5q+nhhXFhA5nrilMH3kDFz9mBm
         10YJNQKufBCz/jyyRU8MatNS7WNx4bnPmFq16ix96OMcyMKVklWQ/upHIy1E4m3PhTYB
         5s/wJdiPRhsf42MgX8kD61XiKg7TPWJvzKjtkZVjYyz65U1nqaBPhJiQgT05Yx8wsVba
         xcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706372297; x=1706977097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7hx93RMzOG3i+4WQOwQzVSRRqOO7TKXa/DZQGj85K0=;
        b=e5ELKc7zdguws/tJCVQUXVRiIJCgx/GrmpPJIa4zAOtw47KLdBzA+q39EgtO9vwi7K
         EjpRHDOdLeGxCNrdi5SFe+rQ1sSQE9eviWpP9lmIHKlAj0CK9KqObN1DuqWJxYcPTCl1
         +IYMgeTkCHN6pfPDV7yDB1BDqgyxkGfGqbWr4tVq3xtI7lN7IbH0bIWMbX2TK2MQtUtU
         grnUeSNFvsSEA9CEql5nYrL5yn75BYeAXWLVHvzUtLgtzUSk8ET/Hqbqc30jNPbUtYfz
         pq+Q3zk/x7VOutJ3VSML/41Nghj/dn4NCcpq17C3Meti7Gg+Pdx/Zlo/incVQeeBA26Q
         1SEQ==
X-Gm-Message-State: AOJu0YyFi4b9qQMJKuvfTAIDOxqHyoxhdHzYoZ4QaV8hgWlfdTo/NuPe
	DtkhYenQ+eoT4eic+2Wumb9RWYzd6sjr723wxzxe03QKsDW0XqCdRkjvwXyElP4=
X-Google-Smtp-Source: AGHT+IEma6WsJ23dnwP9eoVoeoxYtlisa04b7FA0r2KBJAdzpL/P9u3V2dyxSYhtGsTNZnyN6WDzCw==
X-Received: by 2002:a17:902:e80c:b0:1d8:a38b:c13b with SMTP id u12-20020a170902e80c00b001d8a38bc13bmr1375972plg.6.1706372297076;
        Sat, 27 Jan 2024 08:18:17 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.17])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090ac24b00b00290f8c708d0sm5091620pjx.57.2024.01.27.08.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 08:18:16 -0800 (PST)
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
Subject: [PATCH v12 00/25] Linux RISC-V AIA Support
Date: Sat, 27 Jan 2024 21:47:28 +0530
Message-Id: <20240127161753.114685-1-apatel@ventanamicro.com>
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

These patches can also be found in the riscv_aia_v12 branch at:
https://github.com/avpatel/linux.git

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
 - Droped PATCH2 of v3 series instead we now set FWNODE_FLAG_BEST_EFFORT via
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

Anup Patel (11):
  irqchip/sifive-plic: Convert PLIC driver into a platform driver
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

Thomas Gleixner (13):
  irqchip/gic-v3: Make gic_irq_domain_select() robust for zero parameter
    count
  genirq/irqdomain: Remove the param count restriction from select()
  genirq/msi: Extend msi_parent_ops
  genirq/irqdomain: Add DOMAIN_BUS_DEVICE_IMS
  platform-msi: Prepare for real per device domains
  irqchip: Convert all platform MSI users to the new API
  genirq/msi: Provide optional translation op
  genirq/msi: Split msi_domain_alloc_irq_at()
  genirq/msi: Provide DOMAIN_BUS_WIRED_TO_MSI
  genirq/msi: Optionally use dev->fwnode for device domain
  genirq/msi: Provide allocation/free functions for "wired" MSI
    interrupts
  genirq/irqdomain: Reroute device MSI create_mapping
  genirq/msi: Provide MSI_FLAG_PARENT_PM_DEV

 .../interrupt-controller/riscv,aplic.yaml     | 172 ++++
 .../interrupt-controller/riscv,imsics.yaml    | 172 ++++
 MAINTAINERS                                   |  14 +
 arch/riscv/Kconfig                            |   2 +
 arch/x86/include/asm/hw_irq.h                 |   2 -
 drivers/base/platform-msi.c                   |  97 ++
 drivers/dma/mv_xor_v2.c                       |   8 +-
 drivers/dma/qcom/hidma.c                      |   6 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   5 +-
 drivers/irqchip/Kconfig                       |  25 +
 drivers/irqchip/Makefile                      |   3 +
 drivers/irqchip/irq-gic-v3.c                  |   6 +-
 drivers/irqchip/irq-riscv-aplic-direct.c      | 343 +++++++
 drivers/irqchip/irq-riscv-aplic-main.c        | 232 +++++
 drivers/irqchip/irq-riscv-aplic-main.h        |  53 ++
 drivers/irqchip/irq-riscv-aplic-msi.c         | 256 +++++
 drivers/irqchip/irq-riscv-imsic-early.c       | 241 +++++
 drivers/irqchip/irq-riscv-imsic-platform.c    | 403 ++++++++
 drivers/irqchip/irq-riscv-imsic-state.c       | 887 ++++++++++++++++++
 drivers/irqchip/irq-riscv-imsic-state.h       | 105 +++
 drivers/irqchip/irq-riscv-intc.c              |  34 +-
 drivers/irqchip/irq-sifive-plic.c             | 239 +++--
 drivers/mailbox/bcm-flexrm-mailbox.c          |   8 +-
 drivers/perf/arm_smmuv3_pmu.c                 |   4 +-
 drivers/ufs/host/ufs-qcom.c                   |   8 +-
 include/linux/irqchip/riscv-aplic.h           | 119 +++
 include/linux/irqchip/riscv-imsic.h           |  87 ++
 include/linux/irqdomain.h                     |  17 +
 include/linux/irqdomain_defs.h                |   2 +
 include/linux/msi.h                           |  21 +
 kernel/irq/irqdomain.c                        |  28 +-
 kernel/irq/matrix.c                           |  28 +-
 kernel/irq/msi.c                              | 184 +++-
 33 files changed, 3636 insertions(+), 175 deletions(-)
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


