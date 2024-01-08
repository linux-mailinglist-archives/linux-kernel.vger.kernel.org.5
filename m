Return-Path: <linux-kernel+bounces-19877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF3A827602
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF3B1C2130C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D58A53E2F;
	Mon,  8 Jan 2024 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCrr3EGr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04B54670
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 17:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5edbcdc323dso17251527b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 09:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704733549; x=1705338349; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OR6p+geAPxLrHf088YgIuG4gX0Vyo6TqOMzIo/r/fuM=;
        b=iCrr3EGr5ERWG4hEEnVHA9q4E1PbMBqdhmEt/tQ0wsvPOXlDI+pfXMv4VHiO7N6Amy
         7jCKAYqZc97tppeKyo4CVGfyrPZYX7R8A0bRmU/s+lUHc+oocSt/4FRT4QyTZ2rXTtpA
         WDiFYhzhWxwVuPB7VwIA76PNS87irRdJyxTl/AzM71jk/sv5LyGKuFvdUpkLhFdv+YPg
         zPkdeaQwfrhK6BqGtH1sdWynjMZAjCZCwEbg2SMPspDNiQbKrcPNUpEutY03Ak3ZH2BO
         Vnl9cg3rktmRIIqC10Dx+g9ckFsVcWmiLx1MAliM4csFDMgpPe0OPmBA/1BabI9FAgWG
         MQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704733549; x=1705338349;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OR6p+geAPxLrHf088YgIuG4gX0Vyo6TqOMzIo/r/fuM=;
        b=BZ9kFX0drv9MT+uf4uu9cluyQisOqUO3hTPyYsjE4BRPEkvgv/HXtVT1DfK7OhHgn6
         VjGjtV0kFff5NKS9lVQq/Zyxehl/iVrRefcCrMiNFOCjIWeoNxRAnvepxbAkl+TMeCaD
         3I987thEBF7hBC+SkmFJ1Q+xLYWjk2oPiC2VUDYQ8wdWdyq4pXGth0xQFlnABNFzl+5Z
         A4A7nycUpznQo5W6SKOKEciqAisX5LbDKNjJvatracspOb/ZJ3lijmZg4NVLU0KHY7gO
         Ekij5V/f81Jm6Xw+HMxIGgBL23PHJ3cwdq3lq/M2Ll7U6lljaKkoUq97lSQ5nobxBaTU
         fVtQ==
X-Gm-Message-State: AOJu0Yw8RxmkOTefsiyq8Fm+OQZUl+y0EcdnUQRbSwk54T6joKwN1DOt
	w/mHE3Y15L7KNNnNybQvnzA=
X-Google-Smtp-Source: AGHT+IF347fIWzKdWAfkpdRQU18SKZPCwCQnCEKD7dU1eqL418yTiTW0iNiXbkKw/v/MvdReH65hJg==
X-Received: by 2002:a0d:e649:0:b0:5e5:6aa2:a88f with SMTP id p70-20020a0de649000000b005e56aa2a88fmr2452086ywe.56.1704733549119;
        Mon, 08 Jan 2024 09:05:49 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:4c52:8def:a93c:4b38])
        by smtp.gmail.com with ESMTPSA id v63-20020a0dd342000000b005f14c87b271sm26417ywd.53.2024.01.08.09.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 09:05:48 -0800 (PST)
Date: Mon, 8 Jan 2024 09:05:48 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Guanjun <guanjun@linux.alibaba.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Oliver Neukum <oneukum@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sean Christopherson <seanjc@google.com>,
	Takashi Iwai <tiwai@suse.de>, Tony Lu <tonylu@linux.alibaba.com>,
	Vinod Koul <vkoul@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wei Liu <wei.liu@kernel.org>, Wen Gu <guwen@linux.alibaba.com>,
	Will Deacon <will@kernel.org>
Subject: [GIT PULL] bitmap patches for v6.8
Message-ID: <ZZwrbDUe4VQRYv5I@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 33cc938e65a98f1d29d0a18403dbbee050dcad9a:

  Linux 6.7-rc4 (2023-12-03 18:52:56 +0900)

are available in the Git repository at:

  https://github.com/norov/linux.git/ tags/bitmap-for-6.8

for you to fetch changes up to 071ad962baf5e857fd965595421cf6fb588610ed:

  bitmap: Step down as a reviewer (2024-01-01 12:50:08 -0800)

----------------------------------------------------------------
Hi Linus,

Please pull bitmap patches for v6.8.

There is a couple of random cleanup patches, and the rest of the request
is a series adding atomic find_bit() operations:

https://patchwork.kernel.org/project/linux-media/cover/20231212022749.625238-1-yury.norov@gmail.com/

Most of the patches are arch and drivers code where transition to the
new API is straightforward. And most of them (~20/35) are reviewed by
corresponding maintainers. For less actively supported subsystems I
didn't receive a feedback.

Many people asked to pull patches for their drivers together with the
head patch of the series. And because the transition is quite clean,
I decided to move the whole series in this request, including that
unreviewed material. Please let me know if it doesn't work for you,
and I'll resend it with the only reviewed patches.

Thanks,
        Yury

----------------------------------------------------------------
Andy Shevchenko (1):
      bitmap: Step down as a reviewer

Guanjun (1):
      lib/find_bit: Fix the code comments about find_next_bit_wrap

Yury Norov (36):
      lib/find: optimize find_*_bit_wrap
      lib/find: add atomic find_bit() primitives
      lib/find: add test for atomic find_bit() ops
      lib/sbitmap; optimize __sbitmap_get_word() by using find_and_set_bit()
      watch_queue: optimize post_one_notification() by using find_and_clear_bit()
      sched: add cpumask_find_and_set() and use it in __mm_cid_get()
      mips: sgi-ip30: optimize heart_alloc_int() by using find_and_set_bit()
      sparc: optimize alloc_msi() by using find_and_set_bit()
      perf/arm: use atomic find_bit() API
      drivers/perf: optimize ali_drw_get_counter_idx() by using find_and_set_bit()
      dmaengine: idxd: optimize perfmon_assign_event()
      ath10k: optimize ath10k_snoc_napi_poll()
      wifi: rtw88: optimize the driver by using atomic iterator
      KVM: x86: hyper-v: optimize and cleanup kvm_hv_process_stimers()
      PCI: hv: Optimize hv_get_dom_num() by using find_and_set_bit()
      scsi: core: optimize scsi_evt_emit() by using an atomic iterator
      scsi: mpi3mr: optimize the driver by using find_and_set_bit()
      scsi: qedi: optimize qedi_get_task_idx() by using find_and_set_bit()
      powerpc: optimize arch code by using atomic find_bit() API
      iommu: optimize subsystem by using atomic find_bit() API
      media: radio-shark: optimize the driver by using atomic find_bit() API
      sfc: optimize the driver by using atomic find_bit() API
      tty: nozomi: optimize interrupt_handler()
      usb: cdc-acm: optimize acm_softint()
      block: null_blk: replace get_tag() with a generic find_and_set_bit_lock()
      RDMA/rtrs: optimize __rtrs_get_permit() by using find_and_set_bit_lock()
      mISDN: optimize get_free_devid()
      media: em28xx: cx231xx: optimize drivers by using find_and_set_bit()
      ethernet: rocker: optimize ofdpa_port_internal_vlan_id_get()
      serial: sc12is7xx: optimize sc16is7xx_alloc_line()
      bluetooth: optimize cmtp_alloc_block_id()
      net: smc: optimize smc_wr_tx_get_free_slot_index()
      ALSA: use atomic find_bit() functions where applicable
      m68k: optimize get_mmu_context()
      microblaze: optimize get_mmu_context()
      sh: mach-x3proto: optimize ilsel_enable()

 MAINTAINERS                                  |   1 -
 arch/m68k/include/asm/mmu_context.h          |  11 +-
 arch/microblaze/include/asm/mmu_context_mm.h |  11 +-
 arch/mips/sgi-ip30/ip30-irq.c                |  12 +-
 arch/powerpc/mm/book3s32/mmu_context.c       |  10 +-
 arch/powerpc/platforms/pasemi/dma_lib.c      |  45 +---
 arch/powerpc/platforms/powernv/pci-sriov.c   |  12 +-
 arch/sh/boards/mach-x3proto/ilsel.c          |   4 +-
 arch/sparc/kernel/pci_msi.c                  |   9 +-
 arch/x86/kvm/hyperv.c                        |  40 ++--
 drivers/block/null_blk/main.c                |  41 ++--
 drivers/dma/idxd/perfmon.c                   |   8 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       |  15 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.h        |  10 +-
 drivers/iommu/msm_iommu.c                    |  18 +-
 drivers/isdn/mISDN/core.c                    |   9 +-
 drivers/media/radio/radio-shark.c            |   5 +-
 drivers/media/radio/radio-shark2.c           |   5 +-
 drivers/media/usb/cx231xx/cx231xx-cards.c    |  16 +-
 drivers/media/usb/em28xx/em28xx-cards.c      |  37 ++--
 drivers/net/ethernet/rocker/rocker_ofdpa.c   |  11 +-
 drivers/net/ethernet/sfc/rx_common.c         |   4 +-
 drivers/net/ethernet/sfc/siena/rx_common.c   |   4 +-
 drivers/net/ethernet/sfc/siena/siena_sriov.c |  14 +-
 drivers/net/wireless/ath/ath10k/snoc.c       |   9 +-
 drivers/net/wireless/realtek/rtw88/pci.c     |   5 +-
 drivers/net/wireless/realtek/rtw89/pci.c     |   5 +-
 drivers/pci/controller/pci-hyperv.c          |   7 +-
 drivers/perf/alibaba_uncore_drw_pmu.c        |  10 +-
 drivers/perf/arm-cci.c                       |  24 +--
 drivers/perf/arm-ccn.c                       |  10 +-
 drivers/perf/arm_dmc620_pmu.c                |   9 +-
 drivers/perf/arm_pmuv3.c                     |   8 +-
 drivers/scsi/mpi3mr/mpi3mr_os.c              |  21 +-
 drivers/scsi/qedi/qedi_main.c                |   9 +-
 drivers/scsi/scsi_lib.c                      |   7 +-
 drivers/tty/nozomi.c                         |   5 +-
 drivers/tty/serial/sc16is7xx.c               |   8 +-
 drivers/usb/class/cdc-acm.c                  |   5 +-
 include/linux/cpumask.h                      |  12 ++
 include/linux/find.h                         | 301 ++++++++++++++++++++++++++-
 kernel/sched/sched.h                         |  14 +-
 kernel/watch_queue.c                         |   6 +-
 lib/find_bit.c                               |  85 ++++++++
 lib/sbitmap.c                                |  46 +---
 lib/test_bitmap.c                            |  61 ++++++
 net/bluetooth/cmtp/core.c                    |  10 +-
 net/smc/smc_wr.c                             |  10 +-
 sound/pci/hda/hda_codec.c                    |   7 +-
 sound/usb/caiaq/audio.c                      |  13 +-
 50 files changed, 635 insertions(+), 424 deletions(-)

