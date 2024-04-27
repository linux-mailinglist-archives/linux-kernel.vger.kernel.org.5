Return-Path: <linux-kernel+bounces-161094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B598B46EF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 17:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C233D282BCE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 15:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE9329409;
	Sat, 27 Apr 2024 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="acQVl4gJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FD11DDEA;
	Sat, 27 Apr 2024 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714233312; cv=none; b=hMo0ucNSU37RCFAUaOPPg18Q0OvN1lAv5L3mPXH0wU47c/P97PyN3uk7zLMmSPmSZcBFT2QYcIKHqNuXCy4v95lOG4CAMNjQD4fy1C6Rahs8zAG1+x1+FD5vlGIvyNFAh7ed/yfu7z99xaH+I6Yd4krbb8/NlK717c6gn8CGSS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714233312; c=relaxed/simple;
	bh=ZY0vH5XKKF+GxnZSPoqKrUjB3krw8DUv9Ngl1xAkcJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ghplbqtUlgVgg04wIT6gJ4AbExfpdQYin0cuM6E8CuNWZuWqG6dc914IN2ws4jC7RSZnnhjDSacrxhyj9D7Nqaz5YxreDSsNsdPM1nLCy5bEy/krrMVxAL0WHOPclL0GCwRepfW4nwY1BbYdcH05+6iN2WRaheMlNqcsoq1DREU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=acQVl4gJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B2CC32781;
	Sat, 27 Apr 2024 15:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714233311;
	bh=ZY0vH5XKKF+GxnZSPoqKrUjB3krw8DUv9Ngl1xAkcJU=;
	h=From:To:Cc:Subject:Date:From;
	b=acQVl4gJ/vlw2KzD/NCe6W0ENDhwlISs+ia1UrBvcwyb+j+aV0jaYEaz6jj/40qjN
	 Rc6oZrsDgvTWWRjBJ/sxdsfB+spOfcdbDkrz3ziA14GfixDeMtPWoGB8PzYKmzBX9I
	 bU4RzHA0BGyc33b3Qggr/JPpflGKPZztpeteaayM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.29
Date: Sat, 27 Apr 2024 17:55:01 +0200
Message-ID: <2024042702-campus-huff-2d58@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.29 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt                 |    3 
 MAINTAINERS                                                     |    2 
 Makefile                                                        |    2 
 arch/arm/mach-omap2/pdata-quirks.c                              |   10 
 arch/arm64/include/asm/tlbflush.h                               |   40 
 arch/arm64/kernel/head.S                                        |    5 
 arch/arm64/mm/pageattr.c                                        |    3 
 arch/powerpc/include/asm/ftrace.h                               |   10 
 arch/powerpc/include/asm/sections.h                             |    1 
 arch/powerpc/kernel/trace/ftrace.c                              |   12 
 arch/powerpc/kernel/trace/ftrace_64_pg.c                        |    5 
 arch/powerpc/kernel/vmlinux.lds.S                               |    2 
 arch/x86/include/asm/barrier.h                                  |    3 
 arch/x86/include/asm/kvm_host.h                                 |    1 
 arch/x86/kernel/cpu/bugs.c                                      |   11 
 arch/x86/kernel/cpu/cpuid-deps.c                                |    6 
 arch/x86/kvm/cpuid.c                                            |    1 
 arch/x86/kvm/cpuid.h                                            |   10 
 arch/x86/kvm/lapic.c                                            |    3 
 arch/x86/kvm/mmu/mmu.c                                          |    2 
 arch/x86/kvm/mmu/tdp_mmu.c                                      |   21 
 arch/x86/kvm/vmx/vmx.c                                          |   24 
 arch/x86/kvm/x86.c                                              |    2 
 drivers/accessibility/speakup/main.c                            |    2 
 drivers/android/binder.c                                        |    4 
 drivers/char/random.c                                           |   10 
 drivers/clk/clk.c                                               |  195 
 drivers/clk/mediatek/clk-mtk.c                                  |   15 
 drivers/comedi/drivers/vmk80xx.c                                |   35 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                         |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                          |   72 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                        |    4 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c               |    3 
 drivers/gpu/drm/drm_panel_orientation_quirks.c                  |    6 
 drivers/gpu/drm/i915/display/intel_atomic.c                     |    1 
 drivers/gpu/drm/i915/display/intel_cdclk.c                      |   37 
 drivers/gpu/drm/i915/display/intel_crtc.c                       |   96 
 drivers/gpu/drm/i915/display/intel_crtc.h                       |    6 
 drivers/gpu/drm/i915/display/intel_display.c                    |   43 
 drivers/gpu/drm/i915/display/intel_display_device.h             |    1 
 drivers/gpu/drm/i915/display/intel_display_types.h              |    2 
 drivers/gpu/drm/i915/display/intel_dp.c                         |   13 
 drivers/gpu/drm/i915/display/intel_dp_mst.c                     |    2 
 drivers/gpu/drm/i915/i915_vma.c                                 |   42 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h          |    8 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h         |    8 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h          |    8 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c                  |   95 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h                  |    3 
 drivers/gpu/drm/nouveau/nouveau_bios.c                          |   13 
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c              |    7 
 drivers/gpu/drm/panel/panel-visionox-rm69299.c                  |    2 
 drivers/gpu/drm/radeon/radeon_atombios.c                        |    8 
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c                            |   35 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                              |    7 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h                              |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                             |    1 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                             |    3 
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c                             |   32 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                             |   11 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                             |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_prime.c                           |   15 
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c                      |   44 
 drivers/infiniband/core/cm.c                                    |   11 
 drivers/infiniband/hw/mlx5/mad.c                                |    3 
 drivers/infiniband/sw/rxe/rxe.c                                 |    2 
 drivers/interconnect/core.c                                     |    8 
 drivers/media/common/videobuf2/videobuf2-core.c                 |    9 
 drivers/misc/mei/pci-me.c                                       |    2 
 drivers/net/dsa/mt7530.c                                        |   38 
 drivers/net/dsa/mt7530.h                                        |    5 
 drivers/net/ethernet/intel/ice/ice_tc_lib.c                     |   15 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c            |    7 
 drivers/net/ethernet/mediatek/mtk_wed.c                         |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c               |   27 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c               |    9 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c      |    4 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c               |    4 
 drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c        |   61 
 drivers/net/ethernet/stmicro/stmmac/common.h                    |    1 
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c               |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c            |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c             |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c               |    7 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c             |   18 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c               |   29 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                        |   18 
 drivers/net/tun.c                                               |   18 
 drivers/net/usb/ax88179_178a.c                                  |    4 
 drivers/net/virtio_net.c                                        |   25 
 drivers/pci/bus.c                                               |   49 
 drivers/pci/pci.c                                               |   78 
 drivers/pci/pci.h                                               |    4 
 drivers/pci/pcie/aspm.c                                         |   21 
 drivers/pci/pcie/dpc.c                                          |    5 
 drivers/pci/quirks.c                                            |    8 
 drivers/platform/x86/amd/pmc/pmc-quirks.c                       |    9 
 drivers/s390/cio/device.c                                       |   13 
 drivers/s390/cio/qdio_main.c                                    |   28 
 drivers/s390/net/ism_drv.c                                      |   37 
 drivers/scsi/scsi_lib.c                                         |    7 
 drivers/thunderbolt/domain.c                                    |    5 
 drivers/thunderbolt/icm.c                                       |    2 
 drivers/thunderbolt/lc.c                                        |   45 
 drivers/thunderbolt/nhi.c                                       |   19 
 drivers/thunderbolt/path.c                                      |   13 
 drivers/thunderbolt/switch.c                                    |  178 
 drivers/thunderbolt/tb.c                                        |   38 
 drivers/thunderbolt/tb.h                                        |   10 
 drivers/thunderbolt/tb_regs.h                                   |    6 
 drivers/thunderbolt/usb4.c                                      |   52 
 drivers/tty/serial/mxs-auart.c                                  |    8 
 drivers/tty/serial/pmac_zilog.c                                 |   14 
 drivers/tty/serial/serial_base.h                                |    4 
 drivers/tty/serial/serial_core.c                                |   21 
 drivers/tty/serial/serial_port.c                                |   34 
 drivers/tty/serial/stm32-usart.c                                |   13 
 drivers/ufs/host/ufs-qcom.c                                     |    8 
 drivers/usb/class/cdc-wdm.c                                     |    6 
 drivers/usb/core/hub.c                                          |   15 
 drivers/usb/core/port.c                                         |    4 
 drivers/usb/core/quirks.c                                       |    7 
 drivers/usb/dwc2/hcd_ddma.c                                     |    4 
 drivers/usb/gadget/function/f_ncm.c                             |    4 
 drivers/usb/host/xhci-mem.c                                     |    2 
 drivers/usb/host/xhci-ring.c                                    |   11 
 drivers/usb/host/xhci.c                                         |   23 
 drivers/usb/host/xhci.h                                         |    9 
 drivers/usb/serial/option.c                                     |   40 
 fs/ceph/addr.c                                                  |   22 
 fs/ceph/cache.c                                                 |    2 
 fs/ceph/caps.c                                                  |   53 
 fs/ceph/crypto.c                                                |    2 
 fs/ceph/debugfs.c                                               |    4 
 fs/ceph/dir.c                                                   |   24 
 fs/ceph/export.c                                                |   10 
 fs/ceph/file.c                                                  |   26 
 fs/ceph/inode.c                                                 |   14 
 fs/ceph/ioctl.c                                                 |    8 
 fs/ceph/mds_client.c                                            |   41 
 fs/ceph/mds_client.h                                            |    3 
 fs/ceph/mdsmap.c                                                |    3 
 fs/ceph/snap.c                                                  |   18 
 fs/ceph/super.c                                                 |   22 
 fs/ceph/super.h                                                 |   13 
 fs/ceph/xattr.c                                                 |   12 
 fs/fuse/dir.c                                                   |    1 
 fs/nilfs2/dir.c                                                 |    2 
 fs/smb/client/cifs_debug.c                                      |    6 
 fs/smb/client/cifsglob.h                                        |    3 
 fs/smb/client/cifsproto.h                                       |   20 
 fs/smb/client/connect.c                                         |  131 
 fs/smb/client/dfs.c                                             |   51 
 fs/smb/client/dfs.h                                             |   33 
 fs/smb/client/dfs_cache.c                                       |   53 
 fs/smb/client/misc.c                                            |    7 
 fs/smb/common/smb2pdu.h                                         |    2 
 fs/smb/server/server.c                                          |   13 
 fs/smb/server/smb2pdu.c                                         |    4 
 fs/smb/server/vfs.c                                             |    5 
 fs/sysfs/file.c                                                 |    2 
 include/asm-generic/barrier.h                                   |    8 
 include/linux/bootconfig.h                                      |    7 
 include/linux/ceph/mdsmap.h                                     |    5 
 include/linux/gpio/property.h                                   |    1 
 include/linux/pci.h                                             |    5 
 include/linux/shmem_fs.h                                        |    9 
 include/linux/swapops.h                                         |   65 
 include/linux/udp.h                                             |    2 
 include/linux/usb/hcd.h                                         |    5 
 include/linux/usb/quirks.h                                      |    3 
 include/net/netfilter/nf_flow_table.h                           |   12 
 include/trace/events/rpcgss.h                                   |    4 
 include/uapi/linux/pci_regs.h                                   |    1 
 init/main.c                                                     |    2 
 io_uring/io_uring.c                                             |   26 
 kernel/sched/sched.h                                            |   20 
 lib/bootconfig.c                                                |   19 
 mm/hugetlb.c                                                    |   10 
 mm/memory-failure.c                                             |   18 
 mm/shmem.c                                                      |    6 
 net/bridge/br_input.c                                           |   15 
 net/bridge/br_netfilter_hooks.c                                 |    6 
 net/bridge/br_private.h                                         |    1 
 net/bridge/netfilter/nf_conntrack_bridge.c                      |   14 
 net/netfilter/nf_flow_table_inet.c                              |    3 
 net/netfilter/nf_flow_table_ip.c                                |   10 
 net/netfilter/nf_tables_api.c                                   |   16 
 net/netfilter/nft_set_pipapo.c                                  |   14 
 net/unix/af_unix.c                                              |   12 
 sound/core/seq/seq_ump_convert.c                                |    2 
 sound/pci/hda/patch_realtek.c                                   |    3 
 sound/pci/hda/tas2781_hda_i2c.c                                 |    4 
 sound/soc/ti/omap3pandora.c                                     |   63 
 sound/usb/Makefile                                              |    2 
 sound/usb/mixer_quirks.c                                        |    9 
 sound/usb/mixer_scarlett2.c                                     | 4391 ++++++++++
 sound/usb/mixer_scarlett2.h                                     |    7 
 sound/usb/mixer_scarlett_gen2.c                                 | 4274 ---------
 sound/usb/mixer_scarlett_gen2.h                                 |    7 
 tools/perf/util/bpf_skel/lock_contention.bpf.c                  |    5 
 tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc |    6 
 tools/testing/selftests/kselftest.h                             |   18 
 tools/testing/selftests/net/udpgso.c                            |    2 
 tools/testing/selftests/timers/posix_timers.c                   |  156 
 205 files changed, 6733 insertions(+), 5414 deletions(-)

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

Bjorn Helgaas (1):
      PCI/DPC: Use FIELD_GET()

Breno Leitao (1):
      virtio_net: Do not send RSS key if it is not supported

Brenton Simpson (1):
      drm: panel-orientation-quirks: Add quirk for Lenovo Legion Go

Carlos Llamas (1):
      binder: check offset alignment in binder_get_object()

Carolina Jubran (1):
      net/mlx5e: Prevent deadlock while disabling aRFS

Christian König (1):
      drm/amdgpu: remove invalid resource->start check v2

Chuanhong Guo (1):
      USB: serial: option: add support for Fibocom FM650/FG650

Coia Prant (1):
      USB: serial: option: add Lonsung U8300/U9300 product

Daniele Palmas (1):
      USB: serial: option: add Telit FN920C04 rmnet compositions

Danny Lin (1):
      fuse: fix leaked ENOSYS error on first statx call

Dave Airlie (1):
      nouveau: fix instmem race condition around ptr stores

David Matlack (1):
      KVM: x86/mmu: Write-protect L2 SPTEs in TDP MMU when clearing dirty status

Dillon Varone (1):
      drm/amd/display: Do not recursively call manual trigger programming

Dmitry Baryshkov (2):
      drm/msm/dpu: populate SSPP scaler block version
      drm/panel: visionox-rm69299: don't unregister DSI device

Emil Kronborg (1):
      serial: mxs-auart: add spinlock around changing cts state

Eric Biggers (1):
      x86/cpufeatures: Fix dependencies for GFNI, VAES, and VPCLMULQDQ

Felix Fietkau (1):
      net: ethernet: mtk_eth_soc: fix WED + wifi reset

Felix Kuehling (1):
      drm/amdkfd: Fix memory leak in create_process failure

Finn Thain (1):
      serial/pmac_zilog: Remove flawed mitigation for rx irq flood

Florian Westphal (1):
      netfilter: nft_set_pipapo: do not free live element

Gavin Shan (1):
      arm64: tlb: Fix TLBI RANGE operand

Geoffrey D. Bennett (7):
      ALSA: scarlett2: Move USB IDs out from device_info struct
      ALSA: scarlett2: Add support for Clarett 8Pre USB
      ALSA: scarlett2: Default mixer driver to enabled
      ALSA: scarlett2: Add correct product series name to messages
      ALSA: scarlett2: Add Focusrite Clarett+ 2Pre and 4Pre support
      ALSA: scarlett2: Add Focusrite Clarett 2Pre and 4Pre USB support
      ALSA: scarlett2: Rename scarlett_gen2 to scarlett2

Gerd Bayer (1):
      s390/ism: Properly fix receive message buffer allocation

Gil Fine (2):
      thunderbolt: Avoid notify PM core about runtime PM resume
      thunderbolt: Fix wake configurations after device unplug

Greg Kroah-Hartman (2):
      Revert "usb: cdc-wdm: close race between read and workqueue"
      Linux 6.6.29

Hans Verkuil (1):
      media: videobuf2: request more buffers for vb2_read

Hardik Gajjar (2):
      usb: xhci: Add timeout argument in address_device USB HCD callback
      usb: new quirk to reduce the SET_ADDRESS request timeout

Ilpo Järvinen (1):
      PCI: Simplify pcie_capability_clear_and_set_word() to ..._clear_word()

Janusz Krzysztofik (1):
      drm/i915/vma: Fix UAF on destroy against retire race

Jason A. Donenfeld (1):
      random: handle creditable entropy from atomic process context

Jeongjun Park (1):
      nilfs2: fix OOB in nilfs_set_de_type

Jerry Meng (1):
      USB: serial: option: support Quectel EM060K sub-models

Johan Hovold (1):
      PCI/ASPM: Fix deadlock when enabling ASPM

John Stultz (1):
      selftests: timers: Fix posix_timers ksft_print_msg() warning

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: avoid writing the mac address before first reading

Josh Poimboeuf (1):
      x86/bugs: Fix BHI retpoline check

Kai-Heng Feng (1):
      usb: Disable USB3 LPM at shutdown

Kuniyuki Iwashima (2):
      af_unix: Call manage_oob() for every skb in unix_stream_read_generic().
      af_unix: Don't peek OOB data without MSG_OOB.

Lei Chen (1):
      tun: limit printing rate when illegal packet received by tun dev

Linus Walleij (1):
      ASoC: ti: Convert Pandora ASoC to GPIO descriptors

Manivannan Sadhasivam (1):
      scsi: ufs: qcom: Add missing interconnect bandwidth values for Gear 5

Marcin Szycik (1):
      ice: Fix checking for unsupported keys on non-tunnel device

Mario Limonciello (1):
      platform/x86/amd/pmc: Extend Framework 13 quirk to more BIOSes

Marios Makassikis (1):
      ksmbd: clear RENAME_NOREPLACE before calling vfs_rename

Mark Brown (1):
      selftests: timers: Convert posix_timers test to generate KTAP output

Mark Zhang (1):
      RDMA/cm: Print the old state when cm_destroy_id gets timeout

Mathieu Desnoyers (1):
      sched: Add missing memory barrier in switch_mm_cid

Mauro Carvalho Chehab (1):
      ALSA: hda/realtek: Add quirks for Huawei Matebook D14 NBLB-WAX9N

Miaohe Lin (1):
      mm/memory-failure: fix deadlock when hugetlb_optimize_vmemmap is enabled

Michael Guralnik (1):
      RDMA/mlx5: Fix port number for counter query in multi-port configuration

Michal Swiatkowski (2):
      ice: tc: check src_vsi in case of traffic from VF
      ice: tc: allow zero flags in parsing tc flower

Mika Westerberg (1):
      thunderbolt: Reset only non-USB4 host routers in resume

Mike Tipton (1):
      interconnect: Don't access req_list while it's being manipulated

Mikhail Kobuk (1):
      drm: nv04: Fix out of bounds access

Minas Harutyunyan (1):
      usb: dwc2: host: Fix dereference issue in DDMA completion flow.

Namhyung Kim (1):
      perf lock contention: Add a missing NULL check

Namjae Jeon (3):
      ksmbd: fix slab-out-of-bounds in smb2_allocate_rsp_buf
      ksmbd: validate request buffer size in smb2_allocate_rsp_buf()
      ksmbd: common: use struct_group_attr instead of struct_group for network_open_info

Naveen N Rao (1):
      powerpc/ftrace: Ignore ftrace locations in exit text sections

NeilBrown (1):
      ceph: redirty page before returning AOP_WRITEPAGE_ACTIVATE

Nikita Zhandarovich (1):
      comedi: vmk80xx: fix incomplete endpoint checking

Norihiko Hama (1):
      usb: gadget: f_ncm: Fix UAF ncm object at re-bind after usb ep transport error

Oleg Nesterov (2):
      selftests/timers/posix_timers: Reimplement check_timer_distribution()
      selftests: kselftest: Fix build failure with NOLIBC

Oscar Salvador (1):
      mm,swapops: update check in is_pfn_swap_entry for hwpoison entries

Pablo Neira Ayuso (3):
      netfilter: br_netfilter: skip conntrack input hook for promisc packets
      netfilter: flowtable: validate pppoe header
      netfilter: flowtable: incorrect pppoe tuple

Paulo Alcantara (4):
      smb: client: remove extra @chan_count check in __cifs_put_smb_ses()
      smb: client: fix UAF in smb2_reconnect_server()
      smb: client: guarantee refcounted children from parent session
      smb: client: refresh referral without acquiring refpath_lock

Peter Oberparleiter (2):
      s390/qdio: handle deferred cc1
      s390/cio: fix race condition during online processing

Peter Xu (1):
      mm/userfaultfd: allow hugetlb change protection upon poison entry

Pin-yen Lin (1):
      clk: mediatek: Do a runtime PM get on controllers during probe

Qiang Zhang (1):
      bootconfig: use memblock_free_late to free xbc memory to buddy

Ryan Roberts (1):
      arm64/mm: Modify range-based tlbi to decrement scale

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

Shay Drory (2):
      net/mlx5: Lag, restore buckets number to default after hash LAG deactivation
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

Steve French (1):
      smb3: show beginning time for per share stats

Steven Rostedt (Google) (1):
      SUNRPC: Fix rpcgss_context trace event acceptor field

Sumanth Korikkar (1):
      mm/shmem: inline shmem_is_huge() for disabled transparent hugepages

Takashi Iwai (1):
      ALSA: seq: ump: Fix conversion from MIDI2 to MIDI1 UMP messages

Tony Lindgren (1):
      serial: core: Fix missing shutdown and startup for serial base port

Uwe Kleine-König (2):
      serial: stm32: Return IRQ_NONE in the ISR if no handling happend
      serial: stm32: Reset .throttled state in .startup()

Vanillan Wang (1):
      USB: serial: option: add Rolling RW101-GL and RW135-GL support

Ville Syrjälä (9):
      drm/i915: Fix FEC pipe A vs. DDI A mixup
      drm/i915/mst: Reject FEC+MST on ICL
      drm/i915/cdclk: Fix voltage_level programming edge case
      drm/i915: Change intel_pipe_update_{start,end}() calling convention
      drm/i915: Extract intel_crtc_vblank_evade_scanlines()
      drm/i915: Enable VRR later during fastsets
      drm/i915: Adjust seamless_m_n flag behaviour
      drm/i915: Disable live M/N updates when using bigjoiner
      drm/i915/mst: Limit MST+DSC to TGL+

Vishal Badole (1):
      clk: Show active consumers of clocks in debugfs

Xiubo Li (2):
      ceph: pass the mdsc to several helpers
      ceph: rename _to_client() to _to_fs_client()

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


