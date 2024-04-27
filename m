Return-Path: <linux-kernel+bounces-161097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C56268B46F5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 17:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB44DB22375
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 15:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53288225D9;
	Sat, 27 Apr 2024 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZKIiU/bd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C47241206;
	Sat, 27 Apr 2024 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714233327; cv=none; b=U1VTo5ID5vEGDvANkecoaWrZVCvKmuOGeiE9ya5HAh1h6aEMrk2eCletkHjtJVnWYQnVlHXCUGWSvopKPMKXTHWzdFPCvZmW/H+zoRMg7/P8L9yKLXZidzcHmtAIxGIs2S4US94BmVzAZK8biR7JWMjRlllaqVSzYk6X9epQE18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714233327; c=relaxed/simple;
	bh=SxQNr6LRaoJ2DQRsh4sXciT2pmgypu9Oy+AZNpdHHRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V0KyT6eK9Eb1lMQW3MU2Sc3k5DPTLLHYyjJ7T8BrwdMG4RwD8zSUY8oE2bB1sVnWMOx+014VQtaRYTeUh88SNytVkuNCwkBIhCYd3EHE1YuY7JNaiblnKJKc5AlWJ7z6VwgeKA+FedKodMiwF5KbDy8dSiE7KoPf5pEi3VTWFwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZKIiU/bd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C60C113CE;
	Sat, 27 Apr 2024 15:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714233325;
	bh=SxQNr6LRaoJ2DQRsh4sXciT2pmgypu9Oy+AZNpdHHRE=;
	h=From:To:Cc:Subject:Date:From;
	b=ZKIiU/bdKfqpDkguktue98pWImWZG46i+g+B5qvkI3IWMMBUsLHkLmhdgjgl7URJz
	 u3oKieFyKPPdkMPMWOScYZMZopC1zgH63VQ0KrziVWwsQYqEL7UUW6KH8LaHoTw5BD
	 WpOZg2Qo99dbbVJIdiPFRbT4QzdlFiWWJWYI94H0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.8.8
Date: Sat, 27 Apr 2024 17:55:08 +0200
Message-ID: <2024042708-stooge-unmanaged-61e7@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.8.8 kernel.

All users of the 6.8 kernel series must upgrade.

The updated 6.8.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.8.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                        |    2 
 arch/arm64/kernel/head.S                                        |    5 
 arch/arm64/mm/pageattr.c                                        |    3 
 arch/x86/include/asm/barrier.h                                  |    3 
 arch/x86/include/asm/kvm_host.h                                 |    1 
 arch/x86/kernel/cpu/bugs.c                                      |   11 
 arch/x86/kernel/cpu/cpuid-deps.c                                |    6 
 arch/x86/kvm/cpuid.c                                            |    1 
 arch/x86/kvm/cpuid.h                                            |   10 
 arch/x86/kvm/lapic.c                                            |    3 
 arch/x86/kvm/mmu/mmu.c                                          |    5 
 arch/x86/kvm/mmu/tdp_mmu.c                                      |   21 -
 arch/x86/kvm/vmx/vmx.c                                          |   24 +
 arch/x86/kvm/x86.c                                              |    2 
 block/bdev.c                                                    |   29 +
 block/ioctl.c                                                   |    3 
 drivers/accessibility/speakup/main.c                            |    2 
 drivers/android/binder.c                                        |    4 
 drivers/char/random.c                                           |   10 
 drivers/clk/clk.c                                               |  161 +++++++--
 drivers/clk/mediatek/clk-mt7988-infracfg.c                      |    2 
 drivers/clk/mediatek/clk-mtk.c                                  |   15 
 drivers/comedi/drivers/vmk80xx.c                                |   35 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                         |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                          |   72 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                        |    4 
 drivers/gpu/drm/i915/display/intel_cdclk.c                      |   37 +-
 drivers/gpu/drm/nouveau/nouveau_bios.c                          |   13 
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c              |    7 
 drivers/gpu/drm/panel/panel-visionox-rm69299.c                  |    2 
 drivers/gpu/drm/radeon/radeon_atombios.c                        |    8 
 drivers/gpu/drm/ttm/ttm_pool.c                                  |   38 +-
 drivers/gpu/drm/v3d/v3d_irq.c                                   |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c                            |   35 +
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                              |    7 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h                              |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                             |    1 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                             |    3 
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c                             |   32 +
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                             |   11 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                             |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_prime.c                           |   15 
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c                      |   44 +-
 drivers/gpu/drm/xe/display/intel_fb_bo.c                        |    8 
 drivers/infiniband/core/cm.c                                    |   11 
 drivers/infiniband/hw/mlx5/mad.c                                |    3 
 drivers/infiniband/sw/rxe/rxe.c                                 |    2 
 drivers/interconnect/core.c                                     |    8 
 drivers/interconnect/qcom/x1e80100.c                            |   26 -
 drivers/iommu/iommufd/Kconfig                                   |    1 
 drivers/misc/cardreader/rtsx_pcr.c                              |    2 
 drivers/misc/mei/pci-me.c                                       |    2 
 drivers/misc/mei/platform-vsc.c                                 |   17 
 drivers/misc/mei/vsc-tp.c                                       |   84 +++-
 drivers/misc/mei/vsc-tp.h                                       |    3 
 drivers/net/dsa/mt7530.c                                        |   38 +-
 drivers/net/dsa/mt7530.h                                        |    5 
 drivers/net/ethernet/intel/ice/ice_tc_lib.c                     |   15 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c            |    7 
 drivers/net/ethernet/mediatek/mtk_wed.c                         |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c               |   27 -
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c               |    9 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c      |    4 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c               |    4 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                  |    5 
 drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c         |    1 
 drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c        |   61 ++-
 drivers/net/ethernet/realtek/r8169.h                            |    4 
 drivers/net/ethernet/realtek/r8169_leds.c                       |   23 -
 drivers/net/ethernet/realtek/r8169_main.c                       |    7 
 drivers/net/ethernet/renesas/ravb.h                             |    6 
 drivers/net/ethernet/renesas/ravb_main.c                        |   93 ++---
 drivers/net/ethernet/stmicro/stmmac/common.h                    |    1 
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c               |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c            |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c             |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c               |    7 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c             |   18 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c               |   29 -
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                        |   18 +
 drivers/net/tun.c                                               |   18 -
 drivers/net/usb/ax88179_178a.c                                  |    4 
 drivers/platform/x86/amd/pmc/pmc-quirks.c                       |    9 
 drivers/s390/cio/device.c                                       |   13 
 drivers/s390/cio/qdio_main.c                                    |   28 +
 drivers/s390/net/ism_drv.c                                      |   37 +-
 drivers/scsi/scsi_lib.c                                         |    7 
 drivers/thermal/thermal_debugfs.c                               |    1 
 drivers/thunderbolt/domain.c                                    |    5 
 drivers/thunderbolt/icm.c                                       |    2 
 drivers/thunderbolt/lc.c                                        |   45 ++
 drivers/thunderbolt/nhi.c                                       |   19 -
 drivers/thunderbolt/path.c                                      |   13 
 drivers/thunderbolt/switch.c                                    |  178 ++++++++--
 drivers/thunderbolt/tb.c                                        |   44 +-
 drivers/thunderbolt/tb.h                                        |   10 
 drivers/thunderbolt/tb_regs.h                                   |    6 
 drivers/thunderbolt/usb4.c                                      |   52 ++
 drivers/tty/serial/8250/8250_dw.c                               |    6 
 drivers/tty/serial/mxs-auart.c                                  |    8 
 drivers/tty/serial/pmac_zilog.c                                 |   14 
 drivers/tty/serial/serial_base.h                                |    4 
 drivers/tty/serial/serial_core.c                                |   23 +
 drivers/tty/serial/serial_port.c                                |   34 +
 drivers/tty/serial/stm32-usart.c                                |   13 
 drivers/ufs/host/ufs-qcom.c                                     |    8 
 drivers/usb/class/cdc-wdm.c                                     |    6 
 drivers/usb/core/port.c                                         |    4 
 drivers/usb/dwc2/hcd_ddma.c                                     |    4 
 drivers/usb/gadget/function/f_ncm.c                             |    4 
 drivers/usb/misc/onboard_usb_hub.c                              |    6 
 drivers/usb/serial/option.c                                     |   40 ++
 drivers/usb/typec/tcpm/tcpm.c                                   |    4 
 drivers/virt/vmgenid.c                                          |    2 
 fs/btrfs/extent_io.c                                            |   20 -
 fs/fuse/dir.c                                                   |    1 
 fs/nfsd/nfs4xdr.c                                               |   47 +-
 fs/nilfs2/dir.c                                                 |    2 
 fs/smb/common/smb2pdu.h                                         |    2 
 fs/smb/server/server.c                                          |   13 
 fs/smb/server/smb2pdu.c                                         |    4 
 fs/smb/server/vfs.c                                             |    5 
 fs/squashfs/inode.c                                             |    5 
 fs/sysfs/file.c                                                 |    2 
 include/asm-generic/barrier.h                                   |    8 
 include/linux/blkdev.h                                          |    2 
 include/linux/bootconfig.h                                      |    7 
 include/linux/gpio/property.h                                   |    1 
 include/linux/shmem_fs.h                                        |    9 
 include/linux/swapops.h                                         |   65 +--
 include/linux/udp.h                                             |    2 
 include/net/netfilter/nf_flow_table.h                           |   12 
 include/net/netfilter/nf_tables.h                               |   14 
 include/net/sch_generic.h                                       |    1 
 include/trace/events/rpcgss.h                                   |    4 
 init/main.c                                                     |    2 
 io_uring/io_uring.c                                             |   26 -
 kernel/fork.c                                                   |   33 -
 kernel/sched/sched.h                                            |   20 -
 lib/bootconfig.c                                                |   19 -
 mm/gup.c                                                        |   54 +--
 mm/huge_memory.c                                                |    6 
 mm/hugetlb.c                                                    |   10 
 mm/internal.h                                                   |   10 
 mm/madvise.c                                                    |   17 
 mm/memory-failure.c                                             |   18 -
 mm/shmem.c                                                      |    6 
 net/bridge/br_input.c                                           |   15 
 net/bridge/br_netfilter_hooks.c                                 |    6 
 net/bridge/br_private.h                                         |    1 
 net/bridge/netfilter/nf_conntrack_bridge.c                      |   14 
 net/core/dev.c                                                  |    6 
 net/netfilter/nf_flow_table_inet.c                              |    3 
 net/netfilter/nf_flow_table_ip.c                                |   10 
 net/netfilter/nf_tables_api.c                                   |   82 ++++
 net/netfilter/nft_lookup.c                                      |    1 
 net/netfilter/nft_set_bitmap.c                                  |    4 
 net/netfilter/nft_set_hash.c                                    |    8 
 net/netfilter/nft_set_pipapo.c                                  |   43 +-
 net/netfilter/nft_set_pipapo.h                                  |    6 
 net/netfilter/nft_set_pipapo_avx2.c                             |   59 +--
 net/netfilter/nft_set_rbtree.c                                  |    4 
 net/sched/sch_generic.c                                         |    1 
 net/unix/af_unix.c                                              |   12 
 sound/core/seq/seq_ump_convert.c                                |    2 
 sound/pci/hda/patch_realtek.c                                   |    7 
 sound/pci/hda/tas2781_hda_i2c.c                                 |    4 
 tools/perf/ui/browsers/annotate.c                               |    2 
 tools/perf/util/annotate.c                                      |    3 
 tools/perf/util/bpf_skel/lock_contention.bpf.c                  |    5 
 tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc |    6 
 tools/testing/selftests/iommu/config                            |    2 
 tools/testing/selftests/net/tcp_ao/lib/proc.c                   |    2 
 tools/testing/selftests/net/tcp_ao/lib/setup.c                  |   12 
 tools/testing/selftests/net/tcp_ao/rst.c                        |   23 -
 tools/testing/selftests/net/tcp_ao/setsockopt-closed.c          |    2 
 tools/testing/selftests/net/udpgso.c                            |    2 
 tools/testing/selftests/powerpc/papr_vpd/papr_vpd.c             |    2 
 178 files changed, 1902 insertions(+), 827 deletions(-)

Ai Chao (1):
      ALSA: hda/realtek - Enable audio jacks of Haier Boyue G42 with ALC269VC

Alan Stern (1):
      fs: sysfs: Fix reference leak in sysfs_break_active_protection()

Alex Deucher (1):
      drm/radeon: make -fstrict-flex-arrays=3 happy

Alexander Usyskin (1):
      mei: me: disable RPL-S on SPS and IGN firmwares

Alexey Izbyshev (1):
      io_uring: Fix io_cqring_wait() not restoring sigmask on get_timespec64() failure

Andy Shevchenko (2):
      gpiolib: swnode: Remove wrong header inclusion
      serial: core: Clearing the circular buffer before NULLifying it

Ard Biesheuvel (1):
      arm64/head: Disable MMU at EL2 before clearing HCR_EL2.E2H

Arınç ÜNAL (4):
      net: dsa: mt7530: fix mirroring frames received on local port
      net: dsa: mt7530: fix port mirroring for MT7988 SoC switch
      net: dsa: mt7530: fix improper frames on all 25MHz and 40MHz XTAL MT7530
      net: dsa: mt7530: fix enabling EEE on MT7531 switch on all boards

Asbjørn Sloth Tønnesen (2):
      net: sparx5: flower: fix fragment flags handling
      octeontx2-pf: fix FLOW_DIS_IS_FRAGMENT implementation

Bart Van Assche (1):
      scsi: core: Fix handling of SCMD_FAIL_IF_RECOVERING

Carlos Llamas (1):
      binder: check offset alignment in binder_get_object()

Carolina Jubran (1):
      net/mlx5e: Prevent deadlock while disabling aRFS

Christian König (2):
      drm/amdgpu: remove invalid resource->start check v2
      drm/ttm: stop pooling cached NUMA pages v2

Christoph Hellwig (1):
      block: propagate partition scanning errors to the BLKRRPART ioctl

Chuanhong Guo (1):
      USB: serial: option: add support for Fibocom FM650/FG650

Coia Prant (1):
      USB: serial: option: add Lonsung U8300/U9300 product

Daniel Golle (1):
      clk: mediatek: mt7988-infracfg: fix clocks for 2nd PCIe port

Daniele Palmas (1):
      USB: serial: option: add Telit FN920C04 rmnet compositions

Danny Lin (1):
      fuse: fix leaked ENOSYS error on first statx call

Dave Airlie (1):
      nouveau: fix instmem race condition around ptr stores

David Hildenbrand (1):
      mm/madvise: make MADV_POPULATE_(READ|WRITE) handle VM_FAULT_RETRY properly

David Matlack (1):
      KVM: x86/mmu: Write-protect L2 SPTEs in TDP MMU when clearing dirty status

Dmitry Baryshkov (1):
      drm/panel: visionox-rm69299: don't unregister DSI device

Dmitry Safonov (4):
      selftests/tcp_ao: Make RST tests less flaky
      selftests/tcp_ao: Zero-init tcp_ao_info_opt
      selftests/tcp_ao: Fix fscanf() call for format-security
      selftests/tcp_ao: Printing fixes to confirm with format-security

Emil Kronborg (1):
      serial: mxs-auart: add spinlock around changing cts state

Eric Biggers (1):
      x86/cpufeatures: Fix dependencies for GFNI, VAES, and VPCLMULQDQ

Eric Dumazet (1):
      net/sched: Fix mirred deadlock on device recursion

Fabio Estevam (1):
      usb: misc: onboard_usb_hub: Disable the USB hub clock on failure

Felix Fietkau (1):
      net: ethernet: mtk_eth_soc: fix WED + wifi reset

Felix Kuehling (1):
      drm/amdkfd: Fix memory leak in create_process failure

Finn Thain (1):
      serial/pmac_zilog: Remove flawed mitigation for rx irq flood

Florian Westphal (2):
      netfilter: nft_set_pipapo: constify lookup fn args where possible
      netfilter: nft_set_pipapo: do not free live element

Gerd Bayer (1):
      s390/ism: Properly fix receive message buffer allocation

Gil Fine (2):
      thunderbolt: Avoid notify PM core about runtime PM resume
      thunderbolt: Fix wake configurations after device unplug

Greg Kroah-Hartman (2):
      Revert "usb: cdc-wdm: close race between read and workqueue"
      Linux 6.8.8

Hans de Goede (1):
      serial: 8250_dw: Revert: Do not reclock if already at correct rate

Heiner Kallweit (2):
      r8169: fix LED-related deadlock on module removal
      r8169: add missing conditional compiling for call to r8169_remove_leds

Huayu Zhang (1):
      ALSA: hda/realtek: Fix volumn control of ThinkBook 16P Gen4

Jason A. Donenfeld (2):
      Revert "vmgenid: emit uevent when VMGENID updates"
      random: handle creditable entropy from atomic process context

Jason Gunthorpe (1):
      iommufd: Add missing IOMMUFD_DRIVER kconfig for the selftest

Jeongjun Park (1):
      nilfs2: fix OOB in nilfs_set_de_type

Jerry Meng (1):
      USB: serial: option: support Quectel EM060K sub-models

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: avoid writing the mac address before first reading

Josh Poimboeuf (1):
      x86/bugs: Fix BHI retpoline check

Kai-Heng Feng (1):
      usb: Disable USB3 LPM at shutdown

Konrad Dybcio (1):
      interconnect: qcom: x1e80100: Remove inexistent ACV_PERF BCM

Kuniyuki Iwashima (2):
      af_unix: Call manage_oob() for every skb in unix_stream_read_generic().
      af_unix: Don't peek OOB data without MSG_OOB.

Kyle Tso (1):
      usb: typec: tcpm: Correct the PDO counting in pd_set

Lei Chen (1):
      tun: limit printing rate when illegal packet received by tun dev

Lokesh Gidra (1):
      userfaultfd: change src_folio after ensuring it's unpinned in UFFDIO_MOVE

Maarten Lankhorst (1):
      drm/xe: Fix bo leak in intel_fb_bo_framebuffer_init

Manivannan Sadhasivam (1):
      scsi: ufs: qcom: Add missing interconnect bandwidth values for Gear 5

Marcin Szycik (1):
      ice: Fix checking for unsupported keys on non-tunnel device

Mario Limonciello (1):
      platform/x86/amd/pmc: Extend Framework 13 quirk to more BIOSes

Marios Makassikis (1):
      ksmbd: clear RENAME_NOREPLACE before calling vfs_rename

Mark Zhang (1):
      RDMA/cm: Print the old state when cm_destroy_id gets timeout

Mathieu Desnoyers (1):
      sched: Add missing memory barrier in switch_mm_cid

Mauro Carvalho Chehab (1):
      ALSA: hda/realtek: Add quirks for Huawei Matebook D14 NBLB-WAX9N

Maíra Canal (1):
      drm/v3d: Don't increment `enabled_ns` twice

Miaohe Lin (2):
      mm/memory-failure: fix deadlock when hugetlb_optimize_vmemmap is enabled
      fork: defer linking file vma until vma is fully initialized

Michael Guralnik (1):
      RDMA/mlx5: Fix port number for counter query in multi-port configuration

Michal Swiatkowski (2):
      ice: tc: check src_vsi in case of traffic from VF
      ice: tc: allow zero flags in parsing tc flower

Mika Westerberg (2):
      thunderbolt: Do not create DisplayPort tunnels on adapters of the same router
      thunderbolt: Reset only non-USB4 host routers in resume

Mike Tipton (1):
      interconnect: Don't access req_list while it's being manipulated

Mikhail Kobuk (1):
      drm: nv04: Fix out of bounds access

Minas Harutyunyan (1):
      usb: dwc2: host: Fix dereference issue in DDMA completion flow.

Muhammad Usama Anjum (1):
      iommufd: Add config needed for iommufd_fail_nth

Namhyung Kim (2):
      perf annotate: Make sure to call symbol__annotate2() in TUI
      perf lock contention: Add a missing NULL check

Namjae Jeon (3):
      ksmbd: fix slab-out-of-bounds in smb2_allocate_rsp_buf
      ksmbd: validate request buffer size in smb2_allocate_rsp_buf()
      ksmbd: common: use struct_group_attr instead of struct_group for network_open_info

Naohiro Aota (1):
      btrfs: zoned: do not flag ZEROOUT on non-dirty extent buffer

Nathan Lynch (1):
      selftests/powerpc/papr-vpd: Fix missing variable initialization

Nikita Zhandarovich (1):
      comedi: vmk80xx: fix incomplete endpoint checking

Niklas Söderlund (1):
      ravb: Group descriptor types used in Rx ring

Norihiko Hama (1):
      usb: gadget: f_ncm: Fix UAF ncm object at re-bind after usb ep transport error

Oscar Salvador (1):
      mm,swapops: update check in is_pfn_swap_entry for hwpoison entries

Pablo Neira Ayuso (7):
      netfilter: br_netfilter: skip conntrack input hook for promisc packets
      netfilter: nft_set_pipapo: walk over current view on netlink dump
      netfilter: flowtable: validate pppoe header
      netfilter: flowtable: incorrect pppoe tuple
      netfilter: nf_tables: missing iterator type in lookup walk
      netfilter: nf_tables: restore set elements when delete set fails
      netfilter: nf_tables: fix memleak in map from abort path

Paul Barker (2):
      net: ravb: Count packets instead of descriptors in R-Car RX path
      net: ravb: Allow RX loop to move past DMA mapping errors

Peter Oberparleiter (2):
      s390/qdio: handle deferred cc1
      s390/cio: fix race condition during online processing

Peter Xu (1):
      mm/userfaultfd: allow hugetlb change protection upon poison entry

Phillip Lougher (1):
      Squashfs: check the inode number is not the invalid value of zero

Pin-yen Lin (1):
      clk: mediatek: Do a runtime PM get on controllers during probe

Qiang Zhang (1):
      bootconfig: use memblock_free_late to free xbc memory to buddy

Qu Wenruo (1):
      btrfs: do not wait for short bulk allocation

Rafael J. Wysocki (1):
      thermal/debugfs: Add missing count increment to thermal_debug_tz_trip_up()

Rick Edgecombe (1):
      KVM: x86/mmu: x86: Don't overflow lpage_info when checking attributes

Ricky Wu (1):
      misc: rtsx: Fix rts5264 driver status incorrect when card removed

Sakari Ailus (2):
      Revert "mei: vsc: Call wake_up() in the threaded IRQ handler"
      mei: vsc: Unregister interrupt handler for system suspend

Samuel Thibault (1):
      speakup: Avoid crash on very long word

Sanath S (4):
      thunderbolt: Introduce tb_port_reset()
      thunderbolt: Introduce tb_path_deactivate_hop()
      thunderbolt: Make tb_switch_reset() support Thunderbolt 2, 3 and USB4 routers
      thunderbolt: Reset topology created by the boot firmware

Sandipan Das (1):
      KVM: x86/pmu: Do not mask LVTPC when handling a PMI on AMD platforms

Sean Christopherson (2):
      KVM: x86: Snapshot if a vCPU's vendor model is AMD vs. Intel compatible
      KVM: x86/pmu: Disable support for adaptive PEBS

Serge Semin (3):
      net: stmmac: Apply half-duplex-less constraint for DW QoS Eth only
      net: stmmac: Fix max-speed being ignored on queue re-init
      net: stmmac: Fix IP-cores specific MAC capabilities

Shay Drory (3):
      net/mlx5: Lag, restore buckets number to default after hash LAG deactivation
      net/mlx5: Restore mistakenly dropped parts in register devlink flow
      net/mlx5: E-switch, store eswitch pointer before registering devlink_param

Shenghao Ding (2):
      ALSA: hda/tas2781: correct the register for pow calibrated data
      ALSA: hda/tas2781: Add new vendor_id and subsystem_id to support ThinkPad ICE-1

Siddharth Vadapalli (1):
      net: ethernet: ti: am65-cpsw-nuss: cleanup DMA Channels before using them

Stephen Boyd (4):
      clk: Remove prepare_lock hold assertion in __clk_release()
      clk: Initialize struct clk_core kref earlier
      clk: Get runtime PM before walking tree during disable_unused
      clk: Get runtime PM before walking tree for clk_summary

Steven Rostedt (Google) (1):
      SUNRPC: Fix rpcgss_context trace event acceptor field

Sumanth Korikkar (1):
      mm/shmem: inline shmem_is_huge() for disabled transparent hugepages

Takashi Iwai (1):
      ALSA: seq: ump: Fix conversion from MIDI2 to MIDI1 UMP messages

Tony Lindgren (2):
      serial: core: Fix regression when runtime PM is not enabled
      serial: core: Fix missing shutdown and startup for serial base port

Uwe Kleine-König (2):
      serial: stm32: Return IRQ_NONE in the ISR if no handling happend
      serial: stm32: Reset .throttled state in .startup()

Vanillan Wang (1):
      USB: serial: option: add Rolling RW101-GL and RW135-GL support

Vasily Gorbik (1):
      NFSD: fix endianness issue in nfsd4_encode_fattr4

Ville Syrjälä (1):
      drm/i915/cdclk: Fix voltage_level programming edge case

Yanjun.Zhu (1):
      RDMA/rxe: Fix the problem "mutex_destroy missing"

Yaxiong Tian (1):
      arm64: hibernate: Fix level3 translation fault in swsusp_save()

Yuanhe Shu (1):
      selftests/ftrace: Limit length in subsystem-enable tests

Yuntao Wang (1):
      init/main.c: Fix potential static_command_line memory overflow

Yuri Benditovich (1):
      net: change maximum number of UDP segments to 128

Zack Rusin (3):
      drm/vmwgfx: Fix prime import/export
      drm/vmwgfx: Sort primary plane formats by order of preference
      drm/vmwgfx: Fix crtc's atomic check conditional

Ziyang Xuan (2):
      netfilter: nf_tables: Fix potential data-race in __nft_expr_type_get()
      netfilter: nf_tables: Fix potential data-race in __nft_obj_type_get()

bolan wang (1):
      USB: serial: option: add Fibocom FM135-GL variants

xinhui pan (1):
      drm/amdgpu: validate the parameters of bo mapping operations more clearly


