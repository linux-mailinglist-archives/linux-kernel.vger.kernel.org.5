Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275B87E57D9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344697AbjKHNMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbjKHNMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:12:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6427F1BEB;
        Wed,  8 Nov 2023 05:12:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499BFC433C8;
        Wed,  8 Nov 2023 13:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699449168;
        bh=4l7GHlXsAQzVJfA7cAayRWfC9ToGc+fHh8uZB+a2AK4=;
        h=From:To:Cc:Subject:Date:From;
        b=tolhG/79osyzjTlNoJC8SsgmTGCMCHfU0onkslQPKSECWUMSvSYvFGCPMvL3SnOCX
         cvxFyudFbCcIBo7nd7oVLrxYeQjQAzyvKoJf9ryS75zr9eI35K40flTZEGQJpvQNqp
         Usih9EVoerh3BADTFwUmjPJCCoyPO1zd/y4xbU8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.62
Date:   Wed,  8 Nov 2023 14:12:44 +0100
Message-ID: <2023110844-dial-blouse-7644@gregkh>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.1.62 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                        |    2 
 arch/loongarch/mm/init.c                        |    9 
 arch/powerpc/kernel/head_85xx.S                 |    2 
 arch/powerpc/kernel/setup-common.c              |    2 
 arch/powerpc/mm/mem.c                           |    1 
 arch/x86/kvm/svm/svm.c                          |    3 
 drivers/dma/ste_dma40.c                         |    1 
 drivers/firmware/efi/efi.c                      |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c         |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c     |    5 
 drivers/gpu/drm/ttm/ttm_device.c                |    8 
 drivers/hwtracing/coresight/coresight-tmc-etr.c |    3 
 drivers/input/mouse/synaptics.c                 |    1 
 drivers/input/rmi4/rmi_smbus.c                  |   50 ++-
 drivers/irqchip/irq-riscv-intc.c                |   10 
 drivers/irqchip/irq-stm32-exti.c                |    1 
 drivers/misc/pci_endpoint_test.c                |    4 
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c      |    2 
 drivers/net/usb/r8152.c                         |    7 
 drivers/pci/quirks.c                            |    8 
 drivers/platform/mellanox/mlxbf-tmfifo.c        |   21 -
 drivers/power/supply/power_supply_core.c        |    8 
 drivers/scsi/mpt3sas/mpt3sas_scsih.c            |    4 
 drivers/spi/spi-npcm-fiu.c                      |    5 
 drivers/tty/n_gsm.c                             |    2 
 drivers/tty/serial/8250/8250_pci.c              |  327 +++++++++++++++++++++++-
 drivers/usb/gadget/legacy/raw_gadget.c          |   26 +
 drivers/usb/storage/unusual_cypress.h           |    2 
 drivers/usb/typec/tcpm/tcpm.c                   |    3 
 drivers/video/fbdev/aty/atyfb_base.c            |    4 
 drivers/video/fbdev/omap/omapfb_main.c          |    4 
 drivers/video/fbdev/uvesafb.c                   |    2 
 fs/ceph/mds_client.c                            |    2 
 fs/ntfs3/attrib.c                               |    6 
 fs/ntfs3/attrlist.c                             |   15 -
 fs/ntfs3/bitmap.c                               |    3 
 fs/ntfs3/dir.c                                  |    6 
 fs/ntfs3/frecord.c                              |    8 
 fs/ntfs3/fslog.c                                |    6 
 fs/ntfs3/fsntfs.c                               |   13 
 fs/ntfs3/super.c                                |    2 
 include/drm/gpu_scheduler.h                     |    3 
 include/linux/pci_ids.h                         |    1 
 include/linux/power_supply.h                    |    2 
 io_uring/rw.c                                   |    2 
 mm/mempolicy.c                                  |    4 
 mm/mmap.c                                       |   15 +
 net/netfilter/nf_tables_api.c                   |   50 ++-
 net/netfilter/nfnetlink_log.c                   |    2 
 net/sched/cls_u32.c                             |    2 
 sound/hda/intel-dsp-config.c                    |    6 
 sound/soc/codecs/rt5645.c                       |    2 
 sound/soc/codecs/tas2780.c                      |    2 
 sound/soc/codecs/tlv320adc3xxx.c                |    4 
 sound/soc/generic/simple-card.c                 |    6 
 sound/soc/sof/sof-pci-dev.c                     |    7 
 sound/usb/quirks.c                              |    2 
 tools/perf/util/evlist.c                        |    5 
 tools/testing/selftests/netfilter/nft_audit.sh  |   46 +++
 59 files changed, 619 insertions(+), 143 deletions(-)

Al Viro (2):
      io_uring: kiocb_done() should *not* trust ->ki_pos if ->{read,write}_iter() failed
      ceph_wait_on_conflict_unlink(): grab reference before dropping ->d_lock

Andrey Konovalov (1):
      usb: raw-gadget: properly handle interrupted requests

Antoine Gennart (1):
      ASoC: tlv320adc3xxx: BUG: Correct micbias setting

Anup Patel (1):
      irqchip/riscv-intc: Mark all INTC nodes as initialized

Arnd Bergmann (1):
      fbdev: atyfb: only use ioremap_uc() on i386 and ia64

Ben Wolsieffer (1):
      irqchip/stm32-exti: add missing DT IRQ flag translation

Cameron Williams (9):
      tty: 8250: Remove UC-257 and UC-431
      tty: 8250: Add support for additional Brainboxes UC cards
      tty: 8250: Add support for Brainboxes UP cards
      tty: 8250: Add support for Intashield IS-100
      tty: 8250: Fix port count of PX-257
      tty: 8250: Fix up PX-803/PX-857
      tty: 8250: Add support for additional Brainboxes PX cards
      tty: 8250: Add support for Intashield IX cards
      tty: 8250: Add Brainboxes Oxford Semiconductor-based quirks

Christophe Leroy (1):
      powerpc/85xx: Fix math emulation exception

Dan Carpenter (1):
      fbdev: omapfb: fix some error codes

Daniel Starke (1):
      tty: n_gsm: fix race condition in status line change on dead connections

Dmitry Torokhov (1):
      Input: synaptics-rmi4 - handle reset delay when using SMBus trsnsport

Douglas Anderson (2):
      r8152: Check for unplug in rtl_phy_patch_request()
      r8152: Check for unplug in r8153b_ups_en() / r8153c_ups_en()

Felix Kuehling (1):
      drm/amdgpu: Reserve fences for VM update

Florian Westphal (1):
      netfilter: nfnetlink_log: silence bogus compiler warning

Gabriel Marcano (1):
      fs/ntfs3: Fix directory element type detection

Greg Kroah-Hartman (1):
      Linux 6.1.62

Gustavo A. R. Silva (1):
      net: sched: cls_u32: Fix allocation size in u32_init()

Huacai Chen (2):
      LoongArch: Export symbol invalid_pud_table for modules building
      LoongArch: Replace kmap_atomic() with kmap_local_page() in copy_user_highpage()

Ian Rogers (1):
      perf evlist: Avoid frequency mode for the dummy event

Jimmy Hu (1):
      usb: typec: tcpm: Fix NULL pointer dereference in tcpm_pd_svdm()

Jorge Maidana (1):
      fbdev: uvesafb: Call cn_del_callback() at the end of uvesafb_exit()

Kai-Heng Feng (1):
      power: supply: core: Use blocking_notifier_call_chain to avoid RCU complaint

Karolina Stolarek (1):
      drm/ttm: Reorder sys manager cleanup step

Konstantin Komarov (5):
      fs/ntfs3: Add ckeck in ni_update_parent()
      fs/ntfs3: Write immediately updated ntfs state
      fs/ntfs3: Use kvmalloc instead of kmalloc(... __GFP_NOWARN)
      fs/ntfs3: Fix possible NULL-ptr-deref in ni_readpage_cmpr()
      fs/ntfs3: Fix NULL pointer dereference on error in attr_allocate_frame()

Kuan-Wei Chiu (1):
      efi: fix memory leak in krealloc failure handling

Kuninori Morimoto (1):
      ASoC: simple-card: fixup asoc_simple_probe() error handling

Liam R. Howlett (2):
      mm/mempolicy: fix set_mempolicy_home_node() previous VMA pointer
      mmap: fix error paths with dup_anon_vma()

LihaSika (1):
      usb: storage: set 1.50 as the lower bcdDevice for older "Super Top" compatibility

Liming Sun (1):
      platform/mellanox: mlxbf-tmfifo: Fix a warning message

Luben Tuikov (2):
      drm/amdgpu: Unset context priority is now invalid
      gpu/drm: Eliminate DRM_SCHED_PRIORITY_UNSET

Mark Hasemeyer (2):
      ALSA: hda: intel-dsp-config: Fix JSL Chromebook quirk detection
      ASoC: SOF: sof-pci-dev: Fix community key quirk detection

Max McCarthy (1):
      ALSA: usb-audio: add quirk flag to enable native DSD for McIntosh devices

Maxim Levitsky (1):
      x86: KVM: SVM: always update the x2avic msr interception

Michael Ellerman (1):
      powerpc/mm: Fix boot crash with FLATMEM

Phil Sutter (1):
      netfilter: nf_tables: audit log object reset once per table

Roy Chateau (1):
      ASoC: codecs: tas2780: Fix log of failed reset via I2C.

Shuming Fan (1):
      ASoC: rt5650: fix the wrong result of key button

Siddharth Vadapalli (1):
      misc: pci_endpoint_test: Add deviceID for J721S2 PCIe EP device support

Su Hui (2):
      fs/ntfs3: Avoid possible memory leak
      net: chelsio: cxgb4: add an error code check in t4_load_phy_fw

Suzuki K Poulose (1):
      coresight: tmc-etr: Disable warnings for allocation failures

Tomas Henzl (1):
      scsi: mpt3sas: Fix in error path

Vicki Pfau (1):
      PCI: Prevent xHCI driver from claiming AMD VanGogh USB3 DRD device

William A. Kennington III (1):
      spi: npcm-fiu: Fix UMA reads when dummy.nbytes == 0

Zhang Shurong (1):
      dmaengine: ste_dma40: Fix PM disable depth imbalance in d40_probe

