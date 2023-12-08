Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8391B809DC3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573399AbjLHH6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573432AbjLHH6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:58:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CFB1FE7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:57:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4D6C433CA;
        Fri,  8 Dec 2023 07:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702022239;
        bh=5FcSZS1HizH5wfRUCRtnJ9YEfNZg3hUQUE1S5eI9rok=;
        h=From:To:Cc:Subject:Date:From;
        b=EcrWD3hi8Je8aILp6qR5RvnW9hApiMfdl/PS7BdWKMLFP/CzGKcltwmt44w7733kt
         qfBFawDGC/7dfHuqphCA6b/d8E6Ze7IWU5e+HVit9DidpI4Iym0uq1JRikzdmJsP8t
         SExlS8j6+V5HTYok29/a1IwtJMnaW9GVklmlZd90=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.5
Date:   Fri,  8 Dec 2023 08:57:04 +0100
Message-ID: <2023120805-abstract-fancy-0ce5@gregkh>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.6.5 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-class-led                                            |    9 
 Makefile                                                                             |    2 
 arch/parisc/include/asm/alternative.h                                                |    9 
 arch/parisc/include/asm/assembly.h                                                   |    1 
 arch/parisc/include/asm/bug.h                                                        |   30 +
 arch/parisc/include/asm/jump_label.h                                                 |    8 
 arch/parisc/include/asm/ldcw.h                                                       |    2 
 arch/parisc/include/asm/uaccess.h                                                    |    1 
 arch/parisc/include/uapi/asm/errno.h                                                 |    2 
 arch/parisc/kernel/vmlinux.lds.S                                                     |    1 
 arch/powerpc/kernel/fpu.S                                                            |   13 
 arch/powerpc/kernel/process.c                                                        |    6 
 arch/powerpc/kernel/vector.S                                                         |    2 
 arch/powerpc/platforms/pseries/iommu.c                                               |    8 
 arch/s390/mm/page-states.c                                                           |    6 
 arch/x86/xen/enlighten.c                                                             |    6 
 arch/x86/xen/xen-ops.h                                                               |    2 
 drivers/acpi/acpi_video.c                                                            |   14 
 drivers/acpi/scan.c                                                                  |    7 
 drivers/ata/libata-scsi.c                                                            |    9 
 drivers/cpufreq/amd-pstate.c                                                         |   71 +++-
 drivers/cpufreq/imx6q-cpufreq.c                                                      |    2 
 drivers/dma-buf/dma-resv.c                                                           |    2 
 drivers/firewire/core-device.c                                                       |   11 
 drivers/firewire/sbp2.c                                                              |    6 
 drivers/firmware/efi/unaccepted_memory.c                                             |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c                                          |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                                              |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c                                       |    6 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                                               |   10 
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c                                                |    4 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                                                |    4 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c                                              |    4 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                                    |    8 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                             |   21 +
 drivers/gpu/drm/amd/display/dc/dc.h                                                  |    5 
 drivers/gpu/drm/amd/display/dc/dc_stream.h                                           |    1 
 drivers/gpu/drm/amd/display/dc/dc_types.h                                            |    4 
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c                          |    2 
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c                                 |    3 
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c                              |    2 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c                                   |    6 
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c                                 |   15 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c                                 |    3 
 drivers/gpu/drm/amd/display/dc/inc/link.h                                            |    1 
 drivers/gpu/drm/amd/display/dc/link/link_detection.c                                 |    8 
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c                                      |   11 
 drivers/gpu/drm/amd/display/dc/link/link_factory.c                                   |    1 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c                   |   14 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c                          |    3 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c |    6 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c               |   62 ++-
 drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h               |    4 
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c                                      |    1 
 drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h                           |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c                                   |    5 
 drivers/gpu/drm/i915/display/intel_dp.c                                              |   28 +
 drivers/gpu/drm/i915/gt/intel_engine_user.c                                          |   39 +-
 drivers/gpu/drm/nouveau/nouveau_bo.c                                                 |    5 
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c                                       |    1 
 drivers/gpu/drm/panel/panel-novatek-nt36523.c                                        |    4 
 drivers/iommu/intel/dmar.c                                                           |   18 +
 drivers/iommu/intel/iommu.c                                                          |    9 
 drivers/iommu/intel/svm.c                                                            |   26 +
 drivers/iommu/iommu.c                                                                |   20 -
 drivers/iommu/of_iommu.c                                                             |   14 
 drivers/leds/led-class.c                                                             |   14 
 drivers/md/bcache/btree.c                                                            |    2 
 drivers/md/dm-verity-fec.c                                                           |    3 
 drivers/md/dm-verity-target.c                                                        |    7 
 drivers/md/dm-verity.h                                                               |    6 
 drivers/mmc/core/block.c                                                             |    2 
 drivers/mmc/core/core.c                                                              |    9 
 drivers/mmc/host/cqhci-core.c                                                        |   44 +-
 drivers/mmc/host/sdhci-pci-gli.c                                                     |   54 +--
 drivers/mmc/host/sdhci-sprd.c                                                        |   25 +
 drivers/net/dsa/mv88e6xxx/chip.c                                                     |   26 +
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c                                     |   16 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h                                     |    2 
 drivers/net/ethernet/intel/ice/ice_lag.c                                             |  122 ++++---
 drivers/net/ethernet/intel/ice/ice_lag.h                                             |    1 
 drivers/net/ethernet/intel/ice/ice_vf_lib.c                                          |   20 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c                                        |   25 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                                  |    4 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c                                   |    3 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h                             |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c                                 |    9 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c                                 |  120 +++++--
 drivers/net/ethernet/realtek/r8169_main.c                                            |    9 
 drivers/net/ethernet/renesas/ravb_main.c                                             |   69 ++--
 drivers/net/ethernet/renesas/rswitch.c                                               |   22 -
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c                                       |    4 
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                                          |    2 
 drivers/net/netdevsim/bpf.c                                                          |    4 
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c                                     |    4 
 drivers/nvme/host/core.c                                                             |    9 
 drivers/pinctrl/core.c                                                               |    6 
 drivers/pinctrl/stm32/pinctrl-stm32.c                                                |   13 
 drivers/powercap/dtpm_cpu.c                                                          |    6 
 drivers/powercap/dtpm_devfreq.c                                                      |   11 
 drivers/scsi/sd.c                                                                    |    9 
 drivers/ufs/core/ufshcd.c                                                            |   13 
 drivers/vfio/pci/pds/pci_drv.c                                                       |    4 
 drivers/vfio/pci/pds/vfio_dev.c                                                      |   30 +
 drivers/vfio/pci/pds/vfio_dev.h                                                      |    2 
 fs/btrfs/disk-io.c                                                                   |    1 
 fs/btrfs/extent_io.c                                                                 |   11 
 fs/btrfs/ioctl.c                                                                     |    1 
 fs/btrfs/ref-verify.c                                                                |    2 
 fs/btrfs/send.c                                                                      |    2 
 fs/btrfs/super.c                                                                     |    5 
 fs/btrfs/volumes.c                                                                   |    9 
 fs/ext2/file.c                                                                       |    1 
 fs/smb/client/inode.c                                                                |    4 
 fs/smb/client/smb2ops.c                                                              |   13 
 fs/smb/server/smb2pdu.c                                                              |   47 +-
 fs/smb/server/smbacl.c                                                               |    7 
 fs/smb/server/smbacl.h                                                               |    2 
 fs/smb/server/vfs.c                                                                  |   68 ++--
 fs/smb/server/vfs.h                                                                  |   10 
 include/linux/amd-pstate.h                                                           |    4 
 include/linux/dma-fence.h                                                            |   15 
 include/linux/io_uring_types.h                                                       |    3 
 include/linux/iommu.h                                                                |    1 
 include/linux/skmsg.h                                                                |    1 
 include/linux/vfio.h                                                                 |    8 
 include/net/af_unix.h                                                                |    1 
 include/net/neighbour.h                                                              |    2 
 include/scsi/scsi_device.h                                                           |   12 
 include/uapi/linux/stddef.h                                                          |    2 
 include/uapi/linux/v4l2-subdev.h                                                     |    2 
 io_uring/io_uring.c                                                                  |   59 +--
 io_uring/io_uring.h                                                                  |    3 
 io_uring/kbuf.c                                                                      |  169 ++++++++--
 io_uring/kbuf.h                                                                      |    5 
 kernel/bpf/memalloc.c                                                                |    2 
 lib/errname.c                                                                        |    6 
 net/core/skmsg.c                                                                     |    2 
 net/ethtool/netlink.c                                                                |    1 
 net/ipv4/igmp.c                                                                      |    6 
 net/mac80211/driver-ops.h                                                            |    9 
 net/unix/af_unix.c                                                                   |    2 
 net/unix/unix_bpf.c                                                                  |    5 
 net/wireless/core.h                                                                  |    1 
 net/wireless/nl80211.c                                                               |   50 +-
 sound/pci/hda/hda_intel.c                                                            |    2 
 sound/pci/hda/patch_realtek.c                                                        |   12 
 tools/arch/parisc/include/uapi/asm/errno.h                                           |    2 
 tools/testing/selftests/net/af_unix/diag_uid.c                                       |    1 
 tools/testing/selftests/net/cmsg_sender.c                                            |    2 
 tools/testing/selftests/net/ipsec.c                                                  |    4 
 tools/testing/selftests/net/mptcp/mptcp_connect.c                                    |   11 
 tools/testing/selftests/net/mptcp/mptcp_inq.c                                        |   11 
 153 files changed, 1332 insertions(+), 623 deletions(-)

Abdul Halim, Mohd Syazwan (1):
      iommu/vt-d: Add MTL to quirk list to skip TE disabling

Adrian Hunter (6):
      mmc: cqhci: Increase recovery halt timeout
      mmc: cqhci: Warn of halt or task clear failure
      mmc: cqhci: Fix task clearing in CQE error recovery
      mmc: block: Retry commands in CQE error recovery
      mmc: block: Do not lose cache flush during CQE error recovery
      mmc: block: Be sure to wait while busy in CQE error recovery

Agustin Gutierrez (1):
      drm/amd/display: Remove power sequencing check

Alex Sierra (1):
      drm/amdgpu: Force order between a read and write to the same address

Alvin Lee (2):
      drm/amd/display: Include udelay when waiting for INBOX0 ACK
      drm/amd/display: Use DRAM speed from validation for dummy p-state

Antonio Borneo (1):
      pinctrl: stm32: fix array read out of bound

Ayush Jain (1):
      cpufreq/amd-pstate: Only print supported EPP values for performance governor

Bragatheswaran Manickavel (1):
      btrfs: ref-verify: fix memory leaks in btrfs_ref_tree_mod()

Brett Creeley (2):
      vfio/pds: Fix mutex lock->magic != lock warning
      vfio/pds: Fix possible sleep while in atomic context

Camille Cho (1):
      drm/amd/display: Simplify brightness initialization

Candice Li (1):
      drm/amdgpu: Update EEPROM I2C address for smu v13_0_0

Chen Ni (1):
      pinctrl: stm32: Add check for devm_kcalloc

Christian König (1):
      dma-buf: fix check in dma_resv_add_fence

Christoph Niedermaier (1):
      cpufreq: imx6q: Don't disable 792 Mhz OPP unnecessarily

Claudiu Beznea (6):
      net: ravb: Check return value of reset_control_deassert()
      net: ravb: Use pm_runtime_resume_and_get()
      net: ravb: Make write access to CXR35 first before accessing other EMAC registers
      net: ravb: Start TX queues after HW initialization succeeded
      net: ravb: Stop DMA in case of failures on ravb_open()
      net: ravb: Keep reverse order of operations in ravb_remove()

Damien Le Moal (2):
      scsi: Change SCSI device boolean fields to single bit flags
      scsi: sd: Fix system start for ATA devices

Dan Carpenter (2):
      media: v4l2-subdev: Fix a 64bit bug
      wifi: iwlwifi: mvm: fix an error code in iwl_mvm_mld_add_sta()

Daniel Mentz (1):
      iommu: Fix printk arg in of_iommu_get_resv_regions()

Dave Airlie (1):
      nouveau: find the smallest page allocation to cover a buffer alloc.

Dave Ertman (1):
      ice: Fix VF Reset paths when interface in a failed over aggregate

David Howells (2):
      cifs: Fix FALLOC_FL_ZERO_RANGE by setting i_size if EOF moved
      cifs: Fix FALLOC_FL_INSERT_RANGE by setting i_size after EOF moved

David Sterba (1):
      btrfs: fix 64bit compat send ioctl arguments not initializing version member

Dinghao Liu (1):
      drm/amd/pm: fix a memleak in aldebaran_tables_init

Dmitry Antipov (1):
      uapi: propagate __struct_group() attributes to the container union

Elena Salomatkina (1):
      octeontx2-af: Fix possible buffer overflow

Ewan D. Milne (1):
      nvme: check for valid nvme_identify_ns() before using it

Filipe Manana (2):
      btrfs: fix off-by-one when checking chunk map includes logical address
      btrfs: make error messages more clear when getting a chunk map

Furong Xu (1):
      net: stmmac: xgmac: Disable FPE MMC interrupts

Gaurav Batra (1):
      powerpc/pseries/iommu: enable_ddw incorrectly returns direct mapping for SR-IOV device

Gautham R. Shenoy (1):
      cpufreq/amd-pstate: Fix the return value of amd_pstate_fast_switch()

Geetha sowjanya (1):
      octeontx2-pf: Fix adding mbox work queue entry when num_vfs > 64

Greg Kroah-Hartman (1):
      Linux 6.6.5

Greg Ungerer (2):
      net: dsa: mv88e6xxx: fix marvell 6350 switch probing
      net: dsa: mv88e6xxx: fix marvell 6350 probe crash

Gustavo A. R. Silva (1):
      neighbour: Fix __randomize_layout crash in struct neighbour

Hamza Mahfooz (1):
      drm/amd/display: fix ABM disablement

Hans de Goede (1):
      ACPI: video: Use acpi_video_device for cooling-dev driver data

Heiko Carstens (1):
      s390/cmma: fix handling of swapper_pg_dir and invalid_pg_dir

Heiner Kallweit (2):
      r8169: fix deadlock on RTL8125 in jumbo mtu mode
      r8169: prevent potential deadlock in rtl8169_close

Helge Deller (8):
      parisc: Mark ex_table entries 32-bit aligned in assembly.h
      parisc: Mark ex_table entries 32-bit aligned in uaccess.h
      parisc: Use natural CPU alignment for bug_table
      parisc: Mark lock_aligned variables 16-byte aligned on SMP
      parisc: Drop the HP-UX ENOSYM and EREMOTERELEASE error codes
      parisc: Mark jump_table naturally aligned
      parisc: Ensure 32-bit alignment on parisc unwind section
      parisc: Mark altinstructions read-only and 32-bit aligned

Hou Tao (1):
      bpf: Add missed allocation hint for bpf_mem_cache_alloc_flags()

Ian Chen (1):
      drm/amd/display: Refactor edp power control

Ilya Bakoulin (1):
      drm/amd/display: Fix MPCC 1DLUT programming

Ioana Ciornei (2):
      dpaa2-eth: increase the needed headroom to account for alignment
      dpaa2-eth: recycle the RX buffer only after all processing done

Jakub Kicinski (1):
      ethtool: don't propagate EOPNOTSUPP from dumps

Jann Horn (1):
      btrfs: send: ensure send_fd is writable

Jens Axboe (6):
      io_uring: don't allow discontig pages for IORING_SETUP_NO_MMAP
      io_uring: free io_buffer_list entries via RCU
      io_uring: don't guard IORING_OFF_PBUF_RING with SETUP_NO_MMAP
      io_uring: enable io_mem_alloc/free to be used in other parts
      io_uring/kbuf: defer release of mapped buffer rings
      io_uring/kbuf: recycle freed mapped buffer ring entries

Jiawen Wu (1):
      net: libwx: fix memory leak on msix entry

Johannes Berg (1):
      wifi: cfg80211: fix CQM for non-range use

John Fastabend (1):
      bpf, sockmap: af_unix stream sockets need to hold ref for pair sock

Juergen Gross (1):
      x86/xen: fix percpu vcpu_info allocation

Kailang Yang (2):
      ALSA: hda/realtek: Headset Mic VREF to 100%
      ALSA: hda/realtek: Add supported ALC257 for ChromeOS

Kornel Dulęba (1):
      mmc: sdhci-pci-gli: Disable LPM during initialization

Lu Baolu (4):
      iommu/vt-d: Fix incorrect cache invalidation for mm notification
      iommu/vt-d: Omit devTLB invalidation requests when TES=0
      iommu/vt-d: Disable PCI ATS in legacy passthrough mode
      iommu/vt-d: Make context clearing consistent with context mapping

Lukasz Luba (1):
      powercap: DTPM: Fix unneeded conversions to micro-Watts

Maria Yu (1):
      pinctrl: avoid reload of p state in list iteration

Mario Limonciello (1):
      drm/amd: Enable PCIe PME from D3

Markus Weippert (1):
      bcache: revert replacing IS_ERR_OR_NULL with IS_ERR

Michael Roth (1):
      efi/unaccepted: Fix off-by-one when checking for overlapping ranges

Mikulas Patocka (1):
      dm-verity: align struct dm_verity_fec_io properly

Namjae Jeon (1):
      ksmbd: fix possible deadlock in smb2_open

Nicholas Kazlauskas (2):
      drm/amd/display: Remove min_dst_y_next_start check for Z8
      drm/amd/display: Update min Z8 residency time to 2100 for DCN314

Nicholas Piggin (1):
      KVM: PPC: Book3S HV: Fix KVM_RUN clobbering FP/VEC user registers

Oldřich Jedlička (1):
      wifi: mac80211: do not pass AP_VLAN vif pointer to drivers during flush

Paulo Alcantara (2):
      smb: client: fix missing mode bits for SMB symlinks
      smb: client: report correct st_size for SMB and NFS symlinks

Peter Wang (1):
      scsi: ufs: core: Clear cmd if abort succeeds in MCQ mode

Prike Liang (1):
      drm/amdgpu: correct the amdgpu runtime dereference usage count

Qu Wenruo (2):
      btrfs: add dmesg output for first mount and last unmount of a filesystem
      btrfs: free the allocated memory if btrfs_alloc_page_array() fails

Ritesh Harjani (IBM) (1):
      ext2: Fix ki_pos update for DIO buffered-io fallback case

Robin Murphy (1):
      iommu: Avoid more races around device probe

Sean Christopherson (1):
      vfio: Drop vfio_file_iommu_group() stub to fudge around a KVM wart

Sherry Wang (1):
      drm/amd/display: refactor ILR to make it work

Stanislav Fomichev (1):
      netdevsim: Don't accept device bound programs

Subbaraya Sundeep (1):
      octeontx2-pf: Restore TC ingress police rules when interface is up

Swapnil Patel (1):
      drm/amd/display: Reduce default backlight min from 5 nits to 1 nits

Takashi Iwai (2):
      leds: class: Don't expose color sysfs entry
      ALSA: hda: Disable power-save on KONTRON SinglePC

Tim Huang (1):
      drm/amdgpu: fix memory overflow in the IB test

Timothy Pearson (1):
      powerpc: Don't clobber f0/vs0 during fp|altivec register save

Tvrtko Ursulin (1):
      drm/i915/gsc: Mark internal GSC engine with reserved uabi class

Ville Syrjälä (1):
      drm/i915: Also check for VGA converter in eDP probe

Wenchao Chen (1):
      mmc: sdhci-sprd: Fix vqmmc not shutting down after the card was pulled

Willem de Bruijn (4):
      selftests/net: ipsec: fix constant out of range
      selftests/net: fix a char signedness issue
      selftests/net: unix: fix unused variable compiler warning
      selftests/net: mptcp: fix uninitialized variable warnings

Wu Bo (2):
      dm verity: initialize fec io before freeing it
      dm verity: don't perform FEC for failed readahead IO

Wyes Karny (1):
      cpufreq/amd-pstate: Fix scaling_min_freq and scaling_max_freq update

Yang Yingliang (2):
      firewire: core: fix possible memory leak in create_units()
      drm/panel: nt36523: fix return value check in nt36523_probe()

Yoshihiro Shimoda (4):
      net: rswitch: Fix type of ret in rswitch_start_xmit()
      net: rswitch: Fix return value in rswitch_start_xmit()
      net: rswitch: Fix missing dev_kfree_skb_any() in error path
      ravb: Fix races between ravb_tx_timeout_work() and net related ops

Zhengchao Shao (1):
      ipv4: igmp: fix refcnt uaf issue when receiving igmp query packet

Zhongwei (1):
      drm/amd/display: force toggle rate wa for first link training for a retimer

xiazhengqiao (1):
      drm/panel: starry-2081101qfh032011-53g: Fine tune the panel power sequence

