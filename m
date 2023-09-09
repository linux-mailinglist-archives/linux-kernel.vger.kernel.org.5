Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B387999C5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbjIIQZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbjIIOZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 10:25:49 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8774180
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 07:25:44 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c39f2b4f5aso541675ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 07:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694269544; x=1694874344; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D95G51GYdXlh9Qcl1z+wb6iLPnwzfRsoa1uIKAB9sfc=;
        b=gB2IPKWHfG6dF5Kg/OpNTkbb/h9tNPtTnNS3vtGbpkJ3YV7d/wrAvXnZd5dYoaNn+H
         OV5Ai24HNWDiyN/My2YhvxfHC8aeUy4SmaqcoaC291MpJ2+3TE6rPQ1B5NhzB9lVqJxz
         yrPHxK0crXh5EhXsefhnKARbEQnupPVfXU9Zk2sY6LEvYSjWN0cwrxpFFHG0zrQ33ocj
         9C8yfPxwO4vHEV2N6UvyVtP645d4GDvVE8t8+/3MDlmPA+oXe3ZOE79zhDywpgngOmd8
         0McHdk//tD+G94C9sNd4w4qHALNwCZL6vHl6JEy7q5eo691mcBmrxzmF3oa7AwmaFJxa
         n3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694269544; x=1694874344;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D95G51GYdXlh9Qcl1z+wb6iLPnwzfRsoa1uIKAB9sfc=;
        b=gMEuzqLV+qNt71kNc4AFLcsWHx95MF04FPuv1Hk4AdMo5NopsX1b99nTpMp1NAaUBD
         o+yEmlFjOc25bSN7AAz2A+P18vQJgdt74c0RNUZsqmldnB4XmqjVkREyy3MI6e378aGT
         V9gFLGX2oxJQxK3yBneojYeN5YVUCe/hSBge7hE62/XOX0HE/yzJEG5iuMqw+wfJMIxz
         YDMoKqFqz6lIYHh5eoIUPnJMQNfEdd3xFq18yhe2ZOEL50CGc9f2dQGqFwgoklBBFife
         T1toMS+zEUuC/iI7X1d+Bre6PBujK17B7lo+03abRODW12B03gjudJIvZulavO5jirC9
         lSNg==
X-Gm-Message-State: AOJu0YxtPHcPu+ytldRP57+s+zd5ZI/Vhu/j3gYeWezv2iKLcUWhceKN
        8QIB5be3n9dwhtai6qzj1djfZ8KlXiD+sQ8+nEA=
X-Google-Smtp-Source: AGHT+IGOxTrco6qxSbGsbf8eLATPHqV1DgdcxiLOULTUHYT4485WQpNeBBjQWK/TmYagcmQz0Zb3CQ==
X-Received: by 2002:a17:902:f546:b0:1be:e851:c070 with SMTP id h6-20020a170902f54600b001bee851c070mr5222934plf.22.1694269544139;
        Sat, 09 Sep 2023 07:25:44 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id ay6-20020a1709028b8600b001b53c8659fesm3326320plb.30.2023.09.09.07.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 07:25:43 -0700 (PDT)
Date:   Sat, 09 Sep 2023 07:25:43 -0700 (PDT)
X-Google-Original-Date: Sat, 09 Sep 2023 07:23:02 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 6.6 Merge Window, Part 2 (try 2)
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-2cae48f5-f42a-4432-b0e2-bc1ee3e01ce5@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged tag 'riscv-for-linus-6.6-mw1'
The following changes since commit e0152e7481c6c63764d6ea8ee41af5cf9dfac5e9:

  Merge tag 'riscv-for-linus-6.6-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2023-09-01 08:09:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.6-mw2-2

for you to fetch changes up to c6a906cce61a8015b622707f9c12003f90673399:

  soc: renesas: Kconfig: For ARCH_R9A07G043 select the required configs if dependencies are met (2023-09-08 11:25:29 -0700)

----------------------------------------------------------------
RISC-V Patches for the 6.6 Merge Window, Part 2 (try 2)

* The kernel now dynamically probes for misaligned access speed, as
  opposed to relying on a table of known implementations.
* Support for non-coherent devices on systems using the Andes AX45MP
  core, including the RZ/Five SoCs.
* Support for the V extension in ptrace(), again.
* Support for KASLR.
* Support for the BPF prog pack allocator in RISC-V.
* A handful of bug fixes and cleanups.

----------------------------------------------------------------
None of these are super critical so no big deal if it's too late, but I do feel
pretty bad that Prabhakar's been pushing on the DMA stuff for a long time and
figured it'd be better to send this out even if it's late.

The diffstat looks good this time and nobody's mentioned any issues (at least
that I can see) so I think this one is looking better, but apologies in
advance if something else has gone off the rails.  The BPF docs merge conflict
is also gone, so I just have the internal one in libstub for KASLR.  I think I
got that correct, but here's the blurb from yesterday:

I resolved the libstub conflict as part of mergeing in the patch set.  The
actual conflict also looks pretty straight-forward: we refactored some KASLR
handling out to shared code, but there was also a new argument added.  I
resolved it when picking up the patch series, but after talking to some of the
Arm folks I'm not quite sure that was the right way to go.  So it won't show up
when actually merging, but figured I'd say something anyway as end up doing
that sort of "fix a conflict when merging a patch set" from time to time.

----------------------------------------------------------------
Alexandre Ghiti (5):
      riscv: Introduce virtual kernel mapping KASLR
      riscv: Dump out kernel offset information on panic
      arm64: libstub: Move KASLR handling functions to kaslr.c
      libstub: Fix compilation warning for rv32
      riscv: libstub: Implement KASLR by using generic functions

Andy Chiu (1):
      RISC-V: Add ptrace support for vectors

Arnd Bergmann (2):
      riscv: dma-mapping: only invalidate after DMA, not flush
      riscv: dma-mapping: skip invalidation before bidirectional DMA

Evan Green (2):
      RISC-V: Probe for unaligned access speed
      RISC-V: alternative: Remove feature_probe_func

Lad Prabhakar (11):
      riscv: dma-mapping: switch over to generic implementation
      riscv: asm: vendorid_list: Add Andes Technology to the vendors list
      riscv: errata: Add Andes alternative ports
      riscv: mm: dma-noncoherent: nonstandard cache operations support
      dt-bindings: cache: andestech,ax45mp-cache: Add DT binding documentation for L2 cache controller
      cache: Add L2 cache management for Andes AX45MP RISC-V core
      soc: renesas: Kconfig: Select the required configs for RZ/Five SoC
      riscv: Kconfig: Select DMA_DIRECT_REMAP only if MMU is enabled
      riscv: Kconfig.errata: Drop dependency for MMU in ERRATA_ANDES_CMO config
      riscv: Kconfig.errata: Add dependency for RISCV_SBI in ERRATA_ANDES config
      soc: renesas: Kconfig: For ARCH_R9A07G043 select the required configs if dependencies are met

Palmer Dabbelt (6):
      Merge patch series "RISC-V: Probe for misaligned access speed"
      Merge patch series "riscv: dma-mapping: unify support for cache flushes"
      Merge patch series "Add non-coherent DMA support for AX45MP"
      Merge patch "RISC-V: Add ptrace support for vectors"
      Merge patch series "riscv: Introduce KASLR"
      Merge patch series "bpf, riscv: use BPF prog pack allocator in BPF JIT"

Puranjay Mohan (4):
      bpf: make bpf_prog_pack allocator portable
      riscv: extend patch_text_nosync() for multiple pages
      riscv: implement a memset like function for text
      bpf, riscv: use prog pack allocator in the BPF JIT

 .../bindings/cache/andestech,ax45mp-cache.yaml     |  81 ++++++++
 Documentation/riscv/hwprobe.rst                    |  11 +-
 MAINTAINERS                                        |   7 +
 arch/arm64/include/asm/efi.h                       |   2 +
 arch/riscv/Kconfig                                 |  28 ++-
 arch/riscv/Kconfig.errata                          |  21 ++
 arch/riscv/errata/Makefile                         |   1 +
 arch/riscv/errata/andes/Makefile                   |   1 +
 arch/riscv/errata/andes/errata.c                   |  66 +++++++
 arch/riscv/errata/thead/errata.c                   |   8 -
 arch/riscv/include/asm/alternative.h               |   8 +-
 arch/riscv/include/asm/cpufeature.h                |   2 +
 arch/riscv/include/asm/dma-noncoherent.h           |  28 +++
 arch/riscv/include/asm/efi.h                       |   2 +
 arch/riscv/include/asm/errata_list.h               |   5 +
 arch/riscv/include/asm/page.h                      |   3 +
 arch/riscv/include/asm/patch.h                     |   1 +
 arch/riscv/include/asm/vendorid_list.h             |   1 +
 arch/riscv/include/uapi/asm/ptrace.h               |  13 +-
 arch/riscv/kernel/Makefile                         |   1 +
 arch/riscv/kernel/alternative.c                    |  24 +--
 arch/riscv/kernel/copy-unaligned.S                 |  71 +++++++
 arch/riscv/kernel/copy-unaligned.h                 |  13 ++
 arch/riscv/kernel/cpufeature.c                     | 104 ++++++++++
 arch/riscv/kernel/image-vars.h                     |   1 +
 arch/riscv/kernel/patch.c                          | 114 ++++++++++-
 arch/riscv/kernel/pi/Makefile                      |   2 +-
 arch/riscv/kernel/pi/cmdline_early.c               |  13 ++
 arch/riscv/kernel/pi/fdt_early.c                   |  30 +++
 arch/riscv/kernel/ptrace.c                         |  79 ++++++++
 arch/riscv/kernel/setup.c                          |  25 +++
 arch/riscv/kernel/smpboot.c                        |   3 +-
 arch/riscv/mm/dma-noncoherent.c                    | 103 +++++++++-
 arch/riscv/mm/init.c                               |  36 +++-
 arch/riscv/mm/pmem.c                               |  13 ++
 arch/riscv/net/bpf_jit.h                           |   3 +
 arch/riscv/net/bpf_jit_comp64.c                    |  60 ++++--
 arch/riscv/net/bpf_jit_core.c                      | 106 ++++++++--
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/cache/Kconfig                              |  11 ++
 drivers/cache/Makefile                             |   3 +
 drivers/cache/ax45mp_cache.c                       | 213 +++++++++++++++++++++
 drivers/firmware/efi/libstub/Makefile              |   4 +-
 drivers/firmware/efi/libstub/arm64-stub.c          | 117 ++---------
 drivers/firmware/efi/libstub/efistub.h             |   8 +
 drivers/firmware/efi/libstub/kaslr.c               | 159 +++++++++++++++
 drivers/firmware/efi/libstub/riscv-stub.c          |  33 ++--
 drivers/soc/renesas/Kconfig                        |   5 +
 include/uapi/linux/elf.h                           |   2 +
 kernel/bpf/core.c                                  |   8 +-
 51 files changed, 1440 insertions(+), 216 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
 create mode 100644 arch/riscv/errata/andes/Makefile
 create mode 100644 arch/riscv/errata/andes/errata.c
 create mode 100644 arch/riscv/include/asm/dma-noncoherent.h
 create mode 100644 arch/riscv/kernel/copy-unaligned.S
 create mode 100644 arch/riscv/kernel/copy-unaligned.h
 create mode 100644 arch/riscv/kernel/pi/fdt_early.c
 create mode 100644 drivers/cache/Kconfig
 create mode 100644 drivers/cache/Makefile
 create mode 100644 drivers/cache/ax45mp_cache.c
 create mode 100644 drivers/firmware/efi/libstub/kaslr.c
