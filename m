Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2535D7E5B43
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjKHQcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjKHQc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:32:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5D01BE5;
        Wed,  8 Nov 2023 08:32:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA0EC433C8;
        Wed,  8 Nov 2023 16:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699461146;
        bh=gz+jYRBjExZUgraVExE2tVh7u/pJOw5SiDvvavI2ktU=;
        h=From:To:Cc:Subject:Date:From;
        b=v4O6kFiSbaxTUkJNW5bkIGBQ+PV6GxhjqC+r4cwF8aJYEdoxOjLF04kerlcPTk4Z7
         BZe9kHMzq67FwOiH9pEENoGJDWXf1aBGczG0yeX0GkEobz+418Y/+YIzsI+ssNDIb1
         rVUzp6ka0JKxuwitxWKSBSNmUuAa0FitkRlCjvDY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.138
Date:   Wed,  8 Nov 2023 17:32:17 +0100
Message-ID: <2023110818-backstage-strung-facd@gregkh>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.15.138 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                          |    2 
 arch/powerpc/kernel/head_fsl_booke.S              |    2 
 arch/powerpc/kernel/setup-common.c                |    2 
 arch/powerpc/mm/mem.c                             |    1 
 arch/sparc/lib/checksum_32.S                      |    2 
 arch/x86/include/asm/i8259.h                      |    2 
 arch/x86/include/asm/setup.h                      |   46 +-
 arch/x86/kernel/acpi/boot.c                       |    3 
 arch/x86/kernel/i8259.c                           |   38 +
 arch/x86/kernel/setup.c                           |    5 
 arch/x86/kernel/vmlinux.lds.S                     |    2 
 drivers/base/driver.c                             |   69 +++
 drivers/base/platform.c                           |   28 -
 drivers/clk/clk.c                                 |   21 -
 drivers/dma/ste_dma40.c                           |    1 
 drivers/firmware/imx/imx-dsp.c                    |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu.h               |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |   19 
 drivers/gpu/drm/amd/amdgpu/vi.c                   |    2 
 drivers/gpu/drm/drm_dp_mst_topology.c             |    6 
 drivers/gpu/drm/i915/i915_pmu.c                   |    9 
 drivers/gpu/drm/ttm/ttm_device.c                  |    8 
 drivers/i2c/busses/i2c-aspeed.c                   |    3 
 drivers/i2c/busses/i2c-stm32f7.c                  |    9 
 drivers/i2c/muxes/i2c-demux-pinctrl.c             |    2 
 drivers/i2c/muxes/i2c-mux-gpmux.c                 |    2 
 drivers/i2c/muxes/i2c-mux-pinctrl.c               |    2 
 drivers/iio/adc/exynos_adc.c                      |   24 -
 drivers/iio/adc/xilinx-xadc-core.c                |   39 --
 drivers/iio/adc/xilinx-xadc.h                     |    2 
 drivers/iio/afe/iio-rescale.c                     |  162 ++++++--
 drivers/input/mouse/synaptics.c                   |    1 
 drivers/input/rmi4/rmi_smbus.c                    |   50 +-
 drivers/irqchip/irq-riscv-intc.c                  |   10 
 drivers/irqchip/irq-stm32-exti.c                  |    1 
 drivers/mcb/mcb-lpc.c                             |   35 +
 drivers/mcb/mcb-parse.c                           |   15 
 drivers/misc/fastrpc.c                            |   10 
 drivers/misc/pci_endpoint_test.c                  |    4 
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c        |    2 
 drivers/net/ethernet/google/gve/gve_rx_dqo.c      |    2 
 drivers/net/ethernet/intel/i40e/i40e.h            |    2 
 drivers/net/ethernet/intel/i40e/i40e_txrx.c       |    2 
 drivers/net/ethernet/intel/igb/igb_ethtool.c      |    6 
 drivers/net/ethernet/intel/igc/igc_ethtool.c      |   35 +
 drivers/net/ethernet/realtek/r8169_main.c         |    6 
 drivers/net/ethernet/toshiba/ps3_gelic_wireless.c |    2 
 drivers/net/gtp.c                                 |    5 
 drivers/net/ieee802154/adf7242.c                  |    5 
 drivers/net/usb/r8152.c                           |   18 
 drivers/net/usb/smsc95xx.c                        |    4 
 drivers/nvmem/imx-ocotp.c                         |    6 
 drivers/pci/quirks.c                              |    8 
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c          |   17 
 drivers/platform/mellanox/mlxbf-tmfifo.c          |   21 -
 drivers/rpmsg/qcom_glink_native.c                 |    2 
 drivers/rpmsg/rpmsg_core.c                        |   37 +
 drivers/rpmsg/rpmsg_internal.h                    |    5 
 drivers/rpmsg/rpmsg_ns.c                          |    4 
 drivers/scsi/mpt3sas/mpt3sas_scsih.c              |    4 
 drivers/spi/spi-npcm-fiu.c                        |    5 
 drivers/tty/n_gsm.c                               |    2 
 drivers/tty/serial/8250/8250_pci.c                |  327 ++++++++++++++++
 drivers/usb/gadget/legacy/raw_gadget.c            |   26 -
 drivers/usb/storage/unusual_cypress.h             |    2 
 drivers/usb/typec/tcpm/tcpm.c                     |    3 
 drivers/vhost/vhost.c                             |    4 
 drivers/video/fbdev/aty/atyfb_base.c              |    4 
 drivers/video/fbdev/uvesafb.c                     |    2 
 drivers/virtio/virtio_balloon.c                   |    6 
 drivers/virtio/virtio_mmio.c                      |   19 
 fs/ext4/mballoc.c                                 |   51 +-
 fs/ext4/mballoc.h                                 |   14 
 fs/nfsd/vfs.c                                     |   12 
 fs/ntfs3/attrib.c                                 |    6 
 fs/ntfs3/attrlist.c                               |   15 
 fs/ntfs3/bitmap.c                                 |    3 
 fs/ntfs3/dir.c                                    |    6 
 fs/ntfs3/frecord.c                                |    8 
 fs/ntfs3/fslog.c                                  |    6 
 fs/ntfs3/fsntfs.c                                 |   13 
 fs/ntfs3/super.c                                  |    2 
 include/linux/device/driver.h                     |    2 
 include/linux/iio/afe/rescale.h                   |   36 +
 include/linux/kasan.h                             |    6 
 include/linux/pci_ids.h                           |    1 
 include/linux/platform_device.h                   |    6 
 include/linux/rpmsg.h                             |   14 
 include/net/tcp.h                                 |    2 
 include/uapi/linux/can/isotp.h                    |   25 -
 include/uapi/linux/gtp.h                          |    2 
 kernel/events/core.c                              |    3 
 kernel/trace/trace_kprobe.c                       |    4 
 mm/kasan/report.c                                 |    4 
 mm/migrate.c                                      |   14 
 mm/page_alloc.c                                   |    2 
 net/can/isotp.c                                   |  426 ++++++++++++++--------
 net/core/neighbour.c                              |   67 +--
 net/ipv4/tcp.c                                    |   19 
 net/ipv4/tcp_input.c                              |    9 
 net/mptcp/protocol.c                              |   12 
 net/netfilter/nfnetlink_log.c                     |    2 
 net/sched/cls_u32.c                               |    2 
 net/vmw_vsock/virtio_transport.c                  |  215 +++++++----
 sound/hda/intel-dsp-config.c                      |    6 
 sound/soc/codecs/rt5645.c                         |    2 
 sound/soc/codecs/wcd938x.c                        |   52 ++
 sound/soc/generic/simple-card.c                   |    6 
 tools/objtool/check.c                             |    2 
 109 files changed, 1641 insertions(+), 671 deletions(-)

Al Viro (2):
      nfsd: lock_rename() needs both directories to live on the same fs
      sparc32: fix a braino in fault handling in csum_and_copy_..._user()

Alain Volmat (1):
      i2c: stm32f7: Fix PEC handling in case of SMBUS transfers

Alessandro Carminati (1):
      clk: Sanitize possible_parent_show to Handle Return Value of of_clk_get_parent_name

Alexandru Matei (1):
      vsock/virtio: initialize the_virtio_vsock before using VQs

Andrey Konovalov (1):
      usb: raw-gadget: properly handle interrupted requests

Anup Patel (1):
      irqchip/riscv-intc: Mark all INTC nodes as initialized

Arnd Bergmann (1):
      fbdev: atyfb: only use ioremap_uc() on i386 and ia64

Baokun Li (3):
      ext4: add two helper functions extent_logical_end() and pa_logical_end()
      ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow
      ext4: avoid overlapping preallocations due to overflow

Ben Wolsieffer (1):
      irqchip/stm32-exti: add missing DT IRQ flag translation

Bjorn Andersson (1):
      rpmsg: glink: Release driver_override

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

Christophe JAILLET (1):
      net: ieee802154: adf7242: Fix some potential buffer overflow in adf7242_stats_show()

Christophe Leroy (1):
      powerpc/85xx: Fix math emulation exception

Daniel Starke (1):
      tty: n_gsm: fix race condition in status line change on dead connections

Dmitry Torokhov (1):
      Input: synaptics-rmi4 - handle reset delay when using SMBus trsnsport

Douglas Anderson (6):
      r8152: Increase USB control msg timeout to 5000ms as per spec
      r8152: Run the unload routine if we have errors during probe
      r8152: Cancel hw_phy_work if we have an error in probe
      r8152: Release firmware if we have an error in probe
      r8152: Check for unplug in rtl_phy_patch_request()
      r8152: Check for unplug in r8153b_ups_en() / r8153c_ups_en()

Ekansh Gupta (1):
      misc: fastrpc: Clean buffers on remote invocation failures

Eric Auger (1):
      vhost: Allow null msg.size on VHOST_IOTLB_INVALIDATE

Eric Dumazet (3):
      tcp: remove dead code from tcp_sendmsg_locked()
      tcp: cleanup tcp_remove_empty_skb() use
      neighbour: fix various data-races

Florian Westphal (1):
      netfilter: nfnetlink_log: silence bogus compiler warning

Fred Chen (1):
      tcp: fix wrong RTO timeout when received SACK reneging

Gabriel Marcano (1):
      fs/ntfs3: Fix directory element type detection

Gavin Shan (1):
      virtio_balloon: Fix endless deflation and inflation on arm64

Greg Kroah-Hartman (1):
      Linux 5.15.138

Gregory Price (1):
      mm/migrate: fix do_pages_move for compat pointers

Gustavo A. R. Silva (1):
      net: sched: cls_u32: Fix allocation size in u32_init()

Haibo Li (1):
      kasan: print the original fault addr when access invalid shadow

Hangyu Hua (1):
      rpmsg: Fix possible refcount leak in rpmsg_register_device_override()

Hao Ge (1):
      firmware/imx-dsp: Fix use_after_free in imx_dsp_setup_channels()

Herve Codina (3):
      i2c: muxes: i2c-mux-pinctrl: Use of_get_i2c_adapter_by_node()
      i2c: muxes: i2c-mux-gpmux: Use of_get_i2c_adapter_by_node()
      i2c: muxes: i2c-demux-pinctrl: Use of_get_i2c_adapter_by_node()

Ivan Vecera (2):
      i40e: Fix I40E_FLAG_VF_VLAN_PRUNING value
      i40e: Fix wrong check for I40E_TXR_FLAGS_WB_ON_ITR

Jian Zhang (1):
      i2c: aspeed: Fix i2c bus hang in slave read

Jimmy Hu (1):
      usb: typec: tcpm: Fix NULL pointer dereference in tcpm_pd_svdm()

Johan Hovold (2):
      ASoC: codecs: wcd938x: fix resource leaks on bind errors
      ASoC: codecs: wcd938x: fix runtime PM imbalance on remove

John Sperbeck (1):
      objtool/x86: add missing embedded_insn check

Jorge Maidana (1):
      fbdev: uvesafb: Call cn_del_callback() at the end of uvesafb_exit()

Josh Poimboeuf (2):
      x86/mm: Simplify RESERVE_BRK()
      x86/mm: Fix RESERVE_BRK() for older binutils

Juergen Gross (1):
      x86: Fix .brk attribute in linker script

Karolina Stolarek (1):
      drm/ttm: Reorder sys manager cleanup step

Kemeng Shi (1):
      mm/page_alloc: correct start page when guard page debug is enabled

Konstantin Komarov (5):
      fs/ntfs3: Add ckeck in ni_update_parent()
      fs/ntfs3: Write immediately updated ntfs state
      fs/ntfs3: Use kvmalloc instead of kmalloc(... __GFP_NOWARN)
      fs/ntfs3: Fix possible NULL-ptr-deref in ni_readpage_cmpr()
      fs/ntfs3: Fix NULL pointer dereference on error in attr_allocate_frame()

Krzysztof Kozlowski (5):
      pinctrl: qcom: lpass-lpi: fix concurrent register updates
      driver: platform: Add helper for safer setting of driver_override
      rpmsg: Constify local variable in field store macro
      rpmsg: Fix kfree() of static memory on setting driver_override
      rpmsg: Fix calling device_lock() on non-initialized device

Kuninori Morimoto (1):
      ASoC: simple-card: fixup asoc_simple_probe() error handling

Kunwu Chan (1):
      treewide: Spelling fix in comment

Liam Beguin (3):
      iio: afe: rescale: reorder includes
      iio: afe: rescale: expose scale processing function
      iio: afe: rescale: add offset support

LihaSika (1):
      usb: storage: set 1.50 as the lower bcdDevice for older "Super Top" compatibility

Liming Sun (1):
      platform/mellanox: mlxbf-tmfifo: Fix a warning message

Linus Walleij (1):
      iio: afe: rescale: Accept only offset channels

Lukasz Majczak (1):
      drm/dp_mst: Fix NULL deref in get_mst_branch_device_by_guid_helper()

Marek Szyprowski (1):
      iio: exynos-adc: request second interupt only when touchscreen mode is used

Mario Limonciello (2):
      drm/amd: Move helper for dynamic speed switch check out of smu13
      drm/amd: Disable ASPM for VI w/ all Intel systems

Mark Hasemeyer (1):
      ALSA: hda: intel-dsp-config: Fix JSL Chromebook quirk detection

Mateusz Palczewski (1):
      igb: Fix potential memory leak in igb_add_ethtool_nfc_entry

Maximilian Heyne (1):
      virtio-mmio: fix memory leak of vm_dev

Michael Ellerman (1):
      powerpc/mm: Fix boot crash with FLATMEM

Mirsad Goran Todorovac (3):
      r8169: fix the KCSAN reported data-race in rtl_tx() while reading tp->cur_tx
      r8169: fix the KCSAN reported data-race in rtl_tx while reading TxDescArray[entry].opts1
      r8169: fix the KCSAN reported data race in rtl_rx while reading desc->opts1

Oliver Hartkopp (7):
      can: isotp: set max PDU size to 64 kByte
      can: isotp: isotp_bind(): return -EINVAL on incorrect CAN ID formatting
      can: isotp: check CAN address family in isotp_bind()
      can: isotp: handle wait_event_interruptible() return values
      can: isotp: add local echo tx processing and tx without FC
      can: isotp: isotp_bind(): do not validate unused address information
      can: isotp: isotp_sendmsg(): fix TX state detection and wait behavior

Pablo Neira Ayuso (2):
      gtp: uapi: fix GTPA_MAX
      gtp: fix fragmentation needed check with gso

Paolo Abeni (1):
      mptcp: more conservative check for zero probes

Peng Fan (3):
      nvmem: imx: correct nregs for i.MX6ULL
      nvmem: imx: correct nregs for i.MX6SLL
      nvmem: imx: correct nregs for i.MX6UL

Peter Zijlstra (1):
      perf/core: Fix potential NULL deref

Robert Hancock (2):
      iio: adc: xilinx-xadc: Don't clobber preset voltage/temperature thresholds
      iio: adc: xilinx-xadc: Correct temperature offset/scale for UltraScale

Rodríguez Barbarin, José Javier (2):
      mcb: Return actual parsed size when reading chameleon table
      mcb-lpc: Reallocate memory region to avoid memory overlapping

Sasha Neftin (1):
      igc: Fix ambiguity in the ethtool advertising

Shailend Chand (1):
      gve: Fix GFP flags when allocing pages

Shigeru Yoshida (1):
      net: usb: smsc95xx: Fix uninit-value access in smsc95xx_read_reg

Shuming Fan (1):
      ASoC: rt5650: fix the wrong result of key button

Siddharth Vadapalli (1):
      misc: pci_endpoint_test: Add deviceID for J721S2 PCIe EP device support

Stefano Garzarella (2):
      vsock/virtio: factor our the code to initialize and delete VQs
      vsock/virtio: add support for device suspend/resume

Su Hui (2):
      fs/ntfs3: Avoid possible memory leak
      net: chelsio: cxgb4: add an error code check in t4_load_phy_fw

Thomas Gleixner (1):
      x86/i8259: Skip probing when ACPI/MADT advertises PCAT compatibility

Tomas Henzl (1):
      scsi: mpt3sas: Fix in error path

Umesh Nerlige Ramappa (1):
      drm/i915/pmu: Check if pmu is closed before stopping event

Vicki Pfau (1):
      PCI: Prevent xHCI driver from claiming AMD VanGogh USB3 DRD device

William A. Kennington III (1):
      spi: npcm-fiu: Fix UMA reads when dummy.nbytes == 0

Yujie Liu (1):
      tracing/kprobes: Fix the description of variable length arguments

Zhang Shurong (1):
      dmaengine: ste_dma40: Fix PM disable depth imbalance in d40_probe

