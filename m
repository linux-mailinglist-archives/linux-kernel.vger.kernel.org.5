Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD317E57D3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344673AbjKHNLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344568AbjKHNLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:11:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62071BEB;
        Wed,  8 Nov 2023 05:11:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40A1C433C9;
        Wed,  8 Nov 2023 13:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699449069;
        bh=Yn153Fe4FS2r8ky/HQ3jpaZ5mhIqiOi6WxGrdkUfQWo=;
        h=From:To:Cc:Subject:Date:From;
        b=kzLF2A69VGbbyIce+G4tvS5ORBbt7BEmWfsVLc5qJWMk4QXkzvaeEcpw6FH0QRASl
         xVptW5WSxVvNZHfV6RuMZu5QHnp1P2unx/DOgl/LhXNRzW47aPPSCL+77i+4A+lxEI
         nwTa6dkW1hbB+aY7uTPyPNzVIOJYNYo+Gf6+xU2g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.5.11
Date:   Wed,  8 Nov 2023 14:11:04 +0100
Message-ID: <2023110804-lather-basket-a050@gregkh>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.5.11 kernel.

All users of the 6.5 kernel series must upgrade.

The updated 6.5.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.5.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/serial/rs485.yaml       |    4 
 Makefile                                                  |    2 
 arch/arm64/boot/dts/freescale/imx93.dtsi                  |    4 
 arch/loongarch/include/asm/io.h                           |    5 
 arch/loongarch/include/asm/linkage.h                      |    8 
 arch/loongarch/include/asm/pgtable-bits.h                 |    4 
 arch/loongarch/kernel/entry.S                             |    4 
 arch/loongarch/kernel/genex.S                             |   16 
 arch/loongarch/kernel/setup.c                             |   10 
 arch/loongarch/mm/init.c                                  |    9 
 arch/loongarch/mm/tlbex.S                                 |   36 -
 arch/powerpc/kernel/head_85xx.S                           |    2 
 arch/powerpc/kernel/setup-common.c                        |    2 
 arch/powerpc/mm/mem.c                                     |    1 
 arch/riscv/boot/dts/thead/th1520.dtsi                     |    1 
 arch/s390/boot/vmem.c                                     |    7 
 drivers/ata/pata_parport/fit3.c                           |   14 
 drivers/ata/pata_parport/pata_parport.c                   |   68 ++
 drivers/bluetooth/hci_bcm4377.c                           |    5 
 drivers/dma/ste_dma40.c                                   |    1 
 drivers/firmware/efi/efi.c                                |    8 
 drivers/firmware/efi/libstub/x86-stub.c                   |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c                   |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c               |    5 
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c             |    3 
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c             |    3 
 drivers/gpu/drm/ttm/ttm_device.c                          |    8 
 drivers/hwtracing/coresight/coresight-tmc-etr.c           |    3 
 drivers/input/mouse/synaptics.c                           |    1 
 drivers/input/rmi4/rmi_smbus.c                            |   50 +-
 drivers/irqchip/irq-riscv-intc.c                          |   10 
 drivers/irqchip/irq-stm32-exti.c                          |    1 
 drivers/media/i2c/ov8858.c                                |   10 
 drivers/misc/pci_endpoint_test.c                          |    4 
 drivers/net/can/flexcan/flexcan-core.c                    |   46 -
 drivers/net/can/flexcan/flexcan.h                         |    2 
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c                |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c   |   11 
 drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c      |   25 +
 drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h      |    3 
 drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_priv.h |    1 
 drivers/net/usb/r8152.c                                   |    7 
 drivers/pci/quirks.c                                      |    8 
 drivers/platform/mellanox/mlxbf-tmfifo.c                  |   21 
 drivers/power/supply/power_supply_core.c                  |    8 
 drivers/scsi/mpt3sas/mpt3sas_scsih.c                      |    4 
 drivers/spi/spi-npcm-fiu.c                                |    5 
 drivers/tty/n_gsm.c                                       |    2 
 drivers/tty/serial/8250/8250_pci.c                        |  327 +++++++++++++-
 drivers/tty/serial/serial_core.c                          |    2 
 drivers/usb/gadget/legacy/raw_gadget.c                    |   26 -
 drivers/usb/storage/unusual_cypress.h                     |    2 
 drivers/usb/typec/tcpm/tcpm.c                             |    5 
 drivers/video/fbdev/aty/atyfb_base.c                      |    4 
 drivers/video/fbdev/omap/omapfb_main.c                    |    4 
 drivers/video/fbdev/uvesafb.c                             |    2 
 fs/ceph/mds_client.c                                      |    2 
 fs/ntfs3/attrib.c                                         |    6 
 fs/ntfs3/attrlist.c                                       |   15 
 fs/ntfs3/bitmap.c                                         |    3 
 fs/ntfs3/dir.c                                            |    6 
 fs/ntfs3/frecord.c                                        |    8 
 fs/ntfs3/fslog.c                                          |    6 
 fs/ntfs3/fsntfs.c                                         |   13 
 fs/ntfs3/record.c                                         |   68 ++
 fs/ntfs3/super.c                                          |   33 +
 include/drm/gpu_scheduler.h                               |    3 
 include/linux/pci_ids.h                                   |    1 
 include/linux/power_supply.h                              |    2 
 include/sound/soc-dapm.h                                  |    1 
 include/sound/soc.h                                       |    2 
 io_uring/rw.c                                             |    2 
 mm/mmap.c                                                 |   40 +
 net/netfilter/nf_tables_api.c                             |   50 +-
 net/netfilter/nfnetlink_log.c                             |    2 
 net/sched/cls_u32.c                                       |    2 
 rust/kernel/types.rs                                      |   21 
 sound/hda/intel-dsp-config.c                              |    6 
 sound/soc/codecs/da7219-aad.c                             |   11 
 sound/soc/codecs/rt5645.c                                 |    2 
 sound/soc/codecs/tas2780.c                                |    2 
 sound/soc/codecs/tlv320adc3xxx.c                          |    4 
 sound/soc/fsl/fsl-asoc-card.c                             |   12 
 sound/soc/generic/simple-card.c                           |    6 
 sound/soc/intel/boards/sof_sdw.c                          |   10 
 sound/soc/soc-component.c                                 |    1 
 sound/soc/soc-core.c                                      |   20 
 sound/soc/soc-dapm.c                                      |   12 
 sound/soc/sof/sof-pci-dev.c                               |    7 
 sound/usb/quirks.c                                        |    2 
 tools/perf/util/evlist.c                                  |    5 
 tools/testing/selftests/netfilter/nft_audit.sh            |   46 +
 92 files changed, 972 insertions(+), 296 deletions(-)

Al Viro (2):
      io_uring: kiocb_done() should *not* trust ->ki_pos if ->{read,write}_iter() failed
      ceph_wait_on_conflict_unlink(): grab reference before dropping ->d_lock

Alice Ryhl (1):
      rust: make `UnsafeCell` the outer type in `Opaque`

Amadeusz Sławiński (1):
      ASoC: core: Do not call link_exit() on uninitialized rtd objects

Andrey Konovalov (1):
      usb: raw-gadget: properly handle interrupted requests

Antoine Gennart (1):
      ASoC: tlv320adc3xxx: BUG: Correct micbias setting

Anup Patel (1):
      irqchip/riscv-intc: Mark all INTC nodes as initialized

Arnd Bergmann (1):
      fbdev: atyfb: only use ioremap_uc() on i386 and ia64

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Add additional checks for contaminant

Ben Wolsieffer (1):
      irqchip/stm32-exti: add missing DT IRQ flag translation

Benno Lossin (1):
      rust: types: make `Opaque` be `!Unpin`

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

David Rau (1):
      ASoC: da7219: Correct the process of setting up Gnd switch in AAD

Dmitry Torokhov (1):
      Input: synaptics-rmi4 - handle reset delay when using SMBus trsnsport

Douglas Anderson (2):
      r8152: Check for unplug in rtl_phy_patch_request()
      r8152: Check for unplug in r8153b_ups_en() / r8153c_ups_en()

Felix Kuehling (1):
      drm/amdgpu: Reserve fences for VM update

Florian Westphal (1):
      netfilter: nfnetlink_log: silence bogus compiler warning

Francesco Dolcini (1):
      dt-bindings: serial: rs485: Add rs485-rts-active-high

Gabriel Marcano (1):
      fs/ntfs3: Fix directory element type detection

Greg Kroah-Hartman (1):
      Linux 6.5.11

Gustavo A. R. Silva (1):
      net: sched: cls_u32: Fix allocation size in u32_init()

Haibo Chen (2):
      arm64: dts: imx93: add the Flex-CAN stop mode by GPR
      can: flexcan: remove the auto stop mode for IMX93

Huacai Chen (2):
      LoongArch: Export symbol invalid_pud_table for modules building
      LoongArch: Replace kmap_atomic() with kmap_local_page() in copy_user_highpage()

Ian Rogers (1):
      perf evlist: Avoid frequency mode for the dummy event

Icenowy Zheng (1):
      LoongArch: Disable WUC for pgprot_writecombine() like ioremap_wc()

Janne Grunau (1):
      Bluetooth: hci_bcm4377: Mark bcm4378/bcm4387 as BROKEN_LE_CODED

Jimmy Hu (1):
      usb: typec: tcpm: Fix NULL pointer dereference in tcpm_pd_svdm()

Jisheng Zhang (1):
      riscv: dts: thead: set dma-noncoherent to soc bus

Jorge Maidana (1):
      fbdev: uvesafb: Call cn_del_callback() at the end of uvesafb_exit()

Kai-Heng Feng (1):
      power: supply: core: Use blocking_notifier_call_chain to avoid RCU complaint

Karolina Stolarek (1):
      drm/ttm: Reorder sys manager cleanup step

Konstantin Komarov (9):
      fs/ntfs3: Add ckeck in ni_update_parent()
      fs/ntfs3: Write immediately updated ntfs state
      fs/ntfs3: Use kvmalloc instead of kmalloc(... __GFP_NOWARN)
      fs/ntfs3: Add more attributes checks in mi_enum_attr()
      fs/ntfs3: Fix alternative boot searching
      fs/ntfs3: Add more info into /proc/fs/ntfs3/<dev>/volinfo
      fs/ntfs3: Do not allow to change label if volume is read-only
      fs/ntfs3: Fix possible NULL-ptr-deref in ni_readpage_cmpr()
      fs/ntfs3: Fix NULL pointer dereference on error in attr_allocate_frame()

Krzysztof Kozlowski (1):
      ASoC: soc-dapm: Add helper for comparing widget name

Kuan-Wei Chiu (1):
      efi: fix memory leak in krealloc failure handling

Kuninori Morimoto (1):
      ASoC: simple-card: fixup asoc_simple_probe() error handling

Liam R. Howlett (2):
      mmap: fix vma_iterator in error path of vma_merge()
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

Michael Ellerman (1):
      powerpc/mm: Fix boot crash with FLATMEM

Nicholas Kazlauskas (1):
      drm/amd/display: Don't use fsleep for PSR exit waits

Nikolay Borisov (1):
      x86/efistub: Don't try to print after ExitBootService()

Ondrej Jirman (1):
      media: i2c: ov8858: Don't set fwnode in the driver

Ondrej Zary (2):
      ata: pata_parport: add custom version of wait_after_reset
      ata: pata_parport: fit3: implement IDE command set registers

Phil Sutter (1):
      netfilter: nf_tables: audit log object reset once per table

Pierre-Louis Bossart (1):
      ASoC: Intel: sof_sdw: add support for SKU 0B14

Roy Chateau (1):
      ASoC: codecs: tas2780: Fix log of failed reset via I2C.

Shengjiu Wang (1):
      ASoC: fsl-asoc-card: use integer type for fll_id and pll_id

Shuming Fan (1):
      ASoC: rt5650: fix the wrong result of key button

Siddharth Vadapalli (1):
      misc: pci_endpoint_test: Add deviceID for J721S2 PCIe EP device support

Su Hui (2):
      fs/ntfs3: Avoid possible memory leak
      net: chelsio: cxgb4: add an error code check in t4_load_phy_fw

Suzuki K Poulose (1):
      coresight: tmc-etr: Disable warnings for allocation failures

Tiezhu Yang (1):
      LoongArch: Use SYM_CODE_* to annotate exception handlers

Tomas Henzl (1):
      scsi: mpt3sas: Fix in error path

Tony Lindgren (1):
      serial: core: Fix runtime PM handling for pending tx

Vasily Gorbik (1):
      s390/kasan: handle DCSS mapping in memory holes

Vicki Pfau (1):
      PCI: Prevent xHCI driver from claiming AMD VanGogh USB3 DRD device

Vlad Buslov (1):
      net/mlx5: Bridge, fix peer entry ageing in LAG mode

William A. Kennington III (1):
      spi: npcm-fiu: Fix UMA reads when dummy.nbytes == 0

Zhang Shurong (1):
      dmaengine: ste_dma40: Fix PM disable depth imbalance in d40_probe

