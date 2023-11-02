Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E127DEE6E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343753AbjKBIy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbjKBIy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:54:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC0B185;
        Thu,  2 Nov 2023 01:54:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A238EC433C7;
        Thu,  2 Nov 2023 08:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698915257;
        bh=5n5G3EAv0JBtXgEKOsgOIcqLdqnKS/s4mnWwMcuywxI=;
        h=From:To:Cc:Subject:Date:From;
        b=TTq5PhRmteno035mRD6KrMZl2n4mQkGmyCZV3WagE845OagEKoZNw4onpiS9jgGLF
         DPp9YEXDsa9vUdxEJsTXtLdUqOy4n+OwPawOwuF0XbjrQ9Shdga2XjxBjMEEOKCYKZ
         H5VWY6HMMkh0sK21WPa5wXZGgGkoYzRJq/c13Ev8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.61
Date:   Thu,  2 Nov 2023 09:54:12 +0100
Message-ID: <2023110212-dispense-frequent-58b2@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.1.61 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                           |    2 
 arch/arm/boot/dts/omap4-l4-abe.dtsi                |    6 +
 arch/arm/boot/dts/omap4-l4.dtsi                    |    2 
 arch/arm/boot/dts/omap5-l4-abe.dtsi                |    6 +
 arch/arm/mach-omap1/timer32k.c                     |   14 ++--
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi |    1 
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   10 ++
 arch/sparc/lib/checksum_32.S                       |    2 
 arch/x86/include/asm/i8259.h                       |    2 
 arch/x86/include/asm/intel-family.h                |    2 
 arch/x86/kernel/acpi/boot.c                        |    3 
 arch/x86/kernel/i8259.c                            |   38 ++++++++--
 arch/x86/kvm/pmu.h                                 |    6 +
 arch/x86/kvm/svm/pmu.c                             |    2 
 arch/x86/kvm/vmx/pmu_intel.c                       |    4 -
 block/blk-throttle.c                               |    6 +
 drivers/ata/libata-scsi.c                          |    5 -
 drivers/clk/clk.c                                  |   21 +++---
 drivers/clk/ti/clk-44xx.c                          |    5 +
 drivers/clk/ti/clk-54xx.c                          |    4 +
 drivers/crypto/virtio/virtio_crypto_common.h       |    3 
 drivers/crypto/virtio/virtio_crypto_core.c         |   14 +++-
 drivers/firewire/sbp2.c                            |    1 
 drivers/firmware/imx/imx-dsp.c                     |    2 
 drivers/gpu/drm/amd/amdgpu/vi.c                    |    2 
 drivers/gpu/drm/display/drm_dp_mst_topology.c      |    6 -
 drivers/gpu/drm/i915/i915_pmu.c                    |    9 ++
 drivers/gpu/drm/logicvc/Kconfig                    |    2 
 drivers/i2c/busses/i2c-aspeed.c                    |    3 
 drivers/i2c/busses/i2c-stm32f7.c                   |    9 +-
 drivers/i2c/muxes/i2c-demux-pinctrl.c              |    2 
 drivers/i2c/muxes/i2c-mux-gpmux.c                  |    2 
 drivers/i2c/muxes/i2c-mux-pinctrl.c                |    2 
 drivers/iio/adc/exynos_adc.c                       |   24 ++++--
 drivers/iio/adc/xilinx-xadc-core.c                 |   39 ++++-------
 drivers/iio/adc/xilinx-xadc.h                      |    2 
 drivers/iio/afe/iio-rescale.c                      |   19 ++++-
 drivers/mcb/mcb-lpc.c                              |   35 ++++++++--
 drivers/mcb/mcb-parse.c                            |   15 ++--
 drivers/misc/fastrpc.c                             |   34 ++++-----
 drivers/mmc/core/block.c                           |   38 ++++++++--
 drivers/mmc/core/mmc_ops.c                         |    1 
 drivers/net/ethernet/adi/adin1110.c                |    2 
 drivers/net/ethernet/intel/i40e/i40e.h             |    2 
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |    2 
 drivers/net/ethernet/intel/iavf/iavf_main.c        |    7 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |    6 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |   35 +++++++---
 drivers/net/ethernet/realtek/r8169_main.c          |    6 -
 drivers/net/ethernet/toshiba/ps3_gelic_wireless.c  |    2 
 drivers/net/gtp.c                                  |    5 -
 drivers/net/ieee802154/adf7242.c                   |    5 -
 drivers/net/usb/r8152.c                            |   11 ++-
 drivers/net/usb/smsc95xx.c                         |    4 -
 drivers/nvmem/imx-ocotp.c                          |    6 -
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c           |   17 +++-
 drivers/platform/x86/thinkpad_acpi.c               |   73 +++++++++++++++++++++
 drivers/scsi/sd.c                                  |   39 ++++++++++-
 drivers/vhost/vhost.c                              |    4 -
 drivers/virtio/virtio_balloon.c                    |    6 +
 drivers/virtio/virtio_mmio.c                       |   19 ++++-
 drivers/virtio/virtio_pci_modern_dev.c             |    2 
 fs/ext4/mballoc.c                                  |   51 ++++++--------
 fs/ext4/mballoc.h                                  |   14 ++++
 fs/nfsd/vfs.c                                      |   12 +--
 include/linux/hugetlb.h                            |    6 +
 include/linux/kasan.h                              |    6 -
 include/scsi/scsi_device.h                         |   20 +++++
 include/uapi/linux/gtp.h                           |    2 
 io_uring/fdinfo.c                                  |   18 +++--
 kernel/events/core.c                               |    3 
 kernel/trace/trace_kprobe.c                        |    4 -
 lib/maple_tree.c                                   |    2 
 lib/test_maple_tree.c                              |   35 ++++++----
 mm/hugetlb.c                                       |   48 +++++++++++--
 mm/kasan/report.c                                  |    4 -
 mm/migrate.c                                       |   14 +++-
 mm/mmap.c                                          |    6 -
 mm/page_alloc.c                                    |    2 
 net/core/neighbour.c                               |   67 ++++++++++---------
 net/ipv4/tcp_input.c                               |    9 +-
 net/vmw_vsock/virtio_transport.c                   |   18 ++++-
 sound/soc/codecs/wcd938x.c                         |   51 ++++++++------
 tools/include/linux/rwsem.h                        |   40 +++++++++++
 tools/objtool/check.c                              |    2 
 85 files changed, 788 insertions(+), 304 deletions(-)

Al Viro (2):
      nfsd: lock_rename() needs both directories to live on the same fs
      sparc32: fix a braino in fault handling in csum_and_copy_..._user()

Alain Volmat (1):
      i2c: stm32f7: Fix PEC handling in case of SMBUS transfers

Alessandro Carminati (1):
      clk: Sanitize possible_parent_show to Handle Return Value of of_clk_get_parent_name

Alexandru Matei (1):
      vsock/virtio: initialize the_virtio_vsock before using VQs

Baokun Li (3):
      ext4: add two helper functions extent_logical_end() and pa_logical_end()
      ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow
      ext4: avoid overlapping preallocations due to overflow

Christian Loehle (1):
      mmc: block: ioctl: do write error check for spi

Christophe JAILLET (1):
      net: ieee802154: adf7242: Fix some potential buffer overflow in adf7242_stats_show()

Christopher Obbard (2):
      arm64: dts: rockchip: Add i2s0-2ch-bus-bclk-off pins to RK3399
      arm64: dts: rockchip: Fix i2s0 pin conflict on ROCK Pi 4 boards

Damien Le Moal (1):
      scsi: sd: Introduce manage_shutdown device flag

David Lazar (1):
      platform/x86: Add s2idle quirk for more Lenovo laptops

Dell Jin (1):
      net: ethernet: adi: adin1110: Fix uninitialized variable

Douglas Anderson (4):
      r8152: Increase USB control msg timeout to 5000ms as per spec
      r8152: Run the unload routine if we have errors during probe
      r8152: Cancel hw_phy_work if we have an error in probe
      r8152: Release firmware if we have an error in probe

Ekansh Gupta (4):
      misc: fastrpc: Reset metadata buffer to avoid incorrect free
      misc: fastrpc: Free DMA handles for RPC calls with no arguments
      misc: fastrpc: Clean buffers on remote invocation failures
      misc: fastrpc: Unmap only if buffer is unmapped from DSP

Eric Auger (1):
      vhost: Allow null msg.size on VHOST_IOTLB_INVALIDATE

Eric Dumazet (1):
      neighbour: fix various data-races

Fred Chen (1):
      tcp: fix wrong RTO timeout when received SACK reneging

Gavin Shan (1):
      virtio_balloon: Fix endless deflation and inflation on arm64

Greg Kroah-Hartman (1):
      Linux 6.1.61

Gregory Price (1):
      mm/migrate: fix do_pages_move for compat pointers

Haibo Li (1):
      kasan: print the original fault addr when access invalid shadow

Hao Ge (1):
      firmware/imx-dsp: Fix use_after_free in imx_dsp_setup_channels()

Herve Codina (3):
      i2c: muxes: i2c-mux-pinctrl: Use of_get_i2c_adapter_by_node()
      i2c: muxes: i2c-mux-gpmux: Use of_get_i2c_adapter_by_node()
      i2c: muxes: i2c-demux-pinctrl: Use of_get_i2c_adapter_by_node()

Ivan Vecera (2):
      i40e: Fix I40E_FLAG_VF_VLAN_PRUNING value
      i40e: Fix wrong check for I40E_TXR_FLAGS_WB_ON_ITR

Jens Axboe (1):
      io_uring/fdinfo: lock SQ thread while retrieving thread cpu/pid

Jian Zhang (1):
      i2c: aspeed: Fix i2c bus hang in slave read

Johan Hovold (2):
      ASoC: codecs: wcd938x: fix regulator leaks on probe errors
      ASoC: codecs: wcd938x: fix runtime PM imbalance on remove

John Sperbeck (1):
      objtool/x86: add missing embedded_insn check

Kemeng Shi (1):
      mm/page_alloc: correct start page when guard page debug is enabled

Khazhismel Kumykov (1):
      blk-throttle: check for overflow in calculate_bytes_allowed

Krzysztof Kozlowski (2):
      ASoC: codecs: wcd938x: Simplify with dev_err_probe
      pinctrl: qcom: lpass-lpi: fix concurrent register updates

Kunwu Chan (1):
      treewide: Spelling fix in comment

Liam R. Howlett (1):
      maple_tree: add GFP_KERNEL to allocations in mas_expected_entries()

Linus Walleij (1):
      iio: afe: rescale: Accept only offset channels

Lukasz Majczak (1):
      drm/dp_mst: Fix NULL deref in get_mst_branch_device_by_guid_helper()

Marek Szyprowski (1):
      iio: exynos-adc: request second interupt only when touchscreen mode is used

Mario Limonciello (1):
      drm/amd: Disable ASPM for VI w/ all Intel systems

Mateusz Palczewski (1):
      igb: Fix potential memory leak in igb_add_ethtool_nfc_entry

Maximilian Heyne (1):
      virtio-mmio: fix memory leak of vm_dev

Michal Schmidt (2):
      iavf: initialize waitqueues before starting watchdog_task
      iavf: in iavf_down, disable queues when removing the driver

Mirsad Goran Todorovac (3):
      r8169: fix the KCSAN reported data-race in rtl_tx() while reading tp->cur_tx
      r8169: fix the KCSAN reported data-race in rtl_tx while reading TxDescArray[entry].opts1
      r8169: fix the KCSAN reported data race in rtl_rx while reading desc->opts1

Pablo Neira Ayuso (2):
      gtp: uapi: fix GTPA_MAX
      gtp: fix fragmentation needed check with gso

Peng Fan (3):
      nvmem: imx: correct nregs for i.MX6ULL
      nvmem: imx: correct nregs for i.MX6SLL
      nvmem: imx: correct nregs for i.MX6UL

Peter Zijlstra (1):
      perf/core: Fix potential NULL deref

Randy Dunlap (1):
      ARM: OMAP: timer32K: fix all kernel-doc warnings

Rik van Riel (2):
      hugetlbfs: clear resv_map pointer if mmap fails
      hugetlbfs: extend hugetlb_vma_lock to private VMAs

Robert Hancock (2):
      iio: adc: xilinx-xadc: Don't clobber preset voltage/temperature thresholds
      iio: adc: xilinx-xadc: Correct temperature offset/scale for UltraScale

Rodríguez Barbarin, José Javier (2):
      mcb: Return actual parsed size when reading chameleon table
      mcb-lpc: Reallocate memory region to avoid memory overlapping

Roman Kagan (1):
      KVM: x86/pmu: Truncate counter value to allowed width on write

Sasha Neftin (1):
      igc: Fix ambiguity in the ethtool advertising

Sebastian Ott (1):
      mm: fix vm_brk_flags() to not bail out while holding lock

Shigeru Yoshida (1):
      net: usb: smsc95xx: Fix uninit-value access in smsc95xx_read_reg

Sui Jingfeng (1):
      drm/logicvc: Kconfig: select REGMAP and REGMAP_MMIO

Thomas Gleixner (1):
      x86/i8259: Skip probing when ACPI/MADT advertises PCAT compatibility

Tony Lindgren (2):
      clk: ti: Fix missing omap4 mcbsp functional clock and aliases
      clk: ti: Fix missing omap5 mcbsp functional clock and aliases

Tony Luck (1):
      x86/cpu: Add model number for Intel Arrow Lake mobile processor

Ulf Hansson (2):
      mmc: core: Align to common busy polling behaviour for mmc ioctls
      mmc: core: Fix error propagation for some ioctl commands

Umesh Nerlige Ramappa (1):
      drm/i915/pmu: Check if pmu is closed before stopping event

Uwe Kleine-König (1):
      ASoC: codecs: wcd938x: Convert to platform remove callback returning void

Xuan Zhuo (1):
      virtio_pci: fix the common cfg map size

Yujie Liu (1):
      tracing/kprobes: Fix the description of variable length arguments

zhenwei pi (1):
      virtio-crypto: handle config changed by work queue

