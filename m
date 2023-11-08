Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCE77E5476
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344568AbjKHKt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344524AbjKHKtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:49:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8829125B1;
        Wed,  8 Nov 2023 02:46:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC66C433C8;
        Wed,  8 Nov 2023 10:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699440369;
        bh=YE6GCv78KUa/wP5Sk76BCR1jyHgDlTYiHYVhimAPtQ4=;
        h=From:To:Cc:Subject:Date:From;
        b=vANxCb6dgZRJbhtnauvLLDvE0CqbVC3SzwgQuVfogxdLxh6N385vvs33Qw1hDKYNA
         OCnGI8BpatMZvcdaujEe33+mlUM1EkmSkd4DbtdPK598zaEnjJK3gxdHTBd31AQoVz
         SC5SkSqlc2E9C7mGGNhpOSP9MQooAesD01K5dZIg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.298
Date:   Wed,  8 Nov 2023 11:46:00 +0100
Message-ID: <2023110800-freedom-unwanted-8384@gregkh>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 4.19.298 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 MAINTAINERS                                                            |    2 
 Makefile                                                               |    2 
 arch/arm/boot/bootp/init.S                                             |    2 
 arch/arm/boot/compressed/big-endian.S                                  |    2 
 arch/arm/boot/compressed/head.S                                        |    2 
 arch/arm/boot/compressed/piggy.S                                       |    2 
 arch/arm/mm/proc-arm1020.S                                             |    2 
 arch/arm/mm/proc-arm1020e.S                                            |    2 
 arch/arm/mm/proc-arm1022.S                                             |    2 
 arch/arm/mm/proc-arm1026.S                                             |    2 
 arch/arm/mm/proc-arm720.S                                              |    2 
 arch/arm/mm/proc-arm740.S                                              |    2 
 arch/arm/mm/proc-arm7tdmi.S                                            |    2 
 arch/arm/mm/proc-arm920.S                                              |    2 
 arch/arm/mm/proc-arm922.S                                              |    2 
 arch/arm/mm/proc-arm925.S                                              |    2 
 arch/arm/mm/proc-arm926.S                                              |    2 
 arch/arm/mm/proc-arm940.S                                              |    2 
 arch/arm/mm/proc-arm946.S                                              |    2 
 arch/arm/mm/proc-arm9tdmi.S                                            |    2 
 arch/arm/mm/proc-fa526.S                                               |    2 
 arch/arm/mm/proc-feroceon.S                                            |    2 
 arch/arm/mm/proc-mohawk.S                                              |    2 
 arch/arm/mm/proc-sa110.S                                               |    2 
 arch/arm/mm/proc-sa1100.S                                              |    2 
 arch/arm/mm/proc-v6.S                                                  |    2 
 arch/arm/mm/proc-v7.S                                                  |    2 
 arch/arm/mm/proc-v7m.S                                                 |    4 
 arch/arm/mm/proc-xsc3.S                                                |    2 
 arch/arm/mm/proc-xscale.S                                              |    2 
 arch/arm64/kernel/armv8_deprecated.c                                   |    6 
 arch/x86/include/asm/i8259.h                                           |    2 
 arch/x86/include/asm/setup.h                                           |   46 
 arch/x86/kernel/acpi/boot.c                                            |    3 
 arch/x86/kernel/i8259.c                                                |   38 
 arch/x86/kernel/vmlinux.lds.S                                          |    2 
 drivers/ata/ahci.h                                                     |  232 
 drivers/base/driver.c                                                  |   69 
 drivers/base/platform.c                                                |   28 
 drivers/block/Kconfig                                                  |    9 
 drivers/block/Makefile                                                 |    2 
 drivers/block/sx8.c                                                    | 1746 --
 drivers/dma/ste_dma40.c                                                |    1 
 drivers/gpu/drm/drm_dp_mst_topology.c                                  |    6 
 drivers/i2c/busses/i2c-stm32f7.c                                       |    9 
 drivers/i2c/muxes/i2c-demux-pinctrl.c                                  |    2 
 drivers/i2c/muxes/i2c-mux-gpmux.c                                      |    2 
 drivers/i2c/muxes/i2c-mux-pinctrl.c                                    |    2 
 drivers/iio/adc/exynos_adc.c                                           |   24 
 drivers/input/mouse/synaptics.c                                        |    1 
 drivers/input/rmi4/rmi_smbus.c                                         |   50 
 drivers/input/serio/i8042-x86ia64io.h                                  |    8 
 drivers/irqchip/irq-stm32-exti.c                                       |    1 
 drivers/mcb/mcb-lpc.c                                                  |   35 
 drivers/mcb/mcb-parse.c                                                |   15 
 drivers/mmc/core/sdio.c                                                |   22 
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c                             |    2 
 drivers/net/ethernet/intel/i40e/i40e_txrx.c                            |    2 
 drivers/net/ethernet/intel/igb/igb_ethtool.c                           |    6 
 drivers/net/ethernet/realtek/Makefile                                  |    1 
 drivers/net/ethernet/realtek/r8169.c                                   | 7698 ----------
 drivers/net/ethernet/realtek/r8169_main.c                              | 7698 ++++++++++
 drivers/net/ethernet/toshiba/ps3_gelic_wireless.c                      |    2 
 drivers/net/gtp.c                                                      |    5 
 drivers/nvmem/imx-ocotp.c                                              |    4 
 drivers/pci/quirks.c                                                   |    8 
 drivers/platform/x86/asus-wmi.h                                        |    2 
 drivers/rpmsg/qcom_glink_native.c                                      |    1 
 drivers/rpmsg/rpmsg_core.c                                             |   37 
 drivers/rpmsg/rpmsg_internal.h                                         |    5 
 drivers/scsi/mpt3sas/mpt3sas_scsih.c                                   |    4 
 drivers/tty/serial/8250/8250_pci.c                                     |  122 
 drivers/usb/storage/unusual_cypress.h                                  |    2 
 drivers/video/fbdev/aty/atyfb_base.c                                   |    4 
 drivers/video/fbdev/uvesafb.c                                          |    2 
 drivers/virtio/virtio_balloon.c                                        |    6 
 drivers/virtio/virtio_mmio.c                                           |   19 
 fs/cifs/smbdirect.c                                                    |   14 
 fs/f2fs/gc.c                                                           |    3 
 fs/nfs/write.c                                                         |    3 
 fs/nfsd/vfs.c                                                          |   12 
 include/linux/device.h                                                 |    2 
 include/linux/pci_ids.h                                                |    1 
 include/linux/platform_device.h                                        |    6 
 include/linux/rpmsg.h                                                  |   14 
 kernel/events/core.c                                                   |    3 
 lib/kobject.c                                                          |   12 
 net/netfilter/nfnetlink_log.c                                          |    2 
 sound/soc/codecs/rt5645.c                                              |    2 
 sound/soc/generic/simple-card.c                                        |    6 
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc |   13 
 91 files changed, 8376 insertions(+), 9770 deletions(-)

Al Viro (1):
      nfsd: lock_rename() needs both directories to live on the same fs

Alain Volmat (1):
      i2c: stm32f7: Fix PEC handling in case of SMBUS transfers

Arnd Bergmann (2):
      fbdev: atyfb: only use ioremap_uc() on i386 and ia64
      ata: ahci: fix enum constants for gcc-13

Ben Wolsieffer (1):
      irqchip/stm32-exti: add missing DT IRQ flag translation

Bjorn Andersson (1):
      rpmsg: glink: Release driver_override

Cameron Williams (4):
      tty: 8250: Remove UC-257 and UC-431
      tty: 8250: Add support for additional Brainboxes UC cards
      tty: 8250: Add support for Brainboxes UP cards
      tty: 8250: Add support for Intashield IS-100

Chao Yu (1):
      f2fs: fix to do sanity check on inode type during garbage collection

Christoph Hellwig (1):
      remove the sx8 block driver

Denis Efremov (1):
      MAINTAINERS: r8169: Update path to the driver

Dmitry Torokhov (1):
      Input: synaptics-rmi4 - handle reset delay when using SMBus trsnsport

Florian Westphal (1):
      netfilter: nfnetlink_log: silence bogus compiler warning

Francis Laniel (1):
      selftests/ftrace: Add new test case which checks non unique symbol

Gavin Shan (1):
      virtio_balloon: Fix endless deflation and inflation on arm64

Greg Kroah-Hartman (1):
      Linux 4.19.298

Haibo Chen (1):
      mmc: core: sdio: hold retuning if sdio in 1-bit mode

Hangyu Hua (1):
      rpmsg: Fix possible refcount leak in rpmsg_register_device_override()

Hans de Goede (1):
      platform/x86: asus-wmi: Change ASUS_WMI_BRN_DOWN code from 0x20 to 0x2e

Heiner Kallweit (1):
      r8169: rename r8169.c to r8169_main.c

Herve Codina (3):
      i2c: muxes: i2c-mux-pinctrl: Use of_get_i2c_adapter_by_node()
      i2c: muxes: i2c-mux-gpmux: Use of_get_i2c_adapter_by_node()
      i2c: muxes: i2c-demux-pinctrl: Use of_get_i2c_adapter_by_node()

Ivan Vecera (1):
      i40e: Fix wrong check for I40E_TXR_FLAGS_WB_ON_ITR

Jinjie Ruan (1):
      arm64: fix a concurrency issue in emulation_proc_handler()

Jorge Maidana (1):
      fbdev: uvesafb: Call cn_del_callback() at the end of uvesafb_exit()

Josh Poimboeuf (2):
      x86/mm: Simplify RESERVE_BRK()
      x86/mm: Fix RESERVE_BRK() for older binutils

Juergen Gross (1):
      x86: Fix .brk attribute in linker script

Krzysztof Kozlowski (4):
      driver: platform: Add helper for safer setting of driver_override
      rpmsg: Constify local variable in field store macro
      rpmsg: Fix kfree() of static memory on setting driver_override
      rpmsg: Fix calling device_lock() on non-initialized device

Kuninori Morimoto (1):
      ASoC: simple-card: fixup asoc_simple_probe() error handling

Kunwu Chan (1):
      treewide: Spelling fix in comment

LihaSika (1):
      usb: storage: set 1.50 as the lower bcdDevice for older "Super Top" compatibility

Lukasz Majczak (1):
      drm/dp_mst: Fix NULL deref in get_mst_branch_device_by_guid_helper()

Marek Szyprowski (1):
      iio: exynos-adc: request second interupt only when touchscreen mode is used

Mateusz Palczewski (1):
      igb: Fix potential memory leak in igb_add_ethtool_nfc_entry

Maximilian Heyne (1):
      virtio-mmio: fix memory leak of vm_dev

Mirsad Goran Todorovac (2):
      r8169: fix the KCSAN reported data-race in rtl_tx while reading TxDescArray[entry].opts1
      r8169: fix the KCSAN reported data race in rtl_rx while reading desc->opts1

Nick Desaulniers (1):
      ARM: 8933/1: replace Sun/Solaris style flag on section directive

Pablo Neira Ayuso (1):
      gtp: fix fragmentation needed check with gso

Peng Fan (2):
      nvmem: imx: correct nregs for i.MX6SLL
      nvmem: imx: correct nregs for i.MX6UL

Peter Zijlstra (1):
      perf/core: Fix potential NULL deref

Rodríguez Barbarin, José Javier (2):
      mcb: Return actual parsed size when reading chameleon table
      mcb-lpc: Reallocate memory region to avoid memory overlapping

Shuming Fan (1):
      ASoC: rt5650: fix the wrong result of key button

Steve French (1):
      smbdirect: missing rc checks while waiting for rdma events

Su Hui (1):
      net: chelsio: cxgb4: add an error code check in t4_load_phy_fw

Szilard Fabian (1):
      Input: i8042 - add Fujitsu Lifebook E5411 to i8042 quirk table

Thomas Gleixner (1):
      x86/i8259: Skip probing when ACPI/MADT advertises PCAT compatibility

Tomas Henzl (1):
      scsi: mpt3sas: Fix in error path

Trond Myklebust (1):
      NFS: Don't call generic_error_remove_page() while holding locks

Ulf Hansson (1):
      mmc: sdio: Don't re-initialize powered-on removable SDIO cards at resume

Vicki Pfau (1):
      PCI: Prevent xHCI driver from claiming AMD VanGogh USB3 DRD device

Wang Hai (1):
      kobject: Fix slab-out-of-bounds in fill_kobj_path()

Zhang Shurong (1):
      dmaengine: ste_dma40: Fix PM disable depth imbalance in d40_probe

