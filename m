Return-Path: <linux-kernel+bounces-7261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E191281A3FA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A041C24F84
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE494B5B4;
	Wed, 20 Dec 2023 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EfVEnHdW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F1E4B5A0;
	Wed, 20 Dec 2023 16:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133EEC433C9;
	Wed, 20 Dec 2023 16:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088526;
	bh=mrjq5XKK0/MWC3H5NJAwYAjtBqzoTxWPtvvgqTlQ91Q=;
	h=From:To:Cc:Subject:Date:From;
	b=EfVEnHdWDXg6zx9tUXyyhwRtiek/DJCEf6l0qo+b9kPv1oEfHZOOVu1EwhPxqoI7g
	 7Wa7eVbCJU7nc8a2cNpULzi99TTpP2JCErsdVrewx5tTjTFMsmjjKKZOccWyX9EUYo
	 +7kH0qVk6XkFTcMa6uNyzzPIkM5ylKnZ7d8CnaDk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.8
Date: Wed, 20 Dec 2023 17:08:36 +0100
Message-ID: <2023122037-deafness-deodorant-1a66@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.8 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                               |    2 
 arch/arm64/Makefile                                                    |    2 
 arch/arm64/include/asm/pgtable.h                                       |    6 
 arch/loongarch/Makefile                                                |    2 
 arch/loongarch/include/asm/asmmacro.h                                  |    3 
 arch/loongarch/include/asm/setup.h                                     |    2 
 arch/loongarch/kernel/relocate.c                                       |   10 
 arch/loongarch/kernel/time.c                                           |   23 
 arch/loongarch/mm/pgtable.c                                            |    4 
 arch/powerpc/configs/skiroot_defconfig                                 |    1 
 arch/riscv/Kconfig                                                     |    4 
 arch/riscv/kernel/crash_core.c                                         |    4 
 arch/s390/configs/debug_defconfig                                      |    1 
 arch/x86/hyperv/hv_init.c                                              |   25 -
 arch/x86/include/asm/alternative.h                                     |    4 
 arch/x86/include/asm/nospec-branch.h                                   |    4 
 block/blk-cgroup.c                                                     |   13 
 block/blk-throttle.c                                                   |    2 
 drivers/accel/ivpu/ivpu_drv.h                                          |    5 
 drivers/accel/ivpu/ivpu_hw_37xx.c                                      |   17 
 drivers/accel/ivpu/ivpu_hw_40xx.c                                      |    4 
 drivers/atm/solos-pci.c                                                |    8 
 drivers/block/nbd.c                                                    |  117 +++-
 drivers/cxl/core/hdm.c                                                 |    3 
 drivers/cxl/core/port.c                                                |    4 
 drivers/dma/fsl-edma-common.c                                          |    1 
 drivers/dma/stm32-dma.c                                                |    8 
 drivers/firmware/efi/libstub/x86-stub.c                                |   31 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c                              |    3 
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c                                 |   28 +
 drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c |    4 
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c              |    2 
 drivers/gpu/drm/drm_edid.c                                             |    3 
 drivers/gpu/drm/i915/display/intel_fb.c                                |   19 
 drivers/gpu/drm/i915/display/skl_scaler.c                              |    2 
 drivers/gpu/drm/i915/gt/intel_reset.c                                  |    2 
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c                      |    5 
 drivers/gpu/drm/i915/i915_gpu_error.h                                  |   12 
 drivers/gpu/drm/i915/selftests/igt_live_test.c                         |    9 
 drivers/gpu/drm/i915/selftests/igt_live_test.h                         |    3 
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c                                |   14 
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                                 |    5 
 drivers/hid/hid-apple.c                                                |    2 
 drivers/hid/hid-asus.c                                                 |   27 -
 drivers/hid/hid-glorious.c                                             |   16 
 drivers/hid/hid-ids.h                                                  |   12 
 drivers/hid/hid-lenovo.c                                               |    3 
 drivers/hid/hid-mcp2221.c                                              |    4 
 drivers/hid/hid-multitouch.c                                           |    5 
 drivers/hid/hid-quirks.c                                               |    2 
 drivers/hid/i2c-hid/i2c-hid-acpi.c                                     |    5 
 drivers/infiniband/hw/mlx5/main.c                                      |   17 
 drivers/md/bcache/bcache.h                                             |    1 
 drivers/md/bcache/btree.c                                              |    7 
 drivers/md/bcache/super.c                                              |    4 
 drivers/md/bcache/writeback.c                                          |    2 
 drivers/net/ethernet/amazon/ena/ena_eth_com.c                          |    3 
 drivers/net/ethernet/amazon/ena/ena_netdev.c                           |   53 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c                       |    5 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                              |   38 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                              |   10 
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c                      |   11 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c                      |   19 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c                          |    5 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c             |    7 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c                    |   11 
 drivers/net/ethernet/freescale/fec_main.c                              |   27 -
 drivers/net/ethernet/intel/iavf/iavf.h                                 |    1 
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c                         |   27 -
 drivers/net/ethernet/intel/iavf/iavf_fdir.h                            |   15 
 drivers/net/ethernet/intel/iavf/iavf_main.c                            |  179 ++++---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c                        |   71 ++
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c                    |    3 
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c                        |   11 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c                |    5 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c                    |   55 +-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c                   |   25 -
 drivers/net/ethernet/mellanox/mlx5/core/en.h                           |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c               |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c               |   56 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c            |  218 ++++++--
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c       |   10 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                      |   27 -
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c                       |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c                        |   25 -
 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c                 |  154 ------
 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h                 |   15 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c                      |   35 -
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h                      |    2 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c             |   54 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c                     |   29 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c                         |    6 
 drivers/net/ethernet/qlogic/qed/qed_cxt.c                              |    1 
 drivers/net/ethernet/qualcomm/qca_debug.c                              |   17 
 drivers/net/ethernet/qualcomm/qca_spi.c                                |   20 
 drivers/net/ethernet/stmicro/stmmac/Kconfig                            |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c                   |   14 
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c                |   10 
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c                      |    6 
 drivers/net/team/team.c                                                |    4 
 drivers/net/usb/aqc111.c                                               |    8 
 drivers/net/usb/qmi_wwan.c                                             |    1 
 drivers/net/usb/r8152.c                                                |    1 
 drivers/nfc/virtual_ncidev.c                                           |    7 
 drivers/nvme/host/auth.c                                               |    2 
 drivers/nvme/host/core.c                                               |   19 
 drivers/pci/controller/pci-loongson.c                                  |   46 +
 drivers/pci/controller/vmd.c                                           |    2 
 drivers/pci/hotplug/acpiphp_glue.c                                     |    9 
 drivers/pci/pcie/aspm.c                                                |   53 +-
 drivers/platform/x86/intel/telemetry/core.c                            |    4 
 drivers/soundwire/stream.c                                             |    7 
 fs/afs/rxrpc.c                                                         |    2 
 fs/btrfs/delalloc-space.c                                              |    2 
 fs/btrfs/extent_io.c                                                   |    3 
 fs/btrfs/file.c                                                        |    2 
 fs/btrfs/inode.c                                                       |   16 
 fs/btrfs/ioctl.c                                                       |    9 
 fs/btrfs/ordered-data.c                                                |   11 
 fs/btrfs/qgroup.c                                                      |   25 -
 fs/btrfs/qgroup.h                                                      |    4 
 fs/ext4/file.c                                                         |   14 
 fs/ext4/mballoc.c                                                      |    4 
 fs/fuse/dax.c                                                          |    1 
 fs/fuse/file.c                                                         |    8 
 fs/fuse/fuse_i.h                                                       |   19 
 fs/fuse/inode.c                                                        |   81 +++
 fs/nfsd/auth.c                                                         |    4 
 fs/nfsd/nfssvc.c                                                       |    1 
 fs/nfsd/vfs.c                                                          |    9 
 fs/open.c                                                              |    3 
 fs/smb/client/cached_dir.c                                             |   17 
 fs/smb/client/cifsglob.h                                               |   14 
 fs/smb/client/cifspdu.h                                                |    4 
 fs/smb/client/cifsproto.h                                              |   11 
 fs/smb/client/cifssmb.c                                                |  193 +++----
 fs/smb/client/inode.c                                                  |   74 ++
 fs/smb/client/readdir.c                                                |    6 
 fs/smb/client/smb1ops.c                                                |   73 --
 fs/smb/client/smb2inode.c                                              |    2 
 fs/smb/client/smb2misc.c                                               |   26 -
 fs/smb/client/smb2ops.c                                                |  178 +++----
 fs/smb/client/smb2pdu.c                                                |   93 ++-
 fs/smb/client/smb2proto.h                                              |   12 
 fs/smb/common/smb2pdu.h                                                |    2 
 fs/smb/server/smb2pdu.c                                                |    1 
 fs/tracefs/inode.c                                                     |   13 
 include/asm-generic/qspinlock.h                                        |    2 
 include/linux/cred.h                                                   |   58 --
 include/linux/mlx5/device.h                                            |    2 
 include/linux/mlx5/driver.h                                            |    2 
 include/linux/mlx5/mlx5_ifc.h                                          |    9 
 include/linux/mm_inline.h                                              |   23 
 include/linux/mmzone.h                                                 |   34 -
 include/linux/objtool.h                                                |   10 
 include/linux/pci.h                                                    |    3 
 include/linux/usb/r8152.h                                              |    1 
 include/net/addrconf.h                                                 |   12 
 include/net/if_inet6.h                                                 |    4 
 include/net/netfilter/nf_flow_table.h                                  |   10 
 include/uapi/linux/fuse.h                                              |   10 
 io_uring/uring_cmd.c                                                   |    2 
 kernel/Kconfig.kexec                                                   |    1 
 kernel/cred.c                                                          |  250 +---------
 kernel/events/core.c                                                   |   10 
 kernel/exit.c                                                          |    3 
 kernel/trace/ring_buffer.c                                             |   58 --
 kernel/trace/trace.c                                                   |    4 
 lib/Kconfig.debug                                                      |   15 
 mm/shmem.c                                                             |   19 
 mm/vmscan.c                                                            |   92 ++-
 mm/workingset.c                                                        |    6 
 net/appletalk/ddp.c                                                    |    9 
 net/atm/ioctl.c                                                        |    7 
 net/ipv4/tcp_output.c                                                  |    6 
 net/ipv6/addrconf.c                                                    |    6 
 net/rose/af_rose.c                                                     |    4 
 net/rxrpc/conn_client.c                                                |    7 
 net/sched/act_ct.c                                                     |   34 +
 net/sunrpc/auth.c                                                      |    3 
 net/vmw_vsock/virtio_transport_common.c                                |    2 
 scripts/checkstack.pl                                                  |    3 
 scripts/sign-file.c                                                    |   12 
 security/selinux/hooks.c                                               |    6 
 sound/pci/hda/patch_hdmi.c                                             |    3 
 sound/pci/hda/patch_realtek.c                                          |    1 
 sound/pci/hda/tas2781_hda_i2c.c                                        |   21 
 tools/objtool/noreturns.h                                              |    1 
 tools/testing/selftests/Makefile                                       |   21 
 tools/testing/selftests/bpf/config.x86_64                              |    1 
 tools/testing/selftests/bpf/progs/bpf_loop_bench.c                     |   13 
 tools/testing/selftests/hid/config.common                              |    1 
 tools/testing/selftests/lib.mk                                         |   40 -
 tools/testing/selftests/mm/cow.c                                       |    3 
 194 files changed, 2160 insertions(+), 1603 deletions(-)

Al Viro (1):
      io_uring/cmd: fix breakage in SOCKET_URING_OP_SIOC* implementation

Alex Deucher (1):
      drm/amdgpu/sdma5.2: add begin/end_use ring callbacks

Amelie Delaunay (1):
      dmaengine: stm32-dma: avoid bitfield overflow assertion

Amir Goldstein (1):
      fuse: disable FOPEN_PARALLEL_DIRECT_WRITES with FUSE_DIRECT_IO_ALLOW_MMAP

Andrew Halaney (1):
      net: stmmac: Handle disabled MDIO busses from devicetree

Andrzej Kacprowski (1):
      accel/ivpu/37xx: Fix interrupt_clear_with_0 WA initialization

Andy Shevchenko (1):
      platform/x86: intel_telemetry: Fix kernel doc descriptions

Aoba K (1):
      HID: multitouch: Add quirk for HONOR GLO-GXXX touchpad

Ard Biesheuvel (1):
      efi/x86: Avoid physical KASLR on older Dell systems

Baokun Li (1):
      ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS

Bibo Mao (1):
      LoongArch: Implement constant timer shutdown interface

Bjorn Helgaas (1):
      Revert "PCI: acpiphp: Reassign resources on bridge if necessary"

Boris Burkov (3):
      btrfs: free qgroup reserve when ORDERED_IOERR is set
      btrfs: fix qgroup_free_reserved_data int overflow
      btrfs: don't clear qgroup reserved bit in release_folio

Brett Raye (1):
      HID: glorious: fix Glorious Model I HID report

Chengfeng Ye (2):
      atm: solos-pci: Fix potential deadlock on &cli_queue_lock
      atm: solos-pci: Fix potential deadlock on &tx_queue_lock

Chris Mi (2):
      net/mlx5e: Disable IPsec offload support if not FW steering
      net/mlx5e: TC, Don't offload post action rule if not supported

Christian König (1):
      drm/amdgpu: fix tear down order in amdgpu_vm_pt_free

Colin Ian King (1):
      bcache: remove redundant assignment to variable cur_idx

Coly Li (3):
      bcache: avoid oversize memory allocation by small stripe_size
      bcache: add code comments for bch_btree_node_get() and __bch_btree_node_alloc()
      bcache: avoid NULL checking to c->root in run_cache_set()

Dan Carpenter (1):
      net/mlx5: Fix a NULL vs IS_ERR() check

Dan Williams (1):
      cxl/hdm: Fix dpa translation locking

David Arinzon (4):
      net: ena: Destroy correct number of xdp queues upon failure
      net: ena: Fix xdp drops handling due to multibuf packets
      net: ena: Fix DMA syncing in XDP path when SWIOTLB is on
      net: ena: Fix XDP redirection error

David Hildenbrand (1):
      selftests/mm: cow: print ksft header before printing anything else

David Howells (2):
      afs: Fix refcount underflow from error handling race
      rxrpc: Fix some minor issues with bundle tracing

David Stevens (1):
      mm/shmem: fix race in shmem_undo_range w/THP

Denis Benato (2):
      HID: hid-asus: reset the backlight brightness level on resume
      HID: hid-asus: add const to read-only outgoing usb buffer

Dinghao Liu (1):
      qed: Fix a potential use-after-free in qed_cxt_tables_alloc

Dong Chenchen (1):
      net: Remove acked SYN flag from packet in the transmit queue correctly

Eduard Zingerman (1):
      selftests/bpf: fix bpf_loop_bench for new callback verification scheme

Fangrui Song (1):
      x86/speculation, objtool: Use absolute relocations for annotations

Florent Revest (1):
      team: Fix use-after-free when an option instance allocation fails

Frank Li (1):
      dmaengine: fsl-edma: fix DMA channel leak in eDMAv4

Gavin Li (1):
      net/mlx5e: Check netdev pointer before checking its net ns

Gergo Koteles (4):
      ALSA: hda/tas2781: leave hda_component in usable state
      ALSA: hda/tas2781: handle missing EFI calibration data
      ALSA: hda/tas2781: call cleanup functions only once
      ALSA: hda/tas2781: reset the amp before component_add

Greg Kroah-Hartman (1):
      Linux 6.6.8

Hamish Martin (2):
      HID: mcp2221: Set driver data before I2C adapter add
      HID: mcp2221: Allow IO to start during probe

Hangyu Hua (1):
      fuse: dax: set fc->dax to NULL in fuse_dax_conn_free()

Hannes Reinecke (1):
      nvme: catch errors from nvme_configure_metadata()

Hariprasad Kelam (3):
      octeontx2-pf: Fix promisc mcam entry action
      octeontx2-af: Update RSS algorithm index
      octeontx2-af: Fix pause frame configuration

Hartmut Knaack (1):
      ALSA: hda/realtek: Apply mute LED quirk for HP15-db

Heiko Carstens (1):
      scripts/checkstack.pl: match all stack sizes for s390

Huacai Chen (2):
      LoongArch: Silence the boot warning about 'nokaslr'
      LoongArch: Mark {dmw,tlb}_virt_to_page() exports as non-GPL

Hyunwoo Kim (3):
      atm: Fix Use-After-Free in do_vcc_ioctl
      net/rose: Fix Use-After-Free in rose_ioctl
      appletalk: Fix Use-After-Free in atalk_ioctl

Ignat Korchagin (1):
      kexec: drop dependency on ARCH_SUPPORTS_KEXEC from CRASH_DUMP

Igor Russkikh (1):
      net: atlantic: fix double free in ring reinit logic

Ioana Ciornei (2):
      dpaa2-switch: fix size of the dma_unmap
      dpaa2-switch: do not ask for MDB, VLAN and FDB replay

James Houghton (1):
      arm64: mm: Always make sw-dirty PTEs hw-dirty in pte_modify

Jan Kara (1):
      ext4: fix warning in ext4_dio_write_end_io()

Jani Nikula (1):
      drm/edid: also call add modes in EDID connector update fallback

Jason-JH.Lin (1):
      drm/mediatek: Add spinlock for setting vblank event in atomic_begin

Jean Delvare (1):
      stmmac: dwmac-loongson: Add architecture dependency

Jens Axboe (2):
      cred: switch to using atomic_long_t
      cred: get rid of CONFIG_DEBUG_CREDENTIALS

Jianbo Liu (2):
      net/mlx5e: Reduce eswitch mode_lock protection context
      net/mlx5e: Check the number of elements before walk TC rhashtable

Jiaxun Yang (1):
      PCI: loongson: Limit MRRS to 256

Johan Hovold (2):
      PCI/ASPM: Add pci_enable_link_state_locked()
      PCI: vmd: Fix potential deadlock when enabling ASPM

John Hubbard (1):
      Revert "selftests: error out if kernel header files are not yet built"

Josef Bacik (1):
      btrfs: do not allow non subvolume root targets for snapshot

Kai Vehmanen (2):
      ALSA: hda/hdmi: add force-connect quirk for NUC5CPYB
      ALSA: hda/hdmi: add force-connect quirks for ASUSTeK Z170 variants

Kalesh AP (1):
      bnxt_en: Fix wrong return value check in bnxt_close_nic()

Kelly Kane (1):
      r8152: add vendor/device ID pair for ASUS USB-C2500

Krister Johansen (1):
      fuse: share lookup state between submount and its parent

Krzysztof Kozlowski (1):
      soundwire: stream: fix NULL pointer dereference for multi_link

Lech Perczak (1):
      net: usb: qmi_wwan: claim interface 4 for ZTE MF290

Leon Romanovsky (3):
      net/mlx5e: Honor user choice of IPsec replay window size
      net/mlx5e: Ensure that IPsec sequence packet number starts from 1
      net/mlx5e: Tidy up IPsec NAT-T SA discovery

Li Nan (4):
      nbd: fold nbd config initialization into nbd_alloc_config()
      nbd: factor out a helper to get nbd_config without holding 'config_lock'
      nbd: fix null-ptr-dereference while accessing 'nbd->config'
      nbd: pass nbd_sock to nbd_read_reply() instead of index

Linus Torvalds (1):
      asm-generic: qspinlock: fix queued_spin_value_unlocked() implementation

Maciej Żenczykowski (1):
      net: ipv6: support reporting otherwise unknown prefix flags in RTM_NEWPREFIX

Mario Limonciello (3):
      HID: i2c-hid: Add IDEA5002 to i2c_hid_acpi_blacklist[]
      drm/amd/display: Restore guard against default backlight value < 1 nit
      drm/amd/display: Disable PSR-SU on Parade 0803 TCON again

Mark O'Donovan (1):
      nvme-auth: set explanation code for failure2 msgs

Mark Rutland (1):
      perf: Fix perf_event_validate_size() lockdep splat

Masahiro Yamada (2):
      LoongArch: Add dependency between vmlinuz.efi and vmlinux.efi
      arm64: add dependency between vmlinuz.efi and Image

Michael Chan (1):
      bnxt_en: Fix HWTSTAMP_FILTER_ALL packet timestamp logic

Michael Walle (1):
      drm/mediatek: fix kernel oops if no crtc is found

Mikhail Khvainitski (1):
      HID: lenovo: Restrict detection of patched firmware only to USB cptkbd

Ming Lei (2):
      blk-throttle: fix lockdep warning of "cgroup_mutex or RCU read lock required!"
      blk-cgroup: bypass blkcg_deactivate_policy after destroying

Moshe Shemesh (2):
      net/mlx5e: Fix possible deadlock on mlx5e_tx_timeout_work
      net/mlx5: Nack sync reset request when HotPlug is enabled

Namjae Jeon (1):
      ksmbd: fix wrong name of SMB2_CREATE_ALLOCATION_SIZE

Nguyen Dinh Phi (1):
      nfc: virtual_ncidev: Add variable to check if ndev is running

Nikolay Kuratov (1):
      vsock/virtio: Fix unsigned integer wrap around in virtio_transport_has_space()

Oliver Neukum (2):
      usb: aqc111: check packet for fixup for true limit
      HID: add ALWAYS_POLL quirk for Apple kb

Patrisious Haddad (3):
      net/mlx5e: Unify esw and normal IPsec status table creation/destruction
      RDMA/mlx5: Send events from IB driver about device affiliation state
      RDMA/mlx5: Change the key being sent for MPV device affiliation

Paulo Alcantara (7):
      smb: client: implement ->query_reparse_point() for SMB1
      smb: client: introduce ->parse_reparse_point()
      smb: client: set correct file type from NFS reparse points
      smb: client: fix OOB in receive_encrypted_standard()
      smb: client: fix potential OOBs in smb2_parse_contexts()
      smb: client: fix NULL deref in asn1_ber_decoder()
      smb: client: fix OOB in smb2_query_reparse_point()

Piotr Gardocki (2):
      iavf: Introduce new state machines for flow director
      iavf: Handle ntuple on/off based on new state machines for flow director

Radu Bulie (1):
      net: fec: correct queue selection

Saurabh Sengar (1):
      x86/hyperv: Fix the detection of E820_TYPE_PRAM in a Gen2 VM

Sebastian Parschauer (1):
      HID: Add quirk for Labtec/ODDOR/aikeec handbrake

Shinas Rasheed (1):
      octeon_ep: explicitly test for firmware ready value

Slawomir Laba (1):
      iavf: Fix iavf_shutdown to call iavf_remove instead iavf_close

Sneh Shah (1):
      net: stmmac: dwmac-qcom-ethqos: Fix drops in 10M SGMII RX

Somnath Kotur (1):
      bnxt_en: Clear resource reservation during resume

Sreekanth Reddy (1):
      bnxt_en: Fix skb recycling logic in bnxt_deliver_skb()

Stanislaw Gruszka (1):
      accel/ivpu: Print information about used workarounds

Stefan Wahren (3):
      qca_debug: Prevent crash on TX ring changes
      qca_debug: Fix ethtool -G iface tx behavior
      qca_spi: Fix reset behavior

Steven Rostedt (Google) (9):
      eventfs: Do not allow NULL parent to eventfs_start_creating()
      ring-buffer: Fix memory leak of free page
      tracing: Update snapshot buffer on resize if it is allocated
      ring-buffer: Do not update before stamp when switching sub-buffers
      ring-buffer: Have saved event hold the entire event
      ring-buffer: Fix writing to the buffer with max_data_size
      ring-buffer: Fix a race in rb_time_cmpxchg() for 32 bit archs
      ring-buffer: Do not try to put back write_stamp
      ring-buffer: Have rb_time_cmpxchg() set the msb counter too

Stuart Lee (1):
      drm/mediatek: Fix access violation in mtk_drm_crtc_dma_dev_get

Tvrtko Ursulin (2):
      drm/i915/selftests: Fix engine reset count storage for multi-tile
      drm/i915: Use internal class when counting engine resets

Tyler Fanelli (1):
      fuse: Rename DIRECT_IO_RELAX to DIRECT_IO_ALLOW_MMAP

Ville Syrjälä (3):
      drm/i915: Fix ADL+ tiled plane stride when the POT stride is smaller than the original
      drm/i915: Fix intel_atomic_setup_scalers() plane_state handling
      drm/i915: Fix remapped stride with CCS on ADL+

Vlad Buslov (1):
      net/sched: act_ct: Take per-cb reference to tcf_ct_flow_table

WANG Rui (1):
      LoongArch: Record pc instead of offset in la_abs relocation

Yanteng Si (1):
      stmmac: dwmac-loongson: Make sure MDIO is initialized before use

Yihong Cao (1):
      HID: apple: add Jamesdonkey and A3R to non-apple keyboards list

Yu Zhao (4):
      mm/mglru: fix underprotected page cache
      mm/mglru: try to stop at high watermarks
      mm/mglru: respect min_ttl_ms with memcgs
      mm/mglru: reclaim offlined memcgs harder

Yusong Gao (1):
      sign-file: Fix incorrect return values check

Zhipeng Lu (1):
      octeontx2-af: fix a use-after-free in rvu_nix_register_reporters

Zizhi Wo (1):
      ksmbd: fix memory leak in smb2_lock()


