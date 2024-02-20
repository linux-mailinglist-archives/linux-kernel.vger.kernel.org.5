Return-Path: <linux-kernel+bounces-72375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BB585B29C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A27C1C21FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37D657899;
	Tue, 20 Feb 2024 06:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DW28gXgm"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D77857329
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409269; cv=none; b=E91+t+oyhY1GZT9QDz4k1oi0NCDu36Mw5aZh6KAdjduUtHAhTmu1zgru+jTI8VroPmuWRth9mQdSImDzXXCdwPwWSQEGzs3Ro3m+BAKBG4DsE8NoaFSie2IA46U1gDY8P0YKaKJ4UqgQnqd+1PeiGveHaMUjpratvPKJqyBayes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409269; c=relaxed/simple;
	bh=w+qJCf2t/JSaAdN/NE5was8KlVWDkjaUb1Wv4SrMFQY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NbIfEx8HMdm2EJyux9rKLBeLxHuXYkXJFKnJQpLbMoB/ozBeVGtnSrWeOfGhct24ygOog2uVaaQU5qJO76FIsyORoz6wBVcaj6QGGlgosiG70e19RC0sX1+JMxdBpZtP3xHXfTuE0bNvIgbY8lO3L5s14Zwp1dgyz0EE0JG2Vhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DW28gXgm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d731314e67so35496295ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708409267; x=1709014067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0YVdnjJeimj40wibFoyauF5ibuRAflwBB88FmlDpwts=;
        b=DW28gXgm91aYkEEMF5GupZjDwEZoV4WDhFBDNgYXBFS9B0afyNrn3EJmbbuGZYtwld
         h+78NpI9xVOmKBl4mlxTzy4b6miB2svTg7OO/uW7dQ6bEpuIicMw01If3iL+X3LyvXNN
         BcjS7ayWXJZcBnT0i/kctsKNSz3tfCP1CcHtrZDbHuyY4VRbXdPMWuwPrC4/nYv3uSYL
         HadRnWNC3YBtjh78ketwtVShSePfjQHkmjPcs7mkLc+Cj2mPB+EMi3TYlpEqo6qPtI15
         3aunvIrU/wgLm7dqjzyihqLci/sfTVz6EM/DOW4aSbni28L0mQcDuSZZTuAVhhPg92Kl
         cQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708409267; x=1709014067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0YVdnjJeimj40wibFoyauF5ibuRAflwBB88FmlDpwts=;
        b=MA3fAvimyTWgX7gjVDUAVBzxdZNudfXVprqZ1qm+abxoOMabFjuf99P2m2Jr3i2cG9
         M8EGnoHUh9ydxDeX0p5TVmZETvtdU/+pqj+PLnd/4SSJX/3yTLRjsr/i0bStF1kep3lB
         2+v8Uzg9eKV19pLymVdCEpTZO2dC+TPkfgZJypFuiwpsYR2AfwgfRjU/d4V9WjJ/d3Bs
         0zrv9uyL/grlcvcydK1TBBpYAI1yJWWnbxpBGRjLK5T81N2c7IfVG3Fyeqpc0y+3TTIO
         jC15HyNhwd/sFtd4b6c4nTR7sverySXKr2yoGPFz8uoKCHui16gJCaNAy9QienBW2dgx
         QoNA==
X-Forwarded-Encrypted: i=1; AJvYcCXSuAyGMGX+GgQ9ZonJ1cFcHcaHYZyYimwFQXO2R+aJhzl4IVfaonjP5HdPqFn5He1j8tKSkNfBzHuDI/Mb+URoUfwY/xsheP7rk9t5
X-Gm-Message-State: AOJu0YwbJ6qbFUGS4Nm2ImJmpNSGiNN/X4vtNYajfYLFrgHUZgzNGtmA
	vprvvNA5YHznUehXk9S6zBcZxWv/2nHHM3eQEe+G8H3/GCsPEI/f3lD5zVk4RO4=
X-Google-Smtp-Source: AGHT+IEZOnfWmZrEAL1zxVz5Bow/KcKL3MOUAYpY1SKznddPZfU4vtsXbvx7pEaPB2wx9uYZNv2OLA==
X-Received: by 2002:a17:902:e806:b0:1db:c6a0:d023 with SMTP id u6-20020a170902e80600b001dbc6a0d023mr8452556plg.8.1708409266390;
        Mon, 19 Feb 2024 22:07:46 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.80.86])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090276c600b001db4c89aea5sm5368114plt.158.2024.02.19.22.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 22:07:45 -0800 (PST)
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
Subject: [PATCH v13 00/13] Linux RISC-V AIA Support
Date: Tue, 20 Feb 2024 11:37:05 +0530
Message-Id: <20240220060718.823229-1-apatel@ventanamicro.com>
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

These patches can also be found in the riscv_aia_v13 branch at:
https://github.com/avpatel/linux.git

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

Anup Patel (12):
  irqchip/sifive-plic: Convert PLIC driver into a platform driver
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
 drivers/irqchip/irq-riscv-aplic-direct.c      | 324 +++++++
 drivers/irqchip/irq-riscv-aplic-main.c        | 211 ++++
 drivers/irqchip/irq-riscv-aplic-main.h        |  52 +
 drivers/irqchip/irq-riscv-aplic-msi.c         | 263 +++++
 drivers/irqchip/irq-riscv-imsic-early.c       | 213 ++++
 drivers/irqchip/irq-riscv-imsic-platform.c    | 378 ++++++++
 drivers/irqchip/irq-riscv-imsic-state.c       | 906 ++++++++++++++++++
 drivers/irqchip/irq-riscv-imsic-state.h       |  99 ++
 drivers/irqchip/irq-riscv-intc.c              |  34 +-
 drivers/irqchip/irq-sifive-plic.c             | 285 ++++--
 include/linux/irqchip/riscv-aplic.h           | 145 +++
 include/linux/irqchip/riscv-imsic.h           |  87 ++
 kernel/irq/matrix.c                           |  28 +-
 20 files changed, 3298 insertions(+), 117 deletions(-)
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


