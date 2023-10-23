Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C4A7D3D96
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjJWR2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjJWR2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:28:13 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7544D10C1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:28:10 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so3433904b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698082090; x=1698686890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tfvEvyXadvTa0avcNkiDQ8d/SVy/4h80ap5qfPTWpBQ=;
        b=HNpJ99eK0ln4HQwmslKHGoIZdzlfk7Jxt06lYrZH3Djhn/br4vM2BCERLxfVlNA9lr
         kz2BDpvHfgcOMHMG0qRKQ+v2WazHiH7J6+1vl/kNZnfR/O+Q0GwFTgKTzkkTClCvUcYl
         OcvC+AQO8mV176305S2Pla+GO0lqYeGQiurCD6ByJfiaMH+B5VIkjKqSIEEsyDuGef+Y
         hPNYp9oF8uuhJn0OsN+DuynL3qJP3cqMLOdhI67TiTmL9BKINp2p7brPXLVCV2Chf3iA
         YWADtuh903+EFCF5+Jpy6LmrLLZ6alXvzbcnvlypfsWEOhTfEsxtLR3TSMLuH1r4NeLD
         jLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698082090; x=1698686890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tfvEvyXadvTa0avcNkiDQ8d/SVy/4h80ap5qfPTWpBQ=;
        b=qw7dR/NkZ0CREE/Q1gVKZ3gPwIivI8KP3IRIWnF4Q8pejtk8ZS8SomJ4h6CfZ7wz51
         xwwvyY0Gq/wYb0D3iZIUydfGiOyZdz6QbyuAmHt/GMiKe9toHw6YklTVbEYcR0M7Wr3s
         Tdw1qEnczDaDmcY6IhMTwBSGDApjI48iRWeW85pNFwcqxn29wXA471z+Y6f+5zJZSqCu
         iid64fgXdlJfdC1Gh1abvOiyDI1badkcpsOMFZb0TOT/X86z+JfiAoKO5Vm9weWdrzEN
         4n1/2+vIFId/HO5T6uAPfM/NBueVitWWgTcEmqfT8PayqPCPvglh0YwmJ2RGvxEBSyut
         qr5w==
X-Gm-Message-State: AOJu0YwcuScIKFqsfujizEZ0REEj7mBVnzQ93lfS/oOBDKdUIIGLEYvj
        iiVm6DOtjqVF9/c9Hvpe8KMY/Q==
X-Google-Smtp-Source: AGHT+IHvjF1EmWEIlpmImDCR170AkJLmc3QBqLpgBbftXhVcIr6CvpnrtY98+H1ztJlQIXLtd76Viw==
X-Received: by 2002:a05:6a00:2d10:b0:6b6:5ed4:dd42 with SMTP id fa16-20020a056a002d1000b006b65ed4dd42mr12507871pfb.31.1698082089661;
        Mon, 23 Oct 2023 10:28:09 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.9])
        by smtp.gmail.com with ESMTPSA id g5-20020aa79f05000000b006be055ab117sm6473194pfr.92.2023.10.23.10.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 10:28:09 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v11 00/14] Linux RISC-V AIA Support
Date:   Mon, 23 Oct 2023 22:57:46 +0530
Message-Id: <20231023172800.315343-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

These patches can also be found in the riscv_aia_v11 branch at:
https://github.com/avpatel/linux.git

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

Anup Patel (14):
  RISC-V: Don't fail in riscv_of_parent_hartid() for disabled HARTs
  of: property: Add fw_devlink support for msi-parent
  irqchip/sifive-plic: Fix syscore registration for multi-socket systems
  irqchip/sifive-plic: Convert PLIC driver into a platform driver
  irqchip/riscv-intc: Add support for RISC-V AIA
  dt-bindings: interrupt-controller: Add RISC-V incoming MSI controller
  irqchip: Add RISC-V incoming MSI controller early driver
  irqchip/riscv-imsic: Add support for platform MSI irqdomain
  irqchip/riscv-imsic: Add support for PCI MSI irqdomain
  dt-bindings: interrupt-controller: Add RISC-V advanced PLIC
  irqchip: Add RISC-V advanced PLIC driver for direct-mode
  irqchip/riscv-aplic: Add support for MSI-mode
  RISC-V: Select APLIC and IMSIC drivers
  MAINTAINERS: Add entry for RISC-V AIA drivers

 .../interrupt-controller/riscv,aplic.yaml     | 172 ++++
 .../interrupt-controller/riscv,imsics.yaml    | 172 ++++
 MAINTAINERS                                   |  14 +
 arch/riscv/Kconfig                            |   2 +
 arch/riscv/kernel/cpu.c                       |  11 +-
 drivers/irqchip/Kconfig                       |  24 +
 drivers/irqchip/Makefile                      |   3 +
 drivers/irqchip/irq-riscv-aplic-direct.c      | 343 +++++++
 drivers/irqchip/irq-riscv-aplic-main.c        | 232 +++++
 drivers/irqchip/irq-riscv-aplic-main.h        |  53 +
 drivers/irqchip/irq-riscv-aplic-msi.c         | 285 ++++++
 drivers/irqchip/irq-riscv-imsic-early.c       | 235 +++++
 drivers/irqchip/irq-riscv-imsic-platform.c    | 360 +++++++
 drivers/irqchip/irq-riscv-imsic-state.c       | 962 ++++++++++++++++++
 drivers/irqchip/irq-riscv-imsic-state.h       | 110 ++
 drivers/irqchip/irq-riscv-intc.c              |  34 +-
 drivers/irqchip/irq-sifive-plic.c             | 242 +++--
 drivers/of/property.c                         |   2 +
 include/linux/irqchip/riscv-aplic.h           | 119 +++
 include/linux/irqchip/riscv-imsic.h           |  87 ++
 20 files changed, 3359 insertions(+), 103 deletions(-)
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

