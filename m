Return-Path: <linux-kernel+bounces-80528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8865D866928
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1661C21531
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D801B275;
	Mon, 26 Feb 2024 04:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kX1erG+l"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972E81947E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708920544; cv=none; b=IaEfApdN56IrVc0osl4fwC7GsXFyI6l6AAORL2V8K5QDwkos/Q6orK/nggcVMSTAgHgCO8KO0UNX+xb9HjCUlHXAFI5Vc0cuOuFKN+YcWbAgETXDveGzwLxW5hrrSMWR5aeQTnQTzBpcE0wGa286cfMAxVhWr6T46XzhPWZVpe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708920544; c=relaxed/simple;
	bh=rrLMpOFTWqehUwLM6Je1lpJP7bCrTwdlgD/DRAmyfm0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sMVEykE6PkFdMKa6WgsQ4ldcirgxrFYyPiQxt52BLFsPiPkbwkRlN7bAYwy7g5Q9h78CBYD6XiIcsgyTWzy8VFIVzuRDzCJQyh61iEB8FtpRFDSCYRCoaKF+BCop7z/c076kj5IqP946DoPV1oV03o9qTMZ85+iSCfD+lvrVIPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kX1erG+l; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e4670921a4so1320894b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 20:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708920542; x=1709525342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N9zvVIB6oBypg9H0uxhMZz8KIEXtSS4WtHK2xE35xdw=;
        b=kX1erG+l5XQy42/Cr/YRJWxCYVrSfBmVp0K6sqERz5L8zy6fYX3YNq/lq8cl9vtg0t
         ZvzzlEvosK1c6sJt0IWHpLb55m+qbZE/jpNcl72qKpMtFcTV3PaheUdGwVy5cm6ugJvG
         mDMNGE+iUsRDvtFU9yr5Cn81rXmaQYeBsqd9quQIG+KnNPXoXaLUlTIlZFC4jTdmqolm
         crrzyxAeW3qoGBpqIgrTGJTjV4JCmN/4EXrwZ4wlphrigG30KVesf+JEAEgOnwIZiUUV
         sA+Kbw9HAaokyvP7+JZmN/bzJMcLUABSkJmsb6xOWwDCY4jQZIotY36KIfeJnI5TuUpN
         XUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708920542; x=1709525342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9zvVIB6oBypg9H0uxhMZz8KIEXtSS4WtHK2xE35xdw=;
        b=LxrvwSCuGARfX6V34TddqZXlwpvRSsLVcpgrc+mPiXATwZoKlctXO6tGVBL8CvaGxd
         x0N+idagocBhsR0HFKltMIeviegHDhvDOnd8Mo1vWiv/EmHeY7tEBZjL+yX/XB9SWl1Y
         alrXY2pa3MnfONtumCHjcID/i3pinh5mz4zPBMmYOa+HDPPKS/L8ujJwk+D0rz5xJXKP
         ycRo5gRihSpaJYLaeXMYs3GdbZjrTYihCWhLI2RlHakI/5Wo3rX2SYGgRDT/3MgFKh9n
         J0GnaHWSXarWFPn5W6fdhcHB0cORj4sUDwzNaZEIHDRe591t4SXbePWKux7bIJeRq4Ek
         fXkw==
X-Forwarded-Encrypted: i=1; AJvYcCUbGAR3MpdegOGNPaHK3Trr+pADHB9SpbEMPXujCLwkV3oydehAxpZAoQr8X6WU3gbInEpit5Ai1FuqB/ilD6QUC4rpbuTI2n3mYPpc
X-Gm-Message-State: AOJu0Yw5GwuDbxK3KCKcavX4QK/lBor7+ToLa/YjEbQ10N5FzkMGMEDP
	KgnQrQiPNkJml3q40GIv46aoLh071DFfIjTfW8Ax3X9J0GBhH+B+5KCLOyIgov4=
X-Google-Smtp-Source: AGHT+IEv4aDPCEAkK7hxZ837br8iS335dNlDEOA3dBElln/4xACcPsMwudLMDYnQJE5yvqHri2Mjow==
X-Received: by 2002:a05:6a21:2d09:b0:1a0:f9e1:2d11 with SMTP id tw9-20020a056a212d0900b001a0f9e12d11mr3543890pzb.8.1708920541716;
        Sun, 25 Feb 2024 20:09:01 -0800 (PST)
Received: from localhost.localdomain ([171.76.86.62])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902654b00b001dc6f7e794dsm3023258pln.16.2024.02.25.20.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 20:09:01 -0800 (PST)
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
Subject: [PATCH v15 00/10] Linux RISC-V AIA Support
Date: Mon, 26 Feb 2024 09:37:36 +0530
Message-Id: <20240226040746.1396416-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

This series depends upon per-device MSI domain (and few other) patches merged
by Thomas (tglx) which are available in irq/msi branch at:
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

These patches can also be found in the riscv_aia_v15 branch at:
https://github.com/avpatel/linux.git

Changes since v14:
 - Dropped 9 patches which are already merged by Thomas (tglx) and available in
   his irq/msi branch at git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 - Added new PATCH1 which adds changes missed out in merging AIA support for
   RISC-V INTC.
 - Added a separate cpuhp state for IMSIC driver in PATCH3 which ensures that
   cpuhp notifiers of IMSIC are called as early as possible.
 - Removed redundant barriers in PATCH3.
 - Addressed few other nit comments.

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

Anup Patel (10):
  irqchip/riscv-intc: Fix low-level interrupt handler setup for AIA
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

 .../interrupt-controller/riscv,aplic.yaml     | 172 ++++
 .../interrupt-controller/riscv,imsics.yaml    | 172 ++++
 MAINTAINERS                                   |  14 +
 arch/riscv/Kconfig                            |   2 +
 drivers/irqchip/Kconfig                       |  25 +
 drivers/irqchip/Makefile                      |   3 +
 drivers/irqchip/irq-riscv-aplic-direct.c      | 326 +++++++
 drivers/irqchip/irq-riscv-aplic-main.c        | 211 +++++
 drivers/irqchip/irq-riscv-aplic-main.h        |  52 ++
 drivers/irqchip/irq-riscv-aplic-msi.c         | 263 ++++++
 drivers/irqchip/irq-riscv-imsic-early.c       | 201 ++++
 drivers/irqchip/irq-riscv-imsic-platform.c    | 374 ++++++++
 drivers/irqchip/irq-riscv-imsic-state.c       | 865 ++++++++++++++++++
 drivers/irqchip/irq-riscv-imsic-state.h       | 108 +++
 drivers/irqchip/irq-riscv-intc.c              |  10 +-
 include/linux/cpuhotplug.h                    |   1 +
 include/linux/irqchip/riscv-aplic.h           | 145 +++
 include/linux/irqchip/riscv-imsic.h           |  87 ++
 18 files changed, 3028 insertions(+), 3 deletions(-)
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


