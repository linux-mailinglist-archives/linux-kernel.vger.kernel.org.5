Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648617DEE76
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345328AbjKBIym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbjKBIyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:54:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4919F184;
        Thu,  2 Nov 2023 01:54:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C073C433CA;
        Thu,  2 Nov 2023 08:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698915266;
        bh=96jE4X/27qhxLi7Erp6yau8MBjEDjh+ATT1U2Xhd8O0=;
        h=From:To:Cc:Subject:Date:From;
        b=V+WCFN5dMPEjOYqvmUx+rid4QgYsZtMUBrvwlus/LEk1A+qZhioqfriT1Dg7d433A
         1hexBAen8Mk4peN5hnAYq1zSNxA7eNjy1kq9R422LUrA2yMNDEu2HucAhGiZXArlRQ
         72rondAoa8aiOYEEtDOvV9Aq9nfdI3572vY4GZzM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.5.10
Date:   Thu,  2 Nov 2023 09:54:18 +0100
Message-ID: <2023110219-dayroom-slacked-ee81@gregkh>
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

I'm announcing the release of the 6.5.10 kernel.

All users of the 6.5 kernel series must upgrade.

The updated 6.5.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.5.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                              |    2 
 arch/arm/boot/dts/rockchip/rk3128.dtsi                |   18 +-
 arch/arm/boot/dts/ti/omap/omap4-l4-abe.dtsi           |    6 
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi               |    2 
 arch/arm/boot/dts/ti/omap/omap5-l4-abe.dtsi           |    6 
 arch/arm/mach-omap1/board-ams-delta.c                 |   60 +-----
 arch/arm/mach-omap1/timer32k.c                        |   14 -
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts           |   32 +--
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi   |   32 +--
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts    |   18 --
 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi           |    2 
 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts |   10 -
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi    |    1 
 arch/arm64/boot/dts/rockchip/rk3399.dtsi              |   10 +
 arch/sparc/lib/checksum_32.S                          |    2 
 arch/x86/include/asm/i8259.h                          |    2 
 arch/x86/include/asm/intel-family.h                   |    2 
 arch/x86/kernel/acpi/boot.c                           |    3 
 arch/x86/kernel/i8259.c                               |   38 +++-
 arch/x86/kernel/tsc_sync.c                            |   10 +
 block/blk-throttle.c                                  |    6 
 drivers/accel/ivpu/ivpu_drv.c                         |   11 -
 drivers/accel/ivpu/ivpu_drv.h                         |    1 
 drivers/accel/ivpu/ivpu_hw.h                          |    8 
 drivers/accel/ivpu/ivpu_hw_mtl.c                      |   12 -
 drivers/accel/ivpu/ivpu_pm.c                          |    3 
 drivers/ata/libata-scsi.c                             |    5 
 drivers/clk/clk.c                                     |   21 +-
 drivers/clk/socfpga/clk-gate.c                        |   27 ++-
 drivers/clk/stm32/clk-stm32-core.c                    |    2 
 drivers/clk/ti/clk-44xx.c                             |    5 
 drivers/clk/ti/clk-54xx.c                             |    4 
 drivers/crypto/virtio/virtio_crypto_common.h          |    3 
 drivers/crypto/virtio/virtio_crypto_core.c            |   14 +
 drivers/firewire/sbp2.c                               |    1 
 drivers/firmware/imx/imx-dsp.c                        |    2 
 drivers/gpu/drm/amd/amdgpu/vi.c                       |    2 
 drivers/gpu/drm/display/drm_dp_mst_topology.c         |    6 
 drivers/gpu/drm/i915/gt/intel_gt_mcr.c                |   24 ++
 drivers/gpu/drm/i915/i915_perf.c                      |    4 
 drivers/gpu/drm/i915/i915_pmu.c                       |    9 +
 drivers/gpu/drm/logicvc/Kconfig                       |    2 
 drivers/i2c/busses/i2c-aspeed.c                       |    3 
 drivers/i2c/busses/i2c-stm32f7.c                      |    9 -
 drivers/i2c/muxes/i2c-demux-pinctrl.c                 |    2 
 drivers/i2c/muxes/i2c-mux-gpmux.c                     |    2 
 drivers/i2c/muxes/i2c-mux-pinctrl.c                   |    2 
 drivers/iio/adc/exynos_adc.c                          |   24 +-
 drivers/iio/adc/xilinx-xadc-core.c                    |   39 +---
 drivers/iio/adc/xilinx-xadc.h                         |    2 
 drivers/iio/afe/iio-rescale.c                         |   19 +-
 drivers/misc/fastrpc.c                                |   34 +--
 drivers/net/ethernet/adi/adin1110.c                   |    2 
 drivers/net/ethernet/intel/i40e/i40e.h                |    2 
 drivers/net/ethernet/intel/i40e/i40e_txrx.c           |   11 +
 drivers/net/ethernet/intel/iavf/iavf_main.c           |    7 
 drivers/net/ethernet/intel/igb/igb_ethtool.c          |    6 
 drivers/net/ethernet/intel/igc/igc_ethtool.c          |   35 ++--
 drivers/net/ethernet/realtek/r8169_main.c             |    6 
 drivers/net/ethernet/toshiba/ps3_gelic_wireless.c     |    2 
 drivers/net/gtp.c                                     |    5 
 drivers/net/ieee802154/adf7242.c                      |    5 
 drivers/net/usb/r8152.c                               |   11 -
 drivers/net/usb/smsc95xx.c                            |    4 
 drivers/nvmem/imx-ocotp.c                             |    6 
 drivers/platform/x86/amd/pmc-quirks.c                 |   73 ++++++++
 drivers/scsi/sd.c                                     |   39 ++++
 drivers/vdpa/mlx5/net/debug.c                         |    5 
 drivers/vdpa/mlx5/net/mlx5_vnet.c                     |   70 ++++++--
 drivers/vdpa/mlx5/net/mlx5_vnet.h                     |   11 +
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c                  |    5 
 drivers/vhost/vhost.c                                 |    4 
 drivers/virtio/virtio_balloon.c                       |    6 
 drivers/virtio/virtio_mmio.c                          |   19 +-
 drivers/virtio/virtio_pci_modern_dev.c                |    2 
 fs/btrfs/backref.c                                    |   39 ++--
 fs/btrfs/backref.h                                    |    3 
 fs/btrfs/ctree.c                                      |   21 +-
 fs/btrfs/ctree.h                                      |    3 
 fs/btrfs/extent-tree.c                                |   35 ++--
 fs/btrfs/messages.c                                   |    6 
 fs/btrfs/messages.h                                   |    2 
 fs/btrfs/print-tree.c                                 |   10 -
 fs/btrfs/relocation.c                                 |   18 +-
 fs/nfsd/vfs.c                                         |   12 -
 fs/smb/client/cached_dir.c                            |  156 +++++++++---------
 fs/smb/client/cached_dir.h                            |    4 
 fs/smb/client/cifsfs.c                                |   12 +
 fs/smb/client/cifsglob.h                              |    4 
 fs/smb/client/cifsproto.h                             |    2 
 fs/smb/client/connect.c                               |   19 +-
 fs/smb/client/fs_context.c                            |   11 +
 fs/smb/client/fs_context.h                            |    4 
 fs/smb/client/misc.c                                  |   14 +
 fs/smb/client/smb2pdu.c                               |    2 
 include/linux/hugetlb.h                               |    6 
 include/linux/ieee80211.h                             |   29 +++
 include/linux/kasan.h                                 |    6 
 include/net/netfilter/nf_flow_table.h                 |    1 
 include/scsi/scsi_device.h                            |   20 ++
 include/trace/events/btrfs.h                          |    1 
 include/uapi/linux/btrfs_tree.h                       |    6 
 include/uapi/linux/gtp.h                              |    2 
 io_uring/fdinfo.c                                     |   18 +-
 kernel/events/core.c                                  |    3 
 kernel/trace/trace_kprobe.c                           |   28 ++-
 lib/maple_tree.c                                      |    2 
 lib/test_maple_tree.c                                 |   35 ++--
 mm/damon/sysfs.c                                      |    7 
 mm/hugetlb.c                                          |   48 ++++-
 mm/kasan/report.c                                     |    4 
 mm/mempolicy.c                                        |    4 
 mm/migrate.c                                          |   14 +
 mm/mmap.c                                             |    6 
 mm/page_alloc.c                                       |    2 
 net/core/neighbour.c                                  |   67 ++++---
 net/handshake/netlink.c                               |   30 ---
 net/ipv4/tcp.c                                        |    8 
 net/ipv4/tcp_input.c                                  |    9 -
 net/mac80211/rx.c                                     |    3 
 net/netfilter/nf_flow_table_core.c                    |   14 -
 net/sched/act_ct.c                                    |    9 +
 net/vmw_vsock/virtio_transport.c                      |   18 +-
 net/wireless/mlme.c                                   |    3 
 net/wireless/scan.c                                   |    2 
 tools/include/linux/rwsem.h                           |   40 ++++
 tools/testing/selftests/mm/mremap_dontunmap.c         |    1 
 127 files changed, 1161 insertions(+), 576 deletions(-)

Al Viro (2):
      nfsd: lock_rename() needs both directories to live on the same fs
      sparc32: fix a braino in fault handling in csum_and_copy_..._user()

Alain Volmat (1):
      i2c: stm32f7: Fix PEC handling in case of SMBUS transfers

Alessandro Carminati (1):
      clk: Sanitize possible_parent_show to Handle Return Value of of_clk_get_parent_name

Alex Bee (4):
      ARM: dts: rockchip: Fix i2c0 register address for RK3128
      ARM: dts: rockchip: Add missing arm timer interrupt for RK3128
      ARM: dts: rockchip: Add missing quirk for RK3128's dma engine
      ARM: dts: rockchip: Fix timer clocks for RK3128

Alexandru Matei (1):
      vsock/virtio: initialize the_virtio_vsock before using VQs

Andrii Nakryiko (1):
      tracing/kprobes: Fix symbol counting logic by looking at modules as well

Avraham Stern (1):
      wifi: mac80211: don't drop all unprotected public action frames

Ben Greear (1):
      wifi: cfg80211: pass correct pointer to rdev_inform_bss()

Christophe JAILLET (1):
      net: ieee802154: adf7242: Fix some potential buffer overflow in adf7242_stats_show()

Christopher Obbard (2):
      arm64: dts: rockchip: Add i2s0-2ch-bus-bclk-off pins to RK3399
      arm64: dts: rockchip: Fix i2s0 pin conflict on ROCK Pi 4 boards

Damien Le Moal (1):
      scsi: sd: Introduce manage_shutdown device flag

Dan Carpenter (1):
      clk: stm32: Fix a signedness issue in clk_stm32_composite_determine_rate()

David Lazar (1):
      platform/x86: Add s2idle quirk for more Lenovo laptops

Dell Jin (1):
      net: ethernet: adi: adin1110: Fix uninitialized variable

Douglas Anderson (4):
      r8152: Increase USB control msg timeout to 5000ms as per spec
      r8152: Run the unload routine if we have errors during probe
      r8152: Cancel hw_phy_work if we have an error in probe
      r8152: Release firmware if we have an error in probe

Dragos Tatulea (2):
      vdpa/mlx5: Fix firmware error on creation of 1k VQs
      vdpa/mlx5: Fix double release of debugfs entry

Ekansh Gupta (4):
      misc: fastrpc: Reset metadata buffer to avoid incorrect free
      misc: fastrpc: Free DMA handles for RPC calls with no arguments
      misc: fastrpc: Clean buffers on remote invocation failures
      misc: fastrpc: Unmap only if buffer is unmapped from DSP

Eric Auger (1):
      vhost: Allow null msg.size on VHOST_IOTLB_INVALIDATE

Eric Dumazet (2):
      net: do not leave an empty skb in write queue
      neighbour: fix various data-races

Ermin Sunj (1):
      arm64: dts: rockchip: use codec as clock master on px30-ringneck-haikou

Filipe Manana (1):
      btrfs: fix unwritten extent buffer after snapshotting a new subvolume

Fred Chen (1):
      tcp: fix wrong RTO timeout when received SACK reneging

Gavin Shan (1):
      virtio_balloon: Fix endless deflation and inflation on arm64

Greg Kroah-Hartman (1):
      Linux 6.5.10

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

Jacek Lawrynowicz (1):
      accel/ivpu: Don't enter d0i3 during FLR

Jakob Unterwurzacher (1):
      arm64: dts: rockchip: set codec system-clock-fixed on px30-ringneck-haikou

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: Fix MODEM initialization failure

Jens Axboe (1):
      io_uring/fdinfo: lock SQ thread while retrieving thread cpu/pid

Jian Zhang (1):
      i2c: aspeed: Fix i2c bus hang in slave read

Johannes Berg (1):
      wifi: cfg80211: fix assoc response warning on failed links

Karol Wachowski (1):
      accel/ivpu/37xx: Fix missing VPUIP interrupts

Kemeng Shi (1):
      mm/page_alloc: correct start page when guard page debug is enabled

Khazhismel Kumykov (1):
      blk-throttle: check for overflow in calculate_bytes_allowed

Krzysztof Kozlowski (3):
      arm64: dts: qcom: apq8096-db820c: fix missing clock populate
      arm64: dts: qcom: msm8996-xiaomi: fix missing clock populate
      arm64: dts: qcom: sa8775p: correct PMIC GPIO label in gpio-ranges

Kunwu Chan (1):
      treewide: Spelling fix in comment

Liam R. Howlett (2):
      mm/mempolicy: fix set_mempolicy_home_node() previous VMA pointer
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

Matt Roper (1):
      drm/i915/mcr: Hold GT forcewake during steering operations

Maxime Ripard (1):
      clk: socfpga: gate: Account for the divider in determine_rate

Maximilian Heyne (1):
      virtio-mmio: fix memory leak of vm_dev

Michal Schmidt (2):
      iavf: initialize waitqueues before starting watchdog_task
      iavf: in iavf_down, disable queues when removing the driver

Mirsad Goran Todorovac (3):
      r8169: fix the KCSAN reported data-race in rtl_tx() while reading tp->cur_tx
      r8169: fix the KCSAN reported data-race in rtl_tx while reading TxDescArray[entry].opts1
      r8169: fix the KCSAN reported data race in rtl_rx while reading desc->opts1

Moritz Wanzenböck (1):
      net/handshake: fix file ref count in handshake_nl_accept_doit()

Pablo Neira Ayuso (3):
      gtp: uapi: fix GTPA_MAX
      gtp: fix fragmentation needed check with gso
      netfilter: flowtable: GC pushes back packets to classic path

Paulo Alcantara (3):
      smb: client: do not start laundromat thread on nohandlecache
      smb: client: make laundromat a delayed worker
      smb: client: prevent new fids from being removed by laundromat

Peng Fan (3):
      nvmem: imx: correct nregs for i.MX6ULL
      nvmem: imx: correct nregs for i.MX6SLL
      nvmem: imx: correct nregs for i.MX6UL

Peter Zijlstra (1):
      perf/core: Fix potential NULL deref

Qu Wenruo (1):
      btrfs: remove v0 extent handling

Randy Dunlap (1):
      ARM: OMAP: timer32K: fix all kernel-doc warnings

Rik van Riel (2):
      hugetlbfs: clear resv_map pointer if mmap fails
      hugetlbfs: extend hugetlb_vma_lock to private VMAs

Robert Hancock (2):
      iio: adc: xilinx-xadc: Don't clobber preset voltage/temperature thresholds
      iio: adc: xilinx-xadc: Correct temperature offset/scale for UltraScale

Samasth Norway Ananda (1):
      selftests/mm: include mman header to access MREMAP_DONTUNMAP identifier

Sasha Neftin (1):
      igc: Fix ambiguity in the ethtool advertising

Sebastian Ott (1):
      mm: fix vm_brk_flags() to not bail out while holding lock

SeongJae Park (1):
      mm/damon/sysfs: check DAMOS regions update progress from before_terminate()

Shawn.Shao (1):
      vdpa_sim_blk: Fix the potential leak of mgmt_dev

Shigeru Yoshida (1):
      net: usb: smsc95xx: Fix uninit-value access in smsc95xx_read_reg

Steve French (3):
      smb3: allow controlling length of time directory entries are cached with dir leases
      smb3: allow controlling maximum number of cached directories
      smb3: do not start laundromat thread when dir leases disabled

Sui Jingfeng (1):
      drm/logicvc: Kconfig: select REGMAP and REGMAP_MMIO

Thomas Gleixner (2):
      x86/tsc: Defer marking TSC unstable to a worker
      x86/i8259: Skip probing when ACPI/MADT advertises PCAT compatibility

Tirthendu Sarkar (1):
      i40e: sync next_to_clean and next_to_process for programming status desc

Tony Lindgren (2):
      clk: ti: Fix missing omap4 mcbsp functional clock and aliases
      clk: ti: Fix missing omap5 mcbsp functional clock and aliases

Tony Luck (1):
      x86/cpu: Add model number for Intel Arrow Lake mobile processor

Umesh Nerlige Ramappa (2):
      drm/i915/pmu: Check if pmu is closed before stopping event
      drm/i915/perf: Determine context valid in OA reports

Vlad Buslov (1):
      net/sched: act_ct: additional checks for outdated flows

Xuan Zhuo (1):
      virtio_pci: fix the common cfg map size

Yujie Liu (1):
      tracing/kprobes: Fix the description of variable length arguments

zhenwei pi (1):
      virtio-crypto: handle config changed by work queue

