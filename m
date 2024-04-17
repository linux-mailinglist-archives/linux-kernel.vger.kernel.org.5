Return-Path: <linux-kernel+bounces-148250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D55068A7FD8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D1B1F226AB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC5813AD11;
	Wed, 17 Apr 2024 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e43yW1fT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26C11332B5;
	Wed, 17 Apr 2024 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346504; cv=none; b=Z/bQqSU94w0GiT3xmDQvso+N2BCFvnPqBTwRXcLYujHKRY1C5kzRixwv+f7vecxZ1hwpUSy5kmySBqVqrpPUO1/0nt7HyZKUU/CIzoFW6/+eyfBPDmQ9SmTLsDIved541RKPIKzxmYMILL7lxQropKrID3KJoehQpwnWmIAbtbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346504; c=relaxed/simple;
	bh=dvF31Zf6apkbRuJphqcTQxrfhbZxCKFk9fHnzDxxM2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Agrj9XXImgdFFknR46wlrkd9Q2pbyja5TyDfL3BezIZEQMT7/hDru3nBEfR49t/V8DJbT/fvD7y8S5qO1Cz02/tA/pHpA4AnVcH1D/O6+mtqaolinv1GazqBzyGWBF8PqBZBYBPEbg/pv+kTVuGOVAeBYtMUhg9C8P1EOY2aebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e43yW1fT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDAEC072AA;
	Wed, 17 Apr 2024 09:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713346503;
	bh=dvF31Zf6apkbRuJphqcTQxrfhbZxCKFk9fHnzDxxM2A=;
	h=From:To:Cc:Subject:Date:From;
	b=e43yW1fTAC/MKX48gKfuiMb7qWUmKr81PR7ErBAas95BpM9ik/GWbuQqe1Aw2E8LV
	 xPo/vZAOpcWOfedxwnnLJAYo6PijIIbBtvqx/v0cnCsHcaw+yUbG65v/mjhI1qQScV
	 fN7OvxGAwgaYOwlVAaQbsRMVW5S3MmS7BygvUPns=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.28
Date: Wed, 17 Apr 2024 11:34:58 +0200
Message-ID: <2024041758-unvaried-agreement-8d7b@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.28 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/hw-vuln/spectre.rst                   |   22 
 Documentation/admin-guide/kernel-parameters.txt                 |   12 
 Documentation/networking/device_drivers/ethernet/amazon/ena.rst |    1 
 Makefile                                                        |    2 
 arch/arm/boot/dts/nxp/imx/imx7s-warp.dts                        |    1 
 arch/arm/mach-omap2/board-n8x0.c                                |   23 
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi                 |   16 
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi                  |   36 
 arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi                 |   16 
 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi                |    8 
 arch/x86/Kconfig                                                |   21 
 arch/x86/events/core.c                                          |    1 
 arch/x86/include/asm/apic.h                                     |    3 
 arch/x86/kernel/apic/apic.c                                     |    6 
 arch/x86/kernel/cpu/bugs.c                                      |   82 -
 arch/x86/kernel/cpu/common.c                                    |   48 
 block/blk-cgroup.c                                              |    9 
 block/blk-cgroup.h                                              |    2 
 block/blk-core.c                                                |    2 
 drivers/accel/ivpu/ivpu_drv.c                                   |    2 
 drivers/acpi/scan.c                                             |    3 
 drivers/ata/libata-core.c                                       |    2 
 drivers/ata/libata-scsi.c                                       |    9 
 drivers/cxl/core/mbox.c                                         |    5 
 drivers/cxl/core/regs.c                                         |    5 
 drivers/firmware/arm_scmi/raw_mode.c                            |    7 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                          |    2 
 drivers/gpu/drm/amd/amdgpu/soc21.c                              |   27 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c           |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c               |   15 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c  |   19 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c            |   12 
 drivers/gpu/drm/ast/ast_dp.c                                    |    3 
 drivers/gpu/drm/drm_client_modeset.c                            |    3 
 drivers/gpu/drm/i915/display/intel_cdclk.c                      |    7 
 drivers/gpu/drm/i915/display/intel_cdclk.h                      |    3 
 drivers/gpu/drm/i915/display/intel_ddi.c                        |    5 
 drivers/gpu/drm/i915/display/intel_vrr.c                        |    7 
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c                   |   10 
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c             |    7 
 drivers/gpu/drm/panfrost/panfrost_mmu.c                         |   13 
 drivers/gpu/drm/qxl/qxl_release.c                               |   50 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                             |   11 
 drivers/iommu/intel/perfmon.c                                   |    2 
 drivers/iommu/intel/svm.c                                       |    2 
 drivers/md/raid1.c                                              |    2 
 drivers/media/cec/core/cec-adap.c                               |   14 
 drivers/mmc/host/omap.c                                         |   48 
 drivers/net/dsa/mt7530.c                                        |  229 ++-
 drivers/net/dsa/mt7530.h                                        |    5 
 drivers/net/ethernet/amazon/ena/Makefile                        |    2 
 drivers/net/ethernet/amazon/ena/ena_com.c                       |    2 
 drivers/net/ethernet/amazon/ena/ena_ethtool.c                   |    1 
 drivers/net/ethernet/amazon/ena/ena_netdev.c                    |  688 ----------
 drivers/net/ethernet/amazon/ena/ena_netdev.h                    |   83 -
 drivers/net/ethernet/amazon/ena/ena_xdp.c                       |  466 ++++++
 drivers/net/ethernet/amazon/ena/ena_xdp.h                       |  152 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                       |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c                   |    6 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c             |   20 
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c                |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h                |    8 
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c                |   33 
 drivers/net/ethernet/mellanox/mlx5/core/en/selq.c               |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c               |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c                 |    7 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c               |   17 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                  |   37 
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c               |    4 
 drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c         |   22 
 drivers/net/ethernet/micrel/ks8851.h                            |    3 
 drivers/net/ethernet/micrel/ks8851_common.c                     |   16 
 drivers/net/ethernet/micrel/ks8851_par.c                        |   11 
 drivers/net/ethernet/micrel/ks8851_spi.c                        |   11 
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c             |    4 
 drivers/net/geneve.c                                            |    4 
 drivers/platform/chrome/cros_ec_uart.c                          |   28 
 drivers/scsi/hisi_sas/hisi_sas_main.c                           |    2 
 drivers/scsi/qla2xxx/qla_edif.c                                 |    2 
 drivers/scsi/sg.c                                               |   20 
 drivers/vhost/vhost.c                                           |   24 
 fs/btrfs/delayed-inode.c                                        |    3 
 fs/btrfs/inode.c                                                |   13 
 fs/btrfs/ioctl.c                                                |   37 
 fs/btrfs/qgroup.c                                               |    2 
 fs/btrfs/root-tree.c                                            |   10 
 fs/btrfs/root-tree.h                                            |    2 
 fs/btrfs/transaction.c                                          |   17 
 fs/smb/client/cached_dir.c                                      |    4 
 include/linux/dma-fence.h                                       |    7 
 include/linux/irqflags.h                                        |    2 
 include/linux/u64_stats_sync.h                                  |    9 
 include/net/addrconf.h                                          |    4 
 include/net/af_unix.h                                           |    2 
 include/net/bluetooth/bluetooth.h                               |   11 
 include/net/ip_tunnels.h                                        |   33 
 io_uring/net.c                                                  |    1 
 kernel/cpu.c                                                    |    3 
 kernel/kprobes.c                                                |   18 
 kernel/power/suspend.c                                          |    6 
 kernel/trace/ring_buffer.c                                      |    6 
 kernel/trace/trace_events.c                                     |    4 
 net/batman-adv/translation-table.c                              |    2 
 net/bluetooth/hci_request.c                                     |    4 
 net/bluetooth/hci_sync.c                                        |   66 
 net/bluetooth/iso.c                                             |   14 
 net/bluetooth/l2cap_core.c                                      |    3 
 net/bluetooth/sco.c                                             |   23 
 net/ipv4/netfilter/arp_tables.c                                 |    4 
 net/ipv4/netfilter/ip_tables.c                                  |    4 
 net/ipv4/route.c                                                |    4 
 net/ipv6/addrconf.c                                             |    7 
 net/ipv6/ip6_fib.c                                              |    7 
 net/ipv6/netfilter/ip6_tables.c                                 |    4 
 net/openvswitch/conntrack.c                                     |    5 
 net/unix/af_unix.c                                              |    8 
 net/unix/garbage.c                                              |   35 
 net/unix/scm.c                                                  |    8 
 net/xdp/xsk.c                                                   |    2 
 tools/testing/selftests/net/mptcp/mptcp_connect.sh              |   53 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                 |   30 
 tools/testing/selftests/timers/posix_timers.c                   |    2 
 122 files changed, 1750 insertions(+), 1250 deletions(-)

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

Alexander Wetzel (2):
      scsi: sg: Avoid sg device teardown race
      scsi: sg: Avoid race in error handling & drop bogus warn

Anna-Maria Behnsen (1):
      PM: s2idle: Make sure CPUs will wakeup directly on resume

Archie Pusaka (1):
      Bluetooth: l2cap: Don't double set the HCI_CONN_MGMT_CONNECTED bit

Arnd Bergmann (5):
      nouveau: fix function cast warning
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

Carolina Jubran (2):
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

Dave Jiang (1):
      cxl/core/regs: Fix usage of map->reg_type in cxl_decode_regblock() before assigned

David Arinzon (7):
      net: ena: Fix potential sign extension issue
      net: ena: Wrong missing IO completions check order
      net: ena: Fix incorrect descriptor free behavior
      net: ena: Move XDP code to its new files
      net: ena: Pass ena_adapter instead of net_device to ena_xmit_common()
      net: ena: Use tx_ring instead of xdp_ring for XDP channel TX
      net: ena: Set tx_info->xdpf value to NULL

Dmitry Antipov (1):
      Bluetooth: Fix memory leak in hci_req_sync_complete()

Dmitry Baryshkov (1):
      drm/msm/dpu: don't allow overriding data from catalog

Eric Dumazet (3):
      xsk: validate user input for XDP_{UMEM|COMPLETION}_FILL_RING
      geneve: fix header validation in geneve[6]_xmit_skb
      netfilter: complete validation of user input

Fabio Estevam (1):
      ARM: dts: imx7s-warp: Pass OV2680 link-frequencies

Frank Li (7):
      arm64: dts: imx8-ss-conn: fix usdhc wrong lpcg clock order
      arm64: dts: imx8qm-ss-dma: fix can lpcg indices
      arm64: dts: imx8-ss-dma: fix can lpcg indices
      arm64: dts: imx8-ss-dma: fix adc lpcg indices
      arm64: dts: imx8-ss-conn: fix usb lpcg indices
      arm64: dts: imx8-ss-lsio: fix pwm lpcg indices
      arm64: dts: imx8-ss-dma: fix spi lpcg indices

Fudongwang (1):
      drm/amd/display: fix disable otg wa logic in DCN316

Gavin Shan (2):
      vhost: Add smp_rmb() in vhost_vq_avail_empty()
      vhost: Add smp_rmb() in vhost_enable_notify()

Geetha sowjanya (1):
      octeontx2-af: Fix NIX SQ mode and BP config

Geliang Tang (1):
      selftests: mptcp: use += operator to append strings

Gerd Bayer (2):
      s390/ism: fix receive message buffer allocation
      Revert "s390/ism: fix receive message buffer allocation"

Greg Kroah-Hartman (1):
      Linux 6.6.28

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

Jacek Lawrynowicz (1):
      accel/ivpu: Fix deadlock in context_xa

Jacob Pan (1):
      iommu/vt-d: Allocate local memory for page request queue

Jammy Huang (1):
      drm/ast: Fix soft lockup

Jiri Benc (1):
      ipv6: fix race condition between ipv6_get_ifaddr and ipv6_del_addr

John Stultz (1):
      selftests: timers: Fix abs() warning in posix_timers test

Josh Poimboeuf (6):
      x86/bugs: Fix BHI documentation
      x86/bugs: Cache the value of MSR_IA32_ARCH_CAPABILITIES
      x86/bugs: Fix BHI handling of RRSBA
      x86/bugs: Clarify that syscall hardening isn't a BHI mitigation
      x86/bugs: Remove CONFIG_BHI_MITIGATION_AUTO and spectre_bhi=auto
      x86/bugs: Replace CONFIG_SPECTRE_BHI_{ON,OFF} with CONFIG_MITIGATION_SPECTRE_BHI

Kuniyuki Iwashima (2):
      af_unix: Clear stale u->oob_skb.
      af_unix: Do not use atomic ops for unix_sk(sk)->inflight.

Kwangjin Ko (1):
      cxl/core: Fix initialization of mbox_cmd.size_out in get event

Lijo Lazar (1):
      drm/amdgpu: Reset dGPU if suspend got aborted

Luiz Augusto von Dentz (5):
      Bluetooth: ISO: Align broadcast sync_timeout with connection timeout
      Bluetooth: ISO: Don't reject BT_ISO_QOS if parameters are unset
      Bluetooth: hci_sync: Use QoS to determine which PHY to scan
      Bluetooth: hci_sync: Fix using the same interval and window for Coded PHY
      Bluetooth: SCO: Fix not validating setsockopt user input

Marek Vasut (2):
      net: ks8851: Inline ks8851_rx_skb()
      net: ks8851: Handle softirqs at the end of IRQ thread to fix hang

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

Nini Song (1):
      media: cec: core: remove length check of Timer Status

Noah Loomans (1):
      platform/chrome: cros_ec_uart: properly fix race condition

Pavan Chebbi (1):
      bnxt_en: Reset PTP tx_avail after possible firmware reset

Pavel Begunkov (1):
      io_uring/net: restore msg_control on sendzc retry

Petr Tesarik (1):
      u64_stats: fix u64_stats_init() for lockdep when used repeatedly in one file

Rahul Rameshbabu (1):
      net/mlx5e: Do not produce metadata freelist entries in Tx port ts WQE xmit

Sean Christopherson (1):
      x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n

Shay Drory (1):
      net/mlx5: Register devlink first under devlink lock

Steve French (1):
      smb3: fix Open files on server counter going negative

Steven Rostedt (Google) (1):
      ring-buffer: Only update pages_touched when a new page is touched

Sven Eckelmann (1):
      batman-adv: Avoid infinite loop trying to resize local TT

Tim Huang (2):
      drm/amd/pm: fixes a random hang in S4 for SMU v13.0.4/11
      drm/amdgpu: fix incorrect number of active RBs for gfx11

Vikas Gupta (2):
      bnxt_en: Fix possible memory leak in bnxt_rdma_aux_device_init()
      bnxt_en: Fix error recovery for RoCE ulp client

Ville Syrjälä (4):
      drm/i915/vrr: Disable VRR when using bigjoiner
      drm/client: Fully protect modes[] with dev->mode_config.mutex
      drm/i915/cdclk: Fix CDCLK programming order when pipes are active
      drm/i915: Disable port sync when bigjoiner is used

Xiang Chen (1):
      scsi: hisi_sas: Modify the deadline for ata_wait_after_reset()

Xuchun Shang (1):
      iommu/vt-d: Fix wrong use of pasid config

Yu Kuai (1):
      raid1: fix use-after-free for original bio in raid1_write_request()

Yuquan Wang (1):
      cxl/mem: Fix for the index of Clear Event Record Handle

Zack Rusin (1):
      drm/vmwgfx: Enable DMA mappings with SEV

Zheng Yejian (1):
      kprobes: Fix possible use-after-free issue on kprobe registration


