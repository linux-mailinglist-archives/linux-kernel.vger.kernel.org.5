Return-Path: <linux-kernel+bounces-148252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 505768A7FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8111F22613
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6FA13BAC6;
	Wed, 17 Apr 2024 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hrgieqhC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9357E13B5AF;
	Wed, 17 Apr 2024 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346515; cv=none; b=L/ojC4qHaj5vRxjUaOKyc5klQm7l1Zw+fqTk05PPNeDUZFSdaKFkkxvBDUBANsRnbGs1zXCgfHsWXkvf6n91QRAOjKwJqy5Ii9VZlWoqTAHJO/MQf6bApKQ+dnEScBfK4B7gMRV5BPbL2q8V5FR1iCI760dkJfPYVgoPcY/J1zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346515; c=relaxed/simple;
	bh=PH288K57T3xQ4AGtkJxj1MkyFXAJDoMS3ZBAuuxBCwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f0LczziSBVKE/yGdx+qs1jGJwta32yGSL1gIQ6rQgYs/Hme6Fg+onVuOLyLBpUK7BTUZZuZjqgYhsaz6zfgRYmmz6FvXAen2B4l+mxUDMorTyZSRn0Oi/g4bgIXdC2caXC5qiBg8wRI8kRUvfg0P3u9NzVT6aF7osP1Xgm71roo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hrgieqhC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25A6C072AA;
	Wed, 17 Apr 2024 09:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713346515;
	bh=PH288K57T3xQ4AGtkJxj1MkyFXAJDoMS3ZBAuuxBCwQ=;
	h=From:To:Cc:Subject:Date:From;
	b=hrgieqhCrB9UjVag6aN3L/+Qc+ALV1PbLPPF64t+zutb/NEQlZCw0nNNm/UFaZDP9
	 rMLcR6CPawXeQDg5p8gpWTeoI3KfruTGHnSRayjpxsh3zWEApIw2AvKpevEClTkP2R
	 yMlgY9m7O55bAScU0rjGJ82UIOX9BC7tRKUpwYKM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.8.7
Date: Wed, 17 Apr 2024 11:35:07 +0200
Message-ID: <2024041707-thread-molar-5979@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.8.7 kernel.

All users of the 6.8 kernel series must upgrade.

The updated 6.8.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.8.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/hw-vuln/spectre.rst                       |   22 
 Documentation/admin-guide/kernel-parameters.txt                     |   12 
 Documentation/devicetree/bindings/display/msm/qcom,sm8150-mdss.yaml |    9 
 Makefile                                                            |    2 
 arch/arm/boot/dts/nxp/imx/imx7s-warp.dts                            |    1 
 arch/arm/mach-omap2/board-n8x0.c                                    |   23 -
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi                     |   16 
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi                      |   40 -
 arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi                     |   16 
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx.dtsi             |    2 
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi             |    2 
 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi                    |    8 
 arch/arm64/include/asm/tlbflush.h                                   |   20 
 arch/x86/Kconfig                                                    |   21 
 arch/x86/events/core.c                                              |    1 
 arch/x86/include/asm/apic.h                                         |    3 
 arch/x86/kernel/apic/apic.c                                         |    6 
 arch/x86/kernel/cpu/bugs.c                                          |   82 +--
 arch/x86/kernel/cpu/common.c                                        |   48 +-
 block/blk-cgroup.c                                                  |    9 
 block/blk-cgroup.h                                                  |    2 
 block/blk-core.c                                                    |    2 
 drivers/accel/ivpu/ivpu_drv.c                                       |   20 
 drivers/accel/ivpu/ivpu_hw.h                                        |    6 
 drivers/accel/ivpu/ivpu_hw_37xx.c                                   |    7 
 drivers/accel/ivpu/ivpu_hw_40xx.c                                   |    6 
 drivers/accel/ivpu/ivpu_ipc.c                                       |    8 
 drivers/accel/ivpu/ivpu_pm.c                                        |    5 
 drivers/acpi/numa/hmat.c                                            |   43 +
 drivers/acpi/scan.c                                                 |    3 
 drivers/ata/libata-core.c                                           |    2 
 drivers/ata/libata-scsi.c                                           |    9 
 drivers/base/node.c                                                 |    6 
 drivers/cxl/acpi.c                                                  |    8 
 drivers/cxl/core/cdat.c                                             |   58 +-
 drivers/cxl/core/mbox.c                                             |    5 
 drivers/cxl/core/port.c                                             |   76 ++-
 drivers/cxl/core/regs.c                                             |    5 
 drivers/cxl/cxl.h                                                   |    8 
 drivers/firmware/arm_ffa/driver.c                                   |    2 
 drivers/firmware/arm_scmi/raw_mode.c                                |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c                             |    6 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                              |    2 
 drivers/gpu/drm/amd/amdgpu/soc21.c                                  |   32 +
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c                          |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c               |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                   |   15 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c                |    6 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c      |   19 
 drivers/gpu/drm/amd/display/dc/core/dc_state.c                      |    9 
 drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c              |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c                |   12 
 drivers/gpu/drm/ast/ast_dp.c                                        |    3 
 drivers/gpu/drm/drm_client_modeset.c                                |    3 
 drivers/gpu/drm/i915/display/intel_cdclk.c                          |    7 
 drivers/gpu/drm/i915/display/intel_cdclk.h                          |    3 
 drivers/gpu/drm/i915/display/intel_ddi.c                            |    5 
 drivers/gpu/drm/i915/display/intel_dp.c                             |    6 
 drivers/gpu/drm/i915/display/intel_psr.c                            |   11 
 drivers/gpu/drm/i915/display/intel_vrr.c                            |    7 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                               |    4 
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c                       |   10 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c                   |    8 
 drivers/gpu/drm/msm/dp/dp_display.c                                 |    2 
 drivers/gpu/drm/msm/msm_fb.c                                        |    6 
 drivers/gpu/drm/msm/msm_kms.c                                       |    4 
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c                 |    7 
 drivers/gpu/drm/panfrost/panfrost_mmu.c                             |   13 
 drivers/gpu/drm/qxl/qxl_release.c                                   |   50 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                                 |   11 
 drivers/gpu/drm/xe/xe_display.c                                     |    5 
 drivers/gpu/drm/xe/xe_hwmon.c                                       |    4 
 drivers/iommu/intel/iommu.c                                         |   11 
 drivers/iommu/intel/perfmon.c                                       |    2 
 drivers/iommu/intel/svm.c                                           |    2 
 drivers/md/raid1.c                                                  |    2 
 drivers/media/cec/core/cec-adap.c                                   |   14 
 drivers/mmc/host/omap.c                                             |   48 +-
 drivers/net/dsa/mt7530.c                                            |  229 ++++++++--
 drivers/net/dsa/mt7530.h                                            |    5 
 drivers/net/ethernet/amazon/ena/ena_com.c                           |    2 
 drivers/net/ethernet/amazon/ena/ena_netdev.c                        |   35 +
 drivers/net/ethernet/amazon/ena/ena_xdp.c                           |    4 
 drivers/net/ethernet/amd/pds_core/core.c                            |   14 
 drivers/net/ethernet/amd/pds_core/core.h                            |    5 
 drivers/net/ethernet/amd/pds_core/dev.c                             |    3 
 drivers/net/ethernet/amd/pds_core/main.c                            |    8 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                           |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c                       |    6 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                 |   20 
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c                    |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h                    |    8 
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c                    |   33 -
 drivers/net/ethernet/mellanox/mlx5/core/en/selq.c                   |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c                |   17 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                   |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c                     |    7 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c                   |   17 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                      |   37 -
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c                   |    4 
 drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c             |   22 
 drivers/net/ethernet/micrel/ks8851.h                                |    3 
 drivers/net/ethernet/micrel/ks8851_common.c                         |   16 
 drivers/net/ethernet/micrel/ks8851_par.c                            |   11 
 drivers/net/ethernet/micrel/ks8851_spi.c                            |   11 
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c                 |    4 
 drivers/net/geneve.c                                                |    4 
 drivers/net/virtio_net.c                                            |   26 -
 drivers/platform/chrome/cros_ec_uart.c                              |   28 -
 drivers/scsi/hisi_sas/hisi_sas_main.c                               |    2 
 drivers/scsi/qla2xxx/qla_edif.c                                     |    2 
 drivers/scsi/sg.c                                                   |   20 
 drivers/vhost/vhost.c                                               |   24 -
 fs/btrfs/delayed-inode.c                                            |    3 
 fs/btrfs/inode.c                                                    |   13 
 fs/btrfs/ioctl.c                                                    |   37 +
 fs/btrfs/qgroup.c                                                   |    2 
 fs/btrfs/root-tree.c                                                |   10 
 fs/btrfs/root-tree.h                                                |    2 
 fs/btrfs/tests/extent-io-tests.c                                    |   28 +
 fs/btrfs/transaction.c                                              |   17 
 fs/ceph/addr.c                                                      |    4 
 fs/ceph/caps.c                                                      |    4 
 fs/ceph/mds_client.c                                                |    9 
 fs/ceph/mds_client.h                                                |    3 
 fs/kernfs/file.c                                                    |    9 
 fs/proc/bootconfig.c                                                |   12 
 fs/smb/client/cached_dir.c                                          |    4 
 include/acpi/acpi_bus.h                                             |    8 
 include/linux/bootconfig.h                                          |    1 
 include/linux/dma-fence.h                                           |    7 
 include/linux/irqflags.h                                            |    2 
 include/linux/node.h                                                |   18 
 include/linux/u64_stats_sync.h                                      |    9 
 include/net/addrconf.h                                              |    4 
 include/net/af_unix.h                                               |    2 
 include/net/bluetooth/bluetooth.h                                   |   11 
 include/net/ip_tunnels.h                                            |   33 +
 init/main.c                                                         |    5 
 io_uring/io_uring.c                                                 |   25 +
 io_uring/net.c                                                      |   22 
 io_uring/rw.c                                                       |    2 
 kernel/cpu.c                                                        |    3 
 kernel/kprobes.c                                                    |   18 
 kernel/power/suspend.c                                              |    6 
 kernel/trace/ring_buffer.c                                          |    6 
 kernel/trace/trace_events.c                                         |    4 
 lib/checksum_kunit.c                                                |    5 
 net/batman-adv/translation-table.c                                  |    2 
 net/bluetooth/hci_request.c                                         |    4 
 net/bluetooth/hci_sock.c                                            |   21 
 net/bluetooth/hci_sync.c                                            |   66 ++
 net/bluetooth/iso.c                                                 |   50 --
 net/bluetooth/l2cap_core.c                                          |    3 
 net/bluetooth/l2cap_sock.c                                          |   52 --
 net/bluetooth/rfcomm/sock.c                                         |   14 
 net/bluetooth/sco.c                                                 |   23 -
 net/ipv4/netfilter/arp_tables.c                                     |    4 
 net/ipv4/netfilter/ip_tables.c                                      |    4 
 net/ipv4/route.c                                                    |    4 
 net/ipv6/addrconf.c                                                 |    7 
 net/ipv6/ip6_fib.c                                                  |    7 
 net/ipv6/netfilter/ip6_tables.c                                     |    4 
 net/openvswitch/conntrack.c                                         |    5 
 net/unix/af_unix.c                                                  |    8 
 net/unix/garbage.c                                                  |   35 +
 net/unix/scm.c                                                      |    8 
 net/xdp/xsk.c                                                       |    2 
 tools/testing/selftests/kselftest.h                                 |   33 +
 tools/testing/selftests/timers/posix_timers.c                       |  105 ++--
 170 files changed, 1553 insertions(+), 876 deletions(-)

Aaro Koskinen (6):
      ARM: OMAP2+: fix bogus MMC GPIO labels on Nokia N8x0
      ARM: OMAP2+: fix N810 MMC gpiod table
      mmc: omap: fix broken slot switch lookup
      mmc: omap: fix deferred probe
      mmc: omap: restore original power up/down steps
      ARM: OMAP2+: fix USB regression on Nokia N8x0

Adam Dunlap (1):
      x86/apic: Force native_apic_mem_read() to use the MOV instruction

Alex Constantino (1):
      Revert "drm/qxl: simplify qxl_fence_wait"

Alex Deucher (1):
      drm/amdgpu: always force full reset for SOC21

Alex Hung (1):
      drm/amd/display: Return max resolution supported by DWB

Alexander Wetzel (2):
      scsi: sg: Avoid sg device teardown race
      scsi: sg: Avoid race in error handling & drop bogus warn

Amir Goldstein (1):
      kernfs: annotate different lockdep class for of->mutex of writable files

Anna-Maria Behnsen (1):
      PM: s2idle: Make sure CPUs will wakeup directly on resume

Archie Pusaka (1):
      Bluetooth: l2cap: Don't double set the HCI_CONN_MGMT_CONNECTED bit

Arnd Bergmann (6):
      nouveau: fix function cast warning
      lib: checksum: hide unused expected_csum_ipv6_magic[]
      ipv6: fib: hide unused 'pn' variable
      ipv4/route: avoid unused-but-set-variable warning
      tracing: hide unused ftrace_event_id_fops
      irqflags: Explicitly ignore lockdep_hrtimer_exit() argument

Arınç ÜNAL (1):
      net: dsa: mt7530: trap link-local frames regardless of ST Port State

Boris Brezillon (1):
      drm/panfrost: Fix the error path in panfrost_mmu_map_fault_addr()

Boris Burkov (4):
      btrfs: qgroup: correctly model root qgroup rsv in convert
      btrfs: qgroup: fix qgroup prealloc rsv leak in subvolume operations
      btrfs: record delayed inode root in transaction
      btrfs: qgroup: convert PREALLOC to PERTRANS after record_root_in_trans

Breno Leitao (1):
      virtio_net: Do not send RSS key if it is not supported

Brett Creeley (1):
      pds_core: Fix pdsc_check_pci_health function to use work thread

Carolina Jubran (3):
      net/mlx5e: RSS, Block changing channels number when RXFH is configured
      net/mlx5e: Fix mlx5e_priv_init() cleanup flow
      net/mlx5e: HTB, Fix inconsistencies with QoS SQs number

Cosmin Ratiu (2):
      net/mlx5: Properly link new fs rules into the tree
      net/mlx5: Correctly compare pkt reformat ids

Cristian Marussi (1):
      firmware: arm_scmi: Make raw debugfs entries non-seekable

Damien Le Moal (1):
      ata: libata-scsi: Fix ata_scsi_dev_rescan() error path

Dan Carpenter (1):
      scsi: qla2xxx: Fix off by one in qla_edif_app_getstats()

Daniel Machon (1):
      net: sparx5: fix wrong config being used when reconfiguring PCS

Daniel Sneddon (1):
      x86/bugs: Fix return type of spectre_bhi_state()

Dave Jiang (8):
      cxl/core/regs: Fix usage of map->reg_type in cxl_decode_regblock() before assigned
      base/node / ACPI: Enumerate node access class for 'struct access_coordinate'
      ACPI: HMAT: Introduce 2 levels of generic port access class
      ACPI: HMAT / cxl: Add retrieval of generic port coordinates for both access classes
      cxl: Split out combine_coordinates() for common shared usage
      cxl: Split out host bridge access coordinates
      cxl: Remove checking of iter in cxl_endpoint_get_perf_coordinates()
      cxl: Fix retrieving of access_coordinates in PCIe path

David Arinzon (4):
      net: ena: Fix potential sign extension issue
      net: ena: Wrong missing IO completions check order
      net: ena: Fix incorrect descriptor free behavior
      net: ena: Set tx_info->xdpf value to NULL

David Sterba (1):
      btrfs: tests: allocate dummy fs_info and root in test_find_delalloc()

Dillon Varone (1):
      drm/amd/display: Do not recursively call manual trigger programming

Dmitry Antipov (1):
      Bluetooth: Fix memory leak in hci_req_sync_complete()

Dmitry Baryshkov (3):
      drm/msm/dpu: don't allow overriding data from catalog
      drm/msm/dpu: make error messages at dpu_core_irq_register_callback() more sensible
      dt-bindings: display/msm: sm8150-mdss: add DP node

Eric Dumazet (3):
      xsk: validate user input for XDP_{UMEM|COMPLETION}_FILL_RING
      geneve: fix header validation in geneve[6]_xmit_skb
      netfilter: complete validation of user input

Fabio Estevam (1):
      ARM: dts: imx7s-warp: Pass OV2680 link-frequencies

Frank Li (8):
      arm64: dts: imx8-ss-conn: fix usdhc wrong lpcg clock order
      arm64: dts: imx8qm-ss-dma: fix can lpcg indices
      arm64: dts: imx8-ss-dma: fix can lpcg indices
      arm64: dts: imx8-ss-dma: fix adc lpcg indices
      arm64: dts: imx8-ss-conn: fix usb lpcg indices
      arm64: dts: imx8-ss-dma: fix pwm lpcg indices
      arm64: dts: imx8-ss-lsio: fix pwm lpcg indices
      arm64: dts: imx8-ss-dma: fix spi lpcg indices

Fudongwang (1):
      drm/amd/display: fix disable otg wa logic in DCN316

Gavin Shan (3):
      arm64: tlb: Fix TLBI RANGE operand
      vhost: Add smp_rmb() in vhost_vq_avail_empty()
      vhost: Add smp_rmb() in vhost_enable_notify()

Geetha sowjanya (1):
      octeontx2-af: Fix NIX SQ mode and BP config

Gerd Bayer (2):
      s390/ism: fix receive message buffer allocation
      Revert "s390/ism: fix receive message buffer allocation"

Greg Kroah-Hartman (1):
      Linux 6.8.7

Hans de Goede (1):
      ACPI: scan: Do not increase dep_unmet for already met dependencies

Hariprasad Kelam (1):
      octeontx2-pf: Fix transmit scheduler resource leak

Harish Kasiviswanathan (1):
      drm/amdkfd: Reset GPU on queue preemption failure

Harry Wentland (2):
      drm/amd/display: Program VSC SDP colorimetry for all DP sinks >= 1.4
      drm/amd/display: Set VSC SDP Colorimetry same way for MST and SST

Igor Pylypiv (1):
      ata: libata-core: Allow command duration limits detection for ACS-4 drives

Ilya Maximets (1):
      net: openvswitch: fix unwanted error log on timeout policy probing

Ingo Molnar (1):
      x86/bugs: Rename various 'ia32_cap' variables to 'x86_arch_cap_msr'

Jacek Lawrynowicz (3):
      accel/ivpu: Put NPU back to D3hot after failed resume
      accel/ivpu: Return max freq for DRM_IVPU_PARAM_CORE_CLOCK_RATE
      accel/ivpu: Fix deadlock in context_xa

Jacob Pan (1):
      iommu/vt-d: Allocate local memory for page request queue

Jammy Huang (1):
      drm/ast: Fix soft lockup

Jens Axboe (1):
      io_uring: disable io-wq execution of multishot NOWAIT requests

Jens Wiklander (1):
      firmware: arm_ffa: Fix the partition ID check in ffa_notification_info_get()

Jiri Benc (1):
      ipv6: fix race condition between ipv6_get_ifaddr and ipv6_del_addr

Johan Hovold (2):
      drm/msm/dp: fix runtime PM leak on disconnect
      drm/msm/dp: fix runtime PM leak on connect failure

John Stultz (2):
      selftests: timers: Fix posix_timers ksft_print_msg() warning
      selftests: timers: Fix abs() warning in posix_timers test

Josh Poimboeuf (6):
      x86/bugs: Fix BHI documentation
      x86/bugs: Cache the value of MSR_IA32_ARCH_CAPABILITIES
      x86/bugs: Fix BHI handling of RRSBA
      x86/bugs: Clarify that syscall hardening isn't a BHI mitigation
      x86/bugs: Remove CONFIG_BHI_MITIGATION_AUTO and spectre_bhi=auto
      x86/bugs: Replace CONFIG_SPECTRE_BHI_{ON,OFF} with CONFIG_MITIGATION_SPECTRE_BHI

Karthik Poosa (1):
      drm/xe/hwmon: Cast result to output precision on left shift of operand

Kuniyuki Iwashima (2):
      af_unix: Clear stale u->oob_skb.
      af_unix: Do not use atomic ops for unix_sk(sk)->inflight.

Kwangjin Ko (1):
      cxl/core: Fix initialization of mbox_cmd.size_out in get event

Lang Yu (1):
      drm/amdgpu/umsch: reinitialize write pointer in hw init

Lijo Lazar (1):
      drm/amdgpu: Reset dGPU if suspend got aborted

Lu Baolu (1):
      iommu/vt-d: Fix WARN_ON in iommu probe path

Luca Weiss (1):
      drm/msm/adreno: Set highest_bank_bit for A619

Lucas De Marchi (1):
      drm/xe/display: Fix double mutex initialization

Luiz Augusto von Dentz (9):
      Bluetooth: ISO: Align broadcast sync_timeout with connection timeout
      Bluetooth: ISO: Don't reject BT_ISO_QOS if parameters are unset
      Bluetooth: hci_sync: Use QoS to determine which PHY to scan
      Bluetooth: hci_sync: Fix using the same interval and window for Coded PHY
      Bluetooth: SCO: Fix not validating setsockopt user input
      Bluetooth: RFCOMM: Fix not validating setsockopt user input
      Bluetooth: L2CAP: Fix not validating setsockopt user input
      Bluetooth: ISO: Fix not validating setsockopt user input
      Bluetooth: hci_sock: Fix not validating setsockopt user input

Marek Vasut (2):
      net: ks8851: Inline ks8851_rx_skb()
      net: ks8851: Handle softirqs at the end of IRQ thread to fix hang

Masami Hiramatsu (1):
      fs/proc: Skip bootloader comment if no embedded kernel parameters

Michael Liang (1):
      net/mlx5: offset comp irq index in name by one

Michal Luczaj (1):
      af_unix: Fix garbage collector racing against connect()

Ming Lei (1):
      block: fix q->blkg_list corruption during disk rebind

Moshe Shemesh (1):
      net/mlx5: SF, Stop waiting for FW as teardown was called

Namhyung Kim (1):
      perf/x86: Fix out of range data

Nathan Chancellor (1):
      selftests: kselftest: Mark functions that unconditionally call exit() as __noreturn

NeilBrown (1):
      ceph: redirty page before returning AOP_WRITEPAGE_ACTIVATE

Nini Song (1):
      media: cec: core: remove length check of Timer Status

Noah Loomans (1):
      platform/chrome: cros_ec_uart: properly fix race condition

Oleg Nesterov (2):
      selftests/timers/posix_timers: Reimplement check_timer_distribution()
      selftests: kselftest: Fix build failure with NOLIBC

Pavan Chebbi (1):
      bnxt_en: Reset PTP tx_avail after possible firmware reset

Pavel Begunkov (2):
      io_uring: refactor DEFER_TASKRUN multishot checks
      io_uring/net: restore msg_control on sendzc retry

Petr Tesarik (1):
      u64_stats: fix u64_stats_init() for lockdep when used repeatedly in one file

Peyton Lee (1):
      drm/amdgpu/vpe: power on vpe when hw_init

Raag Jadav (1):
      ACPI: bus: allow _UID matching for integer zero

Rahul Rameshbabu (1):
      net/mlx5e: Do not produce metadata freelist entries in Tx port ts WQE xmit

Sean Christopherson (1):
      x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n

Shannon Nelson (1):
      pds_core: use pci_reset_function for health reset

Shay Drory (1):
      net/mlx5: Register devlink first under devlink lock

Stephen Boyd (1):
      drm/msm: Add newlines to some debug prints

Steve French (1):
      smb3: fix Open files on server counter going negative

Steven Rostedt (Google) (1):
      ring-buffer: Only update pages_touched when a new page is touched

Sven Eckelmann (1):
      batman-adv: Avoid infinite loop trying to resize local TT

Tim Harvey (2):
      arm64: dts: freescale: imx8mp-venice-gw72xx-2x: fix USB vbus regulator
      arm64: dts: freescale: imx8mp-venice-gw73xx-2x: fix USB vbus regulator

Tim Huang (2):
      drm/amd/pm: fixes a random hang in S4 for SMU v13.0.4/11
      drm/amdgpu: fix incorrect number of active RBs for gfx11

Vikas Gupta (2):
      bnxt_en: Fix possible memory leak in bnxt_rdma_aux_device_init()
      bnxt_en: Fix error recovery for RoCE ulp client

Ville Syrjälä (6):
      drm/i915/vrr: Disable VRR when using bigjoiner
      drm/client: Fully protect modes[] with dev->mode_config.mutex
      drm/i915/cdclk: Fix CDCLK programming order when pipes are active
      drm/i915/psr: Disable PSR when bigjoiner is used
      drm/i915: Disable port sync when bigjoiner is used
      drm/i915: Disable live M/N updates when using bigjoiner

Wachowski, Karol (2):
      accel/ivpu: Check return code of ipc->lock init
      accel/ivpu: Fix PCI D0 state entry in resume

Wenjing Liu (1):
      drm/amd/display: always reset ODM mode in context when adding first plane

Xiang Chen (1):
      scsi: hisi_sas: Modify the deadline for ata_wait_after_reset()

Xiubo Li (1):
      ceph: switch to use cap_delay_lock for the unlink delay list

Xuchun Shang (1):
      iommu/vt-d: Fix wrong use of pasid config

Yifan Zhang (1):
      drm/amdgpu: differentiate external rev id for gfx 11.5.0

Yu Kuai (1):
      raid1: fix use-after-free for original bio in raid1_write_request()

Yuquan Wang (1):
      cxl/mem: Fix for the index of Clear Event Record Handle

Zack Rusin (1):
      drm/vmwgfx: Enable DMA mappings with SEV

Zheng Yejian (1):
      kprobes: Fix possible use-after-free issue on kprobe registration

Zhenhua Huang (1):
      fs/proc: remove redundant comments from /proc/bootconfig


